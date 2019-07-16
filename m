Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5AC66A4A4
	for <lists+linux-iio@lfdr.de>; Tue, 16 Jul 2019 11:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731581AbfGPJLd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Jul 2019 05:11:33 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58784 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727889AbfGPJLd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 16 Jul 2019 05:11:33 -0400
Received: from laptop.home (unknown [IPv6:2a01:cb19:8da1:9c00:f43f:8285:c795:bffa])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: aragua)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id B4BD828B84E;
        Tue, 16 Jul 2019 10:11:30 +0100 (BST)
From:   Fabien Lahoudere <fabien.lahoudere@collabora.com>
Cc:     kernel@collabora.com,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        Nick Vaccaro <nvaccaro@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/1] iio: common: cros_ec_sensors: Expose cros_ec_sensors frequency range via iio sysfs
Date:   Tue, 16 Jul 2019 11:11:06 +0200
Message-Id: <36eda13de50426c1b5e46a201e17122f9d899f1a.1563268064.git.fabien.lahoudere@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1563268064.git.fabien.lahoudere@collabora.com>
References: <cover.1563268064.git.fabien.lahoudere@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Embedded controller return minimum and maximum frequencies, unfortunately
we have no way to know the step for all available frequencies.
Even if not complete, we can return a list of known values using the
standard read_avail callback (IIO_CHAN_INFO_SAMP_FREQ) to provide them to
userland.

Now cros_ec_* sensors provides frequencies values in sysfs like this:
"0 min max". 0 is always true to disable the sensor.

Default frequencies are provided for earlier protocol.

Signed-off-by: Nick Vaccaro <nvaccaro@chromium.org>
Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 .../common/cros_ec_sensors/cros_ec_sensors.c  |  3 +
 .../cros_ec_sensors/cros_ec_sensors_core.c    | 65 +++++++++++++++++++
 drivers/iio/light/cros_ec_light_prox.c        |  3 +
 .../linux/iio/common/cros_ec_sensors_core.h   | 21 ++++++
 4 files changed, 92 insertions(+)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
index 17af4e0fd5f8..dbca02688c4f 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
@@ -175,6 +175,7 @@ static int cros_ec_sensors_write(struct iio_dev *indio_dev,
 static const struct iio_info ec_sensors_info = {
 	.read_raw = &cros_ec_sensors_read,
 	.write_raw = &cros_ec_sensors_write,
+	.read_avail = &cros_ec_sensors_core_read_avail,
 };
 
 static int cros_ec_sensors_probe(struct platform_device *pdev)
@@ -211,6 +212,8 @@ static int cros_ec_sensors_probe(struct platform_device *pdev)
 			BIT(IIO_CHAN_INFO_SCALE) |
 			BIT(IIO_CHAN_INFO_FREQUENCY) |
 			BIT(IIO_CHAN_INFO_SAMP_FREQ);
+		channel->info_mask_shared_by_all_available =
+			BIT(IIO_CHAN_INFO_SAMP_FREQ);
 		channel->scan_type.realbits = CROS_EC_SENSOR_BITS;
 		channel->scan_type.storagebits = CROS_EC_SENSOR_BITS;
 		channel->scan_index = i;
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index 81111af8a167..805652250960 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -50,6 +50,37 @@ static int cros_ec_get_host_cmd_version_mask(struct cros_ec_device *ec_dev,
 	return ret;
 }
 
+static void get_default_min_max_freq(enum motionsensor_type type,
+				     u32 *min_freq,
+				     u32 *max_freq)
+{
+	switch (type) {
+	case MOTIONSENSE_TYPE_ACCEL:
+	case MOTIONSENSE_TYPE_GYRO:
+		*min_freq = 12500;
+		*max_freq = 100000;
+		break;
+	case MOTIONSENSE_TYPE_MAG:
+		*min_freq = 5000;
+		*max_freq = 25000;
+		break;
+	case MOTIONSENSE_TYPE_PROX:
+	case MOTIONSENSE_TYPE_LIGHT:
+		*min_freq = 100;
+		*max_freq = 50000;
+		break;
+	case MOTIONSENSE_TYPE_BARO:
+		*min_freq = 250;
+		*max_freq = 20000;
+		break;
+	case MOTIONSENSE_TYPE_ACTIVITY:
+	default:
+		*min_freq = 0;
+		*max_freq = 0;
+		break;
+	}
+}
+
 int cros_ec_sensors_core_init(struct platform_device *pdev,
 			      struct iio_dev *indio_dev,
 			      bool physical_device)
@@ -100,6 +131,19 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 		}
 		state->type = state->resp->info.type;
 		state->loc = state->resp->info.location;
+
+		/* 0 is a correct value used to stop the device */
+		state->frequencies[0] = 0;
+		if (state->msg->version < 3) {
+			get_default_min_max_freq(state->resp->info.type,
+						 &state->frequencies[1],
+						 &state->frequencies[2]);
+		} else {
+			state->frequencies[1] =
+			    state->resp->info_3.min_frequency;
+			state->frequencies[2] =
+			    state->resp->info_3.max_frequency;
+		}
 	}
 
 	return 0;
@@ -461,6 +505,27 @@ int cros_ec_sensors_core_read(struct cros_ec_sensors_core_state *st,
 }
 EXPORT_SYMBOL_GPL(cros_ec_sensors_core_read);
 
+int cros_ec_sensors_core_read_avail(struct iio_dev *indio_dev,
+				    struct iio_chan_spec const *chan,
+				    const int **vals,
+				    int *type,
+				    int *length,
+				    long mask)
+{
+	struct cros_ec_sensors_core_state *state = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*length = ARRAY_SIZE(state->frequencies);
+		*vals = (const int *)&state->frequencies;
+		*type = IIO_VAL_INT;
+		return IIO_AVAIL_LIST;
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(cros_ec_sensors_core_read_avail);
+
 int cros_ec_sensors_core_write(struct cros_ec_sensors_core_state *st,
 			       struct iio_chan_spec const *chan,
 			       int val, int val2, long mask)
diff --git a/drivers/iio/light/cros_ec_light_prox.c b/drivers/iio/light/cros_ec_light_prox.c
index 308ee6ff2e22..b9838bf25248 100644
--- a/drivers/iio/light/cros_ec_light_prox.c
+++ b/drivers/iio/light/cros_ec_light_prox.c
@@ -164,6 +164,7 @@ static int cros_ec_light_prox_write(struct iio_dev *indio_dev,
 static const struct iio_info cros_ec_light_prox_info = {
 	.read_raw = &cros_ec_light_prox_read,
 	.write_raw = &cros_ec_light_prox_write,
+	.read_avail = &cros_ec_sensors_core_read_avail,
 };
 
 static int cros_ec_light_prox_probe(struct platform_device *pdev)
@@ -198,6 +199,8 @@ static int cros_ec_light_prox_probe(struct platform_device *pdev)
 	channel->info_mask_shared_by_all =
 		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
 		BIT(IIO_CHAN_INFO_FREQUENCY);
+	channel->info_mask_shared_by_all_available =
+		BIT(IIO_CHAN_INFO_SAMP_FREQ);
 	channel->scan_type.realbits = CROS_EC_SENSOR_BITS;
 	channel->scan_type.storagebits = CROS_EC_SENSOR_BITS;
 	channel->scan_type.shift = 0;
diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include/linux/iio/common/cros_ec_sensors_core.h
index 0c636b9fe8d7..a9623111f7c9 100644
--- a/include/linux/iio/common/cros_ec_sensors_core.h
+++ b/include/linux/iio/common/cros_ec_sensors_core.h
@@ -70,6 +70,9 @@ struct cros_ec_sensors_core_state {
 				    unsigned long scan_mask, s16 *data);
 
 	int curr_sampl_freq;
+
+	/* Table of known available frequencies : 0, Min and Max in mHz */
+	int frequencies[3];
 };
 
 /**
@@ -150,6 +153,24 @@ int cros_ec_sensors_core_read(struct cros_ec_sensors_core_state *st,
 			      struct iio_chan_spec const *chan,
 			      int *val, int *val2, long mask);
 
+/**
+ * cros_ec_sensors_core_read_avail() - get available values
+ * @indio_dev:		pointer to state information for device
+ * @chan:	channel specification structure table
+ * @vals:	list of available values
+ * @type:	type of data returned
+ * @length:	number of data returned in the array
+ * @mask:	specifies which values to be requested
+ *
+ * Return:	an error code, IIO_AVAIL_RANGE or IIO_AVAIL_LIST
+ */
+int cros_ec_sensors_core_read_avail(struct iio_dev *indio_dev,
+				    struct iio_chan_spec const *chan,
+				    const int **vals,
+				    int *type,
+				    int *length,
+				    long mask);
+
 /**
  * cros_ec_sensors_core_write() - function to write a value to the sensor
  * @st:		pointer to state information for device
-- 
2.20.1

