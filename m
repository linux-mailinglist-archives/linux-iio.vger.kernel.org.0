Return-Path: <linux-iio+bounces-4415-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E47A8AC061
	for <lists+linux-iio@lfdr.de>; Sun, 21 Apr 2024 19:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 787D61C2039F
	for <lists+linux-iio@lfdr.de>; Sun, 21 Apr 2024 17:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAFD3A8CE;
	Sun, 21 Apr 2024 17:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FAtGDvt0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2907E6
	for <linux-iio@vger.kernel.org>; Sun, 21 Apr 2024 17:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713722246; cv=none; b=Svsnjh3JYTqz5zQsR3ghehpusaOzRMcZ2/r2TvvsyfMZ1A0mib/3DB9iLIJQivnhPqQmQbZjK1za+JUyA1LpufS9FlKl7XoIsJvi5qGmm8LEaoFFjUiWwKZ5Ir74zM/AMk98ywbgDs/d0yDmoT9V6X+iq5aMXVP0hK9OPpPVlzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713722246; c=relaxed/simple;
	bh=lDvSjwdYpbtR4mlm2qPODhjgiwDw1ybz3spYaYTD+vQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=mGVWicpsn65D5e5N+8LIPKYr7G8RAUrKIW9fpoGX/nTTH6nfXgRkZ06PkNdI210sG8MPwnBWXMgZ7Kf5DdV1W6P4yCY5JAwibivK4TJIVwmP6PKGir/2WDOzmmGyGjeAMQKtg8b1sEYtSeDsPtntsqmlm/1s8lrI0CrnuinttrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FAtGDvt0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 713CCC113CE;
	Sun, 21 Apr 2024 17:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713722245;
	bh=lDvSjwdYpbtR4mlm2qPODhjgiwDw1ybz3spYaYTD+vQ=;
	h=Date:From:To:Subject:From;
	b=FAtGDvt0FRL8JMXJO3fvrTWtQelRAEQQoS2f7JBJGgD6HaSk7tpw7884huj6PyQQ6
	 Pom26hcauXn7oHkbY10RG4aq5bEVZ9hKIQ9f+k8eceLnn6UlRxzflw1uCgLE5fgs80
	 2hPLDAQs1gCB+74xeogXR+bPtES2TfFosaSOjHpcgjE+Hp1ajRD9mIrqMFwlHQ2ySm
	 QyeIzv7CiyFFlDmDuDZom6L5FvBzUDqlGfEYM2O08KU1bnZo3Kh8KI/zsJ3sN6D4qG
	 5QXJRDej1siAHjLB/ueVGWXIsIKEGTzb0///ecWtKpeUiNA7fRJa0pcQakai2Smk5S
	 YTZo/6gA88Ggw==
Date: Sun, 21 Apr 2024 18:57:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] IIO: 1st set of fixes for 6.9
Message-ID: <20240421185716.72eee37e@jic23-huawei>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

The following changes since commit bfa8f18691ed2e978e4dd51190569c434f93e268:

  Merge tag 'scsi-misc' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi (2024-03-22 13:31:07 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-6.9a

for you to fetch changes up to 74a72baf204fd509bbe8b53eec35e39869d94341:

  iio:imu: adis16475: Fix sync mode setting (2024-04-06 16:46:02 +0100)

----------------------------------------------------------------
IIO: 1st set of fixes for the 6.9 cycle.

adi,asdis16475
- Write the correct field in the register when setting the sync mode.
bosch,bmp280
- Wrong chip specific data being used for the bme280 in the SPI driver.
- Fix that we can't use chip IDs because Bosch reuses them for incompatible
  devices (some require a padding byte, others don't).
maxim,max30102 (dt binding)
- Fix incorrect property check to actually match on a device from the
  binding rather than a completely different one due to a typo.
memsic,mxc4005
- Fix wrong masking of interrupt register accidentally disabling temperature
  compensation. Also hammer initial state to 0 as it's not documented
  if interrupts are masked after reset.
- Explicit reset on probe() and resume() as some devices do not power up
  correctly without a reset.

----------------------------------------------------------------
Hans de Goede (2):
      iio: accel: mxc4005: Interrupt handling fixes
      iio: accel: mxc4005: Reset chip on probe() and resume()

Javier Carrasco (1):
      dt-bindings: iio: health: maxim,max30102: fix compatible check

Ramona Gradinariu (1):
      iio:imu: adis16475: Fix sync mode setting

Vasileios Amoiridis (2):
      iio: pressure: Fixes BME280 SPI driver data
      iio: pressure: Fixes SPI support for BMP3xx devices

 .../bindings/iio/health/maxim,max30102.yaml        |  2 +-
 drivers/iio/accel/mxc4005.c                        | 92 ++++++++++++++++++++--
 drivers/iio/imu/adis16475.c                        |  4 +-
 drivers/iio/pressure/bmp280-core.c                 |  1 +
 drivers/iio/pressure/bmp280-spi.c                  | 13 +--
 drivers/iio/pressure/bmp280.h                      |  1 +
 6 files changed, 95 insertions(+), 18 deletions(-)

