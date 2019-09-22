Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 420A5BA374
	for <lists+linux-iio@lfdr.de>; Sun, 22 Sep 2019 19:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388286AbfIVRvL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Sep 2019 13:51:11 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41924 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388283AbfIVRvL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Sep 2019 13:51:11 -0400
Received: by mail-pf1-f194.google.com with SMTP id q7so7559192pfh.8
        for <linux-iio@vger.kernel.org>; Sun, 22 Sep 2019 10:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l7hNi5D/ZJN0kVpa71JImctObcmY7ytKQRt7LHXZ63k=;
        b=P4JQLK9mbCyUdt4Ia4YwRkZEpMegMyS4gVNxeA2hKVAj+f5Yoo0iu6Tjy/MiwMrJA0
         H4WlYzRbqQo06+PNTu7t63DtS77WG3T+cI3ihSCCrVIAE2ZT4Ahw8tmLBFaQ3NRB1tog
         wM+rpgr+HNaplYdiQQV/ZqXa7cFdh0ui2v2Po=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l7hNi5D/ZJN0kVpa71JImctObcmY7ytKQRt7LHXZ63k=;
        b=jsWkKUGBGiPbVKv2KE7TidY9UNkhVCLPZRKFVAqHd4wgPVWuICspgxHGnQ3mV+PC5Y
         imU1rlzbnWI/GSb+PdN36NG0HOka7pwy6W/GMI6Wjf+8p31UxvX7cuN+lJaMwF1k1ZdA
         stS8Kc/WN8wPLUl0dA/ZbbwuJWZXT6WVav1jxnrPjb0USMW/PmcE+rEkkGxiA5XaWffB
         SoykQZCpbCHVyqdLzV6rKioBaFBvPjY/bJ747mYcTtGh+poGXaEzMe1UhjklzQR+7cza
         l8RHCuDysUSWXfElo/ABSp6wUPtxPmr58j95nwVf38r5/cx9I/FvfZRc43s3IP6WdNPK
         /kCg==
X-Gm-Message-State: APjAAAWxjQwpWL69vQTF3C7dcBh5XAjEgkJZvMczy5SnDeUWcWNOZkve
        Ai9DHvb6r903K/opdd3fhW/PQA==
X-Google-Smtp-Source: APXvYqz9QrY6QLI53Wrd2Y0HlHl0KvzWzRsEvDMfLahWuJpzBrM3+Al74K4IcZFyYx8tEfP5HZJpcg==
X-Received: by 2002:a62:583:: with SMTP id 125mr30466432pff.69.1569174670438;
        Sun, 22 Sep 2019 10:51:10 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id n8sm14159523pgt.40.2019.09.22.10.51.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Sep 2019 10:51:09 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, lee.jones@linaro.org, bleung@chromium.org,
        enric.balletbo@collabora.com, dianders@chromium.org,
        groeck@chromium.org, fabien.lahoudere@collabora.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Enrico Granata <egranata@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 06/13] platform: chrome: cros_ec: handle MKBP more events flag
Date:   Sun, 22 Sep 2019 10:50:14 -0700
Message-Id: <20190922175021.53449-7-gwendal@chromium.org>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
In-Reply-To: <20190922175021.53449-1-gwendal@chromium.org>
References: <20190922175021.53449-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Enrico Granata <egranata@chromium.org>

The ChromeOS EC has support for signaling to the host that
a single IRQ can serve multiple MKBP events.

Doing this serves an optimization purpose, as it minimizes the
number of round-trips into the interrupt handling machinery, and
it proves beneficial to sensor timestamping as it keeps the desired
synchronization of event times between the two processors.

This patch adds kernel support for this EC feature, allowing the
ec_irq to loop until all events have been served.

Signed-off-by: Enrico Granata <egranata@chromium.org>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/platform/chrome/cros_ec.c           | 33 +++++++++----
 drivers/platform/chrome/cros_ec_proto.c     | 51 ++++++++++++---------
 include/linux/platform_data/cros_ec_proto.h |  7 ++-
 3 files changed, 57 insertions(+), 34 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index 9c8dc7cdb2b7..4adc007c357c 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -46,25 +46,38 @@ static irqreturn_t ec_irq_handler(int irq, void *data)
 	return IRQ_WAKE_THREAD;
 }
 
-static irqreturn_t ec_irq_thread(int irq, void *data)
+static bool ec_handle_event(struct cros_ec_device *ec_dev)
 {
-	struct cros_ec_device *ec_dev = data;
 	bool wake_event = true;
-	int ret;
+	bool ec_has_more_events = false;
+	int ret = cros_ec_get_next_event(ec_dev, &wake_event);
 
-	ret = cros_ec_get_next_event(ec_dev, &wake_event);
+	if (ec_dev->mkbp_event_supported) {
+		ec_has_more_events = (ret > 0) &&
+			(ec_dev->event_data.event_type &
+				EC_MKBP_HAS_MORE_EVENTS);
+	}
 
-	/*
-	 * Signal only if wake host events or any interrupt if
-	 * cros_ec_get_next_event() returned an error (default value for
-	 * wake_event is true)
-	 */
-	if (wake_event && device_may_wakeup(ec_dev->dev))
+	if (device_may_wakeup(ec_dev->dev) && wake_event)
 		pm_wakeup_event(ec_dev->dev, 0);
 
 	if (ret > 0)
 		blocking_notifier_call_chain(&ec_dev->event_notifier,
 					     0, ec_dev);
+
+	return ec_has_more_events;
+
+}
+
+static irqreturn_t ec_irq_thread(int irq, void *data)
+{
+	struct cros_ec_device *ec_dev = data;
+	bool ec_has_more_events;
+
+	do {
+		ec_has_more_events = ec_handle_event(ec_dev);
+	} while (ec_has_more_events);
+
 	return IRQ_HANDLED;
 }
 
diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index f659f96bda12..70e6d6c93b8d 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -425,10 +425,14 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev)
 	ret = cros_ec_get_host_command_version_mask(ec_dev,
 						    EC_CMD_GET_NEXT_EVENT,
 						    &ver_mask);
-	if (ret < 0 || ver_mask == 0)
+	if (ret < 0 || ver_mask == 0) {
 		ec_dev->mkbp_event_supported = 0;
-	else
-		ec_dev->mkbp_event_supported = 1;
+		dev_info(ec_dev->dev, "MKBP not supported\n");
+	} else {
+		ec_dev->mkbp_event_supported = fls(ver_mask);
+		dev_info(ec_dev->dev, "MKBP support version %u\n",
+			ec_dev->mkbp_event_supported - 1);
+	}
 
 	/* Probe if host sleep v1 is supported for S0ix failure detection. */
 	ret = cros_ec_get_host_command_version_mask(ec_dev,
@@ -519,6 +523,7 @@ EXPORT_SYMBOL(cros_ec_cmd_xfer_status);
 
 static int get_next_event_xfer(struct cros_ec_device *ec_dev,
 			       struct cros_ec_command *msg,
+			       struct ec_response_get_next_event_v1 *event,
 			       int version, uint32_t size)
 {
 	int ret;
@@ -531,7 +536,7 @@ static int get_next_event_xfer(struct cros_ec_device *ec_dev,
 	ret = cros_ec_cmd_xfer(ec_dev, msg);
 	if (ret > 0) {
 		ec_dev->event_size = ret - 1;
-		memcpy(&ec_dev->event_data, msg->data, ret);
+		ec_dev->event_data = *event;
 	}
 
 	return ret;
@@ -539,30 +544,29 @@ static int get_next_event_xfer(struct cros_ec_device *ec_dev,
 
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
+
+	BUILD_BUG_ON(sizeof(union ec_response_get_next_data_v1) != 16);
+
+	memset(&buf, 0, sizeof(buf));
 
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
@@ -606,7 +610,8 @@ int cros_ec_get_next_event(struct cros_ec_device *ec_dev, bool *wake_event)
 		return ret;
 
 	if (wake_event) {
-		event_type = ec_dev->event_data.event_type;
+		event_type =
+			ec_dev->event_data.event_type & EC_MKBP_EVENT_TYPE_MASK;
 		host_event = cros_ec_get_host_event(ec_dev);
 
 		/*
@@ -631,10 +636,12 @@ EXPORT_SYMBOL(cros_ec_get_next_event);
 u32 cros_ec_get_host_event(struct cros_ec_device *ec_dev)
 {
 	u32 host_event;
+	const u8 event_type =
+		ec_dev->event_data.event_type & EC_MKBP_EVENT_TYPE_MASK;
 
 	BUG_ON(!ec_dev->mkbp_event_supported);
 
-	if (ec_dev->event_data.event_type != EC_MKBP_EVENT_HOST_EVENT)
+	if (event_type != EC_MKBP_EVENT_HOST_EVENT)
 		return 0;
 
 	if (ec_dev->event_size != sizeof(host_event)) {
diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
index ab12e28f2107..63b5597294e7 100644
--- a/include/linux/platform_data/cros_ec_proto.h
+++ b/include/linux/platform_data/cros_ec_proto.h
@@ -115,7 +115,9 @@ struct cros_ec_command {
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
@@ -155,7 +157,8 @@ struct cros_ec_device {
 	int (*pkt_xfer)(struct cros_ec_device *ec,
 			struct cros_ec_command *msg);
 	struct mutex lock;
-	bool mkbp_event_supported;
+	/* 0 == not supported, otherwise it supports version x - 1 */
+	u8 mkbp_event_supported;
 	bool host_sleep_v1;
 	struct blocking_notifier_head event_notifier;
 
-- 
2.23.0.351.gc4317032e6-goog

