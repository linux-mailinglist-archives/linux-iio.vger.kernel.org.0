Return-Path: <linux-iio+bounces-6502-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F6090D56D
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 16:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 456231F21039
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 14:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4CB15E5A8;
	Tue, 18 Jun 2024 14:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IqWU84C8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EE815DBC7;
	Tue, 18 Jun 2024 14:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718720523; cv=none; b=E0HUvMPxLi/dn2ghBUfVef6qIZ3lWNLC/jSpls/kxdxESH47ANgCVB3m6yU6P0SY0/9JEyYYhJrZotXeWprE+w3u+5iq/XzGLxXE8V5357clYKl9HgCw7DgdPkvzh9E4Uxrc6IawKxikqbdljOYJ50hKrJn/2kYFIIRCHw4/FhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718720523; c=relaxed/simple;
	bh=odMDZM1iWrH6C/6FAwjz4UxM3my1aTWZBZk/WEJCucM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XjZzm6IlfISSvFM0K0M/V0JuTkzMaAJQmQeBWcv3uHisBDBDMCEx4IUL+upRAZx/q/3ceJ4lofzpOd9OnYHB1RzGZDu/mDyB6udCCY1COP+VEiQdgV2ehMQPWcl2ahhcHe+omi6iEeYEAiYm3FniT+7ozHA/YzezvSclG26x0Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IqWU84C8; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a6f0c3d0792so648560466b.3;
        Tue, 18 Jun 2024 07:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718720520; x=1719325320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JhHe+Dk5RW2z8Ummfx+UjkraQsYp/dWgKDc8czLOogw=;
        b=IqWU84C8OdskdiQPi7ZHfERNKacVHRU3p2QSqD6gN+sI2/1Khsxqw5Sm1cHfiEIb5F
         iBzLjTjoq7v94HMFzg7GYS5Y0eM6wQ/Q7FzTVEoLqm1MruhS1eIjPYD1n71a6Lj7NQbQ
         Jn6OgLjkrSXj2DWg8B86ugs6H33PCOEXNXva4Wd+L8hhnXDCj9srxXl+c80GDg9QxVCF
         M1ay9TlCQMVRFqiZpp7vmlixRKIh3ulvxFWrfCt9+k97BU3x+/tRBTiWhUKyeJIQ/3nD
         m29iTG21hakT/Xn/ykcqHKmRIgYjglKqJeCDoHZrQmKQFnlD61eow5WEgDRdEACVHw5P
         gYvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718720520; x=1719325320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JhHe+Dk5RW2z8Ummfx+UjkraQsYp/dWgKDc8czLOogw=;
        b=HIB+PJAe3KSkIw/qrxknZ5pUbWgtURuR/w2WYcZIPd6JfVPwGYLMdtoqhXJh4ZgTkc
         M1iLllpyUGc0Rxir0x6wyAIPDjsbRavuXejY5mlN+3PRoist91X8aK+TJkzO2eE4nrc9
         vqX+jS/zElL2eVYcemzW8s/QSy2QBebVShYid17gneQsZRWPxD6OvRDorP2qSKF6Iz1E
         HVq5oKM02Z+iZyE0eOn4zH4Tioeu5zYTA/xwACKEQTbaswt4v7WGqc1jzr3Wf+F+4rtg
         E9Zm9qbgoLjTItGJD2RuZoTxJkeU27oldesb6/r1WEAWmKYEd6/zqIwDKwJClahzE4Nt
         0W5w==
X-Forwarded-Encrypted: i=1; AJvYcCXOxZHek7+K2F1OvfuscWat18dWYNsZ5PPgijcB7tJZvvPVmWFPOgYR6fmxQmG4shll6B1xEouyUmJHzSAmHv5VBlQeelMnwielkRzKS2VtpoPUFMvANsfWDAtN0PV3lls0kGj4/T9I2VTAF6SmLYP8nT/kkwwnEBHoyDnoz8bwiy0Aiw==
X-Gm-Message-State: AOJu0Yy35fC5uhY8z3EqHVTVYFxhVUqUKvL5G6Mtze8kXP0rPzLD0MZ2
	+o3/Vf6GgvMvNL1rLQ9jXx96KeiKnZNhZjHOEri/YGdZz5+8CXp3
X-Google-Smtp-Source: AGHT+IFVZW9LpfzvOs2+6b8TPae6fpJQ6Up7o/HkKoHkkKRWzo81hNrOwkPB2iwdqfjoon+dZd4DBw==
X-Received: by 2002:a17:906:a897:b0:a6f:e36:abae with SMTP id a640c23a62f3a-a6f60d41741mr788297966b.42.1718720519667;
        Tue, 18 Jun 2024 07:21:59 -0700 (PDT)
Received: from spiri.. ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56db6dfesm618191466b.87.2024.06.18.07.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 07:21:59 -0700 (PDT)
From: Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To: Alisa-Dariana Roman <alisa.roman@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	David Lechner <dlechner@baylibre.com>
Subject: [PATCH v5 1/6] iio: adc: ad7192: use devm_regulator_get_enable_read_voltage
Date: Tue, 18 Jun 2024 17:21:33 +0300
Message-Id: <20240618142138.520192-2-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240618142138.520192-1-alisa.roman@analog.com>
References: <20240618142138.520192-1-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Lechner <dlechner@baylibre.com>

This makes use of the new devm_regulator_get_enable_read_voltage()
function to reduce boilerplate code.

Error messages have changed slightly since there are now fewer places
where we print an error. The rest of the logic of selecting which
supply to use as the reference voltage remains the same.

Also 1000 is replaced by MILLI in a few places for consistency.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7192.c | 103 ++++++++++++++-------------------------
 1 file changed, 36 insertions(+), 67 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index c7fb51a90e87..334ab90991d4 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -200,8 +200,6 @@ struct ad7192_chip_info {
 
 struct ad7192_state {
 	const struct ad7192_chip_info	*chip_info;
-	struct regulator		*avdd;
-	struct regulator		*vref;
 	struct clk			*mclk;
 	u16				int_vref_mv;
 	u32				aincom_mv;
@@ -1189,18 +1187,12 @@ static const struct ad7192_chip_info ad7192_chip_info_tbl[] = {
 	},
 };
 
-static void ad7192_reg_disable(void *reg)
-{
-	regulator_disable(reg);
-}
-
 static int ad7192_probe(struct spi_device *spi)
 {
 	struct device *dev = &spi->dev;
 	struct ad7192_state *st;
 	struct iio_dev *indio_dev;
-	struct regulator *aincom;
-	int ret;
+	int ret, avdd_mv;
 
 	if (!spi->irq)
 		return dev_err_probe(dev, -ENODEV, "Failed to get IRQ\n");
@@ -1218,72 +1210,49 @@ static int ad7192_probe(struct spi_device *spi)
 	 * Newer firmware should provide a zero volt fixed supply if wired to
 	 * ground.
 	 */
-	aincom = devm_regulator_get_optional(dev, "aincom");
-	if (IS_ERR(aincom)) {
-		if (PTR_ERR(aincom) != -ENODEV)
-			return dev_err_probe(dev, PTR_ERR(aincom),
-					     "Failed to get AINCOM supply\n");
-
-		st->aincom_mv = 0;
-	} else {
-		ret = regulator_enable(aincom);
-		if (ret)
-			return dev_err_probe(dev, ret,
-					     "Failed to enable specified AINCOM supply\n");
-
-		ret = devm_add_action_or_reset(dev, ad7192_reg_disable, aincom);
-		if (ret)
-			return ret;
-
-		ret = regulator_get_voltage(aincom);
-		if (ret < 0)
-			return dev_err_probe(dev, ret,
-					     "Device tree error, AINCOM voltage undefined\n");
-		st->aincom_mv = ret / MILLI;
+	ret = devm_regulator_get_enable_read_voltage(dev, "aincom");
+	if (ret < 0 && ret != -ENODEV)
+		return dev_err_probe(dev, ret, "Failed to get AINCOM voltage\n");
+
+	st->aincom_mv = ret == -ENODEV ? 0 : ret / MILLI;
+
+	/* AVDD can optionally be used as reference voltage */
+	ret = devm_regulator_get_enable_read_voltage(dev, "avdd");
+	if (ret == -ENODEV || ret == -EINVAL) {
+		int ret2;
+
+		/*
+		 * We get -EINVAL if avdd is a supply with unknown voltage. We
+		 * still need to enable it since it is also a power supply.
+		 */
+		ret2 = devm_regulator_get_enable(dev, "avdd");
+		if (ret2)
+			return dev_err_probe(dev, ret2,
+					     "Failed to enable AVDD supply\n");
+	} else if (ret < 0) {
+		return dev_err_probe(dev, ret, "Failed to get AVDD voltage\n");
 	}
 
-	st->avdd = devm_regulator_get(dev, "avdd");
-	if (IS_ERR(st->avdd))
-		return PTR_ERR(st->avdd);
-
-	ret = regulator_enable(st->avdd);
-	if (ret)
-		return dev_err_probe(dev, ret,
-				     "Failed to enable specified AVdd supply\n");
-
-	ret = devm_add_action_or_reset(dev, ad7192_reg_disable, st->avdd);
-	if (ret)
-		return ret;
+	avdd_mv = ret == -ENODEV || ret == -EINVAL ? 0 : ret / MILLI;
 
 	ret = devm_regulator_get_enable(dev, "dvdd");
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to enable specified DVdd supply\n");
 
-	st->vref = devm_regulator_get_optional(dev, "vref");
-	if (IS_ERR(st->vref)) {
-		if (PTR_ERR(st->vref) != -ENODEV)
-			return PTR_ERR(st->vref);
-
-		ret = regulator_get_voltage(st->avdd);
-		if (ret < 0)
-			return dev_err_probe(dev, ret,
-					     "Device tree error, AVdd voltage undefined\n");
-	} else {
-		ret = regulator_enable(st->vref);
-		if (ret)
-			return dev_err_probe(dev, ret,
-					     "Failed to enable specified Vref supply\n");
-
-		ret = devm_add_action_or_reset(dev, ad7192_reg_disable, st->vref);
-		if (ret)
-			return ret;
-
-		ret = regulator_get_voltage(st->vref);
-		if (ret < 0)
-			return dev_err_probe(dev, ret,
-					     "Device tree error, Vref voltage undefined\n");
+	/*
+	 * This is either REFIN1 or REFIN2 depending on adi,refin2-pins-enable.
+	 * If this supply is not present, fall back to AVDD as reference.
+	 */
+	ret = devm_regulator_get_enable_read_voltage(dev, "vref");
+	if (ret == -ENODEV) {
+		if (avdd_mv == 0)
+			return dev_err_probe(dev, -ENODEV,
+					     "No reference voltage available\n");
+	} else if (ret < 0) {
+		return ret;
 	}
-	st->int_vref_mv = ret / 1000;
+
+	st->int_vref_mv = ret == -ENODEV ? avdd_mv : ret / MILLI;
 
 	st->chip_info = spi_get_device_match_data(spi);
 	indio_dev->name = st->chip_info->name;
-- 
2.34.1


