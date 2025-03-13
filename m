Return-Path: <linux-iio+bounces-16759-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7CFA5E957
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 02:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06B087AAF45
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 01:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB9B1C84CD;
	Thu, 13 Mar 2025 01:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vtf8/d2v"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833CA1C84D6
	for <linux-iio@vger.kernel.org>; Thu, 13 Mar 2025 01:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741828595; cv=none; b=pCoTCiw/0VMcj+ZvkiKcZ3UdY7ofddEW1aBZrLx68Xt+z837xQxbF4twrZK058e5LCXaNY3sXFyaIv/wRLE5s0V7tWXtqcNk3ZpjTtCER5LM2RVQEV6M7ftnZgrjVJ2Tneoo9BdL+z2ZRjR7+WMpeaji3plZBTXxwNfP/LuSks4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741828595; c=relaxed/simple;
	bh=akEsK+MydePNjGNlqt6JoBX9UovhB+AF09zT7VtsUh4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OZyjuDndau5+2/W/2gF132aVuoOih4ho/mc6pbpUkMtYN2rcb720NkJg02o941zmG3NLStRUqMao32HcAd2TTRzeZWTvWj6InbNZSHJbjgpiULy3Fvl9Fgp0Amf3u0tMNdhug0rQitlbqpqZ6nxV/oqyMSZeuryidvQG0M+NMQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vtf8/d2v; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5fe8759153dso167138eaf.1
        for <linux-iio@vger.kernel.org>; Wed, 12 Mar 2025 18:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741828592; x=1742433392; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xUFLaRcDCA7FCvRbsTh4BbCfT/fIUbX2SqbhdxolA8A=;
        b=vtf8/d2v7gcv0EEmfw0up2a01tVqN87zFTOwYl3mqgVnhkE+3ay/wU7fgiOyQrGuUX
         tPBY5xd3xE0hh5mVmhHCgnt1F70h21B/Ajz87S8XNvLJDOKIkqUDZCUBL4saBGsg6jy5
         Udw7bMExedbr/RNehhspQ/qHIx1xu4wh4G0cefw5qLRP+DdOrN+raLP3A8xFhMotCFmM
         c5P/z+Rm5NMdP09cjdgvK0oADNiDgxrUIR8pIHAOMho5GVyd+9kf0eugPydm8FzwL8t3
         Nnx84N3R768TrGBrNQwFPr5FNo3be3eCKPRmMm0uXo63SmTOfwqCRG2VpLfZMVgreTum
         MpzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741828592; x=1742433392;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xUFLaRcDCA7FCvRbsTh4BbCfT/fIUbX2SqbhdxolA8A=;
        b=Xt1UyeV4JcbbxaqNLDyliau4odHi0akjYgYK/yqtpAJXUIaL/y4bKfKS6VfRtdrrXl
         qfT4nJkbFfOcIw51xtcb7AEjvGwgWJS12SwP/JCICxGB4KSIio93IUVPnMxtIB99TByS
         Vd4z93vQMnaN3ZUpnlOMdZWi+S7uBbxS293P1ONexirLuKObmJ27bGUKxSErf5rZw1J+
         u8WOejb95uJowujNhWCn7p/J76YYdnFQ0RqrK844gtFriI4BqLm53catdnHStj55VG1h
         j9EuY3VS10eA7r8jOBJkaf1zHLLKPbHLLQ8GQvb2Bd9hIKJkPb0x7QJYDLWmwqBwjFeW
         dcwg==
X-Forwarded-Encrypted: i=1; AJvYcCVzBko8lkkDRhHFDEVqf4oa68KrKkQQOmSB18gjVGUb32MT9cnaE2qEfnbL25dyeG8SFnyhd7gY2tQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRa+CSXb2OP1wNt40zqmUMJoZHllF7+eFZ6SvIDb61FKalFnSJ
	iLaf8vIQxp4s5nWf8iF0CA4I2YGOtBoRGFNnLjTsYeVdfTGh1fIOHk36L2y2sd8TiCUnLtiUAeG
	UbVY=
X-Gm-Gg: ASbGnctFzdALCC6Ip8h6z7fp/7MupMbkki8qtsxQOFS8FGF9jPkOVdX65VW7nW/iCY1
	ou8zaWrMl7nUVmmjX/MdHiG21qrQYma7bIV1YYWeBpGrGW+8/yBDaJCcKalToyUur0oGBYycEuN
	YQ0DJs6RODvUpB9Jg1nR51RuDG0GwDg36MTCld5EBykrGYXdbL3XWWCFCUe08o7dj5FBb6XeK56
	TG5M5VHSfi4ruQHut4NZMORVhY7FmEwDFpNxL2R9P4mWgLx3+LvRnlmQFP5Y+eSp65SYq9OQsjw
	SRamXHwoj5M1YhzffCZY81k/zRGzM4VaC4N30FGDuRHneFYvazKibW4v1yGwISdUkSDeAFINs3Y
	p
X-Google-Smtp-Source: AGHT+IHPAbMjLbwFvEUHWWDePQo9K4D2fvvx8k3LSqJizbYNQKiwaesPnVLjlDw6yL9xZpi1dagVuA==
X-Received: by 2002:a05:6820:2018:b0:5fe:87b7:40f5 with SMTP id 006d021491bc7-6004ab182bfmr9901604eaf.5.1741828592721;
        Wed, 12 Mar 2025 18:16:32 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-601db659ad8sm39865eaf.8.2025.03.12.18.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 18:16:31 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 12 Mar 2025 20:15:47 -0500
Subject: [PATCH 09/11] iio: adc: ad7606: drop ch param from
 ad7606_scale_setup_cb_t
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-iio-adc-ad7606-improvements-v1-9-d1ec04847aea@baylibre.com>
References: <20250312-iio-adc-ad7606-improvements-v1-0-d1ec04847aea@baylibre.com>
In-Reply-To: <20250312-iio-adc-ad7606-improvements-v1-0-d1ec04847aea@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Angelo Dureghello <adureghello@baylibre.com>, 
 Alexandru Ardelean <aardelean@baylibre.com>, 
 Beniamin Bia <beniamin.bia@analog.com>, 
 Stefan Popa <stefan.popa@analog.com>, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6245; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=akEsK+MydePNjGNlqt6JoBX9UovhB+AF09zT7VtsUh4=;
 b=owEBgwJ8/ZANAwAKAR+K+IyC93wDAcsmYgBn0jHbSdA21LPjEOVfB/II39YISFVEWJ9kdCgwZ
 U2LORYLwVSJAkkEAAEKADMWIQSKc9gqah9QmQfzc4gfiviMgvd8AwUCZ9Ix2xUcZGF2aWRAbGVj
 aG5vbG9neS5jb20ACgkQH4r4jIL3fAM4Wg/9GogO2kg8aWDf3/nkfhs8WL8I9wavPwayO3FRhmp
 M7yKC/CJ2eOXqugeWw+0m3Qn/Deb+lFP3EqL6bwTrFj6mHcHb0+0T8ZcH4ZQJtQafNtRsm/3wag
 YWKVVtI6fJ89cXPqdL+Qrj6KJR2+KrLd+j+zYGHtxRKi0527sYyrzm6BBF2uqn9sxiOwahyggl3
 T+QHchu00RCCV6ztOvX5YMPOYzJu1npa4Gc8ck5BQI5F96aRNRpY49nKkhSOobDh7YaV43MPrH6
 BlJNy+LC7tqScs1XERAKr6SD0K/d9CehPger5C6/m7Aaxx+elI6yZy4BbL/eb0dEfKaCY84gyNs
 fgP5VzowT130dubMdVvd04XScv2xRN9810kr+z7Xor+bLUvTBUgEYcgVE/lNcJuLA7Xg+WndIky
 PlQ5VX2CIcj1DSCW+udGh+0pXSWYx5hbRLNNa3vlFfDlvsuTqGYg0OWiNqoFG8w7cU92/LTEEfb
 0P788rauyOljoMYzKQzTAjiYeDuLGfrZSbo3NOmlZMTDXqRDB9AXWhwN7IDbewHChORPWdrJ8CH
 gyx2U7fHBB+0Al53yb5UCHDg86y5fVO3/Bz+uF4FOlwfy4Sxx3l4+5uM9KVCTs00ET0zzpEf5sK
 mD3p8uU8gCE5H2BtA+EkyTKZUWaDh3imu7VK8YgjyWK8=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Drop the ch parameter from the ad7606_scale_setup_cb_t functions. The
same info is already available from the chan param via chan->scan_type
and chan->channel, so the parameter is redundant.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 44 +++++++++++++++++++++++---------------------
 drivers/iio/adc/ad7606.h |  2 +-
 2 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 02ff4be3545d45f0e10bbea7251862f4e3daf97f..12871134b22f5ebcb66e9b57cefb8affa523685e 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -182,17 +182,17 @@ static const struct iio_chan_spec ad7616_channels[] = {
 };
 
 static int ad7606c_18bit_chan_scale_setup(struct iio_dev *indio_dev,
-					  struct iio_chan_spec *chan, int ch);
+					  struct iio_chan_spec *chan);
 static int ad7606c_16bit_chan_scale_setup(struct iio_dev *indio_dev,
-					  struct iio_chan_spec *chan, int ch);
+					  struct iio_chan_spec *chan);
 static int ad7606_16bit_chan_scale_setup(struct iio_dev *indio_dev,
-					 struct iio_chan_spec *chan, int ch);
+					 struct iio_chan_spec *chan);
 static int ad7607_chan_scale_setup(struct iio_dev *indio_dev,
-				   struct iio_chan_spec *chan, int ch);
+				   struct iio_chan_spec *chan);
 static int ad7608_chan_scale_setup(struct iio_dev *indio_dev,
-				   struct iio_chan_spec *chan, int ch);
+				   struct iio_chan_spec *chan);
 static int ad7609_chan_scale_setup(struct iio_dev *indio_dev,
-				   struct iio_chan_spec *chan, int ch);
+				   struct iio_chan_spec *chan);
 static int ad7616_sw_mode_setup(struct iio_dev *indio_dev);
 static int ad7606b_sw_mode_setup(struct iio_dev *indio_dev);
 
@@ -346,10 +346,10 @@ int ad7606_reset(struct ad7606_state *st)
 EXPORT_SYMBOL_NS_GPL(ad7606_reset, "IIO_AD7606");
 
 static int ad7606_16bit_chan_scale_setup(struct iio_dev *indio_dev,
-					 struct iio_chan_spec *chan, int ch)
+					 struct iio_chan_spec *chan)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
-	struct ad7606_chan_scale *cs = &st->chan_scales[ch];
+	struct ad7606_chan_scale *cs = &st->chan_scales[chan->scan_index];
 
 	if (!st->sw_mode_en) {
 		/* tied to logic low, analog input range is +/- 5V */
@@ -425,10 +425,10 @@ static int ad7606_get_chan_config(struct iio_dev *indio_dev, int ch,
 }
 
 static int ad7606c_18bit_chan_scale_setup(struct iio_dev *indio_dev,
-					  struct iio_chan_spec *chan, int ch)
+					  struct iio_chan_spec *chan)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
-	struct ad7606_chan_scale *cs = &st->chan_scales[ch];
+	struct ad7606_chan_scale *cs = &st->chan_scales[chan->scan_index];
 	bool bipolar, differential;
 	int ret;
 
@@ -439,7 +439,8 @@ static int ad7606c_18bit_chan_scale_setup(struct iio_dev *indio_dev,
 		return 0;
 	}
 
-	ret = ad7606_get_chan_config(indio_dev, ch, &bipolar, &differential);
+	ret = ad7606_get_chan_config(indio_dev, chan->scan_index, &bipolar,
+				     &differential);
 	if (ret)
 		return ret;
 
@@ -482,10 +483,10 @@ static int ad7606c_18bit_chan_scale_setup(struct iio_dev *indio_dev,
 }
 
 static int ad7606c_16bit_chan_scale_setup(struct iio_dev *indio_dev,
-					  struct iio_chan_spec *chan, int ch)
+					  struct iio_chan_spec *chan)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
-	struct ad7606_chan_scale *cs = &st->chan_scales[ch];
+	struct ad7606_chan_scale *cs = &st->chan_scales[chan->scan_index];
 	bool bipolar, differential;
 	int ret;
 
@@ -496,7 +497,8 @@ static int ad7606c_16bit_chan_scale_setup(struct iio_dev *indio_dev,
 		return 0;
 	}
 
-	ret = ad7606_get_chan_config(indio_dev, ch, &bipolar, &differential);
+	ret = ad7606_get_chan_config(indio_dev, chan->scan_index, &bipolar,
+				     &differential);
 	if (ret)
 		return ret;
 
@@ -540,10 +542,10 @@ static int ad7606c_16bit_chan_scale_setup(struct iio_dev *indio_dev,
 }
 
 static int ad7607_chan_scale_setup(struct iio_dev *indio_dev,
-				   struct iio_chan_spec *chan, int ch)
+				   struct iio_chan_spec *chan)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
-	struct ad7606_chan_scale *cs = &st->chan_scales[ch];
+	struct ad7606_chan_scale *cs = &st->chan_scales[chan->scan_index];
 
 	cs->range = 0;
 	cs->scale_avail = ad7607_hw_scale_avail;
@@ -552,10 +554,10 @@ static int ad7607_chan_scale_setup(struct iio_dev *indio_dev,
 }
 
 static int ad7608_chan_scale_setup(struct iio_dev *indio_dev,
-				   struct iio_chan_spec *chan, int ch)
+				   struct iio_chan_spec *chan)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
-	struct ad7606_chan_scale *cs = &st->chan_scales[ch];
+	struct ad7606_chan_scale *cs = &st->chan_scales[chan->scan_index];
 
 	cs->range = 0;
 	cs->scale_avail = ad7606_18bit_hw_scale_avail;
@@ -564,10 +566,10 @@ static int ad7608_chan_scale_setup(struct iio_dev *indio_dev,
 }
 
 static int ad7609_chan_scale_setup(struct iio_dev *indio_dev,
-				   struct iio_chan_spec *chan, int ch)
+				   struct iio_chan_spec *chan)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
-	struct ad7606_chan_scale *cs = &st->chan_scales[ch];
+	struct ad7606_chan_scale *cs = &st->chan_scales[chan->scan_index];
 
 	cs->range = 0;
 	cs->scale_avail = ad7609_hw_scale_avail;
@@ -1305,7 +1307,7 @@ static int ad7606_chan_scales_setup(struct iio_dev *indio_dev)
 	indio_dev->channels = chans;
 
 	for (ch = 0; ch < st->chip_info->num_adc_channels; ch++) {
-		ret = st->chip_info->scale_setup_cb(indio_dev, &chans[ch + offset], ch);
+		ret = st->chip_info->scale_setup_cb(indio_dev, &chans[ch + offset]);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index f6a6c89dbdc708f4e25e3c9ade9e9e614a7f99b1..fd4c0d615a880ac6fdcaad213d4843329c3bd7fe 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -113,7 +113,7 @@
 struct ad7606_state;
 
 typedef int (*ad7606_scale_setup_cb_t)(struct iio_dev *indio_dev,
-				       struct iio_chan_spec *chan, int ch);
+				       struct iio_chan_spec *chan);
 typedef int (*ad7606_sw_setup_cb_t)(struct iio_dev *indio_dev);
 
 /**

-- 
2.43.0


