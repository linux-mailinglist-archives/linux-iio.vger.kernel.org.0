Return-Path: <linux-iio+bounces-7172-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A0C92465D
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 19:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DF131C225F7
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 17:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C13E1C0DCF;
	Tue,  2 Jul 2024 17:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bskrnKu8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081F21BE873
	for <linux-iio@vger.kernel.org>; Tue,  2 Jul 2024 17:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719941651; cv=none; b=G53grxed/reICeXpbW7OwdVi8BZ+7O6tneWnNrDoVgm5XMBAurZvdvQ+WnZ/mQuna48EZRn8Kbk3JRapT0917hOlI/gnEdCV5pQj7NKiMqKY6ofJptkPpxsZ1zI56qyU6TkLUWlehjRrgNUrEGQl9oRPYHIUpSL1nr/hdKVwcDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719941651; c=relaxed/simple;
	bh=u/r2uW73OwBD2xLuXA811RokrBDEf+axTdQOVDLJPIM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lbi52qUMCKSkvRcDF7ccpKUmmW+YwrSXdfQENfWhdoM7HzImv9sVQLqyhtGVzKsCLazTqUMNjpufJXX8W+AMzP3iKEDr7Gophcx+KmW104ITEPmjMPdN7kAuNlXDsfDf+WApazlh1nUvhOA8b1hgniopWwK8cnjTdxNHPkKo0rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bskrnKu8; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-425809eef0eso18133315e9.3
        for <linux-iio@vger.kernel.org>; Tue, 02 Jul 2024 10:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719941647; x=1720546447; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XoOP6xDFVO+piNQMxKh2JgMUAWvA+ZCbwk4Ckp0ym3U=;
        b=bskrnKu86JUiCpGnSMMH0jp0oIo7CNOU5GucJkH1i8FNuWfuWtgReLxPKvsgakZwwe
         zeCBNMxG4Ev5grxV0bx9i2Dj/w9ZHSLvHRN4Sx6nKXjNT1vKIHb0cSCBedtTb7KneORE
         F6VzDlGwGBBYugqJT1xtmsuSbUR5ujVM8dIlADMkhlqoJY+77P59vry8d5kiW/SNtMID
         Ejgdd2Gt2ocgc9+W/bypD9KGWg10oIlrxxuS4PB30iEIi2fUsm8tiwnhnBm8RToMKs7r
         ZBKEyyxjJLJgzsbDytQli+8g7Uxdk029u1WEmmfi18xEZD8PQ7xXGgf4umta217DkiV0
         WL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719941647; x=1720546447;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XoOP6xDFVO+piNQMxKh2JgMUAWvA+ZCbwk4Ckp0ym3U=;
        b=Dp0mMkT9+eMNEH6siUvddcz9zKu96AEEiyXsm8DNpP6oXzqn4CVGPqzPd6rJJcG530
         Gluc5IFABnL94Svnbgn7P7vkwHl4yRzpmCHBAx6yV0W2cRf6RlMX2rPfgriACBzjY2hq
         sv1Itics+btwEGiPowrzWJ+zlf3Cig2DEJy4iqwTp87nH0/2g8VvMcbtQUXH9j+Pq0ln
         BgvnJOpYkXuBg5WiQ8RA7yoZ7kvBw580OEIPrX7o/liQxy5w9AFdmpFtbWq0yP6zNFVG
         kZrLBDpNCNoJjh0J11z/BfKgqmI5e/XzK/8SWmEhOdU6i6OMC9TaN0TRRSa6xzsKf8+Q
         urZg==
X-Gm-Message-State: AOJu0YxFsvbUh58TcgZ+C/u7DgX1rNSukhiltfa5Z3WACMB2+6I7+UMV
	2BdKc7xk7dWJewj3eFMRje17CHNkP6o+9pjw7eHZWwNGKWSvLYJsYqMQPX+rMGc=
X-Google-Smtp-Source: AGHT+IGNbBFaMXt00tk7jgstqKf4YHnk4QO27CDWCR548WxyUqMoX0zzovPsmWQ3+2snfKSDrSFNhA==
X-Received: by 2002:a05:600c:c88:b0:425:6498:3b6c with SMTP id 5b1f17b1804b1-4257a06427bmr72751655e9.26.1719941647149;
        Tue, 02 Jul 2024 10:34:07 -0700 (PDT)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af59732sm207594485e9.11.2024.07.02.10.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 10:34:06 -0700 (PDT)
From: Guillaume Stols <gstols@baylibre.com>
Date: Tue, 02 Jul 2024 17:34:05 +0000
Subject: [PATCH v3 1/8] dt-bindings: iio: adc: adi,ad7606: normalize
 textwidth
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240702-cleanup-ad7606-v3-1-57fd02a4e2aa@baylibre.com>
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

Normalize textwidth to 80 columns on the descriptions.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 .../devicetree/bindings/iio/adc/adi,ad7606.yaml    | 50 +++++++++++-----------
 1 file changed, 24 insertions(+), 26 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
index 00fdaed11cbd..32caa9fc00e4 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
@@ -40,60 +40,58 @@ properties:
 
   adi,conversion-start-gpios:
     description:
-      Must be the device tree identifier of the CONVST pin.
-      This logic input is used to initiate conversions on the analog
-      input channels. As the line is active high, it should be marked
-      GPIO_ACTIVE_HIGH.
+      Must be the device tree identifier of the CONVST pin. This logic input is
+      used to initiate conversions on the analog input channels. As the line is
+      active high, it should be marked GPIO_ACTIVE_HIGH.
     maxItems: 1
 
   reset-gpios:
     description:
-      Must be the device tree identifier of the RESET pin. If specified,
-      it will be asserted during driver probe. As the line is active high,
-      it should be marked GPIO_ACTIVE_HIGH.
+      Must be the device tree identifier of the RESET pin. If specified, it will
+      be asserted during driver probe. As the line is active high, it should be
+      marked GPIO_ACTIVE_HIGH.
     maxItems: 1
 
   standby-gpios:
     description:
-      Must be the device tree identifier of the STBY pin. This pin is used
-      to place the AD7606 into one of two power-down modes, Standby mode or
+      Must be the device tree identifier of the STBY pin. This pin is used to
+      place the AD7606 into one of two power-down modes, Standby mode or
       Shutdown mode. As the line is active low, it should be marked
       GPIO_ACTIVE_LOW.
     maxItems: 1
 
   adi,first-data-gpios:
     description:
-      Must be the device tree identifier of the FRSTDATA pin.
-      The FRSTDATA output indicates when the first channel, V1, is
-      being read back on either the parallel, byte or serial interface.
-      As the line is active high, it should be marked GPIO_ACTIVE_HIGH.
+      Must be the device tree identifier of the FRSTDATA pin.  The FRSTDATA
+      output indicates when the first channel, V1, is being read back on either
+      the parallel, byte or serial interface.  As the line is active high, it
+      should be marked GPIO_ACTIVE_HIGH.
     maxItems: 1
 
   adi,range-gpios:
     description:
-      Must be the device tree identifier of the RANGE pin. The polarity on
-      this pin determines the input range of the analog input channels. If
-      this pin is tied to a logic high, the analog input range is ±10V for
-      all channels. If this pin is tied to a logic low, the analog input range
-      is ±5V for all channels. As the line is active high, it should be marked
+      Must be the device tree identifier of the RANGE pin. The polarity on this
+      pin determines the input range of the analog input channels. If this pin
+      is tied to a logic high, the analog input range is ±10V for all channels.
+      If this pin is tied to a logic low, the analog input range is ±5V for all
+      channels. As the line is active high, it should be marked
       GPIO_ACTIVE_HIGH.
     maxItems: 1
 
   adi,oversampling-ratio-gpios:
     description:
-      Must be the device tree identifier of the over-sampling
-      mode pins. As the line is active high, it should be marked
-      GPIO_ACTIVE_HIGH.
+      Must be the device tree identifier of the over-sampling mode pins. As the
+      line is active high, it should be marked GPIO_ACTIVE_HIGH.
     maxItems: 3
 
   adi,sw-mode:
     description:
       Software mode of operation, so far available only for ad7616 and ad7606b.
-      It is enabled when all three oversampling mode pins are connected to
-      high level. The device is configured by the corresponding registers. If the
-      adi,oversampling-ratio-gpios property is defined, then the driver will set the
-      oversampling gpios to high. Otherwise, it is assumed that the pins are hardwired
-      to VDD.
+      It is enabled when all three oversampling mode pins are connected to high
+      level. The device is configured by the corresponding registers. If the
+      adi,oversampling-ratio-gpios property is defined, then the driver will set
+      the oversampling gpios to high. Otherwise, it is assumed that the pins are
+      hardwired to VDD.
     type: boolean
 
 required:

-- 
2.34.1


