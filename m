Return-Path: <linux-iio+bounces-13753-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 005A89FADB1
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2024 12:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CEDC1883F3A
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2024 11:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890B219B5B8;
	Mon, 23 Dec 2024 11:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2HKxdNy"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4185F1990DB;
	Mon, 23 Dec 2024 11:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734953380; cv=none; b=CW4ZfhMqrinTaXUrRsDra+JU0h1HH0BsQkWTTUAuCzm8mTe0nmzOLsuzd60fHZYH1218elQwplScf+L4PnNVOBojhKzBnM/1sArE6GMRPgtqMZemyztuZRmp5tadcOkf5kAqbzvW3KUwSab4nunUmDIxJ0wNLYMSVQNuZJ8xPKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734953380; c=relaxed/simple;
	bh=QeW27fg13es9sL1bMm3sp82w6mae5If2I86oK8XBnfg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iz5wR6mkAkMA93WNw9vm2Ncrd0yjI05Rw5f+2qDZIYvPd7s1Gtch5igLa+ASvxC7hxhsqO33s8dndOfbklnL4YmOxV6EutpsiAvBz3Ahqt/X7Befq24wmCGjvtNGtFoxS+zTJU/ANHUbIvjfcud1YlRyrMJIzhumcp2AjABBi7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2HKxdNy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ECB2C4CED4;
	Mon, 23 Dec 2024 11:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734953379;
	bh=QeW27fg13es9sL1bMm3sp82w6mae5If2I86oK8XBnfg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f2HKxdNyFMepwNmXo86K94aN35hVRhdocLFCQq/2t+lMfKEDGRIXYSXjOQjG4Gqab
	 z6am5JzYFBLzrZpnmqC7QrcuFdH63MXofUYLd/sEDpi2HU+2vG01ELRKrBX7x6gSXV
	 LMfdHk+0yP3zN2wxRM+g2b/kXTBLa7Y7Aq0d5JzZdhWsirQnVWLYPB8+7jBaK5lRGV
	 WLHj/fTHzHJApuTHHEHsAKYqbehANLOk/ooScoX1m5HDrtuI9yTtl44PuIbC4IuK/Z
	 rxXmpnXX7Om5iqYRNEV/pwaIMOYk+GVr0LwjE7hmI/pUHfTGDqNPuOERRBdyM6wFrs
	 cHgjJg0lTpA9w==
Date: Mon, 23 Dec 2024 11:29:32 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 2/2] iio: veml3235: fix scale to conform to ABI
Message-ID: <20241223112932.5d3439c3@jic23-huawei>
In-Reply-To: <20241220-veml3235_scale-v1-2-b43b190bbb6a@gmail.com>
References: <20241220-veml3235_scale-v1-0-b43b190bbb6a@gmail.com>
	<20241220-veml3235_scale-v1-2-b43b190bbb6a@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Dec 2024 20:28:29 +0100
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> The current scale is not ABI-compliant as it is just the sensor gain
> instead of the value that acts as a multiplier to be applied to the raw
> value (there is no offset).
> 
> Use the iio-gts helpers to obtain the proper scale values according to
> the gain and integration time to match the resolution tables from the
> datasheet.
> 
> Fixes: c5a23f80c164 ("iio: light: add support for veml3235")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Hi Javier,

A few non fix related changes that make no functional difference made
it in here. Those should be done in a additional patch after this one
(to make the backport more minimal).

This change is large enough I probably won't directly apply it as a fix anyway.
Most likely it's material for the next merge window that will then get
backported after it is upstream.  That will give a small window in which
the broken code is in a release kernel, but it should hit stable at .2/.3 or
so and no one sane builds product before that point!

Thanks,

Jonathan

> ---
>  drivers/iio/light/Kconfig    |   1 +
>  drivers/iio/light/veml3235.c | 252 ++++++++++++++++++++++++-------------------
>  2 files changed, 140 insertions(+), 113 deletions(-)
> 
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index 0cf9cf2a3f94..12864691a7ff 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -656,6 +656,7 @@ config VCNL4035
>  config VEML3235
>  	tristate "VEML3235 ambient light sensor"
>  	select REGMAP_I2C
> +	select IIO_GTS_HELPER
>  	depends on I2C
>  	help
>  	  Say Y here if you want to build a driver for the Vishay VEML3235
> diff --git a/drivers/iio/light/veml3235.c b/drivers/iio/light/veml3235.c
> index 66361c3012a3..4ace3f8e95f1 100644
> --- a/drivers/iio/light/veml3235.c
> +++ b/drivers/iio/light/veml3235.c

>  
> -static int veml3235_set_gain(struct iio_dev *indio_dev, int val, int val2)
> +static int veml3235_set_scale(struct iio_dev *indio_dev, int val, int val2)
>  {
>  	struct veml3235_data *data = iio_priv(indio_dev);
> -	int ret, new_gain;
> +	int ret, it_idx, gain_sel, time_sel;
>  
> -	if (val2 != 0)
> -		return -EINVAL;
> -
> -	switch (val) {
> -	case 1:
> -		new_gain = 0x00;
> -		break;
> -	case 2:
> -		new_gain = 0x01;
> -		break;
> -	case 4:
> -		new_gain = 0x03;
> -		break;
> -	case 8:
> -		new_gain = 0x07;
> -		break;
> -	default:
> -		return -EINVAL;
> -	}
> +	ret = regmap_field_read(data->rf.it, &it_idx);
> +	if (ret)
> +		return ret;
>  
> -	ret = regmap_field_write(data->rf.gain, new_gain);
> -	if (ret) {
> -		dev_err(data->dev, "failed to set gain: %d\n", ret);
> +	ret = iio_gts_find_gain_sel_in_times(&data->gts, val, val2, &gain_sel,
> +					     &time_sel);
> +	if (ret)
>  		return ret;
> +
> +	if (it_idx != time_sel) {

Not part of this series, but might be worth turning on regcache for this driver.
Then you can do this sort of write unconditionally as it will hit in the cache
and do nothing anyway.  Mind you, this isn't a high performance path, so maybe
just write it anyway.

> +		ret = regmap_field_write(data->rf.it, time_sel);
> +		if (ret)
> +			return ret;
>  	}
>  
> -	return 0;
> +	return regmap_field_write(data->rf.gain, gain_sel);
>  }


> @@ -309,9 +323,12 @@ static int veml3235_write_raw(struct iio_dev *indio_dev,
>  {
>  	switch (mask) {
>  	case IIO_CHAN_INFO_INT_TIME:
> -		return veml3235_set_it(indio_dev, val, val2);
> +		if (val)
> +			return -EINVAL;

This yanking of the test out of the set function is fine, but maybe
as a precursor patch so as to reduce noise in the main change.

I'm not sure it's technically necessary either. More of a sensible
cleanup?

> +
> +		return veml3235_set_it(indio_dev, val2);
>  	case IIO_CHAN_INFO_SCALE:
> -		return veml3235_set_gain(indio_dev, val, val2);
> +		return veml3235_set_scale(indio_dev, val, val2);
>  	}
>  
>  	return -EINVAL;
> @@ -321,7 +338,7 @@ static void veml3235_read_id(struct veml3235_data *data)
>  {
>  	int ret, reg;
>  
> -	ret = regmap_field_read(data->rf.id,  &reg);
> +	ret = regmap_field_read(data->rf.id, &reg);

As below.  Follow up patch would be great, but not in here.

>  	if (ret) {
>  		dev_info(data->dev, "failed to read ID\n");
>  		return;
> @@ -371,6 +388,13 @@ static int veml3235_hw_init(struct iio_dev *indio_dev)
>  	struct device *dev = data->dev;
>  	int ret;
>  
> +	ret = devm_iio_init_iio_gts(data->dev, 0, 272640000,
> +				    veml3235_gain_sel, ARRAY_SIZE(veml3235_gain_sel),
> +				    veml3235_it_sel, ARRAY_SIZE(veml3235_it_sel),
> +				    &data->gts);
> +	if (ret)
> +		return dev_err_probe(data->dev, ret, "failed to init iio gts\n");
> +
>  	/* Set gain to 1 and integration time to 100 ms */
>  	ret = regmap_field_write(data->rf.gain, 0x00);
>  	if (ret)
> @@ -389,9 +413,10 @@ static int veml3235_hw_init(struct iio_dev *indio_dev)
>  }
>  
>  static const struct iio_info veml3235_info = {
> -	.read_raw  = veml3235_read_raw,
> -	.read_avail  = veml3235_read_avail,
> +	.read_raw = veml3235_read_raw,
> +	.read_avail = veml3235_read_avail,

Whilst it would be good to fix that indent, doesn't belong in this patch
as it means the reader has to check very carefully that there are no subtle
changes in this line.  Feel free to send a follow up white space cleanup
patch that clearly states it makes not functional changes though.

>  	.write_raw = veml3235_write_raw,
> +	.write_raw_get_fmt = veml3235_write_raw_get_fmt,
>  };
>  
>  static int veml3235_probe(struct i2c_client *client)
> @@ -493,3 +518,4 @@ module_i2c_driver(veml3235_driver);
>  MODULE_AUTHOR("Javier Carrasco <javier.carrasco.cruz@gmail.com>");
>  MODULE_DESCRIPTION("VEML3235 Ambient Light Sensor");
>  MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS("IIO_GTS_HELPER");
> 


