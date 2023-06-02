Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71EF720935
	for <lists+linux-iio@lfdr.de>; Fri,  2 Jun 2023 20:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235829AbjFBSe5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 2 Jun 2023 14:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237065AbjFBSew (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 2 Jun 2023 14:34:52 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03672196;
        Fri,  2 Jun 2023 11:34:47 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id bc94c963ae8cb155; Fri, 2 Jun 2023 20:34:46 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 5819C956FA8;
        Fri,  2 Jun 2023 20:34:45 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     rafael@kernel.org, lenb@kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, dave.jiang@intel.com,
        ira.weiny@intel.com, rui.zhang@intel.com, jdelvare@suse.com,
        linux@roeck-us.net, jic23@kernel.org, lars@metafoo.de,
        bleung@chromium.org, yu.c.chen@intel.com, hdegoede@redhat.com,
        markgross@kernel.org, luzmaximilian@gmail.com,
        corentin.chary@gmail.com, jprvita@gmail.com,
        cascardo@holoscopio.com, don@syst.com.br, pali@kernel.org,
        jwoithe@just42.net, matan@svgalib.org, kenneth.t.chan@gmail.com,
        malattia@linux.it, jeremy@system76.com, productdev@system76.com,
        herton@canonical.com, coproscefalo@gmail.com, tytso@mit.edu,
        Jason@zx2c4.com, robert.moore@intel.com,
        Michal Wilczynski <michal.wilczynski@intel.com>
Cc:     linux-acpi@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
        chrome-platform@lists.linux.dev,
        platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        acpica-devel@lists.linuxfoundation.org
Subject: Re: [PATCH v4 01/35] acpi: Adjust functions installing bus event handlers
Date:   Fri, 02 Jun 2023 20:34:45 +0200
Message-ID: <4500594.LvFx2qVVIh@kreacher>
In-Reply-To: <20230601131719.300720-1-michal.wilczynski@intel.com>
References: <20230601131719.300720-1-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrfeelfedguddvgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeegvddprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhgvnhgssehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnrdhjrdifihhllhhirghmshesihhnthgvlhdrtghomhdprhgtphhtthhopehvihhshhgrlhdrlhdrvhgvrhhmrgesihhnthgvlhdrtghomhdprhgtphhtthhopegurghvvgdrjhhirghnghesihhnthgvlhdr
 tghomhdprhgtphhtthhopehirhgrrdifvghinhihsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=42 Fuz1=42 Fuz2=42
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thursday, June 1, 2023 3:17:19 PM CEST Michal Wilczynski wrote:
> Currently acpi_device_install_notify_handler() and
> acpi_device_remove_notify_handler() always install acpi_notify_device()
> as a function handler, and only then the real .notify callback gets
> called. This is not efficient and doesn't provide any real advantage.
> 
> Introduce new acpi_device_install_event_handler() and
> acpi_device_remove_event_handler(). Those functions are replacing old
> installers, and after all drivers switch to the new model, old installers
> will be removed at the end of the patchset.
> 
> Make new installer/removal function arguments to take function pointer as
> an argument instead of using .notify callback. Introduce new variable in
> struct acpi_device, as fixed events still needs to be handled by an
> intermediary that would schedule them for later execution. This is due to
> fixed hardware event handlers being executed in interrupt context.
> 
> Make acpi_device_install_event_handler() and
> acpi_device_remove_event_handler() non-static, and export symbols. This
> will allow the drivers to call them directly, instead of relying on
> .notify callback.
> 
> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
> ---
>  drivers/acpi/bus.c      | 59 ++++++++++++++++++++++++++++++++++++++++-
>  include/acpi/acpi_bus.h |  7 +++++
>  2 files changed, 65 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index d161ff707de4..cf2c2bfe29a0 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -535,7 +535,7 @@ static void acpi_notify_device_fixed(void *data)
>  	struct acpi_device *device = data;
>  
>  	/* Fixed hardware devices have no handles */
> -	acpi_notify_device(NULL, ACPI_FIXED_HARDWARE_EVENT, device);
> +	device->fixed_event_notify(NULL, ACPI_FIXED_HARDWARE_EVENT, device);
>  }
>  
>  static u32 acpi_device_fixed_event(void *data)
> @@ -550,11 +550,13 @@ static int acpi_device_install_notify_handler(struct acpi_device *device,
>  	acpi_status status;
>  
>  	if (device->device_type == ACPI_BUS_TYPE_POWER_BUTTON) {
> +		device->fixed_event_notify = acpi_notify_device;
>  		status =
>  		    acpi_install_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
>  						     acpi_device_fixed_event,
>  						     device);
>  	} else if (device->device_type == ACPI_BUS_TYPE_SLEEP_BUTTON) {
> +		device->fixed_event_notify = acpi_notify_device;
>  		status =
>  		    acpi_install_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
>  						     acpi_device_fixed_event,
> @@ -579,9 +581,11 @@ static void acpi_device_remove_notify_handler(struct acpi_device *device,
>  	if (device->device_type == ACPI_BUS_TYPE_POWER_BUTTON) {
>  		acpi_remove_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
>  						acpi_device_fixed_event);
> +		device->fixed_event_notify = NULL;
>  	} else if (device->device_type == ACPI_BUS_TYPE_SLEEP_BUTTON) {
>  		acpi_remove_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
>  						acpi_device_fixed_event);
> +		device->fixed_event_notify = NULL;
>  	} else {
>  		u32 type = acpi_drv->flags & ACPI_DRIVER_ALL_NOTIFY_EVENTS ?
>  				ACPI_ALL_NOTIFY : ACPI_DEVICE_NOTIFY;
> @@ -592,6 +596,59 @@ static void acpi_device_remove_notify_handler(struct acpi_device *device,
>  	acpi_os_wait_events_complete();
>  }
>  
> +int acpi_device_install_event_handler(struct acpi_device *device,
> +				      u32 type,
> +				      void (*notify)(acpi_handle, u32, void*))
> +{
> +	acpi_status status;
> +
> +	if (!notify)
> +		return -EINVAL;
> +
> +	if (device->device_type == ACPI_BUS_TYPE_POWER_BUTTON) {
> +		device->fixed_event_notify = notify;
> +		status =
> +		    acpi_install_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
> +						     acpi_device_fixed_event,
> +						     device);
> +	} else if (device->device_type == ACPI_BUS_TYPE_SLEEP_BUTTON) {
> +		device->fixed_event_notify = notify;
> +		status =
> +		    acpi_install_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
> +						     acpi_device_fixed_event,
> +						     device);
> +	} else {
> +		status = acpi_install_notify_handler(device->handle, type,
> +						     notify,
> +						     device);
> +	}
> +
> +	if (ACPI_FAILURE(status))
> +		return -EINVAL;
> +	return 0;
> +}
> +EXPORT_SYMBOL(acpi_device_install_event_handler);
> +
> +void acpi_device_remove_event_handler(struct acpi_device *device,
> +				      u32 type,
> +				      void (*notify)(acpi_handle, u32, void*))
> +{
> +	if (device->device_type == ACPI_BUS_TYPE_POWER_BUTTON) {
> +		acpi_remove_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
> +						acpi_device_fixed_event);
> +		device->fixed_event_notify = NULL;
> +	} else if (device->device_type == ACPI_BUS_TYPE_SLEEP_BUTTON) {
> +		acpi_remove_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
> +						acpi_device_fixed_event);
> +		device->fixed_event_notify = NULL;
> +	} else {
> +		acpi_remove_notify_handler(device->handle, type,
> +					   notify);
> +	}
> +	acpi_os_wait_events_complete();
> +}
> +EXPORT_SYMBOL(acpi_device_remove_event_handler);
> +
>  /* Handle events targeting \_SB device (at present only graceful shutdown) */
>  
>  #define ACPI_SB_NOTIFY_SHUTDOWN_REQUEST 0x81
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index a6affc0550b0..7fb411438b6f 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -387,6 +387,7 @@ struct acpi_device {
>  	struct list_head physical_node_list;
>  	struct mutex physical_node_lock;
>  	void (*remove)(struct acpi_device *);
> +	void (*fixed_event_notify)(acpi_handle handle, u32 type, void *data);

This is a rather confusing change, because ->remove() above is not a driver
callback, whereas the new one would be.

Moreover, it is rather wasteful, because the only devices needing it are
buttons, so for all of the other ACPI device objects the new callback pointer
would always be NULL.

Finally, it is not necessary even.

The key observation here is that there are only 2 drivers handling power and
sleep buttons that use ACPI fixed events: the ACPI button driver (button.c in
drivers/acpi) and the "tiny power button" driver (tiny-power-button.c in
drivers/acpi).  All of the other drivers don't need the "fixed event notify"
thing and these two can be modified to take care of all of it by themselves.

So if something like the below is done prior to the rest of your series, the
rest will be about acpi_install/remove_notify_handler() only and you won't
even need the wrapper routines any more: driver may just be switched over
to using the ACPICA functions directly.

[This patch is untested and is really 3 patches in one, but since I've cut it
already, I'll send it properly next week after some button driver testing.]

---
 drivers/acpi/bus.c               |   53 +++++-----------------------------
 drivers/acpi/button.c            |   60 +++++++++++++++++++++++++++++++++------
 drivers/acpi/tiny-power-button.c |   49 ++++++++++++++++++++++++++-----
 3 files changed, 101 insertions(+), 61 deletions(-)

Index: linux-pm/drivers/acpi/tiny-power-button.c
===================================================================
--- linux-pm.orig/drivers/acpi/tiny-power-button.c
+++ linux-pm/drivers/acpi/tiny-power-button.c
@@ -19,18 +19,52 @@ static const struct acpi_device_id tiny_
 };
 MODULE_DEVICE_TABLE(acpi, tiny_power_button_device_ids);
 
-static int acpi_noop_add(struct acpi_device *device)
+static void acpi_tiny_power_button_notify(acpi_handle handle, u32 event, void *data)
 {
-	return 0;
+	kill_cad_pid(power_signal, 1);
 }
 
-static void acpi_noop_remove(struct acpi_device *device)
+static void acpi_tiny_power_button_notify_run(void *not_used)
 {
+	acpi_tiny_power_button_notify(NULL, ACPI_FIXED_HARDWARE_EVENT, NULL);
 }
 
-static void acpi_tiny_power_button_notify(struct acpi_device *device, u32 event)
+static u32 acpi_tiny_power_button_event(void *not_used)
 {
-	kill_cad_pid(power_signal, 1);
+	acpi_os_execute(OSL_NOTIFY_HANDLER, acpi_tiny_power_button_notify_run, NULL);
+	return ACPI_INTERRUPT_HANDLED;
+}
+
+static int acpi_tiny_power_button_add(struct acpi_device *device)
+{
+	acpi_status status;
+
+	if (device->device_type == ACPI_BUS_TYPE_POWER_BUTTON) {
+		status = acpi_install_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
+							  acpi_tiny_power_button_event,
+							  NULL);
+	} else {
+		status = acpi_install_notify_handler(device->handle,
+						     ACPI_DEVICE_NOTIFY,
+						     acpi_tiny_power_button_notify,
+						     NULL);
+	}
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	return 0;
+}
+
+static void acpi_tiny_power_button_remove(struct acpi_device *device)
+{
+	if (device->device_type == ACPI_BUS_TYPE_POWER_BUTTON) {
+		acpi_remove_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
+						acpi_tiny_power_button_event);
+	} else {
+		acpi_remove_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
+					   acpi_tiny_power_button_notify);
+	}
+	acpi_os_wait_events_complete();
 }
 
 static struct acpi_driver acpi_tiny_power_button_driver = {
@@ -38,9 +72,8 @@ static struct acpi_driver acpi_tiny_powe
 	.class = "tiny-power-button",
 	.ids = tiny_power_button_device_ids,
 	.ops = {
-		.add = acpi_noop_add,
-		.remove = acpi_noop_remove,
-		.notify = acpi_tiny_power_button_notify,
+		.add = acpi_tiny_power_button_add,
+		.remove = acpi_tiny_power_button_remove,
 	},
 };
 
Index: linux-pm/drivers/acpi/button.c
===================================================================
--- linux-pm.orig/drivers/acpi/button.c
+++ linux-pm/drivers/acpi/button.c
@@ -135,7 +135,6 @@ static const struct dmi_system_id dmi_li
 
 static int acpi_button_add(struct acpi_device *device);
 static void acpi_button_remove(struct acpi_device *device);
-static void acpi_button_notify(struct acpi_device *device, u32 event);
 
 #ifdef CONFIG_PM_SLEEP
 static int acpi_button_suspend(struct device *dev);
@@ -153,7 +152,6 @@ static struct acpi_driver acpi_button_dr
 	.ops = {
 		.add = acpi_button_add,
 		.remove = acpi_button_remove,
-		.notify = acpi_button_notify,
 	},
 	.drv.pm = &acpi_button_pm,
 };
@@ -409,15 +407,13 @@ static void acpi_lid_initialize_state(st
 	button->lid_state_initialized = true;
 }
 
-static void acpi_button_notify(struct acpi_device *device, u32 event)
+static void acpi_button_notify(acpi_handle handle, u32 event, void *data)
 {
+	struct acpi_device *device = data;
 	struct acpi_button *button = acpi_driver_data(device);
 	struct input_dev *input;
 
 	switch (event) {
-	case ACPI_FIXED_HARDWARE_EVENT:
-		event = ACPI_BUTTON_NOTIFY_STATUS;
-		fallthrough;
 	case ACPI_BUTTON_NOTIFY_STATUS:
 		input = button->input;
 		if (button->type == ACPI_BUTTON_TYPE_LID) {
@@ -450,6 +446,17 @@ static void acpi_button_notify(struct ac
 	}
 }
 
+static void acpi_button_notify_run(void *data)
+{
+	acpi_button_notify(NULL, ACPI_BUTTON_NOTIFY_STATUS, data);
+}
+
+static u32 acpi_button_event(void *data)
+{
+	acpi_os_execute(OSL_NOTIFY_HANDLER, acpi_button_notify_run, data);
+	return ACPI_INTERRUPT_HANDLED;
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int acpi_button_suspend(struct device *dev)
 {
@@ -492,6 +499,7 @@ static int acpi_button_add(struct acpi_d
 	struct acpi_button *button;
 	struct input_dev *input;
 	const char *hid = acpi_device_hid(device);
+	acpi_status status;
 	char *name, *class;
 	int error;
 
@@ -568,6 +576,26 @@ static int acpi_button_add(struct acpi_d
 	error = input_register_device(input);
 	if (error)
 		goto err_remove_fs;
+
+	if (device->device_type == ACPI_BUS_TYPE_POWER_BUTTON) {
+		status = acpi_install_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
+							  acpi_button_event,
+							  device);
+	} else if (device->device_type == ACPI_BUS_TYPE_SLEEP_BUTTON) {
+		status = acpi_install_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
+							  acpi_button_event,
+							  device);
+	} else {
+		status = acpi_install_notify_handler(device->handle,
+						     ACPI_DEVICE_NOTIFY,
+						     acpi_button_notify,
+						     device);
+	}
+	if (ACPI_FAILURE(status)) {
+		error = -ENODEV;
+		goto err_input_unregister;
+	}
+
 	if (button->type == ACPI_BUTTON_TYPE_LID) {
 		/*
 		 * This assumes there's only one lid device, or if there are
@@ -580,11 +608,13 @@ static int acpi_button_add(struct acpi_d
 	pr_info("%s [%s]\n", name, acpi_device_bid(device));
 	return 0;
 
- err_remove_fs:
+err_input_unregister:
+	input_unregister_device(input);
+err_remove_fs:
 	acpi_button_remove_fs(device);
- err_free_input:
+err_free_input:
 	input_free_device(input);
- err_free_button:
+err_free_button:
 	kfree(button);
 	return error;
 }
@@ -593,6 +623,18 @@ static void acpi_button_remove(struct ac
 {
 	struct acpi_button *button = acpi_driver_data(device);
 
+	if (device->device_type == ACPI_BUS_TYPE_POWER_BUTTON) {
+		acpi_remove_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
+						acpi_button_event);
+	} else if (device->device_type == ACPI_BUS_TYPE_SLEEP_BUTTON) {
+		acpi_remove_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
+						acpi_button_event);
+	} else {
+		acpi_remove_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
+					   acpi_button_notify);
+	}
+	acpi_os_wait_events_complete();
+
 	acpi_button_remove_fs(device);
 	input_unregister_device(button->input);
 	kfree(button);
Index: linux-pm/drivers/acpi/bus.c
===================================================================
--- linux-pm.orig/drivers/acpi/bus.c
+++ linux-pm/drivers/acpi/bus.c
@@ -530,65 +530,30 @@ static void acpi_notify_device(acpi_hand
 	acpi_drv->ops.notify(device, event);
 }
 
-static void acpi_notify_device_fixed(void *data)
-{
-	struct acpi_device *device = data;
-
-	/* Fixed hardware devices have no handles */
-	acpi_notify_device(NULL, ACPI_FIXED_HARDWARE_EVENT, device);
-}
-
-static u32 acpi_device_fixed_event(void *data)
-{
-	acpi_os_execute(OSL_NOTIFY_HANDLER, acpi_notify_device_fixed, data);
-	return ACPI_INTERRUPT_HANDLED;
-}
-
 static int acpi_device_install_notify_handler(struct acpi_device *device,
 					      struct acpi_driver *acpi_drv)
 {
-	acpi_status status;
-
-	if (device->device_type == ACPI_BUS_TYPE_POWER_BUTTON) {
-		status =
-		    acpi_install_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
-						     acpi_device_fixed_event,
-						     device);
-	} else if (device->device_type == ACPI_BUS_TYPE_SLEEP_BUTTON) {
-		status =
-		    acpi_install_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
-						     acpi_device_fixed_event,
-						     device);
-	} else {
-		u32 type = acpi_drv->flags & ACPI_DRIVER_ALL_NOTIFY_EVENTS ?
+	u32 type = acpi_drv->flags & ACPI_DRIVER_ALL_NOTIFY_EVENTS ?
 				ACPI_ALL_NOTIFY : ACPI_DEVICE_NOTIFY;
+	acpi_status status;
 
-		status = acpi_install_notify_handler(device->handle, type,
-						     acpi_notify_device,
-						     device);
-	}
-
+	status = acpi_install_notify_handler(device->handle, type,
+					     acpi_notify_device, device);
 	if (ACPI_FAILURE(status))
 		return -EINVAL;
+
 	return 0;
 }
 
 static void acpi_device_remove_notify_handler(struct acpi_device *device,
 					      struct acpi_driver *acpi_drv)
 {
-	if (device->device_type == ACPI_BUS_TYPE_POWER_BUTTON) {
-		acpi_remove_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
-						acpi_device_fixed_event);
-	} else if (device->device_type == ACPI_BUS_TYPE_SLEEP_BUTTON) {
-		acpi_remove_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
-						acpi_device_fixed_event);
-	} else {
-		u32 type = acpi_drv->flags & ACPI_DRIVER_ALL_NOTIFY_EVENTS ?
+	u32 type = acpi_drv->flags & ACPI_DRIVER_ALL_NOTIFY_EVENTS ?
 				ACPI_ALL_NOTIFY : ACPI_DEVICE_NOTIFY;
 
-		acpi_remove_notify_handler(device->handle, type,
-					   acpi_notify_device);
-	}
+	acpi_remove_notify_handler(device->handle, type,
+				   acpi_notify_device);
+
 	acpi_os_wait_events_complete();
 }
 



