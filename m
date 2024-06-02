Return-Path: <linux-iio+bounces-5617-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B91C8D7558
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 14:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 651E21C210B4
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 12:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E53F39FD4;
	Sun,  2 Jun 2024 12:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fH/X+kFT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19ECE29413;
	Sun,  2 Jun 2024 12:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717331479; cv=none; b=HvE36noqMshblvNPueTd+IwMxA6JMv01PuN6VbBxt07sYdQ17MKWbwRci6e3RcZ4p5bTzP2WURJf/LoM6bsy3e4FoL7ZPf3LTBibP8xJrU0LVDVSpxl819S09EK0G51rHUbUSjTSQHz3Hvh3A+Ig9huSTJU00u+tQe8ut8VCNP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717331479; c=relaxed/simple;
	bh=8MlhmqadCkNIyYOylf1s41e5ki+UqvqBYrR0S1l28F4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZsyL4nKqmP0hlY2ZjAV3ru/A7L2cgTgyEVWjHASWwX3Qk5uYutak8j1MZmdb/Sp/2JD1kf7Y+XQWRTAmDaCc4XJ+pz692IXyj2Os2IxkNrzSq2cBWRNPmzvgUAhLxVs7mEd2n/wwDPkJ8/Xz48TCDrdH3zaKM47oGMUgCjQFVjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fH/X+kFT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91EFEC2BBFC;
	Sun,  2 Jun 2024 12:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717331478;
	bh=8MlhmqadCkNIyYOylf1s41e5ki+UqvqBYrR0S1l28F4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fH/X+kFTnJej4N6/lmTWUAXKgaAYNfAbtYf+lU926Vj+CXT51FrOFYD8H8QwZYjX7
	 ZmyQkUM4WUFxquoUlg1FBSiUM/pUrCgt1fUapAXjvJwjwfYqVFVIHudHw6iMrUdomL
	 AqeSAIVAcTGbsjN5kVFLO3a9nNe4me08MYTkqw3zejbVgL+PAKfsiie+qgvizD7o17
	 HWT5H4DzxUrfT1YfLDWyTcBafSAuHFFFLSqHNv4mMiJIJTYFYhZ0+iCLXHwFY8W3zr
	 EB64srutdzOIG2gudvK/kEffAWyGEBQQl+LFzOtUpAgQUhCQPC3VL2U7Xne82dJ58b
	 KhHktT5jSP1yg==
Date: Sun, 2 Jun 2024 13:31:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, himanshujha199640@gmail.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mike Looijmans <mike.looijmans@topic.nl>,
 David Frey <dpfrey@gmail.com>
Subject: Re: [PATCH v1 00/17] iio: chemical: bme680: Driver cleanup
Message-ID: <20240602133105.4334175d@jic23-huawei>
In-Reply-To: <20240527183805.311501-1-vassilisamir@gmail.com>
References: <20240527183805.311501-1-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 May 2024 20:37:48 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> This started as a series to add support for buffers and the new
> BME688 but it ended up being just a cleaning series. These might
> be quite some patches for such a thing but I feel that they are
> are well split, in order to allow for better review.
> 
> The patches are mostly small changes but essential for the correct use
> of the driver. The first patches looked like fixes that should be
> marked for the stable. Patches [11,17/17] might be a bit bigger but 11/17
> is quite straightforward and 17/17 is basically a duplication of a
> very similar commit coming from the BMP280 driver [1].
> 
> In general, the datasheet [2] of the driver is not very descriptive,
> and it redirects the user to the BME68x Sensor API [3]. All the things
> that were identified from the BME68x Sensor API have been marked with
> links to the original locations of the GitHub code. If this is too much
> and we don't want this type of information on the commit message, please
> let me know and I will fix it.
> 
> [1]: https://lore.kernel.org/linux-iio/20240512230524.53990-1-vassilisamir@gmail.com/T/#mc6f814e9a4f8c2b39015909d174c7013b3648b9b
> [2]: https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bme680-ds001.pdf
> [3]: https://github.com/boschsensortec/BME68x_SensorAPI/tree/master

+CC Mike and David who have been active around this driver in the past.


> 
> Vasileios Amoiridis (17):
>   iio: chemical: bme680: Fix pressure value output
>   iio: chemical: bme680: Fix calibration data variable
>   iio: chemical: bme680: Fix overflows in compensate() functions
>   iio: chemical: bme680: Fix sensor data read operation
>   iio: chemical: bme680: Fix type in define
>   iio: chemical: bme680: Add mutexes to guard read/write to device
>   iio: chemical: bme680: Drop unnecessary casts and correct adc data
>     types
>   iio: chemical: bme680: Remove remaining ACPI-only stuff
>   iio: chemical: bme680: Sort headers alphabetically
>   iio: chemical: bme680: Remove duplicate register read
>   iio: chemical: bme680: Use bulk reads for calibration data
>   iio: chemical: bme680: Allocate IIO device before chip initialization
>   iio: chemical: bme680: Add read buffers in DMA safe region
>   iio: chemical: bme680: Modify startup procedure
>   iio: chemical: bme680: Remove redundant gas configuration
>   iio: chemical: bme680: Move forced mode setup in ->read_raw()
>   iio: chemical: bme680: Refactorize reading functions
> 
>  drivers/iio/chemical/bme680.h      |  39 +-
>  drivers/iio/chemical/bme680_core.c | 643 ++++++++++++++---------------
>  2 files changed, 315 insertions(+), 367 deletions(-)
> 
> 
> base-commit: 409b6d632f5078f3ae1018b6e43c32f2e12f6736


