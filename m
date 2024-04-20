Return-Path: <linux-iio+bounces-4404-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0485E8ABC2C
	for <lists+linux-iio@lfdr.de>; Sat, 20 Apr 2024 17:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36F6E1C20A4D
	for <lists+linux-iio@lfdr.de>; Sat, 20 Apr 2024 15:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E8128387;
	Sat, 20 Apr 2024 15:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bRG7COGt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8690010A31;
	Sat, 20 Apr 2024 15:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713626393; cv=none; b=ZfjfEa0up4VtKITQwsoe3WMJGd0MhlySGynum+sQu4/G+Y/wStDoDGPpA5Tu6o2xouryV0ps0RCxRiV0xBcrSEHBWAVbQLTlvjfIfoYz1Zp3jtdj/TbLGKHyzOBEnYw194dAISYxjylZgS40Nz/CN/XHKIVwMjFmmOfWGxt05nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713626393; c=relaxed/simple;
	bh=FyGENaf8xK4DdFFkT6suNGtXn8WgaJLV5sg8m9bRPck=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nq8l3m3zLyU7qmIOVFbo45YQ/+ZZPfMJlMvgd1oUaKtI1kslWFqekcgMT+fI2N981IAClrWCSzN4GKEfB4YFnyqjzF3Bckxw1+VGzBEgkWzqPKhf0yRhF9CklfGxf0G8Bhx0XQiri/LuT0U9Y3pPVP0xFWvUp/jRtp+NXOsknfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bRG7COGt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1505C072AA;
	Sat, 20 Apr 2024 15:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713626393;
	bh=FyGENaf8xK4DdFFkT6suNGtXn8WgaJLV5sg8m9bRPck=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bRG7COGtxBAYnmSFA6yKSPJFiJnTC4BkkyCCccFyXNmtD1AkxX7PSvvBQYdYp6FlF
	 0ZOnuSlhowyLIWED94MMAtMYFqu7m/UtTBF6y1PnXOp8D3dWn9lz5WKQgNeb6Q7gsf
	 ciafXJkcoP5bcwBHdjpwHQazNjzv/nbgTQpDelQoKi+oWVx1aF+R70SZUl72DAOpJv
	 0Zoaa1W8N6GakhP+RtVI6Pdls2I8TxCAQ4jsgrNAltUstyVSVKLoIl/SQmKh6tcyQF
	 8kC2NcYeSGitR6kI9CSNR/PfoBw4Uo+1XKEBVFlFIQ9Z1HYzwCCWhz63YLfxsGAl49
	 cRDHfbDQr0Rqw==
Date: Sat, 20 Apr 2024 16:19:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Alexandru Ardelean <alexandru.ardelean@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>
Subject: Re: [PATCH 7/8] iio: adc: ad9467: cache the sample rate
Message-ID: <20240420161941.212e92c5@jic23-huawei>
In-Reply-To: <20240419-ad9467-new-features-v1-7-3e7628ff6d5e@analog.com>
References: <20240419-ad9467-new-features-v1-0-3e7628ff6d5e@analog.com>
	<20240419-ad9467-new-features-v1-7-3e7628ff6d5e@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Apr 2024 17:36:50 +0200
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno Sa <nuno.sa@analog.com>
> 
> Since we allow to change the sampling frequency and do it with
> clk_round_rate(), we can cache it and use on the read_raw() interface.
> This will also be useful in a following patch supporting interface
> calibration.
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>

The clk subsystem caches the clock rate in most cases anyway, so
I'm not sure why we need this.  Or it the point that you are going
to temporarily change it in the next patch?

Patch looks fine, but I think a clearer requirements statement is
needed.

Jonathan


> ---
>  drivers/iio/adc/ad9467.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> index 7475ec2a56c72..7db87ccc1ea4b 100644
> --- a/drivers/iio/adc/ad9467.c
> +++ b/drivers/iio/adc/ad9467.c
> @@ -117,6 +117,7 @@ struct ad9467_state {
>  	struct iio_backend		*back;
>  	struct spi_device		*spi;
>  	struct clk			*clk;
> +	unsigned long			sample_rate;
>  	unsigned int			output_mode;
>  	unsigned int                    (*scales)[2];
>  
> @@ -331,7 +332,7 @@ static int ad9467_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_SCALE:
>  		return ad9467_get_scale(st, val, val2);
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> -		*val = clk_get_rate(st->clk);
> +		*val = st->sample_rate;
>  
>  		return IIO_VAL_INT;
>  	default:
> @@ -346,6 +347,7 @@ static int ad9467_write_raw(struct iio_dev *indio_dev,
>  	struct ad9467_state *st = iio_priv(indio_dev);
>  	const struct ad9467_chip_info *info = st->info;
>  	long r_clk;
> +	int ret;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SCALE:
> @@ -358,7 +360,12 @@ static int ad9467_write_raw(struct iio_dev *indio_dev,
>  			return -EINVAL;
>  		}
>  
> -		return clk_set_rate(st->clk, r_clk);
> +		ret = clk_set_rate(st->clk, r_clk);
> +		if (ret)
> +			return ret;
> +
> +		st->sample_rate = r_clk;
> +		return 0;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -543,6 +550,8 @@ static int ad9467_probe(struct spi_device *spi)
>  	if (IS_ERR(st->clk))
>  		return PTR_ERR(st->clk);
>  
> +	st->sample_rate = clk_get_rate(st->clk);
> +
>  	st->pwrdown_gpio = devm_gpiod_get_optional(&spi->dev, "powerdown",
>  						   GPIOD_OUT_LOW);
>  	if (IS_ERR(st->pwrdown_gpio))
> 


