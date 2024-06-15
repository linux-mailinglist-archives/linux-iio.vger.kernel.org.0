Return-Path: <linux-iio+bounces-6281-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81491909730
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jun 2024 11:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DAA41F22DC1
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jun 2024 09:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86B51CF96;
	Sat, 15 Jun 2024 09:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BK5urrMq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979B917557
	for <linux-iio@vger.kernel.org>; Sat, 15 Jun 2024 09:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718442689; cv=none; b=j85o2l40Uyz40hrImqYpCDrD0y6A3rv17EXUVGEYkStdQ1AjdBgLfqlmCthbmHHlYtRn2SMj+831rjqGzOuHHvieIxb/mJnJWFJYAEeG/F6wYpMYJUQsafM7PJLnV06r/Y2lyj0yf4K259ADgaiHP7ViLl4AZHY7U4ctYxBaUBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718442689; c=relaxed/simple;
	bh=JOtn82JVhYyogaG/hKA8tjghGawmzPaETB7l33Xm0ZA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=LNFKTtc3SyMJxkUoxxX+xNpHk9NHEtcPNxI1DGnJwxDJUyKTzhje9HVePY+CgoyzrzBZaUic3AaVTkSAEy1RST67dBThHputSIQhxOqwJXohIwdhh6G/fgmE9FW/KEdybMAH1EEKk+d/wOE5ApMnRVbaz1KwbQN8HgtmmFQoPCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BK5urrMq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D2BC116B1;
	Sat, 15 Jun 2024 09:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718442689;
	bh=JOtn82JVhYyogaG/hKA8tjghGawmzPaETB7l33Xm0ZA=;
	h=Date:From:To:Subject:From;
	b=BK5urrMqfYL7ydTWGilziWu977MUXm6mFDs4dhUSKQF+wCLTWrGFPCOMpla16vfAi
	 KFN9dj3uF5cfdTVMG2eL4XqdgJznTujLPtaTyFnLP/N6ToqVW+G5u1nb/UiL09xRed
	 vveM/Hi2JsR2ajVAJznT2eqglaNYQ46+8SCbCb9V0j9P5Xa5yc8NbRv6/o6/hUTUIp
	 VPpBNrZtCTNR3Ccan1EqhDZep+bzcTS1c9GO/GRnbahaXAz8H6AtB11RpUKuC3A0nz
	 LfjUqKrQNzz9moiKHcae9vwfGG7LxEdVJqmvz8NpANIOYGMNMndDVOAVDPdU3E5OPO
	 AcVYO7toMi9fg==
Date: Sat, 15 Jun 2024 10:11:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] IIO: 2nd set of fixes for the 6.10 cycle.
Message-ID: <20240615101121.09118fed@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

The following changes since commit 8f40af31971ce012c0a4b13444900aed3f708edf:

  Merge tag 'iio-fixes-for-6.10a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-linus (2024-06-07 21:05:39 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-6.10b

for you to fetch changes up to 4241665e6ea063a9c1d734de790121a71db763fc:

  iio: chemical: bme680: Fix sensor data read operation (2024-06-09 12:02:34 +0100)

----------------------------------------------------------------
IIO: 2nd set of fixes for 6.10

The usual mixed bag of new stuff and long term issues that have surfaced
as a particular driver gets more adoption.

adi,ad7266
- Add missing error check that could lead to bad data being reported.
adi,ad9739a
- Fix Kconfig to not allow COMPILE_TEST to override lack SPI support.
bosch,bme680
- Fix units for pressure value (off by factor of 10)
- Fix sign on a calibration variable read back from the device
- Avoid integer overflow in compensation functions.
- Fix an issue with read sequence that leads to stale data and bad first
  reading.
freescale,fxls8962af
- Kconfig dependency fixes.
ti,hdc3020
- Fix representation of hysteresis to match ABI by being an offset from
  the current event threshold, not an absolute value.
xilinx,ams
- Don't include the ams_ctrl_channels in a computed mask.  This driver is
  making an unusual use of scan_mask (it doesn't support buffers) and that
  lead to an overflow.

----------------------------------------------------------------
Alexander Sverdlin (1):
      iio: accel: fxls8962af: select IIO_BUFFER & IIO_KFIFO_BUF

Dimitri Fedrau (1):
      iio: humidity: hdc3020: fix hysteresis representation

Fernando Yang (1):
      iio: adc: ad7266: Fix variable checking bug

Ke Sun (1):
      iio: dac: fix ad9739a random config compile error

Sean Anderson (1):
      iio: xilinx-ams: Don't include ams_ctrl_channels in scan_mask

Vasileios Amoiridis (4):
      iio: chemical: bme680: Fix pressure value output
      iio: chemical: bme680: Fix calibration data variable
      iio: chemical: bme680: Fix overflows in compensate() functions
      iio: chemical: bme680: Fix sensor data read operation

 drivers/iio/accel/Kconfig          |   2 +
 drivers/iio/adc/ad7266.c           |   2 +
 drivers/iio/adc/xilinx-ams.c       |   8 +-
 drivers/iio/chemical/bme680.h      |   2 +
 drivers/iio/chemical/bme680_core.c |  62 ++++++-
 drivers/iio/dac/Kconfig            |   2 +-
 drivers/iio/humidity/hdc3020.c     | 325 ++++++++++++++++++++++++++++---------
 7 files changed, 316 insertions(+), 87 deletions(-)

