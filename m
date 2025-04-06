Return-Path: <linux-iio+bounces-17657-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23375A7CD76
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 11:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB74816F50D
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 09:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC3A1A08B5;
	Sun,  6 Apr 2025 09:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lcv3hWnR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DE435968;
	Sun,  6 Apr 2025 09:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743931584; cv=none; b=sLZwOWqZNL0OmA/I+OIfF36Ir5KiW7IWMK/wVEsNO84L18ZQZun7b4kVEYaBZiKQqrf2fAUr3X9uVRUQVeDFeCUYWqYuvha31gjvMiMdTqE9JLl8zXbzSEcQxvRmBGrQPm+GMtb453CLw0AMVUaPs+s2mU1NRKvseHjhD8rozr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743931584; c=relaxed/simple;
	bh=3Qq5NnmquQLX60jBevmQd5yzm1UOv63qfAtHb+WnK/4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kNtP+0C7Vq/fd9eTIRda55ua3lcr3WXzrq157yCSOSqx0/PMpSS0gRuZ07o8WLGkL1IlDx8m+tYkhFMCwNXIid3yvdfsjs30NXNiCw0dVROoyg+7Pik7Ztae5anHOkL2a+zShdo4Kl0ysOK2nXH5qfxRQxQwaLTG3d4FjFAeQ2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lcv3hWnR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A10C4CEE3;
	Sun,  6 Apr 2025 09:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743931583;
	bh=3Qq5NnmquQLX60jBevmQd5yzm1UOv63qfAtHb+WnK/4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lcv3hWnRCVUYjnNExkhSOPfB8ZL9ZCen5wd8M+GZISKvYCz2UFQCFdADVCAUW74Dq
	 XmfONTeRVB/c4le7Hsw4Gq4jrDkf+CHjbEpV3P2F9bVaMMLNN92L+W1t9Nx/F4mpCs
	 WCeN03eOMdFHXD2sMLvBjn99y26xlgGTHxY5kejk+iuZYUH1NSNXcmgYIbmJn+1205
	 OGKJloD/d5bqeF32asZB2z/bSk60Vlx1YSvuonS2FM5uayJLXSrqfprzaylX1ym8Gz
	 I7GMVtsMEGpW6wc/5TukKOMk7mQG3XXmNOGs0SGfQYC3MRDKDepeJc5YhiBhvyMsQK
	 lv5q02m8lpqwg==
Date: Sun, 6 Apr 2025 10:26:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <lars@metafoo.de>,
 <Michael.Hennerich@analog.com>, <corbet@lwn.net>, <dlechner@baylibre.com>,
 <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v4 0/4] iio: adc: ad4000: Add SPI offload support
Message-ID: <20250406102615.73b56d01@jic23-huawei>
In-Reply-To: <cover.1743110188.git.marcelo.schmitt@analog.com>
References: <cover.1743110188.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Mar 2025 18:24:14 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> This patch series extends the ad4000 driver to support SPI offloading.
> In addition to that, ad4000 IIO documentation is expanded to:
> - list PulSAR parts supported by the ad4000 driver.
> - describe some characteristics of AD4000 IIO device.
> - describe changes when SPI offload is being used.

I left it to sit for a week to see if anyone else had remaining
comments.  Seems not on this occasion.

Applied to the tesing branch of iio.git which I'll shortly rebase
on rc1 once available.

Thanks,

Jonathan

> 
> Change log v3 -> v4
> [IIO driver]
> - No longer changing spi_device CS timing parameters.
> - SPI offload messages now set only one transfer.
> - Degraded offload_xfers from array to single entry field.
> - Adjusted ad4000_spi_offload_setup() comment.
> - Dropped t_quiet1_ns since it's not used anymore.
> - Fixed include order.
> - Fixed typo: withouth -> without.
> [Documentation]
> - Picked up review tags.
> - Made phrase about SPI offload engine more generic.
> - Complemented SPI offload section with supported wiring configurations.
> 
> Change log v2 -> v3
> - Dropped patch 1 of v2 series and reverted buffer endianness and SPI transfer
>   bits_per_word configurations to the way they were in v1.
> - Removed dummy transfer in ad4000_prepare_offload_turbo_message().
> - Unified offload message preparation.
> - Removed spi->cs_hold.value to use cs_inactive to set CNV/CS high time.
> - Adjusted max sample rate for AD7983 and AD7984.
> - Dropped AD4000_TCONV_NS and made all time related constants a time_spec field.
> - Removed _offl param from _CHANNELS() macros and added a comment about that.
> - Commented IIO_BE check in ad4000_prepare_3wire_mode_message().
> - Now using predisable to balance with postenable.
> - Put spi/offload/consumer.h include right after spi/spi.h.
> - Removed unrelated brackets in info_mask_separate_available assignment
> - Added blank line after if.
> 
> Change log v1 -> v2
> - Fixed passing inappropriate pointer instead of ret to dev_err_probe()
> - [new patch] Set transfer bits_per_word to have data in CPU endianness
> - Set iio_dev num_channels close to where channels is set.
> - Complement offload message comment about first sample being invalid
> - Document why the first buffer sample is invalid when offloading
> - Added blank line before a 'simple return'.
> 
> Link to v3: https://lore.kernel.org/linux-iio/cover.1742992305.git.marcelo.schmitt@analog.com/
> Link to v2: https://lore.kernel.org/linux-iio/cover.1742394806.git.marcelo.schmitt@analog.com/
> Link to v1: https://lore.kernel.org/linux-iio/cover.1741970538.git.marcelo.schmitt@analog.com/
> 
> 
> Marcelo Schmitt (4):
>   iio: adc: ad4000: Add support for SPI offload
>   Documentation: iio: ad4000: Add new supported parts
>   Documentation: iio: ad4000: Add IIO Device characteristics section
>   Documentation: iio: ad4000: Describe offload support
> 
>  Documentation/iio/ad4000.rst |  91 ++++++++-
>  drivers/iio/adc/Kconfig      |   7 +-
>  drivers/iio/adc/ad4000.c     | 382 +++++++++++++++++++++++++++++++----
>  3 files changed, 444 insertions(+), 36 deletions(-)
> 
> 
> base-commit: 9f36acefb2621d980734a5bb7d74e0e24e0af166
> prerequisite-patch-id: 3d517eef53a799adba5922815fe684b913e36773


