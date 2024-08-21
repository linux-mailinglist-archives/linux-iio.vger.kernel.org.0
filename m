Return-Path: <linux-iio+bounces-8665-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8203595A73A
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2024 23:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F06CD1F22C6B
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2024 21:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4647E17BB08;
	Wed, 21 Aug 2024 21:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SK+lyOCj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AA117BB0A;
	Wed, 21 Aug 2024 21:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724277452; cv=none; b=p3aQLjen8+kviyk/F0TsZiUVBTrXuLioCVQnqMWImhD9IvVo1BEPI4voqUA/LZf0CTXnoqd3Ux9pgYI6L/HTHouPHROP7obm52+l9n3jr53zp5JAU3jeb3o5ls1Y4aP9lqegYU0xua9MNPd92ku0IklXXEgcnucUKsOAs9jJPVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724277452; c=relaxed/simple;
	bh=ByQmzSKgsLC2Ez1Bu1l5az2nvxnBX60QPq8um18R+Uw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Uo10OWWW/XaVNclXI0WbSzUcekU8L8Z/ncSqzDwoCSzDwOSVP/y9Wazgr0FFICFNN4pHx17gHfT+E4IcDp/eRENQvaQKcpFm9inu/D+TzS6haVM9u8vL6xLUOoC5rXWxfMkmaYUGMMbxnCgEDksps+PIRc0UK7C6eTXPl/J7WD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SK+lyOCj; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3db157d3bb9so79371b6e.2;
        Wed, 21 Aug 2024 14:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724277449; x=1724882249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkTLpaLrmy3BxDBwaB1+2Zmk+X/0Igy34RCtn19SnOY=;
        b=SK+lyOCjLnoc1hsWC4Eg094IK12kSHcAklAmCf2pj6s8kUwV/9Wmwls59wvULuvytx
         we6VxA2jFmFRUr6wgTXtGne0aJAhYQBwYPAZWA5u4SE487ArdI9QbZmc0d7qdYQg4r/I
         cfvZAfE7Mhho1+qtsSvn2sNCpqvYymuCC5EthQ0Ql1l1cOMDf1G83aRrc5sgKyYRHITc
         RC/b73Qwrig8ASlikGTpO43vQnI38rafM4AzLtYR+QTj4HazEgps31AI+mMwp8TLIGFA
         9fnz8MP1STJq0bpZQRU0oiIeaNDCGUidrZcw/kMq+ptBUsPBJUmVdkPgV8eXmjZ4Otud
         O1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724277449; x=1724882249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WkTLpaLrmy3BxDBwaB1+2Zmk+X/0Igy34RCtn19SnOY=;
        b=tmQG9tAsmJyVkABJoZkj/UUNpcU5UW0zt1ZoH/7DJFXAU7XhHDDGjf/oNzrSTocbIb
         YgASmNqn+VjYNBTQDDHIq3gMuuwlorQVBvZUtwqivTBKgmu92mp/td6aS00wTV0PB5y0
         KOv47NrxghSpwa9UHW2EtsUn25NELKzqvtNWalqN42AUYrQF3cApGx/MiPnlz7Aaqbhi
         fgnQC2S9NrkdWBFiyDvimjMDcT6siiDeoAerx03tT32LuPSxhLMwGpNXGVk/Y/fUSLfv
         WRP80yu5rHv8vqkttCGvoVB+9Jw6KBNTmDx/RdRJqapKFnnkZdqJt9sk7tZU0zh9U7Pe
         7BIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlBWxV97NhrAZZVZaIPI7nCNQgqSWulketF1xSBA6/oY83cFnHkdWVaX8Yzzy9kLXlsIbyQd1cN4H9@vger.kernel.org, AJvYcCWUTisZg9J5izRqwFmq3WLWSjtGUzR/RILGM/tJnVcwj1Sx5OTg9dVRIs76lF1qWFAjPcxk3oa0FNwr@vger.kernel.org
X-Gm-Message-State: AOJu0YyqwHnSzNzHg8uosG2s8cdAKdPwqYKnfseEqluMXPzdgYhEM4EG
	0ZvN19dhB+eIk8WKFynnA5wzP6oJ09B25qNNL0txW4mGu8Z1yOV0
X-Google-Smtp-Source: AGHT+IG0g+ItvbLGFC4CrC1tDA+EwYrPd6P5p9u4y4eTdOg8SYQpZesNcarolPBA3iTnoSWiVjSeXQ==
X-Received: by 2002:a05:6808:3090:b0:3dd:4376:db2c with SMTP id 5614622812f47-3de194e0b70mr5175137b6e.9.1724277449522;
        Wed, 21 Aug 2024 14:57:29 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf:81a9:2325:e0f7:7376])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3de225555b6sm47070b6e.17.2024.08.21.14.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 14:57:29 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-sunxi@lists.linux.dev
Cc: linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	quentin.schulz@free-electrons.com,
	mripard@kernel.org,
	tgamblin@baylibre.com,
	aidanmacdonald.0x0@gmail.com,
	u.kleine-koenig@pengutronix.de,
	lee@kernel.org,
	samuel@sholland.org,
	jernej.skrabec@gmail.com,
	sre@kernel.org,
	wens@csie.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	lars@metafoo.de,
	jic23@kernel.org,
	jonathan.cameron@huawei.com,
	Chris Morgan <macromorgan@hotmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH V4 01/15] iio: adc: axp20x_adc: Add adc_en1 and adc_en2 to axp_data
Date: Wed, 21 Aug 2024 16:54:42 -0500
Message-Id: <20240821215456.962564-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821215456.962564-1-macroalpha82@gmail.com>
References: <20240821215456.962564-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add the register for adc_en1 and adc_en2 to the axp_data struct. This
allows us to specify a different register to enable the adc channels
for different devices such as the AXP717.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/iio/adc/axp20x_adc.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
index b487e577befb..368ba6ee7a80 100644
--- a/drivers/iio/adc/axp20x_adc.c
+++ b/drivers/iio/adc/axp20x_adc.c
@@ -889,7 +889,9 @@ struct axp_data {
 	const struct iio_info		*iio_info;
 	int				num_channels;
 	struct iio_chan_spec const	*channels;
+	unsigned long			adc_en1;
 	unsigned long			adc_en1_mask;
+	unsigned long			adc_en2;
 	unsigned long			adc_en2_mask;
 	int				(*adc_rate)(struct axp20x_adc_iio *info,
 						    int rate);
@@ -910,7 +912,9 @@ static const struct axp_data axp20x_data = {
 	.iio_info = &axp20x_adc_iio_info,
 	.num_channels = ARRAY_SIZE(axp20x_adc_channels),
 	.channels = axp20x_adc_channels,
+	.adc_en1 = AXP20X_ADC_EN1,
 	.adc_en1_mask = AXP20X_ADC_EN1_MASK,
+	.adc_en2 = AXP20X_ADC_EN2,
 	.adc_en2_mask = AXP20X_ADC_EN2_MASK,
 	.adc_rate = axp20x_adc_rate,
 	.maps = axp20x_maps,
@@ -920,6 +924,7 @@ static const struct axp_data axp22x_data = {
 	.iio_info = &axp22x_adc_iio_info,
 	.num_channels = ARRAY_SIZE(axp22x_adc_channels),
 	.channels = axp22x_adc_channels,
+	.adc_en1 = AXP20X_ADC_EN1,
 	.adc_en1_mask = AXP22X_ADC_EN1_MASK,
 	.adc_rate = axp22x_adc_rate,
 	.maps = axp22x_maps,
@@ -929,6 +934,7 @@ static const struct axp_data axp813_data = {
 	.iio_info = &axp813_adc_iio_info,
 	.num_channels = ARRAY_SIZE(axp813_adc_channels),
 	.channels = axp813_adc_channels,
+	.adc_en1 = AXP20X_ADC_EN1,
 	.adc_en1_mask = AXP22X_ADC_EN1_MASK,
 	.adc_rate = axp813_adc_rate,
 	.maps = axp22x_maps,
@@ -988,14 +994,16 @@ static int axp20x_probe(struct platform_device *pdev)
 	indio_dev->channels = info->data->channels;
 
 	/* Enable the ADCs on IP */
-	regmap_write(info->regmap, AXP20X_ADC_EN1, info->data->adc_en1_mask);
+	regmap_write(info->regmap, info->data->adc_en1,
+		     info->data->adc_en1_mask);
 
 	if (info->data->adc_en2_mask)
-		regmap_set_bits(info->regmap, AXP20X_ADC_EN2,
+		regmap_set_bits(info->regmap, info->data->adc_en2,
 				info->data->adc_en2_mask);
 
 	/* Configure ADCs rate */
-	info->data->adc_rate(info, 100);
+	if (info->data->adc_rate)
+		info->data->adc_rate(info, 100);
 
 	ret = iio_map_array_register(indio_dev, info->data->maps);
 	if (ret < 0) {
@@ -1015,10 +1023,10 @@ static int axp20x_probe(struct platform_device *pdev)
 	iio_map_array_unregister(indio_dev);
 
 fail_map:
-	regmap_write(info->regmap, AXP20X_ADC_EN1, 0);
+	regmap_write(info->regmap, info->data->adc_en1, 0);
 
 	if (info->data->adc_en2_mask)
-		regmap_write(info->regmap, AXP20X_ADC_EN2, 0);
+		regmap_write(info->regmap, info->data->adc_en2, 0);
 
 	return ret;
 }
@@ -1031,10 +1039,10 @@ static void axp20x_remove(struct platform_device *pdev)
 	iio_device_unregister(indio_dev);
 	iio_map_array_unregister(indio_dev);
 
-	regmap_write(info->regmap, AXP20X_ADC_EN1, 0);
+	regmap_write(info->regmap, info->data->adc_en1, 0);
 
 	if (info->data->adc_en2_mask)
-		regmap_write(info->regmap, AXP20X_ADC_EN2, 0);
+		regmap_write(info->regmap, info->data->adc_en2, 0);
 }
 
 static struct platform_driver axp20x_adc_driver = {
-- 
2.34.1


