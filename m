Return-Path: <linux-iio+bounces-12001-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 557469C0DFB
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 19:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D97111F22B13
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 18:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5752217318;
	Thu,  7 Nov 2024 18:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJj9Qe4C"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733E7217308
	for <linux-iio@vger.kernel.org>; Thu,  7 Nov 2024 18:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731004899; cv=none; b=D3f4Z7uqSm8Lk0fAwzSHawXEPke+sJurwIF2eV+hUA54dOPcPUanUjbh85YDgIgQeLuOF+4IMpcXP62ZYixzP17ocBcAIwQHcMdNhGeGEJdHG7Sd7Fhc94JCkrXXx2bthHVQqiiXAeRlwRP6Nr0wzo6Yv7jaN28e56+7CcN6tZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731004899; c=relaxed/simple;
	bh=G2W8+MLWC2XcfirptbsrQ9FkdXkAeeRttib6CaIhoMs=;
	h=Date:From:To:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aqJz96CaoFX89hnQ2JxKgRNcRThrjXC/EC8Ekv350mHt+CEbEhKIRJoLEMkMi1m75NZQXyReA2z7dUxzKfhgsTX7hV9VICRqjvDqOUJ9EV2MHBaEZO5YW+LGlT61HYKtC6vv1Q2X/2CHFo7vxe365LxM6+ydtKqC2qTXqKq0jIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJj9Qe4C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D004DC4CECC;
	Thu,  7 Nov 2024 18:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731004898;
	bh=G2W8+MLWC2XcfirptbsrQ9FkdXkAeeRttib6CaIhoMs=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=TJj9Qe4C9M9rEUo1XgAjQKe2gaLMlTRYdd0r5MdslgNZQTzNd4mMbr4+/gbZuR51g
	 MoCKDyMoXGJk25Q2xzeuNucwX5iELYjACN2VcnPJCaya+QKFR7DpUUOpfRWuzgQNMg
	 2dsy0cr7SQa4PYfcWi+IPkuuXl6o3cLxqycE9iX58Q4vNZdD/WjargxfozN/wPguOK
	 16mJMbEjeGgOw4QvuS7Aa+jO4dkO+KUWeCRh+6aRR8mYUK/W8cu8z33z2txMLye/uj
	 prcmX3jO+rSCcbrt6YQucCIlvHl9vSuGUzmPkq7bi0DDAQWXw3cUViLLN3EVI/4WSm
	 oqTKCy7u2p+2Q==
Date: Thu, 7 Nov 2024 18:41:32 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: 3rd set of fixes for the 6.12 cycle.
Message-ID: <20241107184132.4764590a@jic23-huawei>
In-Reply-To: <20241107183156.12299e63@jic23-huawei>
References: <20241107183156.12299e63@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 Nov 2024 18:31:56 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> The following changes since commit d0bc3b92fb9b2c3c981984d52fffe8cca77165dc:
> 
>   Merge tag 'iio-fixes-for-6.12b' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-next (2024-10-29 04:10:12 +0100)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-6.12c
> 
> for you to fetch changes up to 3993ca4add248f0f853f54f9273a7de850639f33:
> 
>   iio: Fix fwnode_handle in __fwnode_iio_channel_get_by_name() (2024-11-02 15:18:52 +0000)
Greg,

These can wait for merge window. I just saw your the counter PULL request comment and was well aware
these are somewhat late in the cycle.

Jonathan

> 
> ----------------------------------------------------------------
> IIO: 3rd set of fixes for the 6.12 cycle
> 
> Usual mixed bag of new issues from this cycle and ancient bugs
> recently noticed.
> 
> core
> - Fix wrong fwnode handle if __fwnode_iio_channel_get_by_name()
>   looks at parents of the provider node.
> core,backend
> - Fix a wrong pointer error check.
> gts library
> - Fix plausible corner case where the value returned was not set.
> - Avoid near infinite loop if the size of the table is 0.
>   (neither are an issue for current drivers).
> adi,ad4000
> - Fix reading of unsigned channels that were returning garbage.
> adi,ad7780
> - Prevent a division by zero.
> adi,ad7923
> - Fix buffer overflows in arrays that were not resized when devices
>   with more channels were added to the driver.
> adi,adxl380
> - Check only for negative error codes rather than including the
>   positive channel read values in an error check.
> invense,common
> - Fix an issue where changing the sampling rate to another value and
>   back again whilst the FIFO was off would not update things correctly.
> kionix,kx022a
> - Fix failure to sign extend value read from device.
> 
> ----------------------------------------------------------------
> Antoniu Miclaus (1):
>       iio: accel: adxl380: fix raw sample read
> 
> David Lechner (1):
>       iio: adc: ad4000: fix reading unsigned data
> 
> Jean-Baptiste Maneyrol (1):
>       iio: invensense: fix multiple odr switch when FIFO is off
> 
> Matti Vaittinen (1):
>       iio: accel: kx022a: Fix raw read format
> 
> Nuno Sa (1):
>       iio: adc: ad7923: Fix buffer overflow for tx_buf and ring_xfer
> 
> Yang Yingliang (1):
>       iio: backend: fix wrong pointer passed to IS_ERR()
> 
> Zicheng Qu (4):
>       ad7780: fix division by zero in ad7780_write_raw()
>       iio: gts: Fix uninitialized symbol 'ret'
>       iio: gts: fix infinite loop for gain_to_scaletables()
>       iio: Fix fwnode_handle in __fwnode_iio_channel_get_by_name()
> 
>  drivers/iio/accel/adxl380.c                            | 2 +-
>  drivers/iio/accel/kionix-kx022a.c                      | 2 +-
>  drivers/iio/adc/ad4000.c                               | 2 ++
>  drivers/iio/adc/ad7780.c                               | 2 +-
>  drivers/iio/adc/ad7923.c                               | 4 ++--
>  drivers/iio/common/inv_sensors/inv_sensors_timestamp.c | 4 ++++
>  drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c      | 2 --
>  drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c       | 3 ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c          | 1 -
>  drivers/iio/industrialio-backend.c                     | 4 ++--
>  drivers/iio/industrialio-gts-helper.c                  | 4 ++--
>  drivers/iio/inkern.c                                   | 2 +-
>  12 files changed, 16 insertions(+), 16 deletions(-)
> 


