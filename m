Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDE96E6A29
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2019 00:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbfJ0XJ7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Oct 2019 19:09:59 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37033 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbfJ0XJ5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Oct 2019 19:09:57 -0400
Received: by mail-pf1-f196.google.com with SMTP id u9so720795pfn.4
        for <linux-iio@vger.kernel.org>; Sun, 27 Oct 2019 16:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yo8GV3RfFAXg0pj4ZoefJom/7S4GI+RBava45ZX6RdU=;
        b=auEEHSOrpbv4a+eeDH7FmBPk4gnSHQ0gV6+X9DG3GsNe8l8XVwQInvN68vHsxp5SXZ
         fuV4rn5BnU+YseyUlne29lG3+mAO5Wfdeg+kxpCImxZUsHhv3AGWqOgyoHIHnDEqlFb3
         0eQtrEXAjaKyaKYy58D2gP/tG/Wsq4qdSq0qQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yo8GV3RfFAXg0pj4ZoefJom/7S4GI+RBava45ZX6RdU=;
        b=AU5qcYF0yMlTGvqG2kwwYTjGnmYY9PDqF/FU8Glnx3zfT9d+wHy4eW2bFqPt2h0L5J
         HwGbvGs5RiaXAC1892Qg85163T0lC6nQqfqq2FYcepaIZu3MHkyKZ+djJNMi2G59wTmm
         c8ezasHm6/UUce6mVu9Pm6HmPsAV+ErWoMDE+1/6QUye0pWr36zHJk5PVPdkFssXpxh0
         JpAUtoH0RFBXvgoqFuUKswD4HwKdBKXT/MapdVGBFw7OUTQOtV2bUpDHbcOZ44aar1zX
         okuQ1xXXTdBIyUiPqw+Zy5GsHtqA+OzZRvX19MjA8zZiUzIxvoMWUV3vcPPCKSwDODMH
         uF+A==
X-Gm-Message-State: APjAAAUb5nRs/yTrBXdo9pn2+OBGus7oEarnFy9k5Jshjp7ZVie15mzI
        nAbdRpxpG14mVhB+PIdEnK8kjQ==
X-Google-Smtp-Source: APXvYqxbYOjiuWpQMK8HAoVrCIvDeyYUC5/OsYLUSpddGqwltBB5ic0Xi0x0+LOxU2ErALVpVClY6g==
X-Received: by 2002:a17:90a:9f8a:: with SMTP id o10mr18578154pjp.91.1572217796448;
        Sun, 27 Oct 2019 16:09:56 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id e198sm9134830pfh.83.2019.10.27.16.09.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Oct 2019 16:09:55 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     briannorris@chromium.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, lee.jones@linaro.org,
        bleung@chromium.org, enric.balletbo@collabora.com,
        dianders@chromium.org, groeck@chromium.org,
        fabien.lahoudere@collabora.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 05/18] platform: chrome: cros-ec: record event timestamp in the hard irq
Date:   Sun, 27 Oct 2019 16:09:08 -0700
Message-Id: <20191027230921.205251-6-gwendal@chromium.org>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
In-Reply-To: <20191027230921.205251-1-gwendal@chromium.org>
References: <20191027230921.205251-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

To improve sensor timestamp precision, given EC and AP are in
different time domains, the AP needs to try to record the exact
moment an event was signalled to the AP by the EC as soon as
possible after it happens.

First thing in the hard irq is the best place for this.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
No changes in v3.
Changes in v2:
  Make cros_ec_get_time_ns inline.
  Using ktime_t instead of s64 when dealing with time.
  Added code in ishtp to gather timestamp.

 drivers/platform/chrome/cros_ec.c           | 12 +++++++++++-
 drivers/platform/chrome/cros_ec_ishtp.c     | 17 +++++++++++++++--
 drivers/platform/chrome/cros_ec_lpc.c       |  2 ++
 include/linux/platform_data/cros_ec_proto.h | 16 ++++++++++++++++
 4 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index 9b2d07422e175..739f3cffe26e3 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -31,6 +31,15 @@ static struct cros_ec_platform pd_p = {
 	.cmd_offset = EC_CMD_PASSTHRU_OFFSET(CROS_EC_DEV_PD_INDEX),
 };
 
+static irqreturn_t ec_irq_handler(int irq, void *data)
+{
+	struct cros_ec_device *ec_dev = data;
+
+	ec_dev->last_event_time = cros_ec_get_time_ns();
+
+	return IRQ_WAKE_THREAD;
+}
+
 static irqreturn_t ec_irq_thread(int irq, void *data)
 {
 	struct cros_ec_device *ec_dev = data;
@@ -141,7 +150,8 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 	}
 
 	if (ec_dev->irq) {
-		err = devm_request_threaded_irq(dev, ec_dev->irq, NULL,
+		err = devm_request_threaded_irq(
+				dev, ec_dev->irq, ec_irq_handler,
 				ec_irq_thread, IRQF_TRIGGER_LOW | IRQF_ONESHOT,
 				"chromeos-ec", ec_dev);
 		if (err) {
diff --git a/drivers/platform/chrome/cros_ec_ishtp.c b/drivers/platform/chrome/cros_ec_ishtp.c
index 25ca2c894b4de..5c848f22b44b4 100644
--- a/drivers/platform/chrome/cros_ec_ishtp.c
+++ b/drivers/platform/chrome/cros_ec_ishtp.c
@@ -200,13 +200,14 @@ static int ish_send(struct ishtp_cl_data *client_data,
  * process_recv() - Received and parse incoming packet
  * @cros_ish_cl: Client instance to get stats
  * @rb_in_proc: Host interface message buffer
+ * @timestamp: Timestamp of when parent callback started
  *
  * Parse the incoming packet. If it is a response packet then it will
  * update per instance flags and wake up the caller waiting to for the
  * response. If it is an event packet then it will schedule event work.
  */
 static void process_recv(struct ishtp_cl *cros_ish_cl,
-			 struct ishtp_cl_rb *rb_in_proc)
+			 struct ishtp_cl_rb *rb_in_proc, ktime_t timestamp)
 {
 	size_t data_len = rb_in_proc->buf_idx;
 	struct ishtp_cl_data *client_data =
@@ -295,6 +296,11 @@ static void process_recv(struct ishtp_cl *cros_ish_cl,
 		break;
 
 	case CROS_MKBP_EVENT:
+		/*
+		 * Set timestamp from beginning of function since we actually
+		 * got an incoming MKBP event
+		 */
+		client_data->ec_dev->last_event_time = timestamp;
 		/* The event system doesn't send any data in buffer */
 		schedule_work(&client_data->work_ec_evt);
 
@@ -322,10 +328,17 @@ static void ish_event_cb(struct ishtp_cl_device *cl_device)
 {
 	struct ishtp_cl_rb *rb_in_proc;
 	struct ishtp_cl	*cros_ish_cl = ishtp_get_drvdata(cl_device);
+	ktime_t timestamp;
+
+	/*
+	 * Take timestamp as close to hardware interrupt as possible for sensor
+	 * timestamps.
+	 */
+	timestamp = cros_ec_get_time_ns();
 
 	while ((rb_in_proc = ishtp_cl_rx_get_rb(cros_ish_cl)) != NULL) {
 		/* Decide what to do with received data */
-		process_recv(cros_ish_cl, rb_in_proc);
+		process_recv(cros_ish_cl, rb_in_proc, timestamp);
 	}
 }
 
diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index 7d10d909435ff..3c77496e164da 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -313,6 +313,8 @@ static void cros_ec_lpc_acpi_notify(acpi_handle device, u32 value, void *data)
 {
 	struct cros_ec_device *ec_dev = data;
 
+	ec_dev->last_event_time = cros_ec_get_time_ns();
+
 	if (ec_dev->mkbp_event_supported &&
 	    cros_ec_get_next_event(ec_dev, NULL) > 0)
 		blocking_notifier_call_chain(&ec_dev->event_notifier, 0,
diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
index 691f9e953a96a..b183024fef1f6 100644
--- a/include/linux/platform_data/cros_ec_proto.h
+++ b/include/linux/platform_data/cros_ec_proto.h
@@ -122,6 +122,8 @@ struct cros_ec_command {
  * @event_data: Raw payload transferred with the MKBP event.
  * @event_size: Size in bytes of the event data.
  * @host_event_wake_mask: Mask of host events that cause wake from suspend.
+ * @last_event_time: exact time from the hard irq when we got notified of
+ *     a new event.
  * @ec: The platform_device used by the mfd driver to interface with the
  *      main EC.
  * @pd: The platform_device used by the mfd driver to interface with the
@@ -162,6 +164,7 @@ struct cros_ec_device {
 	int event_size;
 	u32 host_event_wake_mask;
 	u32 last_resume_result;
+	ktime_t last_event_time;
 
 	/* The platform devices used by the mfd driver */
 	struct platform_device *ec;
@@ -210,4 +213,17 @@ int cros_ec_check_features(struct cros_ec_dev *ec, int feature);
 
 int cros_ec_get_sensor_count(struct cros_ec_dev *ec);
 
+/**
+ * cros_ec_get_time_ns - Return time in ns.
+ *
+ * This is the function used to record the time for last_event_time in struct
+ * cros_ec_device during the hard irq.
+ *
+ * Return: ktime_t format since boot.
+ */
+static inline ktime_t cros_ec_get_time_ns(void)
+{
+	return ktime_get_boottime_ns();
+}
+
 #endif /* __LINUX_CROS_EC_PROTO_H */
-- 
2.23.0.866.gb869b98d4c-goog

