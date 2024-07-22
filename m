Return-Path: <linux-iio+bounces-7802-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2685939610
	for <lists+linux-iio@lfdr.de>; Tue, 23 Jul 2024 00:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 467731F2259B
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2024 22:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE4D47F46;
	Mon, 22 Jul 2024 22:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SLKqfzRj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12437376E7
	for <linux-iio@vger.kernel.org>; Mon, 22 Jul 2024 22:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721685689; cv=none; b=AJJzUUHL6pMHGy9Hb+/vMdpFQD1Bp7OzCOU0QbvlGI5xEVgpYhzOZTTpRj7CAbQGujRQ5gUTKuATr2QvS8AMYoj6CkD/Y66C00c89n1ncoDo4dXXNrnTkvy6E6W4tuoZbXK/HmLc9VfrjuXTRyqHbmUXS3YcJcCwmfOyGtgmwHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721685689; c=relaxed/simple;
	bh=/ru1Bf2H9W5Kc4MG8k98hW6Wdp+YW4glK8+b1cnQf0M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QS0CorKAbp9gAppVSfBNPSAdGU4uXCPCaxXLr3ilvpQbcfmnBQ0t4sSFZUNdDB0cjLwS4mhmL6z1rgy5wCBds07ckmwyYQCLuhvYrI4FX/Oylofrvi1f+YDZ5fNcNC+JeIlZdi6go0hbP5P8Tk0jLcD5edVFWMfMWmR1R2ZA/Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=SLKqfzRj; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-264545214efso573311fac.3
        for <linux-iio@vger.kernel.org>; Mon, 22 Jul 2024 15:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721685686; x=1722290486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JAUt/ALexQ1OP269aBEvYCgpzgE08wFzuX6/YmuwpRo=;
        b=SLKqfzRjxDwjqOUfDwK4XoDQ0BrEtqMUVuPUjv8CfvaQd2kUDJHEgkBVRWXahZ2zC0
         SGUTZ52lfvyZYcxab7NsERSee2A9/2CvhTgjVMtEPj0EvGuX63I/86JfDj4tmYBTi7m9
         Ghw4rQBG+vfOh3r72cvGtT+3hRETI0qvoGo1BtVkZZUUWJYXnzE2tUgp+RFQ/yMAqLUY
         wU6dX2ao0KBRX/YsI+kbZ/vp2bp58st00Lk1KIK5YfoSW189DYqIBDAIq99YSYKfvErq
         eWIPUBcSkxnoXVWnmCuB2N3sHSPs/bw/L+gEqqsnOWtcdwrBI4WIeljHfoZaCXPWnERA
         06Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721685686; x=1722290486;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JAUt/ALexQ1OP269aBEvYCgpzgE08wFzuX6/YmuwpRo=;
        b=cu/yRduvr2pgkizLPLTo9M2vV/PhHqCoQHIz9FEferydEaL8Z7pSYZxE0frsohK+Ms
         u1zyxDkGFurOZnHbpoytiHQxSNO0F/xuDLe/1TgBV/AJLVGRkPk9X+Wr9NWshg+oZSpc
         1BspYCt7wPneVeZqnVKSEUdgpDY0KReZf1oJ+VQN8eGxjRQ1RTXSQ3opl8XsfA+YFIrO
         H/hpH8NjzXqF7OqgdcqghWgVK6TbfCNUkF34lPWJkXNAFRzaKZp7NalRMiTDDliPJFtx
         XKVMWF7HgHFifTMuVXzwMmjvBnxoXh2IjthidbU1wVw3orMaRJ5sGT892/zAjPW1wa/2
         DkAQ==
X-Forwarded-Encrypted: i=1; AJvYcCU54yLOwOPxxDjE7duCdEAEJXbYNvMh9gNYtDgcZ3ah59mP7XkCbrTr15WgfN5kqUmc6B2EupPpZxgv37vmUeFUTljuZlg7b8dO
X-Gm-Message-State: AOJu0YyHIiDtRn7lVXSLh8jzdh+GOBq9+Kfjav61FPKa2XnXK5rCBwYk
	fFAPDwiL41mZuGQfTWJxFWl2/aRXXm3FqsJqMdDuIXgLr/BkJNiSi8PD4JyVHJI=
X-Google-Smtp-Source: AGHT+IGuWCaXZ/ObQnICIEAQHJbPOg0EjyYDPnmTnt9i4wKh7ZomfYywEjSRg/G2c4JYj8HYTBA/Zg==
X-Received: by 2002:a05:6870:4714:b0:261:fd5:aa34 with SMTP id 586e51a60fabf-263ab54f89amr4628410fac.30.1721685685764;
        Mon, 22 Jul 2024 15:01:25 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-708f60a55e1sm1719911a34.11.2024.07.22.15.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 15:01:25 -0700 (PDT)
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
Subject: [PATCH RFC v3 0/9] spi: axi-spi-engine: add offload support
Date: Mon, 22 Jul 2024 16:57:07 -0500
Message-ID: <20240722-dlech-mainline-spi-engine-offload-2-v3-0-7420e45df69b@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.0
Content-Transfer-Encoding: 8bit

There is a recap at the end of this cover letter for those not familiar
with the previous discussions. For those that are, we'll get right to
the changes since the last version.

In RFC v2, most of the discussion was around the DT bindings, so that
is what has mostly changed since then. I think we mostly settled on
what properties are needed and where they should go. There are probably
still some details to work out (see PATCH 5/9 for more discussion) but
I think we have the big-picture stuff figured out.

Here is the actual devicetree used for testing to show how it all
comes together:

	trigger_clk: adc-trigger-clock {
		compatible = "pwm-clock";
		#clock-cells = <0>;
		#trigger-source-cells = <0>;
		pwms = <&adc_trigger 0 10000>;
	};

	...

	axi_spi_engine_0: spi@44a00000 {
		compatible = "adi,axi-spi-engine-1.00.a";
		reg = <0x44a00000 0x1000>;
		interrupt-parent = <&intc>;
		interrupts = <0 56 IRQ_TYPE_LEVEL_HIGH>;
		clocks = <&clkc 15>, <&spi_clk>;
		clock-names = "s_axi_aclk", "spi_clk";

		/* offload-specific properties */
		#spi-offload-cells = <1>;
		dmas = <&rx_dma 0>;
		dma-names = "offload0-rx";
		trigger-sources = <&trigger_clk>;

		#address-cells = <1>;
		#size-cells = <0>;

		ad7986: adc@0 {
			compatible = "adi,ad7986";
			reg = <0>;
			spi-max-frequency = <111111111>; /* 9 ns period */
			adi,spi-mode = "single";
			avdd-supply = <&eval_u12>;
			dvdd-supply = <&eval_u12>;
			vio-supply = <&eval_u3>;
			bvdd-supply = <&eval_u10>;
			ref-supply = <&eval_u5>;
			turbo-gpios = <&gpio0 87 GPIO_ACTIVE_HIGH>;

			spi-offloads = <&axi_spi_engine_0 0>;
		};
	};

A working branch complete with extra hacks can be found at [1].

Also, I took a detour looking into what it would take to get Martin
Sperl's Raspberry Pi DMA offload proof-of-concept [2] updated to work
with this. This way we could have a second user to help guide the
design process. Given all of the SPI hardware quirks on that platform
and the unsolved technical issues, like how to get accurate time delays
and how to work around the 32-bit DMA word limitation, it would be more
work than I have time for (at least without someone sponsoring the work).

[1]: https://github.com/dlech/linux/tree/axi-spi-engine-offload-v3
[2]: https://github.com/msperl/spi-bcm2835/blob/refactor_dmachain_for_prepared_messages/spi-bcm2835dma.c

---
Changes in v3:
- See individual patches for more detailed changes.
- Reworked DT bindings to have things physically connected to the SPI
  controller be properties of the SPI controller and use more
  conventional provider/consumer properties.
- Added more SPI APIs for peripheral drivers to use to get auxillary
  offload resources, like triggers.
- Link to v2: https://lore.kernel.org/r/20240510-dlech-mainline-spi-engine-offload-2-v2-0-8707a870c435@baylibre.com

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
David Lechner (9):
      spi: dt-bindings: add spi-offload properties
      spi: add basic support for SPI offloading
      spi: add support for hardware triggered offload
      spi: add offload TX/RX streaming APIs
      spi: dt-bindings: axi-spi-engine: document spi-offloads
      spi: axi-spi-engine: implement offload support
      iio: buffer-dmaengine: generalize requesting DMA channel
      dt-bindings: iio: adc: adi,ad7944: add SPI offload properties
      iio: adc: ad7944: add support for SPI offload

 .../devicetree/bindings/iio/adc/adi,ad7944.yaml    |   3 +
 .../bindings/spi/adi,axi-spi-engine.yaml           |  41 +++
 .../devicetree/bindings/spi/spi-controller.yaml    |   5 +
 .../bindings/spi/spi-peripheral-props.yaml         |  11 +
 drivers/iio/adc/ad7944.c                           | 173 ++++++++++-
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |  39 ++-
 drivers/iio/dac/adi-axi-dac.c                      |   3 +-
 drivers/spi/spi-axi-spi-engine.c                   | 341 ++++++++++++++++++++-
 drivers/spi/spi.c                                  | 226 +++++++++++++-
 include/linux/iio/buffer-dmaengine.h               |  11 +-
 include/linux/spi/spi.h                            | 169 ++++++++++
 11 files changed, 989 insertions(+), 33 deletions(-)
---
base-commit: 7a891f6a5000f7658274b554cf993dd56aa5adbc
change-id: 20240510-dlech-mainline-spi-engine-offload-2-afce3790b5ab

