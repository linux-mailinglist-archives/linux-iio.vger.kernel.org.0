Return-Path: <linux-iio+bounces-8722-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 755BF95D528
	for <lists+linux-iio@lfdr.de>; Fri, 23 Aug 2024 20:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02A681F238C9
	for <lists+linux-iio@lfdr.de>; Fri, 23 Aug 2024 18:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2991B192B6D;
	Fri, 23 Aug 2024 18:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3Dsk20a"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C727192585;
	Fri, 23 Aug 2024 18:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724437045; cv=none; b=UHeHoGoq1kXesfVkEkZ6NO9H5wXwSjLP2zCnTWFVXlMFwbEJ4kvrikM9aF1aYcxpkByrhPOwOLlproz8e2XIcDx+cyqB92RjpM5fjlCUvbd6YBgbS+2GmrbvhxnzW9isMDid21B38h///mx1I7SjkBVilXIJn9Tx6kumZGsdyy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724437045; c=relaxed/simple;
	bh=ELEh/8U/XhpTzYiXqpqPnwmy2HGOAVgO3wIGOIh2WAQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Oto6ayoXSiXy6zCHprYNxRgRn9Aobci0JXgnM/BdQi7FrCFB4hSMAZjRFY3ur93O2EHyCHrl1bILOOwHPVPTs7zSR3olfkzbg5T7pXLEtGDuUr1cw/MVes+xJuHLs+xXoq5eisqJoYmrvP9dG6gFMt4KNdtlkrbs9bp1bX7JNUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g3Dsk20a; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-371a92d8c90so1135176f8f.3;
        Fri, 23 Aug 2024 11:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724437042; x=1725041842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KnyWsDgDdmHzGpI1ttRRBbvkkmI+2IPKzA7O8Bj7mPs=;
        b=g3Dsk20aYPlH0zYJiPBi7g9w4bYHY/9vHgpY//9/x/oumLXuFe2Ltie5evPoFGNbiU
         NwRWM4zaDVs7fkWZqqA45h8zX4eTXaIDQri0eIzlM0LtHGbM6wkCnB7BeCAGAaOTc2wT
         3PU+BDwwdmetbfNYScQXK5AnjeHQKuxWXW6NdfBNVoe8M87/hFFQ+h3n6QfGnbsBrbxy
         YGqUxf8KWixjzWP7mZ7tl5blTwKVp89FkjDWTx8HmSwGBBgKBArfbccudtM5CgxlQPYh
         xXaufy+C2fHChE+TWbi4VSpJt1bRw31NyCPpSHKnql0QxEcDnPJmOeD+27tt5mkhXOK+
         513A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724437042; x=1725041842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KnyWsDgDdmHzGpI1ttRRBbvkkmI+2IPKzA7O8Bj7mPs=;
        b=G47NJT7fejknaPLR/t4eexTaEkFRK0QA8a8glttxvczln0+GPr2coG08BIUWYTtBS7
         VDklvs0UCoQqKsuGtG9ow7ijTXAta8DoX64PcA4Gv9fNJbiQqDvjNArAzn9S9UITxBG3
         Z9MTAw1I4VckCphddwb+X5x8C8Ox0RkOFhp5Kpu7TG0Ba87M6FJHguXs+JX9yTMHrul/
         wrqEq6YKQPhVd0/12MrjtTVvPFksf0et79lFFV1H3dteVKtmtTviQSkMKQoRow25sPRA
         SQmJBUjGwPQbacI0M/Sg3PPfGFkvQ4KsXJIfrcMsZwBulrVFNE1WrrVRZawMPNgT3Jd7
         Hzxg==
X-Forwarded-Encrypted: i=1; AJvYcCUPgJ3/P1AF5vffNXQtMIqCXpbHxsdu+xQGV1vsjbB6fHsUqbye2ztJdg1pp/+KTc1BOHedXoJIKj97@vger.kernel.org, AJvYcCXDAGD5Ur+ZbxG3BMtI/iUkdgJwasWnQtiyBeGX08AQAZUoQU1AtnSMcP/ziTeGUnJg1W3F2yraJGCy@vger.kernel.org, AJvYcCXdCFX+0UHPrPoVrItfgUtEr8omfvBz8p4oMthSPon9N8v12/0TXsImWiTHOqWUbyUA9UDoGC6vXA3F+aoy@vger.kernel.org
X-Gm-Message-State: AOJu0YygF8+gsMKqngPPYCJ7EKRYkPPllJrtiUmXLn6orTJR801c3qih
	i+faZ1nyZFHWMTvqN4F5piLX4QjtxHVZiFiSJpMLkbAXnRNRO9/S
X-Google-Smtp-Source: AGHT+IG5FQPD1Av1eiqKZfDgPpWmLf8u0kInlvmBUKc90S86F2JCHTQF1PNprUt47iz6s8Ebr14rJQ==
X-Received: by 2002:a05:6000:2ad:b0:371:8484:57d7 with SMTP id ffacd0b85a97d-3731185e93amr2102022f8f.15.1724437042006;
        Fri, 23 Aug 2024 11:17:22 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:f90d:5a72:8d56:a041])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730814602asm4677939f8f.44.2024.08.23.11.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 11:17:21 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com
Cc: vassilisamir@gmail.com,
	ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org,
	biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com,
	semen.protsenko@linaro.org,
	579lpy@gmail.com,
	ak@it-klinger.de,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/7] iio: pressure: bmp280: Remove config error check for IIR filter updates
Date: Fri, 23 Aug 2024 20:17:10 +0200
Message-Id: <20240823181714.64545-4-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240823181714.64545-1-vassilisamir@gmail.com>
References: <20240823181714.64545-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When there is a change in the configuration of the BMP3xx device, several
steps take place. These steps include:

1) Update the OSR settings and check if there was an update
2) Update the ODR settings and check if there was an update
3) Update the IIR settings and check if there was an update
4) Check if there was an update with the following procedure:
	a) Set sensor to SLEEP mode and after to NORMAL mode to trigger
	   a new measurement.
	b) Wait the maximum amount possible depending on the OSR settings
	c) Check the configuration error register if there was an error
	   during the configuration of the sensor.

This check is necessary, because there could be a case where the OSR is
too high for the requested ODR so either the ODR needs to be slower or the
OSR needs to be less. This is something that is checked internally by the
sensor when it runs in NORMAL mode.

In the BMP58x devices the previous steps are done internally by the sensor.

The IIR filter settings do not depend on the OSR or ODR settings, and there
is no need to run a check in case they change.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index e01c9369bd67..736a1f4fd5dc 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -1557,14 +1557,12 @@ static int bmp380_chip_config(struct bmp280_data *data)
 	change = change || aux;
 
 	/* Set filter data */
-	ret = regmap_update_bits_check(data->regmap, BMP380_REG_CONFIG, BMP380_FILTER_MASK,
-				       FIELD_PREP(BMP380_FILTER_MASK, data->iir_filter_coeff),
-				       &aux);
+	ret = regmap_update_bits(data->regmap, BMP380_REG_CONFIG, BMP380_FILTER_MASK,
+				 FIELD_PREP(BMP380_FILTER_MASK, data->iir_filter_coeff));
 	if (ret) {
 		dev_err(data->dev, "failed to write config register\n");
 		return ret;
 	}
-	change = change || aux;
 
 	if (change) {
 		/*
@@ -2154,15 +2152,13 @@ static int bmp580_chip_config(struct bmp280_data *data)
 	reg_val = FIELD_PREP(BMP580_DSP_IIR_PRESS_MASK, data->iir_filter_coeff) |
 		  FIELD_PREP(BMP580_DSP_IIR_TEMP_MASK, data->iir_filter_coeff);
 
-	ret = regmap_update_bits_check(data->regmap, BMP580_REG_DSP_IIR,
-				       BMP580_DSP_IIR_PRESS_MASK |
-				       BMP580_DSP_IIR_TEMP_MASK,
-				       reg_val, &aux);
+	ret = regmap_update_bits(data->regmap, BMP580_REG_DSP_IIR,
+				 BMP580_DSP_IIR_PRESS_MASK |
+				 BMP580_DSP_IIR_TEMP_MASK, reg_val);
 	if (ret) {
 		dev_err(data->dev, "failed to write config register\n");
 		return ret;
 	}
-	change = change || aux;
 
 	/* Restore sensor to normal operation mode */
 	ret = regmap_write_bits(data->regmap, BMP580_REG_ODR_CONFIG,
-- 
2.25.1


