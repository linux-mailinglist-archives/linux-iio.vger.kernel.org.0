Return-Path: <linux-iio+bounces-6308-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7309909969
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jun 2024 19:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6518E283357
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jun 2024 17:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A3B4AECE;
	Sat, 15 Jun 2024 17:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fpc5eREi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFB626AD7;
	Sat, 15 Jun 2024 17:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718473842; cv=none; b=W29DZWzu305Cm188F8V1BS4yX3iqjCkLJeu0MDqGYKgR/sSAbhwrgbntfem7K8Xbt/IhPo0voDhQKqIaujAXfdwBlWK0rZNE8qEK05O2daCK2zKYRPP8CMi+eSDAF3vNZhJCns2kOu0q7TT8tHIIim3KUveD9OnfGzRGZ9Ix/ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718473842; c=relaxed/simple;
	bh=NgJRItt2w4xwjJnL+O2IZh1YQlR3AR+Ne88j9G/SZf8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rofFefDlZSUFQhDf97Ax6GzsQo3HECFEHF7xM494afG6Soj83rF4mDq1QOBfYcoXf+EXObDYz0rwulS/1yAlrI2Cycsi10F4yH8yYr/taTlJOTjP18ur5GJLfJLa+QRE2+NU0RdJy8NG9b8Tj1WRL7U+okZ7l0oXw6PfSlVqdko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fpc5eREi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2244C116B1;
	Sat, 15 Jun 2024 17:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718473841;
	bh=NgJRItt2w4xwjJnL+O2IZh1YQlR3AR+Ne88j9G/SZf8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Fpc5eREiZw8Rvsi02AYFwmrqKQ6yoXvaDag+awHtytoAw8Cx+fJQ5DGg1NfBQZcHJ
	 buKUl6cgnXZ5Nvg22cSE4GfiB3tcol9fi+4OUbGk9qViTHVXg5tO3xcbOCwp6hcey+
	 E1jHnxgoyv6ox63f3QZ4ar1IM12MV4rwnotR37OdKSepXU1dT+hPgzY+8QsiVd6DQp
	 Cw8sril+Y27/X/DXZSb7TmjP7MujUp4Yj8Dgae/ijDwdE88K8ezTSWZXZQVuusbOO+
	 prjHMhCebxyluLXcWBiW2HEaBHFK/GdsShffoVBTWSHlVS0YJLIjSxomYuveit2k/7
	 W0V6DZnlM0WDA==
Date: Sat, 15 Jun 2024 18:50:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: bu27034: Add a read only HWARDWAREGAIN
Message-ID: <20240615185036.7d1934c2@jic23-huawei>
In-Reply-To: <5e88c7b7b0389c6c011f15e05e065791f7561cf5.1718013518.git.mazziesaccount@gmail.com>
References: <cover.1718013518.git.mazziesaccount@gmail.com>
	<5e88c7b7b0389c6c011f15e05e065791f7561cf5.1718013518.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Jun 2024 13:01:40 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> The ROHM BU27034 light sensor has two data channels for measuring
> different frequencies of light. The result from these channels is
> combined into Lux value while the raw channel values are reported via
> intensity channels.
> 
> Both of the intensity channels have adjustable gain setting which
> impacts the scale of the raw channels. Eg, doubling the gain will double
> the values read from the raw channels, which halves the scale value. The
> integration time can also be set for the sensor. This does also have an
> impact to the scale of the intensity channels because increasing the
> integration time will also increase the values reported via the raw
> channels.
> 
> Impact of integration time to the scale and the fact that the scale value
> does not start from '1', can make it hard for a human reader to compute the
> gain values based on the scale.
> 
> Add read-only HARDWAREGAIN to help debugging.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Other than the thing the bot found with fallthrough on the switch statement
not being marked LGTM.
> ---
>  drivers/iio/light/rohm-bu27034.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/rohm-bu27034.c b/drivers/iio/light/rohm-bu27034.c
> index 51acad2cafbd..b299ff2aacce 100644
> --- a/drivers/iio/light/rohm-bu27034.c
> +++ b/drivers/iio/light/rohm-bu27034.c
> @@ -149,7 +149,8 @@ static const struct iio_itime_sel_mul bu27034_itimes[] = {
>  	.channel = BU27034_CHAN_##_name,				\
>  	.channel2 = IIO_MOD_LIGHT_CLEAR,				\
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
> -			      BIT(IIO_CHAN_INFO_SCALE),			\
> +			      BIT(IIO_CHAN_INFO_SCALE) |		\
> +			      BIT(IIO_CHAN_INFO_HARDWAREGAIN),		\
>  	.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),	\
>  	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),		\
>  	.info_mask_shared_by_all_available =				\
> @@ -992,6 +993,13 @@ static int bu27034_read_raw(struct iio_dev *idev,
>  
>  		return IIO_VAL_INT_PLUS_MICRO;
>  
> +	case IIO_CHAN_INFO_HARDWAREGAIN:
> +		ret = bu27034_get_gain(data, chan->channel, val);
> +		if (ret)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +
>  	case IIO_CHAN_INFO_SCALE:
>  		return bu27034_get_scale(data, chan->channel, val, val2);
>  
> @@ -1036,12 +1044,16 @@ static int bu27034_write_raw_get_fmt(struct iio_dev *indio_dev,
>  				     struct iio_chan_spec const *chan,
>  				     long mask)
>  {
> +	struct bu27034_data *data = iio_priv(indio_dev);
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SCALE:
>  		return IIO_VAL_INT_PLUS_NANO;
>  	case IIO_CHAN_INFO_INT_TIME:
>  		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_HARDWAREGAIN:
> +		dev_dbg(data->dev,
> +			"HARDWAREGAIN is read-only, use scale to set\n");

return -EINVAL here.  You could use a fall through marking but it gains
little so I wouldn't bother.

>  	default:
>  		return -EINVAL;
>  	}


