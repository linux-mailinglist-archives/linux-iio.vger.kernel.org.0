Return-Path: <linux-iio+bounces-19111-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 306F6AA9793
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 17:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89EC31694C4
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 15:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A0925CC5B;
	Mon,  5 May 2025 15:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FL9o/uv7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC768494
	for <linux-iio@vger.kernel.org>; Mon,  5 May 2025 15:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746459184; cv=none; b=s+tQzBvcYeHDkxDaKo6HGenUS0QSbk/OYyt4IA4d9jsdZOIiWozVI05pdyU4XrBye0oQJ6ZCcn2F/nsxhZq7kFUdi/TTh2N83nHXsTNRFqwgNBkEORIL11CqOJN/dYxg4s9f9PPQrveJFJ2jcmHrvQhALTLta6FvMUUZ34wVrIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746459184; c=relaxed/simple;
	bh=ttPqR2tA94HQWFndjCbHuYUZaiDmCV1+WKW97pb5WHM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iYWFGcrEVBfexuj3YV6VqEyPPfPudlIjDyuQCPFZ2SaTCrLwMf13aZZzc99P0jdr9X3nT44aRHxsub4UIL0sudsSejIuFY1ENQb72fRkUXSSp1bCSpK/kj6yNCdh+RXUtctKjsW2oqfsnyvTm8b55Fp/oQBmNuyzB/XeRexwiWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FL9o/uv7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46250C4CEE4;
	Mon,  5 May 2025 15:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746459184;
	bh=ttPqR2tA94HQWFndjCbHuYUZaiDmCV1+WKW97pb5WHM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FL9o/uv71Uagk1YimnFCaCp9FUR+Bq2W82Cc6WrZDkphgyNszwUoWWY2sowuOH1wA
	 V9o5tkCm15dhrtRQjbRhcX1pMoykbIzbPMhBGrHeiozC4kG3/YloHXnKaiaHQO0hU/
	 Hoa9G5PEukzG51IJlJcJtiMt0ynHnjwRdso2baVkZ97kZE1m8wBmgZ83wFhXFaid5i
	 QrA/4SqyYxXnygGuLfj9ZhKvhwJMo0tA2Q+36vJZ+EIL2sHZ5QhrrOgM2TRn1jALn/
	 rBJYcYjX/6uBx8+H+6ufz12BeXtx5MsRmyTDspCAvznSMry/JsXpNJZ5dNR0JYE5uQ
	 7h0UKWeSvJGwg==
Date: Mon, 5 May 2025 16:32:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lucas Sobrinho <lucasmsobrinho@gmail.com>
Cc: linux-iio@vger.kernel.org, filipetressmann@usp.br,
 davidbtadokoro@usp.br, paulormm@ime.usp.br
Subject: Re: [PATCH] iio: adc: ti-ads124s08: Add direct mode protection and
 refactor read channel logic
Message-ID: <20250505163258.7a28bc89@jic23-huawei>
In-Reply-To: <20250427222234.126285-1-lucasmsobrinho@gmail.com>
References: <20250427222234.126285-1-lucasmsobrinho@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 27 Apr 2025 19:22:34 -0300
Lucas Sobrinho <lucasmsobrinho@gmail.com> wrote:

> Add a call to iio_device_claim_direct() in the ads124s_read_raw() function
> to ensure exclusive access to the device during direct mode reads.

Why?  This should talk about one of these reads in buffered mode might
cause to happen and why we want to prevent it.

I agree it will be destructive.  However, part of the problem here is
the trigger handler is not taking the mutex() which should be protecting
device specific state (i.e. the command state)

The direct mode claim is only meant to reflect whether transitioning
in or out of buffered mode is a problem during the read (which it is
but this isn't all that is going on!)
Hence I think we should be claiming direct mode and taking the mutex
with care needed to do that in the same order in all paths.


> 
> Also refactor the channel read logic into a separate function.
A patch with the word 'also' in it is a strong indication that it is
doing multiple things and should be multiple patches. 

The factoring out here is separate from dealing with the direct mode
claim + locking.  If it is easier to fix that stuff after factoring
out do it in that order. If it doesn't matter preference is fix first
then cleanup.

> 
> Signed-off-by: Lucas Sobrinho <lucasmsobrinho@gmail.com>
> Co-developed-by: Filipe Tressmann Velozo <filipetressmann@usp.br>
> Signed-off-by: Filipe Tressmann Velozo <filipetressmann@usp.br>
> ---
>  drivers/iio/adc/ti-ads124s08.c | 85 ++++++++++++++++------------------
>  1 file changed, 40 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads124s08.c b/drivers/iio/adc/ti-ads124s08.c
> index 8ea1269f7..e1efe8865 100644
> --- a/drivers/iio/adc/ti-ads124s08.c
> +++ b/drivers/iio/adc/ti-ads124s08.c
> @@ -219,6 +219,40 @@ static int ads124s_read(struct iio_dev *indio_dev)
>  	return get_unaligned_be24(&priv->data[2]);
>  }
>  
> +static int  ads124s_read_channel(struct iio_dev *indio_dev,
> +				struct iio_chan_spec const *chan,
> +				int *val)
> +{
> +	int ret = ads124s_write_reg(indio_dev, ADS124S08_INPUT_MUX, chan);
> +
> +	if (ret) {
> +		dev_err(&priv->spi->dev, "Set ADC CH failed\n");
> +		return ret;
> +	}
> +
> +	ret = ads124s_write_cmd(indio_dev, ADS124S08_START_CONV);
> +	if (ret) {
> +		dev_err(&priv->spi->dev, "Start ADC conversions failed\n");
> +		return ret;
> +	}
> +
> +	ret = ads124s_read(indio_dev);
> +	if (ret < 0) {
> +		dev_err(&priv->spi->dev, "Read ADC failed\n");
> +		return ret;
> +	}
> +
> +	*val = ret;
> +
> +	ret = ads124s_write_cmd(indio_dev, ADS124S08_STOP_CONV);
> +	if (ret) {
> +		dev_err(&priv->spi->dev, "Stop conversions failed\n");
> +		return ret;
> +	}
> +
> +	return IIO_VAL_INT;
> +}
> +
>  static int ads124s_read_raw(struct iio_dev *indio_dev,
>  			    struct iio_chan_spec const *chan,
>  			    int *val, int *val2, long m)
> @@ -226,44 +260,18 @@ static int ads124s_read_raw(struct iio_dev *indio_dev,
>  	struct ads124s_private *priv = iio_priv(indio_dev);
>  	int ret;
>  
> -	mutex_lock(&priv->lock);

As above. This lock is there for a reason. You can't just drop it
and rely on the buffer state to give similar protection.
Whilst with the current implementation of claim_direct that will work
that is an implementation detail we cannot rely on in a driver.

>  	switch (m) {
>  	case IIO_CHAN_INFO_RAW:
> -		ret = ads124s_write_reg(indio_dev, ADS124S08_INPUT_MUX,
> -					chan->channel);
> -		if (ret) {
> -			dev_err(&priv->spi->dev, "Set ADC CH failed\n");
> -			goto out;
> -		}
> -
> -		ret = ads124s_write_cmd(indio_dev, ADS124S08_START_CONV);
> -		if (ret) {
> -			dev_err(&priv->spi->dev, "Start conversions failed\n");
> -			goto out;
> -		}
> -
> -		ret = ads124s_read(indio_dev);
> -		if (ret < 0) {
> -			dev_err(&priv->spi->dev, "Read ADC failed\n");
> -			goto out;
> -		}
> -
> -		*val = ret;
> -
> -		ret = ads124s_write_cmd(indio_dev, ADS124S08_STOP_CONV);
> -		if (ret) {
> -			dev_err(&priv->spi->dev, "Stop conversions failed\n");
> -			goto out;
> -		}
> -
> -		ret = IIO_VAL_INT;
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> +
> +		ret = ads124s_read_channel(indio_dev, chan->channel, val);
> +		iio_device_release_direct(indio_dev);
>  		break;
>  	default:
>  		ret = -EINVAL;
>  		break;
>  	}
> -out:
> -	mutex_unlock(&priv->lock);
>  	return ret;
>  }
>  
> @@ -280,20 +288,7 @@ static irqreturn_t ads124s_trigger_handler(int irq, void *p)
>  	int ret;
>  
>  	iio_for_each_active_channel(indio_dev, scan_index) {
> -		ret = ads124s_write_reg(indio_dev, ADS124S08_INPUT_MUX,
> -					scan_index);
> -		if (ret)
> -			dev_err(&priv->spi->dev, "Set ADC CH failed\n");
> -
> -		ret = ads124s_write_cmd(indio_dev, ADS124S08_START_CONV);
> -		if (ret)
> -			dev_err(&priv->spi->dev, "Start ADC conversions failed\n");
> -
> -		priv->buffer[j] = ads124s_read(indio_dev);
> -		ret = ads124s_write_cmd(indio_dev, ADS124S08_STOP_CONV);
> -		if (ret)
> -			dev_err(&priv->spi->dev, "Stop ADC conversions failed\n");
> -
> +		ads124s_read_channel(indio_dev, chan->channel, &(priv->buffer[j]));

You are passing a u32 pointer to something that takes an int pointer.  That's not
a valid thing to do so fix the types up to use something appropriate in both cases
u32.  Which makes made me curious.  How did this code work before?
Answer seems to be this isn't a 32 bit sensor.  The channel description is wrong.
It's only 24 bits.  So we should fix that as well whilst here.  Given it's only 24 bits
using an int *  for the parameter here is fine.

>  		j++;
>  	}
>  


