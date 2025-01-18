Return-Path: <linux-iio+bounces-14441-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60062A15C6F
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2025 11:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A71DD3A69D1
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2025 10:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46CF17C9F1;
	Sat, 18 Jan 2025 10:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qo4kBUuD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA9C4A28;
	Sat, 18 Jan 2025 10:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737197760; cv=none; b=hcMD+bhHYfx9dRipU1Da0b//WifAKSnKRPIFye65hklMpMAzoIsDYiK0JuPyNbjWHPv8nt170OTRReLSUzOdXC4gwW7ssyvGLenZI9npm0CgRHry336u+HUt21oN8/9kELaZ4XK0iM5R6OxtU/rgfNWl+NUfPMAhL9LO1VTtfjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737197760; c=relaxed/simple;
	bh=8cNNS4ckxqtX/J2UR1pomoh48hcT9GDwKscsf3UXR1c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=MRdwjWQ7OJZ01aHBboYgYhJZk+gbJ9mDvGidrbnf7Xf0f52BrFRWdsXBd3NpaUZ4k3QKwy3B2NSYgns5YuVt2W2HhMK+cYTRvIs7KjLBOyYmMFqpa0/98ZWhNx/CTRsuQO2DSRF6D0UeQL8e+GVLAi39e1zNJi6hefPD2HYx6jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qo4kBUuD; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ee51f8c47dso4161862a91.1;
        Sat, 18 Jan 2025 02:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737197758; x=1737802558; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ilXC3iqVTC0fDvK+mT6z7xyzIdfiTgCazUyS4HUVF5I=;
        b=Qo4kBUuDhaHXVL8WHU0qcI7VwKJxCkV7jntZlzl1x2MadRx1QRGnM3IOhYSAzfrKWL
         G1Vr8ua4ACWcPTw1EWuQ6PiORebMLlJr8F3NMsNkjmBULgWCZVcm24hc91oYZoRor3ES
         3bCCNJONw46vnvxJywuDtzxFhMKb5ZMlc90mwQiEKbEadFP3zAn09McF2tA/MoyzIQ5O
         xZ02UkV7ZxsVKWbheMV+YHzFYL/2cUIKYhsNnV3UleP8ktjVHfWCycoyGRcbqd5hRIho
         /zNPY/EHNkN2MEk07W/AFs71v0T5ZE7pKULOo5fPdHs8uq42XQdoyYpAYSJ1SLVE7lV1
         RxBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737197758; x=1737802558;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ilXC3iqVTC0fDvK+mT6z7xyzIdfiTgCazUyS4HUVF5I=;
        b=RLApb8xYFawBTOaX70xjo9RdQ4mPRk/vwiyboEe+xBZDOFL8ObDHxFqMPuCBXBxXlu
         jOUC6LjRcpJP5ZNES8q4lUUFwpnbO360hWCppJISd+8aPPDcD+QMfsfrk2OZT9G4oDHk
         9QHqiVEQVX2ifzrplI9j4Iw90IgpO9oGnJleMz/BfbY+A0AwSUE2FS6w0VpSfUUsEiN5
         gLGHBYkFlS+QEBy8R/3pETVBuMG7uGoENShrxY67zv5fdMzNZAiYdkq/6TIXwmckOS4i
         FmyBOcZyfgpjPFPHUXiCKtVv9wyW/0etkdt0eAuzVr5Ak9huzbiqjOrZFjTnWyn5Tmk3
         wj7w==
X-Forwarded-Encrypted: i=1; AJvYcCVEr7LXn3AO3IjzULZFViLH6qJhGikJEplLOGYCPG6ehUItvm7Jmp/JT697Owgvu5+tDIH9kzf2kNEm58Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4kO9MIQe2MUBjq48nRiPjrEM1KDW0AYRePqLcMUcAxSMW8HP6
	k0TYJnxBFYB/VYbULVQYFkNbk2aM6X6I3AbEnuRn3yePW5ciSz39
X-Gm-Gg: ASbGncut4OW0YPfX/sb8brVIyc78TTcYDEqphEec8x1/nVm3FKL7VDvMLWWmqnYaoiR
	0IMtTjA1EYzh7LBURK5u39t9/Yij1WFa1sGmsUtiFi+MNag/8g5yvvhGMInMnTNOOjn7GHz0/zu
	oArElfH2VK1W04FFkTbOOFSzRh6FfLBJfDOnmFC+mBfETTzzzA8WcAGB69WH0NrMNZJzd9+Nfgf
	Zn8QsFzv9lFQnY7ziM2piVjqasKOKxyfvs53nOoBofewB2UlFxExF0cVxemXrCL8ZwTfHNEcv8n
	ZUku
X-Google-Smtp-Source: AGHT+IFgeVbHcGCzBLiXn5Jz+/p6TenJAv9ibMYjVA0Wds81iersqpVYw36kl8sgYiYbKSpZux+aQQ==
X-Received: by 2002:a17:90b:4b8c:b0:2f4:9e8b:6aad with SMTP id 98e67ed59e1d1-2f782b11be1mr11119510a91.0.1737197758035;
        Sat, 18 Jan 2025 02:55:58 -0800 (PST)
Received: from [192.168.0.110] ([189.101.161.220])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7761a9b4esm4171919a91.28.2025.01.18.02.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2025 02:55:57 -0800 (PST)
From: Gustavo Silva <gustavograzs@gmail.com>
Date: Sat, 18 Jan 2025 07:55:49 -0300
Subject: [PATCH v2] iio: imu: bmi270: add temperature channel
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250118-bmi270-temp-v2-1-50bc85f36ab2@gmail.com>
X-B4-Tracking: v=1; b=H4sIALSIi2cC/23MywqDMBCF4VeRWTclM+KtK9+juPAy6kBjJJHQI
 nn3pq67/A+c7wTPTtjDIzvBcRAvdktBtwzGtd8WVjKlBtJUaERUgxGqtDrY7IqbiYq8xAZrDem
 xO57lfWnPLvUq/rDuc+EBf+t/J6BCVZXMeU2Iw0ztYnp53UdroIsxfgEgVgy5pgAAAA==
X-Change-ID: 20250111-bmi270-temp-e9d253619180
To: Alex Lanzano <lanzano.alex@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gustavo Silva <gustavograzs@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737197755; l=5477;
 i=gustavograzs@gmail.com; s=20250111; h=from:subject:message-id;
 bh=8cNNS4ckxqtX/J2UR1pomoh48hcT9GDwKscsf3UXR1c=;
 b=/K4eSd5XTF0QI7Li5ncGwZ6Xg0OhLULnWHQHnYj4nCYNrK9yWKvAJPp98zfn5Y2FaPcTIS/oc
 2g/bi0B6UCxCfv5H/3JCWucqTHzARqEpZrsN2WccvvzHw22b+xNmUEu
X-Developer-Key: i=gustavograzs@gmail.com; a=ed25519;
 pk=g2TFXpo1jMCOCN+rzVoM9NDFNfSMOgVyY0rlyvk4RTM=

The BMI270 IMU includes a temperature sensor. Add a channel for reading
the temperature.

Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>
---
Changes in v2:
- Use 'MICRO' instead of 'MEGA' for scale values
- Remove unintended whitespace change
- Link to v1: https://lore.kernel.org/r/20250111-bmi270-temp-v1-1-76ee38211bf2@gmail.com
---
 drivers/iio/imu/bmi270/bmi270_core.c | 48 ++++++++++++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
index 7fec52e0b48624f07031b63a9caf6c318f33f5dc..0f89554d6cd321aeda6175cc17663cc7ad83b8e6 100644
--- a/drivers/iio/imu/bmi270/bmi270_core.c
+++ b/drivers/iio/imu/bmi270/bmi270_core.c
@@ -5,6 +5,7 @@
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
+#include <linux/units.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -28,10 +29,11 @@
 #define BMI270_INTERNAL_STATUS_REG			0x21
 #define BMI270_INTERNAL_STATUS_MSG_MSK			GENMASK(3, 0)
 #define BMI270_INTERNAL_STATUS_MSG_INIT_OK		0x01
-
 #define BMI270_INTERNAL_STATUS_AXES_REMAP_ERR_MSK	BIT(5)
 #define BMI270_INTERNAL_STATUS_ODR_50HZ_ERR_MSK		BIT(6)
 
+#define BMI270_TEMPERATURE_0_REG			0x22
+
 #define BMI270_ACC_CONF_REG				0x40
 #define BMI270_ACC_CONF_ODR_MSK				GENMASK(3, 0)
 #define BMI270_ACC_CONF_ODR_100HZ			0x08
@@ -69,6 +71,10 @@
 #define BMI270_PWR_CTRL_ACCEL_EN_MSK			BIT(2)
 #define BMI270_PWR_CTRL_TEMP_EN_MSK			BIT(3)
 
+/* See datasheet section 4.6.14, Temperature Sensor */
+#define BMI270_TEMP_OFFSET				11776
+#define BMI270_TEMP_SCALE				1953125
+
 #define BMI260_INIT_DATA_FILE "bmi260-init-data.fw"
 #define BMI270_INIT_DATA_FILE "bmi270-init-data.fw"
 
@@ -109,6 +115,7 @@ EXPORT_SYMBOL_NS_GPL(bmi270_chip_info, "IIO_BMI270");
 enum bmi270_sensor_type {
 	BMI270_ACCEL	= 0,
 	BMI270_GYRO,
+	BMI270_TEMP,
 };
 
 struct bmi270_scale {
@@ -136,6 +143,10 @@ static const struct bmi270_scale bmi270_gyro_scale[] = {
 	{ 0, 66 },
 };
 
+static const struct bmi270_scale bmi270_temp_scale[] = {
+	{BMI270_TEMP_SCALE / MICRO, BMI270_TEMP_SCALE % MICRO},
+};
+
 struct bmi270_scale_item {
 	const struct bmi270_scale *tbl;
 	int num;
@@ -150,6 +161,10 @@ static const struct bmi270_scale_item bmi270_scale_table[] = {
 		.tbl	= bmi270_gyro_scale,
 		.num	= ARRAY_SIZE(bmi270_gyro_scale),
 	},
+	[BMI270_TEMP] = {
+		.tbl	= bmi270_temp_scale,
+		.num	= ARRAY_SIZE(bmi270_temp_scale),
+	},
 };
 
 static const struct bmi270_odr bmi270_accel_odr[] = {
@@ -255,7 +270,7 @@ static int bmi270_set_scale(struct bmi270_data *data, int chan_type, int uscale)
 }
 
 static int bmi270_get_scale(struct bmi270_data *bmi270_device, int chan_type,
-			    int *uscale)
+			    int *scale, int *uscale)
 {
 	int ret;
 	unsigned int val;
@@ -280,6 +295,10 @@ static int bmi270_get_scale(struct bmi270_data *bmi270_device, int chan_type,
 		val = FIELD_GET(BMI270_GYR_CONF_RANGE_MSK, val);
 		bmi270_scale_item = bmi270_scale_table[BMI270_GYRO];
 		break;
+	case IIO_TEMP:
+		val = 0;
+		bmi270_scale_item = bmi270_scale_table[BMI270_TEMP];
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -287,6 +306,7 @@ static int bmi270_get_scale(struct bmi270_data *bmi270_device, int chan_type,
 	if (val >= bmi270_scale_item.num)
 		return -EINVAL;
 
+	*scale = bmi270_scale_item.tbl[val].scale;
 	*uscale = bmi270_scale_item.tbl[val].uscale;
 	return 0;
 }
@@ -399,6 +419,9 @@ static int bmi270_get_data(struct bmi270_data *bmi270_device,
 	case IIO_ANGL_VEL:
 		reg = BMI270_ANG_VEL_X_REG + (axis - IIO_MOD_X) * 2;
 		break;
+	case IIO_TEMP:
+		reg = BMI270_TEMPERATURE_0_REG;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -427,9 +450,16 @@ static int bmi270_read_raw(struct iio_dev *indio_dev,
 
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		*val = 0;
-		ret = bmi270_get_scale(bmi270_device, chan->type, val2);
+		ret = bmi270_get_scale(bmi270_device, chan->type, val, val2);
 		return ret ? ret : IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_OFFSET:
+		switch (chan->type) {
+		case IIO_TEMP:
+			*val = BMI270_TEMP_OFFSET;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		ret = bmi270_get_odr(bmi270_device, chan->type, val, val2);
 		return ret ? ret : IIO_VAL_INT_PLUS_MICRO;
@@ -544,6 +574,13 @@ static const struct iio_chan_spec bmi270_channels[] = {
 	BMI270_ANG_VEL_CHANNEL(X),
 	BMI270_ANG_VEL_CHANNEL(Y),
 	BMI270_ANG_VEL_CHANNEL(Z),
+	{
+		.type = IIO_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_OFFSET),
+		.scan_index = -1, /* No buffer support */
+	},
 	IIO_CHAN_SOFT_TIMESTAMP(BMI270_SCAN_TIMESTAMP),
 };
 
@@ -646,7 +683,8 @@ static int bmi270_configure_imu(struct bmi270_data *bmi270_device)
 	ret = regmap_set_bits(regmap, BMI270_PWR_CTRL_REG,
 			      BMI270_PWR_CTRL_AUX_EN_MSK |
 			      BMI270_PWR_CTRL_GYR_EN_MSK |
-			      BMI270_PWR_CTRL_ACCEL_EN_MSK);
+			      BMI270_PWR_CTRL_ACCEL_EN_MSK |
+			      BMI270_PWR_CTRL_TEMP_EN_MSK);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to enable accelerometer and gyroscope");
 

---
base-commit: 577a66e2e634f712384c57a98f504c44ea4b47da
change-id: 20250111-bmi270-temp-e9d253619180

Best regards,
-- 
Gustavo Silva <gustavograzs@gmail.com>


