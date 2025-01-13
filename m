Return-Path: <linux-iio+bounces-14309-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AED80A0C2E2
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 22:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAF67169BD7
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 21:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677E51D5145;
	Mon, 13 Jan 2025 21:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IITjvqHS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7391C8FD4
	for <linux-iio@vger.kernel.org>; Mon, 13 Jan 2025 21:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736802057; cv=none; b=icxPbCQwRB+Jf/BVA3skU94b5vweGlmggdttPhD12vgNLmYi/QARR+EY6T3qW4RAswB70/s08GOwYfAkU9fgymq6zb5bl2sDygIUpHH2Y9OY8ow4CGLDM5RYIpKkQpF+6OHCE5WUicYhb7J6cIF7rReu1psUkfxLm9IACK5XbZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736802057; c=relaxed/simple;
	bh=+XxJO96MN8GyA2olPpEPgu0OAhPuT0MCx2LmULLlwBg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MmD2sXH56Xol5gn1A9neL0xdV6EQAHYUxtFaVWuPJx54cy8rPlfkkkXdcXz7qkIxGMtjUoQVt0bRNAGZeZIrx1lTIdJcJDX2XI40lD1J7BDeWApZtxmCAgb4rgXAOnKYG2mLh7oAp9SLvGVQIssWFlnfFq77//EWmimZ97uU88Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=IITjvqHS; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-71e3284f963so2441983a34.1
        for <linux-iio@vger.kernel.org>; Mon, 13 Jan 2025 13:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736802053; x=1737406853; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TKg1ZIerSTCW5+x1RlJGDBMD+CW27K/9Q4mm4yRANFM=;
        b=IITjvqHShnuOrG6QmJonpZSMhG23JWqAq2e9B2h4xs0scmLS1nXVbexcTmo8iib54M
         AJnMzoEv+ajIKnjh552+Q8RSxvjHKEmKO0nvwOvVaOyi3F9I/QdJCmdClfYXYQ3guMLk
         goOCIrWYRmJNpijOoUidPZAiDP0sCFZqvFpQWNYcXBOxTxHpSLotX4XPrLMpbYqddF+f
         9sq4MY5S/90YyOffZ7+7SKJLw+k2e/+MuZciVFaWYl5NLkriPXf0BEpzRggmRoHgNPBC
         Z97bHraNyTZyakS5VIu5Aa7+uiVqC3XZXtPEjIhr3oda4wwJATnZEHBnhiNrfDtOGRyi
         QkjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736802053; x=1737406853;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TKg1ZIerSTCW5+x1RlJGDBMD+CW27K/9Q4mm4yRANFM=;
        b=P5ucRdwH/4gc1fMQo7ZsRRozoVcCXEJbRIDApZTQvRYfdfQSshq+TFjXwWDqNYDyDB
         mA0tAs6cb4m5BUnD2TM2BMtvuvG4zAUl6RSTbcc+K97rkaGV0Rao4xB3pYLrXpRg1L2G
         l3yg0znnBAfl9wkEdBWWmlHmKpdb0A6My4FGcQjc3QcSjLbKjB0ui9RJX/bMUkIw83G6
         lNvsToLg+t1gKe+NSzK1vk8cyaFlin4yPhXqaZdgfa/WnOLvGfnEfhNH6arsrI4V9vgl
         2sNMOg5QBpRaH7Q/jqV6AcwaonpRRqPMLsnG/rkwX5y9AJr0mPPlmZdNzU7j0XhAbYkV
         bdNg==
X-Forwarded-Encrypted: i=1; AJvYcCW1YiXye0f8p3GuOtrU/ml1o+2rveqXYDTG8ZTWzSDNWYMh5zQ+jg21/Y3V9nWZpDjvIFrsDbZ6EH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyubA3XpBKAVGQdN73NgYH4AMNtC/fxiaV+jGkqvc3RsPyOR32a
	kpdIb8Ds6Ug02e1J+q2FIs4RWl6qFq+Bd0tnM1HFYcgvKLSWQW6/ME3iZmC7Vp4=
X-Gm-Gg: ASbGncsWveg4GO3jks27OfDTdSA6tw9Tq5TvWSXO57FNUxnOZOpZtewjLt6gEGcBwIE
	EjSyujG4w+fpjoaSVs2N5mo6d6zwYSAXhm0Y9jIEOyfurXznFDN2cfFbCK8dnlrZpphK6v4wxJt
	WYJ3GmBmvSxBAe9xp0CNZw6j/uhXvkcVG4p96tcJyv02fZ8ulIeY/QzPEBtdaCUWHhFOweq+wMX
	56kBRzoAnxgs1tlz6cSkvbeb7wPYbPgj/jejsS+UbBtMLD88zLCa0rpcK6cMSvxgATarNhsZlOG
	OzDRr0jazA0J
X-Google-Smtp-Source: AGHT+IGQwUa6ClCD2HbBTBy7UzdHDnH0UU+cNZvOpmP9ULHc/rbUBz/RZt0nxjeF6LRGgb3GKehwAQ==
X-Received: by 2002:a05:6830:678e:b0:71d:fc52:1ab6 with SMTP id 46e09a7af769-721e2e9b660mr14413764a34.23.1736802053400;
        Mon, 13 Jan 2025 13:00:53 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7231855effasm3927744a34.33.2025.01.13.13.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 13:00:52 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v7 00/17] spi: axi-spi-engine: add offload support
Date: Mon, 13 Jan 2025 15:00:05 -0600
Message-Id: <20250113-dlech-mainline-spi-engine-offload-2-v7-0-e0860c81caae@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANV+hWcC/5XSzW7DIAwA4FepOI8JDAbS095j2oEf0yK1SZdkU
 auq7z6SSq009ZBdEEbiszG+soH6QgPbbq6sp6kMpWtrYN82LO59uyNeUo0ZCNACpeDpQHHPj76
 0h9ISH06FU7ubt13Oh84nDtznSMo2IqAPrEqnnnI5L1k+v2q8L8PY9Zcl6QTz6f/8Cbjgzgrr6
 xK1wo/gL4cSenqP3ZHNKSb1ZC3AOlZV1moQpDFl04QXrH6wUoBax+rKZicBQ9Nk9PIFi09WSlz
 HYmUDeScxJCT/qgnmyYKU61gz99YRodUJk1B/2Nv9P3v6/qnDMt4/lZ38WOWS6uSQScqEHMEAo
 YEYZgc0NSYFo02jhdEKzDIXj1vJGU25yc5bJZQDSCgSOuEbCiG5pISOzvvlVvAD8VrLsYzbTUv
 nkdcHopBS1Opuv+hR03/SAgAA
X-Change-ID: 20240510-dlech-mainline-spi-engine-offload-2-afce3790b5ab
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
 David Lechner <dlechner@baylibre.com>, Axel Haslam <ahaslam@baylibre.com>
X-Mailer: b4 0.14.2

We've got Reviewed-by's from all of the relevant maintainers now other
than SPI, so up to you Mark to say what you want to do with this.

If we think this is good enough to go in, the SPI patches should be
applying fine since this is based on a recent linux-next. But the IIO
patches will need some care. There are dependencies on both the
iio/fixes-togreg and the iio/testing branches as well as a couple of
patches that haven't been applied yet because they are waiting for other
dependencies [1]. Given the timing in the merge cycle, if Mark picks up
the SPI patches and they make it into 3.14, then Jonathan can pick up
the IIO patches after the 3.14 merge window closes. Or we can wait until
then for everything to go in at once.

[1]: https://lore.kernel.org/all/20241124125206.1ffd6e6c@jic23-huawei/

---
Changes in v7:
- Addressed some very minor feedback.
- Link to v6: https://lore.kernel.org/r/20241211-dlech-mainline-spi-engine-offload-2-v6-0-88ee574d5d03@baylibre.com

Changes in v6:
- Dropped the "spi: dt-bindings: add trigger-source.yaml" patch. It was
  reworked and merged into dt-schema in
  https://github.com/devicetree-org/dt-schema/pull/147
- Adjusted other dt-bindings patches to account for above change.
- Dropped one iio patch that was already applied to iio tree.
- Added a DAC patch to make use of the TX DMA stream API.
- Minor fixes and improvements to other patches based on feedback.
- Link to v5: https://lore.kernel.org/r/20241115-dlech-mainline-spi-engine-offload-2-v5-0-bea815bd5ea5@baylibre.com

Changes in v5:
- Dropped pwm patch. A variant of this patch has been picked up in the
  pwm tree.
- Addressed review comments (see details in individual patches).
- Added some polish, like MAINTAINERS entries and updating ADC docs.
- Link to v4: https://lore.kernel.org/r/20241023-dlech-mainline-spi-engine-offload-2-v4-0-f8125b99f5a1@baylibre.com

Changes in v4:
- Dropped #spi-offload-cells and spi-offload properties from DT bindings.
- Made an attempt at a more generic trigger interface instead of using
  clk framework. This also includes a new driver for a generic PWM
  trigger.
- Addressed IIO review comments.
- Added new patches for iio/adc/ad4695 as 2nd user of SPI offload.
- Link to v3: https://lore.kernel.org/r/20240722-dlech-mainline-spi-engine-offload-2-v3-0-7420e45df69b@baylibre.com

Changes in v3:
- Reworked DT bindings to have things physically connected to the SPI
  controller be properties of the SPI controller and use more
  conventional provider/consumer properties.
- Added more SPI APIs for peripheral drivers to use to get auxillary
  offload resources, like triggers.
- Link to v2: https://lore.kernel.org/r/20240510-dlech-mainline-spi-engine-offload-2-v2-0-8707a870c435@baylibre.com

Individual patches have more details on these changes and earlier revisions too.
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
streamed to an external sink). This sequence of transactions can then be
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

---
Axel Haslam (1):
      iio: dac: ad5791: Add offload support

David Lechner (16):
      spi: add basic support for SPI offloading
      spi: offload: add support for hardware triggers
      dt-bindings: trigger-source: add generic PWM trigger source
      spi: offload-trigger: add PWM trigger driver
      spi: add offload TX/RX streaming APIs
      spi: dt-bindings: axi-spi-engine: add SPI offload properties
      spi: axi-spi-engine: implement offload support
      iio: buffer-dmaengine: split requesting DMA channel from allocating buffer
      iio: buffer-dmaengine: add devm_iio_dmaengine_buffer_setup_with_handle()
      iio: adc: ad7944: don't use storagebits for sizing
      iio: adc: ad7944: add support for SPI offload
      doc: iio: ad7944: describe offload support
      dt-bindings: iio: adc: adi,ad4695: add SPI offload properties
      iio: adc: ad4695: Add support for SPI offload
      doc: iio: ad4695: add SPI offload support
      iio: dac: ad5791: sort include directives

 .../devicetree/bindings/iio/adc/adi,ad4695.yaml    |  13 +
 .../bindings/spi/adi,axi-spi-engine.yaml           |  24 ++
 .../bindings/trigger-source/pwm-trigger.yaml       |  37 ++
 Documentation/iio/ad4695.rst                       |  68 +++
 Documentation/iio/ad7944.rst                       |  24 +-
 MAINTAINERS                                        |  12 +
 drivers/iio/adc/Kconfig                            |   2 +
 drivers/iio/adc/ad4695.c                           | 445 +++++++++++++++++++-
 drivers/iio/adc/ad7944.c                           | 307 +++++++++++++-
 drivers/iio/adc/adi-axi-adc.c                      |   2 +-
 drivers/iio/buffer/industrialio-buffer-dmaengine.c | 144 +++++--
 drivers/iio/dac/Kconfig                            |   3 +
 drivers/iio/dac/ad5791.c                           | 179 +++++++-
 drivers/iio/dac/adi-axi-dac.c                      |   2 +-
 drivers/spi/Kconfig                                |  16 +
 drivers/spi/Makefile                               |   4 +
 drivers/spi/spi-axi-spi-engine.c                   | 314 +++++++++++++-
 drivers/spi/spi-offload-trigger-pwm.c              | 162 +++++++
 drivers/spi/spi-offload.c                          | 465 +++++++++++++++++++++
 drivers/spi/spi.c                                  |  10 +
 include/dt-bindings/iio/adc/adi,ad4695.h           |   7 +
 include/linux/iio/buffer-dmaengine.h               |   7 +-
 include/linux/spi/offload/consumer.h               |  39 ++
 include/linux/spi/offload/provider.h               |  47 +++
 include/linux/spi/offload/types.h                  |  99 +++++
 include/linux/spi/spi.h                            |  20 +
 26 files changed, 2349 insertions(+), 103 deletions(-)
---
base-commit: 2ba607f3f13e4cb147ad0f05e3c6de4a544c9a52
change-id: 20240510-dlech-mainline-spi-engine-offload-2-afce3790b5ab
prerequisite-patch-id: 7e6d36bfc262e562cb74d524e96db64694064326
prerequisite-patch-id: d864ef9f8a7303822d50d580a9ebbd8d304c8aa6

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


