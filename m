Return-Path: <linux-iio+bounces-10519-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D094399B5D5
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 17:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CCFF283CAC
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 15:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5591419993B;
	Sat, 12 Oct 2024 15:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CdsP8NW6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110BD148FF9;
	Sat, 12 Oct 2024 15:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728746000; cv=none; b=nNwF7WRaSF/PuCobNpyhupv+Z1v/OHDwi89tEX/EFEmABG3ppeRM4jwhBo1TJ4zpJ6U+rWddWA48I1l5ODG09jUkn+rQ3WYIhan1KSRsV0iapsm7i7g/rB6AOMh54rzWq7pE3zVwAnDkG7h6kirGxuNyF9Vzf/pK6jjVbo+Ec8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728746000; c=relaxed/simple;
	bh=SkEH81JnxnHX6oz0noXHCHWYqlliGtXCIWKTybqx0Q8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=suLP93LctEkWQM2msUcYUd5vIBioi5v7PtRoBgf0Htq7u/QSBLWu0jzTpkcyZ16RkG+v9jsIOshC5STXRPvLPz7ZuITk2bD4jyckK+dd6a5Ts5gWbSO24PzzBkQYZJREOWV38KPmfdaFu/zciV5uaq8s3CLHcD1QFYVoohzSEbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CdsP8NW6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9BFAC4CEC6;
	Sat, 12 Oct 2024 15:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728745999;
	bh=SkEH81JnxnHX6oz0noXHCHWYqlliGtXCIWKTybqx0Q8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CdsP8NW6MnbZBelPSqpB5Ry623TWHmDw1fn7tx+a5TR8O3d8Qyiznqhg/FMauXWZ8
	 ztDimHpqo6kyWjjAmh/OTYHSYqYuM3GvaS4pvJqmJQBaCoIYj09ysJ1y54EDNjcYdj
	 qEPDJG8k6GURjax5+2SSn6Ko9c4kp5PuFho430wuSfnTZEQbbt+3klcGHSHuV0pnJj
	 1dzWARtqsRM3W2MdEUeTnPe3EXraLVdNlz5TVMuE7IxSMCP4/EyeHMWjM0qMZteJNv
	 u211npQKJqLQmnz9ggjNprzdzl+jjNg6LEuJVEa5Y/t2S+znw8R8TbEjZZbgh9dYzT
	 f8jnuPgD0KMdA==
Date: Sat, 12 Oct 2024 16:13:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Mohammed Anees <pvmohammedanees2003@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Michael
 Hennerich <michael.hennerich@analog.com>, Kim Seer Paller
 <kimseer.paller@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v3] iioc: dac: ltc2664: Fix span variable usage in
 ltc2664_channel_config()
Message-ID: <20241012161311.5adcccfb@jic23-huawei>
In-Reply-To: <20241005200435.25061-1-pvmohammedanees2003@gmail.com>
References: <20241005200435.25061-1-pvmohammedanees2003@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  6 Oct 2024 01:34:35 +0530
Mohammed Anees <pvmohammedanees2003@gmail.com> wrote:

> In the current implementation of the ltc2664_channel_config() function,
> a variable named span is declared and initialized to 0, intended to
> capture the return value of the ltc2664_set_span() function. However,
> the output of ltc2664_set_span() is directly assigned to chan->span,
> leaving span unchanged. As a result, when the function later checks
> if (span < 0), this condition will never trigger an error since
> span remains 0, this flaw leads to ineffective error handling. Resolve
> this issue by using the ret variable to get the return value and later
> assign it if successful and remove unused span variable.
> 
> Fixes: 4cc2fc445d2e ("iio: dac: ltc2664: Add driver for LTC2664 and LTC2672")
> Signed-off-by: Mohammed Anees <pvmohammedanees2003@gmail.com>
> ---
Hmm. I failed to send a reply to say I applied this.

Anyhow better late than never. Applied. Thanks!

Jonathan

> v3
> - Fixed Styling issues
> ---
>  drivers/iio/dac/ltc2664.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/dac/ltc2664.c b/drivers/iio/dac/ltc2664.c
> index 5be5345ac5c8..67f14046cf77 100644
> --- a/drivers/iio/dac/ltc2664.c
> +++ b/drivers/iio/dac/ltc2664.c
> @@ -516,7 +516,7 @@ static int ltc2664_channel_config(struct ltc2664_state *st)
>  	const struct ltc2664_chip_info *chip_info = st->chip_info;
>  	struct device *dev = &st->spi->dev;
>  	u32 reg, tmp[2], mspan;
> -	int ret, span = 0;
> +	int ret;
>  
>  	mspan = LTC2664_MSPAN_SOFTSPAN;
>  	ret = device_property_read_u32(dev, "adi,manual-span-operation-config",
> @@ -579,20 +579,21 @@ static int ltc2664_channel_config(struct ltc2664_state *st)
>  		ret = fwnode_property_read_u32_array(child, "output-range-microvolt",
>  						     tmp, ARRAY_SIZE(tmp));
>  		if (!ret && mspan == LTC2664_MSPAN_SOFTSPAN) {
> -			chan->span = ltc2664_set_span(st, tmp[0] / 1000,
> -						      tmp[1] / 1000, reg);
> -			if (span < 0)
> -				return dev_err_probe(dev, span,
> +			ret = ltc2664_set_span(st, tmp[0] / 1000, tmp[1] / 1000, reg);
> +			if (ret < 0)
> +				return dev_err_probe(dev, ret,
>  						     "Failed to set span\n");
> +			chan->span = ret;
>  		}
>  
>  		ret = fwnode_property_read_u32_array(child, "output-range-microamp",
>  						     tmp, ARRAY_SIZE(tmp));
>  		if (!ret) {
> -			chan->span = ltc2664_set_span(st, 0, tmp[1] / 1000, reg);
> -			if (span < 0)
> -				return dev_err_probe(dev, span,
> +			ret = ltc2664_set_span(st, 0, tmp[1] / 1000, reg);
> +			if (ret < 0)
> +				return dev_err_probe(dev, ret,
>  						     "Failed to set span\n");
> +			chan->span = ret;
>  		}
>  	}
>  


