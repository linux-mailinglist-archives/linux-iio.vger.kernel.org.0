Return-Path: <linux-iio+bounces-13363-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F12CF9ED7DF
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 21:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53BBB168D6A
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 20:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B1423E6D3;
	Wed, 11 Dec 2024 20:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qo9T7lAb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4203223A19D
	for <linux-iio@vger.kernel.org>; Wed, 11 Dec 2024 20:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733950532; cv=none; b=Ns6UzlsuRKqrpzfFRYtLa7h8i1hTKmegZR+W92d+c1uwHAhpHvfMsPzWwJmW6i9YwZHjwir3dojp6IPzOZ9Pl+dSgv0rD3/UWa58BO27nBqqAiRqkRa2BM24rMRZwQtJtfJdRc85SJu2naF88YpQqENPhijJiAJ6Qmgg2wGuR+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733950532; c=relaxed/simple;
	bh=CqimUPw8uuk68aDc8uu2IsObRv6iG6n7TTJVVOiBWN0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ng2mZe7Vo0NhpLl1F90QIeFAsAllO578RAsT02kyMA4wnrt7Wzx+5XCSkqO5gIxuEhkpWyPQhgFtkR09QGvIRtwk7ZeWWO642IheJ/clBjy5CmsIkATATs4WPs653R133NCqi7zXxeN829y2iJa4Gv1VCCTdrK8HZktu2zdRp00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qo9T7lAb; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3eb40876bbfso1110617b6e.0
        for <linux-iio@vger.kernel.org>; Wed, 11 Dec 2024 12:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733950526; x=1734555326; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F+0eqdGrTj7PVGAdUgO4EyyvRg3ifAOTsfeDd6RHAXU=;
        b=qo9T7lAbw6AgDAbRz4c82O1kZt4TUhA062+NejzpEZ/rNEArkpFHH2g70H/nhLzZ+u
         aseJkAwKJv4Ypmdl6Fi10xV3VZNeITiidDKZW8DwzkFFytq9P1c6aqhwUZR4uvrNGhKq
         Tf9k/txwgNYZvTf5QwKNbUyiTF3ueoEJTFvIzcZXdvTgQHQKMAI2Mu0Ezo40kCXg1tK4
         QuE74EDH3molCjTq1hIgtZZdO+1Ai3co1VGPCwbZXWu59TZ/9/+oMbtD/WZ681uCRMd4
         Vh2/a9Dt7gXPiQLnXTR6v0i6I0z2qQPYV8jia61C74wWJFRctwlGvoRYtemoJxlav+3O
         p9MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733950526; x=1734555326;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F+0eqdGrTj7PVGAdUgO4EyyvRg3ifAOTsfeDd6RHAXU=;
        b=nW/3/Kh8KoQcr7BMTksRgUJJAMND/TrpI2rLb8Y7m1ftodSQ0POtf/sKKKrsnDCjzo
         bz+hxtvOin4FGiYOdzsXdssHDEIGiZgehN8XXannw6K4GFqfuYp2+4Fp1h4NTdhqIkPw
         qE2v7cRkemPCjPHo7cMS1nzOQp6OtCYzLG7NaEzRUvG4tpXcFdZHMOM+fg30PEWY9GO1
         G8Gf1iyv4S7od3cKXGZtXws8v041NAXl4vGG8qot/NQ3BM1ITtugDKILiEnPFVini/bf
         tAnGEvcHcDJZNkv1JBWL0fHJ7VhPpKPNNLzw3mrpcSCMzpCORyJwUaoT/ZbnQMO3cnQS
         o8CQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxXggfTPyYIo0t/wzcKOGmBpbQyIU2FJjvp6cFP1X9f/DMD0Dz6qkXMlMisckuWNPEnNB/k51Zqcg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ5+GGZFlVij3PSoh1NdAlKyvP3AJoFMEJTA6lP1PeiLnxGbwU
	3IrtUf9o+b1XgrRJOeuMF7T3RGJAvHWV7pVUKTz4H4LW9gHA0f8brupl3p76rVs=
X-Gm-Gg: ASbGncvMx52tBj6+L+JdPl09pPe3jrp0Lk33OJJidCg9Ipwu7YeFrkKRB65neS24OEX
	4sGCGZ7P3X+23aDt9VS8JgcLLonKwPHBGObjx20jr16vOMHdtKyEm6EPQlqZ3jwY2JwQZE5thrh
	4+8UvMz6MN2OUFCVbpEGNPL1cAL6Ynap+8eRRBfy43HUI6KuBFUyqlfzJ7FUqsgoSiGteo/HSyD
	J0KJlo+4PZNWkOjqNuPBTHLpSFJzH9XYR6oQ84bdfJbttS1X4b2Ds8O2bg5qh6MciAb8VS0D4gM
	PFCvfykVTA==
X-Google-Smtp-Source: AGHT+IHsptMs0bdpB7TMIMS2sikrd60fAQmzA2ksoYkV+2JBISwTwL8cHuShB0rt9AANJARUZXD9AA==
X-Received: by 2002:a05:6808:398b:b0:3ea:5ef1:c95 with SMTP id 5614622812f47-3eb85c47143mr2389366b6e.25.1733950526016;
        Wed, 11 Dec 2024 12:55:26 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71def651fb2sm1888288a34.27.2024.12.11.12.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 12:55:24 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 11 Dec 2024 14:54:52 -0600
Subject: [PATCH v6 15/17] doc: iio: ad4695: add SPI offload support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-dlech-mainline-spi-engine-offload-2-v6-15-88ee574d5d03@baylibre.com>
References: <20241211-dlech-mainline-spi-engine-offload-2-v6-0-88ee574d5d03@baylibre.com>
In-Reply-To: <20241211-dlech-mainline-spi-engine-offload-2-v6-0-88ee574d5d03@baylibre.com>
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
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

Document SPI offload support for the ad4695 driver.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v6 changes:
* Fixed double "all"
* Don't abbreviate "sampling_frequency" attribute names for clarity.

v5 changes: new patch in v5
---
 Documentation/iio/ad4695.rst | 68 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/Documentation/iio/ad4695.rst b/Documentation/iio/ad4695.rst
index 9ec8bf466c15bf94cbae2ebdb61875f66af1264f..ead0faadff4b5aede2a34bac52e103e375da6f21 100644
--- a/Documentation/iio/ad4695.rst
+++ b/Documentation/iio/ad4695.rst
@@ -47,6 +47,36 @@ In this mode, CNV and CS are tied together and there is a single SDO line.
 To use this mode, in the device tree, omit the ``cnv-gpios`` and
 ``spi-rx-bus-width`` properties.
 
+SPI offload wiring
+^^^^^^^^^^^^^^^^^^
+
+When used with a SPI offload, the supported wiring configuration is:
+
+.. code-block::
+
+    +-------------+         +-------------+
+    |    GP0/BUSY |-------->| TRIGGER     |
+    |          CS |<--------| CS          |
+    |             |         |             |
+    |     ADC     |         |     SPI     |
+    |             |         |             |
+    |         SDI |<--------| SDO         |
+    |         SDO |-------->| SDI         |
+    |        SCLK |<--------| SCLK        |
+    |             |         |             |
+    |             |         +-------------+
+    |         CNV |<-----+--| PWM         |
+    |             |      +--| GPIO        |
+    +-------------+         +-------------+
+
+In this case, both the ``cnv-gpios`` and  ``pwms`` properties are required.
+The ``#trigger-source-cells = <2>`` property is also required to connect back
+to the SPI offload. The SPI offload will have ``trigger-sources`` property
+with cells to indicate the busy signal and which GPx pin is used, e.g
+``<&ad4695 AD4695_TRIGGER_EVENT_BUSY AD4695_TRIGGER_PIN_GP0>``.
+
+.. seealso:: `SPI offload support`_
+
 Channel configuration
 ---------------------
 
@@ -158,6 +188,27 @@ Unimplemented features
 - GPIO support
 - CRC support
 
+SPI offload support
+===================
+
+To be able to achieve the maximum sample rate, the driver can be used with the
+`AXI SPI Engine`_ to provide SPI offload support.
+
+.. _AXI SPI Engine: http://analogdevicesinc.github.io/hdl/projects/ad469x_fmc/index.html
+
+.. seealso:: `SPI offload wiring`_
+
+When SPI offload is being used, some attributes will be different.
+
+* ``trigger`` directory is removed.
+* ``in_voltage0_sampling_frequency`` attributes are added for setting the sample
+  rate.
+* ``in_voltage0_sampling_frequency_available`` attributes are added for querying
+  the max sample rate.
+* ``timestamp`` channel is removed.
+* Buffer data format may be different compared to when offload is not used,
+  e.g. the ``buffer0/in_voltage0_type`` attribute.
+
 Device buffers
 ==============
 
@@ -165,3 +216,20 @@ This driver supports hardware triggered buffers. This uses the "advanced
 sequencer" feature of the chip to trigger a burst of conversions.
 
 Also see :doc:`iio_devbuf` for more general information.
+
+Effective sample rate for buffered reads
+----------------------------------------
+
+When SPI offload is not used, the sample rate is determined by the trigger that
+is manually configured in userspace. All enabled channels will be read in a
+burst when the trigger is received.
+
+When SPI offload is used, the sample rate is configured per channel. All
+channels will have the same rate, so only one ``in_voltageY_sampling_frequency``
+attribute needs to be set. Since this rate determines the delay between each
+individual conversion, the effective sample rate for each sample is actually
+the sum of the periods of each enabled channel in a buffered read. In other
+words, it is the value of the ``in_voltageY_sampling_frequency`` attribute
+divided by the number of enabled channels. So if 4 channels are enabled, with
+the ``in_voltageY_sampling_frequency`` attributes set to 1 MHz, the effective
+sample rate is 250 kHz.

-- 
2.43.0


