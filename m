Return-Path: <linux-iio+bounces-21060-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED19AAEC8D1
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 18:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26DBA7A9E6A
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 16:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2572494FF;
	Sat, 28 Jun 2025 16:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lwnCNVik"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF351E2823
	for <linux-iio@vger.kernel.org>; Sat, 28 Jun 2025 16:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751128786; cv=none; b=tEsiRt/vvIRVZCh+I4igAmT7L8+6949P3Ukjr+rz3L8oJyjjJ21ZgZl6x05IlVZete8q4K72xM8HBqzzC0CLFo5owMJLxLcddr3BA9L86B/ffQGtWtYUSbbUEjKI7MJ1neG6x4R9jD6lzjARZt8+s9XASyese6VwNlu5oLCzDzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751128786; c=relaxed/simple;
	bh=U/8CNOHGauLsIgkJyowuqKhLhmaCBd6GX/xYox/0+34=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZYqIQMVOT34zGe+4ZSC2ZapSFB4SoeKJtXoMhWJ5g0mNHOeJw2Jun9B/NPHUgi/2uEmaEysCwx8ru4k110XmqJQY+GOcBhhJwvVHPpwt1WBY2Zxo0lthqHDVTRUhYRpb92O4F4hQbr7WUYc8TIwgB98LkhbeXaHy1XNNRtQYWKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lwnCNVik; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-4079f80ff0fso2474216b6e.1
        for <linux-iio@vger.kernel.org>; Sat, 28 Jun 2025 09:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751128783; x=1751733583; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IMFk6TBSRPoytsEFWA/L8bAiB5zpBhaDKXVpwxdgx3Y=;
        b=lwnCNVikKh1FBqWShU32wrDEayI4hHRZOceRfRW3QNDFpwgXSxBB5uZfBHn7LRcs8S
         RYTahcMO3N6nWEoPS57fNA4ZiiFdUX7wUAz2QZwR94yvC0MVutCLmRrjtv6RHRQF1s9x
         mrIA2YXO1C6AIgmU+NfX0cP0ESEtkkk31n7tiKzzF30qG37Pj8hEYCWyGJR6kei16phC
         eSXNqwn4/TDI11eaS3YE4600P5Q9K877mLznPaiXmq5Xg33pU7y2UrxoufA+vrPABf6d
         8ZunkTpFJkqo8feLtaEf49f+oPb61cdf7pPP5TmA2boHA+EHlaL99z+U761q667+3Vj+
         14fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751128783; x=1751733583;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IMFk6TBSRPoytsEFWA/L8bAiB5zpBhaDKXVpwxdgx3Y=;
        b=bOzUZINlcbGpPtKyHPdb6LUFT54uMbfeSZjJw2ym6MMVzDUe0hmlXNdMPfhcnMkk77
         AogVyXbt84HBQkleuBk6JYhIoZoBqu+CJPZ+qosc7ivVLXrO7l5DnlWUjBa/3LeuDR9F
         QIrRx5HsTlm7NlJQdY899g0zMWBbl5h0r78QuYNbGKPtnl1qQLg+cfyg9E3DGrUEsbMQ
         R4Gtdqj1k1CJKXMFgStcbNLPJyXkFAYHxn2U3Q5lciq2XCiS7lmGndYAfdrjscZfgWnZ
         8Cyj2uZE0KMFsGbD7LSLw0G+mhYZQqqPSVhp6a5mucgMfjyhyftwXYboKaPwnQ2suHCr
         1iUw==
X-Gm-Message-State: AOJu0YygzyzL38vKDUqdc7HGT9gqsnaogXDs6RcI/iiQU25cegHkjcHI
	3PNAJOBrXRsBmBTHlbKKEubxoAKc+hp8YMVjgH5tE+DlgWNpaLpyT1IBw249EzqFoS0=
X-Gm-Gg: ASbGncuPqJ2+B7DffPT1oEOyRGh6quuQ7Zb7RtCfY0Ht4kHFD1rE7HFq+jaFAUOLtn3
	0IxrAl6ydfGaRp1BeD/4H76KxRThZdzDV72uA4jyu6ox/OyZ2Cz7g5MEVaO6bbf1oNNRqyouOPM
	JKyKFvVBD1irbTTQeWIkDRnbcGyF9TRhYGJzVfcjMeZEEWyGt5zMzdnDjgUoImIDsbZ8giLo8jc
	zq0AFxXGQYDjeAnVyznpbs7juOKXNHif2LbyiVlIRx7yvly05k0VsZuumoxp9+Kpifh8KP+xkvx
	2T1d/IRnldUsdv2hqHipQaoXpK7DkIqSei6zVcB/LfONw5X8W5CY+rUoMLDVB4M+ND3m
X-Google-Smtp-Source: AGHT+IG/xoZFtVbTTOBbDGQ9ZV0tQLObLKh4Adi4IyxX1NpFYvM7jSz8pvzVA7s7N1PFYx+rLy3enw==
X-Received: by 2002:a05:6808:f8f:b0:406:70bb:f25 with SMTP id 5614622812f47-40b1c87a6c5mr9375589b6e.4.1751128782758;
        Sat, 28 Jun 2025 09:39:42 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:3092:a48c:b0c6:cbf4])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40b338a048fsm845415b6e.24.2025.06.28.09.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 09:39:42 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 28 Jun 2025 11:39:33 -0500
Subject: [PATCH] iio: adc: stm32-adc: make stm32_adc_trig_info const
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250628-iio-const-data-10-v1-1-0ba93ac792c8@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAMQaYGgC/x3MMQqAMAxA0atIZgNtaEW8ijiUJmqWVloRQby7x
 fEN/z9QpahUmLoHilxaNacG23cQ95A2QeVmIEPeDDSiasaYUz2RwxnQGiQZDTtm8Y6gdUeRVe/
 /OS/v+wFFPZsnYwAAAA==
X-Change-ID: 20250628-iio-const-data-10-2e80d4dde542
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1712; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=U/8CNOHGauLsIgkJyowuqKhLhmaCBd6GX/xYox/0+34=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoYBrHfYdBpf/RErszbzr+6hfxu+RD/bVyFoJwj
 IclktGBs5iJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaGAaxwAKCRDCzCAB/wGP
 wO0PB/4p5kujQILGatenvEj8+iwGQi6pgb6/Fzf7IdgpkaT8YugDUWjhLwUIfRctbSudWZDNBL1
 NNaMnRe4Wi9Huv+IDIRG5KZwlQ5+j0GRmlMhc2mPf5X/tq4IU321PAna8TnfhqDSLzeY3qAhagu
 8Cx80zHyoUAdBk/7KAY7EowzTt5EV7Hsnd5Za2Z9gxBKwzGEt9VTX9+Id8vzNfJdpT7GBYkqXAz
 VWUcALNxdA84Et3wg44mu5ZD1WMZRaL0DpRCBSwFUo9hrvaNqYOtOUosSJV8hxh9rJhLHH5AExX
 57IN0QLnNW1V45C8dBMUQYeZOiBG9/Q+epD7uEQLv8s8C1el
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add const qualifier to struct stm32_adc_trig_info. This is read-only
data so it can be made const.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/stm32-adc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 588c69e175f5129030eef9ebfe0eabb6412b1893..b9f93116e114b1c840cbe568f17462b2d25bf2db 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -216,7 +216,7 @@ struct stm32_adc;
 struct stm32_adc_cfg {
 	const struct stm32_adc_regspec	*regs;
 	const struct stm32_adc_info	*adc_info;
-	struct stm32_adc_trig_info	*trigs;
+	const struct stm32_adc_trig_info *trigs;
 	bool clk_required;
 	bool has_vregready;
 	bool has_boostmode;
@@ -383,7 +383,7 @@ static const struct stm32_adc_regs stm32f4_sq[STM32_ADC_MAX_SQ + 1] = {
 };
 
 /* STM32F4 external trigger sources for all instances */
-static struct stm32_adc_trig_info stm32f4_adc_trigs[] = {
+static const struct stm32_adc_trig_info stm32f4_adc_trigs[] = {
 	{ TIM1_CH1, STM32_EXT0 },
 	{ TIM1_CH2, STM32_EXT1 },
 	{ TIM1_CH3, STM32_EXT2 },
@@ -473,7 +473,7 @@ static const struct stm32_adc_regs stm32h7_sq[STM32_ADC_MAX_SQ + 1] = {
 };
 
 /* STM32H7 external trigger sources for all instances */
-static struct stm32_adc_trig_info stm32h7_adc_trigs[] = {
+static const struct stm32_adc_trig_info stm32h7_adc_trigs[] = {
 	{ TIM1_CH1, STM32_EXT0 },
 	{ TIM1_CH2, STM32_EXT1 },
 	{ TIM1_CH3, STM32_EXT2 },

---
base-commit: 14071b9cf2d751ff9bc8b5e43fa94fbf08aceea1
change-id: 20250628-iio-const-data-10-2e80d4dde542

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


