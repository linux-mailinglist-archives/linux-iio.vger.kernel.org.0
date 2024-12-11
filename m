Return-Path: <linux-iio+bounces-13365-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E670C9ED881
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 22:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC7471619DD
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 21:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362071E9B35;
	Wed, 11 Dec 2024 21:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYMbKcmJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0091C3038
	for <linux-iio@vger.kernel.org>; Wed, 11 Dec 2024 21:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733952376; cv=none; b=SATpWUs8n+N061kLNmNk421YdfHt4aDFZDsEPV3MAPyChVN+fnNEcG5PBuow5cxOF0Ys6K97etknrww9U6NiHuO9cxA3TzrjfAtexLCGZxevXdmqg+XVmUE+2ODox0VpHGhb2nyaBJBo6J3RGaCewQS3TWJVkGyfIMZZgyp/6DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733952376; c=relaxed/simple;
	bh=5N0c+wMRVU59xfuLINwT9NHBFvuz6s3PxhGTkKOcOfI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=mQWk0f3B1I3HDmurAZkT952zOxdWxPGtERylfDyN/byN3x4WeheilQdRdzzzZq+kFvQwz6Ljal//XEL/xlHd9Q7Y9wZSKg0/HRXx/89jtFmlG1XMRHOB5xIoOioE9nuliV2CAwRgBVALWVVf8Ri+RE8jJ801l1TfxJi/FMSuAsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYMbKcmJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37630C4CED2;
	Wed, 11 Dec 2024 21:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733952375;
	bh=5N0c+wMRVU59xfuLINwT9NHBFvuz6s3PxhGTkKOcOfI=;
	h=Date:From:To:Subject:From;
	b=QYMbKcmJkA6wNuh4L8HbeBmI768zH9o99hUWJTuvBrkLc31Xb/Q39K8w+mBLvry49
	 TK4C7cgGs+h++VmIeYxSlAeqIafU1AjvlKb7FSM0DcyGYBId8fxUyYWoSFF0m2qBO1
	 rTqluZ3lJTkbIlJzfD3ZarjaIde5apysJ6pL4xGLMSE+y+qoBhyMJnQo8I1gdnGbqO
	 28dTQ6/01QV2EymrZrHoIZlRBpRXODMer1eTYRhJsyz6XlnvH87kCYdB6ua9BHecfm
	 mt+iase9VYu1gGKmTYQifWitL2HQrlzAnETEOkp5sCh5CZGVMUBsm222rGchWfXKBV
	 5ocRP1yWeQvvg==
Date: Wed, 11 Dec 2024 21:26:09 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] IIO: 1st set of fixes for 6.13
Message-ID: <20241211212609.6deb07bc@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

The following changes since commit cdd30ebb1b9f36159d66f088b61aee264e649d7a:

  module: Convert symbol namespace to string literal (2024-12-02 11:34:44 -=
0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fi=
xes-for-6.13a

for you to fetch changes up to 54d394905c92b9ecc65c1f9b2692c8e10716d8e1:

  iio: adc: ti-ads1119: fix sample size in scan struct for triggered buffer=
 (2024-12-08 16:59:13 +0000)

----------------------------------------------------------------
IIO: 1st set of fixes for 6.13 cycle.

The usual mixed back of fixes for ancient and recent bugs

A number of these were from an audit by Javier Carrasco of places
we may leak stack data via holes in structures passed to userspace that
were not explicitly zeroed. Very helpful effort after we found a similar
bug in review of new code.

This affected:
- dummy driver
- kionix,kmx61
- murrata,zpa2326
- rockchip,saradc
- rohm,bh1745
- veml,vcnl4035
- ti,ads1119
- ti,ads8688
- ti,tmp0006

Other fixes:

core,inkern
- Underflow fo reference count issue in error path of iio_channel_get_all()
  for devices we haven't yet gotten.
tests
- Kconfig typo fix so it's possible to tell what test is being enabled.
- Check for allocation failures.

adi,ad4695
- Ensure timing requirement wrt to final clock edge vs next conversion
  signal are met by adding an additional SPI transfer.
adi,ad7124
- Ensure channels are disabled at probe to avoid wrong data if channel 0
  is not the first one read.
adi,ad7173
- Fix handing of multiple devices by not editing a single static
  structure and instead making a per instance copy.
adi,ad9467
- Fix handing of multiple devices by not editing a single static
  structure and instead making a per instance copy.
adi,ad9832
- Off by one error on input verification for phase control
adi,ad9834
- Off by one error on input verification for phase control.
atmel,at91
- In an error path don't use a variable that hasn't been initialized yet.
invensense,icm42600
- SPI burst write does not work for some icm426000 chips, disable it.
- Ensure correct handling of timestamps after resume.
st,sensors
- Add back accidentally dropped IIS2MDC compatible in binding doc.
st,stm32-dfsdm:
- label property was accidentally made a required property. Make it optional
  again to fix use of older DT.
ti,ads1119
- Use a fixed size for the channel data rather than an integer, bringing
  the code inline with the advertised 16 bit channel size and avoiding
  userspace misinterpreting the data.
ti,ads124s08
- Use _cansleep gpio calls as no reason to prevent sleeping and it
  was stopping a new board design working (trivial fix).
ti,ads1298
- Add a check on failure of devm_kasprintf()

----------------------------------------------------------------
Carlos Song (1):
      iio: gyro: fxas21002c: Fix missing data update in trigger handler

Charles Han (1):
      iio: adc: ti-ads1298: Add NULL check in ads1298_init

Christophe JAILLET (1):
      iio: adc: ad9467: Fix the "don't allow reading vref if not available"=
 case

David Lechner (1):
      iio: adc: ad7173: fix using shared static info struct

Fabio Estevam (1):
      iio: adc: ti-ads124s08: Use gpiod_set_value_cansleep()

Javier Carrasco (10):
      iio: dummy: iio_simply_dummy_buffer: fix information leak in triggere=
d buffer
      iio: adc: ti-ads8688: fix information leak in triggered buffer
      iio: light: bh1745: fix information leak in triggered buffer
      iio: light: vcnl4035: fix information leak in triggered buffer
      iio: imu: kmx61: fix information leak in triggered buffer
      iio: adc: rockchip_saradc: fix information leak in triggered buffer
      iio: pressure: zpa2326: fix information leak in triggered buffer
      iio: adc: ti-ads1119: fix information leak in triggered buffer
      iio: temperature: tmp006: fix information leak in triggered buffer
      iio: adc: ti-ads1119: fix sample size in scan struct for triggered bu=
ffer

Jean-Baptiste Maneyrol (2):
      iio: imu: inv_icm42600: fix spi burst write not supported
      iio: imu: inv_icm42600: fix timestamps after suspend if sensor is on

Joe Hattori (2):
      iio: adc: at91: call input_free_device() on allocated iio_dev
      iio: inkern: call iio_device_put() only on mapped devices

Matti Vaittinen (1):
      iio: test: Fix GTS test config

Olivier Moysan (1):
      iio: adc: stm32-dfsdm: handle label as an optional property

Pei Xiao (1):
      iio: test : check null return of kunit_kmalloc in iio_rescale_test_sc=
ale

Sean Nyekjaer (1):
      dt-bindings: iio: st-sensors: Re-add IIS2MDC magnetometer

Trevor Gamblin (1):
      iio: adc: ad4695: fix buffered read, single sample timings

Uwe Kleine-K=C3=B6nig (1):
      iio: adc: ad7124: Disable all channels at probe time

Zicheng Qu (2):
      staging: iio: ad9834: Correct phase range check
      staging: iio: ad9832: Correct phase range check

 .../devicetree/bindings/iio/st,st-sensors.yaml     |   1 +
 drivers/iio/adc/ad4695.c                           | 100 ++++++++++++++---=
----
 drivers/iio/adc/ad7124.c                           |   3 +
 drivers/iio/adc/ad7173.c                           |  10 ++-
 drivers/iio/adc/ad9467.c                           |  15 +++-
 drivers/iio/adc/at91_adc.c                         |   2 +-
 drivers/iio/adc/rockchip_saradc.c                  |   2 +
 drivers/iio/adc/stm32-dfsdm-adc.c                  |  13 +--
 drivers/iio/adc/ti-ads1119.c                       |   4 +-
 drivers/iio/adc/ti-ads124s08.c                     |   4 +-
 drivers/iio/adc/ti-ads1298.c                       |   2 +
 drivers/iio/adc/ti-ads8688.c                       |   2 +-
 drivers/iio/dummy/iio_simple_dummy_buffer.c        |   2 +-
 drivers/iio/gyro/fxas21002c_core.c                 |   9 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600.h        |   1 +
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c   |  22 ++++-
 drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c    |   3 +-
 drivers/iio/imu/kmx61.c                            |   2 +-
 drivers/iio/inkern.c                               |   2 +-
 drivers/iio/light/bh1745.c                         |   2 +
 drivers/iio/light/vcnl4035.c                       |   2 +-
 drivers/iio/pressure/zpa2326.c                     |   2 +
 drivers/iio/temperature/tmp006.c                   |   2 +
 drivers/iio/test/Kconfig                           |   2 +-
 drivers/iio/test/iio-test-rescale.c                |   4 +
 drivers/staging/iio/frequency/ad9832.c             |   2 +-
 drivers/staging/iio/frequency/ad9834.c             |   2 +-
 27 files changed, 159 insertions(+), 58 deletions(-)

