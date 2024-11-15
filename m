Return-Path: <linux-iio+bounces-12325-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AEC39CF5E0
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2024 21:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA79F28A545
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2024 20:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BE31E25F4;
	Fri, 15 Nov 2024 20:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iLOt5OkK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3C21F12E1
	for <linux-iio@vger.kernel.org>; Fri, 15 Nov 2024 20:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731701951; cv=none; b=ucjTc83QKiIlj5NAxv4cdmlMc+SLscTRlbKdwwEfEYVNlUZmbgqq3n3reh9eZtywNbEzpKkyKytaxCeRDHu4XMuJjELLVxG9cact929unB6VWpHDcdrRWpPi0n+WU9L9lHuU4fWOOtfAnjTt9dUoX3lulq7whX4VgJVayfr6xEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731701951; c=relaxed/simple;
	bh=K0ELSxsB5ewnDfByel6azG1qzhpSdfFUlrceHRoZqqY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gkqqk5YB0wP2XxKvQPqz4WhIorKyJHn3Ve3KlDZmujUrl7IPpb6gk+K1cw0Y4NYuBd3m2Qc79WhyCNfC9K54z4yFI91lPAq5togLLX9KicLKO/XeItkTnmk9i0gn6GbBTvwx0zuN9ems8d7/o7ff4UFQLdKeO3FN1oRNotdXmeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=iLOt5OkK; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-28c7f207806so984294fac.3
        for <linux-iio@vger.kernel.org>; Fri, 15 Nov 2024 12:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731701948; x=1732306748; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gHWSp9g71dav0wBB3RsBnAwDxMnAi0+sYhD4RSgE92s=;
        b=iLOt5OkKff+H5qnAg29jnxdMSADjMWv2Sf9Mj0EybfejW3UveERNNhVF1EfBKL/QqY
         /cWsP4VzVQq6+dc/jkUd/wrmWOD+riSMQ4COkYHemH4zcDe/fWa798zioVavY0Ed0TWa
         dQ6wx329dxa1F8jhbx7rIUPaZGyA4Cwps7+E/3CKkjRpKmcvgapykEieeMwjY08vAOPl
         u8l0HFef/L10UTUNRKfE/4hRlpd2S1HKumYvcVh1dPVdBfxvgU0+/SXJ08BiItKXr8LP
         34CKDIcKbNdaHLLOnIz+Zgvk2ERupSs3ooqKJ1ucFJXCiNDvkXDYoiFOB/X4oRzDxqa4
         iLqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731701948; x=1732306748;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gHWSp9g71dav0wBB3RsBnAwDxMnAi0+sYhD4RSgE92s=;
        b=e6rL3gSGdfssiVmwVAnh28HUUw3or6aY2iab4EZa/DZtJTMlOw1xJmBctgW1NPS2EB
         2gkbBMFxfZO+HNM+5G24IHupD5Yn4EDp8pe/u62QnEcnN4NJsahD0ZnpsS85uGHXi8P4
         /99cqSGCEBYq3SMUi4v0PtvC958e56g5Gubw6MvT0vBPE/oe1BCp6F0MYwHfGA3A2Lo4
         PdGGeQ34JaYfdzA52y11bmfOjO9bbferRI6ZGoFs8vJ6E+xBbaX8yZoRJVFSE2TFPfH/
         lPLGZLvyn9E6VBV9ULlSLSz4aFLCFH49C4/pTdIKvTeIyEawPY5p2ZamssnB6rAHxSaf
         QYJw==
X-Forwarded-Encrypted: i=1; AJvYcCVCndIyaxeUDBXQQ1ksT8ThpT2BMdvZX2jy1Qy5C5mQK+40Q06uZ3FVw423Jd7rFX2Os1UxkrywvP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuxrjJIhosV8iu3L41/fPwtrJP50kfOI0kWunOSFPmuBvJ6Emr
	ZqQAi4tz3jyTfsKCMsllohPkT30YTI9M/lUYldTSA0trIXP/I4ZImG6X1IBxdQk=
X-Google-Smtp-Source: AGHT+IGWBHYcdZrBR+Etr+tBdm3Lz7gnqd+0QTKy8x+5SgSS97gRVwEjKew7vBfdhv9QAdngjnHbCA==
X-Received: by 2002:a05:6870:32d4:b0:27c:df1d:85c6 with SMTP id 586e51a60fabf-2962dd3a1c0mr3912680fac.8.1731701948269;
        Fri, 15 Nov 2024 12:19:08 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71a780ea62esm748978a34.5.2024.11.15.12.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 12:19:06 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 15 Nov 2024 14:18:52 -0600
Subject: [PATCH v5 13/16] doc: iio: ad7944: describe offload support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-dlech-mainline-spi-engine-offload-2-v5-13-bea815bd5ea5@baylibre.com>
References: <20241115-dlech-mainline-spi-engine-offload-2-v5-0-bea815bd5ea5@baylibre.com>
In-Reply-To: <20241115-dlech-mainline-spi-engine-offload-2-v5-0-bea815bd5ea5@baylibre.com>
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
X-Mailer: b4 0.14.1

Add a section to the ad7944 documentation describing how to use the
driver with SPI offloading.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v5 changes: new patch in v5
---
 Documentation/iio/ad7944.rst | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/iio/ad7944.rst b/Documentation/iio/ad7944.rst
index 0d26e56aba88..e6dbe4d7f58c 100644
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


