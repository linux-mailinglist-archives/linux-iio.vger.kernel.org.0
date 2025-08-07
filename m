Return-Path: <linux-iio+bounces-22378-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B345B1D3AD
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 09:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B693C188046A
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 07:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913232441A6;
	Thu,  7 Aug 2025 07:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJs2u9Vs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C40C1FBEB6;
	Thu,  7 Aug 2025 07:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754552962; cv=none; b=bWWrBna0Tpp2Yn80uZn82tGGBGkGAqSs6pWwPUOJQjjfPr30aDaxvKKyJiRvl5qJyNb9t+zTmsVoAgpIRxLtKB+zZqN/LE0PFK34EA/EEaIUzYxLOGeoj4C2CFVTTfAyfNDb4d+gj3Dz/hwSFM6QAkWVB1J8eKM5lobJqMj10KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754552962; c=relaxed/simple;
	bh=FlmxjrCRrSH4gzueqNI22uxHGBJ7u4m45mHGfQOjsas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lYP8aAODSab8dI5FZ/y4c8F5gdm06hTiSlUGE6tQ5WfZ9S2Hy9q4iiHgq6svUFFPuREwskytaYagMNqq1JOGmpY7D8NgpLhXdpQyPAgDmbvTXc3rpc7m0g7fqyujnFdvIdt4fEfdrYBLSPEsKPwY6fj9H86YGZN1Ucor6ciqbso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJs2u9Vs; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-459e72abdd2so3587675e9.2;
        Thu, 07 Aug 2025 00:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754552958; x=1755157758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KKw3G4NXPyYj3JiCjqirXHYXq+afTsQ8eyBpGUSwIPc=;
        b=JJs2u9VsYooDRycr0sIIxAhDNRBeU5L85PKn+Sf3y8jYtpcy1ljG7AqKpp/J/ibD7g
         VvtkOdI8Q1sg/vzeLj32+AeTYE/0HeJkDFlYa9/8tWBjaQmHABDw3BB36iDVCyakJ2jf
         1pTXk30vdcEoibw/wIWOtq9YahH91QNBsRLK9NSAajud7EkVBJsjZMgo+SnQNCL9Zl2y
         YZkB1vo8F/AwtBwYS/+FOTPGXwRpWmKWXSwQn3/dsJyQHWtKUrVNjxT075UdkHKx8aZK
         AWbx1ikK6CE700iOzBpdl5EQTaOH2ivLQfomTU1kOj82ZqRC/UykCrgUfidCMNAs8Vuz
         ITxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754552958; x=1755157758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KKw3G4NXPyYj3JiCjqirXHYXq+afTsQ8eyBpGUSwIPc=;
        b=ivuqXcs0YuyaM+0OpcQ2s9LMGFlF22SWyrYwL7CkLdsoV+GYs0V5suMasXe9WfqBnx
         dAHQ4Gd3zAU0DW4SfGTwRdKl3RjCtXLODvHAKdEUlxbgIx8mvkSlWDcUt/LuUMMdAkFu
         kc18KHLord4EyebLIx0n3JNvFQKBHFRx9E7P3b4M5OIUqFNkwnnojlY5lUm3Ma5jPKoS
         AKs40hPAjh7zkCMD0SZHwFlyG+8M6JRNRLjeqGxqnNzk7zd7iS/jmPcDPxY/q4yDP8Za
         +XljoXpMNEDxMWNLWjZfQjEDs5bVGoxRv4sKB9w66t41Tcuaa4P/DoMjzANydbEjYFZb
         ANxw==
X-Forwarded-Encrypted: i=1; AJvYcCUZUZrIoz+QRvVYS0j5lP42ZmLWZrQtDqwkF4pC9QO+4PzQytlCCCzUuxgVVtzCtw8adKriITIHpaI8yRM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9ttPvi6TAc5jFKK4BPUJ07xQ8IKcKkfxDqMtCY0AR5mSukt+8
	/TfEKdxMSSEMS5s0wIQjHVpCtJHUBGUoP/4DowdPb2CRALX5hq9rbTAY
X-Gm-Gg: ASbGncsKsF0sH9AuNnch+oADtL0b1Fa48yh959btHeJfqCenmKOjOSg4/PiGMu0omvg
	LDd5k/dl5p4qovcd4BZfr1pMBdHVyvEp5TcFvhRthtUWxVR/OmwbL/3jpbFdZYlUkEms+l6CCb7
	szD+T2jQ7+gHpxD/6yqUs8z8GRkN2r1JZXJiPySkQfzrjLAmF/tY3MYpE9KrqpO19euY0zPBNTI
	1ueoS6fkJ4uzNPZJqmpryia07na6QerF/zOIGKX5GqwIRHRk2cyomkyRjWY1CYzyRFRVkRUvSBB
	EWJCr4ZoHV8qwSxo2ndpLDoDLSUmAcH18TRyspCUnAre4igP2YgT2Llz1lccvppIapgd7d3Fu/O
	LIWNlGJ2MhLSSE4FCh5zVp2bGe2e5OHe4X4xIgkl01n7ExBGOTANHzQiAy13EHXjRNva8p/Lvbs
	4=
X-Google-Smtp-Source: AGHT+IHy5IQ+QnzDGQPwELWmsqk5i7TtfA49NP4hab2ATLdO0J5PGWMfQ81yHmPnYdRLfqZlTXZitw==
X-Received: by 2002:a5d:5f94:0:b0:3b6:17b5:413c with SMTP id ffacd0b85a97d-3b8f9f70087mr1442198f8f.39.1754552957772;
        Thu, 07 Aug 2025 00:49:17 -0700 (PDT)
Received: from localhost.localdomain (2-229-167-183.ip197.fastwebnet.it. [2.229.167.183])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c466838sm27054362f8f.49.2025.08.07.00.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 00:49:17 -0700 (PDT)
From: Stefano Manni <stefano.manni@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefano Manni <stefano.manni@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v2 1/2] iio: adc: ad799x: add reference voltage capability to chip_info
Date: Thu,  7 Aug 2025 09:48:49 +0200
Message-ID: <20250807074850.130831-2-stefano.manni@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250807074850.130831-1-stefano.manni@gmail.com>
References: <20250807074850.130831-1-stefano.manni@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the chip supports an external reference voltage
on REFIN pin then the "vref-supply" regulator may be used.

This commit partially refactors 6b104e7895ab16b9b7f466c5f2ca282b87f661e8
to add the capability of the chip to have an external
voltage reference and then remove the ugly conditional check
on chip id.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Stefano Manni <stefano.manni@gmail.com>
---
 drivers/iio/adc/ad799x.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index 9c02f9199139..f645995b0929 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -114,11 +114,13 @@ struct ad799x_chip_config {
  * @num_channels:	number of channels
  * @noirq_config:	device configuration w/o IRQ
  * @irq_config:		device configuration w/IRQ
+ * @has_vref:		device supports external reference voltage
  */
 struct ad799x_chip_info {
 	int				num_channels;
 	const struct ad799x_chip_config	noirq_config;
 	const struct ad799x_chip_config	irq_config;
+	bool has_vref;
 };
 
 struct ad799x_state {
@@ -604,6 +606,7 @@ static const struct iio_event_spec ad799x_events[] = {
 static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 	[ad7991] = {
 		.num_channels = 5,
+		.has_vref = true,
 		.noirq_config = {
 			.channel = {
 				AD799X_CHANNEL(0, 12),
@@ -617,6 +620,7 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 	},
 	[ad7995] = {
 		.num_channels = 5,
+		.has_vref = true,
 		.noirq_config = {
 			.channel = {
 				AD799X_CHANNEL(0, 10),
@@ -630,6 +634,7 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 	},
 	[ad7999] = {
 		.num_channels = 5,
+		.has_vref = true,
 		.noirq_config = {
 			.channel = {
 				AD799X_CHANNEL(0, 8),
@@ -809,32 +814,22 @@ static int ad799x_probe(struct i2c_client *client)
 		return ret;
 
 	/* check if an external reference is supplied */
-	st->vref = devm_regulator_get_optional(&client->dev, "vref");
-
-	if (IS_ERR(st->vref)) {
-		if (PTR_ERR(st->vref) == -ENODEV) {
+	if (chip_info->has_vref) {
+		st->vref = devm_regulator_get_optional(&client->dev, "vref");
+		ret = PTR_ERR_OR_ZERO(st->vref);
+		if (ret) {
+			if (ret != -ENODEV)
+				goto error_disable_reg;
 			st->vref = NULL;
 			dev_info(&client->dev, "Using VCC reference voltage\n");
-		} else {
-			ret = PTR_ERR(st->vref);
-			goto error_disable_reg;
 		}
-	}
 
-	if (st->vref) {
-		/*
-		 * Use external reference voltage if supported by hardware.
-		 * This is optional if voltage / regulator present, use VCC otherwise.
-		 */
-		if ((st->id == ad7991) || (st->id == ad7995) || (st->id == ad7999)) {
+		if (st->vref) {
 			dev_info(&client->dev, "Using external reference voltage\n");
 			extra_config |= AD7991_REF_SEL;
 			ret = regulator_enable(st->vref);
 			if (ret)
 				goto error_disable_reg;
-		} else {
-			st->vref = NULL;
-			dev_warn(&client->dev, "Supplied reference not supported\n");
 		}
 	}
 
-- 
2.48.1


