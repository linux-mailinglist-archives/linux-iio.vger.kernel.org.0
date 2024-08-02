Return-Path: <linux-iio+bounces-8150-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 691339463B2
	for <lists+linux-iio@lfdr.de>; Fri,  2 Aug 2024 21:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CCB61C210A8
	for <lists+linux-iio@lfdr.de>; Fri,  2 Aug 2024 19:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8A51547FF;
	Fri,  2 Aug 2024 19:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IM9Dywrp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4533547F64;
	Fri,  2 Aug 2024 19:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722626572; cv=none; b=fDViL2oFr27dFWUH4hVDJh7vgo9Y10hPK8kahKFDEtyE0D3zYz3X+R9dl3LzK+17TANVeCftkXhVycDorzOYLdBGr20GDxUq1j/e36OP+axK7+sX7Vel37xhKXarnY8NfetpNBcFBf6vR2AAUfr6fb5B+kwFh4w/temWhw1DDvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722626572; c=relaxed/simple;
	bh=oeKh3JxFFyFc9s3MxdEoaLMTx5bHc9Y7RCEmv06+bT0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aEkc9+gnWESJmRaAduhwHSXr2WZZuO14/VdNqbyUeSNnojufNG2rzBPXk7A6Z/zMB9muEyM38T1z0NdWQBSIbNm0Kf/DfYu6iA2UUzON9WJ2u9ZbYP8V+5Cb4brpHN2lgMFYouyp0MSPUMnQJw0Y/N9Hly0hAZOLExcGX1FsYIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IM9Dywrp; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3dab336717fso5701015b6e.0;
        Fri, 02 Aug 2024 12:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722626570; x=1723231370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MibRB3AQvGbIlGoFS4ggjPfR2n/+IwZ38Kf7aUZ1OD8=;
        b=IM9DywrpGnf8YkIg2lEL5aXS2RkYAGUdvsbqn7qMqIZ4j43W4sG13ZUw1V908dCwUB
         otVcIBExyc9T1cflDqJOHJPZNT5TiYsRya0pLuYDYKJIzd05YDzRWtkrbSpp87A+EjmI
         faI3F3gX07o4GDR1/ghoj7bwIxBpLKYSq8npQG8S93ye/LOBbiYjMTujjvK87U0LGhvf
         TzkOlWtJdZ6yhIrAbskJj7JgqjGqVbVt4iLz1E992F35rrf52Gw0rigNgYkTZwmkxPfH
         GgwUAjK2MuXhyMLJQUMrs4k4y0a+yrCPzvlAOOPoGUHCblMCW37MCzj5h7Ge8lDpz6aj
         FyOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722626570; x=1723231370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MibRB3AQvGbIlGoFS4ggjPfR2n/+IwZ38Kf7aUZ1OD8=;
        b=Pr9zYkLzdXFAUH2j8WSgezIuItkE5yVPfDeeiDlLRBorJOAmv1RJ8LWl+JbMfQfvgN
         I3Y1X+mc8bI/hmjei/bI61VMR6pNh3MNJGRD1aDDmtLkjWmIoEXshwwIzB40CR8I8O9D
         KJ2WDH9o1GdW5ic5uWXsc88/oQHF9eY2cVE8UWx+cEbsCU2TiOGcSIQ0JQPWOze7UbOM
         f1Kogz7fHaYmwvKB/V0GSmhPIKDCXMCYj4v01vr985pnwhf5Iy5ZXOHLBABkJ1z56PFU
         VtkEsdOWRg9aZ5zrzOVomIjgiNjcwMZLYy4U2+y1Dl4QNPpZoqZYlwsZXx1cfLCESJVs
         44JA==
X-Forwarded-Encrypted: i=1; AJvYcCV5pQn7MDFTkk5vJE3sSR+NtXd/+VJdjFPE0TQFsFrtsj9sq4/WYGQLSS0s0OsPrBO1R6qkPKrX5j8Y4dv+YabUDcsR9r8XmysTempNuCUo/lHaodapk8/VqD0CJLJKyJ/QXfs5Qg==
X-Gm-Message-State: AOJu0Yzm3smFVP/3yJEy1OmbhUWSjXeQMOa5wLE8aYNRl6qY0XH+nQ73
	UsTomKyaVeM9ElXebpVCNhIieO77YvEGFUAw8g5KoUedbgUBuRYP
X-Google-Smtp-Source: AGHT+IGiyHXqIqt2Gxy3xDWDxaI1wwnaQV2gEmdDkbsTJ9N/Zvz54RsUGUUI1CFHapa/j3O/y0nxFg==
X-Received: by 2002:a05:6808:2126:b0:3d9:3e48:8af7 with SMTP id 5614622812f47-3db55830c83mr6143565b6e.40.1722626570257;
        Fri, 02 Aug 2024 12:22:50 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3db563b7065sm584592b6e.46.2024.08.02.12.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 12:22:50 -0700 (PDT)
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
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V2 01/15] iio: adc: axp20x_adc: Add adc_en1 and adc_en1 to axp_data
Date: Fri,  2 Aug 2024 14:20:12 -0500
Message-Id: <20240802192026.446344-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240802192026.446344-1-macroalpha82@gmail.com>
References: <20240802192026.446344-1-macroalpha82@gmail.com>
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


