Return-Path: <linux-iio+bounces-18620-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 830CAA9C055
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 10:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA21D3B1FB8
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 08:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8C3230D0E;
	Fri, 25 Apr 2025 08:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dB/j6e+H"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCF126AEC
	for <linux-iio@vger.kernel.org>; Fri, 25 Apr 2025 08:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745568201; cv=none; b=jlyWzUJBzIJIEjMECYEVcab8/M7tR2PhWG+HldBG6vctCkVFZOE8fin/IB79dbOMV+PYnhQwIYKj+9NN/x05AwV9nfWna8cQAJDoQLLDOOVnG/Q1/tR9P0tupVFIq11LFGO+dV003m4tANwRMxpqYBgv9sWAX0yS0bA8e6qPT7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745568201; c=relaxed/simple;
	bh=3KXyJ1KaIJ4ehoTaTikIVPhpZnUlu5A1hW+kC5xy4FE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=IP3xnKF3HxEMuGekMibir2fo0oDMR2oC1YcQA3UA0LM+jOYsmVQ3zD4jeGvVz1TUBmBHh1l1MWvOcD70ttg/JzlpahDGdJCP5u/c9BQ0FAv8IcQ8NI1zUewnSFf4udFWtp267l1wIkxDR/DOWELaRETBJrDzeJQOTeSkZSGWIHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dB/j6e+H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4848AC4CEE4;
	Fri, 25 Apr 2025 08:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745568201;
	bh=3KXyJ1KaIJ4ehoTaTikIVPhpZnUlu5A1hW+kC5xy4FE=;
	h=Date:From:To:Subject:From;
	b=dB/j6e+Hh5X+bMi2fFJUZN+QW4OWNyj6ZIOw1WNetVvyakuJTIM8IhHJw1+tSO9zL
	 X0JCo+/tcSvhsIrFj2Ud4BxoqiWjt+jpYIWsrKrLt2WQj/p2NxtMMwCRHlo+R0CovJ
	 qNlZYjQl4r/HwTvL89t0XW3XwwSYA7IRIG7+cN0TN6wf28039UOa0f1aIKb4DFC3uq
	 t1dIQ07rJSWtQtQP9flyqDy1Q0QVS3CS+3rpSNxhi6gzlROXwD8rQWeVhzsFu9Pgrc
	 ZjC1oqwOWG/MOwa50FgAGtvPpS/9smg/Nqm+BbIU/3iXlUUbB7wkUs+6gHxpPX9Wvt
	 39lWrdRJx561w==
Date: Fri, 25 Apr 2025 09:03:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org
Subject: [PULL] IIO: 1st set of fixes for the 6.15 cycle
Message-ID: <20250425090316.0c0bde91@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

The following changes since commit 0af2f6be1b4281385b618cb86ad946eded089ac8:

  Linux 6.15-rc1 (2025-04-06 13:11:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-6.15a

for you to fetch changes up to 609bc31eca06c7408e6860d8b46311ebe45c1fef:

  iio: adis16201: Correct inclinometer channel resolution (2025-04-21 14:58:31 +0100)

----------------------------------------------------------------
IIO: 1st set of fixes for the 6.15 cycle.

A mixed bunch of fixes for new and ancient issues found.

multiple driver sets:
- Stop leaking wakeup sources on device unbind.
- Various timestamp alignment fixes that came up as part of work to add
  runtime checks on buffer sizing. Similarly a DMA buffer safety fix.
hid-sensor-prox
- Fix a bad merge conflict resolution that lost some variable assignments.
- Fix handling of scale when multiple channels present.
- Fix wrong application of exponent in offset calculation.
adi,ad7380
- Disable offload before using the SPI bus.
- Fix a wrong shift on the event threshold.
adi,ad7606
- Check there is a sw_mode_config callback before using it as not
  all busses define one.
- Fix missing hold of chip select on in multi word accesses.
adi,ad7861
- Fix wrong logic on storing of mode.
adi,adis16201
- Wrong resolution for inclinometer channel.
adi,adxl367
- Use fresh ODR when setting activity time, not previous value.
bosch,bmi270
- Fix initial sampling frequency configuration which was using the
  wrong register mask.
rockchip,saradc
- Fix clock initialization sequence to get frequency after get + enable,
  not before.
st,lsm6dsx
- Avoid 2 potential infinite loops if we see empty FIFOs
ti,opt3001
- Fix a deadlock that can occur due to concurrent access to a flag.

----------------------------------------------------------------
Angelo Dureghello (1):
      iio: adc: ad7606: fix serial register access

David Lechner (8):
      iio: adc: ad7380: disable offload before using SPI bus
      iio: adc: ad7606: check for NULL before calling sw_mode_config()
      iio: adc: ad7380: fix event threshold shift
      iio: imu: inv_mpu6050: align buffer for timestamp
      iio: chemical: sps30: use aligned_s64 for timestamp
      iio: chemical: pms7003: use aligned_s64 for timestamp
      iio: imu: adis16550: align buffers for timestamp
      iio: pressure: mprls0025pa: use aligned_s64 for timestamp

Gabriel Shahrouzi (2):
      staging: iio: adc: ad7816: Correct conditional logic for store mode
      iio: adis16201: Correct inclinometer channel resolution

Gustavo Silva (1):
      iio: imu: bmi270: fix initial sampling frequency configuration

Jonathan Cameron (5):
      iio: temp: maxim-thermocouple: Fix potential lack of DMA safe buffer.
      iio: accel: adxl355: Make timestamp 64-bit aligned using aligned_s64
      iio: adc: dln2: Use aligned_s64 for timestamp
      iio: adc: ad7768-1: Fix insufficient alignment of timestamp.
      iio: adc: ad7266: Fix potential timestamp alignment issue.

Krzysztof Kozlowski (3):
      iio: accel: fxls8962af: Fix wakeup source leaks on device unbind
      iio: adc: qcom-spmi-iadc: Fix wakeup source leaks on device unbind
      iio: imu: st_lsm6dsx: Fix wakeup source leaks on device unbind

Lothar Rubusch (1):
      iio: accel: adxl367: fix setting odr for activity time update

Luca Ceresoli (1):
      iio: light: opt3001: fix deadlock due to concurrent flag access

Silvano Seva (2):
      iio: imu: st_lsm6dsx: fix possible lockup in st_lsm6dsx_read_fifo
      iio: imu: st_lsm6dsx: fix possible lockup in st_lsm6dsx_read_tagged_fifo

Simon Xue (1):
      iio: adc: rockchip: Fix clock initialization sequence

Zhang Lixu (3):
      iio: hid-sensor-prox: Restore lost scale assignments
      iio: hid-sensor-prox: support multi-channel SCALE calculation
      iio: hid-sensor-prox: Fix incorrect OFFSET calculation

 drivers/iio/accel/adis16201.c                      |  4 +--
 drivers/iio/accel/adxl355_core.c                   |  2 +-
 drivers/iio/accel/adxl367.c                        | 10 ++-----
 drivers/iio/accel/fxls8962af-core.c                |  7 +++--
 drivers/iio/adc/ad7266.c                           |  2 +-
 drivers/iio/adc/ad7380.c                           | 32 +++++++++++++++-------
 drivers/iio/adc/ad7606.c                           | 11 ++++++--
 drivers/iio/adc/ad7606_spi.c                       |  2 +-
 drivers/iio/adc/ad7768-1.c                         |  2 +-
 drivers/iio/adc/dln2-adc.c                         |  2 +-
 drivers/iio/adc/qcom-spmi-iadc.c                   |  4 ++-
 drivers/iio/adc/rockchip_saradc.c                  | 17 ++++++------
 drivers/iio/chemical/pms7003.c                     |  5 ++--
 drivers/iio/chemical/sps30.c                       |  2 +-
 .../iio/common/hid-sensors/hid-sensor-attributes.c |  4 +++
 drivers/iio/imu/adis16550.c                        |  2 +-
 drivers/iio/imu/bmi270/bmi270_core.c               |  6 ++--
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c         |  2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c     |  6 ++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |  7 +++--
 drivers/iio/light/hid-sensor-prox.c                | 22 +++++++++------
 drivers/iio/light/opt3001.c                        |  5 ++--
 drivers/iio/pressure/mprls0025pa.h                 | 17 ++++--------
 drivers/iio/temperature/maxim_thermocouple.c       |  2 +-
 drivers/staging/iio/adc/ad7816.c                   |  2 +-
 25 files changed, 104 insertions(+), 73 deletions(-)

