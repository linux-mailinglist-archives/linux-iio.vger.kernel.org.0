Return-Path: <linux-iio+bounces-14355-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E26B9A10ADF
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2025 16:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEC953A8EDA
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2025 15:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5801715746B;
	Tue, 14 Jan 2025 15:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2FComeN8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08D88488
	for <linux-iio@vger.kernel.org>; Tue, 14 Jan 2025 15:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736868711; cv=none; b=FlSuI7VlVk6/gKtCLr1LxWANNl1YYMHgQUsXIZ5v79Vk2DdSzjGuD43CpexikdvJ0F/Oo4ulW3caAzkJ0071EkMzmc7o+gW5x+QL6pQ7cCXysAukNfoZn517bnxztFxlV6dp00tW/EOAZsvyb+GuhWWAp/UVRCT3ntvLl8Q2hXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736868711; c=relaxed/simple;
	bh=pqyr7lB2YlEjhkiVyE7jHiA6cFUHvqgoHwiJXFTx2Ys=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n5faDzp3NaAq6J5Zi6avgOcbN5rls4rphJJtMTIW7PiyfL3UxSpELtILvHNml9XaU6OG0lESKsaDTGbPLHhvfZ0LYml4b+UnGnH3JbFZEfWq4ObVYPEK3hztwDxpdfVtrjLsBn8nNf2KcBMpIMQ9SlO4F8xnqWpGzwJBLHFwXhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2FComeN8; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-385e06af753so2871309f8f.2
        for <linux-iio@vger.kernel.org>; Tue, 14 Jan 2025 07:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736868706; x=1737473506; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M1ZK1w7swUyQuLFjvZaL7bfwG8xysBkjwjJzs0AMUFQ=;
        b=2FComeN8pPywh+irUsHDr/YwuN5JgkPNtnzgGY2+i5jmWe+GiL/vuXdquK/h0c5PTi
         euwPNo5OjfJEQ06MofXOKrxmPif6I6ZN9M060RM3b3y0oNBvhxsiP3JeYKDmovYBCHaC
         bbmYWvTr2fWaIkrFpdPWvLSNKzGPQMYzWTLzbe9gXGvS2VAeb+7vJh+hqTu9h524X/mv
         RdXm2wcjAKyFAgc1CZNK7HTyn9hxnXhkSX8g/cqCZb6KtmJ+JvfCBniFfZQ97WCWZSx5
         Mlvx3KEo3FhJTuWybdZe9afB4Y9ef8rMfFTIXRqlbzTMiJkx8chDNheMlA2qGsnaZcLU
         GCYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736868706; x=1737473506;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M1ZK1w7swUyQuLFjvZaL7bfwG8xysBkjwjJzs0AMUFQ=;
        b=s3MIisWvspuf3Sp4HXARxgUxCUTF6MWodVODWc7/MlWNCPxT3aM2bjkip5IWPC0aWf
         ZKhC51mWZgmZZV4ImSZEi++ZKwemojuJJoRNcGTcq5JJ3JKpdM6s3JHMsQwXNS7xJtRy
         nQ2wqA6b3BF5HaaZxQiCxsALoc8wLUjtcRxb7up2BGMB5+FawTO9erTATmct+R2+XBNh
         zogJ1HYkP1MM6jNuCnuJ3zGab2JahRj+QsBwS5nM4FhPGl1T7tA0Xt73v5iHh/yobe0+
         qKLEkv/0UeB+dJpdQGYLdhqLG8o/3nlziwfgEZW9su2auvXaXRNubLc6iZzplHmnyuL3
         4OVw==
X-Forwarded-Encrypted: i=1; AJvYcCVLJBrF2qirqBsapJgaVFglWkkywH5PicUpaJDsRYiBI+8LnJAIf6gc7IzbA9Nqjd/HgYPWABpiddI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiHnDZCp2hFChQjYojRVyMU/oBURbPp5AGWMmcjXd8Lzl2yXId
	9xFnAOpo7ydBVXwhw/vX3lZ3ZWfdVMnaROBu7zF8gIVoXnjtKSx+eBPxTt9KsbU=
X-Gm-Gg: ASbGnctGFdKVC4MkAI0+2I9PuNttKe880FZ5jnmmu2btfAwO4xVzLue20RrLDxvxQEh
	1ZJ2MeBd9X/n8o71QVOZCdJNwhLGrOshT0XiKae1EnfqEj4t/F7Lavw22bacoiCUZg8EhSm/CXp
	+2blfo2nODovTh/Ivv28Gxx8Uwe84OzZGf8+UPUqy8mLA6sdzqgHCgV+MM4NiwoVaR46hDOzJyR
	e57M+5o005ln4M17uPriazMgi3vcIEuBrR9afAaXbfCCYhf4IyoECds6GI=
X-Google-Smtp-Source: AGHT+IGUfVVhHPPVS2cv9/nifIYxojUhr8Wg6b+On+7nFINLHTVHlstooWa0UcWalyJD5136uQ5tlQ==
X-Received: by 2002:a5d:6da8:0:b0:38a:5ce8:df51 with SMTP id ffacd0b85a97d-38a872f7ef2mr22563413f8f.2.1736868704441;
        Tue, 14 Jan 2025 07:31:44 -0800 (PST)
Received: from [127.0.1.1] ([87.13.70.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4b8116sm15049907f8f.79.2025.01.14.07.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 07:31:43 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Tue, 14 Jan 2025 16:30:10 +0100
Subject: [PATCH v4 1/9] iio: dac: ad3552r-common: fix ad3541/2r ranges
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250114-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v4-1-979402e33545@baylibre.com>
References: <20250114-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v4-0-979402e33545@baylibre.com>
In-Reply-To: <20250114-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v4-0-979402e33545@baylibre.com>
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
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
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


