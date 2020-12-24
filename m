Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9952E2402
	for <lists+linux-iio@lfdr.de>; Thu, 24 Dec 2020 04:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728867AbgLXDUJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 23 Dec 2020 22:20:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728631AbgLXDUJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 23 Dec 2020 22:20:09 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAA6C0617A6
        for <linux-iio@vger.kernel.org>; Wed, 23 Dec 2020 19:19:28 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id z20so702258pgh.18
        for <linux-iio@vger.kernel.org>; Wed, 23 Dec 2020 19:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=+yp3vlugAyf3FntIi+rN49mHkzgLy5xGOOK1CUFv56I=;
        b=KP2tESbKAwXNZ8dFk9kdk1JrVQE4gox+cQ/V9cyDTbVuvk7uI4BdoWoRYprMxtOfLV
         8kUQqSzNM1g7qHaGktZcP0eAKeCJxCrZoI/4HrZE1UQhdFglMcbe1oHS8+mKXtXJIInY
         HsCMshjsOwGXy1Y4II9fskzxzis9n5WcTSzLl4naMeFq9pvdkXcq2qFg8McqwsRmnwFV
         MNhtYCcnOoyCHNaQQiEF1AO2vA4MTqx1BTraqivPcdgdxr8r7h9ycSlhEVdEsnl02QsU
         GVnwEKZJw4DSoH0lrMYFr75FAnWt9+ErF32uwR5kLTQn9S/DQUJVDV9krjElVyK4fsUr
         SDBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+yp3vlugAyf3FntIi+rN49mHkzgLy5xGOOK1CUFv56I=;
        b=Qm1fHEt530kFKNfFYfiujsP2Nm8oqTKWFiKLRuG2otZoq2lYgHexwNYd2h2xdlh36u
         tfehcJM1QgDc5bw+5b3FvpwADzdaD+VaLH9gx7UTgewCw3k/QP/ptgIfjsmspD4WcH6q
         GwAUTqt3y5pT9x37e5CIR7G8USXIv9YeKTtTJjZof3prFDFGI+7pCeY3Z8eZlPW70lO+
         +M2MJMyTegkFsMTG9rAK8UFYWe9eOGnS744pSVyBxJysNzMIrTRVaZOiV+c5RB93fxBD
         FXZK+Piv2P64S8iSUczSaKG+/kUrlx3LGm4H1Gl9+D3QTafelAGMwBnhPtT92FtMf+PE
         No2A==
X-Gm-Message-State: AOAM533IemtkbRVyOA7rQJMdapX8TXLBRTTDJoE4bR1IlaV2x8Uh3PWU
        aW4pCUzJRLKNlRn4ZAGqNI+dQUwNcrDVGw==
X-Google-Smtp-Source: ABdhPJxDk4pR5+iXrSFVyO0vg8u97tm91dAPPLMh22Qr1dSUbnwtJK5PdZ9sreiCVDGCx59M0nrV2jUQlxlI/w==
Sender: "jbhayana via sendgmr" <jbhayana@jbhayana.c.googlers.com>
X-Received: from jbhayana.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:42b2])
 (user=jbhayana job=sendgmr) by 2002:a17:902:c583:b029:da:b32c:cf9f with SMTP
 id p3-20020a170902c583b02900dab32ccf9fmr27773961plx.44.1608779968142; Wed, 23
 Dec 2020 19:19:28 -0800 (PST)
Date:   Thu, 24 Dec 2020 03:19:21 +0000
In-Reply-To: <20201224031921.1547519-1-jbhayana@google.com>
Message-Id: <20201224031921.1547519-2-jbhayana@google.com>
Mime-Version: 1.0
References: <20201224031921.1547519-1-jbhayana@google.com>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [RFC PATCH v2 1/1] iio/scmi: Adding support for IIO SCMI Based Sensors
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
new SCMI Sensor Protocol defined by the upcoming SCMIv3.0
ARM specification

Signed-off-by: Jyoti Bhayana <jbhayana@google.com>
---
 MAINTAINERS                                |   6 +
 drivers/iio/common/Kconfig                 |   1 +
 drivers/iio/common/Makefile                |   1 +
 drivers/iio/common/scmi_sensors/Kconfig    |  18 +
 drivers/iio/common/scmi_sensors/Makefile   |   5 +
 drivers/iio/common/scmi_sensors/scmi_iio.c | 696 +++++++++++++++++++++
 6 files changed, 727 insertions(+)
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
index 000000000000..2f5c884e22ab
--- /dev/null
+++ b/drivers/iio/common/scmi_sensors/scmi_iio.c
@@ -0,0 +1,696 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * System Control and Management Interface(SCMI) based IIO sensor driver
+ *
+ * Copyright (C) 2020 Google LLC
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
+#define NSEC_MULT_POW_10 (const_ilog2(NSEC_PER_SEC) / const_ilog2(10))
+#define UHZ_PER_HZ 1000000UL
+#define ODR_EXPAND(odr, uodr) (((odr)*1000000ULL) + (uodr))
+#define MAX_NUM_OF_CHANNELS 4
+
+struct scmi_iio_priv {
+	struct scmi_handle *handle;
+	const struct scmi_sensor_info *sensor_info;
+	struct iio_dev *indio_dev;
+	long long iio_buf[MAX_NUM_OF_CHANNELS];
+	struct notifier_block sensor_update_nb;
+	u32 *freq_avail;
+};
+
+struct sensor_freq {
+	u64 hz;
+	u64 uhz;
+};
+
+static int sensor_update_cb(struct notifier_block *nb, unsigned long event,
+			    void *data)
+{
+	struct scmi_sensor_update_report *sensor_update = data;
+	u64 time, time_ns;
+	s64 sensor_value;
+	struct iio_dev *scmi_iio_dev;
+	s8 tstamp_scale_ns;
+	int i;
+	struct scmi_iio_priv *sensor =
+		container_of(nb, struct scmi_iio_priv, sensor_update_nb);
+
+	scmi_iio_dev = sensor->indio_dev;
+
+	for (i = 0; i < sensor_update->readings_count; i++) {
+		sensor_value = sensor_update->readings[i].value;
+		time = sensor_update->readings[i].timestamp;
+		sensor->iio_buf[i] = sensor_value;
+	}
+
+	if (!sensor->sensor_info->timestamped) {
+		time_ns = iio_get_time_ns(scmi_iio_dev);
+	} else {
+		tstamp_scale_ns =
+			sensor->sensor_info->tstamp_scale + NSEC_MULT_POW_10;
+		if (tstamp_scale_ns < 0) {
+			tstamp_scale_ns = -1 * tstamp_scale_ns;
+			time_ns = div64_u64(time, int_pow(10, tstamp_scale_ns));
+		} else {
+			time_ns = time * int_pow(10, tstamp_scale_ns);
+		}
+	}
+
+	iio_push_to_buffers_with_timestamp(scmi_iio_dev, sensor->iio_buf,
+					   time_ns);
+
+	return NOTIFY_OK;
+}
+
+static int scmi_iio_buffer_preenable(struct iio_dev *dev)
+{
+	struct scmi_iio_priv *sensor = iio_priv(dev);
+	u32 sensor_id = sensor->sensor_info->id;
+	u32 sensor_config;
+	int err;
+
+	if (sensor->sensor_info->timestamped)
+		sensor_config |= FIELD_PREP(SCMI_SENS_CFG_TSTAMP_ENABLED_MASK,
+					    SCMI_SENS_CFG_TSTAMP_ENABLE);
+
+	sensor_config |= FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK,
+				    SCMI_SENS_CFG_SENSOR_ENABLE);
+
+	err = sensor->handle->notify_ops->register_event_notifier(
+		sensor->handle, SCMI_PROTOCOL_SENSOR, SCMI_EVENT_SENSOR_UPDATE,
+		&sensor_id, &sensor->sensor_update_nb);
+	if (err) {
+		pr_err("Error in registering sensor update notifier for sensor %s err %d",
+		       sensor->sensor_info->name, err);
+		return err;
+	}
+
+	err = sensor->handle->sensor_ops->config_set(
+		sensor->handle, sensor->sensor_info->id, sensor_config);
+	if (err)
+		pr_err("Error in enabling sensor %s err %d",
+		       sensor->sensor_info->name, err);
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
+	err = sensor->handle->notify_ops->unregister_event_notifier(
+		sensor->handle, SCMI_PROTOCOL_SENSOR, SCMI_EVENT_SENSOR_UPDATE,
+		&sensor_id, &sensor->sensor_update_nb);
+	if (err) {
+		pr_err("Error in unregistering sensor update notifier for sensor %s err %d",
+		       sensor->sensor_info->name, err);
+		return err;
+	}
+
+	err = sensor->handle->sensor_ops->config_set(sensor->handle, sensor_id,
+						     sensor_config);
+	if (err)
+		pr_err("Error in disabling sensor %s with err %d",
+		       sensor->sensor_info->name, err);
+
+	return err;
+}
+
+static const struct iio_buffer_setup_ops scmi_iio_buffer_ops = {
+	.preenable = scmi_iio_buffer_preenable,
+	.postdisable = scmi_iio_buffer_postdisable,
+};
+
+static int scmi_iio_read_avail(struct iio_dev *iio_dev,
+					 struct iio_chan_spec const *chan,
+					 const int **vals,
+					 int *type, int *length, long mask)
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
+static int scmi_iio_set_odr_val(struct iio_dev *iio_dev, int val, int val2)
+{
+	struct scmi_iio_priv *sensor = iio_priv(iio_dev);
+	u32 sensor_config;
+	u64 sec, mult, uHz;
+	char buf[32];
+
+	int err = sensor->handle->sensor_ops->config_get(
+		sensor->handle, sensor->sensor_info->id, &sensor_config);
+	if (err) {
+		pr_err("%s: Error in getting sensor config for sensor %s err %d",
+		       __func__, sensor->sensor_info->name, err);
+		return err;
+	}
+
+	uHz = ODR_EXPAND(val, val2);
+
+	/*
+	 * The seconds field in the sensor interval in SCMI is 16 bits long
+	 * Therefore seconds  = 1/Hz <= 0xFFFF. As floating point calculations are
+	 * discouraged in the kernel driver code, to calculate the scale factor (sf)
+	 * (1* 1000000 * sf)/uHz <= 0xFFFF. Therefore, sf <= (uHz * 0xFFFF)/1000000
+	 *  To calculate the multiplier,we convert the sf into char string  and
+	 *  count the number of characters
+	 */
+
+	mult = scnprintf(buf, 32, "%llu", ((u64)uHz * 0xFFFF) / UHZ_PER_HZ) - 1;
+
+	sec = div64_u64(int_pow(10, mult) * UHZ_PER_HZ, uHz);
+	if (sec == 0) {
+		pr_err("Trying to set invalid sensor update value for sensor %s",
+		       sensor->sensor_info->name);
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
+	sensor_config |= FIELD_PREP(SCMI_SENS_CFG_ROUND_MASK, SCMI_SENS_CFG_ROUND_AUTO);
+
+	err = sensor->handle->sensor_ops->config_set(
+		sensor->handle, sensor->sensor_info->id, sensor_config);
+	if (err)
+		pr_err("Error in setting sensor update interval for sensor %s value %u err %d",
+		       sensor->sensor_info->name, sensor_config, err);
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
+	mutex_lock(&iio_dev->mlock);
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		err = scmi_iio_set_odr_val(iio_dev, val, val2);
+		break;
+	default:
+		err = -EINVAL;
+		break;
+	}
+	mutex_unlock(&iio_dev->mlock);
+
+	return err;
+}
+
+static u64 convert_interval_to_ns(u32 val)
+{
+	u64 sensor_interval_mult;
+	u64 sensor_update_interval = SCMI_SENS_INTVL_GET_SECS(val) * NSEC_PER_SEC;
+
+	int mult = SCMI_SENS_INTVL_GET_EXP(val);
+
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
+	return sensor_update_interval;
+}
+
+static void convert_ns_to_freq(u64 interval_ns, struct sensor_freq *freq)
+{
+	u64 rem;
+
+	freq->hz = div64_u64_rem(NSEC_PER_SEC, interval_ns, &rem);
+	freq->uhz = (rem * 1000000UL) / interval_ns;
+}
+
+static int scmi_iio_get_odr_val(struct iio_dev *iio_dev, int *val, int *val2)
+{
+	struct scmi_iio_priv *sensor = iio_priv(iio_dev);
+	u32 sensor_config;
+	struct sensor_freq freq;
+	u64 sensor_update_interval, sensor_interval_mult;
+	int mult;
+
+	int err = sensor->handle->sensor_ops->config_get(
+		sensor->handle, sensor->sensor_info->id, &sensor_config);
+	if (err) {
+		pr_err("%s: Error in getting sensor config for sensor %s err %d",
+		       __func__, sensor->sensor_info->name, err);
+		return err;
+	}
+
+	sensor_update_interval = SCMI_SENS_CFG_GET_UPDATE_SECS(sensor_config) * NSEC_PER_SEC;
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
+	convert_ns_to_freq(sensor_update_interval, &freq);
+	*val = freq.hz;
+	*val2 = freq.uhz;
+
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
+			scale = -scale;
+			*val = 1;
+			*val2 = int_pow(10, scale);
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
+
+	return 0;
+}
+
+static ssize_t scmi_iio_get_sensor_power(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct scmi_iio_priv *sensor = iio_priv(dev_get_drvdata(dev));
+	int len;
+
+	if (sensor->sensor_info->extended_scalar_attrs)
+		len = scnprintf(buf, PAGE_SIZE, "%u\n",
+				sensor->sensor_info->sensor_power);
+
+	return len;
+}
+
+static ssize_t scmi_iio_get_sensor_max_range(struct device *dev,
+					     struct device_attribute *attr,
+					     char *buf)
+{
+	struct scmi_iio_priv *sensor = iio_priv(dev_get_drvdata(dev));
+	int i;
+	s64 max_range = S64_MIN, max_range_axis;
+
+	for (i = 0; i < sensor->sensor_info->num_axis; i++) {
+		if (sensor->sensor_info->axis[i].extended_attrs) {
+			max_range_axis =
+				sensor->sensor_info->axis[i].attrs.max_range;
+			max_range = max(max_range, max_range_axis);
+		}
+	}
+
+	return scnprintf(buf, PAGE_SIZE, "%lld\n", max_range);
+}
+
+static ssize_t scmi_iio_get_sensor_resolution(struct device *dev,
+					      struct device_attribute *attr,
+					      char *buf)
+{
+	struct scmi_iio_priv *sensor = iio_priv(dev_get_drvdata(dev));
+	int len;
+
+	/*
+	 * All the axes are supposed to have the same value for resolution
+	 * and exponent. We are just using the values from the Axis 0 here.
+	 */
+
+	if (sensor->sensor_info->axis[0].extended_attrs) {
+		u32 resolution = sensor->sensor_info->axis[0].resolution;
+		s8 exponent = sensor->sensor_info->axis[0].exponent;
+		u32 multiplier = int_pow(10, abs(exponent));
+
+		if (exponent < 0) {
+			int vals[] = { resolution, multiplier };
+
+			len = iio_format_value(buf, IIO_VAL_FRACTIONAL,
+					       ARRAY_SIZE(vals), vals);
+		} else {
+			int vals[] = { resolution * multiplier };
+
+			len = iio_format_value(buf, IIO_VAL_INT,
+					       ARRAY_SIZE(vals), vals);
+		}
+	}
+
+	return len;
+}
+
+static IIO_DEVICE_ATTR(sensor_power, 0444, scmi_iio_get_sensor_power, NULL, 0);
+static IIO_DEVICE_ATTR(sensor_max_range, 0444, scmi_iio_get_sensor_max_range,
+		       NULL, 0);
+static IIO_DEVICE_ATTR(sensor_resolution, 0444, scmi_iio_get_sensor_resolution,
+		       NULL, 0);
+
+static struct attribute *scmi_iio_attributes[] = {
+	&iio_dev_attr_sensor_power.dev_attr.attr,
+	&iio_dev_attr_sensor_max_range.dev_attr.attr,
+	&iio_dev_attr_sensor_resolution.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group scmi_iio_attribute_group = {
+	.attrs = scmi_iio_attributes,
+};
+
+static const struct iio_info scmi_iio_info = {
+	.read_raw = scmi_iio_read_raw,
+	.read_avail = scmi_iio_read_avail,
+	.write_raw = scmi_iio_write_raw,
+	.attrs = &scmi_iio_attribute_group,
+};
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
+static int scmi_iio_get_chan_modifier(const char *name,
+				      enum iio_modifier *modifier)
+{
+	int ret;
+	char *pch = strrchr(name, '_');
+
+	if (!pch)
+		return -EINVAL;
+
+	if (strcmp(pch + 1, "X") == 0)
+		*modifier = IIO_MOD_X;
+	else if (strcmp(pch + 1, "Y") == 0)
+		*modifier = IIO_MOD_Y;
+	else if (strcmp(pch + 1, "Z") == 0)
+		*modifier = IIO_MOD_Z;
+	else
+		return -EINVAL;
+
+	return ret;
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
+	iio_chan->info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SAMP_FREQ);
+	iio_chan->scan_index = scan_index;
+	iio_chan->scan_type.sign = 's';
+	iio_chan->scan_type.realbits = 64;
+	iio_chan->scan_type.storagebits = 64;
+	iio_chan->scan_type.endianness = IIO_LE;
+}
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
+static int set_sampling_freq_avail(struct iio_dev *iio_dev)
+{
+	struct scmi_iio_priv *sensor = iio_priv(iio_dev);
+	int i;
+	struct sensor_freq freq;
+	u64 cur_interval_ns, low_interval_ns, high_interval_ns, step_size_ns;
+	unsigned int low_interval, high_interval, step_size;
+
+	sensor->freq_avail =  devm_kzalloc(&iio_dev->dev,
+					sizeof(u32) * (sensor->sensor_info->intervals.count * 2),
+					GFP_KERNEL);
+	if (!sensor->freq_avail)
+		return -ENOMEM;
+
+	if (sensor->sensor_info->intervals.segmented) {
+		low_interval = sensor->sensor_info->intervals.desc[SCMI_SENS_INTVL_SEGMENT_LOW];
+		low_interval_ns = convert_interval_to_ns(low_interval);
+		convert_ns_to_freq(low_interval_ns, &freq);
+		sensor->freq_avail[0] = freq.hz;
+		sensor->freq_avail[1] = freq.uhz;
+
+		step_size = sensor->sensor_info->intervals.desc[SCMI_SENS_INTVL_SEGMENT_STEP];
+		step_size_ns = convert_interval_to_ns(step_size);
+		convert_ns_to_freq(step_size_ns, &freq);
+		sensor->freq_avail[2] = freq.hz;
+		sensor->freq_avail[3] = freq.uhz;
+
+		high_interval = sensor->sensor_info->intervals.desc[SCMI_SENS_INTVL_SEGMENT_HIGH];
+		high_interval_ns = convert_interval_to_ns(high_interval);
+		convert_ns_to_freq(high_interval_ns, &freq);
+		sensor->freq_avail[4] = freq.hz;
+		sensor->freq_avail[5] = freq.uhz;
+	} else {
+		for (i = 0; i < sensor->sensor_info->intervals.count; i++) {
+			cur_interval_ns = convert_interval_to_ns
+						(sensor->sensor_info->intervals.desc[i]);
+			convert_ns_to_freq(cur_interval_ns, &freq);
+			sensor->freq_avail[i*2] = freq.hz;
+			sensor->freq_avail[i*2+1] = freq.uhz;
+		}
+	}
+
+	return 0;
+}
+
+static int scmi_iio_buffers_setup(struct iio_dev *scmi_iiodev)
+{
+	struct iio_buffer *buffer = devm_iio_kfifo_allocate(&scmi_iiodev->dev);
+
+	if (!buffer)
+		return -ENOMEM;
+
+	iio_device_attach_buffer(scmi_iiodev, buffer);
+	scmi_iiodev->modes |= INDIO_BUFFER_SOFTWARE;
+	scmi_iiodev->setup_ops = &scmi_iio_buffer_ops;
+
+	return 0;
+}
+
+static int scmi_alloc_iiodev(struct device *dev, struct scmi_handle *handle,
+			     const struct scmi_sensor_info *sensor_info,
+			     struct iio_dev **scmi_iio_dev)
+{
+	struct scmi_iio_priv *sensor;
+	struct iio_chan_spec *iio_channels;
+	enum iio_chan_type type;
+	enum iio_modifier modifier;
+	struct iio_dev *iiodev;
+	int i, ret;
+
+	iiodev = devm_iio_device_alloc(dev, sizeof(*sensor));
+	if (!iiodev)
+		return -ENOMEM;
+
+	iiodev->modes = INDIO_DIRECT_MODE;
+	iiodev->dev.parent = dev;
+	sensor = iio_priv(iiodev);
+	sensor->handle = handle;
+	sensor->sensor_info = sensor_info;
+	sensor->sensor_update_nb.notifier_call = sensor_update_cb;
+	sensor->indio_dev = iiodev;
+	iiodev->num_channels =
+		sensor_info->num_axis +
+		1; /* adding one additional channel for timestamp */
+	iiodev->name = sensor_info->name;
+	iiodev->info = &scmi_iio_info;
+
+	iio_channels =
+		devm_kzalloc(dev,
+			     sizeof(*iio_channels) * (iiodev->num_channels),
+			     GFP_KERNEL);
+	if (!iio_channels)
+		return -ENOMEM;
+
+	for (i = 0; i < sensor_info->num_axis; i++) {
+		ret = scmi_iio_get_chan_type(sensor_info->axis[i].type, &type);
+		if (ret < 0)
+			return ret;
+
+		ret = scmi_iio_get_chan_modifier(sensor_info->axis[i].name,
+						 &modifier);
+		if (ret < 0)
+			return ret;
+
+		scmi_iio_set_data_channel(&iio_channels[i], type, modifier,
+					  sensor_info->axis[i].id);
+	}
+
+	scmi_iio_set_timestamp_channel(&iio_channels[i], i);
+	iiodev->channels = iio_channels;
+
+	ret = set_sampling_freq_avail(iiodev);
+	if (ret < 0)
+		return ret;
+
+	*scmi_iio_dev = iiodev;
+
+	return ret;
+}
+
+static int scmi_iio_dev_probe(struct scmi_device *sdev)
+{
+	struct iio_dev *scmi_iio_dev;
+	const struct scmi_sensor_info *sensor_info;
+	int err, i;
+	u16 nr_sensors;
+	struct device *dev = &sdev->dev;
+	struct scmi_handle *handle = sdev->handle;
+
+	if (!handle || !handle->sensor_ops || !handle->sensor_ops->count_get ||
+	    !handle->sensor_ops->info_get || !handle->sensor_ops->config_get ||
+	    !handle->sensor_ops->config_set) {
+		dev_err(dev, "SCMI device has no sensor interface\n");
+		return -EINVAL;
+	}
+
+	nr_sensors = handle->sensor_ops->count_get(handle);
+	if (!nr_sensors) {
+		dev_dbg(dev, "0 sensors found via SCMI bus\n");
+		return -EINVAL;
+	}
+
+	dev_dbg(dev, "%d sensors found via SCMI bus\n", nr_sensors);
+
+	for (i = 0; i < nr_sensors; i++) {
+		sensor_info = handle->sensor_ops->info_get(handle, i);
+		if (!sensor_info) {
+			dev_err(dev, "SCMI sensor %d has missing info\n", i);
+			return -EINVAL;
+		}
+
+		/* Skipping scalar sensor,as this driver only supports accel and gyro */
+		if (sensor_info->num_axis == 0)
+			continue;
+
+		err = scmi_alloc_iiodev(dev, handle, sensor_info,
+					&scmi_iio_dev);
+		if (err < 0) {
+			dev_err(dev,
+				"failed to allocate IIO device for sensor %s: %d\n",
+				sensor_info->name, err);
+			return err;
+		}
+		if (!scmi_iio_dev) {
+			dev_err(dev, "memory allocation failed at sensor %s\n",
+				sensor_info->name);
+			return -ENOMEM;
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
+
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
2.29.2.729.g45daf8777d-goog

