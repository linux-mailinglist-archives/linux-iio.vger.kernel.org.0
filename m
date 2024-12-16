Return-Path: <linux-iio+bounces-13551-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DD49F3AF0
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2024 21:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 550BC16CF12
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2024 20:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFAC1D5144;
	Mon, 16 Dec 2024 20:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IiMequnD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255B81D4340
	for <linux-iio@vger.kernel.org>; Mon, 16 Dec 2024 20:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734381472; cv=none; b=LC04hRCZCL0bVl+ObNAg6epJAFgCJW82Vx7HVq0dxV0OQ7UqKR5j8WxBdToxwF58sBAD/ioRUhgoovtfbUcTjEIU7YIioBzUghT8A0Ne0QITHrnzIb8JqANUwkmLEExChj8G68BZ7ZgT1SqwLLleuawnABeG5UaGIP1VceFGmKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734381472; c=relaxed/simple;
	bh=fsCWVBl2aaJ7Rw7TFN9KYd/ZIN1YNZzpw8t5WXO3NGA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D3WYHnBh6KUcmfkrT1wv3AZXBsh4WuZJOh4Qq5panVoFdSYRoLNM3wMRjHOGau2AOEz0dWUBMZFnNkQA8nmNBFakKs8Z4h8bVqnQ6Hux1ySXnj0zlMLMxt4CLHcsXDHikGFn6cofutklZGfQOb+nJ0jkqjD4FVX6ytpYww1Fhug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=IiMequnD; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38633b5dbcfso4987112f8f.2
        for <linux-iio@vger.kernel.org>; Mon, 16 Dec 2024 12:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734381468; x=1734986268; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Juh7h407eRDEHSWqSLRr8xowgcij3T6Bt7sPrV5Jtk=;
        b=IiMequnD7pl62k68OeT9RaoqU2XQvDhmO8vDZChxM5GZJfX9T6Ujkngx8KHgPr1bPG
         /ZVHSXytdhshsNnJH9HcT5p+4h75ahnA6OtRjD4c9TbOffVhZ9pC9xiSvBY2/BezwzAW
         5XBxjexeAnGXaljlrNERDsmsf+6Ba109Uy3DYsvvoZ5QTkCqdR6eeeiAb5ANIFUyl14U
         omeldgyBHiFtgn2kKWkl4dykdh49xveUj/8KsTIPBdKl5leMBUKWD9LRzA8hx3yTRiQk
         xHMpTUHzXE7cl32pPzMuyXjg27Zt67gWqLg4Xxnd8kz6abxNKgHBMKfflKTh+resylvq
         K6zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734381468; x=1734986268;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Juh7h407eRDEHSWqSLRr8xowgcij3T6Bt7sPrV5Jtk=;
        b=XJ3A1Fyx9JNHqA3Lxanf0lzMmMy0JZ7m8427bnOSGLHTyq+sG1Heb1u/GiwCGOMQY2
         IeI3oLz2Y8ixfnEQhU1pdWPpJHXqe1iQFGiPHdHLw7B1DfQT5hPDRuPt+f25xg1RLSHX
         8reExoKP7W2xzdRTqJ6LAy3KLPlQZKbCXI6UK5JdPJVv637yeDbPuuOR7+84mRdlYX6A
         xua8l/w48q3xY5iX+HAissl2PSRC+RbTnvXnkTn+ND24Qu/yrrA9fk316PemdKKrWWIg
         0QdPLrKrMxf4UiyZ/aHrlYQ9UPjNUSvShueK4yE9pukTkgU7/49D47XUbon0ethF1icy
         ePjg==
X-Forwarded-Encrypted: i=1; AJvYcCWTHE/rUBykRoMhNYOzMHQ/0xJIrpH4bcE4Ws4BkQpIrHWiBeUZ1xxR0jty3Wn9PfTYghj68Q/9xWc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6b4S5XrgFtnkURzROU5dcr0rg7WC6kp1XWDAPWk0Srluds7pt
	lTWA1oxRCxU8r8bCt96HH6jyPHHmxSqCRZorwNhoi3pEPsTAa2uRWhoVj/zXbq4=
X-Gm-Gg: ASbGncsy+t3wvTWtQ0vgMrtIzg9+VSk0h+YrRZT7HIg0TqP1bC8kTrrczT4Ok454Me2
	ouPwwOyNQjYD94cczz4kzSWEboHlHb30EV8kXbbKgznFEVW7672Z/htP0MXxetFS1VPQlF7FHJW
	kT5cqQ8c9UuL2YcyoR4UmBq/ZtnHNi2/SlmSDj7XBeI+7kEcJHwG+TCOJDpl1Jr/OLDVOId9w1V
	6rqKN94KMJLwYphBc5GaSwZfLtbMFVyqVba/GuyvLql42Vl5CkS+uANeeR/anxaJdONr/GjpUL3
	zNMFh55kazHxdO0nexr3aSgVnADQ622uDw==
X-Google-Smtp-Source: AGHT+IEkpFkOfoc5PKARgk1ZNgu9iMGY03qwc/Xhq8eCKvrej8r9r0RlEFs9qPq/7HEytl7RqDu/4w==
X-Received: by 2002:a5d:64e9:0:b0:385:d7f9:f16c with SMTP id ffacd0b85a97d-3888e0b8761mr11510312f8f.46.1734381468461;
        Mon, 16 Dec 2024 12:37:48 -0800 (PST)
Received: from [127.0.1.1] (host-79-17-239-245.retail.telecomitalia.it. [79.17.239.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4363602b468sm95514245e9.11.2024.12.16.12.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 12:37:47 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Mon, 16 Dec 2024 21:36:21 +0100
Subject: [PATCH 1/8] iio: dac: ad3552r-common: fix ad3541/2r ranges
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-1-856ff71fc930@baylibre.com>
References: <20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-0-856ff71fc930@baylibre.com>
In-Reply-To: <20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-0-856ff71fc930@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Mihail Chindris <mihail.chindris@analog.com>, Nuno Sa <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

Fix ad3541/2r voltage ranges to be as per ad3542r datasheet,
rev. C, table 38 (page 57).

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


