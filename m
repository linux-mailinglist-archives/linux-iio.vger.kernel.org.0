Return-Path: <linux-iio+bounces-12700-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3469D9D47
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 19:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C88DBB24527
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 18:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4231DD9AB;
	Tue, 26 Nov 2024 18:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2jWfzqu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C371DC19D;
	Tue, 26 Nov 2024 18:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732645285; cv=none; b=txenIg7O2UYMS5QoPuVi7KTn+FHcbJJQld9m1jbeLWgWs+BptOX+cDNW/PPl7LkKjL+yOWk4h2D8zU/EPXxtkzvrjkuxJUp6uBSfI8lk8I8qcBnfFAdgFI5lgptNkc7CAWltUtQravXsKQEvn2Qww+aJ4j/i5s2K08UvOw1W3Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732645285; c=relaxed/simple;
	bh=aYpJqi2ZUZUQP64G0QKJQ92EvvD7/P/coIAeXaPIROo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rLTjYbhKEhwAbVEjxF9ZQvVswIS+bTUlo0JxYo54bnU7spkQHVu8RoooYUeSY4FZKJY4NZS6my0E5YvPFAJrK/8K6HL21x06hi9yWmqoLrDsgl6z/LROFFrT2X2M+WJ2pDU4MBt27g60GgJqTgnfwUKJvIeKYP8J3klfw0acyi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2jWfzqu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 899D0C4CECF;
	Tue, 26 Nov 2024 18:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732645284;
	bh=aYpJqi2ZUZUQP64G0QKJQ92EvvD7/P/coIAeXaPIROo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f2jWfzquJVNZLOuwfn+yvtB+iPqsmVcoYgNML9rfT/FBW1vvR7uh91igxHewVVazf
	 Qood18mxlsXBQQIDCOwLstmIffrqi2cl8fQ9cw5OA/L8hFMZcs6Az+BY4JtY1MhIMz
	 ds0zya42vKifA9zsnOzIMEsVt9VvDJfHDITVHvgY9WyWEFXxsLFEzx7vbGRHipBgpW
	 KZdAaMTfUyx6pFHrIDdeIgWx20K/q1R4TPoU3+1JXxP8ScWDM3/mv7EWcvoyebuQdk
	 b28G2EKjfOhyOaOscsuyJqYW0h1AWqRbP3Br4V3/GtCjEQP/1HEJByZGMQejaJ6ZbI
	 UrQQUSNCATa+A==
Date: Tue, 26 Nov 2024 18:21:16 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Guillaume Stols <gstols@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, dlechner@baylibre.com, jstephan@baylibre.com,
 aardelean@baylibre.com, adureghello@baylibre.com
Subject: Re: [PATCH 3/9] iio:adc: ad7606: Move the software mode
 configuration
Message-ID: <20241126182116.3ef16e2a@jic23-huawei>
In-Reply-To: <20241121-ad7606_add_iio_backend_software_mode-v1-3-8a693a5e3fa9@baylibre.com>
References: <20241121-ad7606_add_iio_backend_software_mode-v1-0-8a693a5e3fa9@baylibre.com>
	<20241121-ad7606_add_iio_backend_software_mode-v1-3-8a693a5e3fa9@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Nov 2024 10:18:25 +0000
Guillaume Stols <gstols@baylibre.com> wrote:

> This is a preparation for the intoduction of the sofware functions in
> the iio backend version of the driver.
> The software mode configuration must be executed once the channels are
> configured, and the number of channels is known. This is not the case
> before iio-backend's configuration is called, and iio backend version of
> the driver does not have a timestamp channel.
> Also the sw_mode_config callback is configured during the
> iio-backend configuration.
> For clarity purpose, I moved the entire block instead of just the
> concerned function calls.
> 
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
> ---
>  drivers/iio/adc/ad7606.c | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index 893b93b86aa7..828603ed18f6 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -1246,17 +1246,6 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
>  			return -ERESTARTSYS;
>  	}
>  
> -	st->write_scale = ad7606_write_scale_hw;
> -	st->write_os = ad7606_write_os_hw;
> -
> -	ret = ad7606_sw_mode_setup(indio_dev);
Isn't this the only call to this function?

> -	if (ret)
> -		return ret;
> -
> -	ret = ad7606_chan_scales_setup(indio_dev);
> -	if (ret)
> -		return ret;
> -
>  	/* If convst pin is not defined, setup PWM. */
>  	if (!st->gpio_convst) {
>  		st->cnvst_pwm = devm_pwm_get(dev, NULL);
> @@ -1334,6 +1323,20 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
>  			return ret;
>  	}
>  
> +	st->write_scale = ad7606_write_scale_hw;
> +	st->write_os = ad7606_write_os_hw;
> +
> +	st->sw_mode_en = st->chip_info->sw_setup_cb &&
> +			 device_property_present(st->dev, "adi,sw-mode");
> +	if (st->sw_mode_en) {
> +		indio_dev->info = &ad7606_info_sw_mode;
> +		st->chip_info->sw_setup_cb(indio_dev);

Where did this callback come from?

Looks like this and the next patch need tidying up so each does
one distinct thing.

> +	}
> +
> +	ret = ad7606_chan_scales_setup(indio_dev);
> +	if (ret)
> +		return ret;
> +
>  	return devm_iio_device_register(dev, indio_dev);
>  }
>  EXPORT_SYMBOL_NS_GPL(ad7606_probe, IIO_AD7606);
> 


