Return-Path: <linux-iio+bounces-26177-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B98CDC4FBA6
	for <lists+linux-iio@lfdr.de>; Tue, 11 Nov 2025 21:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80CBE3B2CEA
	for <lists+linux-iio@lfdr.de>; Tue, 11 Nov 2025 20:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54371324B0B;
	Tue, 11 Nov 2025 20:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVRgFHOF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BF533D6CB
	for <linux-iio@vger.kernel.org>; Tue, 11 Nov 2025 20:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762893767; cv=none; b=J2vkM3N2f1dhv6ws51/NuRZtF+bYKDAuj6Sif0vfE8Jkc0E3qsa5HvPdxoKTAGgkTCkDXvanuhGWornukY5JNgAEcHqg6l4dYFi6tidJQeMtT/Ohz+ze17rFy+iomdiuejdhjtUvpJS96KyY7Et6tq10xWKfFoMHNuxOPsAYo18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762893767; c=relaxed/simple;
	bh=IjwWKwjLXp4bWBQoxQ0unOLpxurM7Lubo5JAewrdshk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=RSEdHHmJ39blrERLRqRC2WY0YzfmQYk9kv4mCWTN5ImVVSrBIpeqdGLtts1RCiX+bCa/aVzRZOBCnRsZQZvsXrQgoCIVAnOelRlhKENf30/icPQrbjUy67xQYPUPaBzymVsY63Si7Jepa6Tbp/QTGf+thPkyElz2LS9l3v+hRnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVRgFHOF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D10A8C4CEF5;
	Tue, 11 Nov 2025 20:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762893766;
	bh=IjwWKwjLXp4bWBQoxQ0unOLpxurM7Lubo5JAewrdshk=;
	h=Date:From:To:Subject:From;
	b=YVRgFHOF1dFlWkiAt69LXhuWRFQQV0/ylrWqhTFOCJGDggzfHr3gB1D/76jsegCMq
	 kP6yrODFEhrwXRgBhNmLxcPPBKwMqMmIVXQPEMQXCMNDkXuqp3SKl68AILXuZ7cSFe
	 fdb1WPIy1Y22pIXJKwzqiZGp7hqNCX2MQmLL24UD019I8ku0HET+Jtaf8u8Voqipco
	 dt7aJVLUn6xA6Lm5U8JfF3//06XvekDBFNNo+lx6BMwO0vBc9ErCeMmR5gFXvqGmt1
	 3ArzN3KpKQHMUDeOQHMS/mN6QcZvUit5CnG4fIYiO1LbXLrT9TGiADTlVJHbirKI8g
	 ybLAp0hVDZ4/g==
Date: Tue, 11 Nov 2025 20:42:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] IIO: 1st set of fixes for 6.18
Message-ID: <20251111204241.283143b8@jic23-huawei>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fi=
xes-for-6.18a

for you to fetch changes up to 3aa385a9c75c09b59dcab2ff76423439d23673ab:

  iio: accel: bmc150: Fix irq assumption regression (2025-11-11 20:22:23 +0=
000)

----------------------------------------------------------------
IIO: Fixes for 6.18 (set 1)

The usual mixed back of brand new and ancient bugs.

dmaengine buffer / core
- Add new callback to allow fetching the providing device for a DMA
  channel. Use this to get the right device for the dmaengine buffer
  implementation.
adi,ad4030
- Fix incorrect _scale value for common-mode channels.
adi,ad7124
- Fix gain and offset for temperature channel.
adi,ad7280a
- Fix a factor of 10 error when setting the balance timer.
adi,ad7380
- Fix sampling frequency to account for need to trigger twice per scan
  for some supported chips.
adi,adxl355
- Ensure a long enough wait after SW reset.
bosch,bmc150
- Fix wrong assumption that interrupts are always available.
bosch,bmp280
- Fix the measurement time calculation.
richtek,rtq6056
- Fix wrong sign bit when sign extending.
samsung,ssp
- Fix cleanup of registered mfd devices on error.
st,lsm6dsx
- Fix wrong sized array for register information.
- Fix a wrong time stamp calculation for some devices.
st,stm32-dfsdm
- Update handling of st,adc-alt-channel to reflect binding change as
  part of moving to iio-backend framework.
ti,hdc3020
- Fix wrong units for temperature and humidity. Also the thresholds
  and hysteresis.

----------------------------------------------------------------
Achim Gratz (1):
      iio: pressure: bmp280: correct meas_time_us calculation

ChiYuan Huang (1):
      iio: adc: rtq6056: Correct the sign bit index

Christophe JAILLET (1):
      iio:common:ssp_sensors: Fix an error handling path ssp_probe()

David Lechner (3):
      iio: adc: ad7380: fix SPI offload trigger rate
      iio: adc: ad7280a: fix ad7280_store_balance_timer()
      iio: adc: ad7124: fix temperature channel

Dimitri Fedrau (2):
      iio: humditiy: hdc3020: fix units for temperature and humidity measur=
ement
      iio: humditiy: hdc3020: fix units for thresholds and hysteresis

Francesco Lavra (1):
      iio: imu: st_lsm6dsx: fix array size for st_lsm6dsx_settings fields

Linus Walleij (1):
      iio: accel: bmc150: Fix irq assumption regression

Marcelo Schmitt (1):
      iio: adc: ad4030: Fix _scale value for common-mode channels

Mario Tesi (1):
      iio: st_lsm6dsx: Fixed calibrated timestamp calculation

Nuno S=C3=A1 (3):
      iio: buffer: support getting dma channel from the buffer
      iio: buffer-dma: support getting the DMA channel
      iio: buffer-dmaengine: enable .get_dma_dev()

Olivier Moysan (1):
      iio: adc: stm32-dfsdm: fix st,adc-alt-channel property handling

Valek Andrej (1):
      iio: accel: fix ADXL355 startup race condition

 drivers/iio/accel/adxl355_core.c                   | 44 +++++++++++--
 drivers/iio/accel/bmc150-accel-core.c              |  5 ++
 drivers/iio/accel/bmc150-accel.h                   |  1 +
 drivers/iio/adc/ad4030.c                           |  2 +-
 drivers/iio/adc/ad7124.c                           | 12 ++--
 drivers/iio/adc/ad7280a.c                          |  2 +-
 drivers/iio/adc/ad7380.c                           |  8 +++
 drivers/iio/adc/rtq6056.c                          |  2 +-
 drivers/iio/adc/stm32-dfsdm-adc.c                  |  5 +-
 drivers/iio/buffer/industrialio-buffer-dma.c       |  6 ++
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |  2 +
 drivers/iio/common/ssp_sensors/ssp_dev.c           |  4 +-
 drivers/iio/humidity/hdc3020.c                     | 73 +++++++++++++-----=
----
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h            | 40 ++++++++----
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       | 19 +++---
 drivers/iio/industrialio-buffer.c                  | 21 +++++--
 drivers/iio/pressure/bmp280-core.c                 | 15 +++--
 include/linux/iio/buffer-dma.h                     |  1 +
 include/linux/iio/buffer_impl.h                    |  2 +
 19 files changed, 185 insertions(+), 79 deletions(-)

