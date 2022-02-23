namespace Dino.Plugins.PhoneRinger {

public class Plugin : RootInterface, Object {

    public Dino.Application app;

    private string incoming_path;
    private bool ringing = false;
    private Gst.Element ringer;
    private string outgoing_path;
    private bool dialing = false;
    private Gst.Element dialer;


    private bool ringer_bus_callback (Gst.Bus bus, Gst.Message message) {
        if (message.type == Gst.MessageType.EOS && ringing) {
            ringer.seek_simple(Gst.Format.TIME, Gst.SeekFlags.FLUSH, 0);
        }
        return true;
    }

    private bool dialer_bus_callback (Gst.Bus bus, Gst.Message message) {
        if (message.type == Gst.MessageType.EOS && dialing) {
            dialer.seek_simple(Gst.Format.TIME, Gst.SeekFlags.FLUSH, 0);
        }
        return true;
    }

    public void registered(Dino.Application app) {
        this.app = app;

        try {
            incoming_path = app.search_path_generator.get_soundfile_path("phone-incoming-call.oga");
            outgoing_path = app.search_path_generator.get_soundfile_path("phone-outgoing-calling.oga");
        } catch (IOError e) {
            warning(e.message);
            return; // disable plugin
        }

        ringer = Gst.ElementFactory.make("playbin", "ringer");
        ringer["uri"] = "file://" + incoming_path;
        var bus1 = ringer.get_bus();
        bus1.add_watch(0, ringer_bus_callback);
        dialer = Gst.ElementFactory.make("playbin", "dialer");
        dialer["uri"] = "file://" + outgoing_path;
        var bus2 = dialer.get_bus();
        bus2.add_watch(0, dialer_bus_callback);


        app.stream_interactor.get_module(NotificationEvents.IDENTITY).notify_call_signal.connect((call, conversation, video, multiparty, conversation_display_name) => {
            ringing = true;
            ringer.set_state(Gst.State.PLAYING);
        });

        app.stream_interactor.get_module(NotificationEvents.IDENTITY).retract_call_signal.connect((call, conversation) => {
            ringing = false;
            ringer.set_state(Gst.State.NULL);
        });

        app.stream_interactor.get_module(Calls.IDENTITY).call_outgoing.connect((call, state, conversation) => {
            dialing = true;
            dialer.set_state(Gst.State.PLAYING);
        });

        app.stream_interactor.get_module(Calls.IDENTITY).call_started_or_declined.connect(() => {
            dialing = false;
            dialer.set_state(Gst.State.NULL);
        });
        
    }

    public void shutdown() {
        ringing = false;
        ringer.set_state(Gst.State.NULL);
        dialing = false;
        dialer.set_state(Gst.State.NULL);
    }
}

}
