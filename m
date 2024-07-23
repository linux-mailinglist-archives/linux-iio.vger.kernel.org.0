Return-Path: <linux-iio+bounces-7829-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EF593A786
	for <lists+linux-iio@lfdr.de>; Tue, 23 Jul 2024 21:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 068ABB20FCD
	for <lists+linux-iio@lfdr.de>; Tue, 23 Jul 2024 19:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92AA913DBA4;
	Tue, 23 Jul 2024 18:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QnE1S6JE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45E013C3F5
	for <linux-iio@vger.kernel.org>; Tue, 23 Jul 2024 18:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721761199; cv=none; b=pagv1PF39bygJzSFT4vel0GjJTmuoqzVumbzAqi4ai/uNMsgLMxTqmMG/gEsLKt2RB8yfbJvRC68Uw20/ZwaPJzNdIX/Ymrbb8U7HEiH+3GfGrbItA5nWNLZRrsyH1G28mUtPHsnO6INh09dwIz3KUdM0BaOA//vX4u7+mE3zl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721761199; c=relaxed/simple;
	bh=iyS1ByyUx4twpm9hP+yKFrlEdFKQoGHxhjKyw1jAN64=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Cl9VCdtVLyxYuZG3BJZAsNJ9UkuGSppHBPfJ8usiaVe5HTAWYGsxP3oOQN6i1zrC29FgGCRDByiczPJl94BjD/k2QO2Jtnh5C04+Ua/sSCXEkW4sFMkts5VWQiMFthDslKmovUJC31d+r/0pOlaZZAgz0zMb/3LHhsLg7JA5Bqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=QnE1S6JE; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3d94293f12fso3523855b6e.3
        for <linux-iio@vger.kernel.org>; Tue, 23 Jul 2024 11:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721761195; x=1722365995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=upz/OCbfVuYTOG+l6gDkvMC+JV0tNs7jmWYtWPGntn8=;
        b=QnE1S6JElsVkkeCIxCCYdMSh2fNyeYHYg4EXyl9EkBpLS7w4hVxPIS8OfMIBgBtATc
         m7PcZntSqmn168TWrobOoZNaXwKsykiRdyKdvwovM2io1T2eqei7RRDnssVIdYMLL0+z
         BhIqEgCnwfAUgxI//9/FkhMUJJS9i6ojYGFo3Ceik1C5tFIg2LpYV4kydXVOf9L+ZBZM
         Y23wOmuV/oVCcjYgdnYI21FRaoIzntuJwVMUgnGn4D6K8XyO55cz0I6cYgrvClZzrIB1
         7tOHsDu/JARZChCq0cxQNhOsHQEeLJ2dMUD3Acp8ph/GrWOyUtNGAnVlr9dnjdxoshLO
         OEPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721761195; x=1722365995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=upz/OCbfVuYTOG+l6gDkvMC+JV0tNs7jmWYtWPGntn8=;
        b=vquCaT9GFXFm2S42Zdum9flWsVTESAGgCasvg790VZAqeZTnD1QBFpayIsJTiPzctH
         KBuOFEs6VGFw7n9CJlxAptI3tC3J+8QrxCvwhTjb7qTE3rC6yzTa19Qqvli9g7YmwP5r
         uAxaAxZoQbDNmZ9DRxJO/4N+WswQQLsz0YeJigZfgCAUSwZ/it6lTDGV2Z7Yd+LiIlwz
         3nRG9nBPq/ZuAQVOdwcAnuoquezaBJXefPBeBhCixrtl+Mqu/4K519g9kppAuuN0Sclg
         8Rb99uRxt+QRGJGKoMzHKCHLu1JPKvDAIg09mWR7z56ZbCHJTKEjS5C80aWG2xazgwWB
         0/BA==
X-Forwarded-Encrypted: i=1; AJvYcCUGgjmBfO0HkF4F4HnuPMJncaLEGK7MTC12bRk25ssIdwAj0bwUb0wUMW9sTnFYXGhBVKFTuswm3h4tpReIuGZkdIm2cMu8y0pk
X-Gm-Message-State: AOJu0YwEuUAOfwwv7mfvGoRhlVnOvsE3zCoCMCKKXNnqXT31wehJcn5u
	gKeY1xIMfWfqUF+HHhW6v8laBpx/h7rLR8Xoyfinq4v32eg2w58n+YnNBMg0DCc=
X-Google-Smtp-Source: AGHT+IHWmxzHoa8Zq3eq10vb/pe8QbH2QvQC7hdWVRqF2Zdoo7oipF+bXn58Y1qBgh1MqL2hHJnofw==
X-Received: by 2002:a05:6808:308f:b0:3d6:53fc:e813 with SMTP id 5614622812f47-3db06d99e36mr993749b6e.27.1721761195030;
        Tue, 23 Jul 2024 11:59:55 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3dae0981450sm2100211b6e.24.2024.07.23.11.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 11:59:54 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Marius Cristea <marius.cristea@microchip.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: adc: mcp3564: use devm_regulator_get_enable_read_voltage()
Date: Tue, 23 Jul 2024 13:59:50 -0500
Message-ID: <20240723-iio-regulator-refactor-round-3-v2-1-ae9291201785@baylibre.com>
X-Mailer: git-send-email 2.43.0
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

A use_internal_vref_attr local variable is added to make it more
obvious what the difference between the two iio info structures is.

The return value of the "Unknown Vref" dev_err_probe() is hard-coded to
-ENODEV instead of ret since it was getting a bit far from where ret
was set and logically that is the only value it could have.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v2 changes:
* Rename use_auto_zeroing_ref_attr to use_internal_vref_attr
* Link to v1: https://lore.kernel.org/r/20240712-iio-regulator-refactor-round-3-v1-0-835017bae43d@baylibre.com

(other patches from v1 were already applied, so not included in v2)

---
 drivers/iio/adc/mcp3564.c | 54 ++++++++++++++---------------------------------
 1 file changed, 16 insertions(+), 38 deletions(-)

diff --git a/drivers/iio/adc/mcp3564.c b/drivers/iio/adc/mcp3564.c
index d83bed0e63d2..a68f1cd6883e 100644
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
+static int mcp3564_config(struct iio_dev *indio_dev, bool *use_internal_vref_attr)
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
+	*use_internal_vref_attr = internal_vref;
 
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
+	bool use_internal_vref_attr;
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*adc));
 	if (!indio_dev)
@@ -1428,7 +1406,7 @@ static int mcp3564_probe(struct spi_device *spi)
 	 * enable/disable certain channels
 	 * change the sampling rate to the requested value
 	 */
-	ret = mcp3564_config(indio_dev);
+	ret = mcp3564_config(indio_dev, &use_internal_vref_attr);
 	if (ret)
 		return dev_err_probe(&spi->dev, ret,
 				     "Can't configure MCP356X device\n");
@@ -1440,7 +1418,7 @@ static int mcp3564_probe(struct spi_device *spi)
 	indio_dev->name = adc->chip_info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	if (!adc->vref)
+	if (use_internal_vref_attr)
 		indio_dev->info = &mcp3564r_info;
 	else
 		indio_dev->info = &mcp3564_info;

---
base-commit: 472438c7e0e2261c6737a8321f46ef176eef1c8f
change-id: 20240712-iio-regulator-refactor-round-3-17f2a82d2181

