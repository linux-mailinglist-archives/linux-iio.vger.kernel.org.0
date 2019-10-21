Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71FCADE420
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2019 07:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfJUFyk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Oct 2019 01:54:40 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37910 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbfJUFyj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Oct 2019 01:54:39 -0400
Received: by mail-pf1-f193.google.com with SMTP id h195so7692945pfe.5
        for <linux-iio@vger.kernel.org>; Sun, 20 Oct 2019 22:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y8VvIDEUzgzOMc6xpWZ3lCTYzI69DQPFZmVj3lTRNRw=;
        b=bjYbwrM0vAFomwWAxnewGnzfPMxYI7qz90WNYhoErZZ2KaPma2q9lAVzN6YR4esmfq
         8OhInS6RGIdaSNObOM4//0A3vpF2PMLse2i6Lzt1sQQfW87868lyaZreKtHwGjL0lDdm
         yEJPWUqk8vUQDWcosvYF0+a6oIMBtCgJ2Cd+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y8VvIDEUzgzOMc6xpWZ3lCTYzI69DQPFZmVj3lTRNRw=;
        b=XxgYQCDtc7s5NgjUABrWd4ryV3m0azRXeNbA/Uk+4uvI+MOewG3y5nn1BfP+/JWnZ0
         ETl7LhR2Q/aFsSd2fT30hFIU/oEHmyHITcWsz1aKWQ7LKeqJXQhxG94jVdnpO2ZClqMa
         OJLwTDULVZgZsLuZgj0ul19g+iDeGNkaMrQ7/X/0BN6bYPG9lUXzuts8UQQd9XKkCkDL
         lIs3KYqXspC3wwojzmOBurgkYkciKLHAyfIcwkO0RO1faBHer6H4cW2iPygmmZkLWrrq
         AVSCqIWcp0oGot5kqpCXY1DOslDXUkJ4/gotoRiCykttoCca7maRENeJ8Q0lM+rp4eAA
         Z54g==
X-Gm-Message-State: APjAAAWxgVs/v1cOOA2dbyNVSN2giXHeF6BjxOonf5sOcE+C8zau2zgq
        ESWPE+YeT9vn834YYyoDPzinDA==
X-Google-Smtp-Source: APXvYqztHNMff55mPoiBI7Lm86tfSoxkcF39JDu/xF5Aw5WiwPe4IYx6LTEp4kiXfqjjS0BaQEywDg==
X-Received: by 2002:a63:6d0:: with SMTP id 199mr23068156pgg.96.1571637278614;
        Sun, 20 Oct 2019 22:54:38 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id h66sm22633572pjb.0.2019.10.20.22.54.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Oct 2019 22:54:37 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     briannorris@chromium.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, lee.jones@linaro.org,
        bleung@chromium.org, enric.balletbo@collabora.com,
        dianders@chromium.org, groeck@chromium.org,
        fabien.lahoudere@collabora.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 17/18] iio: cros_ec: Report hwfifo_watermark_max
Date:   Sun, 20 Oct 2019 22:54:02 -0700
Message-Id: <20191021055403.67849-18-gwendal@chromium.org>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
In-Reply-To: <20191021055403.67849-1-gwendal@chromium.org>
References: <20191021055403.67849-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Report the maximum amount of sample the EC can hold.
This is not tunable, but can be useful for application to find out the
maximum amount of time it can sleep when hwfifo_timeout is set to a
large number.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
Changes in v2:
- Remove double lines, add line before return for visibility.

 .../cros_ec_sensors/cros_ec_sensors_core.c    | 34 +++++++++++++++++--
 .../linux/iio/common/cros_ec_sensors_core.h   |  3 ++
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index 92128c67a166e..f50e239f9a1e9 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -23,6 +23,12 @@
 #include <linux/platform_data/cros_ec_sensorhub.h>
 #include <linux/platform_device.h>
 
+/*
+ * Hard coded to the first device to support sensor fifo.  The EC has a 2048
+ * byte fifo and will trigger an interrupt when fifo is 2/3 full.
+ */
+#define CROS_EC_FIFO_SIZE (2048 * 2 / 3)
+
 static char *cros_ec_loc[] = {
 	[MOTIONSENSE_LOC_BASE] = "base",
 	[MOTIONSENSE_LOC_LID] = "lid",
@@ -56,8 +62,15 @@ static int cros_ec_get_host_cmd_version_mask(struct cros_ec_device *ec_dev,
 
 static void get_default_min_max_freq(enum motionsensor_type type,
 				     u32 *min_freq,
-				     u32 *max_freq)
+				     u32 *max_freq,
+				     u32 *max_fifo_events)
 {
+	/*
+	 * We don't know fifo size, set to size previously used by older
+	 * hardware.
+	 */
+	*max_fifo_events = CROS_EC_FIFO_SIZE;
+
 	switch (type) {
 	case MOTIONSENSE_TYPE_ACCEL:
 	case MOTIONSENSE_TYPE_GYRO:
@@ -150,8 +163,22 @@ static IIO_DEVICE_ATTR(hwfifo_timeout, 0644,
 		       cros_ec_sensor_get_report_latency,
 		       cros_ec_sensor_set_report_latency, 0);
 
+static ssize_t hwfifo_watermark_max_show(
+		struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
+
+	return sprintf(buf, "%d\n", st->fifo_max_event_count);
+}
+
+static IIO_DEVICE_ATTR_RO(hwfifo_watermark_max, 0);
+
 const struct attribute *cros_ec_sensor_fifo_attributes[] = {
 	&iio_dev_attr_hwfifo_timeout.dev_attr.attr,
+	&iio_dev_attr_hwfifo_watermark_max.dev_attr.attr,
 	NULL,
 };
 EXPORT_SYMBOL_GPL(cros_ec_sensor_fifo_attributes);
@@ -281,12 +308,15 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 		if (state->msg->version < 3) {
 			get_default_min_max_freq(state->resp->info.type,
 						 &state->frequencies[1],
-						 &state->frequencies[2]);
+						 &state->frequencies[2],
+						 &state->fifo_max_event_count);
 		} else {
 			state->frequencies[1] =
 			    state->resp->info_3.min_frequency;
 			state->frequencies[2] =
 			    state->resp->info_3.max_frequency;
+			state->fifo_max_event_count =
+			    state->resp->info_3.fifo_max_event_count;
 		}
 
 		ret = devm_iio_triggered_buffer_setup(
diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include/linux/iio/common/cros_ec_sensors_core.h
index 387ca9e61dac8..4df3abd151fbf 100644
--- a/include/linux/iio/common/cros_ec_sensors_core.h
+++ b/include/linux/iio/common/cros_ec_sensors_core.h
@@ -51,6 +51,7 @@ typedef irqreturn_t (*cros_ec_sensors_capture_t)(int irq, void *p);
  *				the timestamp. The timestamp is always last and
  *				is always 8-byte aligned.
  * @read_ec_sensors_data:	function used for accessing sensors values
+ * @fifo_max_event_count:	Size of the EC sensor FIFO
  */
 struct cros_ec_sensors_core_state {
 	struct cros_ec_device *ec;
@@ -73,6 +74,8 @@ struct cros_ec_sensors_core_state {
 	int (*read_ec_sensors_data)(struct iio_dev *indio_dev,
 				    unsigned long scan_mask, s16 *data);
 
+	u32 fifo_max_event_count;
+
 	/* Table of known available frequencies : 0, Min and Max in mHz */
 	int frequencies[3];
 };
-- 
2.23.0.866.gb869b98d4c-goog

