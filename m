Return-Path: <linux-iio+bounces-11834-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 671679BA047
	for <lists+linux-iio@lfdr.de>; Sat,  2 Nov 2024 14:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DCB21C20C05
	for <lists+linux-iio@lfdr.de>; Sat,  2 Nov 2024 13:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C9119CC3C;
	Sat,  2 Nov 2024 13:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXvGOppR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E14118A925;
	Sat,  2 Nov 2024 13:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730553212; cv=none; b=MIPZ3bxchok5xh+4cHgtho6VK/oxRTor+ZvzxopP7bCPiBAvLwBaPcWujUtNqP3Nh4Pu11GkwenwxIaSH+KTv8V0YJpEq89AylwP6ZiqDsBHVtnKIsRCoKSmTE7lpn2tqBLegpIuKyhXMIiCMufuxNlwVTDkhiL4e4zt+ITt3cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730553212; c=relaxed/simple;
	bh=7zHkW07VE4G+KlDd97FTSWyFbdEYftQNN9LdHd0WbHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SDFzYNO/cHejFeHNVzlZJuf2/kXRNRWDSAwyd1iIk65cjda+nv4P0FMW/jCTUusyXwnAAYmU5fFLTElwqZDDKjFQvA0kMu1KMbOzJpDAlFRBX6SFsVpZ4sI0eBJZ9BwwMVTg4xhotXo5QDwCcISZZI6vNKtgGy1rTUohiOzvWuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXvGOppR; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d49a7207cso1798224f8f.0;
        Sat, 02 Nov 2024 06:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730553209; x=1731158009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XC8udOzSRteZ7eNrWAXeLvof8SAQ9Jq2fsHq7ONSNCU=;
        b=NXvGOppRIbD02vfwv0pI48sguV+7VjQ147ceIKgMJLVlX4yMiVrmR8edncqDYNq/MO
         5KvsH7221CchvE6H8UxzVBO5lQyEJ/ZCLDL4ZkzxQHMR7J6xrXvnQ++AwKhOq6Xx5BxW
         fIgbJZuMuTtf2prIGJtz21BF/i86ldOi4MrtFev7wHDRgeNL/rsjP5nQh6ivN3fu0XFe
         PCILKrEzh+mqfibHT7z3aJgLZWRJUALpMAbpYyUo1WJiLU5R9e0CNUWd9koihLp1O0s1
         AT1EYYJDRL8vIiugrhmye2Y/lxQ5sV18zJ8N2XZuu1Um1KehS8LQwJqV0C9lqe/5hTg7
         DVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730553209; x=1731158009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XC8udOzSRteZ7eNrWAXeLvof8SAQ9Jq2fsHq7ONSNCU=;
        b=eMUirNXp/tt8eyHcvLlRD0bCy1d6DB0EHfIfaqM7DDSSBvtAOK3ty0hdxToiKbZ3u/
         +5lAqrvBjOAX7Z3M53mSFiDwSkFn4JqA7Y71XrLFgPsQ6q+R31e0VUl3zhWz+guDCmSV
         hpudy5o5cH0hAYirXk+1oNF9J6S8TuKZAe/YFC5IQfroyOsCzaKvK+6IVuECwMUMLzSK
         PMAmDtH6qo1ZOFBwc2E+5xmmt9kDNtRKJLvIkZcBbhXedXFdn7TTQiHG9Zwc1QbB5S6u
         f8on5EQSzqTOS46MJlmNBjaF03oZ3/FdOtMpmwNA7w//b6uYm7gvxHrJO055aFbDVJi6
         /Yiw==
X-Forwarded-Encrypted: i=1; AJvYcCUFYe29hARjH7oSsGPMaIDO/lqiGhwkHrwM3m6+QPaLxtWUt5fgI7VKKZ1DFfFaz4fq4RU6VCx+PATp@vger.kernel.org, AJvYcCUfjNX0oZsM34XPpuIQJzuZ2VpM0hqBt8U9V5HPHnZDdqO2/ayYVwYbn0RmkY1GG5gd35KAl8796Rr3x+BT@vger.kernel.org, AJvYcCX+7U46rclF0Fpv0hD6qbZO+iYM8ogkBPoM22E422bxZXw4zV7pklJmdojqTI/ymez/1PJ8ftELLTr5@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2eoA+9izWVi8rzlBcfkmv15p8OPfoi7gg6JZVkVz8DMdFSoal
	MGIrAZGFQfRP/SgwkxcXquICS2uH9BuZgiw4RXciqH2/0cdSrRkytlxjx1zN
X-Google-Smtp-Source: AGHT+IGg5RzG/e2A7vGkkYRjDa3UjnErQAyZ/n8CjyCqGhzZGZxbV8U5XBIYqH3smkpvOoAr4aih4w==
X-Received: by 2002:a5d:6d0e:0:b0:37c:cc60:2c63 with SMTP id ffacd0b85a97d-381c7a3a23dmr5866217f8f.5.1730553208690;
        Sat, 02 Nov 2024 06:13:28 -0700 (PDT)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:b243:5cd3:bfdd:a16e])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-381c113e5cbsm8081570f8f.80.2024.11.02.06.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 06:13:28 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com
Cc: vassilisamir@gmail.com,
	anshulusr@gmail.com,
	gustavograzs@gmail.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/7] iio: chemical: bme680: Add support for preheat current
Date: Sat,  2 Nov 2024 14:13:08 +0100
Message-ID: <20241102131311.36210-5-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241102131311.36210-1-vassilisamir@gmail.com>
References: <20241102131311.36210-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add functionality to inject a specified amount of current to the heating
plate before the start of the gas measurement to allow the sensor to reach
faster to the requested temperature.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680.h      |  1 +
 drivers/iio/chemical/bme680_core.c | 41 ++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/iio/chemical/bme680.h b/drivers/iio/chemical/bme680.h
index a0a7794543c8..00ab89b3138b 100644
--- a/drivers/iio/chemical/bme680.h
+++ b/drivers/iio/chemical/bme680.h
@@ -42,6 +42,7 @@
 #define   BME680_RHRANGE_MASK			GENMASK(5, 4)
 #define BME680_REG_RES_HEAT_VAL			0x00
 #define   BME680_RSERROR_MASK			GENMASK(7, 4)
+#define BME680_REG_IDAC_HEAT_0			0x50
 #define BME680_REG_RES_HEAT_0			0x5A
 #define BME680_REG_GAS_WAIT_0			0x64
 #define BME680_ADC_GAS_RES			GENMASK(15, 6)
diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 6df87383c243..6cc1cb9e0477 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -118,6 +118,7 @@ struct bme680_data {
 	u8 oversampling_temp;
 	u8 oversampling_press;
 	u8 oversampling_humid;
+	u8 preheat_curr_mA;
 	u16 heater_dur;
 	u16 heater_temp;
 
@@ -214,6 +215,12 @@ static const struct iio_chan_spec bme680_channels[] = {
 		},
 	},
 	IIO_CHAN_SOFT_TIMESTAMP(4),
+	{
+		.type = IIO_CURRENT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+		.output = 1,
+		.scan_index = -1,
+	},
 };
 
 static int bme680_read_calib(struct bme680_data *data,
@@ -561,6 +568,12 @@ static u8 bme680_calc_heater_dur(u16 dur)
 	return durval;
 }
 
+/* Taken from datasheet, section 5.3.3 */
+static u8 bme680_calc_heater_preheat_current(u8 curr)
+{
+	return 8 * curr - 1;
+}
+
 static int bme680_set_mode(struct bme680_data *data, enum bme680_op_mode mode)
 {
 	struct device *dev = regmap_get_device(data->regmap);
@@ -659,6 +672,20 @@ static int bme680_chip_config(struct bme680_data *data)
 	return 0;
 }
 
+static int bme680_preheat_curr_config(struct bme680_data *data, u8 val)
+{
+	struct device *dev = regmap_get_device(data->regmap);
+	u8 heatr_curr;
+	int ret;
+
+	heatr_curr = bme680_calc_heater_preheat_current(val);
+	ret = regmap_write(data->regmap, BME680_REG_IDAC_HEAT_0, heatr_curr);
+	if (ret < 0)
+		dev_err(dev, "failed to write idac_heat_0 register\n");
+
+	return ret;
+}
+
 static int bme680_gas_config(struct bme680_data *data)
 {
 	struct device *dev = regmap_get_device(data->regmap);
@@ -687,6 +714,10 @@ static int bme680_gas_config(struct bme680_data *data)
 		return ret;
 	}
 
+	ret = bme680_preheat_curr_config(data, data->preheat_curr_mA);
+	if (ret)
+		return ret;
+
 	/* Enable the gas sensor and select heater profile set-point 0 */
 	ret = regmap_update_bits(data->regmap, BME680_REG_CTRL_GAS_1,
 				 BME680_RUN_GAS_MASK | BME680_NB_CONV_MASK,
@@ -939,6 +970,15 @@ static int bme680_write_raw(struct iio_dev *indio_dev,
 
 		return bme680_chip_config(data);
 	}
+	case IIO_CHAN_INFO_PROCESSED:
+	{
+		switch (chan->type) {
+		case IIO_CURRENT:
+			return bme680_preheat_curr_config(data, (u8)val);
+		default:
+			return -EINVAL;
+		}
+	}
 	default:
 		return -EINVAL;
 	}
@@ -1074,6 +1114,7 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
 	data->oversampling_temp = 8;  /* 8X oversampling rate */
 	data->heater_temp = 320; /* degree Celsius */
 	data->heater_dur = 150;  /* milliseconds */
+	data->preheat_curr_mA = 0;
 
 	ret = regmap_write(regmap, BME680_REG_SOFT_RESET, BME680_CMD_SOFTRESET);
 	if (ret < 0)
-- 
2.43.0


