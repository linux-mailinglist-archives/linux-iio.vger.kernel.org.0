Return-Path: <linux-iio+bounces-5613-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4958D7549
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 14:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4244B21166
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 12:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255FE38DF2;
	Sun,  2 Jun 2024 12:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/RTfCN3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7767D51A;
	Sun,  2 Jun 2024 12:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717330790; cv=none; b=Fxu5Rdx0e9KcJpH1A42nqMy+MxLlkNaLeIrfn0Wskd6lsSBK/iBw9We5cV0VsrU3QKfNedtX3paDeUbpkjWng91YMVMZ5OIa0aRBU2yMDFN0txAlyV2Uhbp730W9q/g/VFWp5dT/nqPRWimlSOUVRHhiMLVBE8P8JCr2o8MR8T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717330790; c=relaxed/simple;
	bh=CUhHVzSvHrMIHdf8m8dpOjAAiCLEufP7fCHnzeP4xzE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YHkE8+Kd1D5lbJqSrPtLqqMAOdGdA410bzfBMqjBpYIykoaDPfRCzMM7EpGQjkhfUOrT9l7SkQ61dYogxFe7xnIwvDsoduP7r6ckzKpEMb0ibZIbQx9k8Vj4mIFMhze1grjvW+O1alMWqz2QwGI44O3qdz9Ic3d5xFW8LMMlb48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/RTfCN3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D50C7C2BBFC;
	Sun,  2 Jun 2024 12:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717330790;
	bh=CUhHVzSvHrMIHdf8m8dpOjAAiCLEufP7fCHnzeP4xzE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y/RTfCN3gxv4zBPrBOVXl2NVmi10I9lbK3lqHAQuJ9xZn5LEqsKh8HhqrLOohAat4
	 njr3SlQLW8N2vQPxKcYWDUelMIRtHHgykhYHO/y4VufIqAMwjaWHtgdyXFcqx20vnK
	 muoa1kmdbpIrwbrhFw2AdUUAvGIxRlECOeVQq/J8HXDte05BI//6kUd50ClMbjeJhF
	 CIwTmw3lcv5DhHQC6jHf6HoJcx/YpI6J1vLcCh/9xzaDGZK01KFDtos8L4b57Dvqfm
	 UOt6YbXySrGk6/PN+LmXeeqS75SXNzpll2IxLd/KsNUGzCF72C6gIXF5hCOVC2vG9r
	 KC/RGNNe5XF7g==
Date: Sun, 2 Jun 2024 13:19:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dumitru Ceclan via B4 Relay
 <devnull+dumitru.ceclan.analog.com@kernel.org>
Cc: dumitru.ceclan@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Dumitru Ceclan
 <mitrutzceclan@gmail.com>, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH v3 1/5] iio: adc: ad7173: fix buffers enablement for
 ad7176-2
Message-ID: <20240602131939.69e47965@jic23-huawei>
In-Reply-To: <20240530-ad7173-fixes-v3-1-b85f33079e18@analog.com>
References: <20240530-ad7173-fixes-v3-0-b85f33079e18@analog.com>
	<20240530-ad7173-fixes-v3-1-b85f33079e18@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 May 2024 15:07:49 +0300
Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org> wrote:

> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
> 
> AD7176-2 does not feature input buffers and marks corespondent register
> bits as read only. Enable buffers only on supported models.
> 
> Fixes: 8eb903272f75 ("iio: adc: ad7173: add AD7173 driver")
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
I already picked up v2 of patches 1-3 Must have crossed with this.

Jonathan

> ---
>  drivers/iio/adc/ad7173.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
> index f6d29abe1d04..850574437bda 100644
> --- a/drivers/iio/adc/ad7173.c
> +++ b/drivers/iio/adc/ad7173.c
> @@ -145,6 +145,7 @@ struct ad7173_device_info {
>  	unsigned int id;
>  	char *name;
>  	bool has_temp;
> +	bool has_input_buf;
>  	bool has_int_ref;
>  	bool has_ref2;
>  	u8 num_gpios;
> @@ -212,6 +213,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
>  		.num_configs = 4,
>  		.num_gpios = 2,
>  		.has_temp = true,
> +		.has_input_buf = true,
>  		.has_int_ref = true,
>  		.clock = 2 * HZ_PER_MHZ,
>  		.sinc5_data_rates = ad7173_sinc5_data_rates,
> @@ -224,6 +226,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
>  		.num_configs = 8,
>  		.num_gpios = 4,
>  		.has_temp = false,
> +		.has_input_buf = true,
>  		.has_ref2 = true,
>  		.clock = 2 * HZ_PER_MHZ,
>  		.sinc5_data_rates = ad7173_sinc5_data_rates,
> @@ -237,6 +240,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
>  		.num_configs = 8,
>  		.num_gpios = 4,
>  		.has_temp = true,
> +		.has_input_buf = true,
>  		.has_int_ref = true,
>  		.has_ref2 = true,
>  		.clock = 2 * HZ_PER_MHZ,
> @@ -251,6 +255,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
>  		.num_configs = 4,
>  		.num_gpios = 2,
>  		.has_temp = true,
> +		.has_input_buf = true,
>  		.has_int_ref = true,
>  		.clock = 16 * HZ_PER_MHZ,
>  		.sinc5_data_rates = ad7175_sinc5_data_rates,
> @@ -263,6 +268,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
>  		.num_configs = 8,
>  		.num_gpios = 4,
>  		.has_temp = true,
> +		.has_input_buf = true,
>  		.has_int_ref = true,
>  		.has_ref2 = true,
>  		.clock = 16 * HZ_PER_MHZ,
> @@ -277,6 +283,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
>  		.num_configs = 4,
>  		.num_gpios = 2,
>  		.has_temp = false,
> +		.has_input_buf = false,
>  		.has_int_ref = true,
>  		.clock = 16 * HZ_PER_MHZ,
>  		.sinc5_data_rates = ad7175_sinc5_data_rates,
> @@ -289,6 +296,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
>  		.num_configs = 4,
>  		.num_gpios = 2,
>  		.has_temp = true,
> +		.has_input_buf = true,
>  		.has_int_ref = true,
>  		.clock = 16 * HZ_PER_MHZ,
>  		.odr_start_value = AD7177_ODR_START_VALUE,
> @@ -932,7 +940,7 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
>  			AD7173_CH_ADDRESS(chan_arr[chan_index].channel,
>  					  chan_arr[chan_index].channel2);
>  		chan_st_priv->cfg.bipolar = false;
> -		chan_st_priv->cfg.input_buf = true;
> +		chan_st_priv->cfg.input_buf = st->info->has_input_buf;
>  		chan_st_priv->cfg.ref_sel = AD7173_SETUP_REF_SEL_INT_REF;
>  		st->adc_mode |= AD7173_ADC_MODE_REF_EN;
>  
> @@ -989,7 +997,7 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
>  
>  		chan_st_priv->ain = AD7173_CH_ADDRESS(ain[0], ain[1]);
>  		chan_st_priv->chan_reg = chan_index;
> -		chan_st_priv->cfg.input_buf = true;
> +		chan_st_priv->cfg.input_buf = st->info->has_input_buf;
>  		chan_st_priv->cfg.odr = 0;
>  
>  		chan_st_priv->cfg.bipolar = fwnode_property_read_bool(child, "bipolar");
> 


