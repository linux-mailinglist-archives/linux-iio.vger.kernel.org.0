Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53520E6A1E
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2019 00:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbfJ0XKc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Oct 2019 19:10:32 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35539 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728672AbfJ0XKO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Oct 2019 19:10:14 -0400
Received: by mail-pg1-f194.google.com with SMTP id c8so5394084pgb.2
        for <linux-iio@vger.kernel.org>; Sun, 27 Oct 2019 16:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TaSSnoyXsJkJqKtjNXwr9938uilEvWpnhk4UTKv45FE=;
        b=n2pgY+wVD8PRvpHc+7811k12m8kg3uGOp/NoJsq3Drh14guy/eVUuhbtlD2jFp7VaG
         nn/d3ILlefqVPgElAiAHCGVsMgEiQF1RtN6JqdB/33Q0lGTSwVBpM5bBbW3Qf1Yc8Bl9
         eZ/pJq6NhdMGxq91lwqLHlRJz1w54yy/PdW+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TaSSnoyXsJkJqKtjNXwr9938uilEvWpnhk4UTKv45FE=;
        b=GRx9x+QtSRAKFC1yvNdUgvgZcSpd2VOS2tIVibeu7hsxsufXTmyu0KyX/1F/IR9viP
         u6hZLx5AKzU/0VneDggCBB0m6OHSp8IinRv3n9fH2/Uuz886Y7x8c5+XbPDN+sVS+0Ij
         JSHEY2qZ9FCS/qGdqdQSt+XBLzIbkjJMsltQMZslOXqnpZQfVaqUr8VyFKz1n1Rlwwvn
         C2wY9H4ZFqETuaUXkTNEv+t7QxIM11kjr5ERPmrdaggn8UjMci1WNXaAXOGMDm7kA/TG
         jpw4sZlQquirUJ5MOql+ctC1oWR/F2DQ+M8wmymzo8+42rWPKkx2YjN2qKGgXXuHfWCL
         4Sag==
X-Gm-Message-State: APjAAAWc6QCeNon1hNGZ+8s7l5TeYBihtYqMeMSE2colQL3+I81PVQMx
        hH10zT09dEYU5P8dNgwf2V/sPQ==
X-Google-Smtp-Source: APXvYqy+yDUBpgEHWUO0K/ZGXJb9/UxWMJz6Xpvns516khpBoc3opnMDCq3nBUOg//PH08yXV10Zqg==
X-Received: by 2002:a65:64cc:: with SMTP id t12mr17876797pgv.286.1572217812249;
        Sun, 27 Oct 2019 16:10:12 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id m68sm9554233pfb.122.2019.10.27.16.10.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Oct 2019 16:10:11 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     briannorris@chromium.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, lee.jones@linaro.org,
        bleung@chromium.org, enric.balletbo@collabora.com,
        dianders@chromium.org, groeck@chromium.org,
        fabien.lahoudere@collabora.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 16/18] iio: cros_ec: Expose hwfifo_timeout
Date:   Sun, 27 Oct 2019 16:09:19 -0700
Message-Id: <20191027230921.205251-17-gwendal@chromium.org>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
In-Reply-To: <20191027230921.205251-1-gwendal@chromium.org>
References: <20191027230921.205251-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Expose EC minimal interrupt period through buffer/hwfifo_timeout:
- Maximal timeout is limited to 65s.
- When timeout for all sensors is set to 0, EC will not send events,
  even if the sensor sampling rate is greater than 0.

Rename frequency to sampling_frequency to match IIO ABI.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
No changes in v3.
Changes in v2:
- Register fifo_attributes in sensors drivers that previously advertise
  that feature.


 .../common/cros_ec_sensors/cros_ec_sensors.c  |  4 +-
 .../cros_ec_sensors/cros_ec_sensors_core.c    | 95 ++++++++++++++-----
 drivers/iio/light/cros_ec_light_prox.c        |  6 +-
 drivers/iio/pressure/cros_ec_baro.c           |  6 +-
 .../linux/iio/common/cros_ec_sensors_core.h   |  4 +-
 5 files changed, 85 insertions(+), 30 deletions(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
index 2eb4bb254fbde..8c57a3ade78ed 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
@@ -236,6 +236,9 @@ static int cros_ec_sensors_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	iio_buffer_set_attrs(indio_dev->buffer,
+			cros_ec_sensor_fifo_attributes);
+
 	indio_dev->info = &ec_sensors_info;
 	state = iio_priv(indio_dev);
 	for (channel = state->channels, i = CROS_EC_SENSOR_X;
@@ -247,7 +250,6 @@ static int cros_ec_sensors_probe(struct platform_device *pdev)
 			BIT(IIO_CHAN_INFO_CALIBSCALE);
 		channel->info_mask_shared_by_all =
 			BIT(IIO_CHAN_INFO_SCALE) |
-			BIT(IIO_CHAN_INFO_FREQUENCY) |
 			BIT(IIO_CHAN_INFO_SAMP_FREQ);
 		channel->info_mask_shared_by_all_available =
 			BIT(IIO_CHAN_INFO_SAMP_FREQ);
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index 353dbbd9b7515..506b481420036 100644
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
@@ -84,6 +85,77 @@ static void get_default_min_max_freq(enum motionsensor_type type,
 	}
 }
 
+static int cros_ec_sensor_set_ec_rate(struct cros_ec_sensors_core_state *st,
+				      int rate)
+{
+	int ret;
+
+	if (rate > U16_MAX)
+		rate = U16_MAX;
+
+	mutex_lock(&st->cmd_lock);
+	st->param.cmd = MOTIONSENSE_CMD_EC_RATE;
+	st->param.ec_rate.data = rate;
+	ret = cros_ec_motion_send_host_cmd(st, 0);
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
+const struct attribute *cros_ec_sensor_fifo_attributes[] = {
+	&iio_dev_attr_hwfifo_timeout.dev_attr.attr,
+	NULL,
+};
+EXPORT_SYMBOL_GPL(cros_ec_sensor_fifo_attributes);
+
 int cros_ec_sensors_push_data(struct iio_dev *indio_dev,
 			      s16 *data,
 			      s64 timestamp)
@@ -615,18 +687,6 @@ int cros_ec_sensors_core_read(struct cros_ec_sensors_core_state *st,
 
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
@@ -696,7 +756,7 @@ int cros_ec_sensors_core_write(struct cros_ec_sensors_core_state *st,
 	int ret;
 
 	switch (mask) {
-	case IIO_CHAN_INFO_FREQUENCY:
+	case IIO_CHAN_INFO_SAMP_FREQ:
 		st->param.cmd = MOTIONSENSE_CMD_SENSOR_ODR;
 		st->param.sensor_odr.data = val;
 
@@ -705,15 +765,6 @@ int cros_ec_sensors_core_write(struct cros_ec_sensors_core_state *st,
 
 		ret = cros_ec_motion_send_host_cmd(st, 0);
 		break;
-	case IIO_CHAN_INFO_SAMP_FREQ:
-		st->param.cmd = MOTIONSENSE_CMD_EC_RATE;
-		st->param.ec_rate.data = val;
-
-		ret = cros_ec_motion_send_host_cmd(st, 0);
-		if (ret)
-			break;
-		st->curr_sampl_freq = val;
-		break;
 	default:
 		ret = -EINVAL;
 		break;
diff --git a/drivers/iio/light/cros_ec_light_prox.c b/drivers/iio/light/cros_ec_light_prox.c
index 6bac02cdd898a..059aaddc91fd8 100644
--- a/drivers/iio/light/cros_ec_light_prox.c
+++ b/drivers/iio/light/cros_ec_light_prox.c
@@ -183,6 +183,9 @@ static int cros_ec_light_prox_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	iio_buffer_set_attrs(indio_dev->buffer,
+			cros_ec_sensor_fifo_attributes);
+
 	indio_dev->info = &cros_ec_light_prox_info;
 	state = iio_priv(indio_dev);
 	state->core.type = state->core.resp->info.type;
@@ -191,8 +194,7 @@ static int cros_ec_light_prox_probe(struct platform_device *pdev)
 
 	/* Common part */
 	channel->info_mask_shared_by_all =
-		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
-		BIT(IIO_CHAN_INFO_FREQUENCY);
+		BIT(IIO_CHAN_INFO_SAMP_FREQ);
 	channel->info_mask_shared_by_all_available =
 		BIT(IIO_CHAN_INFO_SAMP_FREQ);
 	channel->scan_type.realbits = CROS_EC_SENSOR_BITS;
diff --git a/drivers/iio/pressure/cros_ec_baro.c b/drivers/iio/pressure/cros_ec_baro.c
index fb7daeb4b29f9..e933a1bb64d4b 100644
--- a/drivers/iio/pressure/cros_ec_baro.c
+++ b/drivers/iio/pressure/cros_ec_baro.c
@@ -139,6 +139,9 @@ static int cros_ec_baro_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	iio_buffer_set_attrs(indio_dev->buffer,
+			cros_ec_sensor_fifo_attributes);
+
 	indio_dev->info = &cros_ec_baro_info;
 	state = iio_priv(indio_dev);
 	state->core.type = state->core.resp->info.type;
@@ -148,8 +151,7 @@ static int cros_ec_baro_probe(struct platform_device *pdev)
 	channel->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
 	channel->info_mask_shared_by_all =
 		BIT(IIO_CHAN_INFO_SCALE) |
-		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
-		BIT(IIO_CHAN_INFO_FREQUENCY);
+		BIT(IIO_CHAN_INFO_SAMP_FREQ);
 	channel->scan_type.realbits = CROS_EC_SENSOR_BITS;
 	channel->scan_type.storagebits = CROS_EC_SENSOR_BITS;
 	channel->scan_type.shift = 0;
diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include/linux/iio/common/cros_ec_sensors_core.h
index f5dc532c9db21..ded8381b1299c 100644
--- a/include/linux/iio/common/cros_ec_sensors_core.h
+++ b/include/linux/iio/common/cros_ec_sensors_core.h
@@ -50,7 +50,6 @@ typedef irqreturn_t (*cros_ec_sensors_capture_t)(int irq, void *p);
  *				the timestamp. The timestamp is always last and
  *				is always 8-byte aligned.
  * @read_ec_sensors_data:	function used for accessing sensors values
- * @cuur_sampl_freq:		current sampling period
  */
 struct cros_ec_sensors_core_state {
 	struct cros_ec_device *ec;
@@ -73,8 +72,6 @@ struct cros_ec_sensors_core_state {
 	int (*read_ec_sensors_data)(struct iio_dev *indio_dev,
 				    unsigned long scan_mask, s16 *data);
 
-	int curr_sampl_freq;
-
 	/* Table of known available frequencies : 0, Min and Max in mHz */
 	int frequencies[3];
 };
@@ -117,5 +114,6 @@ int cros_ec_sensors_core_write(struct cros_ec_sensors_core_state *st,
 
 /* List of extended channel specification for all sensors */
 extern const struct iio_chan_spec_ext_info cros_ec_sensors_ext_info[];
+extern const struct attribute *cros_ec_sensor_fifo_attributes[];
 
 #endif  /* __CROS_EC_SENSORS_CORE_H */
-- 
2.23.0.866.gb869b98d4c-goog

