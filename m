Return-Path: <linux-iio+bounces-4941-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A06F8C2DFD
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2024 02:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED69D1F22F7C
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2024 00:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894D7FC1D;
	Sat, 11 May 2024 00:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PgqPKZSh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31228831
	for <linux-iio@vger.kernel.org>; Sat, 11 May 2024 00:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715388600; cv=none; b=Y17mMNPbtOLsDaAb+ZHddxXLXByZir5ZZRltkEkpPq9qVHO9OxqP+Gj2g8YgGPNASNtGm6frAKFV4D3+fypY+L70CJfSbp8wNcklY/oeCRiFaCio9Rj+SMQaJtTyFCc0U7meb/Hg1UFMO0oY4t0wEBVsLwnbuO3DOp+xex/o82E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715388600; c=relaxed/simple;
	bh=hSduPC43AAmHpwPQqz1x75rIfbxY36WPQViOrqNdCXY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NrXIZdooknwSf+SUBfAXNRi21oCozMqI8aq7ND7O4kCVLUzbR4bC1fro+6mLgQLPVctMumSAVUWNdi7q/JAqk96yF2EdkS9xTEtYITQ9c+up+fZusVsDY/h7beKqQyEdsi7KiIEfMAeJtboAiYLNJvmeTRNzGvmw4IOes5vSOxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PgqPKZSh; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5b27c5603ddso905370eaf.1
        for <linux-iio@vger.kernel.org>; Fri, 10 May 2024 17:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715388596; x=1715993396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BVdf4zx6zwtx6KZ3x+nZAgrV5XQ5p7PNnM/KaEXNehA=;
        b=PgqPKZShryV7YCuYvNJh72RMI6MwCpaUFXlF0H6EBPG3j73XNXWULsrr0xmZXYHFTr
         4/axtF5nodeiRjHGScTyellRTMpk65rpC8JLNz7GwiPfHOX5Tz1F9HRsbiMcCqIfr1RR
         MxU0NbeDdbq0eLMvlSNGDfCxfazJoAjWTxMxQVme1u+Fq6sG+zhGMRAH37kuZvIgtrU/
         pPe1Hofz7MMbAMZguT+hGfQb8srOQ2YsCYj6X1f5xbJRryBqgZvZqqiYumGNh/QA/Qso
         FsKd9h+ijMeBqLwaP8m+P/rf57Xa5MSciwIuj0PVbAk+LcUHWKQ22EV0EkuueDc/onrF
         MH0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715388596; x=1715993396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BVdf4zx6zwtx6KZ3x+nZAgrV5XQ5p7PNnM/KaEXNehA=;
        b=KfAC3wRdh9IifPeotusnkI0wNL64IBXPcQFtYZ2ALikR80Ce+Jrbaz6/vclXTbU234
         z0KXc9QJUHcNkKQPYPpLZVrZJnqVzbLAr8JNIClGVYS0PzwiDUtll2Xiz9BY8Pdp12CF
         J+iXmFIDU7athEZeOy1dVNnCKxIUbYq26llKQif0Qr0nUVkXe+CeDgdzl/TN8tJZVwFu
         LJ6CIEXXTt3YM3jniv0JcJ/ntimyQOawyTAlSB4LpgZvr92LJNLZeIkKpqcae9JLYP+B
         CdSMGXAOxy+f1VDk27SX3kV5Wg/9McDac6O4Yk4Cnu/sTyHw0RNtaO1r5Q91+wBURjLp
         43rQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6+SYAmtiC7vkEr5CnYZmjFBfsDcg7aR/NUq0G6qgFpP+BqZNgJaaxdDV81TBi318tdYoDqtCMTMbt04TC2ZqhpLDv6sw6UVo1
X-Gm-Message-State: AOJu0YzZ3qI0K/7il8OY9xjz/cFXcE+J/MBVo0eJI04/PHplpPxGziOY
	aK/me3VVpsSQHDlt0x0GyQ3Tc6HzlInZ33Zil6JrRt+TWliQwujzbXQIkssVEow=
X-Google-Smtp-Source: AGHT+IE+l08r2Jy3SWMc8suRQ79TUjdxsptNlzcVxHzk81oyrBKRUsd8jHwYQCd7VjjjNveGnPu6jw==
X-Received: by 2002:a4a:aa43:0:b0:5ae:fe80:7dd3 with SMTP id 006d021491bc7-5b2819d53d9mr3917970eaf.7.1715388596092;
        Fri, 10 May 2024 17:49:56 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5b29015a3dbsm321132eaf.46.2024.05.10.17.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 17:49:55 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	David Jander <david@protonic.nl>,
	Martin Sperl <kernel@martin.sperl.org>,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH RFC v2 0/8] spi: axi-spi-engine: add offload support
Date: Fri, 10 May 2024 19:44:23 -0500
Message-ID: <20240510-dlech-mainline-spi-engine-offload-2-v2-0-8707a870c435@baylibre.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

Continuing the discussion started a few months ago [1]...

It was suggested that we were trying to do too much in one series. So
we split out part of the series into a separate series that adds generic
support for pre-preparing SPI messages [2]. That work has been merged.

[1]: https://lore.kernel.org/linux-spi/20240109-axi-spi-engine-series-3-v1-0-e42c6a986580@baylibre.com/
[2]: https://lore.kernel.org/linux-spi/20240219-mainline-spi-precook-message-v2-0-4a762c6701b9@baylibre.com/

I was hoping to also break down the remaining work into smaller parts by
first only considering more generic offload support that could be used
with the regular SPI message queue and leaving out the hardware trigger
bits. But the hardware I have at hand is not capable of doing that so
this is the best I can do for now. (Happy to take suggestions if someone
knows some other hardware that could be used for this.)

There have been significant changes since the last version so I'll
discuss what changed in each patch instead of having a very lengthy
cover letter.

A working branch complete with extra hacks can be found at [3].

[3]: https://github.com/dlech/linux/tree/axi-spi-engine-offload-v2

---

As a recap, here is the background and end goal of this series:

The AXI SPI Engine is a SPI controller that has the ability to record a
series of SPI transactions and then play them back using a hardware
trigger. This allows operations to be performed, repeating many times,
without any CPU intervention. This is needed for achieving high data
rates (millions of samples per second) from ADCs and DACs that are
connected via a SPI bus.

The offload hardware interface consists of a trigger input and a data
output for the RX data. These are connected to other hardware external
to the SPI controller.

To record one or more transactions, commands and TX data are written
to memories in the controller (RX buffer is not used since RX data gets
piped to an external sink). This sequence of transactions can then be
played back when the trigger input is asserted.

This series includes core SPI support along with the first SPI
controller (AXI SPI Engine) and SPI peripheral (AD7944 ADC) that use
them. This enables capturing analog data at 2 million samples per
second.

The hardware setup looks like this:

+-------------------------------+   +------------------+
|                               |   |                  |
|  SOC/FPGA                     |   |  AD7944 ADC      |
|  +---------------------+      |   |                  |
|  | AXI SPI Engine      |      |   |                  |
|  |             SPI Bus ============ SPI Bus          |
|  |                     |      |   |                  |
|  |  +---------------+  |      |   |                  |
|  |  | Offload 0     |  |      |   +------------------+
|  |  |   RX DATA OUT > > > >   |
|  |  |    TRIGGER IN < < <  v  |
|  |  +---------------+  | ^ v  |
|  +---------------------+ ^ v  |
|  | AXI PWM             | ^ v  |
|  |                 CH0 > ^ v  |
|  +---------------------+   v  |
|  | AXI DMA             |   v  |
|  |                 CH0 < < <  |
|  +---------------------+      |
|                               |
+-------------------------------+

To: Mark Brown <broonie@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Nuno Sá <nuno.sa@analog.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: David Jander <david@protonic.nl>
Cc: Martin Sperl <kernel@martin.sperl.org>
Cc:  <linux-spi@vger.kernel.org>
Cc:  <devicetree@vger.kernel.org>
Cc:  <linux-kernel@vger.kernel.org>
Cc:  <linux-iio@vger.kernel.org>

---
David Lechner (8):
      spi: dt-bindings: spi-peripheral-props: add spi-offloads property
      spi: add basic support for SPI offloading
      spi: add support for hardware triggered offload
      spi: add offload xfer flags
      spi: dt-bindings: axi-spi-engine: document spi-offloads
      spi: axi-spi-engine: add offload support
      dt-bindings: iio: adc: adi,ad7944: add SPI offload properties
      iio: adc: ad7944: add support for SPI offload

 .../devicetree/bindings/iio/adc/adi,ad7944.yaml    |  58 +++++
 .../bindings/spi/adi,axi-spi-engine.yaml           |  14 ++
 .../bindings/spi/spi-peripheral-props.yaml         |  10 +
 drivers/iio/adc/ad7944.c                           | 147 +++++++++---
 drivers/spi/spi-axi-spi-engine.c                   | 267 ++++++++++++++++++++-
 drivers/spi/spi.c                                  | 202 +++++++++++++++-
 include/linux/spi/spi.h                            |  84 +++++++
 7 files changed, 741 insertions(+), 41 deletions(-)
---
base-commit: 14fde009028126f91c2bd72c404e425cf4f8aec3
change-id: 20240510-dlech-mainline-spi-engine-offload-2-afce3790b5ab

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


