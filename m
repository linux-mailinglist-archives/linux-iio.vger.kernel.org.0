Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFC719613C
	for <lists+linux-iio@lfdr.de>; Fri, 27 Mar 2020 23:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgC0WfC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 27 Mar 2020 18:35:02 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40822 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727860AbgC0We6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Mar 2020 18:34:58 -0400
Received: by mail-pg1-f195.google.com with SMTP id t24so5263531pgj.7
        for <linux-iio@vger.kernel.org>; Fri, 27 Mar 2020 15:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QTh+wdR0CD0jKDR/O8gu60oGmr1BAoQDmL/q2DQ7J8E=;
        b=lg+Nu8YZaeeLdn/Hvh8/JhK2MXHdiud49/ggSlexTrXuqct8do47w9fxQYpnGRLKxx
         TY7vJKK/VEuoPJLtJYnB+0ONI/xr9BXjMjpbFHgydE2OzqZAODXEr4ofeW2CbNCqDPG0
         N5ZSfqT+xmND0mfQURNdxNkSPoJgIiHKrpo0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QTh+wdR0CD0jKDR/O8gu60oGmr1BAoQDmL/q2DQ7J8E=;
        b=B7cxvVFQ2qnd6IDUPLN2otNcOzO3XfnOnOYGYglw6cX4tKPwrpdBcWU402ws7Fs+fe
         YbEVLchf4+wRzus038TMfwA6khWTZ88SlPZHIa7s/2JfsjcILZgg48qoEqts7Op8VpPX
         Kgh7iAttgG03m2FNo9X46lCf0lGOVkknMa1GOgGRBKb8OPA/2aC8EZuoMbXM0mXgY5pu
         m7bdwSbXIgT0xF1lUoFY1o8uKIKQMaxlzmdfjLhsxGrdQnJtk97ShZIDVNCGo2ECO4Wr
         lU3lW83THph26ISzKypioeCFR28nQ6g9sSSJZ1DGFgWtudjAMhuz0z2X+IK5tHgNAlkr
         ZAOQ==
X-Gm-Message-State: ANhLgQ0xww7/B0yP9xnCp5UKMLxfnvZUzf02Ygsf+ruo10MPmo4xxu3g
        I7NmEB/xlLhvapMDCx57V1TynA==
X-Google-Smtp-Source: ADFU+vvugLt7b/NuU949oU3kG00kqTbkXGXbcFYQq14ho6bMk6Mwru1FZjobjRoQD5By7Hc4/+LQYQ==
X-Received: by 2002:a63:7e10:: with SMTP id z16mr1585488pgc.412.1585348497648;
        Fri, 27 Mar 2020 15:34:57 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4cc0:7eee:97c9:3c1a])
        by smtp.gmail.com with ESMTPSA id d26sm4885369pfo.37.2020.03.27.15.34.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2020 15:34:57 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     bleung@chromium.org, enric.balletbo@collabora.com,
        Jonathan.Cameron@huawei.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v7 09/12] iio: cros_ec: Expose hwfifo_timeout
Date:   Fri, 27 Mar 2020 15:34:40 -0700
Message-Id: <20200327223443.6006-10-gwendal@chromium.org>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
In-Reply-To: <20200327223443.6006-1-gwendal@chromium.org>
References: <20200327223443.6006-1-gwendal@chromium.org>
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

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
No changes in v6 and v7.
Changes in v5:
  Added ack.
Changes in v4:
- Check patch with --strict option
    Alignement
No changes in v3.
Changes in v2:
- Register fifo_attributes in sensors drivers that previously advertise
  that feature.

 .../common/cros_ec_sensors/cros_ec_sensors.c  |  3 +-
 .../cros_ec_sensors/cros_ec_sensors_core.c    | 95 ++++++++++++++-----
 drivers/iio/light/cros_ec_light_prox.c        |  5 +-
 drivers/iio/pressure/cros_ec_baro.c           |  5 +-
 .../linux/iio/common/cros_ec_sensors_core.h   |  4 +-
 5 files changed, 82 insertions(+), 30 deletions(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
index fad21a90bc7e8..a66941fdb3855 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
@@ -236,6 +236,8 @@ static int cros_ec_sensors_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	iio_buffer_set_attrs(indio_dev->buffer, cros_ec_sensor_fifo_attributes);
+
 	indio_dev->info = &ec_sensors_info;
 	state = iio_priv(indio_dev);
 	for (channel = state->channels, i = CROS_EC_SENSOR_X;
@@ -247,7 +249,6 @@ static int cros_ec_sensors_probe(struct platform_device *pdev)
 			BIT(IIO_CHAN_INFO_CALIBSCALE);
 		channel->info_mask_shared_by_all =
 			BIT(IIO_CHAN_INFO_SCALE) |
-			BIT(IIO_CHAN_INFO_FREQUENCY) |
 			BIT(IIO_CHAN_INFO_SAMP_FREQ);
 		channel->info_mask_shared_by_all_available =
 			BIT(IIO_CHAN_INFO_SAMP_FREQ);
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index a1ecbd55ea767..b8eac7e5d5e5b 100644
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
@@ -83,6 +84,77 @@ static void get_default_min_max_freq(enum motionsensor_type type,
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
+						 struct device_attribute *attr,
+						 const char *buf, size_t len)
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
+						 struct device_attribute *attr,
+						 char *buf)
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
@@ -631,18 +703,6 @@ int cros_ec_sensors_core_read(struct cros_ec_sensors_core_state *st,
 
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
@@ -712,7 +772,7 @@ int cros_ec_sensors_core_write(struct cros_ec_sensors_core_state *st,
 	int ret;
 
 	switch (mask) {
-	case IIO_CHAN_INFO_FREQUENCY:
+	case IIO_CHAN_INFO_SAMP_FREQ:
 		st->param.cmd = MOTIONSENSE_CMD_SENSOR_ODR;
 		st->param.sensor_odr.data = val;
 
@@ -721,15 +781,6 @@ int cros_ec_sensors_core_write(struct cros_ec_sensors_core_state *st,
 
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
index e10b35de4c2fa..2198b50909ed0 100644
--- a/drivers/iio/light/cros_ec_light_prox.c
+++ b/drivers/iio/light/cros_ec_light_prox.c
@@ -183,6 +183,8 @@ static int cros_ec_light_prox_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	iio_buffer_set_attrs(indio_dev->buffer, cros_ec_sensor_fifo_attributes);
+
 	indio_dev->info = &cros_ec_light_prox_info;
 	state = iio_priv(indio_dev);
 	state->core.type = state->core.resp->info.type;
@@ -191,8 +193,7 @@ static int cros_ec_light_prox_probe(struct platform_device *pdev)
 
 	/* Common part */
 	channel->info_mask_shared_by_all =
-		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
-		BIT(IIO_CHAN_INFO_FREQUENCY);
+		BIT(IIO_CHAN_INFO_SAMP_FREQ);
 	channel->info_mask_shared_by_all_available =
 		BIT(IIO_CHAN_INFO_SAMP_FREQ);
 	channel->scan_type.realbits = CROS_EC_SENSOR_BITS;
diff --git a/drivers/iio/pressure/cros_ec_baro.c b/drivers/iio/pressure/cros_ec_baro.c
index 6add499f11aa6..c079b89600824 100644
--- a/drivers/iio/pressure/cros_ec_baro.c
+++ b/drivers/iio/pressure/cros_ec_baro.c
@@ -140,6 +140,8 @@ static int cros_ec_baro_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	iio_buffer_set_attrs(indio_dev->buffer, cros_ec_sensor_fifo_attributes);
+
 	indio_dev->info = &cros_ec_baro_info;
 	state = iio_priv(indio_dev);
 	state->core.type = state->core.resp->info.type;
@@ -149,8 +151,7 @@ static int cros_ec_baro_probe(struct platform_device *pdev)
 	channel->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
 	channel->info_mask_shared_by_all =
 		BIT(IIO_CHAN_INFO_SCALE) |
-		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
-		BIT(IIO_CHAN_INFO_FREQUENCY);
+		BIT(IIO_CHAN_INFO_SAMP_FREQ);
 	channel->info_mask_shared_by_all_available =
 		BIT(IIO_CHAN_INFO_SAMP_FREQ);
 	channel->scan_type.realbits = CROS_EC_SENSOR_BITS;
diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include/linux/iio/common/cros_ec_sensors_core.h
index 96ea4551945e2..5b0acc14c891f 100644
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
@@ -116,5 +113,6 @@ int cros_ec_sensors_core_write(struct cros_ec_sensors_core_state *st,
 
 /* List of extended channel specification for all sensors */
 extern const struct iio_chan_spec_ext_info cros_ec_sensors_ext_info[];
+extern const struct attribute *cros_ec_sensor_fifo_attributes[];
 
 #endif  /* __CROS_EC_SENSORS_CORE_H */
-- 
2.26.0.rc2.310.g2932bb562d-goog

