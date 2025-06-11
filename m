Return-Path: <linux-iio+bounces-20499-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1393AD62D1
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 00:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCE89188509B
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 22:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1DA25B31A;
	Wed, 11 Jun 2025 22:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cj/rOsUy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9240A25B2ED
	for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 22:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749681759; cv=none; b=BnKOYlhO1eGGgzuzpXpc+ctuXnyZl4jMXG36G6cHXt3yh0JT2mlEuuznpROF/hWfZZLZ6Egc6ZwceLEjoP+iKgB69v8vBYfhsSrAs+EvKAyHxv+PPOp31bdRWOgUyrLD7mcSl6PxXC1f3SbXwMfK/7OcbtM+s+wBsL5zNilzmJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749681759; c=relaxed/simple;
	bh=WSd14gc0IglioCpRcpapejeZeHyJEdiW3ePuDI+8374=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IBoMbqxfuRgsqqDNyBV3V8WopEJO2ypB9OEfoNuTi2NoDeTDjqxwshNDbzxioIlH2RKysh4PfMMVFYJA5BpIrh/AHuxfwostjMiJDXWUCMyC5yoQvdaRDfZzX/VzzZxd8R0rqlfFyjDAwJVRcgR6e+09NlYoHp9Wmj5PRTTyB34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=cj/rOsUy; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-400fa6eafa9so224785b6e.1
        for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 15:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749681754; x=1750286554; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DVj0z+6x0ImArb5yGvcedbePq6HiJkWaJeSxbPqOIBs=;
        b=cj/rOsUyWcgzE+OWhmKctnPbbOOt9oRC4UgighH77MWzMrMkc2IEgg10KzfbHNS+ne
         66bYbwGBwu756qRmsMSePG99OKC3xMGEy4SV2+7YnWQzvcuqMYGXItoDdheIIKYKPus6
         qdWfckiAxyR9f8RmJACZDz4jf2llWbUXfo/MVhjfM5e4N7xSGN1KMVLkxGtiqwXzDabg
         m3j7UGFI3J9cClCPXEnbNxA2Cwu794+GENp6WaG9xcfQLwtSzc3NS5PUaMdq4I9FeXW9
         PB1kfaA6R7+3QrP9zJC0Xc8rpUWRLCQmI8aghrPOz2xoAOzIfeYBzqqZHwd4DbFbpxlU
         Hbkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749681754; x=1750286554;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DVj0z+6x0ImArb5yGvcedbePq6HiJkWaJeSxbPqOIBs=;
        b=LR7hZ3/Mc25xPXuu+9XsPPecldPSTGAHB+HqYcx7vbXdX/Ytghio7N6/fxUFsTYn88
         BzWYPDx7Ttab0LWC8UkyTH3OdVHg1RM8aDe8BhVrZat9ARVbk/a3iImeEo5jVRmIhAei
         EqcqBSkP2aqVTCxNAJA5WFL8Pzp/wDqeqn+0c1BpQfqQghzjLCebf0ztMFwR7nVw3ScP
         h5FHdd5mDVW/vOqF4Kbe/wSbhIK4v+JH7+uYNZd1+hj7xFDG6snU8fQfudKcoRox0QCF
         98BrQV0NNzjXnNM8Mxva6Q5Rx6l1DPo+qR7sM6wgrSe7fCpNWL9LkxD13LZoZSG6EnqC
         hFog==
X-Gm-Message-State: AOJu0Yw2l15gNm1CqwmVZs85IU08MzFAVDpuH3GVoZirEg45XEXizgu6
	rmT4GUkdL8JBbg8lXb/vtd2QkcflfJtvGf32cjqTvkoVczvFhE3mebnzlEZdagvfT1g=
X-Gm-Gg: ASbGncsv//S3A2h9SMiR6WXpzI1u+LZzMyEt79XIS2W8NwVYPdFjMJdKYy5HBRhDrQ7
	IK0f0/MuLENcC+5eJFP8naRuUAG1cpsbZlA8a7NzHnAQHdgUgNtc73rH592+HHvGJotzezmU1fN
	hwstg9Qh5vWDshrbIUXfyU6wh4NMVhsyrjWt7hhqy8yBKyGEWcBzkBaGRJwu7vY0KK6VAtJn83a
	PiDECHvDs8ATkgv6dcGu98aZrWRWjYrOrqmjd1HOVTKlaCwCfI4vSV1hcG4PQgKBgrz1cKp6lNV
	rjVJ+oTrQ4z0bnQKECBe3/IWaKFVVNWxrA5uCP9cQjZoVhirxIHd2bfjQLhXZcdrERNN
X-Google-Smtp-Source: AGHT+IGDN/KHxz9Bnp8yALdHvhwtdj8HwBIeOVLJvupWPyPhdbyamlXaAmqI6CHUMik81UZ3hpwyHA==
X-Received: by 2002:a05:6808:2223:b0:403:34b3:c986 with SMTP id 5614622812f47-40a5d0b202cmr3734055b6e.17.1749681753896;
        Wed, 11 Jun 2025 15:42:33 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:4753:719f:673f:547c])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40a682fbf05sm24684b6e.32.2025.06.11.15.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 15:42:32 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 11 Jun 2025 17:39:00 -0500
Subject: [PATCH 08/28] iio: adc: ti-ads1015: use = { } instead of memset()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-iio-zero-init-stack-with-instead-of-memset-v1-8-ebb2d0a24302@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=847; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=WSd14gc0IglioCpRcpapejeZeHyJEdiW3ePuDI+8374=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoSgW5Ygza7kmThbyisDqsWQsptmTBU8wIgMgQE
 pxnhMsh/S+JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaEoFuQAKCRDCzCAB/wGP
 wKntB/97ufnI2T1BvBKlrPPhGQWGDqAjoQSkW1QKpcvqm5JNUoqkex0I8noUiFjQLHt6g8Fwi0r
 VqqpMFbpUdF1MKsd5VP5Zb7DZxC2kjDp6jL041HzjfWKWjfXVH15wEqbhi9WhO8WDjGwDbAlCsC
 xF7XmULVO9O8XVbEX2VK3nCtJNrC1K8evAkSlACFG8ZzKinPcoB1k9qYzM5sU87+WFtHVkD0AZc
 Qeah+fJkaOfF+P+wux9OLYTxPFsUcmD0IHW5EsI2+Tkmo1808IBnI/YGG1DoVdGBoAdPrE3h6Cr
 QU+mELE3P/nwI+trrPO3SatKUUCLCkgwZTzH+YNm4fFPbrtC
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use { } instead of memset() to zero-initialize stack memory to simplify
the code.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ti-ads1015.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 21181cc3bd852ba3bb05b295c98b3530d8c07d3d..48549d617e5fdc363a5ff583a2b303cc8adc9eae 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -450,11 +450,9 @@ static irqreturn_t ads1015_trigger_handler(int irq, void *p)
 	struct {
 		s16 chan;
 		aligned_s64 timestamp;
-	} scan;
+	} scan = { };
 	int chan, ret, res;
 
-	memset(&scan, 0, sizeof(scan));
-
 	mutex_lock(&data->lock);
 	chan = find_first_bit(indio_dev->active_scan_mask,
 			      iio_get_masklength(indio_dev));

-- 
2.43.0


