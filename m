Return-Path: <linux-iio+bounces-5375-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A03908D0A02
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 20:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D9131C21A9D
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 18:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F59167D8F;
	Mon, 27 May 2024 18:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6ne7o4D"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5F2161339;
	Mon, 27 May 2024 18:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716835107; cv=none; b=MvqTz1NlKTfEN5WvWZDoQriGAJnjYdee0oxhnKiB+Xocpm1hZ7D4jTT57C7C+Wy6ioyo6G8nJ77+qPRv2AqtrSwD71r/pxnvt8cWEd/gnt1RmqNE+0IX8eJm53OfazYXVG8bov+4zq1fJvM8sT9KaSBHUsuGjLUfkR7EHRMQ7to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716835107; c=relaxed/simple;
	bh=Z11L+MBntNd9tpd6XUK/Rkb7dO2gwkXSKNYVH2NWEUA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cZ2QJWqh28mVXLrzz/jD4Yr77fT42iEUAq4erWfCBm7sn6tqRCNHdtg3K2Ie+TzGdv71yYOfNJXL3nnme09YT8/WqcTv3A1qcEaMi9CkDIKa294UcXgkMZE5kQLQjGkofKAZRwJMNiWSOEVEXWaSnS7oEdxXU9vUvB0DJ//Mdd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6ne7o4D; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a626776cc50so7199266b.3;
        Mon, 27 May 2024 11:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716835104; x=1717439904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AhEbl1lNPdJL4216synqDrxWN0ri3RT5MAntM9v8/rc=;
        b=g6ne7o4DFKZ6HnaQfETju1Dk8K1a2DeHirmYXFtplH8yJoO93q5Dn/4kzwdboukzKb
         qbw6liAxzy4ip0vWAIZY/oh19s3kuwnniuJuvFv/9J9rcCS4gUn82X8m4ydVcJzsOr+R
         7rUqzgDDlzE63+H44MY8XV/4/EFQzJpncpSnOQ6+s8DujwHBf2jKN6mn6mnkPAjRl/Ni
         7tfKwf8k+Bi14yofhkMTHtxe1F15U6aLBZGAL/evPgaeccYJRIon/7LI2yf5fp05lEc5
         Qn6DHOsJ2MswO0lHU4HJNqYgRbfaQnvkbwYJVYl0SbT6xcSkbUsnJ8xz3O7+WHejvB+r
         vtgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716835104; x=1717439904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AhEbl1lNPdJL4216synqDrxWN0ri3RT5MAntM9v8/rc=;
        b=viNC4vp9j/s94A55DrRz8DRujfTtbZIAlOiBBjMVFfNS0RpxTVeYe7FyMrZ+TD8zQ5
         r2Ehovaj6FBXMqT14yefMd6GYInR4rL5mvUchZqLJAV3VaIm7OoG3V59py327XYrULpG
         KFK8fXGUvfzE4J+oEDIt/chWN+8Fc7Y0fyDz973fp37w+aeQgTD38ap+vjlFk/Q25SC2
         PEqGAej3odSTuYluRVqr2aJtHo9jmek30oaF8PwdoffQmvlTOW8ax9QCz7sLX4Wpr4an
         HfRHoZwD6io7a8uMghpSZ5OZCXrn+GQbGim267KYkHoFKjenQ5GsBKv3fMd+u9R5bPyu
         7Akg==
X-Forwarded-Encrypted: i=1; AJvYcCUIVmubdSevYLtsiXIQf18z3gq2m+1W9l6Pc4ftR/Uhzz0bpaot7mLVxncqQ0fkadw/TlDDL4tevf6EgGLr+z4kSmGtf2iyxLA14nDl6M2gN/mG1ZMLl4bmNYM9ApKrJaMnyXnsPUAt
X-Gm-Message-State: AOJu0Yx2Gl53u6ZhSE3qgRb/Fxx9uOWlLZLgLi6SOsnRtBw44jVHk6SX
	0H6XPg2kL5Pj3+Cx0vmQzuFDuGBh7aBtVoGouHwCeWxsEo+fYynUE1Ycbg==
X-Google-Smtp-Source: AGHT+IFWE+ggd7jRqc4jQhnraNNFQtB0FSadWCaedcwVOuCdrAG+pUHyTZ0i04dqfAJ0DXR3w+pOhw==
X-Received: by 2002:a17:906:4c49:b0:a63:3702:def1 with SMTP id a640c23a62f3a-a633702dff6mr1659766b.72.1716835104213;
        Mon, 27 May 2024 11:38:24 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:4b45:3774:6be0:a177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc52398sm513825266b.105.2024.05.27.11.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 11:38:23 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: himanshujha199640@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v1 12/17] iio: chemical: bme680: Allocate IIO device before chip initialization
Date: Mon, 27 May 2024 20:38:00 +0200
Message-Id: <20240527183805.311501-13-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240527183805.311501-1-vassilisamir@gmail.com>
References: <20240527183805.311501-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the IIO device allocation before the actual initialization
of the chip to be more consistent with most IIO drivers and also
to have the ability to use any driver specific data for the chip
initialization.

While at it, fix also a misaligned line.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680_core.c | 38 +++++++++++++++---------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index ed4cdb4d64af..a6f425076d36 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -820,25 +820,6 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
 	unsigned int val;
 	int ret;
 
-	ret = regmap_write(regmap, BME680_REG_SOFT_RESET,
-			   BME680_CMD_SOFTRESET);
-	if (ret < 0) {
-		dev_err(dev, "Failed to reset chip\n");
-		return ret;
-	}
-
-	ret = regmap_read(regmap, BME680_REG_CHIP_ID, &val);
-	if (ret < 0) {
-		dev_err(dev, "Error reading chip ID\n");
-		return ret;
-	}
-
-	if (val != BME680_CHIP_ID_VAL) {
-		dev_err(dev, "Wrong chip ID, got %x expected %x\n",
-				val, BME680_CHIP_ID_VAL);
-		return -ENODEV;
-	}
-
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
@@ -860,6 +841,25 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
 	data->heater_temp = 320; /* degree Celsius */
 	data->heater_dur = 150;  /* milliseconds */
 
+	ret = regmap_write(regmap, BME680_REG_SOFT_RESET,
+			   BME680_CMD_SOFTRESET);
+	if (ret < 0) {
+		dev_err(dev, "Failed to reset chip\n");
+		return ret;
+	}
+
+	ret = regmap_read(regmap, BME680_REG_CHIP_ID, &val);
+	if (ret < 0) {
+		dev_err(dev, "Error reading chip ID\n");
+		return ret;
+	}
+
+	if (val != BME680_CHIP_ID_VAL) {
+		dev_err(dev, "Wrong chip ID, got %x expected %x\n",
+			val, BME680_CHIP_ID_VAL);
+		return -ENODEV;
+	}
+
 	ret = bme680_chip_config(data);
 	if (ret < 0) {
 		dev_err(dev, "failed to set chip_config data\n");
-- 
2.25.1


