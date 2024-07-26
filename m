Return-Path: <linux-iio+bounces-7943-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DE593D5E5
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 17:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D33D2843B1
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 15:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C61917C7B2;
	Fri, 26 Jul 2024 15:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="I4MLxprl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC5E17B43E
	for <linux-iio@vger.kernel.org>; Fri, 26 Jul 2024 15:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722007223; cv=none; b=fwzkKjNM/yWfuH+GtztVlxC3Lv4Cw8sFg3q6BfWvaIzvql+vxuu4OK9uEQMO+0BEurAQzxZkP6V4GXv0RtZ936OlVLfyoEGRnYO20/GxX4/EpMyIyacGHX3S1t2JHRS/Fl9NYxF9lLqFPaAb6QvWfiG8hVe4jU0m2igwqyABXJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722007223; c=relaxed/simple;
	bh=/b51c7Gh0KEr+9fwhvTP5AZvLEP79dfZE3yqEhmWqmg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L87wjrD+qvkzAec1XElEfTYmKet57t/Qa1CCUkL8roj80u1JDNRycsvwCvNuQ5Wx+j4zGAGfkeWVqrCKPOTKgNAM1Tjt+VO16tsp1eCH+eyLXaTlw1aqxKYmcmfXzJQqU8S5xEMrKXKOfpDeySgnHyrHFPXCy4r8Ny6aBxq0PH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=I4MLxprl; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so12479915e9.1
        for <linux-iio@vger.kernel.org>; Fri, 26 Jul 2024 08:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722007219; x=1722612019; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tTnR9+wx0EQjyG+dHLGk5jhYlFzNR+TYiB9/k0QU6jg=;
        b=I4MLxprlMPfKgQfuMmFHWfT11kIqLRWadc/ttXaHIirdVauhhONveiPAS0eXftOko4
         H6LaYYL6sE7REIDasZ2gconnghw1xBwEbUwbpdTLZqmqVR01740a7O4VIIM7aUbkHTlX
         +045kADCQxuHPin2NLB7uXYUYuBDBTmNgX1srdRbNqk3Y2OQAEbQ72FRyskswFIAThWc
         bxwRYgX1+PKFYyj06DeVEauI19sOn8hIh2ctatOu6AuyTcXAM7KpsDC2VwGql53cvQqE
         fwDBtNbT860CXl3PpbzRFah3liQvjp7MLdt7GOfQquT/d8QNk/6MxxKBn2xQPywc6a9L
         ugww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722007219; x=1722612019;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tTnR9+wx0EQjyG+dHLGk5jhYlFzNR+TYiB9/k0QU6jg=;
        b=UzYLyJJMGtoo1AyPShhucZAs/h0pDe0X/+jL1ujTwG+II84dGgySTONKsL32GftlKn
         3m7JH3anwhLFcGyVneEs/SXKR+KUdYMhy5j+Xgqf6NLyyYYnpNLvmddPOy2hdOd1r2vP
         lRvQ0hHfYvgCd1tu8jlbOobtOaACVzDPMvCQLgdKSHUPwQ64UZOqhCyyBZhruZ29eTd9
         Btv5SyV+rmhyYZwihAacxqd5riqO6WzrShmiMaSVS4QjMcDrUREB1mkN9URRcMQyLwL2
         LipTEYGJv/K7fP27MrsH7aQjE8SelUBuIUtNwTggp42SnWByZspFEDXc2MkDEsmOPQmn
         ophg==
X-Forwarded-Encrypted: i=1; AJvYcCVtOoodY3+1OtvizyLN08jyuQtTerutfT73kquyywtZlYTnVdmIUNophL5hyf5ggP4z544bD0zkmoQ7oe0/+r4BlQaP3hBjD7WU
X-Gm-Message-State: AOJu0Yy8ZQsmvg5OgEvwZSg5K4GaPhV5tfGv4CwGrljHnAo2la9xJ7co
	O+6P3bQ69xjlr/G8C3jMP5gHfr82XL+ZBDZZsobm/eBzei0R+WqmDpxs9MB7fBk=
X-Google-Smtp-Source: AGHT+IEkJk+VImlGebjXAAw0Pedy4Tauw51C6OqGZDJpb40MgtggtJhEjsRt/rp/lgTeUv7AEdRocg==
X-Received: by 2002:a05:600c:1d05:b0:426:698b:791f with SMTP id 5b1f17b1804b1-427f99eeec2mr62843775e9.3.1722007218727;
        Fri, 26 Jul 2024 08:20:18 -0700 (PDT)
Received: from [192.168.1.61] (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net. [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367c0338sm5500985f8f.1.2024.07.26.08.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 08:20:18 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 26 Jul 2024 17:20:07 +0200
Subject: [PATCH 2/5] ad7380: prepare driver for single-ended parts support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-ad7380-add-single-ended-chips-v1-2-2d628b60ccd1@baylibre.com>
References: <20240726-ad7380-add-single-ended-chips-v1-0-2d628b60ccd1@baylibre.com>
In-Reply-To: <20240726-ad7380-add-single-ended-chips-v1-0-2d628b60ccd1@baylibre.com>
To: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.13.0

ad738x family contains single-ended parts that have a 2:1 mux in front
of ADC, so the number of IIO channels is different from the number of
simultaneous channels that can be sampled.

To prepare the support for single-ended parts, introduce a new
num_simultaneous_channels variable. For currently supported parts,
num_simultaneous_channels is equal to num_channels minus 1 (the
timestamps channel)

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/iio/adc/ad7380.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index 7568cd0a2b32..03bbd561fb23 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -80,6 +80,7 @@ struct ad7380_chip_info {
 	const char *name;
 	const struct iio_chan_spec *channels;
 	unsigned int num_channels;
+	unsigned int num_simult_channels;
 	const char * const *vcm_supplies;
 	unsigned int num_vcm_supplies;
 	const unsigned long *available_scan_masks;
@@ -208,6 +209,7 @@ static const struct ad7380_chip_info ad7380_chip_info = {
 	.name = "ad7380",
 	.channels = ad7380_channels,
 	.num_channels = ARRAY_SIZE(ad7380_channels),
+	.num_simult_channels = 2,
 	.available_scan_masks = ad7380_2_channel_scan_masks,
 	.timing_specs = &ad7380_timing,
 };
@@ -216,6 +218,7 @@ static const struct ad7380_chip_info ad7381_chip_info = {
 	.name = "ad7381",
 	.channels = ad7381_channels,
 	.num_channels = ARRAY_SIZE(ad7381_channels),
+	.num_simult_channels = 2,
 	.available_scan_masks = ad7380_2_channel_scan_masks,
 	.timing_specs = &ad7380_timing,
 };
@@ -224,6 +227,7 @@ static const struct ad7380_chip_info ad7383_chip_info = {
 	.name = "ad7383",
 	.channels = ad7383_channels,
 	.num_channels = ARRAY_SIZE(ad7383_channels),
+	.num_simult_channels = 2,
 	.vcm_supplies = ad7380_2_channel_vcm_supplies,
 	.num_vcm_supplies = ARRAY_SIZE(ad7380_2_channel_vcm_supplies),
 	.available_scan_masks = ad7380_2_channel_scan_masks,
@@ -234,6 +238,7 @@ static const struct ad7380_chip_info ad7384_chip_info = {
 	.name = "ad7384",
 	.channels = ad7384_channels,
 	.num_channels = ARRAY_SIZE(ad7384_channels),
+	.num_simult_channels = 2,
 	.vcm_supplies = ad7380_2_channel_vcm_supplies,
 	.num_vcm_supplies = ARRAY_SIZE(ad7380_2_channel_vcm_supplies),
 	.available_scan_masks = ad7380_2_channel_scan_masks,
@@ -244,6 +249,7 @@ static const struct ad7380_chip_info ad7380_4_chip_info = {
 	.name = "ad7380-4",
 	.channels = ad7380_4_channels,
 	.num_channels = ARRAY_SIZE(ad7380_4_channels),
+	.num_simult_channels = 4,
 	.available_scan_masks = ad7380_4_channel_scan_masks,
 	.timing_specs = &ad7380_4_timing,
 };
@@ -252,6 +258,7 @@ static const struct ad7380_chip_info ad7381_4_chip_info = {
 	.name = "ad7381-4",
 	.channels = ad7381_4_channels,
 	.num_channels = ARRAY_SIZE(ad7381_4_channels),
+	.num_simult_channels = 4,
 	.available_scan_masks = ad7380_4_channel_scan_masks,
 	.timing_specs = &ad7380_4_timing,
 };
@@ -260,6 +267,7 @@ static const struct ad7380_chip_info ad7383_4_chip_info = {
 	.name = "ad7383-4",
 	.channels = ad7383_4_channels,
 	.num_channels = ARRAY_SIZE(ad7383_4_channels),
+	.num_simult_channels = 4,
 	.vcm_supplies = ad7380_4_channel_vcm_supplies,
 	.num_vcm_supplies = ARRAY_SIZE(ad7380_4_channel_vcm_supplies),
 	.available_scan_masks = ad7380_4_channel_scan_masks,
@@ -270,6 +278,7 @@ static const struct ad7380_chip_info ad7384_4_chip_info = {
 	.name = "ad7384-4",
 	.channels = ad7384_4_channels,
 	.num_channels = ARRAY_SIZE(ad7384_4_channels),
+	.num_simult_channels = 4,
 	.vcm_supplies = ad7380_4_channel_vcm_supplies,
 	.num_vcm_supplies = ARRAY_SIZE(ad7380_4_channel_vcm_supplies),
 	.available_scan_masks = ad7380_4_channel_scan_masks,
@@ -407,7 +416,7 @@ static void ad7380_update_xfers(struct ad7380_state *st,
 	 */
 	st->xfer[1].bits_per_word = scan_type->realbits;
 	st->xfer[1].len = BITS_TO_BYTES(scan_type->storagebits) *
-			  (st->chip_info->num_channels - 1);
+			  st->chip_info->num_simult_channels;
 }
 
 static int ad7380_triggered_buffer_preenable(struct iio_dev *indio_dev)

-- 
2.45.1


