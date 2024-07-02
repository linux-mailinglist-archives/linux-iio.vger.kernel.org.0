Return-Path: <linux-iio+bounces-7173-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F487924666
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 19:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A3CCB27684
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 17:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBDF1C8FA2;
	Tue,  2 Jul 2024 17:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JVOkIvJ+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64721BF330
	for <linux-iio@vger.kernel.org>; Tue,  2 Jul 2024 17:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719941652; cv=none; b=lalVRFNyVujZqGBfsfZC22SI3ww2e13p6a6bIOfBTlsfyPXhi0NnN8mXcgYHtAq8ejO6nYuc0AZpNhik0+MAgSAxrx9BI0VBtPQ1ia8NwNGLUkyTyu6YqPg9aRp6CyBIObz0PWMcyQnNHxkrKSeoVXENdLdCYj4O6GAZX/h8XPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719941652; c=relaxed/simple;
	bh=0vxKQkSBULjAJQGXdaLmNcvckFt2gVdVQfpVa/gC9hk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kuB2Zsrepl4WUlHy9MYxPbbWOcLr6/tFm3sINU3CXrcU+SmAbQHKmf1W6GzNupdX7XGCiaG0TjHNr7bFQQbNHohxJvkn55XZ1gkT9FzipD6PogMG8LXPZPo9Kuhc74onC+XvI793SOqB9XionXj4gvNQg1eUpoIiPuZKaHI2Ffs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JVOkIvJ+; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ec50a5e230so45067721fa.0
        for <linux-iio@vger.kernel.org>; Tue, 02 Jul 2024 10:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719941648; x=1720546448; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HiVIhZEAyuYnJTbH9Xr5ihUjZSz2ff/4WqtLGIZJN0k=;
        b=JVOkIvJ+wPM4x7f1DiLk5FgH7P2fdCOFd5yG0hQ1yWyFJA0zhdVyeV6NbX92z8gSWv
         KVb7rxfScYJQTBbv5mE2ykov//i1aNLabqEJzgkCF7mR9a/mRs7p1wZg+9l8mWvvwbAr
         Ssg68/Yjzo0ra30+fc/Hpko9ZhURiLXswyNcHMWWErQLN4G68FQYmsBFvt3y+YTNl7hd
         0ToQ6lMQjcB1fgdtCHqemj5uJuZhsaco8ZFZd8TNCEwLKUhYdMW596nBuc/koIG1bOeB
         x78KtxccdXiqugLGGpP5G9JgHnI2/9lDsOOBjSA4jDiCT4BYD5JlD+JiMvDYW9Gtbn77
         jzEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719941648; x=1720546448;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HiVIhZEAyuYnJTbH9Xr5ihUjZSz2ff/4WqtLGIZJN0k=;
        b=Q27YrJusWKwpjPmt+jtjDaowrgKG/FQ2L4hy3FN/LUOl5Mg5LE5nuYzRQXpcI4UlyN
         NOXV46sLZMMDS672UX3raPp76K6PH4FGv6LbzEe+//GJkjei4gXl3EMKP5/dEuBBsDDN
         NL0mRqkR5/zMDsxoia4UJralxuXIw4Pj1xjJ8fuk+kdtSLfAglld3kaBkS/bv0jZL0ZW
         vHwvGrxRUxghXpzHoguI8DBuknafZC7tzy3epjPIvqYES4ZRZv4bzmO6/lsWjMkZJjHh
         Q2B3zPoG09V1P4qkK35yrxm+5CEzytieUSGywYevZjT2YUbNmgPze9uC4sqHdgoa63ts
         wggg==
X-Gm-Message-State: AOJu0YyINKsK3mIttcfpFIfMu9jTOFtO10dx/iqUX4FUNMR4ad4jxG39
	aqJCTxQYlN/cohIUve1iWGjBHdLcQ53DyModOZcYQ8G7zaHSHUfGejILtBU9Yl0=
X-Google-Smtp-Source: AGHT+IHtC0neIxU3WljyCNjM68D7M5011X90gk+rYESEDsyeS00GTUY8+3AvYg4aHZmpnHdwMPGjWA==
X-Received: by 2002:ac2:4c4d:0:b0:52c:896f:930d with SMTP id 2adb3069b0e04-52e8274ffa8mr6224260e87.57.1719941647670;
        Tue, 02 Jul 2024 10:34:07 -0700 (PDT)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af59732sm207594485e9.11.2024.07.02.10.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 10:34:07 -0700 (PDT)
From: Guillaume Stols <gstols@baylibre.com>
Date: Tue, 02 Jul 2024 17:34:06 +0000
Subject: [PATCH v3 2/8] dt-bindings: iio: adc: adi,ad7606: improve
 descriptions
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240702-cleanup-ad7606-v3-2-57fd02a4e2aa@baylibre.com>
References: <20240702-cleanup-ad7606-v3-0-57fd02a4e2aa@baylibre.com>
In-Reply-To: <20240702-cleanup-ad7606-v3-0-57fd02a4e2aa@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Guillaume Stols <gstols@baylibre.com>, jstephan@baylibre.com, 
 dlechner@baylibre.com
X-Mailer: b4 0.14.0

Reword a few descriptions, and normalize the text width to 80 characters.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 .../devicetree/bindings/iio/adc/adi,ad7606.yaml    | 33 +++++++++++++---------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
index 32caa9fc00e4..76fd6df5f9ca 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
@@ -36,6 +36,9 @@ properties:
   avcc-supply: true
 
   interrupts:
+    description:
+      The BUSY pin falling edge indicates that the conversion is over, and thus
+      new data is available.
     maxItems: 1
 
   adi,conversion-start-gpios:
@@ -48,8 +51,9 @@ properties:
   reset-gpios:
     description:
       Must be the device tree identifier of the RESET pin. If specified, it will
-      be asserted during driver probe. As the line is active high, it should be
-      marked GPIO_ACTIVE_HIGH.
+      be asserted during driver probe. On the AD7606x, as the line is active
+      high, it should be marked GPIO_ACTIVE_HIGH. On the AD7616, as the line is
+      active low, it should be marked GPIO_ACTIVE_LOW.
     maxItems: 1
 
   standby-gpios:
@@ -62,36 +66,39 @@ properties:
 
   adi,first-data-gpios:
     description:
-      Must be the device tree identifier of the FRSTDATA pin.  The FRSTDATA
+      Must be the device tree identifier of the FRSTDATA pin. The FRSTDATA
       output indicates when the first channel, V1, is being read back on either
-      the parallel, byte or serial interface.  As the line is active high, it
+      the parallel, byte or serial interface. As the line is active high, it
       should be marked GPIO_ACTIVE_HIGH.
     maxItems: 1
 
   adi,range-gpios:
     description:
-      Must be the device tree identifier of the RANGE pin. The polarity on this
+      Must be the device tree identifier of the RANGE pin. The state on this
       pin determines the input range of the analog input channels. If this pin
       is tied to a logic high, the analog input range is ±10V for all channels.
-      If this pin is tied to a logic low, the analog input range is ±5V for all
-      channels. As the line is active high, it should be marked
+      On the AD760X, if this pin is tied to a logic low, the analog input range
+      is ±5V for all channels. As the line is active high, it should be marked
       GPIO_ACTIVE_HIGH.
     maxItems: 1
 
   adi,oversampling-ratio-gpios:
     description:
       Must be the device tree identifier of the over-sampling mode pins. As the
-      line is active high, it should be marked GPIO_ACTIVE_HIGH.
+      line is active high, it should be marked GPIO_ACTIVE_HIGH. On the AD7606X
+      parts that support it, if all 3 pins are tied to a logic high, software
+      mode is enabled.
     maxItems: 3
 
   adi,sw-mode:
     description:
-      Software mode of operation, so far available only for ad7616 and ad7606b.
+      Software mode of operation, so far available only for AD7616 and AD7606B.
       It is enabled when all three oversampling mode pins are connected to high
-      level. The device is configured by the corresponding registers. If the
-      adi,oversampling-ratio-gpios property is defined, then the driver will set
-      the oversampling gpios to high. Otherwise, it is assumed that the pins are
-      hardwired to VDD.
+      level for the AD7606B, or both the range selection are connected to high
+      level for the AD7616. The device is configured by the corresponding
+      registers. If the adi,oversampling-ratio-gpios property is defined, then
+      the driver will set the oversampling gpios to high. Otherwise, it is
+      assumed that the pins are hardwired to VDD.
     type: boolean
 
 required:

-- 
2.34.1


