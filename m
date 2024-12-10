Return-Path: <linux-iio+bounces-13305-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B989EAE83
	for <lists+linux-iio@lfdr.de>; Tue, 10 Dec 2024 11:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 592DF1886AC0
	for <lists+linux-iio@lfdr.de>; Tue, 10 Dec 2024 10:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A912080D8;
	Tue, 10 Dec 2024 10:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="W5OXeW03"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4A12080C7
	for <linux-iio@vger.kernel.org>; Tue, 10 Dec 2024 10:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733827609; cv=none; b=CPTqSIJriz8jxxyVKmL5jw/Y9cKBkU4qlvo0TzIJnp0xuEhNQsJDmHco4Aipr8x8o8OeWsS+wFBRAKdjuNd+nVC4v1HzIr6lvtCq9DI2EjG6f2ZXkqH0d8XrXEUPbbCIEjd93Uh8bQvBSQFD2wgqv2I1EOS3YsLc0vmIwYgYUAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733827609; c=relaxed/simple;
	bh=uS8y4KUjGGFp3SCGu9ptn+1rXRsn3b8FMwtrcYMWjdE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aIdclIML6ES0sjx+QyNSvpoebGeWnHDPZEUVl/RsKUp/XvJTkZHieA32WUBoLAiV3EdvWB2XBkjNSMpb5B1eFZcMHV00eYvn+CpcsXF/jlOhognDl+RvINNJNbMKtyZkEz+58RzEQ6a/eugfHs8st0qQsSIbzd7fYkUJJ893FPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=W5OXeW03; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-385dece873cso2557627f8f.0
        for <linux-iio@vger.kernel.org>; Tue, 10 Dec 2024 02:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733827605; x=1734432405; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ClLnB+cbi04gdhAJC+8T48pecpSeiMZUmRU/A+kfSVc=;
        b=W5OXeW034Evj0+mge19k5u7F+O02JJUPHaDVTuD2LDr00cfqIHVUgce/lVLYWBGuq5
         yFOiKe94mIy4LndyMWOXbHlOlrmnZvkUyzkKgfrga5HYCJvx8t8eO7Qv+ffMuUxjOeOI
         ceo3J4r9q0JUwCWM24mKAuB2M33SUowqpajKGAMny6N+WHkZs7F/eKLRc9LIxJeMajd3
         yVP0tYTi+x/XbOCUCEErGOOlH1NDfrzgpZOo7y9t4umKN9MFx+n5/fgUJkGeTbQTEr2T
         x2jKSsirXFeRKGPmsijCY6kZTI0JGs78bpsspkTYlNuEsD5TqJ0PzYU+nUgiVcpDDNv3
         SUNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733827605; x=1734432405;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ClLnB+cbi04gdhAJC+8T48pecpSeiMZUmRU/A+kfSVc=;
        b=bm7xpMVaNyxA5p1HHVf2Ol/kERmEcY9j5pMoCN4tt2ymyFEHFavDSIpleN55efuXPx
         v23cP4E7yAnqySnxE4ZfZPKrXY/4rvpp74ng0+r4SGPUedgn1GkRlgbPMwybJNW7r/3v
         BqUDTVHYk/7RM6EHdO18EuPVjAeH0byE6bE2zMCj38d+bOFp6gxDzuekRczTAwUT01QF
         w/Q4la0SpIR08wSxzTMWyR1sRH9elMWVW3TrVle2lTiDTZ2H3O/5NBe752O/5LpYxdBP
         L4ob4wY+nHPbq3fOoDm9Wzpe+SBH2KJlusF5/4A1yIedKFn0B22VIHwkxKxH+8JWMveZ
         BCVg==
X-Forwarded-Encrypted: i=1; AJvYcCWHTxI+7JqWQLDxzpNRu23kECJpOX1ZbRNhjfmxdCEUoM3S4BvPFGRiN5uqTApJqqASpDYiQ+bsKUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJKRwPrq8MBVAGrUs5Tj471b9aqlLa65c0fwJ8zSUiVS2MDhhM
	kcsGUr29Zu8CkMll6e6jD2mFrQ95gnQQUaKPUYVrW/hwQNGykOlf3/Us8BNrVvk=
X-Gm-Gg: ASbGncvypnBoAxowrDjw0jYvrwgvGefbz57xIwnOt8llfeuU4KpmpfqMjf5iHhR9FPG
	V9vh9R369AZ5qWoD5Pgygm0tzw4jLAGAVugYpIvjztZWx5crVtbIulMbx1J0PXYfPKNhIY8Txz0
	EW86Nl5zcL6G/FGFyVuW7+s4l2VLpbDpEH5PXAYbUVjZcFEKNfZ+x86j9i5c4888UCxdrMoxi8t
	t0xoQ6+cQqU945gx5P5OV6qHb8xBa2m1q+puviPzKttq6lJgr7571C4h3p7SrMtTnuMmxMenbrt
	vw==
X-Google-Smtp-Source: AGHT+IEvNG9eKB8z/U5t1enk5Oh8ZZGNoVReVi3dRyTC3QcJGhPiAAiO06JHmQbdibv9py/aITHp2w==
X-Received: by 2002:a5d:59a6:0:b0:385:edd1:2245 with SMTP id ffacd0b85a97d-3862b380f68mr10085762f8f.30.1733827605278;
        Tue, 10 Dec 2024 02:46:45 -0800 (PST)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434f2d08564sm94543645e9.12.2024.12.10.02.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 02:46:44 -0800 (PST)
From: Guillaume Stols <gstols@baylibre.com>
Date: Tue, 10 Dec 2024 10:46:41 +0000
Subject: [PATCH v2 1/9] iio: adc: ad7606: Fix hardcoded offset in the ADC
 channels
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-ad7606_add_iio_backend_software_mode-v2-1-6619c3e50d81@baylibre.com>
References: <20241210-ad7606_add_iio_backend_software_mode-v2-0-6619c3e50d81@baylibre.com>
In-Reply-To: <20241210-ad7606_add_iio_backend_software_mode-v2-0-6619c3e50d81@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Nuno Sa <nuno.sa@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 devicetree@vger.kernel.org, dlechner@baylibre.com, jstephan@baylibre.com, 
 aardelean@baylibre.com, adureghello@baylibre.com, 
 Guillaume Stols <gstols@baylibre.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733827603; l=7243;
 i=gstols@baylibre.com; s=20240417; h=from:subject:message-id;
 bh=uS8y4KUjGGFp3SCGu9ptn+1rXRsn3b8FMwtrcYMWjdE=;
 b=hkwg1GMUOnEH41vU+VyvTShCazCQ+ZNhx/qkEmZgI9x0hhmR0SzOugmDBLZ+0FhJWddgTdi96
 EvY0m0OxcoHDhUQskoHc6Yt/sYWaFYgwDzJuCl8b2yTX2TwI82d5ZHR
X-Developer-Key: i=gstols@baylibre.com; a=ed25519;
 pk=XvMm5WHuV67sGYOJZqIYzXndbaJOlNd8Q6li6vnb4Cs=

When introducing num_adc_channels, I overlooked some new functions
created in a meanwhile that had also the hardcoded offset. This commit
adds the new logic to these functions.

Fixes: 7a671afeb592 ("iio: adc: ad7606: Introduce num_adc_channels")
Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 48 ++++++++++++++++++++++++++++--------------------
 drivers/iio/adc/ad7606.h |  2 +-
 2 files changed, 29 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index e35d55d03d86..d8e3c7a43678 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -175,17 +175,17 @@ static const struct iio_chan_spec ad7616_channels[] = {
 	AD7606_CHANNEL(15, 16),
 };
 
-static int ad7606c_18bit_chan_scale_setup(struct ad7606_state *st,
+static int ad7606c_18bit_chan_scale_setup(struct iio_dev *indio_dev,
 					  struct iio_chan_spec *chan, int ch);
-static int ad7606c_16bit_chan_scale_setup(struct ad7606_state *st,
+static int ad7606c_16bit_chan_scale_setup(struct iio_dev *indio_dev,
 					  struct iio_chan_spec *chan, int ch);
-static int ad7606_16bit_chan_scale_setup(struct ad7606_state *st,
+static int ad7606_16bit_chan_scale_setup(struct iio_dev *indio_dev,
 					 struct iio_chan_spec *chan, int ch);
-static int ad7607_chan_scale_setup(struct ad7606_state *st,
+static int ad7607_chan_scale_setup(struct iio_dev *indio_dev,
 				   struct iio_chan_spec *chan, int ch);
-static int ad7608_chan_scale_setup(struct ad7606_state *st,
+static int ad7608_chan_scale_setup(struct iio_dev *indio_dev,
 				   struct iio_chan_spec *chan, int ch);
-static int ad7609_chan_scale_setup(struct ad7606_state *st,
+static int ad7609_chan_scale_setup(struct iio_dev *indio_dev,
 				   struct iio_chan_spec *chan, int ch);
 
 const struct ad7606_chip_info ad7605_4_info = {
@@ -323,9 +323,10 @@ int ad7606_reset(struct ad7606_state *st)
 }
 EXPORT_SYMBOL_NS_GPL(ad7606_reset, "IIO_AD7606");
 
-static int ad7606_16bit_chan_scale_setup(struct ad7606_state *st,
+static int ad7606_16bit_chan_scale_setup(struct iio_dev *indio_dev,
 					 struct iio_chan_spec *chan, int ch)
 {
+	struct ad7606_state *st = iio_priv(indio_dev);
 	struct ad7606_chan_scale *cs = &st->chan_scales[ch];
 
 	if (!st->sw_mode_en) {
@@ -345,10 +346,12 @@ static int ad7606_16bit_chan_scale_setup(struct ad7606_state *st,
 	return 0;
 }
 
-static int ad7606_get_chan_config(struct ad7606_state *st, int ch,
+static int ad7606_get_chan_config(struct iio_dev *indio_dev, int ch,
 				  bool *bipolar, bool *differential)
 {
-	unsigned int num_channels = st->chip_info->num_channels - 1;
+	struct ad7606_state *st = iio_priv(indio_dev);
+	unsigned int num_channels = st->chip_info->num_adc_channels;
+	unsigned int offset = indio_dev->num_channels - st->chip_info->num_adc_channels;
 	struct device *dev = st->dev;
 	int ret;
 
@@ -364,7 +367,7 @@ static int ad7606_get_chan_config(struct ad7606_state *st, int ch,
 			continue;
 
 		/* channel number (here) is from 1 to num_channels */
-		if (reg == 0 || reg > num_channels) {
+		if (reg < offset || reg > num_channels) {
 			dev_warn(dev,
 				 "Invalid channel number (ignoring): %d\n", reg);
 			continue;
@@ -399,9 +402,10 @@ static int ad7606_get_chan_config(struct ad7606_state *st, int ch,
 	return 0;
 }
 
-static int ad7606c_18bit_chan_scale_setup(struct ad7606_state *st,
+static int ad7606c_18bit_chan_scale_setup(struct iio_dev *indio_dev,
 					  struct iio_chan_spec *chan, int ch)
 {
+	struct ad7606_state *st = iio_priv(indio_dev);
 	struct ad7606_chan_scale *cs = &st->chan_scales[ch];
 	bool bipolar, differential;
 	int ret;
@@ -413,7 +417,7 @@ static int ad7606c_18bit_chan_scale_setup(struct ad7606_state *st,
 		return 0;
 	}
 
-	ret = ad7606_get_chan_config(st, ch, &bipolar, &differential);
+	ret = ad7606_get_chan_config(indio_dev, ch, &bipolar, &differential);
 	if (ret)
 		return ret;
 
@@ -455,9 +459,10 @@ static int ad7606c_18bit_chan_scale_setup(struct ad7606_state *st,
 	return 0;
 }
 
-static int ad7606c_16bit_chan_scale_setup(struct ad7606_state *st,
+static int ad7606c_16bit_chan_scale_setup(struct iio_dev *indio_dev,
 					  struct iio_chan_spec *chan, int ch)
 {
+	struct ad7606_state *st = iio_priv(indio_dev);
 	struct ad7606_chan_scale *cs = &st->chan_scales[ch];
 	bool bipolar, differential;
 	int ret;
@@ -469,7 +474,7 @@ static int ad7606c_16bit_chan_scale_setup(struct ad7606_state *st,
 		return 0;
 	}
 
-	ret = ad7606_get_chan_config(st, ch, &bipolar, &differential);
+	ret = ad7606_get_chan_config(indio_dev, ch, &bipolar, &differential);
 	if (ret)
 		return ret;
 
@@ -512,9 +517,10 @@ static int ad7606c_16bit_chan_scale_setup(struct ad7606_state *st,
 	return 0;
 }
 
-static int ad7607_chan_scale_setup(struct ad7606_state *st,
+static int ad7607_chan_scale_setup(struct iio_dev *indio_dev,
 				   struct iio_chan_spec *chan, int ch)
 {
+	struct ad7606_state *st = iio_priv(indio_dev);
 	struct ad7606_chan_scale *cs = &st->chan_scales[ch];
 
 	cs->range = 0;
@@ -523,9 +529,10 @@ static int ad7607_chan_scale_setup(struct ad7606_state *st,
 	return 0;
 }
 
-static int ad7608_chan_scale_setup(struct ad7606_state *st,
+static int ad7608_chan_scale_setup(struct iio_dev *indio_dev,
 				   struct iio_chan_spec *chan, int ch)
 {
+	struct ad7606_state *st = iio_priv(indio_dev);
 	struct ad7606_chan_scale *cs = &st->chan_scales[ch];
 
 	cs->range = 0;
@@ -534,9 +541,10 @@ static int ad7608_chan_scale_setup(struct ad7606_state *st,
 	return 0;
 }
 
-static int ad7609_chan_scale_setup(struct ad7606_state *st,
+static int ad7609_chan_scale_setup(struct iio_dev *indio_dev,
 				   struct iio_chan_spec *chan, int ch)
 {
+	struct ad7606_state *st = iio_priv(indio_dev);
 	struct ad7606_chan_scale *cs = &st->chan_scales[ch];
 
 	cs->range = 0;
@@ -1146,8 +1154,8 @@ static int ad7606_sw_mode_setup(struct iio_dev *indio_dev)
 
 static int ad7606_chan_scales_setup(struct iio_dev *indio_dev)
 {
-	unsigned int num_channels = indio_dev->num_channels - 1;
 	struct ad7606_state *st = iio_priv(indio_dev);
+	unsigned int offset = indio_dev->num_channels - st->chip_info->num_adc_channels;
 	struct iio_chan_spec *chans;
 	size_t size;
 	int ch, ret;
@@ -1161,8 +1169,8 @@ static int ad7606_chan_scales_setup(struct iio_dev *indio_dev)
 	memcpy(chans, indio_dev->channels, size);
 	indio_dev->channels = chans;
 
-	for (ch = 0; ch < num_channels; ch++) {
-		ret = st->chip_info->scale_setup_cb(st, &chans[ch + 1], ch);
+	for (ch = 0; ch < st->chip_info->num_adc_channels; ch++) {
+		ret = st->chip_info->scale_setup_cb(indio_dev, &chans[ch + offset], ch);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index 998814a92b82..8778ffe515b3 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -69,7 +69,7 @@
 
 struct ad7606_state;
 
-typedef int (*ad7606_scale_setup_cb_t)(struct ad7606_state *st,
+typedef int (*ad7606_scale_setup_cb_t)(struct iio_dev *indio_dev,
 				       struct iio_chan_spec *chan, int ch);
 
 /**

-- 
2.34.1


