Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD83DBA37A
	for <lists+linux-iio@lfdr.de>; Sun, 22 Sep 2019 19:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388330AbfIVRvS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Sep 2019 13:51:18 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33480 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388328AbfIVRvS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Sep 2019 13:51:18 -0400
Received: by mail-pg1-f194.google.com with SMTP id i30so822846pgl.0
        for <linux-iio@vger.kernel.org>; Sun, 22 Sep 2019 10:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fU7pV+OJmhx44QoE/6uD0xkUifuGWdTctjSB3GNUjbc=;
        b=UEbRnZ6fVNHK/UMvbrEvJZOKGaoPZ/Dqx/GrOtBkydXI5WA2+pm3ZztTgTwhpO68LG
         4Nr4HM1m/QzJzaRxVQGfKvK3a5k0lbvqmgMe1ofSpDQm8dEpZ8DbtVNlUUvnZvyVwYvX
         Xsg+BpCKlv716i5Ip8CV0iLrv2e9ltQSrC5w0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fU7pV+OJmhx44QoE/6uD0xkUifuGWdTctjSB3GNUjbc=;
        b=dlAU8tYIhXX9ecXKAA4Q6Ml9o1fN6a1TZ3NKPxw8P5CcfpR7WIj5Mt5YIR+HgaDLY3
         3KEnAvZ2SAzE7DERY5tue2xCHA/zMhyfBTFrxreHczO+2YoXcyJJ0kCRiJmqQWHD852t
         eu0snViES1O7Bh++6xUsAAyR7X3t63z0F4GNGdwN6VHki23VoBEk+na8iazzWq4ns3Nc
         AvKk17Zh+tUWOwGrlg6hfMfrK5m3Ct2k64nNmOPcvM1VItLU+N7PXfxu2zluMmWMaY7n
         rifXllp4vvctsQxM2N7ouF/7Xj9peuHTtzQ5He+19GrrlopF7RNAroolg7y/Xs9scahB
         l81g==
X-Gm-Message-State: APjAAAWvuh6wuZ6b/DpVnxiCbZnKE4TYxNUjMpzs7Yh/9bnIDgetjCVL
        cBH4fddVeUkIqIiy+BJ8jFoMUQ==
X-Google-Smtp-Source: APXvYqwGcV9+d4bWnHkp6A0EN+2ZcdeZBTlEaVyob3EjcrwidAOAUaQTS61bahp/PqMV2JoS/FV6yg==
X-Received: by 2002:a17:90a:8d13:: with SMTP id c19mr17305261pjo.142.1569174677370;
        Sun, 22 Sep 2019 10:51:17 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id z21sm8929021pfa.119.2019.09.22.10.51.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Sep 2019 10:51:16 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, lee.jones@linaro.org, bleung@chromium.org,
        enric.balletbo@collabora.com, dianders@chromium.org,
        groeck@chromium.org, fabien.lahoudere@collabora.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 11/13] iio: cros_ec: Expose hwfifo_timeout
Date:   Sun, 22 Sep 2019 10:50:19 -0700
Message-Id: <20190922175021.53449-12-gwendal@chromium.org>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
In-Reply-To: <20190922175021.53449-1-gwendal@chromium.org>
References: <20190922175021.53449-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Expose EC sampling rate through buffer/hwfifo_timeout.
Rename frequency to sampling_frequency to match IIO ABI.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 .../common/cros_ec_sensors/cros_ec_sensors.c  |   1 -
 .../cros_ec_sensors/cros_ec_sensors_core.c    | 110 +++++++++++++-----
 drivers/iio/light/cros_ec_light_prox.c        |   3 +-
 drivers/iio/pressure/cros_ec_baro.c           |   3 +-
 4 files changed, 81 insertions(+), 36 deletions(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
index b78a942ac8e5..95a4b4cf8f87 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
@@ -255,7 +255,6 @@ static int cros_ec_sensors_probe(struct platform_device *pdev)
 			BIT(IIO_CHAN_INFO_CALIBSCALE);
 		channel->info_mask_shared_by_all =
 			BIT(IIO_CHAN_INFO_SCALE) |
-			BIT(IIO_CHAN_INFO_FREQUENCY) |
 			BIT(IIO_CHAN_INFO_SAMP_FREQ);
 		channel->info_mask_shared_by_all_available =
 			BIT(IIO_CHAN_INFO_SAMP_FREQ);
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index c4c37c6df301..a31a761e3a81 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -11,6 +11,7 @@
 #include <linux/iio/common/cros_ec_sensors_core.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/kfifo_buf.h>
+#include <linux/iio/sysfs.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 #include <linux/kernel.h>
@@ -84,6 +85,75 @@ static void get_default_min_max_freq(enum motionsensor_type type,
 	}
 }
 
+static int cros_ec_sensor_set_ec_rate(struct cros_ec_sensors_core_state *st,
+				      int rate)
+{
+	int ret;
+
+	mutex_lock(&st->cmd_lock);
+	st->param.cmd = MOTIONSENSE_CMD_EC_RATE;
+	st->param.ec_rate.data = rate;
+	ret = cros_ec_motion_send_host_cmd(st, 0);
+	if (ret == 0)
+		st->curr_sampl_freq = rate;
+	mutex_unlock(&st->cmd_lock);
+	return ret;
+}
+
+static ssize_t cros_ec_sensor_set_report_latency(struct device *dev,
+					      struct device_attribute *attr,
+					      const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
+	int integer, fract, ret;
+	int latency;
+
+	ret = iio_str_to_fixpoint(buf, 100000, &integer, &fract);
+	if (ret)
+		return ret;
+
+	/* EC rate is in ms. */
+	latency = integer * 1000 + fract / 1000;
+	ret = cros_ec_sensor_set_ec_rate(st, latency);
+	if (ret < 0)
+		return ret;
+
+	return len;
+}
+
+static ssize_t cros_ec_sensor_get_report_latency(struct device *dev,
+					      struct device_attribute *attr,
+					      char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
+	int latency, ret;
+
+	mutex_lock(&st->cmd_lock);
+	st->param.cmd = MOTIONSENSE_CMD_EC_RATE;
+	st->param.ec_rate.data = EC_MOTION_SENSE_NO_VALUE;
+
+	ret = cros_ec_motion_send_host_cmd(st, 0);
+	latency = st->resp->ec_rate.ret;
+	mutex_unlock(&st->cmd_lock);
+	if (ret < 0)
+		return ret;
+
+	return sprintf(buf, "%d.%06u\n",
+		       latency / 1000,
+		       (latency % 1000) * 1000);
+}
+
+static IIO_DEVICE_ATTR(hwfifo_timeout, 0644,
+		       cros_ec_sensor_get_report_latency,
+		       cros_ec_sensor_set_report_latency, 0);
+
+static const struct attribute *cros_ec_sensor_fifo_attributes[] = {
+	&iio_dev_attr_hwfifo_timeout.dev_attr.attr,
+	NULL,
+};
+
 int cros_ec_sensors_push_data(
 		struct iio_dev *indio_dev,
 		s16 *data,
@@ -194,6 +264,9 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 			if (!buffer)
 				return -ENOMEM;
 
+			iio_buffer_set_attrs(buffer,
+					     cros_ec_sensor_fifo_attributes);
+
 			iio_device_attach_buffer(indio_dev, buffer);
 			indio_dev->modes = INDIO_BUFFER_SOFTWARE;
 			ret = cros_ec_sensorhub_register_push_data(
@@ -553,18 +626,6 @@ int cros_ec_sensors_core_read(struct cros_ec_sensors_core_state *st,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		st->param.cmd = MOTIONSENSE_CMD_EC_RATE;
-		st->param.ec_rate.data =
-			EC_MOTION_SENSE_NO_VALUE;
-
-		ret = cros_ec_motion_send_host_cmd(st, 0);
-		if (ret)
-			break;
-
-		*val = st->resp->ec_rate.ret;
-		ret = IIO_VAL_INT;
-		break;
-	case IIO_CHAN_INFO_FREQUENCY:
 		st->param.cmd = MOTIONSENSE_CMD_SENSOR_ODR;
 		st->param.sensor_odr.data =
 			EC_MOTION_SENSE_NO_VALUE;
@@ -613,23 +674,16 @@ int cros_ec_sensors_core_write(struct cros_ec_sensors_core_state *st,
 	int ret;
 
 	switch (mask) {
-	case IIO_CHAN_INFO_FREQUENCY:
+	case IIO_CHAN_INFO_SAMP_FREQ:
 		st->param.cmd = MOTIONSENSE_CMD_SENSOR_ODR;
 		st->param.sensor_odr.data = val;
 
 		/* Always roundup, so caller gets at least what it asks for. */
 		st->param.sensor_odr.roundup = 1;
 
-		ret = cros_ec_motion_send_host_cmd(st, 0);
-		break;
-	case IIO_CHAN_INFO_SAMP_FREQ:
-		st->param.cmd = MOTIONSENSE_CMD_EC_RATE;
-		st->param.ec_rate.data = val;
-
 		ret = cros_ec_motion_send_host_cmd(st, 0);
 		if (ret)
 			break;
-		st->curr_sampl_freq = val;
 		break;
 	default:
 		ret = -EINVAL;
@@ -643,6 +697,7 @@ static int __maybe_unused cros_ec_sensors_prepare(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
+	int ret = 0;
 
 	if (st->curr_sampl_freq == 0)
 		return 0;
@@ -652,13 +707,10 @@ static int __maybe_unused cros_ec_sensors_prepare(struct device *dev)
 	 * sleep. Set sampling to a long period if necessary.
 	 */
 	if (st->curr_sampl_freq < CROS_EC_MIN_SUSPEND_SAMPLING_FREQUENCY) {
-		mutex_lock(&st->cmd_lock);
-		st->param.cmd = MOTIONSENSE_CMD_EC_RATE;
-		st->param.ec_rate.data = CROS_EC_MIN_SUSPEND_SAMPLING_FREQUENCY;
-		cros_ec_motion_send_host_cmd(st, 0);
-		mutex_unlock(&st->cmd_lock);
+		ret = cros_ec_sensor_set_ec_rate(st,
+				CROS_EC_MIN_SUSPEND_SAMPLING_FREQUENCY);
 	}
-	return 0;
+	return ret;
 }
 
 static void __maybe_unused cros_ec_sensors_complete(struct device *dev)
@@ -670,11 +722,7 @@ static void __maybe_unused cros_ec_sensors_complete(struct device *dev)
 		return;
 
 	if (st->curr_sampl_freq < CROS_EC_MIN_SUSPEND_SAMPLING_FREQUENCY) {
-		mutex_lock(&st->cmd_lock);
-		st->param.cmd = MOTIONSENSE_CMD_EC_RATE;
-		st->param.ec_rate.data = st->curr_sampl_freq;
-		cros_ec_motion_send_host_cmd(st, 0);
-		mutex_unlock(&st->cmd_lock);
+		cros_ec_sensor_set_ec_rate(st, st->curr_sampl_freq);
 	}
 }
 
diff --git a/drivers/iio/light/cros_ec_light_prox.c b/drivers/iio/light/cros_ec_light_prox.c
index d58f010880ce..e9b0072d5c88 100644
--- a/drivers/iio/light/cros_ec_light_prox.c
+++ b/drivers/iio/light/cros_ec_light_prox.c
@@ -199,8 +199,7 @@ static int cros_ec_light_prox_probe(struct platform_device *pdev)
 
 	/* Common part */
 	channel->info_mask_shared_by_all =
-		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
-		BIT(IIO_CHAN_INFO_FREQUENCY);
+		BIT(IIO_CHAN_INFO_SAMP_FREQ);
 	channel->info_mask_shared_by_all_available =
 		BIT(IIO_CHAN_INFO_SAMP_FREQ);
 	channel->scan_type.realbits = CROS_EC_SENSOR_BITS;
diff --git a/drivers/iio/pressure/cros_ec_baro.c b/drivers/iio/pressure/cros_ec_baro.c
index c7538e93d24f..aa3cae5a1a15 100644
--- a/drivers/iio/pressure/cros_ec_baro.c
+++ b/drivers/iio/pressure/cros_ec_baro.c
@@ -148,8 +148,7 @@ static int cros_ec_baro_probe(struct platform_device *pdev)
 	channel->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
 	channel->info_mask_shared_by_all =
 		BIT(IIO_CHAN_INFO_SCALE) |
-		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
-		BIT(IIO_CHAN_INFO_FREQUENCY);
+		BIT(IIO_CHAN_INFO_SAMP_FREQ);
 	channel->scan_type.realbits = CROS_EC_SENSOR_BITS;
 	channel->scan_type.storagebits = CROS_EC_SENSOR_BITS;
 	channel->scan_type.shift = 0;
-- 
2.23.0.351.gc4317032e6-goog

