Return-Path: <linux-iio+bounces-17054-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 054B0A6801F
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 23:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E06E542673A
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 22:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468B42153C1;
	Tue, 18 Mar 2025 22:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xWfl2MFw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE782214A84
	for <linux-iio@vger.kernel.org>; Tue, 18 Mar 2025 22:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742338356; cv=none; b=grsus0j1jpXZoKGJ+goavarZ1fqBo6Rxq9cJpXcbfkAeUGigi5FyK5c7EQtcGRcze/UVW8L5/o/HgrrmPHp0u/26r48+CCLQ97RwBLp0e/VkjQQpjuGLnOjdUzt00ggn4btntoUo7k++RLbKW8+/gVySfFx1balSqQaUzlIZSO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742338356; c=relaxed/simple;
	bh=Uzrv30yYQqWShTTtrC3FkE9Uod1gM6aCjwnsOexjGsU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lr2/tkYReUtFLOrIZaeWlJRpUR2alfSR8mMJgW8YBekVl39fUFCiVvCV6gammGr1aCSFrZJMqxNzQl2lN6CwSBEFx22ZEDCrJ0FtoNvLn9oLsuN9n5TOqT9twW2Vyy2ewlCDBw8GfPfXsQbQPERa+OVVCZxpPr8EsdihKM9E3hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xWfl2MFw; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2a9ef75a20dso6109556fac.2
        for <linux-iio@vger.kernel.org>; Tue, 18 Mar 2025 15:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742338352; x=1742943152; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yy74OziyShY3LbwJ+ieZKhuYNkY88Mm9WSgSOOCUGR4=;
        b=xWfl2MFwjYlsh69xthmOs5NXc3Vm6hbUZkDmQ0Eb0qnezMT8tYiRd8vRZ9pJayNExa
         8ly5OM9Yb3vZN3JuBe2Cs9HLp9LfEtys2zLpcxDnTfmF/8WZcDFC92RLN9RE6a1oTivx
         r93KHBroJaf1sl0XqvwjuF130+4LUbIfKSmYogyJ0ZbfXr2mr9RuB5mz5Mkkocet7igd
         8APamlxP6+pxa6kbG2d8T4rfyv7VOC8f4QQ46cfL5LiVyVHRvx9tfM0lr85v6Nq+vWKI
         S23SqKNYxMIw4uoPuNGgWo3BbeC9IyGMn2lWq6UoG/9J0bcBcZLRQwzDRk1nyh73+S1u
         wC9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742338352; x=1742943152;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yy74OziyShY3LbwJ+ieZKhuYNkY88Mm9WSgSOOCUGR4=;
        b=r4/INAykB0J1ui5DlUtaAbrjL6U+9ppTeFZhSP2EKOeoiMUrwv8i82Ru518lMR3hR0
         RczsFbibMeXvVctwqAKAheKvqlLU3i++CqXVgiCzEzUOULVGJ7hfUdJ4reDtI77GmQQF
         +2w3TMMhi9bZSZYDuM4fLmlfkTWX646sEXp9L+b9NW2FHq7eoSn02oVR0Qrb4AbbBiNu
         267mJfIDhYlgX+cs3Rtn9+yqcNBpAGMoYkbJ9GqGtpd/bhp23jpLmuF5sQj9CybfxhWt
         2tjfqxIGBQq284wR2hLXm/ufiXGNsbihcYiBdjE02i8nDnAxMZQHrsKV8GQREYl5t0CZ
         ShwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYFRNYk/ump7OkaNBkxb09GE0G5nddOtN4CuLiUJ+JsHf4Gmrr8wznwxUFIiTFBXJByHO17YEa+p8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPV7YbRqK7xEi+e+7ESG8StQAQxW9UdMz1EcxGlyyrsDM+zeWH
	flwtrMG3rRtcHXH6mmleFubPsjrELdB8ZGG4mO99fJiW6l1gMvgeCE/cd+3+gYlUniuA4X9AVow
	ZNfE=
X-Gm-Gg: ASbGncshnfMZIDjibqMPW6SmzkKRPdfEonBOm8kBKQz/BJ3l9/R00UDyUfjCHZL+AcV
	+YT7/OfnR+vXoy9k9gd1/2VAYjo586aLH7jDtFp2ZJONnG9gjc2T/i//8MyGhPnFf+nQOe1sE69
	0eWiRioRIj+WOXv2T9XdFQ6OMKuD49UWyDKXOOzZeIDpB+mnhYvNyjyQvL/Zh7r68hksaxHwNPT
	exLQKp11T/jEM1DZIlcTi4/B/dOhg1yiwSEJMWOGKggqSqqYDUxMUnXF4K/EoeYOtK3flkXLl/e
	GHclpsKWy7bs1lM60Ee92UCVMBVNXdSaS9AaFYjXvy4TXGtBeCOOk1jXD4IDOCF2ScH0fIXp5/+
	3Cs7yGifIjCc=
X-Google-Smtp-Source: AGHT+IHDNjYdCXJgGEhG/OvAI5fdhAPcCIDjzLH4qe9nNtPHDKJYInZX2MI7qzObTnluXZe2Pkgh9w==
X-Received: by 2002:a05:6870:2252:b0:29e:3d0b:834 with SMTP id 586e51a60fabf-2c7454187eemr245240fac.5.1742338351588;
        Tue, 18 Mar 2025 15:52:31 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72bb274e95dsm2191690a34.52.2025.03.18.15.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 15:52:30 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 18 Mar 2025 17:52:17 -0500
Subject: [PATCH v2 09/10] iio: adc: ad7606: dynamically allocate channel
 info
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250318-iio-adc-ad7606-improvements-v2-9-4b605427774c@baylibre.com>
References: <20250318-iio-adc-ad7606-improvements-v2-0-4b605427774c@baylibre.com>
In-Reply-To: <20250318-iio-adc-ad7606-improvements-v2-0-4b605427774c@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Angelo Dureghello <adureghello@baylibre.com>, 
 Alexandru Ardelean <aardelean@baylibre.com>, 
 Beniamin Bia <beniamin.bia@analog.com>, 
 Stefan Popa <stefan.popa@analog.com>, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=24126;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=Uzrv30yYQqWShTTtrC3FkE9Uod1gM6aCjwnsOexjGsU=;
 b=owEBgwJ8/ZANAwAKAR+K+IyC93wDAcsmYgBn2fkd4475+D1YJMpWfolvNcLwqHxF0iYHY9NMh
 iZ1BWCv8ueJAkkEAAEKADMWIQSKc9gqah9QmQfzc4gfiviMgvd8AwUCZ9n5HRUcZGF2aWRAbGVj
 aG5vbG9neS5jb20ACgkQH4r4jIL3fAOX4A/9Hse0+u9nYArn5w1ulBkhSU8R/EI8NtjLvS0qyI7
 wSmnMyGWgkwSJck8Z2f3xRbHUvG0AsB1uGo2fpglizU/QSlNoQRavgjEO2wY2wyIAKtDx/Pwr1x
 W7s6b70Fk39ZscS8fPA34a2Pzcq2KN8h3D5zZWSy40NdcibKnQZ3yxo3XUvFG+XVoc+zyD8/Fl2
 x+OlkeE9sSBdaxsWWQEJR3prOg/fIK0vPZgHVmqppTjT7PScuDtXR2XOfg5x2mVN3KCbzemEdzD
 +S4jdwFHhXUs0WC27dOmq1GLxEfYdC6p2L3L/ObK3YFdf01ZOxJydgF1o5SAL3DzdAwYBir4ZlU
 L9SERIFOJ3zXEQWTygvUulhAFrQQMLXqeJMEYAOQOtGbeAksLUGY/hxflBRH8yH1ZAqLmsjms7a
 2kt1rbZ3BHMYh8bZgJK/SXbjC2fvERaQkpPnvpJ+1GfR4s5pF8mBgRLEFPszZafylABly4OvKcj
 FKQE+m0xP1KlupqfxDYTy7ixXpxPOQNpFdl4RWqwgUSlWAAswrJpOz8MQQJvaNT/fl5MoBRW3Da
 Faa38DHowSIXuu9yeqOonODyomIY3/wpSflIPqqGp6HTXUCOa5mcAhkaAD2EvPQOJ7MC7CuFMlv
 cht6qPYn0sHChdtbrEIQF2VeXpptcE7CoyCXEJ5ZbnbI=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Refactor the ad7606 drivers to dynamically allocate the channel info.

The channel info was getting a bit unwieldy. In some cases, the
indio_dev->channels field was getting assigned up to 3 different times,
each in a different function, making it difficult to see where the info
was coming from. This problem stems from the number of permutations of
the channel array needed to support various modes of operation and data
buses. We already have 4 per chip (hardware mode, software mode, AXI ADC
backend and AXI ADC backend with software mode) and we intend to add two
more per chip when adding SPI offload support.

To make it easier to read and maintain, move all of the channel setup
to a single function that dynamically allocates and fills in the channel
info.

Additionally, this lets us remove some hacks where we had to compute an
offset due to the fact that sometimes there was a soft timestamp channel
at the start of the array. Now the timestamp channel is always at the
end of the array as is typical in other drivers.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7606.c     | 232 ++++++++++++++++++-------------------------
 drivers/iio/adc/ad7606.h     |  76 +-------------
 drivers/iio/adc/ad7606_par.c |  33 ------
 drivers/iio/adc/ad7606_spi.c |  86 +---------------
 4 files changed, 102 insertions(+), 325 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 09c35161df365e531b8d254c7333359facf045c7..f3a78b01278527a3a380b80423d39774cee269c4 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -95,92 +95,6 @@ static const unsigned int ad7616_oversampling_avail[8] = {
 	1, 2, 4, 8, 16, 32, 64, 128,
 };
 
-static const struct iio_chan_spec ad7605_channels[] = {
-	IIO_CHAN_SOFT_TIMESTAMP(4),
-	AD7605_CHANNEL(0),
-	AD7605_CHANNEL(1),
-	AD7605_CHANNEL(2),
-	AD7605_CHANNEL(3),
-};
-
-static const struct iio_chan_spec ad7606_channels_16bit[] = {
-	IIO_CHAN_SOFT_TIMESTAMP(8),
-	AD7606_CHANNEL(0, 16),
-	AD7606_CHANNEL(1, 16),
-	AD7606_CHANNEL(2, 16),
-	AD7606_CHANNEL(3, 16),
-	AD7606_CHANNEL(4, 16),
-	AD7606_CHANNEL(5, 16),
-	AD7606_CHANNEL(6, 16),
-	AD7606_CHANNEL(7, 16),
-};
-
-static const struct iio_chan_spec ad7606_channels_18bit[] = {
-	IIO_CHAN_SOFT_TIMESTAMP(8),
-	AD7606_CHANNEL(0, 18),
-	AD7606_CHANNEL(1, 18),
-	AD7606_CHANNEL(2, 18),
-	AD7606_CHANNEL(3, 18),
-	AD7606_CHANNEL(4, 18),
-	AD7606_CHANNEL(5, 18),
-	AD7606_CHANNEL(6, 18),
-	AD7606_CHANNEL(7, 18),
-};
-
-static const struct iio_chan_spec ad7607_channels[] = {
-	IIO_CHAN_SOFT_TIMESTAMP(8),
-	AD7606_CHANNEL(0, 14),
-	AD7606_CHANNEL(1, 14),
-	AD7606_CHANNEL(2, 14),
-	AD7606_CHANNEL(3, 14),
-	AD7606_CHANNEL(4, 14),
-	AD7606_CHANNEL(5, 14),
-	AD7606_CHANNEL(6, 14),
-	AD7606_CHANNEL(7, 14),
-};
-
-static const struct iio_chan_spec ad7608_channels[] = {
-	IIO_CHAN_SOFT_TIMESTAMP(8),
-	AD7606_CHANNEL(0, 18),
-	AD7606_CHANNEL(1, 18),
-	AD7606_CHANNEL(2, 18),
-	AD7606_CHANNEL(3, 18),
-	AD7606_CHANNEL(4, 18),
-	AD7606_CHANNEL(5, 18),
-	AD7606_CHANNEL(6, 18),
-	AD7606_CHANNEL(7, 18),
-};
-
-/*
- * The current assumption that this driver makes for AD7616, is that it's
- * working in Hardware Mode with Serial, Burst and Sequencer modes activated.
- * To activate them, following pins must be pulled high:
- *	-SER/PAR
- *	-SEQEN
- * And following pins must be pulled low:
- *	-WR/BURST
- *	-DB4/SER1W
- */
-static const struct iio_chan_spec ad7616_channels[] = {
-	IIO_CHAN_SOFT_TIMESTAMP(16),
-	AD7606_CHANNEL(0, 16),
-	AD7606_CHANNEL(1, 16),
-	AD7606_CHANNEL(2, 16),
-	AD7606_CHANNEL(3, 16),
-	AD7606_CHANNEL(4, 16),
-	AD7606_CHANNEL(5, 16),
-	AD7606_CHANNEL(6, 16),
-	AD7606_CHANNEL(7, 16),
-	AD7606_CHANNEL(8, 16),
-	AD7606_CHANNEL(9, 16),
-	AD7606_CHANNEL(10, 16),
-	AD7606_CHANNEL(11, 16),
-	AD7606_CHANNEL(12, 16),
-	AD7606_CHANNEL(13, 16),
-	AD7606_CHANNEL(14, 16),
-	AD7606_CHANNEL(15, 16),
-};
-
 static int ad7606c_18bit_chan_scale_setup(struct iio_dev *indio_dev,
 					  struct iio_chan_spec *chan);
 static int ad7606c_16bit_chan_scale_setup(struct iio_dev *indio_dev,
@@ -198,20 +112,18 @@ static int ad7606b_sw_mode_setup(struct iio_dev *indio_dev);
 
 const struct ad7606_chip_info ad7605_4_info = {
 	.max_samplerate = 300 * KILO,
-	.channels = ad7605_channels,
 	.name = "ad7605-4",
+	.bits = 16,
 	.num_adc_channels = 4,
-	.num_channels = 5,
 	.scale_setup_cb = ad7606_16bit_chan_scale_setup,
 };
 EXPORT_SYMBOL_NS_GPL(ad7605_4_info, "IIO_AD7606");
 
 const struct ad7606_chip_info ad7606_8_info = {
 	.max_samplerate = 200 * KILO,
-	.channels = ad7606_channels_16bit,
 	.name = "ad7606-8",
+	.bits = 16,
 	.num_adc_channels = 8,
-	.num_channels = 9,
 	.oversampling_avail = ad7606_oversampling_avail,
 	.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
 	.scale_setup_cb = ad7606_16bit_chan_scale_setup,
@@ -220,10 +132,9 @@ EXPORT_SYMBOL_NS_GPL(ad7606_8_info, "IIO_AD7606");
 
 const struct ad7606_chip_info ad7606_6_info = {
 	.max_samplerate = 200 * KILO,
-	.channels = ad7606_channels_16bit,
 	.name = "ad7606-6",
+	.bits = 16,
 	.num_adc_channels = 6,
-	.num_channels = 7,
 	.oversampling_avail = ad7606_oversampling_avail,
 	.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
 	.scale_setup_cb = ad7606_16bit_chan_scale_setup,
@@ -232,10 +143,9 @@ EXPORT_SYMBOL_NS_GPL(ad7606_6_info, "IIO_AD7606");
 
 const struct ad7606_chip_info ad7606_4_info = {
 	.max_samplerate = 200 * KILO,
-	.channels = ad7606_channels_16bit,
 	.name = "ad7606-4",
+	.bits = 16,
 	.num_adc_channels = 4,
-	.num_channels = 5,
 	.oversampling_avail = ad7606_oversampling_avail,
 	.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
 	.scale_setup_cb = ad7606_16bit_chan_scale_setup,
@@ -243,11 +153,10 @@ const struct ad7606_chip_info ad7606_4_info = {
 EXPORT_SYMBOL_NS_GPL(ad7606_4_info, "IIO_AD7606");
 
 const struct ad7606_chip_info ad7606b_info = {
-	.channels = ad7606_channels_16bit,
 	.max_samplerate = 800 * KILO,
 	.name = "ad7606b",
+	.bits = 16,
 	.num_adc_channels = 8,
-	.num_channels = 9,
 	.oversampling_avail = ad7606_oversampling_avail,
 	.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
 	.scale_setup_cb = ad7606_16bit_chan_scale_setup,
@@ -257,10 +166,9 @@ EXPORT_SYMBOL_NS_GPL(ad7606b_info, "IIO_AD7606");
 
 const struct ad7606_chip_info ad7606c_16_info = {
 	.max_samplerate = 1 * MEGA,
-	.channels = ad7606_channels_16bit,
 	.name = "ad7606c16",
+	.bits = 16,
 	.num_adc_channels = 8,
-	.num_channels = 9,
 	.oversampling_avail = ad7606_oversampling_avail,
 	.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
 	.scale_setup_cb = ad7606c_16bit_chan_scale_setup,
@@ -270,10 +178,9 @@ EXPORT_SYMBOL_NS_GPL(ad7606c_16_info, "IIO_AD7606");
 
 const struct ad7606_chip_info ad7607_info = {
 	.max_samplerate = 200 * KILO,
-	.channels = ad7607_channels,
 	.name = "ad7607",
+	.bits = 14,
 	.num_adc_channels = 8,
-	.num_channels = 9,
 	.oversampling_avail = ad7606_oversampling_avail,
 	.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
 	.scale_setup_cb = ad7607_chan_scale_setup,
@@ -282,10 +189,9 @@ EXPORT_SYMBOL_NS_GPL(ad7607_info, "IIO_AD7606");
 
 const struct ad7606_chip_info ad7608_info = {
 	.max_samplerate = 200 * KILO,
-	.channels = ad7608_channels,
 	.name = "ad7608",
+	.bits = 18,
 	.num_adc_channels = 8,
-	.num_channels = 9,
 	.oversampling_avail = ad7606_oversampling_avail,
 	.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
 	.scale_setup_cb = ad7608_chan_scale_setup,
@@ -294,10 +200,9 @@ EXPORT_SYMBOL_NS_GPL(ad7608_info, "IIO_AD7606");
 
 const struct ad7606_chip_info ad7609_info = {
 	.max_samplerate = 200 * KILO,
-	.channels = ad7608_channels,
 	.name = "ad7609",
+	.bits = 18,
 	.num_adc_channels = 8,
-	.num_channels = 9,
 	.oversampling_avail = ad7606_oversampling_avail,
 	.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
 	.scale_setup_cb = ad7609_chan_scale_setup,
@@ -306,10 +211,9 @@ EXPORT_SYMBOL_NS_GPL(ad7609_info, "IIO_AD7606");
 
 const struct ad7606_chip_info ad7606c_18_info = {
 	.max_samplerate = 1 * MEGA,
-	.channels = ad7606_channels_18bit,
 	.name = "ad7606c18",
+	.bits = 18,
 	.num_adc_channels = 8,
-	.num_channels = 9,
 	.oversampling_avail = ad7606_oversampling_avail,
 	.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
 	.scale_setup_cb = ad7606c_18bit_chan_scale_setup,
@@ -319,11 +223,10 @@ EXPORT_SYMBOL_NS_GPL(ad7606c_18_info, "IIO_AD7606");
 
 const struct ad7606_chip_info ad7616_info = {
 	.max_samplerate = 1 * MEGA,
-	.channels = ad7616_channels,
 	.init_delay_ms = 15,
 	.name = "ad7616",
+	.bits = 16,
 	.num_adc_channels = 16,
-	.num_channels = 17,
 	.oversampling_avail = ad7616_oversampling_avail,
 	.oversampling_num = ARRAY_SIZE(ad7616_oversampling_avail),
 	.os_req_reset = true,
@@ -373,7 +276,6 @@ static int ad7606_get_chan_config(struct iio_dev *indio_dev, int ch,
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
 	unsigned int num_channels = st->chip_info->num_adc_channels;
-	unsigned int offset = indio_dev->num_channels - st->chip_info->num_adc_channels;
 	struct device *dev = st->dev;
 	int ret;
 
@@ -389,7 +291,7 @@ static int ad7606_get_chan_config(struct iio_dev *indio_dev, int ch,
 			continue;
 
 		/* channel number (here) is from 1 to num_channels */
-		if (reg < offset || reg > num_channels) {
+		if (reg < 1 || reg > num_channels) {
 			dev_warn(dev,
 				 "Invalid channel number (ignoring): %d\n", reg);
 			continue;
@@ -706,8 +608,8 @@ static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch,
 			      int *val)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
-	unsigned int realbits = st->chip_info->channels[1].scan_type.realbits;
 	const struct iio_chan_spec *chan;
+	unsigned int realbits;
 	int ret;
 
 	if (st->gpio_convst) {
@@ -739,7 +641,9 @@ static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch,
 	if (ret)
 		goto error_ret;
 
-	chan = &indio_dev->channels[ch + 1];
+	chan = &indio_dev->channels[ch];
+	realbits = chan->scan_type.realbits;
+
 	if (chan->scan_type.sign == 'u') {
 		if (realbits > 16)
 			*val = st->data.buf32[ch];
@@ -1289,29 +1193,84 @@ static int ad7606b_sw_mode_setup(struct iio_dev *indio_dev)
 	return st->bops->sw_mode_config(indio_dev);
 }
 
-static int ad7606_chan_scales_setup(struct iio_dev *indio_dev)
+static int ad7606_probe_channels(struct iio_dev *indio_dev)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
-	unsigned int offset = indio_dev->num_channels - st->chip_info->num_adc_channels;
-	struct iio_chan_spec *chans;
-	size_t size;
-	int ch, ret;
-
-	/* Clone IIO channels, since some may be differential */
-	size = indio_dev->num_channels * sizeof(*indio_dev->channels);
-	chans = devm_kzalloc(st->dev, size, GFP_KERNEL);
-	if (!chans)
+	struct device *dev = indio_dev->dev.parent;
+	struct iio_chan_spec *channels;
+	bool slow_bus;
+	int ret, i;
+
+	slow_bus = !st->bops->iio_backend_config;
+	indio_dev->num_channels = st->chip_info->num_adc_channels;
+
+	/* Slow buses also get 1 more channel for soft timestamp */
+	if (slow_bus)
+		indio_dev->num_channels++;
+
+	channels = devm_kcalloc(dev, indio_dev->num_channels, sizeof(*channels),
+				GFP_KERNEL);
+	if (!channels)
 		return -ENOMEM;
 
-	memcpy(chans, indio_dev->channels, size);
-	indio_dev->channels = chans;
+	for (i = 0; i < indio_dev->num_channels; i++) {
+		struct iio_chan_spec *chan = &channels[i];
 
-	for (ch = 0; ch < st->chip_info->num_adc_channels; ch++) {
-		ret = st->chip_info->scale_setup_cb(indio_dev, &chans[ch + offset]);
+		chan->type = IIO_VOLTAGE;
+		chan->indexed = 1;
+		chan->channel = i;
+		chan->scan_index = i;
+		chan->scan_type.sign = 's';
+		chan->scan_type.realbits = st->chip_info->bits;
+		chan->scan_type.storagebits = st->chip_info->bits > 16 ? 32 : 16;
+		chan->scan_type.endianness = IIO_CPU;
+
+		if (indio_dev->modes & INDIO_DIRECT_MODE)
+			chan->info_mask_separate |= BIT(IIO_CHAN_INFO_RAW);
+
+		if (st->sw_mode_en) {
+			chan->info_mask_separate |= BIT(IIO_CHAN_INFO_SCALE);
+			chan->info_mask_separate_available |=
+				BIT(IIO_CHAN_INFO_SCALE);
+
+			/*
+			 * All chips with software mode support oversampling,
+			 * so we skip the oversampling_available check. And the
+			 * shared_by_type instead of shared_by_all on slow
+			 * buses is for backward compatibility.
+			 */
+			if (slow_bus)
+				chan->info_mask_shared_by_type |=
+					BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO);
+			else
+				chan->info_mask_shared_by_all |=
+					BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO);
+
+			chan->info_mask_shared_by_all_available |=
+				BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO);
+		} else {
+			chan->info_mask_shared_by_type |=
+				BIT(IIO_CHAN_INFO_SCALE);
+
+			if (st->chip_info->oversampling_avail)
+				chan->info_mask_shared_by_all |=
+					BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO);
+		}
+
+		if (!slow_bus)
+			chan->info_mask_shared_by_all |=
+				BIT(IIO_CHAN_INFO_SAMP_FREQ);
+
+		ret = st->chip_info->scale_setup_cb(indio_dev, chan);
 		if (ret)
 			return ret;
 	}
 
+	if (slow_bus)
+		channels[i] = (struct iio_chan_spec)IIO_CHAN_SOFT_TIMESTAMP(i);
+
+	indio_dev->channels = channels;
+
 	return 0;
 }
 
@@ -1343,6 +1302,11 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 	st->bops = bops;
 	st->base_address = base_address;
 	st->oversampling = 1;
+	st->sw_mode_en = device_property_read_bool(dev, "adi,sw-mode");
+
+	if (st->sw_mode_en && !chip_info->sw_setup_cb)
+		return dev_err_probe(dev, -EINVAL,
+			"Software mode is not supported for this chip\n");
 
 	ret = devm_regulator_get_enable(dev, "avcc");
 	if (ret)
@@ -1371,10 +1335,14 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 		else
 			indio_dev->info = &ad7606_info_no_os_or_range;
 	}
-	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	/* AXI ADC backend doesn't support single read. */
+	indio_dev->modes = st->bops->iio_backend_config ? 0 : INDIO_DIRECT_MODE;
 	indio_dev->name = chip_info->name;
-	indio_dev->channels = st->chip_info->channels;
-	indio_dev->num_channels = st->chip_info->num_channels;
+
+	ret = ad7606_probe_channels(indio_dev);
+	if (ret)
+		return ret;
 
 	ret = ad7606_reset(st);
 	if (ret)
@@ -1465,17 +1433,11 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 	st->write_scale = ad7606_write_scale_hw;
 	st->write_os = ad7606_write_os_hw;
 
-	st->sw_mode_en = st->chip_info->sw_setup_cb &&
-			 device_property_present(st->dev, "adi,sw-mode");
 	if (st->sw_mode_en) {
 		indio_dev->info = &ad7606_info_sw_mode;
 		st->chip_info->sw_setup_cb(indio_dev);
 	}
 
-	ret = ad7606_chan_scales_setup(indio_dev);
-	if (ret)
-		return ret;
-
 	return devm_iio_device_register(dev, indio_dev);
 }
 EXPORT_SYMBOL_NS_GPL(ad7606_probe, "IIO_AD7606");
diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index c57a193761c92add6f82cf0cc51ccfdb9d8d2ab4..f0b262fb4554f0bf244338c98ca585143321d616 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -40,76 +40,6 @@
 #define AD7606_RANGE_CH_ADDR(ch)	(0x03 + ((ch) >> 1))
 #define AD7606_OS_MODE			0x08
 
-#define AD760X_CHANNEL(num, mask_sep, mask_type, mask_all,	\
-		mask_sep_avail, mask_all_avail, bits) {		\
-		.type = IIO_VOLTAGE,				\
-		.indexed = 1,					\
-		.channel = num,					\
-		.info_mask_separate = mask_sep,			\
-		.info_mask_separate_available =			\
-			mask_sep_avail,				\
-		.info_mask_shared_by_type = mask_type,		\
-		.info_mask_shared_by_all = mask_all,		\
-		.info_mask_shared_by_all_available =		\
-			mask_all_avail,				\
-		.scan_index = num,				\
-		.scan_type = {					\
-			.sign = 's',				\
-			.realbits = (bits),			\
-			.storagebits = (bits) > 16 ? 32 : 16,	\
-			.endianness = IIO_CPU,			\
-		},						\
-}
-
-#define AD7606_SW_CHANNEL(num, bits)			\
-	AD760X_CHANNEL(num,				\
-		/* mask separate */			\
-		BIT(IIO_CHAN_INFO_RAW) |		\
-		BIT(IIO_CHAN_INFO_SCALE),		\
-		/* mask type */				\
-		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
-		/* mask all */				\
-		0,					\
-		/* mask separate available */		\
-		BIT(IIO_CHAN_INFO_SCALE),		\
-		/* mask all available */		\
-		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
-		bits)
-
-#define AD7605_CHANNEL(num)				\
-	AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_RAW),	\
-		BIT(IIO_CHAN_INFO_SCALE), 0, 0, 0, 16)
-
-#define AD7606_CHANNEL(num, bits)			\
-	AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_RAW),	\
-		BIT(IIO_CHAN_INFO_SCALE),		\
-		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
-		0, 0, bits)
-
-#define AD7616_CHANNEL(num)	AD7606_SW_CHANNEL(num, 16)
-
-#define AD7606_BI_CHANNEL(num)				\
-	AD760X_CHANNEL(num, 0,				\
-		BIT(IIO_CHAN_INFO_SCALE),		\
-		BIT(IIO_CHAN_INFO_SAMP_FREQ) |		\
-		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),  \
-		0, 0, 16)
-
-#define AD7606_BI_SW_CHANNEL(num)			\
-	AD760X_CHANNEL(num,				\
-		/* mask separate */			\
-		BIT(IIO_CHAN_INFO_SCALE),		\
-		/* mask type */				\
-		0,					\
-		/* mask all */				\
-		BIT(IIO_CHAN_INFO_SAMP_FREQ) |		\
-		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
-		/* mask separate available */		\
-		BIT(IIO_CHAN_INFO_SCALE),		\
-		/* mask all available */		\
-		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
-		16)
-
 struct ad7606_state;
 
 typedef int (*ad7606_scale_setup_cb_t)(struct iio_dev *indio_dev,
@@ -118,11 +48,10 @@ typedef int (*ad7606_sw_setup_cb_t)(struct iio_dev *indio_dev);
 
 /**
  * struct ad7606_chip_info - chip specific information
- * @channels:		channel specification
  * @max_samplerate:	maximum supported sample rate
  * @name:		device name
+ * @bits:		data width in bits
  * @num_adc_channels:	the number of physical voltage inputs
- * @num_channels:	number of IIO channels
  * @scale_setup_cb:	callback to setup the scales for each channel
  * @sw_setup_cb:	callback to setup the software mode if available.
  * @oversampling_avail:	pointer to the array which stores the available
@@ -133,11 +62,10 @@ typedef int (*ad7606_sw_setup_cb_t)(struct iio_dev *indio_dev);
  *			after a restart
  */
 struct ad7606_chip_info {
-	const struct iio_chan_spec	*channels;
 	unsigned int			max_samplerate;
 	const char			*name;
+	unsigned int			bits;
 	unsigned int			num_adc_channels;
-	unsigned int			num_channels;
 	ad7606_scale_setup_cb_t		scale_setup_cb;
 	ad7606_sw_setup_cb_t		sw_setup_cb;
 	const unsigned int		*oversampling_avail;
diff --git a/drivers/iio/adc/ad7606_par.c b/drivers/iio/adc/ad7606_par.c
index 335fb481bfde15b79331eabdcbc970d70880338c..e33b07ab5eace4b78e7cf39ee7e8d9379c9f73e7 100644
--- a/drivers/iio/adc/ad7606_par.c
+++ b/drivers/iio/adc/ad7606_par.c
@@ -21,28 +21,6 @@
 #include "ad7606.h"
 #include "ad7606_bus_iface.h"
 
-static const struct iio_chan_spec ad7606b_bi_channels[] = {
-	AD7606_BI_CHANNEL(0),
-	AD7606_BI_CHANNEL(1),
-	AD7606_BI_CHANNEL(2),
-	AD7606_BI_CHANNEL(3),
-	AD7606_BI_CHANNEL(4),
-	AD7606_BI_CHANNEL(5),
-	AD7606_BI_CHANNEL(6),
-	AD7606_BI_CHANNEL(7),
-};
-
-static const struct iio_chan_spec ad7606b_bi_sw_channels[] = {
-	AD7606_BI_SW_CHANNEL(0),
-	AD7606_BI_SW_CHANNEL(1),
-	AD7606_BI_SW_CHANNEL(2),
-	AD7606_BI_SW_CHANNEL(3),
-	AD7606_BI_SW_CHANNEL(4),
-	AD7606_BI_SW_CHANNEL(5),
-	AD7606_BI_SW_CHANNEL(6),
-	AD7606_BI_SW_CHANNEL(7),
-};
-
 static int ad7606_par_bus_update_scan_mode(struct iio_dev *indio_dev,
 					   const unsigned long *scan_mask)
 {
@@ -94,9 +72,6 @@ static int ad7606_par_bus_setup_iio_backend(struct device *dev,
 			return ret;
 	}
 
-	indio_dev->channels = ad7606b_bi_channels;
-	indio_dev->num_channels = 8;
-
 	return 0;
 }
 
@@ -120,19 +95,11 @@ static int ad7606_par_bus_reg_write(struct ad7606_state *st, unsigned int addr,
 	return pdata->bus_reg_write(st->back, addr, val);
 }
 
-static int ad7606_par_bus_sw_mode_config(struct iio_dev *indio_dev)
-{
-	indio_dev->channels = ad7606b_bi_sw_channels;
-
-	return 0;
-}
-
 static const struct ad7606_bus_ops ad7606_bi_bops = {
 	.iio_backend_config = ad7606_par_bus_setup_iio_backend,
 	.update_scan_mode = ad7606_par_bus_update_scan_mode,
 	.reg_read = ad7606_par_bus_reg_read,
 	.reg_write = ad7606_par_bus_reg_write,
-	.sw_mode_config = ad7606_par_bus_sw_mode_config,
 };
 
 static int ad7606_par16_read_block(struct device *dev,
diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
index 1abaf8626206cb30e532cf9f82e0d050706aa1e0..b2b975fb7fea4d1af6caef59e75ca495501bc140 100644
--- a/drivers/iio/adc/ad7606_spi.c
+++ b/drivers/iio/adc/ad7606_spi.c
@@ -15,50 +15,6 @@
 
 #define MAX_SPI_FREQ_HZ		23500000	/* VDRIVE above 4.75 V */
 
-static const struct iio_chan_spec ad7616_sw_channels[] = {
-	IIO_CHAN_SOFT_TIMESTAMP(16),
-	AD7616_CHANNEL(0),
-	AD7616_CHANNEL(1),
-	AD7616_CHANNEL(2),
-	AD7616_CHANNEL(3),
-	AD7616_CHANNEL(4),
-	AD7616_CHANNEL(5),
-	AD7616_CHANNEL(6),
-	AD7616_CHANNEL(7),
-	AD7616_CHANNEL(8),
-	AD7616_CHANNEL(9),
-	AD7616_CHANNEL(10),
-	AD7616_CHANNEL(11),
-	AD7616_CHANNEL(12),
-	AD7616_CHANNEL(13),
-	AD7616_CHANNEL(14),
-	AD7616_CHANNEL(15),
-};
-
-static const struct iio_chan_spec ad7606b_sw_channels[] = {
-	IIO_CHAN_SOFT_TIMESTAMP(8),
-	AD7606_SW_CHANNEL(0, 16),
-	AD7606_SW_CHANNEL(1, 16),
-	AD7606_SW_CHANNEL(2, 16),
-	AD7606_SW_CHANNEL(3, 16),
-	AD7606_SW_CHANNEL(4, 16),
-	AD7606_SW_CHANNEL(5, 16),
-	AD7606_SW_CHANNEL(6, 16),
-	AD7606_SW_CHANNEL(7, 16),
-};
-
-static const struct iio_chan_spec ad7606c_18_sw_channels[] = {
-	IIO_CHAN_SOFT_TIMESTAMP(8),
-	AD7606_SW_CHANNEL(0, 18),
-	AD7606_SW_CHANNEL(1, 18),
-	AD7606_SW_CHANNEL(2, 18),
-	AD7606_SW_CHANNEL(3, 18),
-	AD7606_SW_CHANNEL(4, 18),
-	AD7606_SW_CHANNEL(5, 18),
-	AD7606_SW_CHANNEL(6, 18),
-	AD7606_SW_CHANNEL(7, 18),
-};
-
 static u16 ad7616_spi_rd_wr_cmd(int addr, char is_write_op)
 {
 	/*
@@ -160,48 +116,13 @@ static int ad7606_spi_reg_write(struct ad7606_state *st,
 	return spi_write(spi, &st->d16[0], sizeof(st->d16[0]));
 }
 
-static int ad7616_sw_mode_config(struct iio_dev *indio_dev)
-{
-	/*
-	 * Scale can be configured individually for each channel
-	 * in software mode.
-	 */
-	indio_dev->channels = ad7616_sw_channels;
-
-	return 0;
-}
-
 static int ad7606b_sw_mode_config(struct iio_dev *indio_dev)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
-	int ret;
 
 	/* Configure device spi to output on a single channel */
-	ret = st->bops->reg_write(st, AD7606_CONFIGURATION_REGISTER,
-				  AD7606_SINGLE_DOUT);
-	if (ret)
-		return ret;
-
-	/*
-	 * Scale can be configured individually for each channel
-	 * in software mode.
-	 */
-	indio_dev->channels = ad7606b_sw_channels;
-
-	return 0;
-}
-
-static int ad7606c_18_sw_mode_config(struct iio_dev *indio_dev)
-{
-	int ret;
-
-	ret = ad7606b_sw_mode_config(indio_dev);
-	if (ret)
-		return ret;
-
-	indio_dev->channels = ad7606c_18_sw_channels;
-
-	return 0;
+	return st->bops->reg_write(st, AD7606_CONFIGURATION_REGISTER,
+				   AD7606_SINGLE_DOUT);
 }
 
 static const struct ad7606_bus_ops ad7606_spi_bops = {
@@ -221,7 +142,6 @@ static const struct ad7606_bus_ops ad7616_spi_bops = {
 	.reg_read = ad7606_spi_reg_read,
 	.reg_write = ad7606_spi_reg_write,
 	.rd_wr_cmd = ad7616_spi_rd_wr_cmd,
-	.sw_mode_config = ad7616_sw_mode_config,
 };
 
 static const struct ad7606_bus_ops ad7606b_spi_bops = {
@@ -237,7 +157,7 @@ static const struct ad7606_bus_ops ad7606c_18_spi_bops = {
 	.reg_read = ad7606_spi_reg_read,
 	.reg_write = ad7606_spi_reg_write,
 	.rd_wr_cmd = ad7606b_spi_rd_wr_cmd,
-	.sw_mode_config = ad7606c_18_sw_mode_config,
+	.sw_mode_config = ad7606b_sw_mode_config,
 };
 
 static const struct ad7606_bus_info ad7605_4_bus_info = {

-- 
2.43.0


