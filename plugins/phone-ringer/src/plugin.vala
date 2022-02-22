namespace Dino.Plugins.PhoneRinger {

public class Plugin : RootInterface, Object {

    public Dino.Application app;

    private string incoming_path;
    private bool ringing = false;
    private Gst.Element player = null;

    private bool bus_callback (Gst.Bus bus, Gst.Message message) {
        if (message.type == Gst.MessageType.EOS && ringing) {
            player.seek_simple(Gst.Format.TIME, Gst.SeekFlags.FLUSH, 0);
        }
        return true;
    }

    public void registered(Dino.Application app) {
        this.app = app;

        try {
            incoming_path = app.search_path_generator.get_soundfile_path("phone-incoming-call.oga");
        } catch (IOError e) {
            warning(e.message);
            return; // disable plugin
        }

        player = Gst.ElementFactory.make("playbin", "player");
        player["uri"] = "file://" + incoming_path;
        var bus = player.get_bus();
        bus.add_watch(0, bus_callback);

        app.stream_interactor.get_module(NotificationEvents.IDENTITY).notify_call_signal.connect((call, conversation, video, multiparty, conversation_display_name) => {
            ringing = true;
            player.set_state(Gst.State.PLAYING);
        });

        app.stream_interactor.get_module(NotificationEvents.IDENTITY).retract_call_signal.connect((call, conversation) => {
            ringing = false;
            player.set_state(Gst.State.NULL);
        });

    }

    public void shutdown() {
        ringing = false;
        player.set_state(Gst.State.NULL);
    }
}

}
