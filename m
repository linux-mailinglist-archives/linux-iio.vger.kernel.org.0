Return-Path: <linux-iio+bounces-10275-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D57992CDC
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 15:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39A6B282193
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 13:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE801D45FF;
	Mon,  7 Oct 2024 13:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RAh2CfL+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FF31D3644
	for <linux-iio@vger.kernel.org>; Mon,  7 Oct 2024 13:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728306895; cv=none; b=EqcAaxNZdFObz8b5le5/LMV9bIDXTW1ridasrBWFmLhxYBG4naUplpEW9ZWHZ25u5gmfye5PLaDk+mQVLrKBG2zEpJ/x2aqxnqWCeK6m9+vuQ1W2ju947/2gdJ+bA2EfzfNITJ5PSWhW3K5Ob+cFW4Hi1mdCB9H3wFpWbYhucW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728306895; c=relaxed/simple;
	bh=JE9NM46xm6yUa5BAzvE76L+iWgUrQoHCcP0yblU388c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p5zIH8HlM2CMUWsgLvRDd9V9kE1etyIKOkWylcfX/XPOml1yTN3OArqsnhJBPq/uu10peAHLzLmicxKyIImCCq4DytLqzS43zWYznLxHP0u4ciOq8poFTB7GuqJ+p9egfux5RNzUhVc4JQ3hbzGWMSZuCmk2Enqn2MB9hKYVwNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RAh2CfL+; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42cd74c0d16so45288775e9.1
        for <linux-iio@vger.kernel.org>; Mon, 07 Oct 2024 06:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728306892; x=1728911692; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hnArz4yfttKAFtln2UG4JPxpJ8Ty/6N11wglgOPOIlI=;
        b=RAh2CfL+PZKrU7lquH4mq5jGD6j2ccqhhkT0gViwHbWOojPHDTrujYGx5NWPmepFU/
         HODdFBpTQTGVq+xsl4OJG1Q/aMPs9y5VVnT/6+XAg/iEdSTdq9Xbu7N4cyazDuMe83E7
         j6e/TzL4dq6vv+t0LQhsOe8QdTToy4gpv7XMnwZib6gOZGcmzP5TsPVo9SZAjCGfCaBv
         egPy6qaGN2RN40hExg7D1mpEU/U2nOGvc0Tt2SUqKmno66konSSQVntTZ1efIsI+LKOl
         fkTrttkb0RhQ0zKkxrWw06AgZ0JZ7XSCqxxEo382HSd1VFVEZnyQMmG7iKyBUSxaqlTS
         x+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728306892; x=1728911692;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hnArz4yfttKAFtln2UG4JPxpJ8Ty/6N11wglgOPOIlI=;
        b=xJ8qEoQ9/8BhnxCjVriYwBlPPv1H70ZU//NvlThkWZPMbcUIcXTrgRc6gAv0zw+U5G
         W/PkkO9LgQiswdVPpVYuootpEf4SfPeXzy9C4Sr9H16DvsigTeaS3lIuInZbj8qP+J2e
         PhVT5IILdBZxs63ueOi/3un4n3FHDEODp9Rlb+5b5Nb5nE590P1c0RL6H+W7D6ibx4zB
         9D/E/35f/2U0ct8N6eKVhoZ8P3vM8OFOiYdWUQsdSCbaMN0gF82Z9Ym5WiK8aytIujUQ
         ecMeaYbP/i0SlLNjBTsZPCzcuPAILOR7ENLJWCF7jJ1Xw0gHRHHCRk7P8/rg5gxugKdF
         E8Ag==
X-Forwarded-Encrypted: i=1; AJvYcCUe2YpeLKgKHeG4eWsxgHIVhoLE1nlSKo5FO1dkze0yvUuRk0TTT9m5nG9Oi252O+dXMqxH3busmLs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8qJ2ypZltx3IgYrzIfD2nfMo8a3ORu3h2nLiGo6IHPjZIY4sN
	4FQ/sXI4AwHF+g+0l9bRStBTGB2RvOHqPBRRxC40km+FJAjhUjEIUtAN7ce+jxE=
X-Google-Smtp-Source: AGHT+IG9f4vB6T1s6tN6UwA9Vx4hvfJiLo7UbpRm9dR3KAduAY6eAEjDIHlMPls4IGr1n67LhwSTqw==
X-Received: by 2002:a05:600c:1907:b0:42e:d463:3ea8 with SMTP id 5b1f17b1804b1-42f85aefaeamr104422085e9.34.1728306891710;
        Mon, 07 Oct 2024 06:14:51 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f89ec6396sm73916475e9.30.2024.10.07.06.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 06:14:51 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 07 Oct 2024 15:14:40 +0200
Subject: [PATCH 3/3] iio: magnetometer: add Allegro MicroSystems ALS31300
 3-D Linear Hall Effect driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-topic-input-upstream-als31300-v1-3-2c240ea5cb77@linaro.org>
References: <20241007-topic-input-upstream-als31300-v1-0-2c240ea5cb77@linaro.org>
In-Reply-To: <20241007-topic-input-upstream-als31300-v1-0-2c240ea5cb77@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=15979;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=JE9NM46xm6yUa5BAzvE76L+iWgUrQoHCcP0yblU388c=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnA97HXjaosaOJPMPI1ESZnVrgAQ85u53QiofhPTQY
 Sty183aJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZwPexwAKCRB33NvayMhJ0Z6tD/
 9EXkZgx4cNH/5uz8c48SNITuvWDreqwF3wuhdIHAnrLLzM6Z4bSns0e2yDUZ5UinetS5ytJqDedi+F
 XSIgQNaBdgaZdG5xKJK/8F/nMgqV53Ur76zFWntaW6OzhWVNQvhlbkDnsTC4K/Z7naEXlTOA6jMXyF
 bRj7vqYvgRefVxx+wldINVh1WqdQS4f3WXFAZ14psei+0IeBRjlkvDHwSuTCejHioPFbHlXThoF1xd
 O5PiFhbVO9BGtRw7R9ykWfHy3eYY8wKnTBRRTV7SDvRc+PvACuEKKXLt4bY5F2+xF9ATgHI/4ONYRP
 hwsH7j+JhVd5seQwmHBdoss6oI0eVFkMon6sq3e4DKpjI3s6qnMm+LER3ApWytTjhNgzvv5uonOtbO
 vQZHRXuaa7fdK++MSIJ4bAuJn2CzwhbQtwHJhRl5JpCrIhBPwq3YpUUtYu1coCiFoqw4uSsz51pcbY
 ShFkIhBP3UOWS1FloGIpu6//lB102WBWIfpOUJ5/8e/Q9VgqgRVIJyNoh6IdYneCaJjVg4UZV7tKal
 Yb2HUxy5inBKnzAH0ACmJivygrF7ZxdsjEseIkNeqQtSZcXf/e6tgHWw15oqNye0fxh8pP11++9xib
 GRiDg21JNTeZICMlyRtNPP+OIg4PgEhhTWtSpMGIkXctPB7Xa9nRdarzs7bA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The Allegro MicroSystems ALS31300 is a 3-D Linear Hall Effect Sensor
mainly used for 3D head-on motion sensing applications.

The device is configured over I2C, and as part of the Sensor
data the temperature core is also provided.

While the device provides an IRQ gpio, it depends on a configuration
programmed into the internal EEPROM, thus only the default mode
is supported and buffered input via trigger is also supported
to allow streaming values with the same sensing timestamp.

The device can be configured with different sensitivities in factory,
but the sensitivity value used to calculate value into the Gauss
unit is not available from registers, thus the sensitivity is
provided by the compatible/device-id string which is based
on the part number as described in the datasheet page 2.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/iio/magnetometer/Kconfig    |  13 +
 drivers/iio/magnetometer/Makefile   |   1 +
 drivers/iio/magnetometer/als31300.c | 459 ++++++++++++++++++++++++++++++++++++
 3 files changed, 473 insertions(+)

diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
index 8eb718f5e50f..e7adc11049d6 100644
--- a/drivers/iio/magnetometer/Kconfig
+++ b/drivers/iio/magnetometer/Kconfig
@@ -52,6 +52,19 @@ config AK09911
 	help
 	  Deprecated: AK09911 is now supported by AK8975 driver.
 
+config ALS31300
+	tristate "Allegro MicroSystems ALS31300 3-D Linear Hall Effect Sensor"
+	depends on I2C
+	select REGMAP_I2C
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	help
+	  Say yes here to build support for the Allegro MicroSystems
+	  ALS31300 Hall Effect Sensor through its I2C interface.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called als31300.
+
 config BMC150_MAGN
 	tristate
 	select IIO_BUFFER
diff --git a/drivers/iio/magnetometer/Makefile b/drivers/iio/magnetometer/Makefile
index ec5c46fbf999..3e4c2ecd9adf 100644
--- a/drivers/iio/magnetometer/Makefile
+++ b/drivers/iio/magnetometer/Makefile
@@ -7,6 +7,7 @@
 obj-$(CONFIG_AF8133J)	+= af8133j.o
 obj-$(CONFIG_AK8974)	+= ak8974.o
 obj-$(CONFIG_AK8975)	+= ak8975.o
+obj-$(CONFIG_ALS31300)	+= als31300.o
 obj-$(CONFIG_BMC150_MAGN) += bmc150_magn.o
 obj-$(CONFIG_BMC150_MAGN_I2C) += bmc150_magn_i2c.o
 obj-$(CONFIG_BMC150_MAGN_SPI) += bmc150_magn_spi.o
diff --git a/drivers/iio/magnetometer/als31300.c b/drivers/iio/magnetometer/als31300.c
new file mode 100644
index 000000000000..123e6a63b516
--- /dev/null
+++ b/drivers/iio/magnetometer/als31300.c
@@ -0,0 +1,459 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Driver for the Allegro MicroSystems ALS31300 3-D Linear Hall Effect Sensor
+ *
+ * Copyright (c) 2024 Linaro Limited
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+#include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
+
+#include <linux/iio/buffer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+
+/*
+ * The Allegro MicroSystems ALS31300 has an EEPROM space to configure how
+ * the device works and how the interrupt line behaves,
+ * we only support the default setup with external trigger
+ *
+ * Since by default the interrupt line is disable, we don't
+ * support GPIO interrupt events for now.
+ *
+ * It should be possible to adapt the driver to the current
+ * device setup, but we leave it as a future exercise.
+ */
+
+#define ALS31300_EEPROM_CONFIG		0x02
+#define ALS31300_EEPROM_INTERRUPT	0x03
+#define ALS31300_EEPROM_CUSTOMER_1	0x0d
+#define ALS31300_EEPROM_CUSTOMER_2	0x0e
+#define ALS31300_EEPROM_CUSTOMER_3	0x0f
+#define ALS31300_VOLATILE_MODE		0x27
+#define ALS31300_VOLATILE_MODE_LPDCM		GENMASK(6, 4)
+#define ALS31300_VOLATILE_MODE_SLEEP		GENMASK(1, 0)
+#define ALS31300_VOLATILE_MSB		0x28
+#define ALS31300_VOLATILE_MSB_TEMPERATURE	GENMASK(5, 0)
+#define ALS31300_VOLATILE_MSB_INTERRUPT		BIT(6)
+#define ALS31300_VOLATILE_MSB_NEW_DATA		BIT(7)
+#define ALS31300_VOLATILE_MSB_Z_AXIS		GENMASK(15, 8)
+#define ALS31300_VOLATILE_MSB_Y_AXIS		GENMASK(23, 16)
+#define ALS31300_VOLATILE_MSB_X_AXIS		GENMASK(31, 24)
+#define ALS31300_VOLATILE_LSB		0x29
+#define ALS31300_VOLATILE_LSB_TEMPERATURE	GENMASK(5, 0)
+#define ALS31300_VOLATILE_LSB_HALL_STATUS	GENMASK(7, 7)
+#define ALS31300_VOLATILE_LSB_Z_AXIS		GENMASK(11, 8)
+#define ALS31300_VOLATILE_LSB_Y_AXIS		GENMASK(15, 12)
+#define ALS31300_VOLATILE_LSB_X_AXIS		GENMASK(19, 16)
+#define ALS31300_VOLATILE_LSB_INTERRUPT_WRITE	BIT(20)
+#define ALS31300_CUSTOMER_ACCESS	0x35
+
+#define ALS31300_LPDCM_INACTIVE_0_5_MS		0
+#define ALS31300_LPDCM_INACTIVE_1_0_MS		1
+#define ALS31300_LPDCM_INACTIVE_5_0_MS		2
+#define ALS31300_LPDCM_INACTIVE_10_0_MS		3
+#define ALS31300_LPDCM_INACTIVE_50_0_MS		4
+#define ALS31300_LPDCM_INACTIVE_100_0_MS	5
+#define ALS31300_LPDCM_INACTIVE_500_0_MS	6
+#define ALS31300_LPDCM_INACTIVE_1000_0_MS	7
+
+#define ALS31300_VOLATILE_MODE_ACTIVE_MODE	0
+#define ALS31300_VOLATILE_MODE_SLEEP_MODE	1
+#define ALS31300_VOLATILE_MODE_LPDCM_MODE	2
+
+#define ALS31300_DATA_X_GET(__buf)			\
+		((int)(s8)FIELD_GET(ALS31300_VOLATILE_MSB_X_AXIS, __buf[0]) << 4 | \
+			  FIELD_GET(ALS31300_VOLATILE_LSB_X_AXIS, __buf[1]))
+#define ALS31300_DATA_Y_GET(__buf)			\
+		((int)(s8)FIELD_GET(ALS31300_VOLATILE_MSB_Y_AXIS, __buf[0]) << 4 | \
+			  FIELD_GET(ALS31300_VOLATILE_LSB_Y_AXIS, __buf[1]))
+#define ALS31300_DATA_Z_GET(__buf)			\
+		((int)(s8)FIELD_GET(ALS31300_VOLATILE_MSB_Z_AXIS, __buf[0]) << 4 | \
+			  FIELD_GET(ALS31300_VOLATILE_LSB_Z_AXIS, __buf[1]))
+#define ALS31300_TEMPERATURE_GET(__buf)			\
+		((u32)(u8)FIELD_GET(ALS31300_VOLATILE_MSB_TEMPERATURE, __buf[0]) << 6 | \
+			  FIELD_GET(ALS31300_VOLATILE_LSB_TEMPERATURE, __buf[1]))
+
+enum als31300_channels {
+	TEMPERATURE = 0,
+	AXIS_X,
+	AXIS_Y,
+	AXIS_Z,
+};
+
+struct als31300_data {
+	struct device *dev;
+	/* protects power on/off the device and access HW */
+	struct mutex mutex;
+	unsigned long sensitivity;
+	struct regmap *map;
+	struct {
+		u16 temperature;
+		s16 channels[3];
+		s64 timestamp __aligned(8);
+	} scan;
+};
+
+/* The whole measure is split into 2x32bit registers, we need to read them both at once */
+static int als31300_get_measure(struct als31300_data *data, s16 *t, s16 *x,
+				s16 *y, s16 *z)
+{
+	unsigned int count = 0;
+	u32 buf[2];
+	int ret;
+
+	mutex_lock(&data->mutex);
+	ret = pm_runtime_resume_and_get(data->dev);
+	if (ret)
+		goto unlock;
+
+	/* Max update rate it 2KHz, wait up to 1ms */
+	while (count < 50) {
+		/* Read Data */
+		ret = regmap_bulk_read(data->map, ALS31300_VOLATILE_MSB, buf, 2);
+		if (ret) {
+			dev_err(data->dev, "read data failed, error %d\n", ret);
+			goto out;
+		}
+
+		/* Check if data is valid, happens right after getting out of sleep mode */
+		if (FIELD_GET(ALS31300_VOLATILE_MSB_NEW_DATA, buf[0]))
+			break;
+
+		usleep_range(10, 20);
+		++count;
+	}
+
+	if (count >= 50) {
+		ret = -ETIMEDOUT;
+		goto out;
+	}
+
+	*t = ALS31300_TEMPERATURE_GET(buf);
+	*x = ALS31300_DATA_X_GET(buf);
+	*y = ALS31300_DATA_Y_GET(buf);
+	*z = ALS31300_DATA_Z_GET(buf);
+
+out:
+	pm_runtime_mark_last_busy(data->dev);
+	pm_runtime_put_autosuspend(data->dev);
+
+unlock:
+	mutex_unlock(&data->mutex);
+
+	return ret;
+}
+
+static int als31300_read_raw(struct iio_dev *indio_dev,
+			     const struct iio_chan_spec *chan, int *val,
+			     int *val2, long mask)
+{
+	struct als31300_data *data = iio_priv(indio_dev);
+	s16 t, x, y, z;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_PROCESSED:
+	case IIO_CHAN_INFO_RAW:
+		ret = als31300_get_measure(data, &t, &x, &y, &z);
+		if (ret)
+			return ret;
+		switch (chan->address) {
+		case TEMPERATURE:
+			*val = t;
+			return IIO_VAL_INT;
+		case AXIS_X:
+			*val = x;
+			return IIO_VAL_INT;
+		case AXIS_Y:
+			*val = y;
+			return IIO_VAL_INT;
+		case AXIS_Z:
+			*val = z;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_TEMP:
+			/*
+			 * Fractional part of:
+			 *         302(value - 1708)
+			 * temp = ------------------
+			 *             4096
+			 * to convert temperature in Celcius
+			 */
+			*val = 302;
+			*val2 = 4096;
+			return IIO_VAL_FRACTIONAL;
+		case IIO_MAGN:
+			/*
+			 * Devices are configured in factory
+			 * with different sensitivities:
+			 * - 500 GAUSS <-> 4 LSB/Gauss
+			 * - 1000 GAUSS <-> 2 LSB/Gauss
+			 * - 2000 GAUSS <-> 1 LSB/Gauss
+			 * with translates by a division of the returned
+			 * value to get Gauss value.
+			 * The sensisitivity cannot be read at runtime
+			 * so the value depends on the model compatible
+			 * or device id.
+			 */
+			*val = 1;
+			*val2 = data->sensitivity;
+			return IIO_VAL_FRACTIONAL;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_OFFSET:
+		switch (chan->type) {
+		case IIO_TEMP:
+			*val = -1708;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static irqreturn_t als31300_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct als31300_data *data = iio_priv(indio_dev);
+	s16 x, y, z;
+	u16 t;
+	int ret;
+
+	ret = als31300_get_measure(data, &t, &x, &y, &z);
+	if (ret)
+		goto trigger_out;
+
+	data->scan.temperature = t;
+	data->scan.channels[0] = x;
+	data->scan.channels[1] = y;
+	data->scan.channels[2] = z;
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
+					   iio_get_time_ns(indio_dev));
+
+trigger_out:
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
+#define ALS31300_AXIS_CHANNEL(axis, index)				     \
+	{								     \
+		.type = IIO_MAGN,					     \
+		.modified = 1,						     \
+		.channel2 = IIO_MOD_##axis,				     \
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		     \
+				      BIT(IIO_CHAN_INFO_SCALE),		     \
+		.address = index,					     \
+		.scan_index = index,					     \
+		.scan_type = {						     \
+			.sign = 's',					     \
+			.realbits = 12,					     \
+			.storagebits = 16,				     \
+			.endianness = IIO_CPU,				     \
+		},							     \
+	}
+
+static const struct iio_chan_spec als31300_channels[] = {
+	{
+		.type = IIO_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_SCALE) |
+			BIT(IIO_CHAN_INFO_OFFSET),
+		.address = TEMPERATURE,
+		.scan_index = TEMPERATURE,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_CPU,
+		},
+	},
+	ALS31300_AXIS_CHANNEL(X, AXIS_X),
+	ALS31300_AXIS_CHANNEL(Y, AXIS_Y),
+	ALS31300_AXIS_CHANNEL(Z, AXIS_Z),
+	IIO_CHAN_SOFT_TIMESTAMP(6),
+};
+
+static const struct iio_info als31300_info = {
+	.read_raw = als31300_read_raw,
+};
+
+static int als31300_set_operating_mode(struct als31300_data *data,
+				       unsigned int val)
+{
+	return regmap_update_bits(data->map, ALS31300_VOLATILE_MODE,
+				  ALS31300_VOLATILE_MODE_SLEEP, val);
+}
+
+static void als31300_power_down(void *data)
+{
+	als31300_set_operating_mode(data, ALS31300_VOLATILE_MODE_SLEEP_MODE);
+}
+
+static const struct iio_buffer_setup_ops als31300_setup_ops = {};
+
+static const unsigned long als31300_scan_masks[] = { GENMASK(3, 0), 0 };
+
+static bool als31300_volatile_reg(struct device *dev, unsigned int reg)
+{
+	return reg == ALS31300_VOLATILE_MSB || reg == ALS31300_VOLATILE_LSB;
+}
+
+static const struct regmap_config als31300_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 32,
+	.max_register = ALS31300_CUSTOMER_ACCESS,
+	.volatile_reg = als31300_volatile_reg,
+};
+
+static int als31300_probe(struct i2c_client *i2c)
+{
+	struct device *dev = &i2c->dev;
+	struct als31300_data *data;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	data->dev = dev;
+	i2c_set_clientdata(i2c, indio_dev);
+
+	mutex_init(&data->mutex);
+
+	data->sensitivity = (unsigned long)of_device_get_match_data(dev);
+
+	data->map = devm_regmap_init_i2c(i2c, &als31300_regmap_config);
+	if (IS_ERR(data->map))
+		return dev_err_probe(dev, PTR_ERR(data->map),
+				     "failed to allocate register map\n");
+
+	ret = devm_regulator_get_enable(dev, "vcc");
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to enable regulator\n");
+
+	ret = als31300_set_operating_mode(data, ALS31300_VOLATILE_MODE_ACTIVE_MODE);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to power on device\n");
+
+	ret = devm_add_action_or_reset(dev, als31300_power_down, data);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to add powerdown action\n");
+
+	indio_dev->info = &als31300_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->name = i2c->name;
+	indio_dev->channels = als31300_channels;
+	indio_dev->num_channels = ARRAY_SIZE(als31300_channels);
+	indio_dev->available_scan_masks = als31300_scan_masks;
+
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+					      iio_pollfunc_store_time,
+					      als31300_trigger_handler,
+					      &als31300_setup_ops);
+	if (ret < 0) {
+		dev_err(dev, "iio triggered buffer setup failed\n");
+		return ret;
+	}
+
+	ret = pm_runtime_set_active(dev);
+	if (ret < 0)
+		return ret;
+
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return ret;
+
+	pm_runtime_get_noresume(dev);
+	pm_runtime_set_autosuspend_delay(dev, 200);
+	pm_runtime_use_autosuspend(dev);
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "device register failed\n");
+
+	return 0;
+}
+
+static int als31300_runtime_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct als31300_data *data = iio_priv(indio_dev);
+	int ret;
+
+	ret = als31300_set_operating_mode(data, ALS31300_VOLATILE_MODE_SLEEP_MODE);
+	if (ret)
+		dev_err(dev, "failed to power off device (%pe)\n", ERR_PTR(ret));
+
+	return ret;
+}
+
+static int als31300_runtime_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct als31300_data *data = iio_priv(indio_dev);
+	int ret;
+
+	ret = als31300_set_operating_mode(data, ALS31300_VOLATILE_MODE_ACTIVE_MODE);
+	if (ret)
+		dev_err(dev, "failed to power on device (%pe)\n", ERR_PTR(ret));
+
+	return ret;
+}
+
+static DEFINE_RUNTIME_DEV_PM_OPS(als31300_pm_ops,
+				 als31300_runtime_suspend, als31300_runtime_resume,
+				 NULL);
+
+static const struct i2c_device_id als31300_id[] = {
+	{ "als31300-500" },
+	{ "als31300-1000" },
+	{ "als31300-2000" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(i2c, als31300_id);
+
+static const struct of_device_id als31300_of_match[] = {
+	{ .compatible = "allegromicro,als31300-500", .data = (void *)4 },
+	{ .compatible = "allegromicro,als31300-1000", .data = (void *)2 },
+	{ .compatible = "allegromicro,als31300-2000", .data = (void *)1 },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, als31300_of_match);
+
+static struct i2c_driver als31300_driver = {
+	.driver	 = {
+		.name = "als31300",
+		.of_match_table = als31300_of_match,
+		.pm = pm_ptr(&als31300_pm_ops),
+	},
+	.probe = als31300_probe,
+	.id_table = als31300_id,
+};
+module_i2c_driver(als31300_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("ALS31300 3-D Linear Hall Effect Driver");
+MODULE_AUTHOR("Neil Armstrong <neil.armstrong@linaro.org>");

-- 
2.34.1


