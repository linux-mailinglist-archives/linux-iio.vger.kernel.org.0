Return-Path: <linux-iio+bounces-4987-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF688C3687
	for <lists+linux-iio@lfdr.de>; Sun, 12 May 2024 14:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 041E3B218C1
	for <lists+linux-iio@lfdr.de>; Sun, 12 May 2024 12:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9A218641;
	Sun, 12 May 2024 12:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAL2WAAq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780ED9445;
	Sun, 12 May 2024 12:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715517261; cv=none; b=A2MBOIw8ZW+rWndEdOUerHMdbU2pnfB6VkazV/0w1B/9FHUI8VIq28h+3KOQOUSP3uhEFKlNMiF3LZXiL2duLmMFSOS1FstRxsN/QaSyIqiIGp9YIDNIw41v+0wloSyVegkzMd6BLTZoayraqDNMyublZUv9twdBsteS+ng7U9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715517261; c=relaxed/simple;
	bh=pPdbQD3pDbSWDMpUCx3V7YtjEDy9QOmEYjvZWgdceeA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d456EYUI33xUw228KjAgr+1F4N7DhhHLeiGgH40XaNCPr2gLEq0+Nwyg9txrBIGJgjtanBW30Md4klRPLl2LdlxKj4Zo6VCNM052YUHUg2q76FB6AqX6Y/+IOk0jvKUJ8Wjw+3KBP7swVf3stT0G4QpJjNi0o+JJJiY72eQOdB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAL2WAAq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC05C116B1;
	Sun, 12 May 2024 12:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715517260;
	bh=pPdbQD3pDbSWDMpUCx3V7YtjEDy9QOmEYjvZWgdceeA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TAL2WAAqaUSd3SPNARXo89NeKVpGhXPRVTFlrOq98Mrnxqq+FK1aTB2b6ZTdhifws
	 fAkPlxCk0Uv74ABRgF0uORvLo24pMh/CjfEVVDJ53l3o4ZnN7OI2mHdO2GlT5r/puj
	 j26uRqfBQiDnb1ycykyiijJf+VnplaFGE2xclY8zjS8SA+E3PmFzrg2+P47u9G4Wif
	 qGloNSMcCamG1cx1DggLIpa9CGSAMOiNG/cUEEbGb2jiJexZracErZ875xMTpBiJ/P
	 1cgFZXmH4nHelBFt06tfEC81FYypFJUWku1tvnOCPwPIK2d2RsLMzoIvFEchbupRuA
	 w0k6mgPFhtOLw==
Date: Sun, 12 May 2024 13:34:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, andriy.shevchenko@linux.intel.com,
 ang.iglesiasg@gmail.com, mazziesaccount@gmail.com, ak@it-klinger.de,
 petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
 linus.walleij@linaro.org, semen.protsenko@linaro.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 9/9] iio: pressure: bmp280: Add triggered buffer
 support
Message-ID: <20240512133409.6fb350c4@jic23-huawei>
In-Reply-To: <20240508165207.145554-10-vassilisamir@gmail.com>
References: <20240508165207.145554-1-vassilisamir@gmail.com>
	<20240508165207.145554-10-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  8 May 2024 18:52:07 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> BMP2xx, BME280, BMP3xx, and BMP5xx use continuous buffers for their
> temperature, pressure and humidity readings. This facilitates the
> use of burst/bulk reads in order to acquire data faster. The
> approach is different from the one used in oneshot captures.
> 
> BMP085 & BMP1xx devices use a completely different measurement
> process that is well defined and is used in their buffer_handler().
> 
> Suggested-by: Angel Iglesias <ang.iglesiasg@gmail.com>
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>

The switch to ARRAY_SIZE() for num channels will simplify this
because all those values will not need to be manually updated to
include the timestamp channel.

Other than that, this patch and earlier ones I didn't comment on (6, 7)
look good to me.

Thanks,

Jonathan

> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index 3f8144a0355b..95f56836fd86 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c

>  static const int bmp180_oversampling_temp_avail[] = { 1 };
>  static const int bmp180_oversampling_press_avail[] = { 1, 2, 4, 8 };
>  static const u8 bmp180_chip_ids[] = { BMP180_CHIP_ID };
> @@ -2191,7 +2464,8 @@ const struct bmp280_chip_info bmp180_chip_info = {
>  	.regmap_config = &bmp180_regmap_config,
>  	.start_up_time = 2000,
>  	.channels = bmp280_channels,
> -	.num_channels = 2,
> +	.num_channels = 3,

As comment on above, if this was ARRAY_SIZE(bmp280_channels) you wouldn't need
to update it here.  Probably best to make that change as part of the previous
patch.

> +	.avail_scan_masks = bmp280_avail_scan_masks,

