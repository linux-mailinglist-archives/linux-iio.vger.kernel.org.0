Return-Path: <linux-iio+bounces-13347-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFA29ED78C
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 21:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6436E168421
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 20:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E5B259490;
	Wed, 11 Dec 2024 20:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JqPs31EW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1905B225A52
	for <linux-iio@vger.kernel.org>; Wed, 11 Dec 2024 20:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733950498; cv=none; b=k6IdVc/aTxtefrJsZEOLs/Qki2w4U09iF12z15ZcuDNxFDUwwtYLyDa7psLEc/+N0p7/6gRErmG8mysWSlX1ciQuch5cUH0c0lKX8QtnmUYRUOWDibXEuGHEN5sqkdt02ZhoQUbSe362bif4mjIIShEE9czVXwaXWeOSjHBZWZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733950498; c=relaxed/simple;
	bh=OvwiQLnYA0FC4btps/SB28eG/A2uLzi8u4tHo5Ohxic=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=i4o+T5aPGW0Ao5U9ffUAgTI8zFKnVyvHtSxQb2MECDcgmBibD2i//Nh5ARJNA+yl11Z3ImmbH3qpmKSP9q5HHahJ20kJKoxc6LJMMw81QC/tocfIxwhgfW/7cDXm9hHdEyPJgd3I1aRQitSrNVEXGr5TtUSgkzOiI0t29PH9fMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JqPs31EW; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-71e22b2387cso512554a34.3
        for <linux-iio@vger.kernel.org>; Wed, 11 Dec 2024 12:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733950494; x=1734555294; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W6v76obBpEyhyDBRmwYte1jAQRvqqCqDiU8b8n9rTgs=;
        b=JqPs31EWFlctSOKZmmjkJPQgXw2ga4CuwPBdtrvAEjHkf5yAnVLpLC6Tu277Tl0ZSL
         gBf28vRo4lXjWr+kq+DDlXsY1kGIG6ntpZWjwYE1DIqKPsHviTtfyx2cpF8ZMSuzUQcV
         fkjmBrEDFJovwaTb2lHebjmqS6DbRysSq60tiywvJjJ/4RGYEttXfzbRX6XnmFhd2hBI
         RqLfHF48DFwe8SnOzsN0oELcgS8U6gCJ//RXlddmqtRSbF4VbYCTifrdtBxHt4lkAq33
         mKbIl7+LAZ1+Y05XThcED6Ytk05+uEnM+qQD1Y1uPYe5IRztVbZYO6DE2vwTn2rpbdXw
         4E3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733950494; x=1734555294;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W6v76obBpEyhyDBRmwYte1jAQRvqqCqDiU8b8n9rTgs=;
        b=XyYdAFallQl8frxAiTIqsG6F0GEy/y5qpIQsBMWtEOY/R5RcwLVtkxotfrFCXR/OdR
         37Pz8h0nGlrb4u4ACmlmpKlQh7HzVtU3irYfbQB4dxZOzcTfkPNTlb08Ng8XA6tO7cco
         EwBtp67n0pH+nZcLErd0MnIoYWqFPjyJQVcBKE3DmcBVgqQnoii97oj+ygCj3o42nHSz
         3YgPeEcO4ICa7tZOJHTjLlcC4R81ApuBPyefE5b/aYW+b9S7ViaL9Vgj3nVpg7j38PTD
         hOHfLwX1o+c3LGI8uzKtuVocvTHCuplkPyLhGZAv3OzTvP+HxPoQ2wh7FuKTJeEWqWck
         wikw==
X-Forwarded-Encrypted: i=1; AJvYcCXIuEb1PYaHuO99L3XS8EEY10AvyfLfbzl9DXbrdI0ZXHrShNfYw2IyXTmjgYaRlHpCRymhjYqDi5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDD6xyrikg/4DN49TSFNjuNj0FcnzGV2GLSTQPbC8fFzQnGh+1
	xpL0uBGBOxF531gLDXpgDN2tToINFgVcq6CwOHLwAHKA8dlEtfbho/kpuq1J0n8=
X-Gm-Gg: ASbGncvLmA9WBD2IF+qMCWNXvTapanfIVmVzyepMVKwsisT7V9CrJfNcSCb/RP0TMwT
	bbkczK+aV7y/r40dKxMQzcCKxZqnuNyCLRz397rmkygi6f95YSZTvoB7bGKiVJIin3FuRiOMl4j
	vi/Vgk3vczGwMt4USvPPDywSTpYjndaVcN9hZtlUVNUNhL5IUJ41Sp5GYmKmR0Ds+u2Q0bjd2vY
	NGMT7HnlgpA5j53RML0WXfpY5deKOeeS3thcy/eJl7qFNGAr2T3OZG6pXZsTnD64J/O+ZJHM2jW
	AbZfYe3GzQ==
X-Google-Smtp-Source: AGHT+IFNDEOjvNOX5bJwM+maGY3ABusKGwINCwh8iOScXEB4QUNI10mrV2AERnfTCXNrv8EfRusM7w==
X-Received: by 2002:a05:6830:6c09:b0:71d:63fc:2ea6 with SMTP id 46e09a7af769-71e29bb5a0fmr595822a34.8.1733950493780;
        Wed, 11 Dec 2024 12:54:53 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71def651fb2sm1888288a34.27.2024.12.11.12.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 12:54:52 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v6 00/17] spi: axi-spi-engine: add offload support
Date: Wed, 11 Dec 2024 14:54:37 -0600
Message-Id: <20241211-dlech-mainline-spi-engine-offload-2-v6-0-88ee574d5d03@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA38WWcC/5XRzWrDMAwA4FcJPs/Dkf972nuMHWRbbg1p0iVZa
 Cl997kptDB66C7GMuiTLJ3ZRGOhiW2aMxtpKVMZ+hqYt4bFHfZb4iXVmIEAJXQreOoo7vgeS9+
 Vnvh0KJz67fU65NwNmDhwzJGk9SJoDKxKh5FyOa5VPr9qvCvTPIyntegC19f/+QtwwZ0VFusRl
 dQfAU9dCSO9x2HPriUW+WAtwGusrKxVIEjplI0PT1h1Z1sB8jVWVTa7FnTwPmtsn7D6wbatfo3
 VlQ2ErtUhacK/Q7jcBj/S90/d6nybPjvgXOWSNo0lk6QJOYIB0gZisCppUORNCkYZr4RREsy6w
 HtWckZR9tmhlUI6gKRF0k6gpxCSS1Ko6BDXrIAT8drLvsybpqfjzNcPQitqd5df5Lt1YXsCAAA
 =
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

Not much to say for this revision. The main changes were making the
trigger-sources/#trigger-source-cells properties more generic,
splitting up the spi-offload.h header into consumer/provider/types.h
and adding a DAC driver patch to make use of the TX DMA stream API.

If we think this is good enough to go in, the SPI patches should be
applying fine since this is based on a recent linux-next. But the IIO
patches will need some care. There are dependencies on both the
iio/fixes-togreg and the iio/testing branches as well as a couple of
patches that haven't been applied yet because they are waiting for other
dependencies [1]. So best would be to let Mark pick up the SPI stuff and
create an immutable branch and let Jonathan work out the IIO stuff.

[1]: https://lore.kernel.org/all/20241124125206.1ffd6e6c@jic23-huawei/

---
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
 drivers/iio/dac/ad5791.c                           | 166 +++++++-
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
 26 files changed, 2336 insertions(+), 103 deletions(-)
---
base-commit: 8ca8e57217e8263bc6dda6b77ef6c9051c2b6241
change-id: 20240510-dlech-mainline-spi-engine-offload-2-afce3790b5ab
prerequisite-patch-id: 7e6d36bfc262e562cb74d524e96db64694064326
prerequisite-patch-id: d864ef9f8a7303822d50d580a9ebbd8d304c8aa6

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


