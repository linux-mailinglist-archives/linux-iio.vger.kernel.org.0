Return-Path: <linux-iio+bounces-325-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1327F89E8
	for <lists+linux-iio@lfdr.de>; Sat, 25 Nov 2023 11:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CBF9B21293
	for <lists+linux-iio@lfdr.de>; Sat, 25 Nov 2023 10:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E529CA5D;
	Sat, 25 Nov 2023 10:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnvDf9At"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077331BD;
	Sat, 25 Nov 2023 02:24:48 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id 98e67ed59e1d1-2839b922c18so2030241a91.1;
        Sat, 25 Nov 2023 02:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700907887; x=1701512687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fTLsuYr7ngK5fIM+P5rOnW8uEsxD0at2dIYrsi0LR1U=;
        b=MnvDf9AtK0+lfhwIKBz9LwX2Ln4K+MHZbUTgc/T5LRNiT0+KaxUeVreiBKhFevQGR7
         qfF/ZplfrJuLvLhisNMaxw4qmKzhdXWZOivJWxplvEQekAQx39qZBQ2NHJLJBSuIfTOc
         ndm4EUOIEFJPJGIj2zbAxGte7/Nt5O7SCi1EWAm8S0g9ACW7BukoR7RFEkybkHA3KzDZ
         C805aTo/CmndBGtYdKB5m+mAfQJbBIiHmQOy9uTqQolLQdVIbc0St8wyU+wwMYkVJEJv
         a6D4ZRRC53mC21QX2TA9gnoO1saOvapyNrCQs8Kjqd8T4hgs+iGUEr0I6B99mGcfFPNL
         jdPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700907887; x=1701512687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fTLsuYr7ngK5fIM+P5rOnW8uEsxD0at2dIYrsi0LR1U=;
        b=NvF84uJeWitj8FmBJ8NWtvExiHw1uJ6XATcVdApATybMyKNqXAs+xBIMmwkDCKoltQ
         OlFJ4IHIEufqm2ucuCJC2LcWivP2BUjmY0hn/tUG5rqWf5fD2GECYcMnztkQ0rbuQxgT
         eUvH5qlPFfKG42JFd/VQpMDVIrxtvFKl5ZjAN1UX/stWKwpegDZw9DCw8Ti0sOFQ9oOe
         Ds5ISmmCB65ZMlDkrGy+8dYt+kcApTffNOlpN5cPa3n4YojBKy84GOhHMH5RcSQBq3dZ
         PokVi/IpAHR2tVQqlgtJJoQjc/zYFOUDXdl+e9I3MQBwrXL6vWFffMy+dvOt/vd6ibZ4
         KtWw==
X-Gm-Message-State: AOJu0YxLp/At+E5IwQk+26wOTHSZyFG2OxpZ1uV7QkjHV4jo4n6V6kBr
	ZHD6tmis6EA4hTDN0ZGJu14=
X-Google-Smtp-Source: AGHT+IGPphVkeCUxeyplHRmZL8/2ct+DM4Ucxr6VbUu+vslhETQKCVcgRS0eGrh7DhHZK0Kdl5rxPA==
X-Received: by 2002:a17:902:ee54:b0:1cf:7ce5:e6e8 with SMTP id 20-20020a170902ee5400b001cf7ce5e6e8mr5606303plo.12.1700907887142;
        Sat, 25 Nov 2023 02:24:47 -0800 (PST)
Received: from dawn-virtual-machine.localdomain ([183.198.109.30])
        by smtp.gmail.com with ESMTPSA id w5-20020a170902904500b001cf85115f3asm4610675plz.235.2023.11.25.02.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 02:24:46 -0800 (PST)
From: 579lpy@gmail.com
To: jic23@kernel.org,
	lars@metafoo.de,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Li peiyu <579lpy@gmail.com>
Subject: [PATCH v3 1/2] iio: humidity: Add driver for ti HDC302x humidity sensors
Date: Sat, 25 Nov 2023 18:22:21 +0800
Message-Id: <20231125102221.2795-1-579lpy@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Li peiyu <579lpy@gmail.com>

Add support for HDC302x integrated capacitive based relative
humidity (RH) and temperature sensor.
This driver supports reading values, reading the maximum and
minimum of values and controlling the integrated heater of
the sensor.

Signed-off-by: Li peiyu <579lpy@gmail.com>
---
changes for v3:
- Removed the custom ABI
- Give up calculating values in the driver
- Use read_avail callback to get available parameters
- Changed the scope of the lock to make the code more concise
- Fixed the code format issue
changes for v2:
- Added static modification to global variables
- change the methord to read peak value

 drivers/iio/humidity/Kconfig   |  11 +
 drivers/iio/humidity/Makefile  |   1 +
 drivers/iio/humidity/hdc3020.c | 522 +++++++++++++++++++++++++++++++++
 3 files changed, 534 insertions(+)
 create mode 100644 drivers/iio/humidity/hdc3020.c

diff --git a/drivers/iio/humidity/Kconfig b/drivers/iio/humidity/Kconfig
index 2de5494e7c22..7b585bc7db9a 100644
--- a/drivers/iio/humidity/Kconfig
+++ b/drivers/iio/humidity/Kconfig
@@ -48,6 +48,17 @@ config HDC2010
 	  To compile this driver as a module, choose M here: the module
 	  will be called hdc2010.
 
+config HDC3020
+	tristate "TI HDC3020 relative humidity and temperature sensor"
+	depends on I2C
+	help
+	  Say yes here to build support for the Texas Instruments
+	  HDC3020,HDC3021 and HDC3022 relative humidity and temperature
+	  sensors.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called hdc3020.
+
 config HID_SENSOR_HUMIDITY
 	tristate "HID Environmental humidity sensor"
 	depends on HID_SENSOR_HUB
diff --git a/drivers/iio/humidity/Makefile b/drivers/iio/humidity/Makefile
index f19ff3de97c5..5fbeef299f61 100644
--- a/drivers/iio/humidity/Makefile
+++ b/drivers/iio/humidity/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_AM2315) += am2315.o
 obj-$(CONFIG_DHT11) += dht11.o
 obj-$(CONFIG_HDC100X) += hdc100x.o
 obj-$(CONFIG_HDC2010) += hdc2010.o
+obj-$(CONFIG_HDC3020) += hdc3020.o
 obj-$(CONFIG_HID_SENSOR_HUMIDITY) += hid-sensor-humidity.o
 
 hts221-y := hts221_core.o \
diff --git a/drivers/iio/humidity/hdc3020.c b/drivers/iio/humidity/hdc3020.c
new file mode 100644
index 000000000000..bbd90abfb7df
--- /dev/null
+++ b/drivers/iio/humidity/hdc3020.c
@@ -0,0 +1,522 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * hdc3020.c - Support for the TI HDC3020,HDC3021 and HDC3022
+ * temperature + relative humidity sensors
+ *
+ * Copyright (C) 2023
+ *
+ * Datasheet: https://www.ti.com/lit/ds/symlink/hdc3020.pdf
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+
+#include <asm/unaligned.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
+#define READ_RETRY_TIMES 10
+#define BUSY_DELAY 10
+
+static const u8 HDC3020_S_AUTO_10HZ_MOD0[2] = { 0x27, 0x37 };
+
+static const u8 HDC3020_EXIT_AUTO[2] = { 0x30, 0x93 };
+
+static const u8 HDC3020_R_T_RH_AUTO[2] = { 0xE0, 0x00 };
+static const u8 HDC3020_R_T_LOW_AUTO[2] = { 0xE0, 0x02 };
+static const u8 HDC3020_R_T_HIGH_AUTO[2] = { 0xE0, 0x03 };
+static const u8 HDC3020_R_RH_LOW_AUTO[2] = { 0xE0, 0x04 };
+static const u8 HDC3020_R_RH_HIGH_AUTO[2] = { 0xE0, 0x05 };
+
+static const u8 HDC3020_ENABLE_HEATER[2] = { 0x30, 0x6D };
+static const u8 HDC3020_DISABLE_HEATER[2] = { 0x30, 0x66 };
+
+static const u8 HDC3020_HEATER_FULL[5] = { 0x30, 0x6E, 0x3F, 0xFF, 0x06 };
+static const u8 HDC3020_HEATER_HALF[5] = { 0x30, 0x6E, 0x03, 0xFF, 0x00 };
+static const u8 HDC3020_HEATER_QUARTER[5] = { 0x30, 0x6E, 0x00, 0x9F, 0x96 };
+
+struct hdc3020_data {
+	struct i2c_client *client;
+	struct mutex lock;
+
+	int temp;
+	int humidity;
+	int temp_high_peak;
+	int temp_low_peak;
+	int humidity_high_peak;
+	int humidity_low_peak;
+};
+
+enum hdc3020_heater_power {
+	HEATER_OFF = 0,
+	HEATER_QUARTER = 1,
+	HEATER_HALF = 2,
+	HEATER_FULL = 3,
+};
+
+static const int HEATER_VALUES[] = { HEATER_OFF, HEATER_QUARTER, HEATER_HALF,
+				     HEATER_FULL };
+
+static const struct iio_chan_spec hdc3020_channels[] = {
+	{
+		.type = IIO_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+		BIT(IIO_CHAN_INFO_SCALE),
+	},
+	{
+		/* For minimum value during measurement */
+		.type = IIO_TEMP,
+		.channel = 0,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PEAK) |
+		BIT(IIO_CHAN_INFO_PEAK_SCALE),
+		.indexed = 1,
+	},
+	{
+		/* For maxmum value during measurement */
+		.type = IIO_TEMP,
+		.channel = 1,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PEAK) |
+		BIT(IIO_CHAN_INFO_PEAK_SCALE),
+		.indexed = 1,
+	},
+	{
+		.type = IIO_HUMIDITYRELATIVE,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+		BIT(IIO_CHAN_INFO_SCALE),
+	},
+	{
+		/* For minimum value during measurement */
+		.type = IIO_HUMIDITYRELATIVE,
+		.channel = 0,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PEAK) |
+		BIT(IIO_CHAN_INFO_PEAK_SCALE),
+		.indexed = 1,
+	},
+	{
+		/* For maxmum value during measurement */
+		.type = IIO_HUMIDITYRELATIVE,
+		.channel = 1,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PEAK) |
+		BIT(IIO_CHAN_INFO_PEAK_SCALE),
+		.indexed = 1,
+	},
+	{
+		/* For setting the internal heater,which can be switched on to
+		 * prevent or remove any condensation that may develop when the
+		 * ambient environment approaches its dew point temperature.
+		 */
+		.type = IIO_CURRENT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_separate_available = 1,
+		.output = 1,
+	},
+};
+
+static int hdc3020_write_bytes(struct hdc3020_data *data, const u8 *buf,
+			       u8 len)
+{
+	int ret, cnt;
+	struct i2c_msg msg;
+	struct i2c_client *client = data->client;
+
+	msg.addr = client->addr;
+	msg.flags = 0;
+	msg.buf = (char *)buf;
+	msg.len = len;
+
+	/*
+	 * During the measurement process, HDC3020 will not return data.
+	 * So wait for a while and try again
+	 */
+	ret = 0;
+	cnt = 0;
+
+	while (cnt < READ_RETRY_TIMES) {
+		ret = i2c_transfer(client->adapter, &msg, 1);
+		if (ret == 1) {
+			ret = 0;
+			break;
+		}
+
+		mdelay(BUSY_DELAY);
+		cnt++;
+	}
+	if (cnt == READ_RETRY_TIMES) {
+		dev_err(&client->dev, "Could not write sensor command\n");
+		return -EREMOTEIO;
+	}
+
+	return 0;
+}
+
+static int hdc3020_read_bytes(struct hdc3020_data *data, const u8 *buf,
+			      void *val, int len)
+{
+	int ret, cnt;
+	struct i2c_client *client = data->client;
+	struct i2c_msg msg[2] = {
+		[0] = {
+			.addr = client->addr,
+			.flags = 0,
+			.buf = (char *)buf,
+			.len = 2,
+		},
+		[1] = {
+			.addr = client->addr,
+			.flags = I2C_M_RD,
+			.buf = val,
+			.len = len,
+		},
+	};
+
+	/*
+	 * During the measurement process, HDC3020 will not return data.
+	 * So wait for a while and try again
+	 */
+	ret = 0;
+	cnt = 0;
+
+	while (cnt < READ_RETRY_TIMES) {
+		ret = i2c_transfer(client->adapter, msg, 2);
+		if (ret == 2) {
+			ret = 0;
+			break;
+		}
+		mdelay(BUSY_DELAY);
+		cnt++;
+	}
+
+	if (cnt == READ_RETRY_TIMES) {
+		dev_err(&client->dev, "Could not read sensor data\n");
+		return -EREMOTEIO;
+	}
+
+	return 0;
+}
+
+static int hdc3020_read_measurement(struct hdc3020_data *data)
+{
+	int ret;
+	u8 buf[6];
+
+	ret = hdc3020_read_bytes(data, HDC3020_R_T_RH_AUTO, (void *)buf, 6);
+	if (ret < 0)
+		return ret;
+	/* Subtract offset: 45 / 175 * 65535 = 16852 */
+	data->temp = (int)get_unaligned_be16(buf) - 16852;
+	data->humidity = get_unaligned_be16(&buf[3]);
+	return 0;
+}
+
+/*
+ * After exiting the automatic measurement mode or resetting, the peak
+ * value will be reset to the default value
+ * This methord is used to get the lowest temp measured during automatic
+ * measurement
+ */
+static int hdc3020_read_high_peak_t(struct hdc3020_data *data)
+{
+	int ret;
+	u8 buf[3];
+
+	ret = hdc3020_read_bytes(data, HDC3020_R_T_HIGH_AUTO, (void *)buf, 3);
+	if (ret < 0)
+		return ret;
+	/* Subtract offset: 45 / 175 * 65535 = 16852 */
+	data->temp_high_peak = (int)get_unaligned_be16(buf) - 16852;
+
+	return 0;
+}
+
+/*
+ * This methord is used to get the highest temp measured during automatic
+ * measurement
+ */
+static int hdc3020_read_low_peak_t(struct hdc3020_data *data)
+{
+	int ret;
+	u8 buf[3];
+
+	ret = hdc3020_read_bytes(data, HDC3020_R_T_LOW_AUTO, (void *)buf, 3);
+	if (ret < 0)
+		return ret;
+	/* Subtract offset: 45 / 175 * 65535 = 16852 */
+	data->temp_low_peak = (int)get_unaligned_be16(buf) - 16852;
+
+	return 0;
+}
+
+/*
+ * This methord is used to get the highest humidity measured during automatic
+ * measurement
+ */
+static int hdc3020_read_high_peak_rh(struct hdc3020_data *data)
+{
+	int ret;
+	u8 buf[3];
+
+	ret = hdc3020_read_bytes(data, HDC3020_R_RH_HIGH_AUTO, (void *)buf, 3);
+	if (ret < 0)
+		return ret;
+	data->humidity_high_peak = get_unaligned_be16(buf);
+
+	return 0;
+}
+
+/*
+ * This methord is used to get the lowest humidity measured during automatic
+ * measurement
+ */
+static int hdc3020_read_low_peak_rh(struct hdc3020_data *data)
+{
+	int ret;
+	u8 buf[3];
+
+	ret = hdc3020_read_bytes(data, HDC3020_R_RH_LOW_AUTO, (void *)buf, 3);
+	if (ret < 0)
+		return ret;
+	data->humidity_low_peak = get_unaligned_be16(buf);
+
+	return 0;
+}
+
+static int hdc3020_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int *val,
+			    int *val2, long mask)
+{
+	struct hdc3020_data *data = iio_priv(indio_dev);
+	int ret = 0;
+
+	mutex_lock(&data->lock);
+	switch (mask) {
+
+	case IIO_CHAN_INFO_RAW:
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret < 0)
+			break;
+
+		ret = hdc3020_read_measurement(data);
+		if (ret < 0)
+			break;
+
+		if (chan->type == IIO_TEMP)
+			*val = data->temp;
+		else if (chan->type == IIO_HUMIDITYRELATIVE)
+			*val = data->humidity;
+		iio_device_release_direct_mode(indio_dev);
+		ret = IIO_VAL_INT;
+		break;
+
+	case IIO_CHAN_INFO_PEAK:
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret < 0)
+			break;
+
+		if (chan->type == IIO_TEMP) {
+			if (chan->channel == 0) {
+				ret = hdc3020_read_low_peak_t(data);
+				if (ret < 0)
+					break;
+
+				*val = data->temp_low_peak;
+			} else if (chan->channel == 1) {
+				ret = hdc3020_read_high_peak_t(data);
+				if (ret < 0)
+					break;
+
+				*val = data->temp_high_peak;
+			}
+		} else if (chan->type == IIO_HUMIDITYRELATIVE) {
+			if (chan->channel == 0) {
+				ret = hdc3020_read_low_peak_rh(data);
+				if (ret < 0)
+					break;
+
+				*val = data->humidity_low_peak;
+			} else if (chan->channel == 1) {
+				ret = hdc3020_read_high_peak_rh(data);
+				if (ret < 0)
+					break;
+
+				*val = data->humidity_high_peak;
+			}
+		}
+		iio_device_release_direct_mode(indio_dev);
+		ret = IIO_VAL_INT;
+		break;
+
+	case IIO_CHAN_INFO_SCALE:
+	case IIO_CHAN_INFO_PEAK_SCALE:
+		*val2 = 65536;
+		if (chan->type == IIO_TEMP)
+			*val = 175;
+		else
+			*val = 100;
+		ret = IIO_VAL_FRACTIONAL;
+		break;
+
+	default:
+		ret = -EINVAL;
+	}
+	mutex_unlock(&data->lock);
+
+	return ret;
+}
+
+static int hdc3020_read_available(struct iio_dev *indio_dev,
+				  struct iio_chan_spec const *chan,
+				  const int **vals,
+				  int *type, int *length, long mask)
+{
+	if (mask != IIO_CHAN_INFO_RAW || chan->type != IIO_CURRENT)
+		return -EINVAL;
+
+	*vals = HEATER_VALUES;
+	*type = IIO_VAL_INT;
+	*length = 4;
+
+	return IIO_AVAIL_LIST;
+}
+
+static int hdc3020_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long mask)
+{
+	struct hdc3020_data *data = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (chan->type != IIO_CURRENT || val2 != 0 || val < 0
+		    || val > 3)
+			return -EINVAL;
+
+		mutex_lock(&data->lock);
+		switch (val) {
+		case HEATER_QUARTER:
+			ret =
+			    hdc3020_write_bytes(data, HDC3020_HEATER_QUARTER,
+						5);
+			if (ret < 0)
+				break;
+
+			ret =
+			    hdc3020_write_bytes(data, HDC3020_ENABLE_HEATER, 2);
+			break;
+		case HEATER_HALF:
+			ret = hdc3020_write_bytes(data, HDC3020_HEATER_HALF, 5);
+			if (ret < 0)
+				break;
+
+			ret =
+			    hdc3020_write_bytes(data, HDC3020_ENABLE_HEATER, 2);
+			break;
+		case HEATER_FULL:
+			ret = hdc3020_write_bytes(data, HDC3020_HEATER_FULL, 5);
+			if (ret < 0)
+				break;
+
+			ret =
+			    hdc3020_write_bytes(data, HDC3020_ENABLE_HEATER, 2);
+			break;
+		case HEATER_OFF:
+			ret =
+			    hdc3020_write_bytes(data, HDC3020_DISABLE_HEATER,
+						2);
+			break;
+		}
+		mutex_unlock(&data->lock);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static const struct iio_info hdc3020_info = {
+	.read_raw = hdc3020_read_raw,
+	.write_raw = hdc3020_write_raw,
+	.read_avail = hdc3020_read_available,
+};
+
+static void hdc3020_stop(void *data)
+{
+	hdc3020_write_bytes((struct hdc3020_data *)data, HDC3020_EXIT_AUTO, 2);
+}
+
+static int hdc3020_probe(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev;
+	struct hdc3020_data *data;
+	int ret;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
+		return -EOPNOTSUPP;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	data->client = client;
+	mutex_init(&data->lock);
+
+	indio_dev->name = "hdc3020";
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &hdc3020_info;
+
+	indio_dev->channels = hdc3020_channels;
+	indio_dev->num_channels = ARRAY_SIZE(hdc3020_channels);
+
+	ret = hdc3020_write_bytes(data, HDC3020_S_AUTO_10HZ_MOD0, 2);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				     "Unable to set up measurement\n");
+
+	ret = devm_add_action_or_reset(&data->client->dev, hdc3020_stop, data);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				     "Failed to add device\n\n");
+
+	ret = devm_iio_device_register(&data->client->dev, indio_dev);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				     "Failed to add device\n\n");
+
+	return 0;
+}
+
+static const struct i2c_device_id hdc3020_id[] = {
+	{ "hdc3020" },
+	{ "hdc3021" },
+	{ "hdc3022" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, hdc3020_id);
+
+static const struct of_device_id hdc3020_dt_ids[] = {
+	{.compatible = "ti,hdc3020" },
+	{.compatible = "ti,hdc3021" },
+	{.compatible = "ti,hdc3022" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, hdc3020_dt_ids);
+
+static struct i2c_driver hdc3020_driver = {
+	.driver = {
+		.name = "hdc3020",
+		.of_match_table = hdc3020_dt_ids,
+	},
+	.probe = hdc3020_probe,
+	.id_table = hdc3020_id,
+};
+
+module_i2c_driver(hdc3020_driver);
+
+MODULE_AUTHOR("Li peiyu <579lpy@gmail.com>");
+MODULE_DESCRIPTION("TI HDC3020 humidity and temperature sensor driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1


