Return-Path: <linux-iio+bounces-5806-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE72A8FC51A
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 09:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F13471C225F0
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 07:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D0218C35C;
	Wed,  5 Jun 2024 07:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WH2pmLaC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61ED118C33F;
	Wed,  5 Jun 2024 07:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717573959; cv=none; b=B4AseeUQnwxbKjl9uB/kE8SwDd4/aU7KKqrrIXSQyuqY/iK1VHMLaQ07Dk+/Wz7SRTvwA1ED7HptVHFK/otTjw/tWkpVwfK6ldejsY82P+ZBlJ5YQklqnSXf+tu3texQsf4m47GOts5YEAH1A47lfMMUsH9YO61ZCis6NEI/tC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717573959; c=relaxed/simple;
	bh=XnCCa8SVtULSuNqyntOQ3y8A67k3ygOWbMFbkiP94k0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fEqaQkrJLVH6uJBBS02CH2YoweoZLw/2tK3c20zkAT+/Nj5By156Gz1iMRhmi4faH9yvd7SARZlsVBqNf9JT9/59OItxcA20RJErNnSWu8zXcYXkEwMQ4ocY8aiBFbLYV/hpdiC7yWh76ojsyITX94X5jB63UnObkNCNKmwl1A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WH2pmLaC; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-354f3f6c3b1so1777184f8f.2;
        Wed, 05 Jun 2024 00:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717573956; x=1718178756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q9GmxwYP+jlkVfu6yreaC7OABxu9rOG6xWbTi39hosQ=;
        b=WH2pmLaCn0Mbc+5ol4+IRkAZDJimy8iND4d0a2PYunGoZOrzSneXbXd7tcJNKr0zAZ
         L8httKwkiYSGvR4c1muLxttLS+2W3n3mvkeF4/MlqvTPOlN7UYeYIC2LBzKJj7nqYxE7
         4UzJ8XSLVDAOhz5JYGWC9paGKgY/WCuo24xpFwKeGcgmHg6Lhroc/ao90ksMlYeTLrRX
         PMwWmBtwQIbbOysrioOqLKJCrE4co4shOHJ/7Fw0TXdCtctG56j4jKHjdvnSlw/GTAMM
         hSqaFa6zXraCllnAXhNV8h71ztGgHN+qybSOZ0AYWZNdivgm+bXGCX9P4pfJepziGv4q
         gaAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717573956; x=1718178756;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q9GmxwYP+jlkVfu6yreaC7OABxu9rOG6xWbTi39hosQ=;
        b=M2tcz9PNN5fhM9dUZ/2WtSOByoRkLFtc3Zav5eqApGl2+eMDk6YgXVVmOvuYC9T/gM
         akQ3yE2LL2LAgLMETUXeunq3QvgolbJnLi/8PfJ9EOkz3rF3iz+PEmqKTyQ+g+JlanJv
         BT+FGNVnJKC5kJU5CENCz2DqRPovsOmkzFugXAN5xFjixHaQuc8kCkHcFRVeBc8+4I3j
         cUVyeidizwXZbEx6wZw4vP6q5l9e6/q4ZvypsQHmBLwMBFoRTjaR24FMs7QEGLVIiQQ7
         Y3vRKTwuTUdILfahmoa3c3GW2wam2X2YCWWOsUsxJAfU6+5E04IdG4ch+bGtkohEMA4H
         0zdw==
X-Forwarded-Encrypted: i=1; AJvYcCVp0oMbVTmNUXt63tKcyekXVssb8T3y/ie2oAwI+Xnr7qTurBgr2YJ6c1GXv7N0RTQGzLzJ09SKBytiKJJxjiYgGflXAlIax81ADgJH/97WT7ZV17vnvPeAboU1gXH6awXgRRho8nOdCfv1mhPU+2jfTu7AoC2GnJbRPMGWG0KN3CJwfA==
X-Gm-Message-State: AOJu0Yw7Fm9Capqs8H39fg/FLwyrVM2HA6C+4e9WsRCYgTyLZ2huK4xN
	xJCikYS9Rql09j+5nW57jm+Dzs1eokWQQsARhqJFBT6zTOWbPJ6P
X-Google-Smtp-Source: AGHT+IEq3f3SYgIJL/MSjzmnaxzs5xFdpvzFSrvr7D74Pb/GW1+0Hnl6QXuL7PYliKVyBO4z7CeNiA==
X-Received: by 2002:a05:6000:92:b0:35e:e87e:6b33 with SMTP id ffacd0b85a97d-35ee87e6c90mr836485f8f.51.1717573955446;
        Wed, 05 Jun 2024 00:52:35 -0700 (PDT)
Received: from spiri.. ([2a02:2f08:a10a:2300:8e59:f160:bdc8:6311])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04c0839sm13760638f8f.23.2024.06.05.00.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 00:52:35 -0700 (PDT)
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
	Alexandru Tachici <alexandru.tachici@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 1/3] iio: adc: ad7192: Clean up dev
Date: Wed,  5 Jun 2024 10:51:52 +0300
Message-Id: <20240605075154.625123-1-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clean up by using a local variable struct device *dev.

Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
---
 drivers/iio/adc/ad7192.c | 45 ++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 0789121236d6..f06cb7ac4b42 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -1196,17 +1196,18 @@ static void ad7192_reg_disable(void *reg)
 
 static int ad7192_probe(struct spi_device *spi)
 {
+	struct device *dev = &spi->dev;
 	struct ad7192_state *st;
 	struct iio_dev *indio_dev;
 	struct regulator *aincom;
 	int ret;
 
 	if (!spi->irq) {
-		dev_err(&spi->dev, "no IRQ?\n");
+		dev_err(dev, "no IRQ?\n");
 		return -ENODEV;
 	}
 
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -1219,71 +1220,71 @@ static int ad7192_probe(struct spi_device *spi)
 	 * Newer firmware should provide a zero volt fixed supply if wired to
 	 * ground.
 	 */
-	aincom = devm_regulator_get_optional(&spi->dev, "aincom");
+	aincom = devm_regulator_get_optional(dev, "aincom");
 	if (IS_ERR(aincom)) {
 		if (PTR_ERR(aincom) != -ENODEV)
-			return dev_err_probe(&spi->dev, PTR_ERR(aincom),
+			return dev_err_probe(dev, PTR_ERR(aincom),
 					     "Failed to get AINCOM supply\n");
 
 		st->aincom_mv = 0;
 	} else {
 		ret = regulator_enable(aincom);
 		if (ret)
-			return dev_err_probe(&spi->dev, ret,
+			return dev_err_probe(dev, ret,
 					     "Failed to enable specified AINCOM supply\n");
 
-		ret = devm_add_action_or_reset(&spi->dev, ad7192_reg_disable, aincom);
+		ret = devm_add_action_or_reset(dev, ad7192_reg_disable, aincom);
 		if (ret)
 			return ret;
 
 		ret = regulator_get_voltage(aincom);
 		if (ret < 0)
-			return dev_err_probe(&spi->dev, ret,
+			return dev_err_probe(dev, ret,
 					     "Device tree error, AINCOM voltage undefined\n");
 		st->aincom_mv = ret / MILLI;
 	}
 
-	st->avdd = devm_regulator_get(&spi->dev, "avdd");
+	st->avdd = devm_regulator_get(dev, "avdd");
 	if (IS_ERR(st->avdd))
 		return PTR_ERR(st->avdd);
 
 	ret = regulator_enable(st->avdd);
 	if (ret) {
-		dev_err(&spi->dev, "Failed to enable specified AVdd supply\n");
+		dev_err(dev, "Failed to enable specified AVdd supply\n");
 		return ret;
 	}
 
-	ret = devm_add_action_or_reset(&spi->dev, ad7192_reg_disable, st->avdd);
+	ret = devm_add_action_or_reset(dev, ad7192_reg_disable, st->avdd);
 	if (ret)
 		return ret;
 
-	ret = devm_regulator_get_enable(&spi->dev, "dvdd");
+	ret = devm_regulator_get_enable(dev, "dvdd");
 	if (ret)
-		return dev_err_probe(&spi->dev, ret, "Failed to enable specified DVdd supply\n");
+		return dev_err_probe(dev, ret, "Failed to enable specified DVdd supply\n");
 
-	st->vref = devm_regulator_get_optional(&spi->dev, "vref");
+	st->vref = devm_regulator_get_optional(dev, "vref");
 	if (IS_ERR(st->vref)) {
 		if (PTR_ERR(st->vref) != -ENODEV)
 			return PTR_ERR(st->vref);
 
 		ret = regulator_get_voltage(st->avdd);
 		if (ret < 0)
-			return dev_err_probe(&spi->dev, ret,
+			return dev_err_probe(dev, ret,
 					     "Device tree error, AVdd voltage undefined\n");
 	} else {
 		ret = regulator_enable(st->vref);
 		if (ret) {
-			dev_err(&spi->dev, "Failed to enable specified Vref supply\n");
+			dev_err(dev, "Failed to enable specified Vref supply\n");
 			return ret;
 		}
 
-		ret = devm_add_action_or_reset(&spi->dev, ad7192_reg_disable, st->vref);
+		ret = devm_add_action_or_reset(dev, ad7192_reg_disable, st->vref);
 		if (ret)
 			return ret;
 
 		ret = regulator_get_voltage(st->vref);
 		if (ret < 0)
-			return dev_err_probe(&spi->dev, ret,
+			return dev_err_probe(dev, ret,
 					     "Device tree error, Vref voltage undefined\n");
 	}
 	st->int_vref_mv = ret / 1000;
@@ -1305,13 +1306,13 @@ static int ad7192_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = devm_ad_sd_setup_buffer_and_trigger(&spi->dev, indio_dev);
+	ret = devm_ad_sd_setup_buffer_and_trigger(dev, indio_dev);
 	if (ret)
 		return ret;
 
 	st->fclk = AD7192_INT_FREQ_MHZ;
 
-	st->mclk = devm_clk_get_optional_enabled(&spi->dev, "mclk");
+	st->mclk = devm_clk_get_optional_enabled(dev, "mclk");
 	if (IS_ERR(st->mclk))
 		return PTR_ERR(st->mclk);
 
@@ -1321,17 +1322,17 @@ static int ad7192_probe(struct spi_device *spi)
 	    st->clock_sel == AD7192_CLK_EXT_MCLK2) {
 		st->fclk = clk_get_rate(st->mclk);
 		if (!ad7192_valid_external_frequency(st->fclk)) {
-			dev_err(&spi->dev,
+			dev_err(dev,
 				"External clock frequency out of bounds\n");
 			return -EINVAL;
 		}
 	}
 
-	ret = ad7192_setup(indio_dev, &spi->dev);
+	ret = ad7192_setup(indio_dev, dev);
 	if (ret)
 		return ret;
 
-	return devm_iio_device_register(&spi->dev, indio_dev);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static const struct of_device_id ad7192_of_match[] = {
-- 
2.34.1


