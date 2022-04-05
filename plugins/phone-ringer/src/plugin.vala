namespace Dino.Plugins.PhoneRinger {

public class Plugin : RootInterface, Object {

    public Dino.Application app;

    private Canberra.Context sound_context;
    private const int ringer_id = 0;
    private const int dialer_id = 1;
    private Canberra.Proplist ringer_props;
    private Canberra.Proplist dialer_props;

    private void loop_ringer() {
        sound_context.play_full(ringer_id, ringer_props, (c, id, code) => {
            if (code != Canberra.Error.CANCELED) {
                Idle.add(() => {
                    loop_ringer();
                    return Source.REMOVE;
                });
            }
        });
    }

    private void loop_dialer() {
        sound_context.play_full(dialer_id, dialer_props, (c, id, code) => {
            if (code != Canberra.Error.CANCELED) {
                Idle.add(() => {
                    loop_dialer();
                    return Source.REMOVE;
                });
            }
        });
    }

    public void registered(Dino.Application app) {
        this.app = app;

        Canberra.Context.create(out sound_context);
        Canberra.Proplist.create(out ringer_props);
        Canberra.Proplist.create(out dialer_props);
        ringer_props.sets(Canberra.PROP_EVENT_ID, "phone-incoming-call");
        ringer_props.sets(Canberra.PROP_EVENT_DESCRIPTION, "Incoming call");
        dialer_props.sets(Canberra.PROP_EVENT_ID, "phone-outgoing-calling");
        dialer_props.sets(Canberra.PROP_EVENT_DESCRIPTION, "Outgoing call");

        app.stream_interactor.get_module(Calls.IDENTITY).call_incoming.connect((call, state, conversation, video, multiparty) => {

            loop_ringer();

            call.notify["state"].connect(() => {
                if (call.state != Dino.Entities.Call.State.RINGING) {
                    sound_context.cancel(ringer_id);
                }
            });

        });

        app.stream_interactor.get_module(Calls.IDENTITY).call_outgoing.connect((call, state, conversation) => {
            loop_dialer();
        });

        app.stream_interactor.get_module(Calls.IDENTITY).call_started_or_declined.connect(() => {
            sound_context.cancel(dialer_id);
        });
        
    }

    public void shutdown() { }
}

}
