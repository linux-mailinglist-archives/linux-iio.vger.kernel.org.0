Return-Path: <linux-iio+bounces-10517-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D02B99B5C2
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 17:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49B53B22FD5
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 15:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE881714A1;
	Sat, 12 Oct 2024 15:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZ5xTJB3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF8311CA0
	for <linux-iio@vger.kernel.org>; Sat, 12 Oct 2024 15:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728745631; cv=none; b=iJICRPYtU5H6ZeWd0iccUwKoIczcLQKLcx5bboevJ08FDEt0RXxQJ5ESryGDXIonbQrsHnXMNMTiu4ELTdJm845b9GQZnpv5WWEZbF8qjaKKOETxKRTFGISwTH9g4oiRTzyuNjvzEW5GIXqfpf+chnRCPnrlkGhvPNVSi2Cxh5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728745631; c=relaxed/simple;
	bh=jWa2JuSnhlW9UR3OeEdKu1SH0ilKRpJ4h4Wng+tBMvQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=nD75WNYuTAQhW9r3ZYx+KDGYAcjOURwrtGjvdyz9z7X3TlYyzZZZdtPjl5scmp+ZE8SuNnWPlCknxelT6TrzuoigeTsFltO8wZYNcs747VrwOjfTIvIUNdmRCbyy0dUf3Vpp8F6DJYajBatMxuKi3QxPKMO1yq5co3d2EgtTujg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZ5xTJB3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1590BC4CEC6;
	Sat, 12 Oct 2024 15:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728745630;
	bh=jWa2JuSnhlW9UR3OeEdKu1SH0ilKRpJ4h4Wng+tBMvQ=;
	h=Date:From:To:Subject:From;
	b=LZ5xTJB3DXwPpBUFLbmuCQww6dOB7zjzKnEq4nzqfqG5LHvm9F6U4wHbEgMZMXPjO
	 VKZBW7pzoEF8X+fHgAPlQDhpA2ApbK3Jg4a9vrIBWP0sfQ2spkf/qXgTCdUahokNtu
	 ezFnV1pYgwthE2PMXkatsmH/rXhSFLexpGhsuJmFv0CDKUhiieE+hIHeS5Z99fL4AR
	 UyteQ50fNkSgpX3qA3HCb6mdPZ9wkRD8BZp2TLBBz+9ToZtSihMqgLcLDgd+9iONqK
	 Hz4XBUigSAw/xTYk2WG/807uHDQomZdpTCwXHh3229tlzdbl6Kdkbw3ZzYAzs0viwG
	 4mDJdFtT5bB1A==
Date: Sat, 12 Oct 2024 16:07:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] IIO: 1st set of fixes for the 6.12 cycle
Message-ID: <20241012160703.61b02c87@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-6.12a

for you to fetch changes up to 6b8e9dbfaed471627f7b863633b9937717df1d4d:

  iio: frequency: admv4420: fix missing select REMAP_SPI in Kconfig (2024-10-10 19:27:25 +0100)

----------------------------------------------------------------
IIO: 1st set of fixes for the 6.12 cycle.

Most of this pull request is the result of Javier Carrasco doing a
careful audit for missing Kconfig dependencies that luck has meant
the random builds have never hit. The rest is the usual mix of old
bugs that have surfaced and some fallout from the recent merge window.

adi,ad5686
 - Fix binding duplication of compatible strings.
bosch,bma400
 - Fix an uninitialized variable in the event tap handling.
bosch,bmi323
 - Fix several issues in the register saving and restore on suspend/resume
sensiron,spd500
 - Fix missing CRC8 dependency
ti,op3001
 - Fix a missing full-scale range value (values above this point were
   all reported wrongly)
vishay,veml6030
 - Fix a segmentation fault due to some type confusion.
 - Fix wrong ambient light sensor resolution.

----------------------------------------------------------------
Christophe JAILLET (1):
      iio: hid-sensors: Fix an error handling path in _hid_sensor_set_report_latency()

Dan Carpenter (2):
      iio: bmi323: fix copy and paste bugs in suspend resume
      iio: bmi323: fix reversed if statement in bmi323_core_runtime_resume()

David Lechner (1):
      iio: adc: ad4695: Add missing Kconfig select

Emil Gedenryd (1):
      iio: light: opt3001: add missing full-scale range value

Javier Carrasco (24):
      iio: light: veml6030: fix IIO device retrieval from embedded device
      iio: light: veml6030: fix ALS sensor resolution
      iio: accel: kx022a: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig
      iio: adc: ad7944: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig
      iio: adc: ti-ads124s08: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig
      iio: adc: ti-lmp92064: add missing select REGMAP_SPI in Kconfig
      iio: adc: ti-lmp92064: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig
      iio: dac: ad3552r: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig
      iio: dac: ad5766: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig
      iio: chemical: ens160: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig
      iio: light: bu27008: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig
      iio: magnetometer: af8133j: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig
      iio: pressure: bm1390: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig
      iio: proximity: mb1232: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig
      iio: resolver: ad2s1210 add missing select REGMAP in Kconfig
      iio: resolver: ad2s1210: add missing select (TRIGGERED_)BUFFER in Kconfig
      iio: frequency: adf4377: add missing select REMAP_SPI in Kconfig
      iio: amplifiers: ada4250: add missing select REGMAP_SPI in Kconfig
      iio: dac: ad5770r: add missing select REGMAP_SPI in Kconfig
      iio: dac: ltc1660: add missing select REGMAP_SPI in Kconfig
      iio: dac: stm32-dac-core: add missing select REGMAP_MMIO in Kconfig
      iio: adc: ti-ads8688: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig
      iio: frequency: {admv4420,adrf6780}: format Kconfig entries
      iio: frequency: admv4420: fix missing select REMAP_SPI in Kconfig

Jonathan Cameron (1):
      iio: pressure: sdp500: Add missing select CRC8

Mikhail Lobanov (1):
      iio: accel: bma400: Fix uninitialized variable field_value in tap event handling.

Mohammed Anees (1):
      iioc: dac: ltc2664: Fix span variable usage in ltc2664_channel_config()

Nathan Chancellor (1):
      iio: bmi323: Drop CONFIG_PM guards around runtime functions

Rob Herring (Arm) (1):
      dt-bindings: iio: dac: adi,ad56xx: Fix duplicate compatible strings

 .../devicetree/bindings/iio/dac/adi,ad5686.yaml    | 53 +++++++---------------
 .../devicetree/bindings/iio/dac/adi,ad5696.yaml    |  3 +-
 drivers/iio/accel/Kconfig                          |  2 +
 drivers/iio/accel/bma400_core.c                    |  3 +-
 drivers/iio/adc/Kconfig                            | 11 +++++
 drivers/iio/amplifiers/Kconfig                     |  1 +
 drivers/iio/chemical/Kconfig                       |  2 +
 .../iio/common/hid-sensors/hid-sensor-trigger.c    |  2 +-
 drivers/iio/dac/Kconfig                            |  7 +++
 drivers/iio/dac/ltc2664.c                          | 17 +++----
 drivers/iio/frequency/Kconfig                      | 34 +++++++-------
 drivers/iio/imu/bmi323/bmi323_core.c               | 23 +++++-----
 drivers/iio/light/Kconfig                          |  2 +
 drivers/iio/light/opt3001.c                        |  4 ++
 drivers/iio/light/veml6030.c                       |  5 +-
 drivers/iio/magnetometer/Kconfig                   |  2 +
 drivers/iio/pressure/Kconfig                       |  4 ++
 drivers/iio/proximity/Kconfig                      |  2 +
 drivers/iio/resolver/Kconfig                       |  3 ++
 19 files changed, 102 insertions(+), 78 deletions(-)

