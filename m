Return-Path: <linux-iio+bounces-11307-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B2C9B1724
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 12:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 311321C21822
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 10:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3857B1D1F71;
	Sat, 26 Oct 2024 10:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odGeK1mH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F3F18787E
	for <linux-iio@vger.kernel.org>; Sat, 26 Oct 2024 10:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729939174; cv=none; b=qmlcD8oomKAAjzmYtxR7qkuZhvAU27mncBZoVyyUCqz8cENpSnUabIjL9Q7WO4zdzonPmSY5TuMMKYvN0WEltJAmIH6qucelyY5REIf+j+gjZnisu/JrIjtX7G+HAybhNvCZKrp3S64Mwi1S7hs9mwa1BCSoddO1zteppjcOO6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729939174; c=relaxed/simple;
	bh=O65eMf3Exaq875fyQ4tocAe2Lz+SN4AqW1u4FBmyu8Q=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=XAW46XVE08+s3ldelq1flIZikKSQ3vX+lvfKl1F2jEby13hOhsdV+njDFKFldYioXMiqn4mWybSg/OciN3CpodkMfxEnDCtasnIpmOCu43bWdl3XUN27JoOlv7XVRgMr74m1k/nnyMgrFF5WkulKcsIejW4Fi0gx7DGK9KAV7pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odGeK1mH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32652C4CEC6;
	Sat, 26 Oct 2024 10:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729939173;
	bh=O65eMf3Exaq875fyQ4tocAe2Lz+SN4AqW1u4FBmyu8Q=;
	h=Date:From:To:Subject:From;
	b=odGeK1mH0SKQ5zwFPsV4eLw1oL4BmuINpAOOooECwUl350ZM+wBf/L0eMsh/IABBr
	 MpnhQckQbqcfjT49iZskcyo32KYhN26BTWZlSqY3c1higvIr54rKfZ1e7lM21MnYhA
	 O4iKWqMpdUQskmRVknffCn8SE2zqrbY/RgtzEwnxA5HgUMAdjFFUT2/ahFlpvwCDwt
	 JVMIOgVPXiEe5IUPZShonpBn+Zx5YNW3ZIwWugOhFZnbg3lasovswQZLn+UQQPYbW/
	 AeF5Gs0KlymSI9CFoT1FjFdsuc0MNXHp7uv7zOdJqHotpYNGMFsqfU7488OF/N1Eyj
	 I6LDfB/Gq4arw==
Date: Sat, 26 Oct 2024 11:39:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] IIO: Fixes for 6.12 - set 2
Message-ID: <20241026113927.333b48c1@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


The following changes since commit 2471787c1f0dae6721f60ab44be37460635d3732:

  misc: microchip: pci1xxxx: add support for NVMEM_DEVID_AUTO for OTP device (2024-10-13 18:17:57 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-6.12b

for you to fetch changes up to 7bd4923940c8d67d9f3f3fde8d7c067e9e804fc6:

  iio: dac: Kconfig: Fix build error for ltc2664 (2024-10-24 18:46:04 +0100)

----------------------------------------------------------------
IIO: Fixes for 6.12, set 2

Usual mixed back of fixes for ancient bugs and some more recently
introduced problems.

gts-helper module
- Memory leak fixes for this library code to handle complex gain cases.
adi,ad7124
- Fix a divide by zero that can be triggered from userspace.
adi,ad7380
- Various supply fixes. Includes some minor rework that simplifies the
  fix though increases the apparent scale of the change.
adi,ad9832
- Avoid a potential divide by zero if clk_get_rate() returns 0.
adi,ltc2642
- Fix wrong Kconfig regmap dependency.
vishay,veml6030
- Fix a scaling problem with decimal part of processed channel.
  Note that only the illuminance channel is fixed as a larger series
  of cleanups not suitable for this point in the rc cycle removes
  the intensity channel anyway.

----------------------------------------------------------------
Javier Carrasco (1):
      iio: light: veml6030: fix microlux value calculation

Jinjie Ruan (3):
      iio: gts-helper: Fix memory leaks in iio_gts_build_avail_scale_table()
      iio: gts-helper: Fix memory leaks for the error path of iio_gts_build_avail_scale_table()
      iio: dac: Kconfig: Fix build error for ltc2664

Julien Stephan (5):
      dt-bindings: iio: adc: ad7380: fix ad7380-4 reference supply
      iio: adc: ad7380: use devm_regulator_get_enable_read_voltage()
      iio: adc: ad7380: add missing supplies
      iio: adc: ad7380: fix supplies for ad7380-4
      docs: iio: ad7380: fix supply for ad7380-4

Zicheng Qu (2):
      staging: iio: frequency: ad9832: fix division by zero in ad9832_calc_freqreg()
      iio: adc: ad7124: fix division by zero in ad7124_set_channel_odr()

 .../devicetree/bindings/iio/adc/adi,ad7380.yaml    |  21 ++++
 Documentation/iio/ad7380.rst                       |  13 +-
 drivers/iio/adc/ad7124.c                           |   2 +-
 drivers/iio/adc/ad7380.c                           | 136 ++++++++++++---------
 drivers/iio/dac/Kconfig                            |   2 +-
 drivers/iio/industrialio-gts-helper.c              |   4 +-
 drivers/iio/light/veml6030.c                       |   2 +-
 drivers/staging/iio/frequency/ad9832.c             |   7 +-
 8 files changed, 121 insertions(+), 66 deletions(-)

