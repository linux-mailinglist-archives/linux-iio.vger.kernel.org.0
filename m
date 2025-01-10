Return-Path: <linux-iio+bounces-14088-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6D6A08DE2
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2025 11:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED3803A7874
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2025 10:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED5A20B81B;
	Fri, 10 Jan 2025 10:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FbHN+Yyd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B465E20B1E9
	for <linux-iio@vger.kernel.org>; Fri, 10 Jan 2025 10:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736504752; cv=none; b=hIEqoZS9Zl+p9j2wAdFmHUjVpXy3pSu3i/Weth8huh+IaVfg09ixDOzf1tejH8faDc1q2nyvtSj2El5GkiU+pC2dTQgdGfbJVGaDKpLmDjzShtbZyRo/RCrI84KGVYXn7tsuokWgolmTHl427e/aNN68/5krUr7GMS+d49AJjMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736504752; c=relaxed/simple;
	bh=BU8usK5hfPm4w0lU+vwnmS92dSAjZsWnIkUPfiLZiok=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uJlgLSMaK44u6Tf3hVnA1gGMXHDz8kLHTNbpMq9H4PmV99WmMJoHnlECkTmFTAiFo/tVZnWOa0triuBbgWZZJBCtLi1LsU627hObDJjPbOdKQhmJHwcz3xMxPqAlDAxjsnvguwkYak+VuU+sbWwx87yybQXr3xeylEUK5CArJc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FbHN+Yyd; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3863703258fso1927317f8f.1
        for <linux-iio@vger.kernel.org>; Fri, 10 Jan 2025 02:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736504748; x=1737109548; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LTzMiHBO+Ydh4211xpRKGTzEHCkmIaaesvGZwqEp6FU=;
        b=FbHN+YydoS7KqxUzvrG/7bEYyMaiJ7LtvKDBEE6XuSNWVaqcpacyNZmyLVZN2znuNU
         AYNyzhVUOERojTPvODoZ4y+5MaIo4TTerNSb2v9KAz33fUz2Kf4WOt1dw92yNWXhCfNH
         fL6WXPSfJ6X0hwTTiutUAUbPNzb3mhFMVC9+UQ4ic9EPRl3uOyOEQjsHnjCO18Sii4zB
         xSUqvqjdTZb4AcQJVKH6m+DCUz3CAC4M4gDTRwWRlfrZyS9bGD1Mney0X81VUytzKI+T
         6SVStyDTx3ZpgV8aRCTLXdR/0ullhbGg6b02JABQmd8GZUSvmxtBnyLpr2kQr63SXNfn
         lMnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736504748; x=1737109548;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LTzMiHBO+Ydh4211xpRKGTzEHCkmIaaesvGZwqEp6FU=;
        b=JXllkRGixLEODWhWvIf1dVgyF5y2sXI6sRAmAxvh30Nt6vWlyJ+ABbJ5CPu7QngrjR
         1Or7+SVBYO/vfVoy195wQ0UFqHA7obyLEjmJukclg9iXt1JiMRA+1zSMHlSaP5+LQ5N7
         Y7QsMXAZKD8s2W3x3iWFDi3UCl5LEwCZ7/hYcWz3f3VZZRA+racVEhy9s9tyl04n2/1u
         viZiHMyn1/2zwQcjSmcCn1VynaiNcySFqwNjX1LNHKl2R+dA8iZ7jDnwdh3leTxk8ffB
         abH36hquz666Xgx3aDip4bCNl4yeJv6lbL92OhBe6xeVn6/OltIAEz56YcL4YBoXpKY3
         fNRw==
X-Forwarded-Encrypted: i=1; AJvYcCVSp00XJUMGRRlQmcyBqJ/oAPBlYUm/HEWAwq0Ws4u7YueMRY/GiG3aFG0Ncqm2mWV67gMgNJRzM0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzggHg479tFPm5Y4pdaQIe4uqbJUoBAlzVZ7EcTm8MwtJf/qewm
	ebjHp2wOczwPdMq2ogYCOwhSCKFrjhz6GG2pyMI1Syu1yLYJLg4NviOkpIt40cs=
X-Gm-Gg: ASbGnctvQTTXrm86jaKlXsfj/SO4hvC3PJnMI8ll9hEBR1hRMe99FG/aBm3gwjrX5Wu
	2Cgl6FpGNtySlh8hPxYsEuoPp/5dPj4TnMAl2TwsEh02o6yhD7UTNbG0YQZ+6b6v4KqPgffJXj0
	2pYWK9uxBqV4RLPrgwYVUVfSaHZZUPXfaNOJ/z2z3owB1H4uRtgHd3umbh1J3ahdfA5pQsOHb/5
	wYAeIJmD5GT6R96em46W+WfI0qTxjJ1U1lH3C6iM4uoYPDCYEv2WfC8cPc=
X-Google-Smtp-Source: AGHT+IF+TvdLKJqiFKbCKWWoktZaPfZ/8uKZuWN2qtyGhWJ4PS0vvIbOvdfel9z+Fck1EgMS2G9Mew==
X-Received: by 2002:a05:6000:4026:b0:386:3c2f:a3e7 with SMTP id ffacd0b85a97d-38a8b0b7fdcmr5660709f8f.3.1736504748107;
        Fri, 10 Jan 2025 02:25:48 -0800 (PST)
Received: from [127.0.1.1] ([87.13.70.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e37d085sm4246430f8f.13.2025.01.10.02.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 02:25:47 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Fri, 10 Jan 2025 11:24:13 +0100
Subject: [PATCH v3 1/9] iio: dac: ad3552r-common: fix ad3541/2r ranges
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-1-ab42aef0d840@baylibre.com>
References: <20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-0-ab42aef0d840@baylibre.com>
In-Reply-To: <20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-0-ab42aef0d840@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Nuno Sa <nuno.sa@analog.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

Fix ad3541/2r voltage ranges to be as per ad3542r datasheet,
rev. C, table 38 (page 57).

The wrong ad354xr ranges was generating erroneous Vpp output.

In more details:
- fix wrong number of ranges, they are 5 ranges, not 6,
- remove non-existent 0-3V range,
- adjust order, since ad3552r_find_range() get a wrong index,
  producing a wrong Vpp as output.

Retested all the ranges on real hardware, EVALAD3542RFMCZ:

adi,output-range-microvolt (fdt):
<(000000) (2500000)>;   ok (Rfbx1, switch 10)
<(000000) (5000000)>;   ok (Rfbx1, switch 10)
<(000000) (10000000)>;  ok (Rfbx1, switch 10)
<(-5000000) (5000000)>; ok (Rfbx2, switch +/- 5)
<(-2500000) (7500000)>; ok (Rfbx2, switch -2.5/7.5)

Fixes: 8f2b54824b28 ("drivers:iio:dac: Add AD3552R driver support")
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/ad3552r-common.c | 5 ++---
 drivers/iio/dac/ad3552r.h        | 8 +++-----
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/dac/ad3552r-common.c b/drivers/iio/dac/ad3552r-common.c
index 0f495df2e5ce..03e0864f5084 100644
--- a/drivers/iio/dac/ad3552r-common.c
+++ b/drivers/iio/dac/ad3552r-common.c
@@ -22,11 +22,10 @@ EXPORT_SYMBOL_NS_GPL(ad3552r_ch_ranges, "IIO_AD3552R");
 
 const s32 ad3542r_ch_ranges[AD3542R_MAX_RANGES][2] = {
 	[AD3542R_CH_OUTPUT_RANGE_0__2P5V]	= { 0, 2500 },
-	[AD3542R_CH_OUTPUT_RANGE_0__3V]		= { 0, 3000 },
 	[AD3542R_CH_OUTPUT_RANGE_0__5V]		= { 0, 5000 },
 	[AD3542R_CH_OUTPUT_RANGE_0__10V]	= { 0, 10000 },
-	[AD3542R_CH_OUTPUT_RANGE_NEG_2P5__7P5V]	= { -2500, 7500 },
-	[AD3542R_CH_OUTPUT_RANGE_NEG_5__5V]	= { -5000, 5000 }
+	[AD3542R_CH_OUTPUT_RANGE_NEG_5__5V]	= { -5000, 5000 },
+	[AD3542R_CH_OUTPUT_RANGE_NEG_2P5__7P5V]	= { -2500, 7500 }
 };
 EXPORT_SYMBOL_NS_GPL(ad3542r_ch_ranges, "IIO_AD3552R");
 
diff --git a/drivers/iio/dac/ad3552r.h b/drivers/iio/dac/ad3552r.h
index fd5a3dfd1d1c..4b5581039ae9 100644
--- a/drivers/iio/dac/ad3552r.h
+++ b/drivers/iio/dac/ad3552r.h
@@ -131,7 +131,7 @@
 #define AD3552R_CH1_ACTIVE				BIT(1)
 
 #define AD3552R_MAX_RANGES	5
-#define AD3542R_MAX_RANGES	6
+#define AD3542R_MAX_RANGES	5
 #define AD3552R_QUAD_SPI	2
 
 extern const s32 ad3552r_ch_ranges[AD3552R_MAX_RANGES][2];
@@ -189,16 +189,14 @@ enum ad3552r_ch_vref_select {
 enum ad3542r_ch_output_range {
 	/* Range from 0 V to 2.5 V. Requires Rfb1x connection */
 	AD3542R_CH_OUTPUT_RANGE_0__2P5V,
-	/* Range from 0 V to 3 V. Requires Rfb1x connection  */
-	AD3542R_CH_OUTPUT_RANGE_0__3V,
 	/* Range from 0 V to 5 V. Requires Rfb1x connection  */
 	AD3542R_CH_OUTPUT_RANGE_0__5V,
 	/* Range from 0 V to 10 V. Requires Rfb2x connection  */
 	AD3542R_CH_OUTPUT_RANGE_0__10V,
-	/* Range from -2.5 V to 7.5 V. Requires Rfb2x connection  */
-	AD3542R_CH_OUTPUT_RANGE_NEG_2P5__7P5V,
 	/* Range from -5 V to 5 V. Requires Rfb2x connection  */
 	AD3542R_CH_OUTPUT_RANGE_NEG_5__5V,
+	/* Range from -2.5 V to 7.5 V. Requires Rfb2x connection  */
+	AD3542R_CH_OUTPUT_RANGE_NEG_2P5__7P5V,
 };
 
 enum ad3552r_ch_output_range {

-- 
2.47.0


