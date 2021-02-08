Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE2531418E
	for <lists+linux-iio@lfdr.de>; Mon,  8 Feb 2021 22:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbhBHVUc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Feb 2021 16:20:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236352AbhBHVUK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Feb 2021 16:20:10 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B44BC06178B
        for <linux-iio@vger.kernel.org>; Mon,  8 Feb 2021 13:19:26 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id x5so278198pjk.7
        for <linux-iio@vger.kernel.org>; Mon, 08 Feb 2021 13:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=+UO7t1fiBCtqm6AMKRgpMhb0FcwpGXGfnEs5Vmc3s84=;
        b=mp6XKL4bLhB5DS3r/0qXz7hEl1kB6XT9u3J2IgZxkoEg3ZCNRKDwIwupBa5kchqJAV
         RJQrW8ILZjutV41JRVzDJyaK+R5eU5Gs1nuH5GEqSP1IgC032GQT7SC0b1mlztBjvUyM
         MzE03YBNbqPxCvaTtFt45Mv+bb7BSbvftiX0NKVXpzSM2XN/IYAuAa3Sa0Lar7FXR/zA
         Bus0RzfAw5nKzPMOE2lShHk3P8eFCAV9tsou6UfaVw1g8mH6jaLCBXMiEkqE33q5dD/O
         fzvqOg2GZyynLKqy5qZwWVTyREtDR/Y2IO/fEO+8ZvKDphW8zohGtqUg9YxJBnEhNzMW
         faKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+UO7t1fiBCtqm6AMKRgpMhb0FcwpGXGfnEs5Vmc3s84=;
        b=hfic59uTIMz1T34S1KEOaS2VHY6yVhP8O7u6tegdeD1O4kPEDaPdu3Y26GVNgEwpUg
         01xgHww6DdG5kwAz1DIVyUZ9+P6huwftqebQtm0p+a49SlLCI53svl/fDVBuASl1GyQT
         CEU5p7hhGXxhN6uvOSHJ/FL1O4IiRfozD3d/3IzEl1ocoRRa9YzzQlEvVpXQIHuouYV0
         GZMIn/GwwCJqEQVbZB9SeRwyQwAuFRoOg77hlx4F23NpLiY6Vpa1QdXrJj3dc72urTF/
         +AOcpzszJvAskk9P2UGRowhRg2uk7RxxClB/9wcLJ9tNHED5SMtG51rvUx9n7uTujV0W
         HzHA==
X-Gm-Message-State: AOAM532+nLEY+x3W2+nZgcfReyMlWTx+86IXOlKwNw0ZGs9SZTS8EwoS
        ij9GV9HQT+gbOFADPVOv+m9dnCtrf76N+g==
X-Google-Smtp-Source: ABdhPJyYK+lPodttU058gB8dPY2s5o1LWB8G+9qSgGYj8mz8MNb2SKviUwgD8pSiQ1sWdyZCkqS36cuCExRFTA==
Sender: "jbhayana via sendgmr" <jbhayana@jbhayana.c.googlers.com>
X-Received: from jbhayana.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:42b2])
 (user=jbhayana job=sendgmr) by 2002:a62:14cb:0:b029:1d1:f512:f686 with SMTP
 id 194-20020a6214cb0000b02901d1f512f686mr19041385pfu.11.1612819165997; Mon,
 08 Feb 2021 13:19:25 -0800 (PST)
Date:   Mon,  8 Feb 2021 21:19:18 +0000
In-Reply-To: <20210208211918.1280588-1-jbhayana@google.com>
Message-Id: <20210208211918.1280588-2-jbhayana@google.com>
Mime-Version: 1.0
References: <20210208211918.1280588-1-jbhayana@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH v5 1/1] iio/scmi: Adding support for IIO SCMI Based Sensors
From:   Jyoti Bhayana <jbhayana@google.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jyoti Bhayana <jbhayana@google.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        cristian.marussi@arm.com, sudeep.holla@arm.com,
        egranata@google.com, mikhail.golubev@opensynergy.com,
        Igor.Skalkin@opensynergy.com, Peter.hilber@opensynergy.com,
        ankitarora@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change provides ARM SCMI Protocol based IIO device.
This driver provides support for Accelerometer and Gyroscope using
SCMI Sensor Protocol extensions added in the SCMIv3.0 ARM specification

Signed-off-by: Jyoti Bhayana <jbhayana@google.com>
---
 MAINTAINERS                                |   6 +
 drivers/firmware/arm_scmi/driver.c         |   2 +-
 drivers/iio/common/Kconfig                 |   1 +
 drivers/iio/common/Makefile                |   1 +
 drivers/iio/common/scmi_sensors/Kconfig    |  18 +
 drivers/iio/common/scmi_sensors/Makefile   |   5 +
 drivers/iio/common/scmi_sensors/scmi_iio.c | 673 +++++++++++++++++++++
 7 files changed, 705 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iio/common/scmi_sensors/Kconfig
 create mode 100644 drivers/iio/common/scmi_sensors/Makefile
 create mode 100644 drivers/iio/common/scmi_sensors/scmi_iio.c

diff --git a/MAINTAINERS b/MAINTAINERS
index b516bb34a8d5..ccf37d43ab41 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8567,6 +8567,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.txt
 F:	drivers/iio/multiplexer/iio-mux.c
 
+IIO SCMI BASED DRIVER
+M:	Jyoti Bhayana <jbhayana@google.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	drivers/iio/common/scmi_sensors/scmi_iio.c
+
 IIO SUBSYSTEM AND DRIVERS
 M:	Jonathan Cameron <jic23@kernel.org>
 R:	Lars-Peter Clausen <lars@metafoo.de>
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 5392e1fc6b4e..248313bbd473 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -741,7 +741,7 @@ static struct scmi_prot_devnames devnames[] = {
 	{ SCMI_PROTOCOL_SYSTEM, { "syspower" },},
 	{ SCMI_PROTOCOL_PERF,   { "cpufreq" },},
 	{ SCMI_PROTOCOL_CLOCK,  { "clocks" },},
-	{ SCMI_PROTOCOL_SENSOR, { "hwmon" },},
+	{ SCMI_PROTOCOL_SENSOR, { "hwmon", "iiodev" },},
 	{ SCMI_PROTOCOL_RESET,  { "reset" },},
 	{ SCMI_PROTOCOL_VOLTAGE,  { "regulator" },},
 };
diff --git a/drivers/iio/common/Kconfig b/drivers/iio/common/Kconfig
index 2b9ee9161abd..0334b4954773 100644
--- a/drivers/iio/common/Kconfig
+++ b/drivers/iio/common/Kconfig
@@ -6,5 +6,6 @@
 source "drivers/iio/common/cros_ec_sensors/Kconfig"
 source "drivers/iio/common/hid-sensors/Kconfig"
 source "drivers/iio/common/ms_sensors/Kconfig"
+source "drivers/iio/common/scmi_sensors/Kconfig"
 source "drivers/iio/common/ssp_sensors/Kconfig"
 source "drivers/iio/common/st_sensors/Kconfig"
diff --git a/drivers/iio/common/Makefile b/drivers/iio/common/Makefile
index 4bc30bb548e2..fad40e1e1718 100644
--- a/drivers/iio/common/Makefile
+++ b/drivers/iio/common/Makefile
@@ -11,5 +11,6 @@
 obj-y += cros_ec_sensors/
 obj-y += hid-sensors/
 obj-y += ms_sensors/
+obj-y += scmi_sensors/
 obj-y += ssp_sensors/
 obj-y += st_sensors/
diff --git a/drivers/iio/common/scmi_sensors/Kconfig b/drivers/iio/common/scmi_sensors/Kconfig
new file mode 100644
index 000000000000..67e084cbb1ab
--- /dev/null
+++ b/drivers/iio/common/scmi_sensors/Kconfig
@@ -0,0 +1,18 @@
+#
+# IIO over SCMI
+#
+# When adding new entries keep the list in alphabetical order
+
+menu "IIO SCMI Sensors"
+
+config IIO_SCMI
+	tristate "IIO SCMI"
+        depends on ARM_SCMI_PROTOCOL
+        select IIO_BUFFER
+        select IIO_KFIFO_BUF
+	help
+          Say yes here to build support for IIO SCMI Driver.
+          This provides ARM SCMI Protocol based IIO device.
+          This driver provides support for accelerometer and gyroscope
+          sensors available on SCMI based platforms.
+endmenu
diff --git a/drivers/iio/common/scmi_sensors/Makefile b/drivers/iio/common/scmi_sensors/Makefile
new file mode 100644
index 000000000000..f13140a2575a
--- /dev/null
+++ b/drivers/iio/common/scmi_sensors/Makefile
@@ -0,0 +1,5 @@
+# SPDX - License - Identifier : GPL - 2.0 - only
+#
+# Makefile for the IIO over SCMI
+#
+obj-$(CONFIG_IIO_SCMI) += scmi_iio.o
diff --git a/drivers/iio/common/scmi_sensors/scmi_iio.c b/drivers/iio/common/scmi_sensors/scmi_iio.c
new file mode 100644
index 000000000000..093b1fc24e27
--- /dev/null
+++ b/drivers/iio/common/scmi_sensors/scmi_iio.c
@@ -0,0 +1,673 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * System Control and Management Interface(SCMI) based IIO sensor driver
+ *
+ * Copyright (C) 2021 Google LLC
+ */
+
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/kfifo_buf.h>
+#include <linux/iio/sysfs.h>
+#include <linux/kernel.h>
+#include <linux/kthread.h>
+#include <linux/module.h>
+#include <linux/scmi_protocol.h>
+#include <linux/time.h>
+#include <linux/types.h>
+
+#define SCMI_IIO_NUM_OF_AXIS 3
+
+struct scmi_iio_priv {
+	struct scmi_handle *handle;
+	const struct scmi_sensor_info *sensor_info;
+	struct iio_dev *indio_dev;
+	/* adding one additional channel for timestamp */
+	long long iio_buf[SCMI_IIO_NUM_OF_AXIS + 1];
+	struct notifier_block sensor_update_nb;
+	u32 *freq_avail;
+};
+
+static int scmi_iio_sensor_update_cb(struct notifier_block *nb,
+				     unsigned long event, void *data)
+{
+	struct scmi_sensor_update_report *sensor_update = data;
+	struct iio_dev *scmi_iio_dev;
+	struct scmi_iio_priv *sensor;
+	s8 tstamp_scale;
+	u64 time, time_ns;
+	int i;
+
+	if (sensor_update->readings_count == 0)
+		return NOTIFY_DONE;
+
+	sensor = container_of(nb, struct scmi_iio_priv, sensor_update_nb);
+
+	for (i = 0; i < sensor_update->readings_count; i++)
+		sensor->iio_buf[i] = sensor_update->readings[i].value;
+
+	if (!sensor->sensor_info->timestamped) {
+		time_ns = ktime_to_ns(sensor_update->timestamp);
+	} else {
+		/*
+		 *  All the axes are supposed to have the same value for timestamp.
+		 *  We are just using the values from the Axis 0 here.
+		 */
+		time = sensor_update->readings[0].timestamp;
+
+		/*
+		 *  Timestamp returned by SCMI is in seconds and is equal to
+		 *  time * power-of-10 multiplier(tstamp_scale) seconds.
+		 *  Converting the timestamp to nanoseconds below.
+		 */
+		tstamp_scale = sensor->sensor_info->tstamp_scale +
+			       const_ilog2(NSEC_PER_SEC) / const_ilog2(10);
+		if (tstamp_scale < 0)
+			time_ns =
+				div64_u64(time, int_pow(10, abs(tstamp_scale)));
+		else
+			time_ns = time * int_pow(10, tstamp_scale);
+	}
+
+	scmi_iio_dev = sensor->indio_dev;
+	iio_push_to_buffers_with_timestamp(scmi_iio_dev, sensor->iio_buf,
+					   time_ns);
+	return NOTIFY_OK;
+}
+
+static int scmi_iio_buffer_preenable(struct iio_dev *iio_dev)
+{
+	struct scmi_iio_priv *sensor = iio_priv(iio_dev);
+	u32 sensor_id = sensor->sensor_info->id;
+	u32 sensor_config = 0;
+	int err;
+
+	if (sensor->sensor_info->timestamped)
+		sensor_config |= FIELD_PREP(SCMI_SENS_CFG_TSTAMP_ENABLED_MASK,
+					    SCMI_SENS_CFG_TSTAMP_ENABLE);
+
+	sensor_config |= FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK,
+				    SCMI_SENS_CFG_SENSOR_ENABLE);
+
+	err = sensor->handle->notify_ops->register_event_notifier(sensor->handle,
+			SCMI_PROTOCOL_SENSOR, SCMI_EVENT_SENSOR_UPDATE,
+			&sensor_id, &sensor->sensor_update_nb);
+	if (err) {
+		dev_err(&iio_dev->dev,
+			"Error in registering sensor update notifier for sensor %s err %d",
+			sensor->sensor_info->name, err);
+		return err;
+	}
+
+	err = sensor->handle->sensor_ops->config_set(sensor->handle,
+			sensor->sensor_info->id, sensor_config);
+	if (err) {
+		sensor->handle->notify_ops->unregister_event_notifier(sensor->handle,
+				SCMI_PROTOCOL_SENSOR,
+				SCMI_EVENT_SENSOR_UPDATE, &sensor_id,
+				&sensor->sensor_update_nb);
+		dev_err(&iio_dev->dev, "Error in enabling sensor %s err %d",
+			sensor->sensor_info->name, err);
+	}
+
+	return err;
+}
+
+static int scmi_iio_buffer_postdisable(struct iio_dev *iio_dev)
+{
+	struct scmi_iio_priv *sensor = iio_priv(iio_dev);
+	u32 sensor_id = sensor->sensor_info->id;
+	u32 sensor_config = 0;
+	int err;
+
+	sensor_config |= FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK,
+				    SCMI_SENS_CFG_SENSOR_DISABLE);
+
+	err = sensor->handle->notify_ops->unregister_event_notifier(sensor->handle,
+			SCMI_PROTOCOL_SENSOR, SCMI_EVENT_SENSOR_UPDATE,
+			&sensor_id, &sensor->sensor_update_nb);
+	if (err) {
+		dev_err(&iio_dev->dev,
+			"Error in unregistering sensor update notifier for sensor %s err %d",
+			sensor->sensor_info->name, err);
+		return err;
+	}
+
+	err = sensor->handle->sensor_ops->config_set(sensor->handle, sensor_id,
+						     sensor_config);
+	if (err) {
+		dev_err(&iio_dev->dev,
+			"Error in disabling sensor %s with err %d",
+			sensor->sensor_info->name, err);
+	}
+
+	return err;
+}
+
+static const struct iio_buffer_setup_ops scmi_iio_buffer_ops = {
+	.preenable = scmi_iio_buffer_preenable,
+	.postdisable = scmi_iio_buffer_postdisable,
+};
+
+static int scmi_iio_set_odr_val(struct iio_dev *iio_dev, int val, int val2)
+{
+	struct scmi_iio_priv *sensor = iio_priv(iio_dev);
+	const unsigned long UHZ_PER_HZ = 1000000UL;
+	u64 sec, mult, uHz;
+	u32 sensor_config;
+
+	int err = sensor->handle->sensor_ops->config_get(sensor->handle,
+			sensor->sensor_info->id, &sensor_config);
+	if (err) {
+		dev_err(&iio_dev->dev,
+			"Error in getting sensor config for sensor %s err %d",
+			sensor->sensor_info->name, err);
+		return err;
+	}
+
+	uHz = val * UHZ_PER_HZ + val2;
+
+	/*
+	 * The seconds field in the sensor interval in SCMI is 16 bits long
+	 * Therefore seconds  = 1/Hz <= 0xFFFF. As floating point calculations are
+	 * discouraged in the kernel driver code, to calculate the scale factor (sf)
+	 * (1* 1000000 * sf)/uHz <= 0xFFFF. Therefore, sf <= (uHz * 0xFFFF)/1000000
+	 */
+	mult = ilog2(((u64)uHz * 0xFFFF) / UHZ_PER_HZ) / const_ilog2(10);
+
+	sec = div64_u64(int_pow(10, mult) * UHZ_PER_HZ, uHz);
+	if (sec == 0) {
+		dev_err(&iio_dev->dev,
+			"Trying to set invalid sensor update value for sensor %s",
+			sensor->sensor_info->name);
+		return -EINVAL;
+	}
+
+	sensor_config &= ~SCMI_SENS_CFG_UPDATE_SECS_MASK;
+	sensor_config |= FIELD_PREP(SCMI_SENS_CFG_UPDATE_SECS_MASK, sec);
+	sensor_config &= ~SCMI_SENS_CFG_UPDATE_EXP_MASK;
+	sensor_config |= FIELD_PREP(SCMI_SENS_CFG_UPDATE_EXP_MASK, -mult);
+
+	if (sensor->sensor_info->timestamped) {
+		sensor_config &= ~SCMI_SENS_CFG_TSTAMP_ENABLED_MASK;
+		sensor_config |= FIELD_PREP(SCMI_SENS_CFG_TSTAMP_ENABLED_MASK,
+					    SCMI_SENS_CFG_TSTAMP_ENABLE);
+	}
+
+	sensor_config &= ~SCMI_SENS_CFG_ROUND_MASK;
+	sensor_config |=
+		FIELD_PREP(SCMI_SENS_CFG_ROUND_MASK, SCMI_SENS_CFG_ROUND_AUTO);
+
+	err = sensor->handle->sensor_ops->config_set(sensor->handle,
+			sensor->sensor_info->id, sensor_config);
+	if (err)
+		dev_err(&iio_dev->dev,
+			"Error in setting sensor update interval for sensor %s value %u err %d",
+			sensor->sensor_info->name, sensor_config, err);
+
+	return err;
+}
+
+static int scmi_iio_write_raw(struct iio_dev *iio_dev,
+			      struct iio_chan_spec const *chan, int val,
+			      int val2, long mask)
+{
+	int err;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		mutex_lock(&iio_dev->mlock);
+		err = scmi_iio_set_odr_val(iio_dev, val, val2);
+		mutex_unlock(&iio_dev->mlock);
+		return err;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int scmi_iio_read_avail(struct iio_dev *iio_dev,
+			       struct iio_chan_spec const *chan,
+			       const int **vals, int *type, int *length,
+			       long mask)
+{
+	struct scmi_iio_priv *sensor = iio_priv(iio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*vals = sensor->freq_avail;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		*length = sensor->sensor_info->intervals.count * 2;
+		if (sensor->sensor_info->intervals.segmented)
+			return IIO_AVAIL_RANGE;
+		else
+			return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static void convert_ns_to_freq(u64 interval_ns, u64 *hz, u64 *uhz)
+{
+	u64 rem;
+
+	*hz = div64_u64_rem(NSEC_PER_SEC, interval_ns, &rem);
+	*uhz = (rem * 1000000UL) / interval_ns;
+}
+
+static int scmi_iio_get_odr_val(struct iio_dev *iio_dev, int *val, int *val2)
+{
+	u64 sensor_update_interval, sensor_interval_mult, hz, uhz;
+	struct scmi_iio_priv *sensor = iio_priv(iio_dev);
+	u32 sensor_config;
+	int mult;
+
+	int err = sensor->handle->sensor_ops->config_get(sensor->handle,
+			sensor->sensor_info->id, &sensor_config);
+	if (err) {
+		dev_err(&iio_dev->dev,
+			"Error in getting sensor config for sensor %s err %d",
+			sensor->sensor_info->name, err);
+		return err;
+	}
+
+	sensor_update_interval =
+		SCMI_SENS_CFG_GET_UPDATE_SECS(sensor_config) * NSEC_PER_SEC;
+
+	mult = SCMI_SENS_CFG_GET_UPDATE_EXP(sensor_config);
+	if (mult < 0) {
+		sensor_interval_mult = int_pow(10, abs(mult));
+		sensor_update_interval =
+			sensor_update_interval / sensor_interval_mult;
+	} else {
+		sensor_interval_mult = int_pow(10, mult);
+		sensor_update_interval =
+			sensor_update_interval * sensor_interval_mult;
+	}
+
+	convert_ns_to_freq(sensor_update_interval, &hz, &uhz);
+	*val = hz;
+	*val2 = uhz;
+	return 0;
+}
+
+static int scmi_iio_read_raw(struct iio_dev *iio_dev,
+			     struct iio_chan_spec const *ch, int *val,
+			     int *val2, long mask)
+{
+	struct scmi_iio_priv *sensor = iio_priv(iio_dev);
+	s8 scale;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		scale = sensor->sensor_info->axis[ch->scan_index].scale;
+		if (scale < 0) {
+			*val = 1;
+			*val2 = int_pow(10, abs(scale));
+			return IIO_VAL_FRACTIONAL;
+		}
+		*val = int_pow(10, scale);
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret = scmi_iio_get_odr_val(iio_dev, val, val2);
+		return ret ? ret : IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info scmi_iio_info = {
+	.read_raw = scmi_iio_read_raw,
+	.read_avail = scmi_iio_read_avail,
+	.write_raw = scmi_iio_write_raw,
+};
+
+static ssize_t scmi_iio_get_raw_available(struct iio_dev *iio_dev,
+					  uintptr_t private,
+					  const struct iio_chan_spec *chan,
+					  char *buf)
+{
+	struct scmi_iio_priv *sensor = iio_priv(iio_dev);
+	unsigned long long resolution, rem;
+	long long min_range, max_range;
+	s8 exponent, scale;
+	int len = 0;
+
+	/*
+	 * All the axes are supposed to have the same value for range and resolution.
+	 * We are just using the values from the Axis 0 here.
+	 */
+	if (sensor->sensor_info->axis[0].extended_attrs) {
+		min_range = sensor->sensor_info->axis[0].attrs.min_range;
+		max_range = sensor->sensor_info->axis[0].attrs.max_range;
+		resolution = sensor->sensor_info->axis[0].resolution;
+		exponent = sensor->sensor_info->axis[0].exponent;
+		scale = sensor->sensor_info->axis[0].scale;
+
+		/*
+		 * To provide the raw value for the resolution to the userspace,
+		 * need to divide the resolution exponent by the sensor scale
+		 */
+		exponent = exponent - scale;
+		if (exponent < 0) {
+			resolution = div64_u64_rem(resolution,
+						   int_pow(10, abs(exponent)),
+						   &rem);
+			len = scnprintf(buf, PAGE_SIZE,
+					"[%lld %llu.%llu %lld]\n", min_range,
+					resolution, rem, max_range);
+		} else {
+			resolution = resolution * int_pow(10, exponent);
+			len = scnprintf(buf, PAGE_SIZE, "[%lld %llu %lld]\n",
+					min_range, resolution, max_range);
+		}
+	}
+	return len;
+}
+
+static const struct iio_chan_spec_ext_info scmi_iio_ext_info[] = {
+	{
+		.name = "raw_available",
+		.read = scmi_iio_get_raw_available,
+		.shared = IIO_SHARED_BY_TYPE,
+	},
+	{},
+};
+
+static void scmi_iio_set_timestamp_channel(struct iio_chan_spec *iio_chan,
+					   int scan_index)
+{
+	iio_chan->type = IIO_TIMESTAMP;
+	iio_chan->channel = -1;
+	iio_chan->scan_index = scan_index;
+	iio_chan->scan_type.sign = 'u';
+	iio_chan->scan_type.realbits = 64;
+	iio_chan->scan_type.storagebits = 64;
+}
+
+static void scmi_iio_set_data_channel(struct iio_chan_spec *iio_chan,
+				      enum iio_chan_type type,
+				      enum iio_modifier mod, int scan_index)
+{
+	iio_chan->type = type;
+	iio_chan->modified = 1;
+	iio_chan->channel2 = mod;
+	iio_chan->info_mask_separate = BIT(IIO_CHAN_INFO_SCALE);
+	iio_chan->info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ);
+	iio_chan->info_mask_shared_by_type_available =
+		BIT(IIO_CHAN_INFO_SAMP_FREQ);
+	iio_chan->scan_index = scan_index;
+	iio_chan->scan_type.sign = 's';
+	iio_chan->scan_type.realbits = 64;
+	iio_chan->scan_type.storagebits = 64;
+	iio_chan->scan_type.endianness = IIO_LE;
+	iio_chan->ext_info = scmi_iio_ext_info;
+}
+
+static int scmi_iio_get_chan_modifier(const char *name,
+				      enum iio_modifier *modifier)
+{
+	char *pch, mod;
+
+	if (!name)
+		return -EINVAL;
+
+	pch = strrchr(name, '_');
+	if (!pch)
+		return -EINVAL;
+
+	mod = *(pch + 1);
+	switch (mod) {
+	case 'X':
+		*modifier = IIO_MOD_X;
+		return 0;
+	case 'Y':
+		*modifier = IIO_MOD_Y;
+		return 0;
+	case 'Z':
+		*modifier = IIO_MOD_Z;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int scmi_iio_get_chan_type(u8 scmi_type, enum iio_chan_type *iio_type)
+{
+	switch (scmi_type) {
+	case METERS_SEC_SQUARED:
+		*iio_type = IIO_ACCEL;
+		return 0;
+	case RADIANS_SEC:
+		*iio_type = IIO_ANGL_VEL;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static u64 scmi_iio_convert_interval_to_ns(u32 val)
+{
+	u64 sensor_update_interval =
+		SCMI_SENS_INTVL_GET_SECS(val) * NSEC_PER_SEC;
+	u64 sensor_interval_mult;
+	int mult;
+
+	mult = SCMI_SENS_INTVL_GET_EXP(val);
+	if (mult < 0) {
+		sensor_interval_mult = int_pow(10, abs(mult));
+		sensor_update_interval =
+			sensor_update_interval / sensor_interval_mult;
+	} else {
+		sensor_interval_mult = int_pow(10, mult);
+		sensor_update_interval =
+			sensor_update_interval * sensor_interval_mult;
+	}
+	return sensor_update_interval;
+}
+
+static int scmi_iio_set_sampling_freq_avail(struct iio_dev *iio_dev)
+{
+	u64 cur_interval_ns, low_interval_ns, high_interval_ns, step_size_ns,
+		hz, uhz;
+	unsigned int cur_interval, low_interval, high_interval, step_size;
+	struct scmi_iio_priv *sensor = iio_priv(iio_dev);
+	int i;
+
+	sensor->freq_avail =
+		devm_kzalloc(&iio_dev->dev,
+			     sizeof(*sensor->freq_avail) *
+				     (sensor->sensor_info->intervals.count * 2),
+			     GFP_KERNEL);
+	if (!sensor->freq_avail)
+		return -ENOMEM;
+
+	if (sensor->sensor_info->intervals.segmented) {
+		low_interval = sensor->sensor_info->intervals
+				       .desc[SCMI_SENS_INTVL_SEGMENT_LOW];
+		low_interval_ns = scmi_iio_convert_interval_to_ns(low_interval);
+		convert_ns_to_freq(low_interval_ns, &hz, &uhz);
+		sensor->freq_avail[0] = hz;
+		sensor->freq_avail[1] = uhz;
+
+		step_size = sensor->sensor_info->intervals
+				    .desc[SCMI_SENS_INTVL_SEGMENT_STEP];
+		step_size_ns = scmi_iio_convert_interval_to_ns(step_size);
+		convert_ns_to_freq(step_size_ns, &hz, &uhz);
+		sensor->freq_avail[2] = hz;
+		sensor->freq_avail[3] = uhz;
+
+		high_interval = sensor->sensor_info->intervals
+					.desc[SCMI_SENS_INTVL_SEGMENT_HIGH];
+		high_interval_ns =
+			scmi_iio_convert_interval_to_ns(high_interval);
+		convert_ns_to_freq(high_interval_ns, &hz, &uhz);
+		sensor->freq_avail[4] = hz;
+		sensor->freq_avail[5] = uhz;
+	} else {
+		for (i = 0; i < sensor->sensor_info->intervals.count; i++) {
+			cur_interval = sensor->sensor_info->intervals.desc[i];
+			cur_interval_ns =
+				scmi_iio_convert_interval_to_ns(cur_interval);
+			convert_ns_to_freq(cur_interval_ns, &hz, &uhz);
+			sensor->freq_avail[i * 2] = hz;
+			sensor->freq_avail[i * 2 + 1] = uhz;
+		}
+	}
+	return 0;
+}
+
+static int scmi_iio_buffers_setup(struct iio_dev *scmi_iiodev)
+{
+	struct iio_buffer *buffer;
+
+	buffer = devm_iio_kfifo_allocate(&scmi_iiodev->dev);
+	if (!buffer)
+		return -ENOMEM;
+
+	iio_device_attach_buffer(scmi_iiodev, buffer);
+	scmi_iiodev->modes |= INDIO_BUFFER_SOFTWARE;
+	scmi_iiodev->setup_ops = &scmi_iio_buffer_ops;
+	return 0;
+}
+
+struct iio_dev *scmi_alloc_iiodev(struct device *dev,
+				  struct scmi_handle *handle,
+				  const struct scmi_sensor_info *sensor_info)
+{
+	struct iio_chan_spec *iio_channels;
+	struct scmi_iio_priv *sensor;
+	enum iio_modifier modifier;
+	enum iio_chan_type type;
+	struct iio_dev *iiodev;
+	int i, ret;
+
+	iiodev = devm_iio_device_alloc(dev, sizeof(*sensor));
+	if (!iiodev)
+		return ERR_PTR(-ENOMEM);
+
+	iiodev->modes = INDIO_DIRECT_MODE;
+	iiodev->dev.parent = dev;
+	sensor = iio_priv(iiodev);
+	sensor->handle = handle;
+	sensor->sensor_info = sensor_info;
+	sensor->sensor_update_nb.notifier_call = scmi_iio_sensor_update_cb;
+	sensor->indio_dev = iiodev;
+
+	/* adding one additional channel for timestamp */
+	iiodev->num_channels = sensor_info->num_axis + 1;
+	iiodev->name = sensor_info->name;
+	iiodev->info = &scmi_iio_info;
+
+	iio_channels =
+		devm_kzalloc(dev,
+			     sizeof(*iio_channels) * (iiodev->num_channels),
+			     GFP_KERNEL);
+	if (!iio_channels)
+		return ERR_PTR(-ENOMEM);
+
+	scmi_iio_set_sampling_freq_avail(iiodev);
+
+	for (i = 0; i < sensor_info->num_axis; i++) {
+		ret = scmi_iio_get_chan_type(sensor_info->axis[i].type, &type);
+		if (ret < 0)
+			return ERR_PTR(ret);
+
+		ret = scmi_iio_get_chan_modifier(sensor_info->axis[i].name,
+						 &modifier);
+		if (ret < 0)
+			return ERR_PTR(ret);
+
+		scmi_iio_set_data_channel(&iio_channels[i], type, modifier,
+					  sensor_info->axis[i].id);
+	}
+
+	scmi_iio_set_timestamp_channel(&iio_channels[i], i);
+	iiodev->channels = iio_channels;
+	return iiodev;
+}
+
+static int scmi_iio_dev_probe(struct scmi_device *sdev)
+{
+	const struct scmi_sensor_info *sensor_info;
+	struct scmi_handle *handle = sdev->handle;
+	struct device *dev = &sdev->dev;
+	struct iio_dev *scmi_iio_dev;
+	u16 nr_sensors;
+	int err = -ENODEV, i;
+
+	if (!handle || !handle->sensor_ops) {
+		dev_err(dev, "SCMI device has no sensor interface\n");
+		return -EINVAL;
+	}
+
+	nr_sensors = handle->sensor_ops->count_get(handle);
+	if (!nr_sensors) {
+		dev_dbg(dev, "0 sensors found via SCMI bus\n");
+		return -ENODEV;
+	}
+
+	for (i = 0; i < nr_sensors; i++) {
+		sensor_info = handle->sensor_ops->info_get(handle, i);
+		if (!sensor_info) {
+			dev_err(dev, "SCMI sensor %d has missing info\n", i);
+			return -EINVAL;
+		}
+
+		/* This driver only supports 3-axis accel and gyro, skipping other sensors */
+		if (sensor_info->num_axis != SCMI_IIO_NUM_OF_AXIS)
+			continue;
+
+		/* This driver only supports 3-axis accel and gyro, skipping other sensors */
+		if (sensor_info->axis[0].type != METERS_SEC_SQUARED &&
+		    sensor_info->axis[0].type != RADIANS_SEC)
+			continue;
+
+		scmi_iio_dev = scmi_alloc_iiodev(dev, handle, sensor_info);
+		if (IS_ERR(scmi_iio_dev)) {
+			dev_err(dev,
+				"failed to allocate IIO device for sensor %s: %ld\n",
+				sensor_info->name, PTR_ERR(scmi_iio_dev));
+			return PTR_ERR(scmi_iio_dev);
+		}
+
+		err = scmi_iio_buffers_setup(scmi_iio_dev);
+		if (err < 0) {
+			dev_err(dev,
+				"IIO buffer setup error at sensor %s: %d\n",
+				sensor_info->name, err);
+			return err;
+		}
+
+		err = devm_iio_device_register(dev, scmi_iio_dev);
+		if (err) {
+			dev_err(dev,
+				"IIO device registration failed at sensor %s: %d\n",
+				sensor_info->name, err);
+			return err;
+		}
+	}
+	return err;
+}
+
+static const struct scmi_device_id scmi_id_table[] = {
+	{ SCMI_PROTOCOL_SENSOR, "iiodev" },
+	{},
+};
+
+MODULE_DEVICE_TABLE(scmi, scmi_id_table);
+
+static struct scmi_driver scmi_iiodev_driver = {
+	.name = "scmi-sensor-iiodev",
+	.probe = scmi_iio_dev_probe,
+	.id_table = scmi_id_table,
+};
+
+module_scmi_driver(scmi_iiodev_driver);
+
+MODULE_AUTHOR("Jyoti Bhayana <jbhayana@google.com>");
+MODULE_DESCRIPTION("SCMI IIO Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.30.0.478.g8a0d178c01-goog

