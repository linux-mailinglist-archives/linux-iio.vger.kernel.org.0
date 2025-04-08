Return-Path: <linux-iio+bounces-17805-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBAFA7FBF1
	for <lists+linux-iio@lfdr.de>; Tue,  8 Apr 2025 12:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A25C3B7143
	for <lists+linux-iio@lfdr.de>; Tue,  8 Apr 2025 10:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D2E26869C;
	Tue,  8 Apr 2025 10:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1D6dpUnv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B94A267F76
	for <linux-iio@vger.kernel.org>; Tue,  8 Apr 2025 10:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744107619; cv=none; b=JyHWkuvOACqE8Fe0hGjQxS5LPahAEEwT69SeXKxebJ88KeKQv0W3t9TGUn8gxLmJaPBnTklK2ykopAGbSAGiLbaDVKB2NPq2FhxNfe3RmUKXgYj5P3P3AWYTv5GqOYMvUkNN1g3UJ9gyljmFo8Ero8Y1k/QbJAF2/kEkBjLkp08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744107619; c=relaxed/simple;
	bh=uaSn6MwlcUjmKtZsVLaWOQsSsxy2zH+ZMA/NJ+Ecw1I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hXLZsIh12tmaj6oIR35Hf6Ulx+Skg8hHKMwpSdDd/YgEo/BtgzfX8LtJmmjN25ZiwbCp1+a4mlEuVD1xKX+GPKGDXAaXTO8tTWqNqKhSCL9NB9JDy+A4GXFn74fdauCRKJVKkV1t5Z/hTLG+VKT1Dj9sLgKGLirygvp6xtQr/Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1D6dpUnv; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cfb6e9031so48781905e9.0
        for <linux-iio@vger.kernel.org>; Tue, 08 Apr 2025 03:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744107614; x=1744712414; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5TWjREkBL8GjTju5ZPe7ZnjIycMK9O4uTTIH3dx3mcg=;
        b=1D6dpUnvnAsWmZeluKx2NMBI3WA+071Xtany+l+7sPq8R0i3BF1ovS1fePxDfzcIBm
         8IAxxs4zbJs5JFDt+7Uu+UIaNhbyuCtyOdBuaBwht03KyjJObB5asHuU0ybiqC1+Btb3
         tdqFq6somI7PWDZLGzEGttu3SKMb1p/PtXWsO5qh9wfXyPhImApkrXHqvQ79sVm9XbVp
         iQO3VwuvdVp/UF18QYB9kPZazxR+5aq6MYhWlYLJvkHtEYqvfjlImvXd8AE1lmr4LvyJ
         gbgDBLiJ2i8IkIzyp/4jjVrv7YDdT02eeWH26EH7ntI7fXZWnAYzOww2Q+n9JOJIB9x4
         b89w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744107614; x=1744712414;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5TWjREkBL8GjTju5ZPe7ZnjIycMK9O4uTTIH3dx3mcg=;
        b=sY7M63mRD2Ei4s62fpYV4x3tDrXS9VQFRlIKjomiSKKmdFTyWJJvFbXS6loB0kbCL8
         OJW1DG07FR1iCRDtXgwVexXgwUxJ3tW8QR3q48NzsyZtBci62zSWcOQhAhlhidyeWeay
         LKyLW+Zkpqcy1HERf7al2mMKJsoxmiUvU+lEPPaN65QVs8gAhJADJGK1zXzN6tZ0GbuZ
         MtJe99LV3P1apuqNp395G35N/0pFe7j/n9IjfaPstgD0mCJkiHLsrFQyQj3iO8f3T1i+
         hTHRMKe+vBMsUK4Vyoeszo20+WehEjy1O7SE8q+wJqcxF8Ti6TTJeuE9F1lquGDYZ666
         dbcw==
X-Gm-Message-State: AOJu0Yzvaw9pDXzmRjqJ+ux4Mbh51x7cARNp4zXKyn5bMsVv20X2Am/6
	UbGKA+elvCft0wevPFWlAYoKLj4sCHfuUjqlzRZVWAFh8gCFeludQnkeiaq/1dE=
X-Gm-Gg: ASbGncsDYQXxAuuTkDzhLis91NZP1lFrsnV1x/vBoXZBjJxAKdmVowlhOP5RhppFwll
	repIoIiuCP/HRq4E6woYDUUZbh+fySEM7dB6zwtVq1lXsFYOn49vmeOuz/XepfgRiUYfcid8cww
	9nBU2GilXJykjQc/Y+mT/hCMvYOsXrIPTwHFdQ0AjkWbnlBM6CpltUI/rIA6uHwFUCtqDDqxZ9a
	h/14KzaWWn2aKZ9DsgB8ADRNqOrz+wJhDKfxsW0qef90VJyTUYyW64Q7p1lzBUuAYfJehBGmWEV
	KgcVhQfTP7VXLkHKPbctg2cBEmp1YKYwP859u/JvuBdF9QtyF6qJ/fUs76X4EiwKZqWAC155I5L
	OgU0IHeMSC+MBrE8pPFOtEg==
X-Google-Smtp-Source: AGHT+IGRho06kAFvyYZIybkWVdW8uTOAmiAGyOTWEhu5um6FvJaKPHVpVzSbgjTLVAUzrMNLKKYedQ==
X-Received: by 2002:a5d:59a5:0:b0:39b:fa24:950a with SMTP id ffacd0b85a97d-39cba9825e1mr12129520f8f.36.1744107614314;
        Tue, 08 Apr 2025 03:20:14 -0700 (PDT)
Received: from [192.168.0.2] (host-87-15-70-119.retail.telecomitalia.it. [87.15.70.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d7c6d838bsm4396138f8f.69.2025.04.08.03.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 03:20:13 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Tue, 08 Apr 2025 12:18:51 +0200
Subject: [PATCH v4 1/5] iio: dac: adi-axi-dac: add cntrl chan check
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250408-wip-bl-ad3552r-fixes-v4-1-b33c0264bd78@baylibre.com>
References: <20250408-wip-bl-ad3552r-fixes-v4-0-b33c0264bd78@baylibre.com>
In-Reply-To: <20250408-wip-bl-ad3552r-fixes-v4-0-b33c0264bd78@baylibre.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>
Cc: linux-iio@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3092;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=UoS9PVUrR5VQ2Mqe4V6ZiAxOY0YtQJ30vm21lXMXNAw=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYkj/8kMo6slvwRyLdb8OvPbLZFtiXxaQ1GDRePZNfeXy7
 IO7LI0LO0pZGMS4GGTFFFnqEiNMQm+HSikvYJwNM4eVCWQIAxenAEykdSrDP3u3idteO8kLyOS2
 qb9iW54os/CIwo/pEWJOzjMWfX3leonhf/EHhglXDx+sVJlebBrPKxPGUyYSVZFiUCTyemGdZfo
 EPgA=
X-Developer-Key: i=adureghello@baylibre.com; a=openpgp;
 fpr=703CDFAD8B573EB00850E38366D1CB9419AF3953

From: Angelo Dureghello <adureghello@baylibre.com>

Add validity check on CNTRL_X channels (valid as 0 to 15).

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/adi-axi-dac.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
index 892d770aec69c4259de777058801c9ab33c79923..f86acb98b0cffb09bf4d4626f932bf1edc911e2b 100644
--- a/drivers/iio/dac/adi-axi-dac.c
+++ b/drivers/iio/dac/adi-axi-dac.c
@@ -84,6 +84,7 @@
 #define AXI_DAC_CHAN_CNTRL_7_REG(c)		(0x0418 + (c) * 0x40)
 #define   AXI_DAC_CHAN_CNTRL_7_DATA_SEL		GENMASK(3, 0)
 
+#define AXI_DAC_CHAN_CNTRL_MAX			15
 #define AXI_DAC_RD_ADDR(x)			(BIT(7) | (x))
 
 /* 360 degrees in rad */
@@ -186,6 +187,9 @@ static int __axi_dac_frequency_get(struct axi_dac_state *st, unsigned int chan,
 	u32 reg, raw;
 	int ret;
 
+	if (chan > AXI_DAC_CHAN_CNTRL_MAX)
+		return -EINVAL;
+
 	if (!st->dac_clk) {
 		dev_err(st->dev, "Sampling rate is 0...\n");
 		return -EINVAL;
@@ -230,6 +234,9 @@ static int axi_dac_scale_get(struct axi_dac_state *st,
 	int ret, vals[2];
 	u32 reg, raw;
 
+	if (chan->channel > AXI_DAC_CHAN_CNTRL_MAX)
+		return -EINVAL;
+
 	if (tone_2)
 		reg = AXI_DAC_CHAN_CNTRL_3_REG(chan->channel);
 	else
@@ -264,6 +271,9 @@ static int axi_dac_phase_get(struct axi_dac_state *st,
 	u32 reg, raw, phase;
 	int ret, vals[2];
 
+	if (chan->channel > AXI_DAC_CHAN_CNTRL_MAX)
+		return -EINVAL;
+
 	if (tone_2)
 		reg = AXI_DAC_CHAN_CNTRL_4_REG(chan->channel);
 	else
@@ -291,6 +301,9 @@ static int __axi_dac_frequency_set(struct axi_dac_state *st, unsigned int chan,
 	u16 raw;
 	int ret;
 
+	if (chan > AXI_DAC_CHAN_CNTRL_MAX)
+		return -EINVAL;
+
 	if (!sample_rate || freq > sample_rate / 2) {
 		dev_err(st->dev, "Invalid frequency(%u) dac_clk(%llu)\n",
 			freq, sample_rate);
@@ -342,6 +355,9 @@ static int axi_dac_scale_set(struct axi_dac_state *st,
 	u32 raw = 0, reg;
 	int ret;
 
+	if (chan->channel > AXI_DAC_CHAN_CNTRL_MAX)
+		return -EINVAL;
+
 	ret = iio_str_to_fixpoint(buf, 100000, &integer, &frac);
 	if (ret)
 		return ret;
@@ -385,6 +401,9 @@ static int axi_dac_phase_set(struct axi_dac_state *st,
 	u32 raw, reg;
 	int ret;
 
+	if (chan->channel > AXI_DAC_CHAN_CNTRL_MAX)
+		return -EINVAL;
+
 	ret = iio_str_to_fixpoint(buf, 100000, &integer, &frac);
 	if (ret)
 		return ret;
@@ -493,6 +512,9 @@ static int axi_dac_data_source_set(struct iio_backend *back, unsigned int chan,
 {
 	struct axi_dac_state *st = iio_backend_get_priv(back);
 
+	if (chan > AXI_DAC_CHAN_CNTRL_MAX)
+		return -EINVAL;
+
 	switch (data) {
 	case IIO_BACKEND_INTERNAL_CONTINUOUS_WAVE:
 		return regmap_update_bits(st->regmap,
@@ -521,6 +543,8 @@ static int axi_dac_set_sample_rate(struct iio_backend *back, unsigned int chan,
 	unsigned int freq;
 	int ret, tone;
 
+	if (chan > AXI_DAC_CHAN_CNTRL_MAX)
+		return -EINVAL;
 	if (!sample_rate)
 		return -EINVAL;
 	if (st->reg_config & AXI_DAC_CONFIG_DDS_DISABLE)

-- 
2.49.0


