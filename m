Return-Path: <linux-iio+bounces-20271-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9333AD03EB
	for <lists+linux-iio@lfdr.de>; Fri,  6 Jun 2025 16:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 437E3189A663
	for <lists+linux-iio@lfdr.de>; Fri,  6 Jun 2025 14:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1872428935C;
	Fri,  6 Jun 2025 14:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="e+x/X77k"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E4A1B4F09
	for <linux-iio@vger.kernel.org>; Fri,  6 Jun 2025 14:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749219649; cv=none; b=E0cergDq1nt0ZQdTcS08UvsO2JreWWwrm2daTYjUUNZ2V9rCaFa48NIIMWfN4T4jTz6q3+ppWJlqR4QnfkgsL3IUiUlGqNQB8+S+Tu3CVrI7hnukOslC4zZB0xWLsyN/Ri3dR4BUo9d/zxWZCjfdakfHBtMBwtcxjjQk2EzBCuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749219649; c=relaxed/simple;
	bh=FM/lNx/NoMUl4+HOYDoXqhqfqugSIVlZhiTKYzbPGF8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=biPMs/bo7JWDqMPMVbfIKDVja9TdF8C0OMapY0VRR4bNfEJiIIJyXiO5TLwxmq9kFJ9v5VrYlp/U913Ew5xoq6JBIdRSNpmmVvHkb7hyEW7b1dDQw9Ih9SkPucr5dD8mwUpLIdHSsNJbSLFTXl7ApA7fMxqxCc7uLTHLA2z/7Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=e+x/X77k; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-451ebd3d149so14463555e9.2
        for <linux-iio@vger.kernel.org>; Fri, 06 Jun 2025 07:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749219645; x=1749824445; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FTuEafk7AJcKSXLfCGmDtVuPWJx1m3LaW+qyIuTb51M=;
        b=e+x/X77kqpGTvnyR7HK6Jbsbh3OJewr2fDJEVVRvH3W20jj0ftX9FvhLXYPUsMd0aQ
         zgSRELIjpigRwQdMzsy/qD9sFzs5do99njdIhIkZDvDtw7qW5zGRpLpnaIFud+aarJHa
         RnzNGZbvXzYOoo/4DFe8OnWZLWuyYbsbWWvLM0q+Tjk/p01EjFqouvBu7HSw5iEEQn2x
         UPO4t04dS5YGiaXdU8z0clptcEn0CohMJKtUfSxscOLtWQAwfaQFkJkoQtQF6AGlOWFA
         QCgkmtzU31qZTSM5aE/z3B2W7lclFXIbm+cdgl/unTWYI89paGoWx8T/qmdrzYysZtOF
         soyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749219645; x=1749824445;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FTuEafk7AJcKSXLfCGmDtVuPWJx1m3LaW+qyIuTb51M=;
        b=iEp4UqkjZnwdTdn+X1DdHZvLJKhryFokEMgt2fc2srR0NXjPJBwoCujpvcMUwY6+So
         P+gFKS9gLvMsifbMXh1x6V5v6KZCXhWDsJbUAfpQI2EXQAKdOxOUuXc4eciPtM5aWkxM
         vEHJy6O8GJwwDR+FDX6Yksuk/p98uixed0Ld21dKAaHVUVK0wdu0J6TYhJp2RUX4K5uq
         wMqRc3PvmUxHu56lOD2SOd8l4qkagSZDu1t23QGQoxRdo5F6seF5YuAMA7sW0dwwqhit
         Y/0zoc47GB/9SLP5KgCTdDR1mreSU4SJ02MCnZRMh/jbvSnLtYqZz742rXh7DfKLUHAt
         JLDQ==
X-Gm-Message-State: AOJu0Yyx6oXxk+nQSD18YjcwYx4YxuvQrJb95Vp4VColv2vlWsu/pqU7
	AvjU0vdy+704R+py3eW/la0KSirejxy8K8t2FHKlinp5ZFBeM1P8Bj0xphYMWfOocEg=
X-Gm-Gg: ASbGncuRLDtDfkiy6LFKBKkIG63FRJtMRPVscLeWJ4lFrZWkv6GFrDEc4HEOA1aoiW7
	zBNaXyA5JaxlezvxhddRJ0979f375yRI+Rk7wQRCFrxCYpGiIFfqf5HyLmSnMGWZqoAM79ym1BU
	vhdZec8ZmsXD+D1MtVJogpoa8mD9KdlP2xBANtdHS8Bs299xtVDSZQvx5Fj3KKGAkZdxCFyQQTe
	5pKLKXnvPZU1hPHTlywRh6QeUJPwN4yMi8AmPz4WFOUSbw50N0Omub1BlCQI69IF4IRzx0ZGRkT
	e3ABY1o72+e8xElDYAlZZ8Mu632i7tUHC2xg5q6uaPCPRdpX+0eR5mBfgkhiBFW2UHwQ61Yg0Dl
	wEwD+F4vHBUq70jiRxxKfJAgkqbZTEo4=
X-Google-Smtp-Source: AGHT+IGEhI4sPI0wEudXZKJjhOjCtgvCYvzI5muZwgZmR7jg/VdiL3a8CyaHhrsgfABhSeDX0jmdGQ==
X-Received: by 2002:a05:600c:8b11:b0:43d:77c5:9c1a with SMTP id 5b1f17b1804b1-4520137401bmr37541965e9.4.1749219644593;
        Fri, 06 Jun 2025 07:20:44 -0700 (PDT)
Received: from [192.168.0.2] (host-80-116-51-117.retail.telecomitalia.it. [80.116.51.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45213754973sm25686345e9.35.2025.06.06.07.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 07:20:44 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Fri, 06 Jun 2025 16:19:21 +0200
Subject: [PATCH v9 6/7] iio: adc: ad7606: rename chan_scale to a more
 generic chan_info
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250606-wip-bl-ad7606-calibration-v9-6-6e014a1f92a2@baylibre.com>
References: <20250606-wip-bl-ad7606-calibration-v9-0-6e014a1f92a2@baylibre.com>
In-Reply-To: <20250606-wip-bl-ad7606-calibration-v9-0-6e014a1f92a2@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 devicetree@vger.kernel.org, Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=13558;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=jM36RN95wuoXc1xpOLlSkdVG60WLPaOM5HAG18IsH9o=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYshw+vGs8PPbQ80BZb7CIq8rcouE3kbvW5dx+IYw09sft
 jd3PM436ShlYRDjYpAVU2SpS4wwCb0dKqW8gHE2zBxWJpAhDFycAjCRmRmMDHtlstfnqiYXu0/9
 N9NNNdDpsPyFzfP/fOuY+P/FsalbC7IZ/lelvJnvNmllYYTXvCjJ5U6LJicf0njW+3PvrDjHI09
 UWDgA
X-Developer-Key: i=adureghello@baylibre.com; a=openpgp;
 fpr=703CDFAD8B573EB00850E38366D1CB9419AF3953

From: Angelo Dureghello <adureghello@baylibre.com>

Non functional, renaming chan-related chan_scale structure to a more
generic chan_info, to host other chan specific settings, not just
scale-related.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 142 +++++++++++++++++++++++------------------------
 drivers/iio/adc/ad7606.h |   8 +--
 2 files changed, 75 insertions(+), 75 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index e5878974a28293664dd8dbded5fffcea6db31ef3..d19682186e7cd73a60541f62adf08d987ba24ec3 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -283,21 +283,21 @@ static int ad7606_16bit_chan_scale_setup(struct iio_dev *indio_dev,
 					 struct iio_chan_spec *chan)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
-	struct ad7606_chan_scale *cs = &st->chan_scales[chan->scan_index];
+	struct ad7606_chan_info *ci = &st->chan_info[chan->scan_index];
 
 	if (!st->sw_mode_en) {
 		/* tied to logic low, analog input range is +/- 5V */
-		cs->range = 0;
-		cs->scale_avail = ad7606_16bit_hw_scale_avail;
-		cs->num_scales = ARRAY_SIZE(ad7606_16bit_hw_scale_avail);
+		ci->range = 0;
+		ci->scale_avail = ad7606_16bit_hw_scale_avail;
+		ci->num_scales = ARRAY_SIZE(ad7606_16bit_hw_scale_avail);
 		return 0;
 	}
 
 	/* Scale of 0.076293 is only available in sw mode */
 	/* After reset, in software mode, ±10 V is set by default */
-	cs->range = 2;
-	cs->scale_avail = ad7606_16bit_sw_scale_avail;
-	cs->num_scales = ARRAY_SIZE(ad7606_16bit_sw_scale_avail);
+	ci->range = 2;
+	ci->scale_avail = ad7606_16bit_sw_scale_avail;
+	ci->num_scales = ARRAY_SIZE(ad7606_16bit_sw_scale_avail);
 
 	return 0;
 }
@@ -359,14 +359,14 @@ static int ad7606c_18bit_chan_scale_setup(struct iio_dev *indio_dev,
 					  struct iio_chan_spec *chan)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
-	struct ad7606_chan_scale *cs = &st->chan_scales[chan->scan_index];
+	struct ad7606_chan_info *ci = &st->chan_info[chan->scan_index];
 	bool bipolar, differential;
 	int ret;
 
 	if (!st->sw_mode_en) {
-		cs->range = 0;
-		cs->scale_avail = ad7606_18bit_hw_scale_avail;
-		cs->num_scales = ARRAY_SIZE(ad7606_18bit_hw_scale_avail);
+		ci->range = 0;
+		ci->scale_avail = ad7606_18bit_hw_scale_avail;
+		ci->num_scales = ARRAY_SIZE(ad7606_18bit_hw_scale_avail);
 		return 0;
 	}
 
@@ -376,12 +376,12 @@ static int ad7606c_18bit_chan_scale_setup(struct iio_dev *indio_dev,
 		return ret;
 
 	if (differential) {
-		cs->scale_avail = ad7606c_18bit_differential_bipolar_scale_avail;
-		cs->num_scales =
+		ci->scale_avail = ad7606c_18bit_differential_bipolar_scale_avail;
+		ci->num_scales =
 			ARRAY_SIZE(ad7606c_18bit_differential_bipolar_scale_avail);
 		/* Bipolar differential ranges start at 8 (b1000) */
-		cs->reg_offset = 8;
-		cs->range = 1;
+		ci->reg_offset = 8;
+		ci->range = 1;
 		chan->differential = 1;
 		chan->channel2 = chan->channel;
 
@@ -391,23 +391,23 @@ static int ad7606c_18bit_chan_scale_setup(struct iio_dev *indio_dev,
 	chan->differential = 0;
 
 	if (bipolar) {
-		cs->scale_avail = ad7606c_18bit_single_ended_bipolar_scale_avail;
-		cs->num_scales =
+		ci->scale_avail = ad7606c_18bit_single_ended_bipolar_scale_avail;
+		ci->num_scales =
 			ARRAY_SIZE(ad7606c_18bit_single_ended_bipolar_scale_avail);
 		/* Bipolar single-ended ranges start at 0 (b0000) */
-		cs->reg_offset = 0;
-		cs->range = 3;
+		ci->reg_offset = 0;
+		ci->range = 3;
 		chan->scan_type.sign = 's';
 
 		return 0;
 	}
 
-	cs->scale_avail = ad7606c_18bit_single_ended_unipolar_scale_avail;
-	cs->num_scales =
+	ci->scale_avail = ad7606c_18bit_single_ended_unipolar_scale_avail;
+	ci->num_scales =
 		ARRAY_SIZE(ad7606c_18bit_single_ended_unipolar_scale_avail);
 	/* Unipolar single-ended ranges start at 5 (b0101) */
-	cs->reg_offset = 5;
-	cs->range = 1;
+	ci->reg_offset = 5;
+	ci->range = 1;
 	chan->scan_type.sign = 'u';
 
 	return 0;
@@ -417,14 +417,14 @@ static int ad7606c_16bit_chan_scale_setup(struct iio_dev *indio_dev,
 					  struct iio_chan_spec *chan)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
-	struct ad7606_chan_scale *cs = &st->chan_scales[chan->scan_index];
+	struct ad7606_chan_info *ci = &st->chan_info[chan->scan_index];
 	bool bipolar, differential;
 	int ret;
 
 	if (!st->sw_mode_en) {
-		cs->range = 0;
-		cs->scale_avail = ad7606_16bit_hw_scale_avail;
-		cs->num_scales = ARRAY_SIZE(ad7606_16bit_hw_scale_avail);
+		ci->range = 0;
+		ci->scale_avail = ad7606_16bit_hw_scale_avail;
+		ci->num_scales = ARRAY_SIZE(ad7606_16bit_hw_scale_avail);
 		return 0;
 	}
 
@@ -434,12 +434,12 @@ static int ad7606c_16bit_chan_scale_setup(struct iio_dev *indio_dev,
 		return ret;
 
 	if (differential) {
-		cs->scale_avail = ad7606c_16bit_differential_bipolar_scale_avail;
-		cs->num_scales =
+		ci->scale_avail = ad7606c_16bit_differential_bipolar_scale_avail;
+		ci->num_scales =
 			ARRAY_SIZE(ad7606c_16bit_differential_bipolar_scale_avail);
 		/* Bipolar differential ranges start at 8 (b1000) */
-		cs->reg_offset = 8;
-		cs->range = 1;
+		ci->reg_offset = 8;
+		ci->range = 1;
 		chan->differential = 1;
 		chan->channel2 = chan->channel;
 		chan->scan_type.sign = 's';
@@ -450,23 +450,23 @@ static int ad7606c_16bit_chan_scale_setup(struct iio_dev *indio_dev,
 	chan->differential = 0;
 
 	if (bipolar) {
-		cs->scale_avail = ad7606c_16bit_single_ended_bipolar_scale_avail;
-		cs->num_scales =
+		ci->scale_avail = ad7606c_16bit_single_ended_bipolar_scale_avail;
+		ci->num_scales =
 			ARRAY_SIZE(ad7606c_16bit_single_ended_bipolar_scale_avail);
 		/* Bipolar single-ended ranges start at 0 (b0000) */
-		cs->reg_offset = 0;
-		cs->range = 3;
+		ci->reg_offset = 0;
+		ci->range = 3;
 		chan->scan_type.sign = 's';
 
 		return 0;
 	}
 
-	cs->scale_avail = ad7606c_16bit_single_ended_unipolar_scale_avail;
-	cs->num_scales =
+	ci->scale_avail = ad7606c_16bit_single_ended_unipolar_scale_avail;
+	ci->num_scales =
 		ARRAY_SIZE(ad7606c_16bit_single_ended_unipolar_scale_avail);
 	/* Unipolar single-ended ranges start at 5 (b0101) */
-	cs->reg_offset = 5;
-	cs->range = 1;
+	ci->reg_offset = 5;
+	ci->range = 1;
 	chan->scan_type.sign = 'u';
 
 	return 0;
@@ -476,11 +476,11 @@ static int ad7607_chan_scale_setup(struct iio_dev *indio_dev,
 				   struct iio_chan_spec *chan)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
-	struct ad7606_chan_scale *cs = &st->chan_scales[chan->scan_index];
+	struct ad7606_chan_info *ci = &st->chan_info[chan->scan_index];
 
-	cs->range = 0;
-	cs->scale_avail = ad7607_hw_scale_avail;
-	cs->num_scales = ARRAY_SIZE(ad7607_hw_scale_avail);
+	ci->range = 0;
+	ci->scale_avail = ad7607_hw_scale_avail;
+	ci->num_scales = ARRAY_SIZE(ad7607_hw_scale_avail);
 	return 0;
 }
 
@@ -488,11 +488,11 @@ static int ad7608_chan_scale_setup(struct iio_dev *indio_dev,
 				   struct iio_chan_spec *chan)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
-	struct ad7606_chan_scale *cs = &st->chan_scales[chan->scan_index];
+	struct ad7606_chan_info *ci = &st->chan_info[chan->scan_index];
 
-	cs->range = 0;
-	cs->scale_avail = ad7606_18bit_hw_scale_avail;
-	cs->num_scales = ARRAY_SIZE(ad7606_18bit_hw_scale_avail);
+	ci->range = 0;
+	ci->scale_avail = ad7606_18bit_hw_scale_avail;
+	ci->num_scales = ARRAY_SIZE(ad7606_18bit_hw_scale_avail);
 	return 0;
 }
 
@@ -500,11 +500,11 @@ static int ad7609_chan_scale_setup(struct iio_dev *indio_dev,
 				   struct iio_chan_spec *chan)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
-	struct ad7606_chan_scale *cs = &st->chan_scales[chan->scan_index];
+	struct ad7606_chan_info *ci = &st->chan_info[chan->scan_index];
 
-	cs->range = 0;
-	cs->scale_avail = ad7609_hw_scale_avail;
-	cs->num_scales = ARRAY_SIZE(ad7609_hw_scale_avail);
+	ci->range = 0;
+	ci->scale_avail = ad7609_hw_scale_avail;
+	ci->num_scales = ARRAY_SIZE(ad7609_hw_scale_avail);
 	return 0;
 }
 
@@ -743,7 +743,7 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
 {
 	int ret, ch = 0;
 	struct ad7606_state *st = iio_priv(indio_dev);
-	struct ad7606_chan_scale *cs;
+	struct ad7606_chan_info *ci;
 	struct pwm_state cnvst_pwm_state;
 
 	switch (m) {
@@ -758,9 +758,9 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SCALE:
 		if (st->sw_mode_en)
 			ch = chan->scan_index;
-		cs = &st->chan_scales[ch];
-		*val = cs->scale_avail[cs->range][0];
-		*val2 = cs->scale_avail[cs->range][1];
+		ci = &st->chan_info[ch];
+		*val = ci->scale_avail[ci->range][0];
+		*val2 = ci->scale_avail[ci->range][1];
 		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		*val = st->oversampling;
@@ -795,12 +795,12 @@ static ssize_t in_voltage_scale_available_show(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7606_state *st = iio_priv(indio_dev);
-	struct ad7606_chan_scale *cs = &st->chan_scales[0];
-	const unsigned int (*vals)[2] = cs->scale_avail;
+	struct ad7606_chan_info *ci = &st->chan_info[0];
+	const unsigned int (*vals)[2] = ci->scale_avail;
 	unsigned int i;
 	size_t len = 0;
 
-	for (i = 0; i < cs->num_scales; i++)
+	for (i = 0; i < ci->num_scales; i++)
 		len += scnprintf(buf + len, PAGE_SIZE - len, "%u.%06u ",
 				 vals[i][0], vals[i][1]);
 	buf[len - 1] = '\n';
@@ -901,7 +901,7 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
 	unsigned int scale_avail_uv[AD760X_MAX_SCALES];
-	struct ad7606_chan_scale *cs;
+	struct ad7606_chan_info *ci;
 	int i, ret, ch = 0;
 
 	guard(mutex)(&st->lock);
@@ -910,21 +910,21 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SCALE:
 		if (st->sw_mode_en)
 			ch = chan->scan_index;
-		cs = &st->chan_scales[ch];
-		for (i = 0; i < cs->num_scales; i++) {
-			scale_avail_uv[i] = cs->scale_avail[i][0] * MICRO +
-					    cs->scale_avail[i][1];
+		ci = &st->chan_info[ch];
+		for (i = 0; i < ci->num_scales; i++) {
+			scale_avail_uv[i] = ci->scale_avail[i][0] * MICRO +
+					    ci->scale_avail[i][1];
 		}
 		val = (val * MICRO) + val2;
-		i = find_closest(val, scale_avail_uv, cs->num_scales);
+		i = find_closest(val, scale_avail_uv, ci->num_scales);
 
 		if (!iio_device_claim_direct(indio_dev))
 			return -EBUSY;
-		ret = st->write_scale(indio_dev, ch, i + cs->reg_offset);
+		ret = st->write_scale(indio_dev, ch, i + ci->reg_offset);
 		iio_device_release_direct(indio_dev);
 		if (ret < 0)
 			return ret;
-		cs->range = i;
+		ci->range = i;
 
 		return 0;
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
@@ -1115,7 +1115,7 @@ static int ad7606_read_avail(struct iio_dev *indio_dev,
 			     long info)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
-	struct ad7606_chan_scale *cs;
+	struct ad7606_chan_info *ci;
 	unsigned int ch = 0;
 
 	switch (info) {
@@ -1130,9 +1130,9 @@ static int ad7606_read_avail(struct iio_dev *indio_dev,
 		if (st->sw_mode_en)
 			ch = chan->scan_index;
 
-		cs = &st->chan_scales[ch];
-		*vals = (int *)cs->scale_avail;
-		*length = cs->num_scales * 2;
+		ci = &st->chan_info[ch];
+		*vals = (int *)ci->scale_avail;
+		*length = ci->num_scales * 2;
 		*type = IIO_VAL_INT_PLUS_MICRO;
 
 		return IIO_AVAIL_LIST;
@@ -1655,7 +1655,7 @@ static int ad7606_resume(struct device *dev)
 	struct ad7606_state *st = iio_priv(indio_dev);
 
 	if (st->gpio_standby) {
-		gpiod_set_value(st->gpio_range, st->chan_scales[0].range);
+		gpiod_set_value(st->gpio_range, st->chan_info[0].range);
 		gpiod_set_value(st->gpio_standby, 1);
 		ad7606_reset(st);
 	}
diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index f613583a7fa4095115b0b28e3f8e51cd32b93524..26db8e3c724f47f68b7d5323f5d1db75b3334540 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -86,14 +86,14 @@ struct ad7606_chip_info {
 };
 
 /**
- * struct ad7606_chan_scale - channel scale configuration
+ * struct ad7606_chan_info - channel configuration
  * @scale_avail:	pointer to the array which stores the available scales
  * @num_scales:		number of elements stored in the scale_avail array
  * @range:		voltage range selection, selects which scale to apply
  * @reg_offset:		offset for the register value, to be applied when
  *			writing the value of 'range' to the register value
  */
-struct ad7606_chan_scale {
+struct ad7606_chan_info {
 #define AD760X_MAX_SCALES		16
 	const unsigned int		(*scale_avail)[2];
 	unsigned int			num_scales;
@@ -106,7 +106,7 @@ struct ad7606_chan_scale {
  * @dev:		pointer to kernel device
  * @chip_info:		entry in the table of chips that describes this device
  * @bops:		bus operations (SPI or parallel)
- * @chan_scales:	scale configuration for channels
+ * @chan_info:		scale configuration for channels
  * @oversampling:	oversampling selection
  * @cnvst_pwm:		pointer to the PWM device connected to the cnvst pin
  * @base_address:	address from where to read data in parallel operation
@@ -137,7 +137,7 @@ struct ad7606_state {
 	struct device			*dev;
 	const struct ad7606_chip_info	*chip_info;
 	const struct ad7606_bus_ops	*bops;
-	struct ad7606_chan_scale	chan_scales[AD760X_MAX_CHANNELS];
+	struct ad7606_chan_info		chan_info[AD760X_MAX_CHANNELS];
 	unsigned int			oversampling;
 	struct pwm_device		*cnvst_pwm;
 	void __iomem			*base_address;

-- 
2.49.0


