Return-Path: <linux-iio+bounces-6804-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 752C8914B05
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 14:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0309B1F23C0A
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 12:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D7B13D298;
	Mon, 24 Jun 2024 12:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4neDO81"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C896F13CFB6;
	Mon, 24 Jun 2024 12:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719233411; cv=none; b=o/4m2vM4Q65r79ZHm0Bh9YAL469aqKdCMH49m1ENrd5+fni1De1KRM3qsrNv+mlqEAxoNt0IjNtcEOROzn1HKculn4w66oM/RHUYV9tB+QPjZI7GE+M31lt/1+TBSpxiJ86rBfNPTLgh6lmazR0Kjpf0zmJG6aM0XuYPovba3IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719233411; c=relaxed/simple;
	bh=kazmdC/cLGmIsaW+TEKeeGpN3GwONcFkU1ULaXVaWeg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Og9cG24p0+patwb8iYYl2xB5cotAjHKzvGyot2zUoEkgCrMXOsXs7SkMwHev4rlhx5IK0dckAKI7522JPXjYD5D8r3E9E0J7esur9YrXh4Y+1aTTnEDn/i2jhUB3Eq/NyJ3AH9qE4EZ0iLNWmtiBCY4xfa2g4Ta655z1zrUya78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T4neDO81; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4248e28de9eso9996375e9.2;
        Mon, 24 Jun 2024 05:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719233408; x=1719838208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p0m6UNyRnajMw6xAJ7LWWvSa2adAG/lm7tOiNtbOtpw=;
        b=T4neDO81gXzv6Kye1vW61WMWoI6q2iwRiWcS4W9EE/brPFz4LtMqnfgGG4jSIRbUBh
         mdvYxHitUSjqNjURUkyEbxquqUj+nfNldvUBoJjapvcmyRqV5wy8tsgaE+YpRZ3DJsv7
         0u6KxyUUrPdtN5PVawNHv2ivg/AQeDbIJeJD068OQNNVDhCIYWh6H6q/VfReEXe89I9b
         D/lrcMme3Eb1SksBAkJbI053MEkrrqeGX7Nk2JQywC/Zwsq8pEMKcBGbiqRSHA27lfau
         pTuSECIOdwLZcGYsIHn/kZq02fPUbvsCgi6pPr4cAPwPhyHPFvST500JNet03xtaalPu
         BNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719233408; x=1719838208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p0m6UNyRnajMw6xAJ7LWWvSa2adAG/lm7tOiNtbOtpw=;
        b=XOUszS9bJiDlPyiRBqdNipllrFBTjhLToE+EJ00EayTWJtIzoxBFJESOD7Wk2JvAyu
         rRrvyQKmNInmcHWhXDRbBzsyB61FwA6lbvXvs2lxop1i2DLuHgdEwEPh1MAq8jOk+nvA
         rC/Xe+7Y/9H1Rq2s+pbiZEKeWV9LMW98XHwPHmLi0qvO5R+h5sHZ8EEAuPAntryYK8zi
         ZdukwjT90ZEPEjXefozJLhO2yw+nrvQ9f4hj42HkKhcCZxEAy6ehSVpq5waENxDHGQfT
         VCJlif18J6qZYh6OsKlc34uiTqnd1bMSMZ/gQatMkrR5eJI63SlIJmMcp53yUKWfgeQO
         EqXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVobgvEwewsITYCyDwC0IAlKc5OdnIMLGZ3FLlVtbizqlfVEBoJkKdMEBWXBZm8MhvR+4ld2hFTO55GIBsFfLZZZ1a+yf8OgjLHJjBJmjbPPIgst+tzZAuydI3wIui8evkBCt5t+TJgO9rYlTYjxPOVMAhbDoVkBkMi3P6SmqL/hZEdkQ==
X-Gm-Message-State: AOJu0YxTlDunzN0mJc0Ps6MOEwjhC4xNyZHYyNkfeMdxP5AG6hjBlzPN
	+Zl5g9J04eRcYSgoR7EoXJNJfZ6f8W5sMxH6poPfbYVD160249/a
X-Google-Smtp-Source: AGHT+IGy5cmaBr5ntYugOtnY+Liivf8C7QSQCOSQ75qzG8qIRq2obmka5A5zHOX3y+wIec0VYl0TAg==
X-Received: by 2002:a05:600c:4451:b0:422:62db:5a02 with SMTP id 5b1f17b1804b1-4248cc586ddmr37382835e9.32.1719233407669;
        Mon, 24 Jun 2024 05:50:07 -0700 (PDT)
Received: from spiri.. ([5.14.146.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d208b60sm174127905e9.37.2024.06.24.05.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 05:50:07 -0700 (PDT)
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
Subject: [PATCH v6 1/6] iio: adc: ad7192: use devm_regulator_get_enable_read_voltage
Date: Mon, 24 Jun 2024 15:49:36 +0300
Message-Id: <20240624124941.113010-2-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240624124941.113010-1-alisa.roman@analog.com>
References: <20240624124941.113010-1-alisa.roman@analog.com>
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
Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
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


