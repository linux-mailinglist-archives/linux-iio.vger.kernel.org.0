Return-Path: <linux-iio+bounces-12227-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C009C7D2F
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 21:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10F901F22D5C
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 20:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99490208225;
	Wed, 13 Nov 2024 20:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fTXpgNMg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA21B2064E2
	for <linux-iio@vger.kernel.org>; Wed, 13 Nov 2024 20:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731531190; cv=none; b=P/3IrfdN+yqbkBvrcdM3ttR8e9LevXz+SIP8UVnv8og+rV0kl4lSxEYT1LCUcrUaDaLBBlMKbl5wwgaM4BYGoJH5QJRjtJFKXeUL/wN9AnvWWib6MYf2CS1tsFPc/pcozg1595xmvQxwmq/J3y2NSMPpGKU1rgpxLI0S0zZjQVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731531190; c=relaxed/simple;
	bh=usxnLSOifC75UUbscRAQm9vBt1XSyQeNy/RrQ8fENrA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eTZg23Z6QKikLzhhjAYMS4KzhXaD9ZwHYndgD7Wayl1VmpnJILfGtGq9ru4NCtoZS9U7lWJpLJw6EQPbU4E+m4zJgghBSgR0FLNXJwOf/DS4gfTQrXkdD1ypHlQ4dlnJ/B88l89jjLXZZk6jOIXlpt6shD/+zyEEs9UrwgZtrmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fTXpgNMg; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6cbcd49b833so48169586d6.3
        for <linux-iio@vger.kernel.org>; Wed, 13 Nov 2024 12:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731531186; x=1732135986; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ITogGBSwNSbrmJAZixpXgO1FJBpp7STOlbU6R2lyybE=;
        b=fTXpgNMgiVAthfGxCj7joIwTxK9auxbn9ZbaU2qXjnRJeuaxY79PSIIffCCdfJQ/t0
         nyH4tccmAUpGhkQhxe7RxhVBDT1jaSHRvHwW1nfPCsLAoMN4HkZLbmooIClCAaJHryd1
         3lVn3VBXgsFe9UsmrE4g5lRKJdLeIWOH3a49nYZ740nQJHgaKFi+ykdI+EvmMpPqRsfD
         ADtMmMqShxSPnd0scGqzeH//BfV001mFQEUiA9VyzRWPEfEYzx2F1PK9lbq4C/HYzVGw
         qp+BX00jHr4JXlewPaArbp5TYSLTJ5KuKIalHfMH2O808/pMxlX9Oc8VcNfQ+6CARzPV
         vMUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731531186; x=1732135986;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ITogGBSwNSbrmJAZixpXgO1FJBpp7STOlbU6R2lyybE=;
        b=DUHmDeTAcrQuUytnXamJthZe2l+1VFp40CEu2CmSgc6hjFwFsOrYRFqEAi44ZyLtwO
         nVyga2O/EO705npjAGdKYo65OngX7MfjLUJn+QksF2I4SI0HexYTwyUyOyZdX7yQoxvt
         O1xJ5aXMeNicgb1Hw2M5wEkcQHsEPGlKyqcUdHtjqkSJLRjQq0FfiZ8qnrsURhbTB0ks
         3EMnAqjJ8cXQ8uUWSns/A/vvvmPW68XVwhKbpRoQzPtYBsTPK/klME4CIzCSh/hASmCT
         JPWaT0Xc6r12aK5YX+OimoYiiLyIIkjmUc+fxqvjxdQ3CYSaqqfoB1Q5RF1YH95qp0V0
         F/Qw==
X-Forwarded-Encrypted: i=1; AJvYcCUA14xDUbhIlggn3ejpP7QMIGhUjZSx0JSpiVqo5YPRiJmG7tqY23Ya5D8xSNIqtuFo37rtTrZMMro=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNBqFXp9csOHpDPEdNFvZZU9nU/3foNtsUKLSViBYOGPLKgRkv
	SQlZL3VBOYv7WoTy/sAmFgtGe0fY+Kq8nwt4jBO2FLulfj0nCEKjjGW5BEctTB8=
X-Google-Smtp-Source: AGHT+IFDgRdfRwbHfCGhimMOMUXkC66ocOQWIyw72aM4GlMmOQLibfUV596pHenrKWvqiaZX5Xuoyg==
X-Received: by 2002:a05:6214:3290:b0:6cb:f87f:f073 with SMTP id 6a1803df08f44-6d39e1078dbmr293135896d6.6.1731531186505;
        Wed, 13 Nov 2024 12:53:06 -0800 (PST)
Received: from [127.0.1.1] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3961df2f5sm88829336d6.2.2024.11.13.12.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 12:53:06 -0800 (PST)
From: Trevor Gamblin <tgamblin@baylibre.com>
Date: Wed, 13 Nov 2024 15:52:59 -0500
Subject: [PATCH v2 2/3] iio: adc: ad4695: make
 ad4695_exit_conversion_mode() more robust
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-tgamblin-ad4695_improvements-v2-2-b6bb7c758fc4@baylibre.com>
References: <20241113-tgamblin-ad4695_improvements-v2-0-b6bb7c758fc4@baylibre.com>
In-Reply-To: <20241113-tgamblin-ad4695_improvements-v2-0-b6bb7c758fc4@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Trevor Gamblin <tgamblin@baylibre.com>
X-Mailer: b4 0.14.1

Ensure that conversion mode is successfully exited when the command is
issued by adding an extra transfer beforehand, matching the minimum CNV
high and low times from the AD4695 datasheet. The AD4695 has a quirk
where the exit command only works during a conversion, so guarantee this
happens by triggering a conversion in ad4695_exit_conversion_mode().
Then make this even more robust by ensuring that the exit command is run
at AD4695_REG_ACCESS_SCLK_HZ rather than the bus maximum.

Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
 drivers/iio/adc/ad4695.c | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ad4695.c b/drivers/iio/adc/ad4695.c
index 0146aed9069f..4bc800293e60 100644
--- a/drivers/iio/adc/ad4695.c
+++ b/drivers/iio/adc/ad4695.c
@@ -92,6 +92,8 @@
 #define AD4695_T_REFBUF_MS		100
 #define AD4695_T_REGCONFIG_NS		20
 #define AD4695_T_SCK_CNV_DELAY_NS	80
+#define AD4695_T_CNVL_NS		80
+#define AD4695_T_CNVH_NS		10
 #define AD4695_REG_ACCESS_SCLK_HZ	(10 * MEGA)
 
 /* Max number of voltage input channels. */
@@ -364,11 +366,31 @@ static int ad4695_enter_advanced_sequencer_mode(struct ad4695_state *st, u32 n)
  */
 static int ad4695_exit_conversion_mode(struct ad4695_state *st)
 {
-	struct spi_transfer xfer = {
-		.tx_buf = &st->cnv_cmd2,
-		.len = 1,
-		.delay.value = AD4695_T_REGCONFIG_NS,
-		.delay.unit = SPI_DELAY_UNIT_NSECS,
+	/*
+	 * An extra transfer is needed to trigger a conversion here so
+	 * that we can be 100% sure the command will be processed by the
+	 * ADC, rather than relying on it to be in the correct state
+	 * when this function is called (this chip has a quirk where the
+	 * command only works when reading a conversion, and if the
+	 * previous conversion was already read then it won't work). The
+	 * actual conversion command is then run at the slower
+	 * AD4695_REG_ACCESS_SCLK_HZ speed to guarantee this works.
+	 */
+	struct spi_transfer xfers[] = {
+		{
+			.delay.value = AD4695_T_CNVL_NS,
+			.delay.unit = SPI_DELAY_UNIT_NSECS,
+			.cs_change = 1,
+			.cs_change_delay.value = AD4695_T_CNVH_NS,
+			.cs_change_delay.unit = SPI_DELAY_UNIT_NSECS,
+		},
+		{
+			.speed_hz = AD4695_REG_ACCESS_SCLK_HZ,
+			.tx_buf = &st->cnv_cmd2,
+			.len = 1,
+			.delay.value = AD4695_T_REGCONFIG_NS,
+			.delay.unit = SPI_DELAY_UNIT_NSECS,
+		},
 	};
 
 	/*
@@ -377,7 +399,7 @@ static int ad4695_exit_conversion_mode(struct ad4695_state *st)
 	 */
 	st->cnv_cmd2 = AD4695_CMD_EXIT_CNV_MODE << 3;
 
-	return spi_sync_transfer(st->spi, &xfer, 1);
+	return spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
 }
 
 static int ad4695_set_ref_voltage(struct ad4695_state *st, int vref_mv)

-- 
2.39.5


