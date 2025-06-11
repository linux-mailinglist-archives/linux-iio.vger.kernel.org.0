Return-Path: <linux-iio+bounces-20512-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CB1AD62E8
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 00:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD4011BC33A0
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 22:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2628128DF02;
	Wed, 11 Jun 2025 22:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UppqaxXN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392ED286D6F
	for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 22:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749681781; cv=none; b=r78B4P/Tuy9SdwiwaKN+dyFaED9eiFrVkDevxN/Xt4WKqkKg/Ng0M0ITOYBDDGEYtgfdZAqtMvx2mdc899N1NYNQp4z5J9ih5uEkdNAtO5KjpWEGSEYCyejmnSmGHCdvhEJy2ehOzNaagGX57bg/VWPOTCFaW7yGiV8HxzWPzVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749681781; c=relaxed/simple;
	bh=iremmMu1ndnd7A4Ps07xEYpBZI14kNGzGGkmeue7GjM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rJt1Z2EMtgvAkxdQnwwz6/4ckVliW7nnblefCxrPbIAv9k7dDVr+j1b20k6hComw/J76qm+vNlr9YZnNIj07UoYZ7R+J6f/Yj2690Go8kfzUQwlvKV4FLuZIXHP1jdZOMhn1ymCvyIJrD+wX+r5QK7vN3zEKKXLMDRVoz/jnYUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=UppqaxXN; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-408d7e2ad03so219750b6e.1
        for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 15:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749681778; x=1750286578; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7gNeyiiatnOg12pB5RbWcv5kPhqcJXqPYg/9AFCOdp0=;
        b=UppqaxXNXYQQBK1xtmEkImo9br0NF6WhxmPgCJznezuAsTSdKUxd7Zbu2kGq2UEpmG
         U9YKjlez62Ur+4CAGF5PUI6bsxZZlZRIJ7hzW8Zg0bqqlYp2nNHLSwnLsPFpLjtSSDRB
         tH4jd3NOF9EvZ4GjDS5hfZVU6Vu2x+OQjaHp8JepyU8+y4roPl9G8C3QQAoYEcKHc0ZF
         d0zMJamRxDe2zrU1mBeZNLRZU/WmUD7g6ZCBKR03NnN4PkvAh2w0bAJTLYoFHsRdamNk
         WjLeG2ZUMT9F6TnAyvsZDIss7nzvdLbSzNqs0GDTiNdJACZVADRAYSdapIH6Mh2OHrHK
         ov2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749681778; x=1750286578;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7gNeyiiatnOg12pB5RbWcv5kPhqcJXqPYg/9AFCOdp0=;
        b=SiSeO2rTS8bDX5CQiM0qA3eRt3adVVZXXdnWSl7Rvod98/sxLqh72UNLDFgwJ+bIWC
         oWfRFGz+emiJVyhqjnhco4peqR+T5xqkR5MJnyKTJrXdnWE2MLPvKGmfu8UqwQqodrNI
         lH/PtI+4FDxD5NvkYrP9AzH6mpscxt4mVXh64V/+rs0XjBOl2n/6AQmF5YOk+ilMKpz0
         2i8sCkxbQpAtaN2VwglJkq8ritwIlV5VFGgeVtU8PewcE6E26hqarjDDLxn01f7TwHwO
         AhwK4Fef8YlB7p93aln1aib67wdj4lhzzhXHGnek9IKz5GI16ZOh9D9AhxtlXbRn9iwM
         +wYA==
X-Gm-Message-State: AOJu0YwUQe19yYbVExLuPw0e02Isbf0uv6fCL5LiOFbMtxwkyrhFyGXn
	+X+tjBJPTJnjBI8JFnWmozyT7bCAxDNUHaUFsuReoo3jk1vuDAmddzDMWpcGL7RM/RY=
X-Gm-Gg: ASbGncsDlUO7+iWQG5efoQQPM8gw/6OoHpmLYHs9Q2dc+q2+acENdwbe8esIQ5TFlb1
	W8JlXFllZY77r6RhHYCaIJwfgz47ovk1DZn9M/1/tkaxXOP+7laJDhOqBXFBKp+T1s6Ld+6kCzS
	BjjhOCiScWJ0CrbkEeqfHVBGWRWAv08RmTOL3DyvBr7bxFZin78uTB69Bw4/Evsa+buCXLVleKB
	06wGGuG07J9MS/VlQi1G9pzhsHuF+By5Vdwtdz/QRjv0KyP9PB99o1K0Xm57BngQzMuF46YLpNz
	m96UjIdTSUoJ7/nVFz+l3XmHwgeDhVRBl2pei9MD7MSPEU2dlbG7eJLyvwBBAx2WWFCa
X-Google-Smtp-Source: AGHT+IF8vLl1oZyRXlNmWN4+7O4lpLib8z/LRQvjmS2nfSR+pVwcY8I2vpYyrg4nGSIO9hYnaIgubg==
X-Received: by 2002:a05:6808:2395:b0:406:59f3:738d with SMTP id 5614622812f47-40a65f82d85mr1058633b6e.4.1749681778380;
        Wed, 11 Jun 2025 15:42:58 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:4753:719f:673f:547c])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40a682fbf05sm24684b6e.32.2025.06.11.15.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 15:42:57 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 11 Jun 2025 17:39:13 -0500
Subject: [PATCH 21/28] iio: light: veml6030: use = { } instead of memset()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-iio-zero-init-stack-with-instead-of-memset-v1-21-ebb2d0a24302@baylibre.com>
References: <20250611-iio-zero-init-stack-with-instead-of-memset-v1-0-ebb2d0a24302@baylibre.com>
In-Reply-To: <20250611-iio-zero-init-stack-with-instead-of-memset-v1-0-ebb2d0a24302@baylibre.com>
To: Michael Hennerich <michael.hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Francesco Dolcini <francesco@dolcini.it>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>, 
 =?utf-8?q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>, 
 kernel@pengutronix.de, Oleksij Rempel <o.rempel@pengutronix.de>, 
 Roan van Dijk <roan@protonic.nl>, 
 Tomasz Duszynski <tomasz.duszynski@octakon.com>, 
 Jacopo Mondi <jacopo@jmondi.org>, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Mudit Sharma <muditsharma.info@gmail.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 =?utf-8?q?Ond=C5=99ej_Jirman?= <megi@xff.cz>, 
 Andreas Klinger <ak@it-klinger.de>, 
 Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=804; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=iremmMu1ndnd7A4Ps07xEYpBZI14kNGzGGkmeue7GjM=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoSgYP8WsYQcwPg/QZttEVQAubGL55qot8Hvrta
 PXX1og+vq+JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaEoGDwAKCRDCzCAB/wGP
 wMjAB/9UreFKkkIj5dONnjnnK8DcB0PP9NwVYQE0mLIdoU7NMfJo1xDYNFB//ohFjvbKA3cP7xn
 TZULWqPy8UzorusrfpYLqSjNuqe/iSnOJUyt0URfEW+PFO2iBTYLbevM1E3jZs4OP3y1H9P0LkP
 lzFF9/gmEjEOZ8TX2HDvoHjSthCnmkIbB0rZgSAWzV2CtwsWAbz3cJmYxU45vdgfhXTi5o81ife
 +AQ7EmHHgG7cy49HOGnvublhmnWgpvoPulkVMW5/n7FkpryUfUCAzJ65gmUs/8B74qZPpycDA+E
 4e5skikbdS1v1z198Lxa16R09kc1jTul4iUxmi1lPrhTkD4C
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use { } instead of memset() to zero-initialize stack memory to simplify
the code.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/light/veml6030.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
index 473a9c3e32a3a53f373595a5113b47e795f5366c..0945f146bedbda79511e704158122acaac5e60c1 100644
--- a/drivers/iio/light/veml6030.c
+++ b/drivers/iio/light/veml6030.c
@@ -892,9 +892,7 @@ static irqreturn_t veml6030_trigger_handler(int irq, void *p)
 	struct {
 		u16 chans[2];
 		aligned_s64 timestamp;
-	} scan;
-
-	memset(&scan, 0, sizeof(scan));
+	} scan = { };
 
 	iio_for_each_active_channel(iio, ch) {
 		ret = regmap_read(data->regmap, VEML6030_REG_DATA(ch),

-- 
2.43.0


