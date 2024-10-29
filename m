Return-Path: <linux-iio+bounces-11567-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA329B4BD5
	for <lists+linux-iio@lfdr.de>; Tue, 29 Oct 2024 15:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD63C1C22612
	for <lists+linux-iio@lfdr.de>; Tue, 29 Oct 2024 14:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8902A2076AB;
	Tue, 29 Oct 2024 14:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tzxIMJcE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D48F206E99
	for <linux-iio@vger.kernel.org>; Tue, 29 Oct 2024 14:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730211228; cv=none; b=pTT2EFy3QO0S3xpzOOxLApF5JoZS2QyztZu4pQFOi+ZLaySxfa/IZj6xwIPpe9EpY7ZHQuk3XsMFXu8/OPqCGUZWd6aD9yjKsw7jHYP3nc6QHoTuRAHXKiucb2jd9Wlt3jAaLkhO/LgvmLfC/B7P/HTdZ9M/emIPnc3kUEHPcMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730211228; c=relaxed/simple;
	bh=BXdjI2YlKCR7g+MKVbJZnNL02lIFvK1zn+GNQyze4Qk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pAEjlvAZRafggQoI3zwYmeUSDpzbj2Cx6QdKLXWRoQZM6hL5Hn4ELB+X0F3YrIghd45v/pe1iZqH9ixDTaFcyetVxUX/CXou9mwldQulWP0po0E69FisUPaoAapZM2Fqysw4NKRYSn/Qv6y5p+E/aZX+ACRSUYE8ltHM82JPQFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tzxIMJcE; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d4d1b48f3so4059816f8f.1
        for <linux-iio@vger.kernel.org>; Tue, 29 Oct 2024 07:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730211223; x=1730816023; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RxIS8WnfphWdKVLUFiCF93GyflCiZBVANXevZugUg+g=;
        b=tzxIMJcEvg+6YfJPRCR/bcEhcXlfCUn7rGLSCfjCB3mseXiPg/WV85xfPqLizLRpW6
         vLHiaVLpp+5NlDi2mbbpCJuha/DXmKDO91AF/PQKuVrN1Z3rhGjt8j7s1ucq6Qs4h1gv
         Qu0G5dkruZoDdTzJEqei9DcenV8Ys3HVB+2Yp9OxcmMOSOqaAzuGlYNgoyfVsvWEIAej
         7luT0MAyAp4lOAMXTKg1G5vEsjq2fj5hrpStuOv5ylhCUNuMv7qskVc9+lfJgqmwpdHv
         YSlZ9Q5Ol+s9sr+YGophC/CMA9ANGUCIRrIqnjPXztsx4hytYV3PPnSiqhDbb6EWr7fK
         dqwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730211223; x=1730816023;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RxIS8WnfphWdKVLUFiCF93GyflCiZBVANXevZugUg+g=;
        b=C1/KDCxmxvkaS/h44nMBOyrHx1Jd7k3KJPfs6BpuUoAUNtlVvbzwPl9p5gA7mdX1ld
         yuQ+/z2uh0d/Alu/DawhWJvt3gegtU7F7znTj7bekL328v9cB8L65uzAKhGZnYljjTiw
         gQVtdJoUbs6k4E4rMjs+8UJ53vpbQnovD2/LfIljP4GYF4N7xonDNAoTZLAp5Bm+qAWM
         FMjKwSU0Ly7vQeqCCE5Umy0f5cNJRPwQ2a296SLXSzM4DsDDMJEA7PUQO2Bp9VzWTI2m
         xxMe1J8ZEOLW6o/E1TNyVSdf69MbHE2614eCWVsEE7OGhoiQOY0aEfcFd87GdhlxtBNz
         U5sQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjEKrJ0TC+Fgu6TQNsx/GRDLP1LEvtYdizlQoaYfeQiIAZYCVKj4mgeBP7B2Mj2ZjogfcgSRZCppQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw19y6pBYbly6E4As8iKSDN650ixnZbMfPwDeRlyhh/PiG4xJRm
	OVItyZ2Evu567OqgYJbxxISJrLgt6Mxp1yr8crz9gOll9qCNc3mybU2Y528+33M=
X-Google-Smtp-Source: AGHT+IFf89MRh/3FsABXLHVZ5TiIgJ7DTf+gOc2x1sK1H0Yy5yRS3BDP+K9+vtPRc1vT92s5uOaJ7Q==
X-Received: by 2002:a05:6000:149:b0:37c:d23a:1e4 with SMTP id ffacd0b85a97d-380611515eemr8852096f8f.30.1730211223364;
        Tue, 29 Oct 2024 07:13:43 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b714fesm12645871f8f.71.2024.10.29.07.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 07:13:42 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 29 Oct 2024 15:13:39 +0100
Subject: [PATCH v3 3/3] iio: magnetometer: add Allegro MicroSystems
 ALS31300 3-D Linear Hall Effect driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-topic-input-upstream-als31300-v3-3-147926dd63b3@linaro.org>
References: <20241029-topic-input-upstream-als31300-v3-0-147926dd63b3@linaro.org>
In-Reply-To: <20241029-topic-input-upstream-als31300-v3-0-147926dd63b3@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=16824;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=BXdjI2YlKCR7g+MKVbJZnNL02lIFvK1zn+GNQyze4Qk=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnIO2TkBX1s2PysOZmats1WfQMhwafBeS39Q2OvNch
 S6RPHumJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZyDtkwAKCRB33NvayMhJ0cC0D/
 wIOJ9nejJtnakWtv9gr+RkwjXLtvQ6oRa+gwzNbYcyt6/EQRl+8REkLxWl5Azk+Wm657uEDAUYFcLj
 n8Tk2CfYtL8bx1AfLbIXLViA7lhacwtI/zzXXJnXUC1vqYDQ59BgX/5j/U4DP28w/J7ZwOfKlE65U8
 oDFwQaA4crkj7rgh6MjGCCqA6mghf61zGUF/h5c4NLTzPSr/5JxaOnC4m0qKXlIaE2vZ8TG+ufI1sD
 8xS+v2bUx9A/RMJ7NwhB8OD9pW1XMvMRcTvSYOWwdYWeC0tSbfqsgwGA3mjyhiqYP4X4PT46ddQPjY
 3xVEQZQaxd03Tvafs9bfMonQdhCKnlBhFSPxRCegngS15GU0e/4H6SV/3lTiu45D4c1Oty2e3YhElY
 D+iuhXD6AaERSZohv5CVSZId3vAQw0mCMG+srSHZ6uW/PUcHnf1IOpiWlZVTmEjfSCbr0oYgWdjasy
 dppTLnJZejR5OhMpxY5knxcGCJt1PhjIhWfAM7dtJT4YWQVVCbFmSmXtAraQQHY/rTFn/5FSn5MCVD
 Ma/8yVOkRxFXuo+95LXpckK8p2T9/TXoNl3yiEEwdnac9w3UyTofr42z5ul3DN9CpRBsKA4l79zYqW
 9+OcigvDtRkTn60octrO34AywZ8xmLBs913+TnhMR5f7tbygFe3gHS2EFbwg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The Allegro MicroSystems ALS31300 is a 3-D Linear Hall Effect Sensor
mainly used for 3D head-on motion sensing applications.

The device is configured over I2C, and as part of the Sensor data the
temperature core is also provided.

While the device provides an IRQ gpio, it depends on a configuration
programmed into the internal EEPROM, thus only the default mode is
supported and buffered input via trigger is also supported to allow
streaming values with the same sensing timestamp.

The device can be configured with different sensitivities in factory,
but the sensitivity value used to calculate value into the Gauss
unit is not available from registers, thus the sensitivity is provided
by the compatible/device-id string which is based on the part number
as described in the datasheet page 2.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/iio/magnetometer/Kconfig    |  13 +
 drivers/iio/magnetometer/Makefile   |   1 +
 drivers/iio/magnetometer/als31300.c | 493 ++++++++++++++++++++++++++++++++++++
 3 files changed, 507 insertions(+)

diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
index 8eb718f5e50f3591082d33618b680ea22608fde8..e7adc11049d6f71b76da4569be4756e65f9dfd28 100644
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
index ec5c46fbf999b6403593de2c425079cf69a29cac..3e4c2ecd9adf865025d169a0d1d5feffd012e2f3 100644
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
index 0000000000000000000000000000000000000000..1cceac18c5ddd05ab8c81a541c0e9dc30e404ab2
--- /dev/null
+++ b/drivers/iio/magnetometer/als31300.c
@@ -0,0 +1,493 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Driver for the Allegro MicroSystems ALS31300 3-D Linear Hall Effect Sensor
+ *
+ * Copyright (c) 2024 Linaro Limited
+ */
+
+#include <linux/types.h>
+#include <linux/units.h>
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+#include <linux/pm.h>
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
+ * the device works and how the interrupt line behaves.
+ * Only the default setup with external trigger is supported.
+ *
+ * While the bindings supports declaring an interrupt line, those
+ * events are not supported.
+ *
+ * It should be possible to adapt the driver to the current
+ * device EEPROM setup at runtime.
+ */
+
+#define ALS31300_EEPROM_CONFIG		0x02
+#define ALS31300_EEPROM_INTERRUPT	0x03
+#define ALS31300_EEPROM_CUSTOMER_1	0x0d
+#define ALS31300_EEPROM_CUSTOMER_2	0x0e
+#define ALS31300_EEPROM_CUSTOMER_3	0x0f
+#define ALS31300_VOL_MODE		0x27
+#define ALS31300_VOL_MODE_LPDCM			GENMASK(6, 4)
+#define	  ALS31300_LPDCM_INACTIVE_0_5_MS	0
+#define   ALS31300_LPDCM_INACTIVE_1_0_MS	1
+#define   ALS31300_LPDCM_INACTIVE_5_0_MS	2
+#define   ALS31300_LPDCM_INACTIVE_10_0_MS	3
+#define   ALS31300_LPDCM_INACTIVE_50_0_MS	4
+#define   ALS31300_LPDCM_INACTIVE_100_0_MS	5
+#define   ALS31300_LPDCM_INACTIVE_500_0_MS	6
+#define   ALS31300_LPDCM_INACTIVE_1000_0_MS	7
+#define ALS31300_VOL_MODE_SLEEP			GENMASK(1, 0)
+#define   ALS31300_VOL_MODE_ACTIVE_MODE		0
+#define   ALS31300_VOL_MODE_SLEEP_MODE		1
+#define   ALS31300_VOL_MODE_LPDCM_MODE		2
+#define ALS31300_VOL_MSB		0x28
+#define ALS31300_VOL_MSB_TEMPERATURE		GENMASK(5, 0)
+#define ALS31300_VOL_MSB_INTERRUPT		BIT(6)
+#define ALS31300_VOL_MSB_NEW_DATA		BIT(7)
+#define ALS31300_VOL_MSB_Z_AXIS			GENMASK(15, 8)
+#define ALS31300_VOL_MSB_Y_AXIS			GENMASK(23, 16)
+#define ALS31300_VOL_MSB_X_AXIS			GENMASK(31, 24)
+#define ALS31300_VOL_LSB		0x29
+#define ALS31300_VOL_LSB_TEMPERATURE		GENMASK(5, 0)
+#define ALS31300_VOL_LSB_HALL_STATUS		GENMASK(7, 7)
+#define ALS31300_VOL_LSB_Z_AXIS			GENMASK(11, 8)
+#define ALS31300_VOL_LSB_Y_AXIS			GENMASK(15, 12)
+#define ALS31300_VOL_LSB_X_AXIS			GENMASK(19, 16)
+#define ALS31300_VOL_LSB_INTERRUPT_WRITE	BIT(20)
+#define ALS31300_CUSTOMER_ACCESS	0x35
+
+#define ALS31300_DATA_X_GET(b)		\
+		sign_extend32(FIELD_GET(ALS31300_VOL_MSB_X_AXIS, b[0]) << 4 | \
+			      FIELD_GET(ALS31300_VOL_LSB_X_AXIS, b[1]), 11)
+#define ALS31300_DATA_Y_GET(b)		\
+		sign_extend32(FIELD_GET(ALS31300_VOL_MSB_Y_AXIS, b[0]) << 4 | \
+			      FIELD_GET(ALS31300_VOL_LSB_Y_AXIS, b[1]), 11)
+#define ALS31300_DATA_Z_GET(b)		\
+		sign_extend32(FIELD_GET(ALS31300_VOL_MSB_Z_AXIS, b[0]) << 4 | \
+			      FIELD_GET(ALS31300_VOL_LSB_Z_AXIS, b[1]), 11)
+#define ALS31300_TEMPERATURE_GET(b)	\
+		(FIELD_GET(ALS31300_VOL_MSB_TEMPERATURE, b[0]) << 6 | \
+		 FIELD_GET(ALS31300_VOL_LSB_TEMPERATURE, b[1]))
+
+enum als31300_channels {
+	TEMPERATURE = 0,
+	AXIS_X,
+	AXIS_Y,
+	AXIS_Z,
+};
+
+struct als31300_variant_info {
+	u8 sensitivity;
+};
+
+struct als31300_data {
+	struct device *dev;
+	/* protects power on/off the device and access HW */
+	struct mutex mutex;
+	const struct als31300_variant_info *variant_info;
+	struct regmap *map;
+};
+
+/* The whole measure is split into 2x32bit registers, we need to read them both at once */
+static int als31300_get_measure(struct als31300_data *data,
+				u16 *t, s16 *x, s16 *y, s16 *z)
+{
+	u32 buf[2];
+	int ret, err;
+
+	guard(mutex)(&data->mutex);
+
+	ret = pm_runtime_resume_and_get(data->dev);
+	if (ret)
+		return ret;
+
+	/*
+	 * Loop until data is valid, new data should have the
+	 * ALS31300_VOL_MSB_NEW_DATA bit set to 1.
+	 * Max update rate is 2KHz, wait up to 1ms
+	 */
+	ret = read_poll_timeout(regmap_bulk_read, err,
+				err || FIELD_GET(ALS31300_VOL_MSB_NEW_DATA, buf[0]),
+				20, USEC_PER_MSEC, false,
+				data->map, ALS31300_VOL_MSB, buf, ARRAY_SIZE(buf));
+	/* Bail out on read_poll_timeout() error */
+	if (ret)
+		goto out;
+
+	/* Bail out on regmap_bulk_read() error */
+	if (err) {
+		dev_err(data->dev, "read data failed, error %d\n", ret);
+		ret = err;
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
+	return ret;
+}
+
+static int als31300_read_raw(struct iio_dev *indio_dev,
+			     const struct iio_chan_spec *chan, int *val,
+			     int *val2, long mask)
+{
+	struct als31300_data *data = iio_priv(indio_dev);
+	s16 x, y, z;
+	u16 t;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_PROCESSED:
+	case IIO_CHAN_INFO_RAW:
+		ret = als31300_get_measure(data, &t, &x, &y, &z);
+		if (ret)
+			return ret;
+
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
+			 *         1000 * 302 * (value - 1708)
+			 * temp = ----------------------------
+			 *             4096
+			 * to convert temperature in millicelcius
+			 */
+			*val = MILLI * 302;
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
+			*val2 = data->variant_info->sensitivity;
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
+	struct {
+		u16 temperature;
+		s16 channels[3];
+		aligned_s64 timestamp;
+	} scan;
+	s16 x, y, z;
+	int ret;
+	u16 t;
+
+	ret = als31300_get_measure(data, &t, &x, &y, &z);
+	if (ret)
+		goto trigger_out;
+
+	scan.temperature = t;
+	scan.channels[0] = x;
+	scan.channels[1] = y;
+	scan.channels[2] = z;
+	iio_push_to_buffers_with_timestamp(indio_dev, &scan,
+					   pf->timestamp);
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
+				      BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_OFFSET),
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
+	IIO_CHAN_SOFT_TIMESTAMP(4),
+};
+
+static const struct iio_info als31300_info = {
+	.read_raw = als31300_read_raw,
+};
+
+static int als31300_set_operating_mode(struct als31300_data *data,
+				       unsigned int val)
+{
+	int ret;
+
+	ret = regmap_update_bits(data->map, ALS31300_VOL_MODE,
+				 ALS31300_VOL_MODE_SLEEP, val);
+	if (ret) {
+		dev_err(data->dev, "failed to set operating mode (%pe)\n", ERR_PTR(ret));
+		return ret;
+	}
+
+	/* The time it takes to exit sleep mode is equivalent to Power-On Delay Time */
+	if (val == ALS31300_VOL_MODE_ACTIVE_MODE)
+		usleep_range(600, 650);
+
+	return 0;
+}
+
+static void als31300_power_down(void *data)
+{
+	als31300_set_operating_mode(data, ALS31300_VOL_MODE_SLEEP_MODE);
+}
+
+static const struct iio_buffer_setup_ops als31300_setup_ops = {};
+
+static const unsigned long als31300_scan_masks[] = { GENMASK(3, 0), 0 };
+
+static bool als31300_volatile_reg(struct device *dev, unsigned int reg)
+{
+	return reg == ALS31300_VOL_MSB || reg == ALS31300_VOL_LSB;
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
+	devm_mutex_init(dev, &data->mutex);
+
+	data->variant_info = i2c_get_match_data(i2c);
+	if (!data->variant_info)
+		return -EINVAL;
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
+	ret = als31300_set_operating_mode(data, ALS31300_VOL_MODE_ACTIVE_MODE);
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
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "iio triggered buffer setup failed\n");
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
+
+	return als31300_set_operating_mode(data, ALS31300_VOL_MODE_SLEEP_MODE);
+}
+
+static int als31300_runtime_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct als31300_data *data = iio_priv(indio_dev);
+
+	return als31300_set_operating_mode(data, ALS31300_VOL_MODE_ACTIVE_MODE);
+}
+
+static DEFINE_RUNTIME_DEV_PM_OPS(als31300_pm_ops,
+				 als31300_runtime_suspend, als31300_runtime_resume,
+				 NULL);
+
+static const struct als31300_variant_info al31300_variant_500 = {
+	.sensitivity = 4,
+};
+
+static const struct als31300_variant_info al31300_variant_1000 = {
+	.sensitivity = 2,
+};
+
+static const struct als31300_variant_info al31300_variant_2000 = {
+	.sensitivity = 1,
+};
+
+static const struct i2c_device_id als31300_id[] = {
+	{
+		.name = "als31300-500",
+		.driver_data = (kernel_ulong_t)&al31300_variant_500,
+	},
+	{
+		.name = "als31300-1000",
+		.driver_data = (kernel_ulong_t)&al31300_variant_1000,
+	},
+	{
+		.name = "als31300-2000",
+		.driver_data = (kernel_ulong_t)&al31300_variant_2000,
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(i2c, als31300_id);
+
+static const struct of_device_id als31300_of_match[] = {
+	{
+		.compatible = "allegromicro,als31300-500",
+		.data = &al31300_variant_500,
+	},
+	{
+		.compatible = "allegromicro,als31300-1000",
+		.data = &al31300_variant_1000,
+	},
+	{
+		.compatible = "allegromicro,als31300-2000",
+		.data = &al31300_variant_2000,
+	},
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


