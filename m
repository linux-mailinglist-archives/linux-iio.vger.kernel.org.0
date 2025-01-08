Return-Path: <linux-iio+bounces-14026-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F182A06365
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 18:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B68E33A60AF
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 17:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE96A200BA2;
	Wed,  8 Jan 2025 17:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="H4nT60Fc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA301F2C5D
	for <linux-iio@vger.kernel.org>; Wed,  8 Jan 2025 17:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736357435; cv=none; b=D4Gw+t91FpQQDlIB3h/XAgYg0kuukpMY7OGS64pGRQzU8nlNsyA6SywbT95V/7ZqUFKmSEbJPWmzf+jxdiw65Prw9hcPbfE3ks9eF8RYBddgTr3/jWT6K4USltuenTbEvksSVUWyXBqHxESkGVALSV06nRjiOgAI6XzXXLP9tcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736357435; c=relaxed/simple;
	bh=Evy5a08Q4IXyCPvxw1bhzoqYCioL8eNF759RXajKvAk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EDbOddVo18LSdja9p+l8iFVPVa0GhKKh3Z1lGhI15jKJR6iqg+vMDkcgDnnAp1ACWbw/9R7BkwWsnuF/6ccbXWRQlt+Xokzo+BG692DxTOWzN44uCHV+mCpQuVTh8Bl1Tn08gda4Cz/j0MMxo+KprJVUdD3bvqx6U37edB6Hfa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=H4nT60Fc; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-385dece873cso27261f8f.0
        for <linux-iio@vger.kernel.org>; Wed, 08 Jan 2025 09:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736357432; x=1736962232; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MISweJ7mhpf3vsy2x6Aiv1b3ZxOcL3WBro7kZl0BFxk=;
        b=H4nT60FcxFbPJ+o2W2BZbnCUbmDX0a9vZNUxrguCctO1zNjrGnkIDoqNP9ptUs9Zke
         gUNwSLmgjpFijmyCFZhkCdeGnveaArZR/hXHr6BqC8hSlNqlBzNcis9Mk8vDPBMWIBkK
         RjAwZ5KR3zSU/kyNNbrJETcWfs/nKCt+bKVu30J3sgO8vrSq7ZB6MCaP/X5G0DlihBIS
         CLJ4MWqcFIa6h/7eazvJ9veoD8r3akP38r/+kuEXI0v276+aqjCjGm28b9/4L7KidHa0
         rOBBewmuB+cAAYbcxZQuFFpyQDkGO19w1Xzh0xjNTGHkjt/h2ZK3KjLwECWJKYkfAPi1
         H1Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736357432; x=1736962232;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MISweJ7mhpf3vsy2x6Aiv1b3ZxOcL3WBro7kZl0BFxk=;
        b=t9TfI21b/8quggnAbagdAfriWqFOVu4hfTFueGmBMdMIsPpiHPB33czpnhYqscCNIu
         liuoA07Ohc9+mZ+eQmuHtKoCNWQ3yc9mJih1PJTSfEtLq/dlnzPYHclGz3x3G8L0OODp
         3y9PURxT/+eNM0c6rOFUMVYwvw0vzfXr730hjO3y9OhI6snSUE38a20sTVocLncrkYDR
         PUdYHR9+69tnl+JShYSWE59MkQfWuoi9eseJC7Q3is024bhv9ubeE1PV+uGDzJ5dJ33Y
         McHCXzp06KZSdb79jyQd3ejq9mRnpRb0tuUR5O4imqdQP6cmamMUnJYJ/R86lGoA+r4b
         ocwg==
X-Forwarded-Encrypted: i=1; AJvYcCUGuTvsqIeEjxdcA77C8iTIrZXB7TlNJKwmzlsf/9K1Bqm5k4ari6awMv2oz+FbjOEn7VSX4UhDmeU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq7d/NOazFPdbswIP035aKei9RYmnXDdYz3r8mH9BQIO89GPS3
	YQmE0GISG3Xrx0Ws5iVWiG6ekE5foA0g0+6IlvjMHuD1O7XCIbsyu92oKoOidkg=
X-Gm-Gg: ASbGncvPIZGXUybZ/Y4xErdbUHI4m2Ai11u2oRT2Gztvnwx0uHTF26ehbW/88F7+uUl
	0lno1wKt9K1rRiTqrf+ErC2pE+Q3v6oqeAlx90UE1zfOgIv56V/+/22tRlt/m3Npnh63EISvB0D
	lhm63fKx7GkqcG5g/ia4rTXea1pSE6HrH0DkbtmBu/NWzSJsCYeRDHlGY2+5Rf1amRQUEpqcmHP
	ZyVirYqy5xQWWcOC4xUJqQqp5J9BqbryWbBUfSjaMKDdXCoeGCbVOIEplk=
X-Google-Smtp-Source: AGHT+IHDamTzJpW3qPznX5EYK5GRfDPlH2hpAKWLJ73AVRWe7y5yhqi8Rjxz3mXkBuFV8JrxR91qGw==
X-Received: by 2002:a5d:648a:0:b0:38a:4b8a:e47d with SMTP id ffacd0b85a97d-38a8730ac0emr2930329f8f.26.1736357431699;
        Wed, 08 Jan 2025 09:30:31 -0800 (PST)
Received: from [127.0.1.1] ([87.13.70.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8330d4sm52782599f8f.29.2025.01.08.09.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 09:30:31 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Wed, 08 Jan 2025 18:29:15 +0100
Subject: [PATCH v2 1/9] iio: dac: ad3552r-common: fix ad3541/2r ranges
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-1-2dac02f04638@baylibre.com>
References: <20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-0-2dac02f04638@baylibre.com>
In-Reply-To: <20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-0-2dac02f04638@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Mihail Chindris <mihail.chindris@analog.com>, Nuno Sa <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>
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


