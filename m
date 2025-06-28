Return-Path: <linux-iio+bounces-21052-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 042B6AEC88D
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 18:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11F7917B836
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 16:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2A8246782;
	Sat, 28 Jun 2025 16:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wXTKo23A"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5061E2602
	for <linux-iio@vger.kernel.org>; Sat, 28 Jun 2025 16:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751126977; cv=none; b=sPc/O25ajmb3eJzDJBW6R5MFlOQh0sYoUgwZ43qrrFyKNLfK+oXGSM85SSScfejcX8TBZn/2a9KbSoBhu04TgZuRWSLNNeAiDMZrNEbVjnOc5Mk9UMJWj8x9VmTB/VRm1AAL+Dyu5nbRFoUKMFIF6fuhawuJv0W7RLriBM9PBD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751126977; c=relaxed/simple;
	bh=xd9zgN26iUwiHRfuwwnHBEGh37uP/NmSoUedlNGjeVQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qEGaA2tJUZ6V7zdL7mUeXurdLPAjKWDkX3AChx5IDgZNGkon1JTnpxVRcezyRd/lmjVCY+0IyhRnk/ouJfCmJqhOcGIw4eXt8fo6K4x8TkxmxdV8AhwAbGPfRnetE9yM/Pw0Asv0wJu/clwiKN68fJX7gnTI/EREaBYMx4tS1Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=wXTKo23A; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-40a4bf1ebb7so533629b6e.0
        for <linux-iio@vger.kernel.org>; Sat, 28 Jun 2025 09:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751126974; x=1751731774; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kdMUjRTn+e0cE+oX4aeWZd7ydc61mU0zAwixi2eYD18=;
        b=wXTKo23AAGMZwX+/jDqFw5yxYULQLVcxN81FXDwy0jxXZVEqzNmQIIDP+zvmO9UdOw
         XNBkA4nzx/1j1z2/RWaZpRAOHhB+DdgqN/5kxCR97GEJMsVH7ja3cjO11RTJH6sH8Zea
         FHtC5Oh3T2voQ7/1g9U0xeyIHkuD0r4MwwCpVPOMU8EkkurA3Out/0z8Qbn3O2BD2A2f
         J+I2uu4SKFaBWFu0ZEt+8GgPKeaGAhRa8Y1o9tRkjKQ2BCyM+WTci67C8e8ZXqvqrR33
         SksUIIIiI6Xi1cn4rWILixG5GAdiCum7TGduf77iUQ5wH2IFsmYI0SiG1dgw2TbaFinK
         JbJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751126974; x=1751731774;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kdMUjRTn+e0cE+oX4aeWZd7ydc61mU0zAwixi2eYD18=;
        b=mXzjmAShfprO3b0Gb3uGNZiuIJ5BR20WsZpXSsJvVTm8mSlmyf1+Lw5njkCXTCZAGb
         K5R0mw+gSdp9ikyT0FTF/J0IiPHx7C+h9lT9hnhsgIfdVFpq5lX9tEYzE8DmmO2Y4EU2
         Scwa4U8FoWG2JRcdp8doOocbWecovylk74djIqHQOtALYtXFO6aP400wMnH6pQtuT8Xs
         tgxaJBp/7NbmPerNHzUL2iU7ibXIodXeyFJgarNVInwT6a+EO8DcDkNl1O4gJj0C7pzB
         oxi5H1KETJVN24BqEgb5yG0DEswhRQ98tfXU+lS6T7JOX1oQnfmhKgneab/VQAPDHTOj
         9uNQ==
X-Gm-Message-State: AOJu0YwDVk+U039Q1vZh49COoca3rFzdkhDeKI6TVq6xKPTP/xgqfqud
	w0yX4Cc/vvcXkjlqz5k2SZFhbJVPp0TF/DEs+omzc6DZhaPuOBlYGO+8hZyxp834OiwjzWuihyL
	1AyIPRsc=
X-Gm-Gg: ASbGncv8JuSQVtRF2fkKSUHUcuLdzDdTlX8Fx4ywJwxkOgjrGb8A0g0DMrHa9Bgv8wg
	wO7e//AAqNjLArHnL/ltbWVCGKQalTyhPxcr+3QPDtbypRhQBonA+2F7Cf+9PZ7g4sm2mk9iz8L
	tUvUc44NKd0Fk6BZTH9CjGq+rw5jtTcNPNrFuUXT1eulEIMdCusWdOkeb/KMYIQO3ta5+pswJJb
	yEmGnYAOJoFyjkBhMoIhlnnTawJfsfn1CHOYQz3gPbxcXdk+vXH8eOhZTqQxR1XiEgGgyIRNQJy
	eynghoKOEk0RDVsMznHNON+JDU8kpq5X4YFriK+MMaPJ5tjZ1wfjJIbCL2vzK44Odg0H
X-Google-Smtp-Source: AGHT+IE4hkmnbrzjcRiMlYEt2HfpUltmZZWcvFW150YhWFQd9BeNbD81KmjzKrCXWyXVHUU8BsSCXw==
X-Received: by 2002:a05:6808:2107:b0:401:e5fc:e726 with SMTP id 5614622812f47-40b33e4c3f2mr5949897b6e.31.1751126974462;
        Sat, 28 Jun 2025 09:09:34 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:3092:a48c:b0c6:cbf4])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40b487940bbsm452991b6e.3.2025.06.28.09.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 09:09:34 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 28 Jun 2025 11:09:25 -0500
Subject: [PATCH] iio: adc: ad7091r8: make ad7091r_init_info const
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250628-iio-const-data-4-v1-1-4e0f93c9cf83@baylibre.com>
X-B4-Tracking: v=1; b=H4sIALQTYGgC/x3MTQqAIBBA4avErBtI0aiuEi38mWo2GhoRiHdPW
 n6L9wpkSkwZlq5Aooczx9Ag+g7cacJByL4Z5CD1MMoJmSO6GPKN3twGFc5iV14obazV0LIr0c7
 vv1y3Wj8k87YhYgAAAA==
X-Change-ID: 20250628-iio-const-data-4-91f4d145abb5
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1715; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=xd9zgN26iUwiHRfuwwnHBEGh37uP/NmSoUedlNGjeVQ=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoYBO2b9GPfD4TEJkDp3Ez+DgnZViPgd2YzhMIX
 bvccv6WmnaJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaGATtgAKCRDCzCAB/wGP
 wBsuB/9RXXpHaLBroPGtqQQPP3MLYfCbk15M96LfMFiZBBvnMiPC2KM6h6Vq2bNJrY1o8XxJQeO
 lQSmvRjzJgu9Q8YGWvymvZZ7gbvoaggmxfbtGjBU2PGI84SgLCSGzha+rKWDiaAjL8EWnqrfe+b
 vDPd0xsihVlSnxxMyjZMEjw8qMftG0xqXvEFt8TfNHGSaqGqk6LleyPx34hp2+sXX5dSBL3Xe1M
 ssOG7qUdoi+in5DDJTYuSF7xDpNs//o6fTqDPOWbsNetT2exujI4hCB9KD4qKaI62kQSMLWl7jN
 SYqYlgsnth/tEHb63EXtpPXQv4z3oDmGppULGDDp+KTFDBqX
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add const qualifier to struct ad7091r_init_info ad7091r*_init_info. This
is read-only data so it can be made const.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7091r8.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad7091r8.c b/drivers/iio/adc/ad7091r8.c
index cebade4c2d49ede2bd256ccfa9a064f56437fe4f..e93b8bb60e8ea70eedc086551bf09510e78eae51 100644
--- a/drivers/iio/adc/ad7091r8.c
+++ b/drivers/iio/adc/ad7091r8.c
@@ -206,14 +206,14 @@ static int ad7091r8_gpio_setup(struct ad7091r_state *st)
 	return 0;
 }
 
-static struct ad7091r_init_info ad7091r2_init_info = {
+static const struct ad7091r_init_info ad7091r2_init_info = {
 	.info_no_irq = &ad7091r8_infos[AD7091R2_INFO],
 	.regmap_config = &ad7091r2_reg_conf,
 	.init_adc_regmap = &ad7091r8_regmap_init,
 	.setup = &ad7091r8_gpio_setup
 };
 
-static struct ad7091r_init_info ad7091r4_init_info = {
+static const struct ad7091r_init_info ad7091r4_init_info = {
 	.info_no_irq = &ad7091r8_infos[AD7091R4_INFO],
 	.info_irq = &ad7091r8_infos[AD7091R4_INFO_IRQ],
 	.regmap_config = &ad7091r4_reg_conf,
@@ -221,7 +221,7 @@ static struct ad7091r_init_info ad7091r4_init_info = {
 	.setup = &ad7091r8_gpio_setup
 };
 
-static struct ad7091r_init_info ad7091r8_init_info = {
+static const struct ad7091r_init_info ad7091r8_init_info = {
 	.info_no_irq = &ad7091r8_infos[AD7091R8_INFO],
 	.info_irq = &ad7091r8_infos[AD7091R8_INFO_IRQ],
 	.regmap_config = &ad7091r8_reg_conf,

---
base-commit: 14071b9cf2d751ff9bc8b5e43fa94fbf08aceea1
change-id: 20250628-iio-const-data-4-91f4d145abb5

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


