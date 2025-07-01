Return-Path: <linux-iio+bounces-21199-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02364AF024E
	for <lists+linux-iio@lfdr.de>; Tue,  1 Jul 2025 19:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7D1148551A
	for <lists+linux-iio@lfdr.de>; Tue,  1 Jul 2025 17:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08C027FD60;
	Tue,  1 Jul 2025 17:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmuVcvhQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CEC3596B
	for <linux-iio@vger.kernel.org>; Tue,  1 Jul 2025 17:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751392615; cv=none; b=YYITRhMLBpA0GfxA/D/2iTjiYsTikknxbrNryHzZGYph0GXApQBWDQ8R2FYN5L5iahYlnqofGztBO9NN/IkfQctcp/bBmX7GuB6fAgtzzBSwmD7y7193jrVgwFmgTLjtQOYnP7fM4OGqxUYNL2jblBGool/FvXm8ktq8V/ZU930=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751392615; c=relaxed/simple;
	bh=eIomWXWVCti3l8hWeUq7AusukgukqKe7mFfBjWbaOew=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=hyklIUses/jZ9fdqePe8zYYne6wu3IAhDHvGkqEllp8j2pRRgPb2Cd8hw8XdrRv01uKWIQDcFAE5Cboa5nmdS6+7FUOramSnLmBl+XbIbRV47gC/Dc+e0tRkrr3LkbselNwas9MakfAg+wnTEuoaGtuW6J9MmWdU+G8FB79f1mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmuVcvhQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60732C4CEEB;
	Tue,  1 Jul 2025 17:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751392615;
	bh=eIomWXWVCti3l8hWeUq7AusukgukqKe7mFfBjWbaOew=;
	h=Date:From:To:Subject:From;
	b=bmuVcvhQ9gdIiO4Xfkg2qMuRxHM36OaX/tQuKPATbbchdWq8E2S9THDpq0l5nXf9F
	 l83NIkUq6/vDD+3aiyYUfYt4Ikx6ZFn/3Ijq4C+TwW7EB0OE/WLNubY6iNocM2cCW7
	 Czywr6/Wb88jvnxkhlGwKMTk6dZFSHXoF8JurawJtkT2a+dLTgxsnYE3Ed5jdAFxkF
	 G5xzHNO1QKnorJ1JRXT2ouKaa5V7c9nIID2dDWL9kj+xVEl9m506tg7i9bPBkyEXBj
	 hnQVyV1FC+/HJsBCJGdjDfbYdfX6cG8r6TkSQ9OKWrBh10PCQX3v5gIcWgsE6i8PSF
	 qzn5GxAOSIHuw==
Date: Tue, 1 Jul 2025 18:56:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] IIO: 1st set of fixes for 6.16
Message-ID: <20250701185650.4c5a6872@jic23-huawei>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-6.16a

for you to fetch changes up to 1131e70558bc70f1fc52515281de2663e961e1cc:

  iio: dac: ad3530r: Fix incorrect masking for channels 4-7 in powerdown mode (2025-06-29 17:15:40 +0100)

----------------------------------------------------------------
iio: 1st set of fixes for the 6.16 cycle

The usual mixed back of the recent and ancient issues that have surfaced
so far this cycle.

iio-core
- Fix a possible out of bounds write on writing string terminator.
iio-backend:
- Fix a possible out of bounds write on writing string terminator.

adi,ad3530r
- Fix wrong masking for channels 4-7 in powerdown mode as they are in a
  second register and mask assumed all in one larger register.
adi,ad7380
- Fix parsing of adi,gain-milli property by reading it as u16 as specified
  in the binding.
adi,ad7606
- Tweak dt-binding to allow both interrupts and backend to be wired up
  resolving some dt_schema warnings.
- Mask value before returning it in register read as for parallel busses
  both the value and (unwanted) address are read back.
adi,ad7949
- Use spi_is_bpw_supported() to correctly handle bits_per_word_mask == 0
  which means default value of 8.
invensense,mpu3050
- Fix wrong number of interrupts in the binding as minItems should have
  been maxItems.
maxim,max1363
- Two related fixes for a long running mismatch between array indexes
  that now results in warnings after the core gained a sanity check.
  Resulted in unnecessary channels being sampled.
nxp,fxls8962
- Fix a use after free in fxls8962af_fifo_flush() if it races with buffer
  mode tear down.
st,sensors
- Stop using indio_dev->dev before it was initialized as the parent device
  should be used anyway for error messages and similar.
st,stm32-adc
- Fix a race when installing chained IRQ handler.
x-powers,axp20x_adc
- Add missing sentinel in ADC channel map (avoid out of bounds read).

----------------------------------------------------------------
Angelo Dureghello (1):
      dt-bindings: iio: adc: adi,ad7606: fix dt_schema validation warning

Chen Ni (1):
      iio: adc: stm32-adc: Fix race in installing chained IRQ handler

Chen-Yu Tsai (1):
      iio: adc: axp20x_adc: Add missing sentinel to AXP717 ADC channel maps

David Lechner (3):
      iio: adc: adi-axi-adc: fix ad7606_bus_reg_read()
      iio: adc: ad7949: use spi_is_bpw_supported()
      iio: adc: ad7380: fix adi,gain-milli property parsing

Fabio Estevam (2):
      iio: adc: max1363: Fix MAX1363_4X_CHANS/MAX1363_8X_CHANS[]
      iio: adc: max1363: Reorder mode_list[] entries

Kim Seer Paller (1):
      iio: dac: ad3530r: Fix incorrect masking for channels 4-7 in powerdown mode

Markus Burri (2):
      iio: backend: fix out-of-bound write
      iio: fix potential out-of-bound write

Maud Spierings (1):
      iio: common: st_sensors: Fix use of uninitialize device structs

Rodrigo Gobbi (1):
      dt-bindings: iio: gyro: invensense,mpu3050: change irq maxItems

Sean Nyekjaer (1):
      iio: accel: fxls8962af: Fix use after free in fxls8962af_fifo_flush

 .../devicetree/bindings/iio/adc/adi,ad7606.yaml    |  6 ---
 .../bindings/iio/gyroscope/invensense,mpu3050.yaml |  2 +-
 drivers/iio/accel/fxls8962af-core.c                |  2 +
 drivers/iio/accel/st_accel_core.c                  | 10 ++---
 drivers/iio/adc/ad7380.c                           |  5 ++-
 drivers/iio/adc/ad7949.c                           |  7 ++--
 drivers/iio/adc/adi-axi-adc.c                      |  6 ++-
 drivers/iio/adc/axp20x_adc.c                       |  1 +
 drivers/iio/adc/max1363.c                          | 43 +++++++++++-----------
 drivers/iio/adc/stm32-adc-core.c                   |  7 ++--
 drivers/iio/common/st_sensors/st_sensors_core.c    | 36 +++++++++---------
 drivers/iio/common/st_sensors/st_sensors_trigger.c | 20 +++++-----
 drivers/iio/dac/ad3530r.c                          |  4 +-
 drivers/iio/industrialio-backend.c                 |  5 ++-
 drivers/iio/industrialio-core.c                    |  5 ++-
 15 files changed, 80 insertions(+), 79 deletions(-)

