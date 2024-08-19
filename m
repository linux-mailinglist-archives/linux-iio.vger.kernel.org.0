Return-Path: <linux-iio+bounces-8603-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE079570BC
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2024 18:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5439E1C22113
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2024 16:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74C6179953;
	Mon, 19 Aug 2024 16:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mF98XSrN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098E41741FD;
	Mon, 19 Aug 2024 16:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724086125; cv=none; b=RTMmjfidbrkm0uwRZp3SediNe3+B5V0JHYG6sGSGm1mBvd41isWOThFaiRSy1hueOKMXpYhHgs9qHIHBao1wNrka05fobWG111mDq4UcVV5Rs8dp0IIc2hBAHtGMbTf3pJ2QBjYr0Lp72PT2Tlv8tyx9Q1HGicI7CM4n5FhX6EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724086125; c=relaxed/simple;
	bh=ByQmzSKgsLC2Ez1Bu1l5az2nvxnBX60QPq8um18R+Uw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HegLoXOg+z2Tozr3FAjLeN4tngm3axVyOqmMZtx8V9uBk7BkUe9UDqqXaSPr05pLTxbu/SksVeTtNs6Zu/hGCp5mqTE4d2e1eBtz4Dsl7T9q53lwZESOqr4Llkes6n4ke2AQdIqSHWl+ha64KCThOyfsHS94fejrLfZmNu857OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mF98XSrN; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-70941cb73e9so2258063a34.2;
        Mon, 19 Aug 2024 09:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724086123; x=1724690923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkTLpaLrmy3BxDBwaB1+2Zmk+X/0Igy34RCtn19SnOY=;
        b=mF98XSrNX1SGHbHJxMucvaSpWi0hn78Gk45myZxsvQV0uyngJTER3efJ7r+lVPCFoB
         caxgT5w/b3u/bNSW+OuQLLbbfsKsEumHzokL856cwb8lqBHAsb85/Gn70K0zvTWxDjgN
         sAnYgSJnRcX3gCyGTSkqRJvPn14f1HgOL1EiDnFNlw6SO1oPxCHp0H41zFnrd4eouFNV
         oz2Tk3+6HVddlcoNTkvy5RWaPzb2S22CeB5xcu/dCX7RLnDpWWoAC6YZBucWPY3InQAP
         IJB5Zuvz5yC9H2mF4qZZ8U7IUE4dEzMHqAbZfjmFiBYX+xUoI/9Q8+Or7sHnDxT3G3nn
         NhxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724086123; x=1724690923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WkTLpaLrmy3BxDBwaB1+2Zmk+X/0Igy34RCtn19SnOY=;
        b=rVC0pqUSXy6BpwPiVwsp1jlqo9t0+yLCjv1h8hUnPiwHOH21WI0q7yE0icX56hfxVi
         1o9MrixTfl6CgABSVTDD/z/PkRKGfq8V7hEad1EWhinfszsg5ERmjAioaZxi/A56w/3N
         c58dlY5QTWmQ/QCAV59aYwKPyQWIURyEqjA5KlFBGQ7fZsx9ji9+HiHeyQkOYWH5ifJG
         U1VOzRGD+Jc+fEb95U0NZVL8IRijnsLQ5xuU0nEgRWD22pGNvOPOdwqLkRmAp68/zeXN
         qGQMsiHbOLnWRalwL7aqLj5Smw0YqQ9YuxIzg0WQj+9Bbdj3QWK9dOEd8SCuUl1BJ7Ec
         hRig==
X-Forwarded-Encrypted: i=1; AJvYcCU7otMSongazFDeta0S2jjkscCznG3lLB1v7qHmydHuTO/kjuJnxm0E+A7nuIQFbvFFCTDeknVRcr6x1i+unJL737umkEx2bKB+iZ0zCw4rgHN/P8BRb6smTNGWyle+4e0hQVhyYw==
X-Gm-Message-State: AOJu0Yx4ql0EObbl+zZV18/Adyw1kNbZkzY36YdQbAkOO+l4bu7waX3J
	1nLEhg3E4Mm3xvNBPNvuUTyroTJUHe02KNKjTYqCGwqK2zEQmkZi
X-Google-Smtp-Source: AGHT+IEielcGYZURUYCkdiY1sv7fhZ692W4q8URFL/ta+IKVzCfe94ydQiEeafp1lIyynTDkxNazaw==
X-Received: by 2002:a05:6830:6d09:b0:703:68e5:725b with SMTP id 46e09a7af769-70cac8c20bfmr15012910a34.24.1724086123067;
        Mon, 19 Aug 2024 09:48:43 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70ca649c61csm2332428a34.26.2024.08.19.09.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 09:48:42 -0700 (PDT)
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
Subject: [PATCH V3 01/15] iio: adc: axp20x_adc: Add adc_en1 and adc_en1 to axp_data
Date: Mon, 19 Aug 2024 11:46:05 -0500
Message-Id: <20240819164619.556309-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240819164619.556309-1-macroalpha82@gmail.com>
References: <20240819164619.556309-1-macroalpha82@gmail.com>
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


