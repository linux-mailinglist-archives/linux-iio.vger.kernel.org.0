Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22306FD9E7
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2019 10:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfKOJv0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Nov 2019 04:51:26 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35051 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727427AbfKOJub (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Nov 2019 04:50:31 -0500
Received: by mail-pg1-f196.google.com with SMTP id k32so20600pgl.2
        for <linux-iio@vger.kernel.org>; Fri, 15 Nov 2019 01:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YKvWIiX8f6r/tshVcQv0VcSh8J3fB/cLWX5VEjsHu80=;
        b=VivcTxJj9hgjOwan6xFCvIdPngnwVIax/tcam9mR+vmV2b5prWHzXlzuhNBpKQHcNe
         Gb8lAwyju5kMWmNFo+rdu5iLfjh3sXzyIOamAvsDnP9B1ZMc+ER/0lioVH5dSE7GNYk7
         nUBWJslHsx7uVfY0cdc4r/2XWaNlDuZUfrxmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YKvWIiX8f6r/tshVcQv0VcSh8J3fB/cLWX5VEjsHu80=;
        b=bFQBlQ5MruLG6wCAp0p6/dezo+qrOdyKImVh4yoPWYgejslusZirGlDFidQ37g8pSM
         gPSXgY0cQKhIqWoGyqEKBn7N7u0uqa5qSb+gWYHud1H51yN4m8ioONSs94BsfTyjsPmi
         AEjwbDHULNlb3hjLelA7z+eiIzMnkqix+bikwjovmKQRJ65i4vWr4gE+j7zJwpCchvDE
         stezi3fS6B8HIsCEjinDF/AzrtsM4rkFRMp07cxW4RxvqPIqbBj3vvF26Dvakf8FX3rb
         9IRJSqbWrsv+YzcxGvKHA/O39mWApAw03y6XPlwxxCo2RIezKdUIxDEVCLUjAtfD/vMq
         OlVg==
X-Gm-Message-State: APjAAAUvlPnm9VvRQhnYnFSYV3sfn40UhqpPgqaIPkWMWYDDoAy/4uQb
        Tb1zVsUseOT/8BO2Aq/O22rUdg==
X-Google-Smtp-Source: APXvYqyjmuvsnezR7yW9g0VH2uM3Vebr8GU2jMlbtmIUo8DB06Gz9W0HyQsjxZPgJf4zheci/xr3Ag==
X-Received: by 2002:a63:4819:: with SMTP id v25mr15234995pga.165.1573811428900;
        Fri, 15 Nov 2019 01:50:28 -0800 (PST)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id y12sm11577313pfp.176.2019.11.15.01.50.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2019 01:50:28 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     dmitry.torokhov@gmail.com, groeck@chromium.org,
        briannorris@chromium.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, lee.jones@linaro.org,
        bleung@chromium.org, enric.balletbo@collabora.com,
        dianders@chromium.org, fabien.lahoudere@collabora.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org,
        Enrico Granata <egranata@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v5 06/18] platform: chrome: cros_ec: handle MKBP more events flag
Date:   Fri, 15 Nov 2019 01:34:00 -0800
Message-Id: <20191115093412.144922-7-gwendal@chromium.org>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
In-Reply-To: <20191115093412.144922-1-gwendal@chromium.org>
References: <20191115093412.144922-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Enrico Granata <egranata@chromium.org>

The ChromeOS EC has support for signaling to the host that
a single IRQ can serve multiple MKBP (Matrix KeyBoard Protocol)
events.

Doing this serves an optimization purpose, as it minimizes the
number of round-trips into the interrupt handling machinery, and
it proves beneficial to sensor timestamping as it keeps the desired
synchronization of event times between the two processors.

This patch adds kernel support for this EC feature, allowing the
ec_irq to loop until all events have been served.

Signed-off-by: Enrico Granata <egranata@chromium.org>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
Changes in v5:
- Remove unrelated blank line change.
Changes in v4:
- Check patch with --strict option
    Alignement
Changes in v3:
  Fix indentation.
Changes in v2:
  Process flag inside cros_ec_get_next_event, clean flag from event.
  Introduce public function cros_ec_handle_event(), use it in rpmsg and
    ishtp transport layer.
  Remplace dev_info with dev_dbg, call only once.

 drivers/platform/chrome/cros_ec.c           | 34 +++++++--
 drivers/platform/chrome/cros_ec_ishtp.c     |  8 +--
 drivers/platform/chrome/cros_ec_lpc.c       | 15 ++--
 drivers/platform/chrome/cros_ec_proto.c     | 80 +++++++++++++--------
 drivers/platform/chrome/cros_ec_rpmsg.c     | 19 ++---
 include/linux/platform_data/cros_ec_proto.h | 12 +++-
 6 files changed, 107 insertions(+), 61 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index d3dfa27171e6..6d6ce86a1408 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -40,13 +40,23 @@ static irqreturn_t ec_irq_handler(int irq, void *data)
 	return IRQ_WAKE_THREAD;
 }
 
-static irqreturn_t ec_irq_thread(int irq, void *data)
+/**
+ * cros_ec_handle_event() - process and forward pending events on EC
+ * @ec_dev: Device with events to process.
+ *
+ * Call this function in a loop when the kernel is notified that the EC has
+ * pending events.
+ *
+ * Return: true if more events are still pending and this function should be
+ * called again.
+ */
+bool cros_ec_handle_event(struct cros_ec_device *ec_dev)
 {
-	struct cros_ec_device *ec_dev = data;
-	bool wake_event = true;
+	bool wake_event;
+	bool ec_has_more_events;
 	int ret;
 
-	ret = cros_ec_get_next_event(ec_dev, &wake_event);
+	ret = cros_ec_get_next_event(ec_dev, &wake_event, &ec_has_more_events);
 
 	/*
 	 * Signal only if wake host events or any interrupt if
@@ -59,6 +69,20 @@ static irqreturn_t ec_irq_thread(int irq, void *data)
 	if (ret > 0)
 		blocking_notifier_call_chain(&ec_dev->event_notifier,
 					     0, ec_dev);
+
+	return ec_has_more_events;
+}
+EXPORT_SYMBOL(cros_ec_handle_event);
+
+static irqreturn_t ec_irq_thread(int irq, void *data)
+{
+	struct cros_ec_device *ec_dev = data;
+	bool ec_has_more_events;
+
+	do {
+		ec_has_more_events = cros_ec_handle_event(ec_dev);
+	} while (ec_has_more_events);
+
 	return IRQ_HANDLED;
 }
 
@@ -274,7 +298,7 @@ EXPORT_SYMBOL(cros_ec_suspend);
 static void cros_ec_report_events_during_suspend(struct cros_ec_device *ec_dev)
 {
 	while (ec_dev->mkbp_event_supported &&
-	       cros_ec_get_next_event(ec_dev, NULL) > 0)
+	       cros_ec_get_next_event(ec_dev, NULL, NULL) > 0)
 		blocking_notifier_call_chain(&ec_dev->event_notifier,
 					     1, ec_dev);
 }
diff --git a/drivers/platform/chrome/cros_ec_ishtp.c b/drivers/platform/chrome/cros_ec_ishtp.c
index 5c848f22b44b..e5996821d08b 100644
--- a/drivers/platform/chrome/cros_ec_ishtp.c
+++ b/drivers/platform/chrome/cros_ec_ishtp.c
@@ -136,11 +136,11 @@ static void ish_evt_handler(struct work_struct *work)
 	struct ishtp_cl_data *client_data =
 		container_of(work, struct ishtp_cl_data, work_ec_evt);
 	struct cros_ec_device *ec_dev = client_data->ec_dev;
+	bool ec_has_more_events;
 
-	if (cros_ec_get_next_event(ec_dev, NULL) > 0) {
-		blocking_notifier_call_chain(&ec_dev->event_notifier,
-					     0, ec_dev);
-	}
+	do {
+		ec_has_more_events = cros_ec_handle_event(ec_dev);
+	} while (ec_has_more_events);
 }
 
 /**
diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index 3c77496e164d..dccf479c6625 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -312,13 +312,20 @@ static int cros_ec_lpc_readmem(struct cros_ec_device *ec, unsigned int offset,
 static void cros_ec_lpc_acpi_notify(acpi_handle device, u32 value, void *data)
 {
 	struct cros_ec_device *ec_dev = data;
+	bool ec_has_more_events;
+	int ret;
 
 	ec_dev->last_event_time = cros_ec_get_time_ns();
 
-	if (ec_dev->mkbp_event_supported &&
-	    cros_ec_get_next_event(ec_dev, NULL) > 0)
-		blocking_notifier_call_chain(&ec_dev->event_notifier, 0,
-					     ec_dev);
+	if (ec_dev->mkbp_event_supported)
+		do {
+			ret = cros_ec_get_next_event(ec_dev, NULL,
+						     &ec_has_more_events);
+			if (ret > 0)
+				blocking_notifier_call_chain(
+						&ec_dev->event_notifier, 0,
+						ec_dev);
+		} while (ec_has_more_events);
 
 	if (value == ACPI_NOTIFY_DEVICE_WAKE)
 		pm_system_wakeup();
diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 12bdd1f3aee9..da1b1c450433 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -456,7 +456,10 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev)
 	if (ret < 0 || ver_mask == 0)
 		ec_dev->mkbp_event_supported = 0;
 	else
-		ec_dev->mkbp_event_supported = 1;
+		ec_dev->mkbp_event_supported = fls(ver_mask);
+
+	dev_dbg(ec_dev->dev, "MKBP support version %u\n",
+		ec_dev->mkbp_event_supported - 1);
 
 	/* Probe if host sleep v1 is supported for S0ix failure detection. */
 	ret = cros_ec_get_host_command_version_mask(ec_dev,
@@ -569,6 +572,7 @@ EXPORT_SYMBOL(cros_ec_cmd_xfer_status);
 
 static int get_next_event_xfer(struct cros_ec_device *ec_dev,
 			       struct cros_ec_command *msg,
+			       struct ec_response_get_next_event_v1 *event,
 			       int version, uint32_t size)
 {
 	int ret;
@@ -581,7 +585,7 @@ static int get_next_event_xfer(struct cros_ec_device *ec_dev,
 	ret = cros_ec_cmd_xfer(ec_dev, msg);
 	if (ret > 0) {
 		ec_dev->event_size = ret - 1;
-		memcpy(&ec_dev->event_data, msg->data, ret);
+		ec_dev->event_data = *event;
 	}
 
 	return ret;
@@ -589,30 +593,26 @@ static int get_next_event_xfer(struct cros_ec_device *ec_dev,
 
 static int get_next_event(struct cros_ec_device *ec_dev)
 {
-	u8 buffer[sizeof(struct cros_ec_command) + sizeof(ec_dev->event_data)];
-	struct cros_ec_command *msg = (struct cros_ec_command *)&buffer;
-	static int cmd_version = 1;
-	int ret;
+	struct {
+		struct cros_ec_command msg;
+		struct ec_response_get_next_event_v1 event;
+	} __packed buf;
+	struct cros_ec_command *msg = &buf.msg;
+	struct ec_response_get_next_event_v1 *event = &buf.event;
+	const int cmd_version = ec_dev->mkbp_event_supported - 1;
 
+	memset(msg, 0, sizeof(*msg));
 	if (ec_dev->suspended) {
 		dev_dbg(ec_dev->dev, "Device suspended.\n");
 		return -EHOSTDOWN;
 	}
 
-	if (cmd_version == 1) {
-		ret = get_next_event_xfer(ec_dev, msg, cmd_version,
-				sizeof(struct ec_response_get_next_event_v1));
-		if (ret < 0 || msg->result != EC_RES_INVALID_VERSION)
-			return ret;
-
-		/* Fallback to version 0 for future send attempts */
-		cmd_version = 0;
-	}
-
-	ret = get_next_event_xfer(ec_dev, msg, cmd_version,
+	if (cmd_version == 0)
+		return get_next_event_xfer(ec_dev, msg, event, 0,
 				  sizeof(struct ec_response_get_next_event));
 
-	return ret;
+	return get_next_event_xfer(ec_dev, msg, event, cmd_version,
+				sizeof(struct ec_response_get_next_event_v1));
 }
 
 static int get_keyboard_state_event(struct cros_ec_device *ec_dev)
@@ -639,32 +639,55 @@ static int get_keyboard_state_event(struct cros_ec_device *ec_dev)
  * @ec_dev: Device to fetch event from.
  * @wake_event: Pointer to a bool set to true upon return if the event might be
  *              treated as a wake event. Ignored if null.
+ * @has_more_events: Pointer to bool set to true if more than one event is
+ *              pending.
+ *              Some EC will set this flag to indicate cros_ec_get_next_event()
+ *              can be called multiple times in a row.
+ *              It is an optimization to prevent issuing a EC command for
+ *              nothing or wait for another interrupt from the EC to process
+ *              the next message.
+ *              Ignored if null.
  *
  * Return: negative error code on errors; 0 for no data; or else number of
  * bytes received (i.e., an event was retrieved successfully). Event types are
  * written out to @ec_dev->event_data.event_type on success.
  */
-int cros_ec_get_next_event(struct cros_ec_device *ec_dev, bool *wake_event)
+int cros_ec_get_next_event(struct cros_ec_device *ec_dev,
+			   bool *wake_event,
+			   bool *has_more_events)
 {
 	u8 event_type;
 	u32 host_event;
 	int ret;
 
-	if (!ec_dev->mkbp_event_supported) {
-		ret = get_keyboard_state_event(ec_dev);
-		if (ret <= 0)
-			return ret;
+	/*
+	 * Default value for wake_event.
+	 * Wake up on keyboard event, wake up for spurious interrupt or link
+	 * error to the EC.
+	 */
+	if (wake_event)
+		*wake_event = true;
 
-		if (wake_event)
-			*wake_event = true;
+	/*
+	 * Default value for has_more_events.
+	 * EC will raise another interrupt if AP does not process all events
+	 * anyway.
+	 */
+	if (has_more_events)
+		*has_more_events = false;
 
-		return ret;
-	}
+	if (!ec_dev->mkbp_event_supported)
+		return get_keyboard_state_event(ec_dev);
 
 	ret = get_next_event(ec_dev);
 	if (ret <= 0)
 		return ret;
 
+	if (has_more_events)
+		*has_more_events = ec_dev->event_data.event_type &
+			EC_MKBP_HAS_MORE_EVENTS;
+	ec_dev->event_data.event_type &= EC_MKBP_EVENT_TYPE_MASK;
+
 	if (wake_event) {
 		event_type = ec_dev->event_data.event_type;
 		host_event = cros_ec_get_host_event(ec_dev);
@@ -679,9 +702,6 @@ int cros_ec_get_next_event(struct cros_ec_device *ec_dev, bool *wake_event)
 		else if (host_event &&
 			 !(host_event & ec_dev->host_event_wake_mask))
 			*wake_event = false;
-		/* Consider all other events as wake events. */
-		else
-			*wake_event = true;
 	}
 
 	return ret;
diff --git a/drivers/platform/chrome/cros_ec_rpmsg.c b/drivers/platform/chrome/cros_ec_rpmsg.c
index 0c3738c3244d..bd068afe43b5 100644
--- a/drivers/platform/chrome/cros_ec_rpmsg.c
+++ b/drivers/platform/chrome/cros_ec_rpmsg.c
@@ -143,22 +143,11 @@ cros_ec_rpmsg_host_event_function(struct work_struct *host_event_work)
 						      struct cros_ec_rpmsg,
 						      host_event_work);
 	struct cros_ec_device *ec_dev = dev_get_drvdata(&ec_rpmsg->rpdev->dev);
-	bool wake_event = true;
-	int ret;
-
-	ret = cros_ec_get_next_event(ec_dev, &wake_event);
-
-	/*
-	 * Signal only if wake host events or any interrupt if
-	 * cros_ec_get_next_event() returned an error (default value for
-	 * wake_event is true)
-	 */
-	if (wake_event && device_may_wakeup(ec_dev->dev))
-		pm_wakeup_event(ec_dev->dev, 0);
+	bool ec_has_more_events;
 
-	if (ret > 0)
-		blocking_notifier_call_chain(&ec_dev->event_notifier,
-					     0, ec_dev);
+	do {
+		ec_has_more_events = cros_ec_handle_event(ec_dev);
+	} while (ec_has_more_events);
 }
 
 static int cros_ec_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
index 02dc34f366d7..30098a551523 100644
--- a/include/linux/platform_data/cros_ec_proto.h
+++ b/include/linux/platform_data/cros_ec_proto.h
@@ -116,7 +116,9 @@ struct cros_ec_command {
  *            code.
  * @pkt_xfer: Send packet to EC and get response.
  * @lock: One transaction at a time.
- * @mkbp_event_supported: True if this EC supports the MKBP event protocol.
+ * @mkbp_event_supported: 0 if MKBP not supported. Otherwise its value is
+ *                        the maximum supported version of the MKBP host event
+ *                        command + 1.
  * @host_sleep_v1: True if this EC supports the sleep v1 command.
  * @event_notifier: Interrupt event notifier for transport devices.
  * @event_data: Raw payload transferred with the MKBP event.
@@ -156,7 +158,7 @@ struct cros_ec_device {
 	int (*pkt_xfer)(struct cros_ec_device *ec,
 			struct cros_ec_command *msg);
 	struct mutex lock;
-	bool mkbp_event_supported;
+	u8 mkbp_event_supported;
 	bool host_sleep_v1;
 	struct blocking_notifier_head event_notifier;
 
@@ -205,7 +207,9 @@ int cros_ec_unregister(struct cros_ec_device *ec_dev);
 
 int cros_ec_query_all(struct cros_ec_device *ec_dev);
 
-int cros_ec_get_next_event(struct cros_ec_device *ec_dev, bool *wake_event);
+int cros_ec_get_next_event(struct cros_ec_device *ec_dev,
+			   bool *wake_event,
+			   bool *has_more_events);
 
 u32 cros_ec_get_host_event(struct cros_ec_device *ec_dev);
 
@@ -213,6 +217,8 @@ int cros_ec_check_features(struct cros_ec_dev *ec, int feature);
 
 int cros_ec_get_sensor_count(struct cros_ec_dev *ec);
 
+bool cros_ec_handle_event(struct cros_ec_device *ec_dev);
+
 /**
  * cros_ec_get_time_ns() - Return time in ns.
  *
-- 
2.24.0.432.g9d3f5f5b63-goog

