Return-Path: <linux-iio+bounces-15143-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C66A2CDC8
	for <lists+linux-iio@lfdr.de>; Fri,  7 Feb 2025 21:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E106E188DC80
	for <lists+linux-iio@lfdr.de>; Fri,  7 Feb 2025 20:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08F61DE8A9;
	Fri,  7 Feb 2025 20:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="c/xQHjKJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4A51DE2DA
	for <linux-iio@vger.kernel.org>; Fri,  7 Feb 2025 20:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738958991; cv=none; b=lW5DZSqYaXN3GNCTu17bYCau5tm2AI7gXL89PfGP3nZqcBVyHnm69WtuWS0wd+iymOk0pRYt1JyZt4m0hBlmFrGu9t65UcVBej2xC6ikqnh8cu7vxOrfLcTzu1JxpH4IU951brhlyvY7/e1jVQAYDN/qXlHqeeuVobQHB/dQXm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738958991; c=relaxed/simple;
	bh=jRlTs2hPxFTMWzXud2pwyf/gDJQZpce7x7Xes5PCDq0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NR5fzigj9/4ZprT1yZa2f3TZklxbV8BjqBnHURfy/R6YURtbrULI8KKJASCygTKQET9HR3YtT/dj3o7gksgv/mOzsDMmF2jeXBcCPEk2bAGjgVkzxrkNr5/R+3mc1zmnQeni78c3eIXvxSTJbBsjr7ObBzihhQBLISurgi8HLvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=c/xQHjKJ; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5f31841c6f6so1438426eaf.0
        for <linux-iio@vger.kernel.org>; Fri, 07 Feb 2025 12:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738958988; x=1739563788; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m4qOy1E2SWXTRLQzjAjoUUpkXvVJq7HeawRi11wv1CQ=;
        b=c/xQHjKJuastuL7F4tSshhnKVOt8W5fYRMSzu1kwH8f1mcBTUTV+/CqgYIjyPhbEk8
         iyETe7xmqVbt3gFqi+cy9posN6t4MSxXkHVAqwE2ZND+0quXlkijyz63XB4yprJdgpjs
         hZXD3queVLzUTqNb7KxCVLSiYlyrDtU4QylpE0GrxiUhILKU3o2LTr0z4bBzTLe7Wkd0
         LN+bK9OGbDwMc559RsNj3wS6cHHzO1c5yM7kV9R5MkPkL5IWyAbwX2ky5rRuiQApnYsH
         1c1mnVo3mRkuayv4+rwjhc6OczSo0GGFPG5BQqM+HkUYtIq1J9yqxRjJZr9wESEwGS01
         w33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738958988; x=1739563788;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m4qOy1E2SWXTRLQzjAjoUUpkXvVJq7HeawRi11wv1CQ=;
        b=U0RwIebVFnmld46ess8uHpW2lfZTMTlxf/WISjcs5ZyzB6zEbYxatu60NmWZNfuBtp
         pA/Lg0v1dWCRlUwpSaKbQ5AW/8wojdgU4LYZmo1RR+dZB0m0O01kIeG3+eBk3S8RhD2e
         MjyEJi8Xk600oJ18Wa14l1KaOvevjI7aBt77ImZ1Gq0yo3bijzXYl08vVyuX/P7xgYDY
         Kp/I5w1qXzXx7tWjjFghHSwMsd4gvB9G4o4hYqXxagg/qE5M8L42YSYs1RN55o0xnTe7
         +vDmEgUfpcV7I3imXQuzc1hJztyHj47Om3BizPJvS0fLbgDGRmGtI5JMPbrQ84mV1yzN
         ickw==
X-Forwarded-Encrypted: i=1; AJvYcCUdTOvkFUviRXoqY3gfl+PpF6+fiaswr3hIwIMnXpoUvkL4nuEg+NNlkYWdh7EKd62B2lFpNYQ9qJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPdqvJePmQeRqBgmRRDUI+Eyu9DnuipDCuahjjkU5WKVGIXjcT
	It49u+1pjYKBl38e2Le5bmF2y/xVMKvKSOa84Y2s2Kc6+JouchJqvHeV2yiYgcs=
X-Gm-Gg: ASbGnct7q9lJLPnpaclyhewF6EqOkJ0gGUjx9LyaUaXq5SsvdCAwWc0QlCkZV+QEVEL
	OG8F2tovt0HknJAHd169193dXnbDje6Whx3gcHmuo7ff8OVdVAYlYs97uceRZs1UQiB8dr8mo5U
	1dWJ7Tv2aeIkpCjVYi5NZkA9nYz0rGjuGzzg7/jsWa97zkf3J4w0rKUOiyIOQCqnuiy3KZeDvp2
	TC6iCmjGJOs1sb9jc/znVweaJDdr+LzoY0TjSsGB0zXZdxWtPztIIge+QEkVkUCcYLNQE8dHhLW
	rSH03Hs4U2O4AMEX0/TZ0kFAn4DH5uP23MDgaVVAyADIeco=
X-Google-Smtp-Source: AGHT+IG77ZOpZoqliQs6i/d86fRFOW+Nrx505QHjkxGWQhm1CMXLj+So9sv5ltnLehIXmgyoVX5BBg==
X-Received: by 2002:a4a:ee14:0:b0:5fa:8925:3d76 with SMTP id 006d021491bc7-5fc5e5c755dmr2828112eaf.1.1738958988093;
        Fri, 07 Feb 2025 12:09:48 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fc544b08d4sm930387eaf.2.2025.02.07.12.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 12:09:46 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 07 Feb 2025 14:09:09 -0600
Subject: [PATCH v8 12/17] doc: iio: ad7944: describe offload support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-dlech-mainline-spi-engine-offload-2-v8-12-e48a489be48c@baylibre.com>
References: <20250207-dlech-mainline-spi-engine-offload-2-v8-0-e48a489be48c@baylibre.com>
In-Reply-To: <20250207-dlech-mainline-spi-engine-offload-2-v8-0-e48a489be48c@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>, 
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
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


