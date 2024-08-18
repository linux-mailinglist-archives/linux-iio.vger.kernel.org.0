Return-Path: <linux-iio+bounces-8571-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32669955D18
	for <lists+linux-iio@lfdr.de>; Sun, 18 Aug 2024 17:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 560AE1C20A5E
	for <lists+linux-iio@lfdr.de>; Sun, 18 Aug 2024 15:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AF01422D2;
	Sun, 18 Aug 2024 15:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmGBWZzQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F462942A;
	Sun, 18 Aug 2024 15:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723993793; cv=none; b=hrO/FLEHcNiJujqs+plQ9DDg/bj0U/xDNMcLV8sjXQhRaOIelJBt++0HZPS31Kejy6tqYJZtHX/SPuabNyg661Vnm6J+5xu2q61UIvuZVpZT0LbtQBlAgY5bwwLbnCNL1gm/dgHKqCRN+WxM/pJxijZOPDWTTQsUpAZizwhF8qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723993793; c=relaxed/simple;
	bh=TivfOUfHwdHuaLI/XDV8RQTL/MqGeDsvvgz3LDiisvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IF4iIPCVsoJ08IlhQ92FsLxksG6vISqE/lNaJNhJr71bqv0tDSc9T2oB7gwSjUflbRQHyUIYCSYS0LT4uNF42YMtcmxaTXEK/wlhEsDhRV0z1H32oEpCjmFxZlqSaceygWlZu2qjjIYb6EBYrshdAe7FEqZaqcE2Xj3huu2+9Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EmGBWZzQ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4280b3a7efaso26520045e9.0;
        Sun, 18 Aug 2024 08:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723993790; x=1724598590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96TeNwTGymqEsoDtP+JIVi4x/g1+D0nKb1HsS7srL1U=;
        b=EmGBWZzQpclnwvps74iGlFJNyYfaSmoNGu4NvxCiFKXenE0nFxL8TUiPFem72enFc6
         MnjPxzy3sPEEcuKTLWKCzecUHHU8B4TXMFRVBNZC9DItOTtbKTUbW4ej3vE9hHZkcSJU
         ZIczYJ48DvJfPJxvwNXkrGiUBwQ5Si7/Sb2NO14MzkAV9Xiwa6YXiaZ8JZIRDYWM3dsy
         ki35JMldgtIyXo8sxJnzdz8QItY9u6rG6DE7YVx9TvzyvslFLtBfF3rJhEELd9xUduvK
         GL6OtMO0F79Z12Fn0d9j/+ZLTHXEWdj01qNhAldsxxC5tchMtyDPkRDkhI304Qa8yMh3
         9bWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723993790; x=1724598590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=96TeNwTGymqEsoDtP+JIVi4x/g1+D0nKb1HsS7srL1U=;
        b=JoCyMKg+JSj9iZPWVEPmNa2HSkGjr/Sd4WizxofDdde3en6Zx5YrXW5W2kaaUbFjj5
         EkueVAXOGHVjPZYrNP+xb8+9kmBYv4La5vH2jdgdMIzr6WzGHjcCe2nyvFoSdVfoJvDz
         hnxo5CIhJZo7WcWmbyALy+WuFj+YH0TtgP19n/ph0RJAHIPdnIPz8ruoUBvDlhu6mvck
         PbrYBkvUukSAiapGjqAzvN8ziZCSS8QbgHMVMTGSz31ugQUA1rzte9KYX5z5FDIOaj0E
         71Xy1w73J3ZsIeIqP/vBz5uJrnJ7SrxIVH9nMKiwuWFp4SdZnF7pF1oXOnmRQn2ZI9xS
         s99w==
X-Forwarded-Encrypted: i=1; AJvYcCU16VBNlEBiVBBt0zDCRjp8hgbk9AvV0Wq3a+n5ZqGLf+VGFDsx3k26y3s4GIY4wMfEzIcr3UtzmnfjQsad@vger.kernel.org, AJvYcCVXPXaOsxQPftmK9iLMDe3ZaLs78gXMleSXBAoyR53sLJBqxct8UgmIBChoOS64bt56Mdzq4qXCVNc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz05XVu0EycjD/BipLOLrJupfTgGYinlaaCs/Dkk/BBIywRKaJW
	CfT2IySuzND4rdBQRhWNm++MKosb/7t5HLiV+j6Z4MhvRAKOjidw
X-Google-Smtp-Source: AGHT+IEitVK34Rzf3QLYWWcCidnzaO4Dabc4GK1seM0rF8CotB49882CrYDjuJHa1F7cs4FnFtQnkA==
X-Received: by 2002:adf:a39a:0:b0:367:9d2c:95f4 with SMTP id ffacd0b85a97d-371946a3485mr5182305f8f.47.1723993789821;
        Sun, 18 Aug 2024 08:09:49 -0700 (PDT)
Received: from localhost.localdomain ([151.95.42.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429d877f234sm141972345e9.1.2024.08.18.08.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 08:09:49 -0700 (PDT)
From: Denis Benato <benato.denis96@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jagath Jog J <jagathjog1996@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D . Jones" <luke@ljones.dev>,
	Jonathan LoBue <jlobue10@gmail.com>,
	Denis Benato <benato.denis96@gmail.com>
Subject: [PATCH v2] iio: bmi323: peripheral in lowest power state on suspend
Date: Sun, 18 Aug 2024 17:09:23 +0200
Message-ID: <20240818150923.20387-2-benato.denis96@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240818150923.20387-1-benato.denis96@gmail.com>
References: <20240817134911.6043c798@jic23-huawei>
 <20240818150923.20387-1-benato.denis96@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bmi323 is mounted on some devices that are powered
by an internal battery: help in reducing system overall power drain
while the system is in s2idle or the imu driver is not loaded
by resetting it in its lowest power draining state.

Signed-off-by: Denis Benato <benato.denis96@gmail.com>
---
 drivers/iio/imu/bmi323/bmi323_core.c | 225 ++++++++++++++++++++++++++-
 1 file changed, 223 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/bmi323/bmi323_core.c b/drivers/iio/imu/bmi323/bmi323_core.c
index 4b2b211a3e88..5d383fffe083 100644
--- a/drivers/iio/imu/bmi323/bmi323_core.c
+++ b/drivers/iio/imu/bmi323/bmi323_core.c
@@ -118,6 +118,84 @@ static const struct bmi323_hw bmi323_hw[2] = {
 	},
 };
 
+struct bmi323_reg_runtime_pm {
+	unsigned int reg;
+};
+
+static const struct bmi323_reg_runtime_pm bmi323_reg_savestate[] = {
+	{
+		.reg = BMI323_INT_MAP1_REG
+	},
+	{
+		.reg = BMI323_INT_MAP2_REG
+	},
+	{
+		.reg = BMI323_IO_INT_CTR_REG
+	},
+	{
+		.reg = BMI323_IO_INT_CONF_REG
+	},
+	{
+		.reg = BMI323_ACC_CONF_REG
+	},
+	{
+		.reg = BMI323_GYRO_CONF_REG
+	},
+	{
+		.reg = BMI323_FEAT_IO0_REG
+	},
+	{
+		.reg = BMI323_FIFO_WTRMRK_REG
+	},
+	{
+		.reg = BMI323_FIFO_CONF_REG
+	}
+};
+
+static const struct bmi323_reg_runtime_pm bmi323_ext_reg_savestate[] = {
+	{
+		.reg = BMI323_GEN_SET1_REG
+	},
+	{
+		.reg = BMI323_TAP1_REG
+	},
+	{
+		.reg = BMI323_TAP2_REG
+	},
+	{
+		.reg = BMI323_TAP3_REG
+	},
+	{
+		.reg = BMI323_FEAT_IO0_S_TAP_MSK
+	},
+	{
+		.reg = BMI323_STEP_SC1_REG
+	},
+	{
+		.reg = BMI323_ANYMO1_REG
+	},
+	{
+		.reg = BMI323_NOMO1_REG
+	},
+	{
+		.reg = BMI323_ANYMO1_REG + BMI323_MO2_OFFSET
+	},
+	{
+		.reg = BMI323_NOMO1_REG + BMI323_MO2_OFFSET
+	},
+	{
+		.reg = BMI323_ANYMO1_REG + BMI323_MO3_OFFSET
+	},
+	{
+		.reg = BMI323_NOMO1_REG + BMI323_MO3_OFFSET
+	}
+};
+
+struct bmi323_regs_runtime_pm {
+	unsigned int reg_settings[ARRAY_SIZE(bmi323_reg_savestate)];
+	unsigned int ext_reg_settings[ARRAY_SIZE(bmi323_ext_reg_savestate)];
+};
+
 struct bmi323_data {
 	struct device *dev;
 	struct regmap *regmap;
@@ -130,6 +208,7 @@ struct bmi323_data {
 	u32 odrns[BMI323_SENSORS_CNT];
 	u32 odrhz[BMI323_SENSORS_CNT];
 	unsigned int feature_events;
+	struct bmi323_regs_runtime_pm runtime_pm_status;
 
 	/*
 	 * Lock to protect the members of device's private data from concurrent
@@ -1972,6 +2051,11 @@ static void bmi323_disable(void *data_ptr)
 
 	bmi323_set_mode(data, BMI323_ACCEL, ACC_GYRO_MODE_DISABLE);
 	bmi323_set_mode(data, BMI323_GYRO, ACC_GYRO_MODE_DISABLE);
+
+	/*
+	 * Place the peripheral in its lowest power consuming state.
+	 */
+	regmap_write(data->regmap, BMI323_CMD_REG, BMI323_RST_VAL);
 }
 
 static int bmi323_set_bw(struct bmi323_data *data,
@@ -2030,6 +2114,13 @@ static int bmi323_init(struct bmi323_data *data)
 		return dev_err_probe(data->dev, -EINVAL,
 				     "Sensor power error = 0x%x\n", val);
 
+	return 0;
+}
+
+static int bmi323_init_reset(struct bmi323_data *data)
+{
+	int ret;
+
 	/*
 	 * Set the Bandwidth coefficient which defines the 3 dB cutoff
 	 * frequency in relation to the ODR.
@@ -2078,12 +2169,18 @@ int bmi323_core_probe(struct device *dev)
 	data = iio_priv(indio_dev);
 	data->dev = dev;
 	data->regmap = regmap;
+	data->irq_pin = BMI323_IRQ_DISABLED;
+	data->state = BMI323_IDLE;
 	mutex_init(&data->mutex);
 
 	ret = bmi323_init(data);
 	if (ret)
 		return -EINVAL;
 
+	ret = bmi323_init_reset(data);
+	if (ret)
+		return -EINVAL;
+
 	if (!iio_read_acpi_mount_matrix(dev, &data->orientation, "ROTM")) {
 		ret = iio_read_mount_matrix(dev, &data->orientation);
 		if (ret)
@@ -2117,7 +2214,7 @@ int bmi323_core_probe(struct device *dev)
 		return dev_err_probe(data->dev, ret,
 				     "Unable to register iio device\n");
 
-	return 0;
+	return bmi323_fifo_disable(data);
 }
 EXPORT_SYMBOL_NS_GPL(bmi323_core_probe, IIO_BMI323);
 
@@ -2125,13 +2222,137 @@ EXPORT_SYMBOL_NS_GPL(bmi323_core_probe, IIO_BMI323);
 static int bmi323_core_runtime_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct bmi323_data *data = iio_priv(indio_dev);
+	struct bmi323_regs_runtime_pm *savestate = &data->runtime_pm_status;
+
+	int ret;
 
-	return iio_device_suspend_triggering(indio_dev);
+	guard(mutex)(&data->mutex);
+
+	ret = iio_device_suspend_triggering(indio_dev);
+	if (ret)
+		return ret;
+
+	/*
+	 * Save registers meant to be restored by resume pm callback.
+	 */
+	for (unsigned int i = 0; i < ARRAY_SIZE(bmi323_reg_savestate); i++) {
+		const unsigned int reg_addr = bmi323_reg_savestate[i].reg;
+		unsigned int *reg_val = &savestate->reg_settings[i];
+
+		ret = regmap_read(data->regmap, reg_addr, reg_val);
+		if (ret) {
+			dev_err(data->dev, "Error reading bmi323 reg 0x%x: %d\n",
+				  reg_addr, ret);
+			return ret;
+		}
+	}
+
+	/*
+	 * Save external registers meant to be restored by resume pm callback.
+	 */
+	for (unsigned int i = 0; i < ARRAY_SIZE(bmi323_ext_reg_savestate); i++) {
+		const unsigned int ext_reg_addr = bmi323_reg_savestate[i].reg;
+		unsigned int *ext_reg_val = &savestate->reg_settings[i];
+
+		ret = bmi323_read_ext_reg(data, ext_reg_addr, ext_reg_val);
+		if (ret) {
+			dev_err(data->dev, "Error reading bmi323 external reg 0x%x: %d\n",
+				  ext_reg_addr, ret);
+			return ret;
+		}
+	}
+
+	/*
+	 * Perform soft reset to place the device in its lowest power state.
+	 */
+	ret = regmap_write(data->regmap, BMI323_CMD_REG, BMI323_RST_VAL);
+	if (ret)
+		return ret;
+
+	return 0;
 }
 
 static int bmi323_core_runtime_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct bmi323_data *data = iio_priv(indio_dev);
+	struct bmi323_regs_runtime_pm *savestate = &data->runtime_pm_status;
+
+	int ret;
+
+	guard(mutex)(&data->mutex);
+
+	/*
+	 * Perform the device power-on and initial setup once again
+	 * after being reset in the lower power state by runtime-pm.
+	 */
+	ret = bmi323_init(data);
+	if (!ret)
+		return ret;
+
+	/* Register must be cleared before changing an active config */
+	ret = regmap_write(data->regmap, BMI323_FEAT_IO0_REG, 0);
+	if (ret) {
+		dev_err(data->dev, "Error stopping feature engine\n");
+		return ret;
+	}
+
+	/*
+	 * Restore external registers saved by suspend pm callback.
+	 */
+	for (unsigned int i = 0; i < ARRAY_SIZE(bmi323_ext_reg_savestate); i++) {
+		const unsigned int ext_reg_addr = bmi323_reg_savestate[i].reg;
+		const unsigned int ext_reg_val = savestate->reg_settings[i];
+
+		ret = bmi323_write_ext_reg(data, ext_reg_addr, ext_reg_val);
+		if (ret) {
+			dev_err(data->dev, "Error writing bmi323 external reg 0x%x: %d\n",
+				  ext_reg_addr, ret);
+			return ret;
+		}
+	}
+
+	/*
+	 * Restore registers saved by suspend pm callback.
+	 */
+	for (unsigned int i = 0; i < ARRAY_SIZE(bmi323_reg_savestate); i++) {
+		const unsigned int reg_addr = bmi323_reg_savestate[i].reg;
+		const unsigned int reg_val = savestate->reg_settings[i];
+
+		ret = regmap_write(data->regmap, reg_addr, reg_val);
+		if (ret) {
+			dev_err(data->dev, "Error writing bmi323 reg 0x%x: %d\n",
+				  reg_addr, ret);
+			return ret;
+		}
+	}
+
+	/*
+	 * Clear old FIFO samples that might be generated before suspend
+	 * or generated from a peripheral state not equal to the saved one.
+	 */
+	if (data->state == BMI323_BUFFER_FIFO) {
+		ret = regmap_write(data->regmap, BMI323_FIFO_CTRL_REG,
+			   BMI323_FIFO_FLUSH_MSK);
+		if (ret) {
+			dev_err(data->dev, "Error flushing FIFO buffer: %d\n", ret);
+			return ret;
+		}
+	}
+
+	unsigned int val;
+
+	ret = regmap_read(data->regmap, BMI323_ERR_REG, &val);
+	if (ret) {
+		dev_err(data->dev, "Error reading bmi323 error register: %d\n", ret);
+		return ret;
+	}
+
+	if (val) {
+		dev_err(data->dev, "Sensor power error in PM = 0x%x\n", val);
+		return -EINVAL;
+	}
 
 	return iio_device_resume_triggering(indio_dev);
 }
-- 
2.46.0


