Return-Path: <linux-iio+bounces-14321-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BD2A0C31F
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 22:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C6BC169020
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 21:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8431FA8EE;
	Mon, 13 Jan 2025 21:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FTab2Gif"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162181F9F60
	for <linux-iio@vger.kernel.org>; Mon, 13 Jan 2025 21:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736802071; cv=none; b=Kq44X9mW+T2ZXXHgOTw4GUBQ5GqY5BxmbO0okH2ekyxX3OhstHPCJglRe6IUw4eqt+/bWUJbzfV1nG3pq1By3HB6Ew1Cs3Gfc170+dwHJ9S9OsVvKri33Oe2WjNueff2a/cIsMUUOYbzOCdXyqKpGJ0tWf4a2MnS7cRk/qGziZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736802071; c=relaxed/simple;
	bh=jRlTs2hPxFTMWzXud2pwyf/gDJQZpce7x7Xes5PCDq0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p5zf6pkf+1GizoX8kwAbVsZT9ZRcNWBQANF/xnhOm/2dcyF9teX2hv6ZucOAhLAtsZe70KtqTqHlm5BE9/IDjgteb5lmghcyT3UVQDWD9Wcpa+g77jMUv1xFZwM2eKvpC4VagLAEI6yvlpeLe9QUedtofoYxl+ovvp0yhzGb0r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FTab2Gif; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-71e565708beso2559597a34.1
        for <linux-iio@vger.kernel.org>; Mon, 13 Jan 2025 13:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736802067; x=1737406867; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m4qOy1E2SWXTRLQzjAjoUUpkXvVJq7HeawRi11wv1CQ=;
        b=FTab2GifrSjdz1W7bjvBYjUilGHiDoz4r6Q9cZxQUjZT6/S4jKM/5e64KBeK6s6BiR
         JGeJ2PmIrk/0HUD3u6T5LKtUvO5/uuSCWJwHmP9gIzfNN/oum6nl+C1wf2mVnS+JdP3s
         T9esDyBsdsPFpYjWYkW4W9NrubDlJbbyKHOgxhF8sLo7bu4IN/tgVl/jh+Ns0XE+VlAC
         R6uw0cWjFPvco6Q0TJPA8UX97BVESQ9tU3lRqyO7C92sEP7uuIv7H231xIbO9jXwKjT5
         1NH994K0aig/V0rXPYPTPJMgGTnUCbpsLUVAfBokesH7Vhf6yb8jd2tj2xZTw4H0rbU5
         IzZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736802067; x=1737406867;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m4qOy1E2SWXTRLQzjAjoUUpkXvVJq7HeawRi11wv1CQ=;
        b=E4vwuS2HT/KaUaiV0O7SNVmM6YGibYBAkT2yeAfSYr1K2CLFrL2euRTrsDgeshf4la
         HG/4ZY2D2ImnyuJItpt8lTQv4w9Yqknd5ovYb6ncXtfQ0/byTZ0Xjcx5HOXGD4aYnqbN
         xH9DtytqUE1ginJwwvwRR5mxzunglBZy65SNmK++QVd5fIff7XCJCs2xy7p9gciSR6/0
         2GtDiJT5kRUHMQDRBNUI1zSEjofSALdI6Iao+3gsOuPXQgVNiEzVtDEJKmO3i72tnDok
         F27DQiOI1/DPyFq/G6xnArfY8GWwr41uiBoCdh6p6cGH+g4OTnfAgPkE1Hc6MaNm/Cdz
         laiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVq6EwYo5YprHeoN71Zrfoo4IVJoa0RQQ9rursydG/R0jCrywIlDiu4gYkn2bMRg7/dv7DhyMW/PGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8eHgWS0ckGpl5XbZTUJek6ZOcjbrcKAA6023AfHuVIuZty72n
	zcZhVof9NgmRMrj98M19pdOipIN1RkifIU5WK2tyhA97C/JeW+LEtwcA2rjfAXE=
X-Gm-Gg: ASbGncvkKdGE2bzgstB+6td1rPankyMCdx6oShQmtWdxacJZUs+iLvdlTkBfZmRI8B+
	yIIpO17FSCy4xoc/SPPSzKdTanqEkFBCkbVd2WgkxKFaQPrIB89eprx1N9VroPiu1G571flbej/
	e2gAoYHXub1HIGioOoaQKqvD1WD1o4i0ENl9UPO8wAoKk+R0sY8MyAIDbHhpr44EEYoS/AF1gV4
	WGE2dpiRhOp5mmzBuH/ZzCjR0LYyy6WnunIYpsqhR9sS5v97EZ6kO57ZcErJSlGpw/xnWxPIsen
	uHVCIUc4F4UB
X-Google-Smtp-Source: AGHT+IEhD0Vp5JdEuew98KxE05jR40/4fw1aRh9ZIYPvM+djmKr8mac14kyQAxtYZsi3oBGb27A3Bw==
X-Received: by 2002:a05:6830:3495:b0:71d:5236:9295 with SMTP id 46e09a7af769-721e2eff802mr13309103a34.24.1736802066783;
        Mon, 13 Jan 2025 13:01:06 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7231855effasm3927744a34.33.2025.01.13.13.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 13:01:06 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 13 Jan 2025 15:00:17 -0600
Subject: [PATCH v7 12/17] doc: iio: ad7944: describe offload support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-dlech-mainline-spi-engine-offload-2-v7-12-e0860c81caae@baylibre.com>
References: <20250113-dlech-mainline-spi-engine-offload-2-v7-0-e0860c81caae@baylibre.com>
In-Reply-To: <20250113-dlech-mainline-spi-engine-offload-2-v7-0-e0860c81caae@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>, 
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

Add a section to the ad7944 documentation describing how to use the
driver with SPI offloading.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v7 changes: none

v6 changes: none

v5 changes: new patch in v5
---
 Documentation/iio/ad7944.rst | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/iio/ad7944.rst b/Documentation/iio/ad7944.rst
index 0d26e56aba8862a8d2ff541012bb4681d05c7bb5..e6dbe4d7f58cffd9f700f931ad2641d336526129 100644
--- a/Documentation/iio/ad7944.rst
+++ b/Documentation/iio/ad7944.rst
@@ -46,6 +46,8 @@ CS mode, 3-wire, without busy indicator
 To select this mode in the device tree, set the ``adi,spi-mode`` property to
 ``"single"`` and omit the ``cnv-gpios`` property.
 
+This is the only wiring configuration supported when using `SPI offload support`_.
+
 CS mode, 4-wire, without busy indicator
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
@@ -106,7 +108,6 @@ Unimplemented features
 ----------------------
 
 - ``BUSY`` indication
-- ``TURBO`` mode
 
 
 Device attributes
@@ -147,6 +148,27 @@ AD7986 is a fully-differential ADC and has the following attributes:
 In "chain" mode, additional chips will appear as additional voltage input
 channels, e.g. ``in_voltage2-voltage3_raw``.
 
+SPI offload support
+===================
+
+To be able to achieve the maximum sample rate, the driver can be used with the
+`AXI SPI Engine`_ to provide SPI offload support.
+
+.. _AXI SPI Engine: http://analogdevicesinc.github.io/hdl/projects/pulsar_adc/index.html
+
+When SPI offload is being used, some attributes will be different.
+
+* ``trigger`` directory is removed.
+* ``in_voltage0_sampling_frequency`` attribute is added for setting the sample
+  rate.
+* ``in_voltage0_sampling_frequency_available`` attribute is added for querying
+  the max sample rate.
+* ``timestamp`` channel is removed.
+* Buffer data format may be different compared to when offload is not used,
+  e.g. the ``in_voltage0_type`` attribute.
+
+If the ``turbo-gpios`` property is present in the device tree, the driver will
+turn on TURBO during buffered reads and turn it off otherwise.
 
 Device buffers
 ==============

-- 
2.43.0


