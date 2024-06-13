Return-Path: <linux-iio+bounces-6232-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F395906B6B
	for <lists+linux-iio@lfdr.de>; Thu, 13 Jun 2024 13:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0730285937
	for <lists+linux-iio@lfdr.de>; Thu, 13 Jun 2024 11:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355AE143C53;
	Thu, 13 Jun 2024 11:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4k31Esz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3806F143866;
	Thu, 13 Jun 2024 11:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718278826; cv=none; b=n32FIAUQAd1tYgwrNC4tGYvhLZoxE6n1ki84GfJYy/Dn+mV5H41r4FKPnCCIMQm6Rv4emy/4JExfwttBdMOmWUvxjFw8Unqbl4if/vesDm+qrdPlvoNaQaVjLMHgy7jlTHDCfzCF7MAo9sWfJPlK1PC/m+ErlKfYYePUFJv8zYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718278826; c=relaxed/simple;
	bh=nWYPQxxwE+yLRvq7s8nxaFNdTduVeGKEK24IxVR0zs4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JDbrsLt54efMsOQnlzOzwutLMLsD2D5PFrk2l48HoEFBssx4V/dWZijbyUiicmMYw8bDx1eShjkNK7y8neS5FAtfls79LL92LU3LJ6Rd3H/WUeR1dFy0fNZbpKmbhhcc55pjbZa/F490WKQbsSGL0PGnL7D+uXQ03tMRap2fJDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b4k31Esz; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57864327f6eso1498453a12.1;
        Thu, 13 Jun 2024 04:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718278822; x=1718883622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OAUSO8vbG3/LrLvVh9qEVuxHdvnZC+R+Dcd/s8Fk7Wc=;
        b=b4k31EszFeFB+jdy+J2/Vv7QfVjJFBcE0wpWc5fxmo1QUh1cCLAUhIHaPbaZyrTFES
         eVY+Tby6kxgkQUhkTsxAFfuIxB0YeVsjYrPsRul8QWNwfNDY1SQZ3V0cLF5F2PsA+RPX
         Ulvri7Ow5reBHpZQ3/OtIfu7KJbVRoA7D8/rIYbIuh3DvnogwjtzeG9cLQ4snOxF2LfX
         xyQ0jVeoTXuz3XH+HZDZ6r9KnH7LzrPQp5EGwpVS2BrzRhASmBv7oOqXwM/U2Yk+E17y
         Kh7d1j4rxgMu2Ej3EYTfL6wY4OMB2o/063u8M0WyV1Inpk8/+Gp0FydkSnHa33aWKCWT
         UJhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718278822; x=1718883622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OAUSO8vbG3/LrLvVh9qEVuxHdvnZC+R+Dcd/s8Fk7Wc=;
        b=IrnrAAKRLfya9eo3VyvYmk6Z8tdP+ekCA3No8aWplLfmAMorBs8+yXk5t00kTh5vO/
         PJnVvBVL7xUj1xRE0m3P/YuOm0LHSsJqex1+CeNgzn7NW/fO0uJ2A+NH95cviiawsQb+
         4fxMqKEpifrqNcqiNmr8tnOevk4/xytae1QeL8p6gi1Z3wakixUhkgfcexuycSa+AsoQ
         W84+5dRJlglb5397rM9nDUvOAxN4z6d44+6ESF1M2yzWsEJbiijDR5iEx4ss2VsIQBMc
         9OsXhK78xipmhvs1lJ4aNp5Ydwq+myQopTSWWNZKrkkZ5pwwlsyfrv+foSZPZjY9xggA
         GeAw==
X-Forwarded-Encrypted: i=1; AJvYcCV7V5p4GcQid0J3M7PRyXO43w0K6R8Bgvq423xh5AFsdDhIxQdpjJTNYngTDpZGVi8dvnClwbMb+fYJktPBaeCJ4ceYIiddPz56FBRAXQVmvkGH+aOk2Ma+0G8Rqc6U4OCP+tgpF8Tj40sEK5eu6wAUP5uyMlUHgvXkGS4FhZBEzarHnA==
X-Gm-Message-State: AOJu0YzJfmmXbmwOhADFFWUBS1HXE5QSad+DITb95Y7MSL8XIHRJzV56
	irOxzkJ+MIF3ny78i5pYaFcOKIRWlxeH5cKEbs7c3wkb6zHiuu5pPxLXqA==
X-Google-Smtp-Source: AGHT+IGqv9YHOq/cJnzJHLpula4WzGgrdHxfJs+LUnrjenQReA0/CIdgQjsBv6SCVpWKW2aecWxxQg==
X-Received: by 2002:a50:d556:0:b0:57c:9c9f:b164 with SMTP id 4fb4d7f45d1cf-57cb4bcddecmr1994558a12.10.1718278822097;
        Thu, 13 Jun 2024 04:40:22 -0700 (PDT)
Received: from spiri.. ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cbb05b465sm308861a12.18.2024.06.13.04.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 04:40:21 -0700 (PDT)
From: Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To: Alisa-Dariana Roman <alisa.roman@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexandru Tachici <alexandru.tachici@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH v4 1/5] iio: adc: ad7192: Clean up dev
Date: Thu, 13 Jun 2024 14:39:57 +0300
Message-Id: <20240613114001.270233-2-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240613114001.270233-1-alisa.roman@analog.com>
References: <20240613114001.270233-1-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clean up by using a local variable struct device *dev. Also use
dev_err_probe where possible.

Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
---
 drivers/iio/adc/ad7192.c | 65 +++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 35 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 0789121236d6..c7fb51a90e87 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -1196,17 +1196,16 @@ static void ad7192_reg_disable(void *reg)
 
 static int ad7192_probe(struct spi_device *spi)
 {
+	struct device *dev = &spi->dev;
 	struct ad7192_state *st;
 	struct iio_dev *indio_dev;
 	struct regulator *aincom;
 	int ret;
 
-	if (!spi->irq) {
-		dev_err(&spi->dev, "no IRQ?\n");
-		return -ENODEV;
-	}
+	if (!spi->irq)
+		return dev_err_probe(dev, -ENODEV, "Failed to get IRQ\n");
 
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -1219,71 +1218,69 @@ static int ad7192_probe(struct spi_device *spi)
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
-	if (ret) {
-		dev_err(&spi->dev, "Failed to enable specified AVdd supply\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to enable specified AVdd supply\n");
 
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
-		if (ret) {
-			dev_err(&spi->dev, "Failed to enable specified Vref supply\n");
-			return ret;
-		}
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to enable specified Vref supply\n");
 
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
@@ -1305,13 +1302,13 @@ static int ad7192_probe(struct spi_device *spi)
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
 
@@ -1320,18 +1317,16 @@ static int ad7192_probe(struct spi_device *spi)
 	if (st->clock_sel == AD7192_CLK_EXT_MCLK1_2 ||
 	    st->clock_sel == AD7192_CLK_EXT_MCLK2) {
 		st->fclk = clk_get_rate(st->mclk);
-		if (!ad7192_valid_external_frequency(st->fclk)) {
-			dev_err(&spi->dev,
-				"External clock frequency out of bounds\n");
-			return -EINVAL;
-		}
+		if (!ad7192_valid_external_frequency(st->fclk))
+			return dev_err_probe(dev, -EINVAL,
+					     "External clock frequency out of bounds\n");
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


