Return-Path: <linux-iio+bounces-14323-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0A7A0C327
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 22:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AE011654E1
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 21:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114161FBBF3;
	Mon, 13 Jan 2025 21:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oO8oVVzk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F131FA27F
	for <linux-iio@vger.kernel.org>; Mon, 13 Jan 2025 21:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736802074; cv=none; b=Ky1BlLRwrS956h2jBbRiCv67d7IUDwke7SBQpz1r7bDEMDUe6fhLJQxVN3yhcB13HPE1umKPs+G08BVOUdJ9OExrB5tTK3Muv3VD57eaE+vR5Y9P7RD4YIVTJuEEFCXq35NZL2gzcdbhIVTzmKND2ZU49iaWCJ/DsAuEhY7FohY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736802074; c=relaxed/simple;
	bh=DhX51StZjS6ZG3+/IYLjnj3db6LuckpDYDUdYX9k1yk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r+HamOjMrmWqRhC35ZhvTLkP+l/wfGP/1rzXNqY8SJXZC+Ov0vVH6taAdQke7qNKUoawhU7rSNEQBfSgawH/r2xf//+/DAlMiaX0b6LajaZXxndxoXP9/18xtM7GEgUj0s/IFCznocaeKpj74tH5wBB4ZtAyBBB3oTf0TQ2R4t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=oO8oVVzk; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-71e2bc5b90fso2450706a34.0
        for <linux-iio@vger.kernel.org>; Mon, 13 Jan 2025 13:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736802069; x=1737406869; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3uXVd6FnRPX1W8Wg/eWBdOZEvpGo7dHFBW2WCW32Bdw=;
        b=oO8oVVzkgh/3DbqDs4SG4VVOS4uI+OBm5VGglyfYJX0R42kcxpc2GCknp5c/2qWI2/
         sEN3OE3EQKcokewCpz1Mf8OGnvMt+nLhikf4CYbMbJCdreNJpH1ySgq27ioaYowtp1jB
         dorfejL39eBJkAB4wHhITwrlkCz/ksL6PWY9ODrC/DOhtyWyHUhIIjy6nqB9KSkzi8bx
         hRG322g04gTXwnrNI8C8C7qv8xCIFywYxouRWQBFiXsQq7qYEILwTQe5VMAg6r/fyp1M
         T5onHXNLtdl8o9yzC+Hlx8Gu3DllHKhU943AlXnAQ3eD4h58W8Opb7MoY204C+w3eXLC
         ABlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736802069; x=1737406869;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3uXVd6FnRPX1W8Wg/eWBdOZEvpGo7dHFBW2WCW32Bdw=;
        b=WqPJOBDmP66pcNlyUuo3gXoCnnHddX4qwgzovCOddcU/pZTreNyx9vl3tFhTmSwFxZ
         ePBAVI0ShtedV8Pu8ar6cZaCpBwkMOXVBubrdCSFEIbiK4lMvJJ629Bn7fOJFWZl/gcg
         tvan6ZZ3uxlbKdB9n9SGdglgiaLwRBI5D8jDslrsLbv4xNWJC0xeLWXVDeLaPVa0NuD/
         gSc0lentrsaoF8IGwK++ec3SE36V4jZ7X6KzbKfCJsVB68pYi6cHSdpqhBnRdaXNz1NA
         Y+ygfNRgqnfKZfkid3dYy3LlxkTNyVNC48exanr81mKvmzeDz/IriLB15iO4hdCpCH5J
         J74A==
X-Forwarded-Encrypted: i=1; AJvYcCWxJbbzcS0MTPsO1PnkID7bdwIjPV8AjHOXoyyEVs2K73NBcV2wgarxRoOl7Y7NntgXmD9nfaYN8kw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQYE4iyayYKUEsQdt5/+HzS8EsDew64VcVFYd8QpR/Bb05llFE
	EgzWwT3087QzaTPDa/RBW0U1FAksXsWltozXQKqzUzDZ82am/siUAG44+JUWZLg=
X-Gm-Gg: ASbGncsRr82RzAXa8f003U8B42+92VWjfwhH+G9VuV6fRdxxvDbecyChCDpokVm5hj3
	3OQ6uBSHJI61LzFoL5x0RKpEkCJwtcDH9s5KkpsDD8Zm5anVLhA7JjvmnjeXRoAsDePBkMmvBOA
	R/rR7lsMC0+VojHBiw0H4qJPI9csKpwQsqwZJFfZFTkaqAz2e62T7xw4hRe+XGZr2fAOLGxceV2
	Bj6CbxlmIuncX4Y27RY5vzbP7V9AF+ufSrCYK7YxpJaG2YYJe3WlMBOT67B8TGOpXSstDfggIS7
	wuFvYSnwThFD
X-Google-Smtp-Source: AGHT+IGulA4qmDQ8WGRs1VyQjDXlPbYFho/RM3G2U9CehZxAyN2Da3u9SYC//Ca05O7nTL9Ydwk4QA==
X-Received: by 2002:a05:6830:2a9f:b0:71d:fa78:a5e7 with SMTP id 46e09a7af769-721e2cccb60mr16384875a34.0.1736802069599;
        Mon, 13 Jan 2025 13:01:09 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7231855effasm3927744a34.33.2025.01.13.13.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 13:01:09 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 13 Jan 2025 15:00:20 -0600
Subject: [PATCH v7 15/17] doc: iio: ad4695: add SPI offload support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-dlech-mainline-spi-engine-offload-2-v7-15-e0860c81caae@baylibre.com>
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
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

Document SPI offload support for the ad4695 driver.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v7 changes: none

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


