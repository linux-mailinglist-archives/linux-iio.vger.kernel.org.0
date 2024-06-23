Return-Path: <linux-iio+bounces-6761-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A25913C3A
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 17:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6C3D1C20D94
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 15:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06E6181D07;
	Sun, 23 Jun 2024 15:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NH88dh1l"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B5B1DFD8;
	Sun, 23 Jun 2024 15:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719156079; cv=none; b=sDVTaFw62cE8Ureh6RR+RksO0qNk+bJ02OITZsD6w6t3lJes194T5ODjC/JX6Mx/xYG3/I5h0ov1t7QyCCIjUBpBfDWSxPDqPatsXSyix4lvru45m1LS+GJGmaBGwMENMvOW0WunbCxa59GxN0brUAPGJ9AcJYeLTVsPjXeCypw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719156079; c=relaxed/simple;
	bh=8R5yRhx5HD3Qdpebye/X5fiOJqmtxqaT2hxCrl24IRg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=THcjsGYu4OtYbBn9DAHdTQ3AW6rinYBjx7WumaZdMwsKJmzEkmbkYTBsZMoTzTRu+uf7HWefGkp6gAehOGYG8NRxwQftKxCQsrAo6zq7WP2XXodxQQ6ZW7aes1OCVzUp51yeWL5MQdiHv6eyUzNYzl1/H+UKnKpB4tCVUku5hbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NH88dh1l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D15F4C2BD10;
	Sun, 23 Jun 2024 15:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719156079;
	bh=8R5yRhx5HD3Qdpebye/X5fiOJqmtxqaT2hxCrl24IRg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NH88dh1lxv1ZgGw2LykIVmIsCvg40jS4wnMhugJsHZjFjYJ9pLcnnASVl1lXt1MhS
	 hgEeTDb//LFMRbykDgY6L3T6i63jABIAQ/2HZXNTSczhTc7aVZiFoDe3MpVi39w1gM
	 mL5aTQH/Yw6CKQ8HVfp01PplV2PHALH1t1hJpXemfI2KCljBZRgbiZVGXbT5k3GrL9
	 NjSs0AFwUWyvCOXHfdDrLpdCKYlloNwGac43KJK0z/wQzJEIPYhKUZ71PMA62LYYGa
	 AhEBjcI5pIupwS9CiIWij5LO+U5H9lgFcDnACuPqKoC0yvFqt86kKnqBREGu3So07G
	 R7TWKcvmm6pyQ==
Date: Sun, 23 Jun 2024 16:21:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Olivier Moysan <olivier.moysan@foss.st.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 8/8] iio: adc: stm32-dfsdm: add scaling support to dfsdm
Message-ID: <20240623162110.708032af@jic23-huawei>
In-Reply-To: <20240618160836.945242-9-olivier.moysan@foss.st.com>
References: <20240618160836.945242-1-olivier.moysan@foss.st.com>
	<20240618160836.945242-9-olivier.moysan@foss.st.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jun 2024 18:08:34 +0200
Olivier Moysan <olivier.moysan@foss.st.com> wrote:

> Add scaling support to STM32 DFSDM.
Perhaps a short description here of how this works?  Where does the scale come
from, what assumptions are made etc.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>

Some minor stuff.

> diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
> index 69b4764d7cba..93bf6035bd6d 100644
> --- a/drivers/iio/adc/stm32-dfsdm-adc.c
> +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
urn 0;
>  }
>  
> @@ -1060,7 +1072,7 @@ static int stm32_dfsdm_update_scan_mode(struct iio_dev *indio_dev,
>  static int stm32_dfsdm_postenable(struct iio_dev *indio_dev)
>  {
>  	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
> -	int ret;
> +	int i = 0, ret;

Don't mix assigned and unassigned variable declarations. Just use a separate line
as this can mean subtle assignment or lack of assignment issues sneak in.

>  
>  	/* Reset adc buffer index */
>  	adc->bufi = 0;
> @@ -1071,6 +1083,15 @@ static int stm32_dfsdm_postenable(struct iio_dev *indio_dev)
>  			return ret;
>  	}
>  
> +	if (adc->backend) {
> +		while (adc->backend[i]) {

Could do similar to the suggestion below.
Mostly I don't like the index variable manipulation.

> +			ret = iio_backend_enable(&indio_dev->dev, adc->backend[i]);
> +			if (ret < 0)
> +				return ret;
> +			i++;
> +		}
> +	}
> +
>  	ret = stm32_dfsdm_start_dfsdm(adc->dfsdm);
>  	if (ret < 0)
>  		goto err_stop_hwc;
> @@ -1103,6 +1124,7 @@ static int stm32_dfsdm_postenable(struct iio_dev *indio_dev)
>  static int stm32_dfsdm_predisable(struct iio_dev *indio_dev)
>  {
>  	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
> +	int i = 0;
>  
>  	stm32_dfsdm_stop_conv(indio_dev);
>  
> @@ -1110,6 +1132,13 @@ static int stm32_dfsdm_predisable(struct iio_dev *indio_dev)
>  
>  	stm32_dfsdm_stop_dfsdm(adc->dfsdm);
>  
> +	if (adc->backend) {
> +		while (adc->backend[i]) {
> +			iio_backend_disable(&indio_dev->dev, adc->backend[i]);
> +			i++;
> +		}
Something like
		struct iio_backend **be = &adc->backend[0];
		do {
			iio_backend_disable(&indio-dev->dev, be);
		} while (be++);

maybe. Up to you.
		

> +	}

> @@ -1320,6 +1360,45 @@ static int stm32_dfsdm_read_raw(struct iio_dev *indio_dev,
>  		*val = adc->sample_freq;
>  
>  		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		/*
> +		 * Scale is expressed in mV.
> +		 * When fast mode is disabled, actual resolution may be lower
> +		 * than 2^n, where n=realbits-1.

As below, use a few more spaces.

> +		 * This leads to underestimating input voltage. To
> +		 * compensate this deviation, the voltage reference can be
> +		 * corrected with a factor = realbits resolution / actual max
> +		 */
> +		if (adc->backend[idx]) {
> +			iio_backend_read_raw(adc->backend[idx], val, val2, mask);
> +
> +			*val = div_u64((u64)*val * (u64)BIT(DFSDM_DATA_RES - 1), max);
> +			*val2 = chan->scan_type.realbits;
> +			if (chan->differential)
> +				*val *= 2;
> +		}
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +
> +	case IIO_CHAN_INFO_OFFSET:
> +		/*
> +		 * DFSDM output data are in the range [-2^n,2^n],
Use a few more spaces. [-2^2, 2^n]
> +		 * with n=realbits-1.
n = realbits - 1

Just to keep it closer to the C coding style.

> +		 * - Differential modulator:
> +		 * Offset correspond to SD modulator offset.
> +		 * - Single ended modulator:
> +		 * Input is in [0V,Vref] range, where 0V corresponds to -2^n, and Vref to 2^n.

Avoid that long line with a suitable line break.

> +		 * Add 2^n to offset. (i.e. middle of input range)
> +		 * offset = offset(sd) * vref / res(sd) * max / vref.
> +		 */
> +		if (adc->backend[idx]) {
> +			iio_backend_read_raw(adc->backend[idx], val, val2, mask);
> +
> +			*val = div_u64((u64)max * *val, BIT(*val2 - 1));
> +			if (!chan->differential)
> +				*val += max;
> +		}
> +		return IIO_VAL_INT;
>  	}
>  
>  	return -EINVAL;
> @@ -1449,7 +1528,15 @@ static int stm32_dfsdm_adc_chan_init_one(struct iio_dev *indio_dev, struct iio_c
>  	 * IIO_CHAN_INFO_RAW: used to compute regular conversion
>  	 * IIO_CHAN_INFO_OVERSAMPLING_RATIO: used to set oversampling
>  	 */
> -	ch->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
> +	if (child) {
> +		ch->info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +					BIT(IIO_CHAN_INFO_SCALE) |
> +					BIT(IIO_CHAN_INFO_OFFSET);

Indent looks a little odd. Maybe one more space neede?

> +	} else {
> +		/* Legacy. Scaling not supported */
> +		ch->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
> +	}
> +
>  	ch->info_mask_shared_by_all = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |
>  					BIT(IIO_CHAN_INFO_SAMP_FREQ);
>  
> @@ -1816,3 +1903,4 @@ module_platform_driver(stm32_dfsdm_adc_driver);
>  MODULE_DESCRIPTION("STM32 sigma delta ADC");
>  MODULE_AUTHOR("Arnaud Pouliquen <arnaud.pouliquen@st.com>");
>  MODULE_LICENSE("GPL v2");
> +MODULE_IMPORT_NS(IIO_BACKEND);


