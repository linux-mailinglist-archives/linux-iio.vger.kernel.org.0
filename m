Return-Path: <linux-iio+bounces-11677-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D44C29B7534
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 08:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94B4D2866AB
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 07:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DE01553A7;
	Thu, 31 Oct 2024 07:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="X9h3U7uu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D96514F9F8
	for <linux-iio@vger.kernel.org>; Thu, 31 Oct 2024 07:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730359080; cv=none; b=hh81CFihaJwaDWpq1gWw0UauUOHkhDGIcTrQxNWJVmKMhqOhO0YLZ8zuhBHn7NgPfls+JV/+HOeZBTw7GGWjSx/oZj5LVBC9bPv/VEPdoZwLf2w+f9J9t/GphWN+jsEq1lsaY71sfWndZQIxvQVtvXU0k7Xz0vleEIJCxyHhb6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730359080; c=relaxed/simple;
	bh=hRRz6Z3zhjYmY795aPCQsEcsvIGIKzWS3nJb+c+XP1I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ThQ120nOBTW2xcm/2TthDqzc/HeUBtx+fE4TQiBXbLi00UNUtMja2tzjb0RuD2oSRe0cbiEOIrckcQhot1yzqD/BHex0W1PHEvKTByJpAMBRrYJ1pV4IzcmAudbPKILO7+7lmudBBQrUXKqFYgff/WDYpXYrI3sU4sZGQdqZA1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=X9h3U7uu; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43158625112so4914955e9.3
        for <linux-iio@vger.kernel.org>; Thu, 31 Oct 2024 00:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730359076; x=1730963876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BeRlMEUtBMXjfsJVHTeMu8lQ8IK1457+K1awnOuwaZk=;
        b=X9h3U7uu0eCiI6Ccz3GK3TAbR2t5XRQCjn4GLKQkgP+IVY5+eLrbgCKzEaZX7tncxb
         lTWcL1iU1LwTxsmolYHjvfTWPVmrmXPlsrB70lNcaBoMU/8Zl8HDW5YFEg5t4f1zO7+u
         GZ4ZbfYU04vyEaMKn12pkm3nM1l4gRGJO450xptGZ1n7d9rcFfBRpBSHRfHCxzZUtKz1
         E11mqt2Nvcd8KDMInp0hqOMCdtv6oTXwQjXk/BUNermy57l0a8Cx8xm7PlRHWwV8Ww6+
         rmwfWjLDXcC0hYEtwWZaarpXwMARe8UlDsD8OdbBDfx3yEKqptod1V4fE+UzB2bKDUgg
         nOBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730359076; x=1730963876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BeRlMEUtBMXjfsJVHTeMu8lQ8IK1457+K1awnOuwaZk=;
        b=AVod188PJlLYZkGMXqml6i1Vne7JSjKxgp/Wr/uOfX+0DJI2IRQ9JEHnCCA1p3iXB5
         Opgo5gePRo8gaa3KJp3MvyToSzHwXAd5W14C8A+7QqwtUtoGZfEY+gnKAoIhf6TKUWVi
         zgN+JEazcR5doGsRjrN4m43ODUY26+rg61cdo/2qb2Le1jANsnvek10/htfmZAR+0RLG
         aEr8zP/bPXJS1AHEJ2NQlvXZx9azQ/HXmstqvYj18TXE5YbYqzR2GbLpBUm9nA6UfXoV
         8mBxLkvPiNHf0hgnRKBxvC9lYhSD48izjTrUNtDiGxtKR5ymOjz58s9wYYhOFdtW0qMC
         SMVQ==
X-Gm-Message-State: AOJu0YwIFV4mFjR3FJAOT6x2P4d6Tgey8NPtcrd6VBiEALNJZzAmY9G7
	sNEkfHI4d0Bs8VUVBoKvppKPoP/G7CY8JE4DSImblOOdV90PC/Lxu8zdoVaTFYo=
X-Google-Smtp-Source: AGHT+IFXvK55d0CGj9OJo4gCkJhWNNTnKajsdZ89N392DRFUQyDEd53HDsOaPmhrhw5rLrryeaaweQ==
X-Received: by 2002:a05:600c:3556:b0:431:5f1b:a7c4 with SMTP id 5b1f17b1804b1-4319ad29d0bmr169902125e9.34.1730359076424;
        Thu, 31 Oct 2024 00:17:56 -0700 (PDT)
Received: from axelh-ThinkPad-T450s.home (lfbn-nic-1-251-169.w2-15.abo.wanadoo.fr. [2.15.94.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c113e694sm1187547f8f.86.2024.10.31.00.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 00:17:55 -0700 (PDT)
From: ahaslam@baylibre.com
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nuno.sa@analog.com,
	dlechner@baylibre.com
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Axel Haslam <ahaslam@baylibre.com>
Subject: [PATCH v3 5/6] iio: dac: ad5791: Use devm_regulator_get_enable_read_voltage
Date: Thu, 31 Oct 2024 08:17:45 +0100
Message-Id: <20241031071746.848694-6-ahaslam@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241031071746.848694-1-ahaslam@baylibre.com>
References: <20241031071746.848694-1-ahaslam@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Axel Haslam <ahaslam@baylibre.com>

Simplify probe by using of the devm_regulator_get_enable_read_voltage.

Suggested-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 drivers/iio/dac/ad5791.c | 58 ++++++++++------------------------------
 1 file changed, 14 insertions(+), 44 deletions(-)

diff --git a/drivers/iio/dac/ad5791.c b/drivers/iio/dac/ad5791.c
index c5d4d755d57a..92d47e766fd3 100644
--- a/drivers/iio/dac/ad5791.c
+++ b/drivers/iio/dac/ad5791.c
@@ -360,32 +360,6 @@ static int ad5791_probe(struct spi_device *spi)
 	if (IS_ERR(st->gpio_ldac))
 		return PTR_ERR(st->gpio_ldac);
 
-	st->reg_vdd = devm_regulator_get(&spi->dev, "vdd");
-	if (!IS_ERR(st->reg_vdd)) {
-		ret = regulator_enable(st->reg_vdd);
-		if (ret)
-			return ret;
-
-		ret = regulator_get_voltage(st->reg_vdd);
-		if (ret < 0)
-			goto error_disable_reg_pos;
-
-		pos_voltage_uv = ret;
-	}
-
-	st->reg_vss = devm_regulator_get(&spi->dev, "vss");
-	if (!IS_ERR(st->reg_vss)) {
-		ret = regulator_enable(st->reg_vss);
-		if (ret)
-			goto error_disable_reg_pos;
-
-		ret = regulator_get_voltage(st->reg_vss);
-		if (ret < 0)
-			goto error_disable_reg_neg;
-
-		neg_voltage_uv = ret;
-	}
-
 	st->pwr_down = true;
 	st->spi = spi;
 
@@ -395,7 +369,17 @@ static int ad5791_probe(struct spi_device *spi)
 		use_rbuf_gain2 = device_property_read_bool(&spi->dev,
 							   "adi,rbuf-gain2-en");
 
-	if (!IS_ERR(st->reg_vss) && !IS_ERR(st->reg_vdd)) {
+	pos_voltage_uv = devm_regulator_get_enable_read_voltage(&spi->dev, "vdd");
+	if (pos_voltage_uv < 0 && pos_voltage_uv != -ENODEV)
+		return dev_err_probe(&spi->dev, pos_voltage_uv,
+				     "failed to get vdd voltage\n");
+
+	neg_voltage_uv = devm_regulator_get_enable_read_voltage(&spi->dev, "vss");
+	if (neg_voltage_uv < 0 && neg_voltage_uv != -ENODEV)
+		return dev_err_probe(&spi->dev, neg_voltage_uv,
+				     "failed to get vss voltage\n");
+
+	if (neg_voltage_uv >= 0 && pos_voltage_uv >= 0) {
 		st->vref_mv = (pos_voltage_uv + neg_voltage_uv) / 1000;
 		st->vref_neg_mv = neg_voltage_uv / 1000;
 	} else if (pdata) {
@@ -411,7 +395,7 @@ static int ad5791_probe(struct spi_device *spi)
 	} else {
 		ret = ad5791_spi_write(st, AD5791_ADDR_SW_CTRL, AD5791_SWCTRL_RESET);
 		if (ret)
-			goto error_disable_reg_neg;
+			return dev_err_probe(&spi->dev, ret, "fail to reset\n");
 	}
 
 	st->chip_info = spi_get_device_match_data(spi);
@@ -425,7 +409,7 @@ static int ad5791_probe(struct spi_device *spi)
 	ret = ad5791_spi_write(st, AD5791_ADDR_CTRL, st->ctrl |
 		AD5791_CTRL_OPGND | AD5791_CTRL_DACTRI);
 	if (ret)
-		goto error_disable_reg_neg;
+		return dev_err_probe(&spi->dev, ret, "fail to write ctrl register\n");
 
 	spi_set_drvdata(spi, indio_dev);
 	indio_dev->info = &ad5791_info;
@@ -435,30 +419,16 @@ static int ad5791_probe(struct spi_device *spi)
 	indio_dev->name = st->chip_info->name;
 	ret = iio_device_register(indio_dev);
 	if (ret)
-		goto error_disable_reg_neg;
+		return dev_err_probe(&spi->dev, ret, "unable to register iio device\n");
 
 	return 0;
-
-error_disable_reg_neg:
-	if (!IS_ERR(st->reg_vss))
-		regulator_disable(st->reg_vss);
-error_disable_reg_pos:
-	if (!IS_ERR(st->reg_vdd))
-		regulator_disable(st->reg_vdd);
-	return ret;
 }
 
 static void ad5791_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-	struct ad5791_state *st = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
-	if (!IS_ERR(st->reg_vdd))
-		regulator_disable(st->reg_vdd);
-
-	if (!IS_ERR(st->reg_vss))
-		regulator_disable(st->reg_vss);
 }
 
 static const struct of_device_id ad5791_of_match[] = {
-- 
2.34.1


