/* statusnotifier.vapi generated by vapigen, do not modify. */

[CCode (cprefix = "StatusNotifier", gir_namespace = "StatusNotifier", gir_version = "1.0", lower_case_cprefix = "status_notifier_")]
namespace StatusNotifier {
	[CCode (cheader_filename = "statusnotifier.h", type_id = "status_notifier_item_get_type ()")]
	public class Item : GLib.Object {
		[CCode (has_construct_function = false)]
		protected Item ();
		public void freeze_tooltip ();
		[CCode (has_construct_function = false)]
		public Item.from_icon_name (string id, StatusNotifier.Category category, string icon_name);
		[CCode (has_construct_function = false)]
		public Item.from_pixbuf (string id, StatusNotifier.Category category, Gdk.Pixbuf pixbuf);
		public string get_attention_movie_name ();
		public StatusNotifier.Category get_category ();
		[Version (since = "1.0.0")]
		public unowned GLib.Object get_context_menu ();
		public string get_icon_name (StatusNotifier.Icon icon);
		public unowned string get_id ();
		[Version (since = "1.0.0")]
		public bool get_item_is_menu ();
		public Gdk.Pixbuf get_pixbuf (StatusNotifier.Icon icon);
		public StatusNotifier.State get_state ();
		public StatusNotifier.Status get_status ();
		public string get_title ();
		public string get_tooltip_body ();
		public string get_tooltip_title ();
		public uint32 get_window_id ();
		public bool has_pixbuf (StatusNotifier.Icon icon);
		public void register ();
		public void set_attention_movie_name (string movie_name);
		[Version (since = "1.0.0")]
		public bool set_context_menu (GLib.Object? menu);
		public void set_from_icon_name (StatusNotifier.Icon icon, string icon_name);
		public void set_from_pixbuf (StatusNotifier.Icon icon, Gdk.Pixbuf pixbuf);
		[Version (since = "1.0.0")]
		public void set_item_is_menu (bool is_menu);
		public void set_status (StatusNotifier.Status status);
		public void set_title (string title);
		public void set_tooltip (string icon_name, string title, string body);
		public void set_tooltip_body (string body);
		public void set_tooltip_title (string title);
		public void set_window_id (uint32 window_id);
		public void thaw_tooltip ();
		[NoAccessorMethod]
		public string attention_icon_name { owned get; set; }
		[NoAccessorMethod]
		public Gdk.Pixbuf attention_icon_pixbuf { owned get; set; }
		public string attention_movie_name { owned get; set; }
		public StatusNotifier.Category category { get; construct; }
		public string id { get; construct; }
		[Version (since = "1.0.0")]
		public bool item_is_menu { get; set; }
		[NoAccessorMethod]
		public string main_icon_name { owned get; set; }
		[NoAccessorMethod]
		public Gdk.Pixbuf main_icon_pixbuf { owned get; set; }
		[NoAccessorMethod]
		[Version (since = "1.0.0")]
		public GLib.Object menu { owned get; set; }
		[NoAccessorMethod]
		public string overlay_icon_name { owned get; set; }
		[NoAccessorMethod]
		public Gdk.Pixbuf overlay_icon_pixbuf { owned get; set; }
		public StatusNotifier.State state { get; }
		public StatusNotifier.Status status { get; set; }
		public string title { owned get; set; }
		public string tooltip_body { owned get; set; }
		[NoAccessorMethod]
		public string tooltip_icon_name { owned get; set; }
		[NoAccessorMethod]
		public Gdk.Pixbuf tooltip_icon_pixbuf { owned get; set; }
		public string tooltip_title { owned get; set; }
		public uint window_id { get; set; }
		public virtual signal bool activate (int x, int y);
		public virtual signal bool context_menu (int x, int y);
		public virtual signal void registration_failed (GLib.Error error);
		public virtual signal bool scroll (int delta, StatusNotifier.ScrollOrientation orientation);
		public virtual signal bool secondary_activate (int x, int y);
	}
	[CCode (cheader_filename = "statusnotifier.h", cprefix = "STATUS_NOTIFIER_CATEGORY_", type_id = "status_notifier_category_get_type ()")]
	public enum Category {
		APPLICATION_STATUS,
		COMMUNICATIONS,
		SYSTEM_SERVICES,
		HARDWARE
	}
	[CCode (cheader_filename = "statusnotifier.h", cprefix = "STATUS_NOTIFIER_ERROR_NO_", type_id = "status_notifier_error_get_type ()")]
	public enum Error {
		CONNECTION,
		NAME,
		WATCHER,
		HOST
	}
	[CCode (cheader_filename = "statusnotifier.h", cprefix = "STATUS_NOTIFIER_", type_id = "status_notifier_icon_get_type ()")]
	public enum Icon {
		ICON,
		ATTENTION_ICON,
		OVERLAY_ICON,
		TOOLTIP_ICON
	}
	[CCode (cheader_filename = "statusnotifier.h", cprefix = "STATUS_NOTIFIER_SCROLL_ORIENTATION_", type_id = "status_notifier_scroll_orientation_get_type ()")]
	public enum ScrollOrientation {
		HORIZONTAL,
		VERTICAL
	}
	[CCode (cheader_filename = "statusnotifier.h", cprefix = "STATUS_NOTIFIER_STATE_", type_id = "status_notifier_state_get_type ()")]
	public enum State {
		NOT_REGISTERED,
		REGISTERING,
		REGISTERED,
		FAILED
	}
	[CCode (cheader_filename = "statusnotifier.h", cprefix = "STATUS_NOTIFIER_STATUS_", type_id = "status_notifier_status_get_type ()")]
	public enum Status {
		PASSIVE,
		ACTIVE,
		NEEDS_ATTENTION
	}
}
