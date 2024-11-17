Return-Path: <linux-iio+bounces-12349-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3409D050D
	for <lists+linux-iio@lfdr.de>; Sun, 17 Nov 2024 19:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4C4D1F21AB0
	for <lists+linux-iio@lfdr.de>; Sun, 17 Nov 2024 18:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0461DD0DA;
	Sun, 17 Nov 2024 18:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUJnB7eE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879A21DC749;
	Sun, 17 Nov 2024 18:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731868104; cv=none; b=XxlqfOEsIPnNnEZrJA+o3F+sBD89npXCLLCdiF9bTU7wAcKUjv7TKr0JqBb72lQs/EFA2Mbp1SjyNCh3WlXTVKne2EKGo4gHJZfXN2scU9lbdJh3lmFo8tk5eaHC+X2RunbT5gAvkg3RYBuGnpNa4dITJSsrebtF3pKMLDuJdfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731868104; c=relaxed/simple;
	bh=4r1cVkYdRT9ZfGiUI9fHGkVIlyLVh+osJxxDLNbbpVY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FfTPJ4hSNJsFBpuLMA0zVl3YNgl0e3Ty1/dKpbD8jUStNHabW+fzJ24auu7wpYh5lnLSUUSVqW/fjyi7fbUG9e5rW/fwg1DZ3BSurLNhz9MoD7nFyMgUkacfyQlmPPu0mEYeH3uRSCX10QXdIj+DOm3qB7yyy2alILLYLOM9388=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XUJnB7eE; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3823ef92bd0so73305f8f.2;
        Sun, 17 Nov 2024 10:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731868101; x=1732472901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PPnUNq9UPYs83FPZhXy9S6/EzgNticedB2U5cxlHgYU=;
        b=XUJnB7eE+VCanka8OhAIJXYjQkaEZiJvcKM8c55l6TUbJJC/+8pCYAKTouY8W4STvp
         pT17JZ//i/HA5xWUt1cJX4mb9PsJhRKtI8Ce2171E+fgLOFlYwvl7KcIxJG46Pe0SKLe
         1LtEF9QXtwqQz+n7nbqKTEJyxrLJovD0aVKOSOWUxUGhQcR+JF+QTeRB+/yLg7uKvnbE
         pVXU0QhxYT1kmmH16kQ6NPzJKLb39S+jVRQ0+g+4TpBxwR0dQugNAbbzW7RAZdh5IQIy
         +EZ5pgKRUwavn+M25s7o9knFfNbl0krBdqfyzl2JermF5KnGYlwipMYzFG6Z8zrKA+pq
         kHuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731868101; x=1732472901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PPnUNq9UPYs83FPZhXy9S6/EzgNticedB2U5cxlHgYU=;
        b=RzrLl7AJ8s0TclQCogInPCDxfJmKUUS+jhGln92sUfaNZsgDfeXjhjbPNWbPf7LM4M
         eXRqOUE1LpMCK4+9oUCOaMR2cxjW2L+Kt4sOTgYhlbg+OqozwLb3MovZ7/Xf4VdY5iPt
         WuNlTlrT3P/EO0EvHN2qpoHsGTl04LXzDJxq5r7bZPKknGSCEY7/K6h75rAjenVARL/X
         MHwAED2x5IZaemkBEfzV56Trs8nxsdhGIBmz2GY5ClT9JgVayv+V5vDi8rREZ3ScTxFE
         7FSGwY4lENueO9L5CP+yDpymXIJgIwBue0sPclyYVVZ8nQXECaOTH4syeLoVwewEGEbE
         sc6w==
X-Forwarded-Encrypted: i=1; AJvYcCV34POV1Pm1I/mTE42K045KTNPEWem3c+o2nQ74TwyN9IQelVp9+Y+GoyMXIjKa0s3zvqs8pVNQcZBoa9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNl3pOf4RQjpaHmjFwFxOflZ1D8STZmVxO8PZVfzhmLfNcfdhq
	dbslM/3I91pcd4DFGQLSvDRAsGLwDeFy9q53EZXfDromIH06nwaA
X-Gm-Gg: ASbGncvzrDJUnx+IhXzU3vpbjq6uvIP9evrNAcvcQwupEe/OhswPWo/tO7HWb8xNfIc
	jv+cEW26/0IkZtT1bwLi2Esb5pnke5CI1A818NCKVbYdx61jVefLILmvPqyvE0tf+1J83qnD1O2
	BY3tCbzrggxeMTcw9M8NQfx0LgisPtVwkNSNMZGLveG6woa6TupNFkXaL2kUTJcMWnNyPdlt5Kk
	vXrdTqVCYNUfcX7a8huDZtknTKZbGjJKmeY3qXtBTGPWldnQbWjKg977haaE1eUSoqK+ZiV74G5
	7T6nAtA8LmhjKMBCNU1/Wvigeuhe
X-Google-Smtp-Source: AGHT+IE0aApcftU5GYHT8HfUFdCRHqXn8jqBx0A+4xGFI6fKxnFqpLfCljv8kWP7MYfXTwu4nmIuWw==
X-Received: by 2002:a05:600c:1c29:b0:42c:aeee:80a with SMTP id 5b1f17b1804b1-432df791c54mr36031325e9.7.1731868100706;
        Sun, 17 Nov 2024 10:28:20 -0800 (PST)
Received: from 5dfbf0f66296.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3823f72441bsm3028137f8f.101.2024.11.17.10.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 10:28:20 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v2 06/22] iio: accel: adxl345: add function to switch measuring
Date: Sun, 17 Nov 2024 18:26:35 +0000
Message-Id: <20241117182651.115056-7-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241117182651.115056-1-l.rubusch@gmail.com>
References: <20241117182651.115056-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the powerup / powerdown functions by a generic function to put
the sensor in STANDBY, or MEASURE mode. This is needed for several
features of the accelerometer. It allows to change e.g. FIFO settings.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 53 ++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 926e397678..81688a9eaf 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -138,6 +138,39 @@ static int adxl345_write_raw_get_fmt(struct iio_dev *indio_dev,
 	}
 }
 
+/**
+ * adxl345_set_measure_en() - Enable and disable measuring.
+ *
+ * @st: The device data.
+ * @en: Enable measurements, else standby mode.
+ *
+ * For lowest power operation, standby mode can be used. In standby mode,
+ * current consumption is supposed to be reduced to 0.1uA (typical). In this
+ * mode no measurements are made. Placing the device into standby mode
+ * preserves the contents of FIFO.
+ *
+ * Return: Returns 0 if successful, or a negative error value.
+ */
+static int adxl345_set_measure_en(struct adxl34x_state *st, bool en)
+{
+	unsigned int val = 0;
+	int ret;
+
+	val = (en) ? ADXL345_POWER_CTL_MEASURE : ADXL345_POWER_CTL_STANDBY;
+	ret = regmap_write(st->regmap, ADXL345_REG_POWER_CTL, val);
+	if (ret)
+		return -EINVAL;
+
+	return 0;
+}
+
+static void adxl345_powerdown(void *ptr)
+{
+	struct adxl34x_state *st = ptr;
+
+	adxl345_set_measure_en(st, false);
+}
+
 static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(
 "0.09765625 0.1953125 0.390625 0.78125 1.5625 3.125 6.25 12.5 25 50 100 200 400 800 1600 3200"
 );
@@ -158,16 +191,6 @@ static const struct iio_info adxl345_info = {
 	.write_raw_get_fmt	= adxl345_write_raw_get_fmt,
 };
 
-static int adxl345_powerup(void *regmap)
-{
-	return regmap_write(regmap, ADXL345_REG_POWER_CTL, ADXL345_POWER_CTL_MEASURE);
-}
-
-static void adxl345_powerdown(void *regmap)
-{
-	regmap_write(regmap, ADXL345_REG_POWER_CTL, ADXL345_POWER_CTL_STANDBY);
-}
-
 /**
  * adxl345_core_probe() - probe and setup for the adxl345 accelerometer,
  *                        also covers the adxl375 and adxl346 accelerometer
@@ -242,14 +265,12 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 		return dev_err_probe(dev, -ENODEV, "Invalid device ID: %x, expected %x\n",
 				     regval, ADXL345_DEVID);
 
-	/* Enable measurement mode */
-	ret = adxl345_powerup(st->regmap);
+	ret = devm_add_action_or_reset(dev, adxl345_powerdown, st);
 	if (ret < 0)
-		return dev_err_probe(dev, ret, "Failed to enable measurement mode\n");
+		return dev_err_probe(dev, ret, "Failed to add action or reset\n");
 
-	ret = devm_add_action_or_reset(dev, adxl345_powerdown, st->regmap);
-	if (ret < 0)
-		return ret;
+	/* Enable measurement mode */
+	adxl345_set_measure_en(st, true);
 
 	return devm_iio_device_register(dev, indio_dev);
 }
-- 
2.39.5


