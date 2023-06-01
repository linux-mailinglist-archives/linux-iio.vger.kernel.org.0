Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF650719E7C
	for <lists+linux-iio@lfdr.de>; Thu,  1 Jun 2023 15:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbjFANnh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Jun 2023 09:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbjFANng (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Jun 2023 09:43:36 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB6E13E;
        Thu,  1 Jun 2023 06:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685627015; x=1717163015;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xy9OgUL61th3jROVwjpCmagDUUoL2L/+PFsZiahG3m4=;
  b=k/hFLdDspdeYNgByIMpob5ABSkLTdVRkHMkSujI3O1+BRt22fcupYY76
   lAJ8h58oNHKuQWiKeeVvbCB1+I1YBweWZYTqFbi3y3EEjmM0Gaz/I0Rgk
   0hmRXbJBoiEybcHY5X21giuE9BH5r1WGCQAv/rVR6gAl1nmmnSHBoxzZg
   65Ifd4sLzTyeIErvlnAJ9P478IVx4w0r3NPcQNPAANIfJNK7pd4Fl8Y8e
   Gv1LIWmOFddh4/t7vC/teRX1r+q9ylltBZP1G9o1ou0m8emUwpSFmxBc/
   xzaBINsHlpaE71ZXY54UffAnRd4XiNGxKb9iA1aqjz8HnnFmohQDID3JZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="421350828"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="421350828"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 06:17:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="851678057"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="851678057"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 06:17:23 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
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
        Jason@zx2c4.com, robert.moore@intel.com
Cc:     linux-acpi@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
        chrome-platform@lists.linux.dev,
        platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        acpica-devel@lists.linuxfoundation.org
Subject: [PATCH v4 01/35] acpi: Adjust functions installing bus event handlers
Date:   Thu,  1 Jun 2023 15:17:19 +0200
Message-Id: <20230601131719.300720-1-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Currently acpi_device_install_notify_handler() and
acpi_device_remove_notify_handler() always install acpi_notify_device()
as a function handler, and only then the real .notify callback gets
called. This is not efficient and doesn't provide any real advantage.

Introduce new acpi_device_install_event_handler() and
acpi_device_remove_event_handler(). Those functions are replacing old
installers, and after all drivers switch to the new model, old installers
will be removed at the end of the patchset.

Make new installer/removal function arguments to take function pointer as
an argument instead of using .notify callback. Introduce new variable in
struct acpi_device, as fixed events still needs to be handled by an
intermediary that would schedule them for later execution. This is due to
fixed hardware event handlers being executed in interrupt context.

Make acpi_device_install_event_handler() and
acpi_device_remove_event_handler() non-static, and export symbols. This
will allow the drivers to call them directly, instead of relying on
.notify callback.

Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 drivers/acpi/bus.c      | 59 ++++++++++++++++++++++++++++++++++++++++-
 include/acpi/acpi_bus.h |  7 +++++
 2 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index d161ff707de4..cf2c2bfe29a0 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -535,7 +535,7 @@ static void acpi_notify_device_fixed(void *data)
 	struct acpi_device *device = data;
 
 	/* Fixed hardware devices have no handles */
-	acpi_notify_device(NULL, ACPI_FIXED_HARDWARE_EVENT, device);
+	device->fixed_event_notify(NULL, ACPI_FIXED_HARDWARE_EVENT, device);
 }
 
 static u32 acpi_device_fixed_event(void *data)
@@ -550,11 +550,13 @@ static int acpi_device_install_notify_handler(struct acpi_device *device,
 	acpi_status status;
 
 	if (device->device_type == ACPI_BUS_TYPE_POWER_BUTTON) {
+		device->fixed_event_notify = acpi_notify_device;
 		status =
 		    acpi_install_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
 						     acpi_device_fixed_event,
 						     device);
 	} else if (device->device_type == ACPI_BUS_TYPE_SLEEP_BUTTON) {
+		device->fixed_event_notify = acpi_notify_device;
 		status =
 		    acpi_install_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
 						     acpi_device_fixed_event,
@@ -579,9 +581,11 @@ static void acpi_device_remove_notify_handler(struct acpi_device *device,
 	if (device->device_type == ACPI_BUS_TYPE_POWER_BUTTON) {
 		acpi_remove_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
 						acpi_device_fixed_event);
+		device->fixed_event_notify = NULL;
 	} else if (device->device_type == ACPI_BUS_TYPE_SLEEP_BUTTON) {
 		acpi_remove_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
 						acpi_device_fixed_event);
+		device->fixed_event_notify = NULL;
 	} else {
 		u32 type = acpi_drv->flags & ACPI_DRIVER_ALL_NOTIFY_EVENTS ?
 				ACPI_ALL_NOTIFY : ACPI_DEVICE_NOTIFY;
@@ -592,6 +596,59 @@ static void acpi_device_remove_notify_handler(struct acpi_device *device,
 	acpi_os_wait_events_complete();
 }
 
+int acpi_device_install_event_handler(struct acpi_device *device,
+				      u32 type,
+				      void (*notify)(acpi_handle, u32, void*))
+{
+	acpi_status status;
+
+	if (!notify)
+		return -EINVAL;
+
+	if (device->device_type == ACPI_BUS_TYPE_POWER_BUTTON) {
+		device->fixed_event_notify = notify;
+		status =
+		    acpi_install_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
+						     acpi_device_fixed_event,
+						     device);
+	} else if (device->device_type == ACPI_BUS_TYPE_SLEEP_BUTTON) {
+		device->fixed_event_notify = notify;
+		status =
+		    acpi_install_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
+						     acpi_device_fixed_event,
+						     device);
+	} else {
+		status = acpi_install_notify_handler(device->handle, type,
+						     notify,
+						     device);
+	}
+
+	if (ACPI_FAILURE(status))
+		return -EINVAL;
+	return 0;
+}
+EXPORT_SYMBOL(acpi_device_install_event_handler);
+
+void acpi_device_remove_event_handler(struct acpi_device *device,
+				      u32 type,
+				      void (*notify)(acpi_handle, u32, void*))
+{
+	if (device->device_type == ACPI_BUS_TYPE_POWER_BUTTON) {
+		acpi_remove_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
+						acpi_device_fixed_event);
+		device->fixed_event_notify = NULL;
+	} else if (device->device_type == ACPI_BUS_TYPE_SLEEP_BUTTON) {
+		acpi_remove_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
+						acpi_device_fixed_event);
+		device->fixed_event_notify = NULL;
+	} else {
+		acpi_remove_notify_handler(device->handle, type,
+					   notify);
+	}
+	acpi_os_wait_events_complete();
+}
+EXPORT_SYMBOL(acpi_device_remove_event_handler);
+
 /* Handle events targeting \_SB device (at present only graceful shutdown) */
 
 #define ACPI_SB_NOTIFY_SHUTDOWN_REQUEST 0x81
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index a6affc0550b0..7fb411438b6f 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -387,6 +387,7 @@ struct acpi_device {
 	struct list_head physical_node_list;
 	struct mutex physical_node_lock;
 	void (*remove)(struct acpi_device *);
+	void (*fixed_event_notify)(acpi_handle handle, u32 type, void *data);
 };
 
 /* Non-device subnode */
@@ -513,6 +514,12 @@ void acpi_bus_private_data_handler(acpi_handle, void *);
 int acpi_bus_get_private_data(acpi_handle, void **);
 int acpi_bus_attach_private_data(acpi_handle, void *);
 void acpi_bus_detach_private_data(acpi_handle);
+int acpi_device_install_event_handler(struct acpi_device *device,
+				      u32 type,
+				      void (*notify)(acpi_handle, u32, void*));
+void acpi_device_remove_event_handler(struct acpi_device *device,
+				      u32 type,
+				      void (*notify)(acpi_handle, u32, void*));
 extern int acpi_notifier_call_chain(struct acpi_device *, u32, u32);
 extern int register_acpi_notifier(struct notifier_block *);
 extern int unregister_acpi_notifier(struct notifier_block *);
-- 
2.40.1

