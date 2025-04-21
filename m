Return-Path: <linux-iio+bounces-18427-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 620F6A9510B
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 14:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B678189431D
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 12:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6A1264F88;
	Mon, 21 Apr 2025 12:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGOSlejL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3091CA5E;
	Mon, 21 Apr 2025 12:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745238936; cv=none; b=WsoemzShmIOi7Y86xEclg3/dfAAa05h+AlapKEpoV0HMqSh1hkl2sTQziHa/1epuX144L6xs0niqo/xSCYT2afIE2rRjvdCtGsEtsvWb+P7YOq5lSEFv3aofm2fHxdm7lBb06Tw2dlACq7n9Dp7PnDl4fp4db/kgR29AKUtS2ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745238936; c=relaxed/simple;
	bh=LKV5AF+UI7xJyCRmClBJn1fAs26XKw6odVEo5yG6Itw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VX+QtxsIN3A7F2ErEaXxai2iGIKfJXJxKHQsAgISdtIER/2ISpYvmZL1YGvwHw0fBLUUIGNbmaxdVHMl05fSUjCOPsBGeXcNprmTMEiYDlemgCD1UOIF9Ef5B116RYw3XUaV7ZoOHvNeyLuxQPUBuFV0tZNv7UrHUYH4OULHPFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGOSlejL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2076CC4CEE4;
	Mon, 21 Apr 2025 12:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745238935;
	bh=LKV5AF+UI7xJyCRmClBJn1fAs26XKw6odVEo5yG6Itw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hGOSlejLY9j/kj+DCdjHBTSBlxfjlF6oBGJnK4zbT9Gf4iXcwg9xSdAhbbi5X6ph0
	 Ue3pP6Cr3S3AgBiglPcmzlfIHtIBWs7f7Ik5bSkJrN7TxZqScRSaprkg2tSHJ//7aH
	 wWCTy6GSunTuW/kZPJpZPjS7uQoNcQ3LshWb/kDQl7v6aHPzTCkyMpxSaA1TF2Q+04
	 S800ivtSabXe6xnlsrhY65kBc7ZoStSCwtDyjfGlJOWa8yPuoBpNkQA8zee1wIgCxj
	 WilqjS2r/Ya/+kXTCosvFtvbLWC9C6vkpPRWtnVH/HIWcaih74YKImiXhuxzBRPgyX
	 D/ZBpH9exl0lA==
Date: Mon, 21 Apr 2025 13:35:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Cc: gregkh@linuxfoundation.org, lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
 Michael.Hennerich@analog.com, sonic.zhang@analog.com, vapier@gentoo.org,
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v5 4/5] staging: iio: adc: ad7816: Use chip_info for
 device capabilities
Message-ID: <20250421133526.29a562be@jic23-huawei>
In-Reply-To: <20250420014910.849934-5-gshahrouzi@gmail.com>
References: <20250420014910.849934-1-gshahrouzi@gmail.com>
	<20250420014910.849934-5-gshahrouzi@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 19 Apr 2025 21:49:09 -0400
Gabriel Shahrouzi <gshahrouzi@gmail.com> wrote:

> Move device-specific capability information, like the presence of a
> BUSY pin, into the ad7816_chip_info structure.
> 
> Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
> ---
>  drivers/staging/iio/adc/ad7816.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
> index 39310ade770d0..ab7520a8a3da9 100644
> --- a/drivers/staging/iio/adc/ad7816.c
> +++ b/drivers/staging/iio/adc/ad7816.c
> @@ -44,21 +44,25 @@
>  struct ad7816_chip_info {
>  	const char *name;
>  	u8 max_channels;
> +	bool has_busy_pin;
>  };
>  
>  static const struct ad7816_chip_info ad7816_info_ad7816 = {
>  	.name = "ad7816",
>  	.max_channels = 0,
> +	.has_busy_pin = true,
>  };
>  
>  static const struct ad7816_chip_info ad7817_info_ad7817 = {
>  	.name = "ad7817",
>  	.max_channels = 3,
> +	.has_busy_pin = true,
>  };
>  
>  static const struct ad7816_chip_info ad7818_info_ad7818 = {
>  	.name = "ad7818",
>  	.max_channels = 1,
> +	.has_busy_pin = false,
>  };
>  
>  struct ad7816_state {
> @@ -98,7 +102,7 @@ static int ad7816_spi_read(struct ad7816_state *chip, u16 *data)
>  		gpiod_set_value(chip->convert_pin, 1);
>  	}
>  
> -	if (chip->chip_info == &ad7816_info_ad7816 || chip->chip_info == &ad7817_info_ad7817) {
> +	if (chip->chip_info->has_busy_pin) {
There are two places in the previous patch that have this pattern, but only one is
being converted here.  Why not replace the one in probe() as well?


>  		while (gpiod_get_value(chip->busy_pin))
>  			cpu_relax();
>  	}


