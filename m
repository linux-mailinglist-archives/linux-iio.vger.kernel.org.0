Return-Path: <linux-iio+bounces-7556-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5881D92FE1C
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 18:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E14E3B21F4A
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 16:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637FF176FB6;
	Fri, 12 Jul 2024 16:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WHNli7Et"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C079176256
	for <linux-iio@vger.kernel.org>; Fri, 12 Jul 2024 16:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720800250; cv=none; b=McPFLhqFTbEGnrDirZB4JOE3fMeV+Ix45kBP0Xq3dLdOiWiO5RhkcZdoOidR37H+TwECeogC6oLZyunZQ+eZL4lhThpU9rR6g7wtFGMAMZmJcd6/BS9AWDTex+Tk1qJFX+nKCjk2lM9y3UNtW/z89PbQcfP8zdfiqwvHr/dXs4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720800250; c=relaxed/simple;
	bh=mIcfdse/+rlP58eFFA/PEI/fcZHOFfe3jGuPELWLLNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uRu8HNTh1NMkm3Pm+eXn5v/DL0Vxi27a3wwky69vDJYY45fpJqE+UAYb6R/6vNzWZRKRmhz1/htp/PGVTFQmEyrcKA3KpdOmhiavtKyJDDzaMMFpwUOnKpi7HY9pHJxp3AQ114RnGFPdR0spee9LHuWnBYmbEFZM+Out2V6VfDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=WHNli7Et; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7044c085338so1190748a34.2
        for <linux-iio@vger.kernel.org>; Fri, 12 Jul 2024 09:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720800248; x=1721405048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+LRn09+VizRf0JvYt3kqJDUqFvXhYNVL1CgwtRvMbM=;
        b=WHNli7Et3K9tDbM9vidxaU1Scfyo/sTxka4kgSuR4WWMUIA+/KsbS77Xd5sbgbjkqj
         lJPQEvoElvoRnpn83n9+ZVos8wrxy5MSFLZJIGeu+FX7CU15oKrdXiE8qIwAu4CYcyXn
         rPDdXLj2ZpTa8SVaXS0bBnkD0Z4qVIT9XoFuKPnk/PU0lfWwqao3R7Qvyce8tWVwfkyd
         pa206ND/nqNphVMfR3zUJAZQxbUjPV8nvbFH3sEtxt9RmrgB3tyCL+iUefBGG7Spz/Z5
         8gEszvbEhjNMcgmtompTmYwWntpawOiel4FQc0wmGiVfa+jDSGxGEPZpZRTaD6thrsDz
         DtMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720800248; x=1721405048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z+LRn09+VizRf0JvYt3kqJDUqFvXhYNVL1CgwtRvMbM=;
        b=WbiyAGvLIEsHoG0VXbG9xEeBTbGuEZy2e7Jq0nDtL8EeDwVdvQX+YkmR1NDXQcseGu
         TAwmNoQ7Ajbm/M83HJGdAMx2kmVS4oiMSq7S3w+mOVluOkN3uH9F/bLD2cL8o1PKaxiQ
         0lgWPHGhi4YJ7rKu3d2MiBAxiVIhAp1X+9QJmFvPX9yYls/o4PXQwSz528VfTUJhwTmB
         kCmEaEsZ6fRWU1tlwNj0JMvDATyzIODq89IaxRNXyAs4ZFfz+Uc2vjscGlIIHu3EDQmq
         DNQV1ruUzK0ctDKXwxuFUvXIvJIqWQWdxxUgu45ASy7ZDTCL7jKcjJhgtzOm/6DDZZgx
         L0+Q==
X-Forwarded-Encrypted: i=1; AJvYcCX2JhU9uLxejTGxSaQx8NVNJwMFyshFwzHUkCydsB8vNiNiRAEvnkydbGe3f76M4eQzGcBjYm2nHfZ+IQT7X+Aj24XgDtg61BVE
X-Gm-Message-State: AOJu0Yzd3uWmNo9z7aP0tNVV/MMdkP2Y7wu/K7h0vHCDafmD6vSHrlVe
	03OBuzhkKsBJ5kNMaISVu6P2fLKf8EmL86BkoMG8i/Aackh5lj49vhWChdbo2v8=
X-Google-Smtp-Source: AGHT+IFJqQ4jVYwcPc+YyB6lTtaO4ZRCyIF+arWnpBOToBO1d5MfWdt5nWxhs6AalNLw9FExThA36Q==
X-Received: by 2002:a05:6870:c110:b0:25e:1f67:b3bb with SMTP id 586e51a60fabf-25eae784d0cmr10096191fac.10.1720800247429;
        Fri, 12 Jul 2024 09:04:07 -0700 (PDT)
Received: from localhost.localdomain (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70374f78d35sm1615131a34.23.2024.07.12.09.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 09:04:07 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Marius Cristea <marius.cristea@microchip.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Kent Gustavsson <kent@minoris.se>
Cc: David Lechner <dlechner@baylibre.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] iio: adc: mcp3564: use devm_regulator_get_enable_read_voltage()
Date: Fri, 12 Jul 2024 11:03:56 -0500
Message-ID: <20240712-iio-regulator-refactor-round-3-v1-5-835017bae43d@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240712-iio-regulator-refactor-round-3-v1-0-835017bae43d@baylibre.com>
References: <20240712-iio-regulator-refactor-round-3-v1-0-835017bae43d@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.0
Content-Transfer-Encoding: 8bit

This makes use of the new devm_regulator_get_enable_read_voltage()
helper function to reduce boilerplate code in the MCP3564 ADC driver.

The error message is slightly changed since there are fewer error
return paths.

Setting adc->vref_mv is consolidated into a single place to make the
logic easier to follow.

A use_auto_zeroing_ref_attr local variable is added to make it more
obvious what the difference between the two iio info structures is.

The return value of the "Unknown Vref" dev_err_probe() is hard-coded to
-ENODEV instead of ret since it was getting a bit far from where ret
was set and logically that is the only value it could have.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/mcp3564.c | 54 ++++++++++++++---------------------------------
 1 file changed, 16 insertions(+), 38 deletions(-)

diff --git a/drivers/iio/adc/mcp3564.c b/drivers/iio/adc/mcp3564.c
index d83bed0e63d2..34903b7b3cc4 100644
--- a/drivers/iio/adc/mcp3564.c
+++ b/drivers/iio/adc/mcp3564.c
@@ -349,8 +349,6 @@ struct mcp3564_chip_info {
  * struct mcp3564_state - working data for a ADC device
  * @chip_info:		chip specific data
  * @spi:		SPI device structure
- * @vref:		the regulator device used as a voltage reference in case
- *			external voltage reference is used
  * @vref_mv:		voltage reference value in miliVolts
  * @lock:		synchronize access to driver's state members
  * @dev_addr:		hardware device address
@@ -369,7 +367,6 @@ struct mcp3564_chip_info {
 struct mcp3564_state {
 	const struct mcp3564_chip_info	*chip_info;
 	struct spi_device		*spi;
-	struct regulator		*vref;
 	unsigned short			vref_mv;
 	struct mutex			lock; /* Synchronize access to driver's state members */
 	u8				dev_addr;
@@ -1085,11 +1082,6 @@ static int mcp3564_parse_fw_children(struct iio_dev *indio_dev)
 	return 0;
 }
 
-static void mcp3564_disable_reg(void *reg)
-{
-	regulator_disable(reg);
-}
-
 static void mcp3564_fill_scale_tbls(struct mcp3564_state *adc)
 {
 	unsigned int pow = adc->chip_info->resolution - 1;
@@ -1110,7 +1102,7 @@ static void mcp3564_fill_scale_tbls(struct mcp3564_state *adc)
 	}
 }
 
-static int mcp3564_config(struct iio_dev *indio_dev)
+static int mcp3564_config(struct iio_dev *indio_dev, bool *use_auto_zeroing_ref_attr)
 {
 	struct mcp3564_state *adc = iio_priv(indio_dev);
 	struct device *dev = &adc->spi->dev;
@@ -1119,6 +1111,7 @@ static int mcp3564_config(struct iio_dev *indio_dev)
 	enum mcp3564_ids ids;
 	int ret = 0;
 	unsigned int tmp = 0x01;
+	bool internal_vref;
 	bool err = false;
 
 	/*
@@ -1218,36 +1211,22 @@ static int mcp3564_config(struct iio_dev *indio_dev)
 
 	dev_dbg(dev, "Found %s chip\n", adc->chip_info->name);
 
-	adc->vref = devm_regulator_get_optional(dev, "vref");
-	if (IS_ERR(adc->vref)) {
-		if (PTR_ERR(adc->vref) != -ENODEV)
-			return dev_err_probe(dev, PTR_ERR(adc->vref),
-					     "failed to get regulator\n");
+	ret = devm_regulator_get_enable_read_voltage(dev, "vref");
+	if (ret < 0 && ret != -ENODEV)
+		return dev_err_probe(dev, ret, "Failed to get vref voltage\n");
+
+	internal_vref = ret == -ENODEV;
+	adc->vref_mv = internal_vref ? MCP3564R_INT_VREF_MV : ret / MILLI;
+	*use_auto_zeroing_ref_attr = internal_vref;
 
+	if (internal_vref) {
 		/* Check if chip has internal vref */
 		if (!adc->have_vref)
-			return dev_err_probe(dev, PTR_ERR(adc->vref),
-					     "Unknown Vref\n");
-		adc->vref = NULL;
+			return dev_err_probe(dev, -ENODEV, "Unknown Vref\n");
+
 		dev_dbg(dev, "%s: Using internal Vref\n", __func__);
 	} else {
-		ret = regulator_enable(adc->vref);
-		if (ret)
-			return ret;
-
-		ret = devm_add_action_or_reset(dev, mcp3564_disable_reg,
-					       adc->vref);
-		if (ret)
-			return ret;
-
 		dev_dbg(dev, "%s: Using External Vref\n", __func__);
-
-		ret = regulator_get_voltage(adc->vref);
-		if (ret < 0)
-			return dev_err_probe(dev, ret,
-					     "Failed to read vref regulator\n");
-
-		adc->vref_mv = ret / MILLI;
 	}
 
 	ret = mcp3564_parse_fw_children(indio_dev);
@@ -1350,10 +1329,8 @@ static int mcp3564_config(struct iio_dev *indio_dev)
 	tmp_reg |= FIELD_PREP(MCP3564_CONFIG0_CLK_SEL_MASK, MCP3564_CONFIG0_USE_INT_CLK);
 	tmp_reg |= MCP3456_CONFIG0_BIT6_DEFAULT;
 
-	if (!adc->vref) {
+	if (internal_vref)
 		tmp_reg |= FIELD_PREP(MCP3456_CONFIG0_VREF_MASK, 1);
-		adc->vref_mv = MCP3564R_INT_VREF_MV;
-	}
 
 	ret = mcp3564_write_8bits(adc, MCP3564_CONFIG0_REG, tmp_reg);
 
@@ -1412,6 +1389,7 @@ static int mcp3564_probe(struct spi_device *spi)
 	int ret;
 	struct iio_dev *indio_dev;
 	struct mcp3564_state *adc;
+	bool use_auto_zeroing_ref_attr;
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*adc));
 	if (!indio_dev)
@@ -1428,7 +1406,7 @@ static int mcp3564_probe(struct spi_device *spi)
 	 * enable/disable certain channels
 	 * change the sampling rate to the requested value
 	 */
-	ret = mcp3564_config(indio_dev);
+	ret = mcp3564_config(indio_dev, &use_auto_zeroing_ref_attr);
 	if (ret)
 		return dev_err_probe(&spi->dev, ret,
 				     "Can't configure MCP356X device\n");
@@ -1440,7 +1418,7 @@ static int mcp3564_probe(struct spi_device *spi)
 	indio_dev->name = adc->chip_info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	if (!adc->vref)
+	if (use_auto_zeroing_ref_attr)
 		indio_dev->info = &mcp3564r_info;
 	else
 		indio_dev->info = &mcp3564_info;

-- 
2.43.0


