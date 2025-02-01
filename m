Return-Path: <linux-iio+bounces-14839-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA978A24AB9
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 17:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 982761884BFB
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 16:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5A31C5D7E;
	Sat,  1 Feb 2025 16:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETpBvqF+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3607E1B414B;
	Sat,  1 Feb 2025 16:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738428559; cv=none; b=uW5/EZjDHj4mDQI2pZakrASt5YMOX5sgMUCnQDpIxADFrvc6UsrFAtsYK95ISF6yALazze6JEWCBf5r9KijU6iLTCvynJbmOaoQkJat2oz1OJSauTk3LXSS7UccJuyagsOjfUyZ0O7HoiY8FmUNMaFjEg514FgPFutdJ3sdbUaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738428559; c=relaxed/simple;
	bh=ORz6sL2Z98K9p1NpgMlSIO0aBQ6VlLfvEXaik8RcMiw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pwGyJ8roXvLwNEiiQAs7PrtwS1ytHYKXcqT4F0EgS5+Mc7T/TZ7pko7feiOl9vpoWUJZnMZytm1LqKuR/lElZ6DTdddGw1xP8viJALFwTRcYV0pxYERkEWHEpQrIcB+wDEtW8aQ3OlywhYe9TcDu+oDuuMX3nOuSp5b+9EtE7VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETpBvqF+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5712C4CED3;
	Sat,  1 Feb 2025 16:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738428558;
	bh=ORz6sL2Z98K9p1NpgMlSIO0aBQ6VlLfvEXaik8RcMiw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ETpBvqF+QtH8M5WfSQOGUZtmUG99ieO09VidqgqfhNIQpiZppEDL0XlOkMDjQif9l
	 dSLHKk26zvD2mCyt7ru8DH7LIT0aEauzou7d/RcyLw/3dyCFJ8KbC4/33MeGtWnnaJ
	 SruJMrxyaJF87kbvv0Qca45cb5lNOK82Enrl1RiFtQEyCq2ary2eTs3p8bJEaqboXR
	 oVTwvFxBS0LM11Pg+T9RYunFvxIoZynCDvpB3ylH5eCqI783i3w4BuuX+an2g663xs
	 d6mJhHWUDaGstMrQTR5QtBIEOnslPWqSleEQUA01Ww590aIyD53zGpG63myDSkOhGS
	 DpLfu7GxBDbjg==
Date: Sat, 1 Feb 2025 16:49:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v1 05/12] iio: accel: adxl345: improve access to the
 interrupt enable register
Message-ID: <20250201164913.5434a749@jic23-huawei>
In-Reply-To: <20250128120100.205523-6-l.rubusch@gmail.com>
References: <20250128120100.205523-1-l.rubusch@gmail.com>
	<20250128120100.205523-6-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jan 2025 12:00:53 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Split the current set_interrupts() functionality. Separate writing the
> interrupt map from writing the interrupt enable register.
Makes sense.

> 
> Move writing the interrupt map into the probe(). The interrupt map will
> setup which event finally will go over the INT line. Thus, all events
> are mapped to this interrupt line now once at the beginning.
> 
> On the other side the function set_interrupts() will now be focussed on
> enabling interrupts for event features. Thus it will be renamed to
> write_interrupts() to better distinguish from further usage of get/set
> in the conext of the sensor features.

For this, I'm not yet seeing why we need a function to do this. May
become clear later.

> 
> Also, add the missing initial reset of the interrupt enable register.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  drivers/iio/accel/adxl345_core.c | 43 +++++++++++++++++---------------
>  1 file changed, 23 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index 7ee50a0b23ea..b55f6774b1e9 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -190,25 +190,9 @@ static void adxl345_powerdown(void *ptr)
>  	adxl345_set_measure_en(st, false);
>  }
>  
> -static int adxl345_set_interrupts(struct adxl345_state *st)
> +static inline int adxl345_write_interrupts(struct adxl345_state *st)
>  {
> -	int ret;
> -	unsigned int int_enable = st->int_map;
> -	unsigned int int_map;
> -
> -	/*
> -	 * Any bits set to 0 in the INT map register send their respective
> -	 * interrupts to the INT1 pin, whereas bits set to 1 send their respective
> -	 * interrupts to the INT2 pin. The intio shall convert this accordingly.
> -	 */
> -	int_map = FIELD_GET(ADXL345_REG_INT_SOURCE_MSK,
> -			    st->intio ? st->int_map : ~st->int_map);
> -
> -	ret = regmap_write(st->regmap, ADXL345_REG_INT_MAP, int_map);
> -	if (ret)
> -		return ret;
> -
> -	return regmap_write(st->regmap, ADXL345_REG_INT_ENABLE, int_enable);
> +	return regmap_write(st->regmap, ADXL345_REG_INT_ENABLE, st->int_map);
Not sure the function adds much.  Maybe it will later, but my gut
feeling on what is here would be to just do the regamp_write() inline
where this function is currently called.
>  }
>  

>  
>  static const struct iio_buffer_setup_ops adxl345_buffer_ops = {
> @@ -602,6 +586,8 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>  		return -ENODEV;
>  	st->fifo_delay = fifo_delay_default;
>  
> +	st->int_map = 0x00;			/* reset interrupts */
> +
>  	indio_dev->name = st->info->name;
>  	indio_dev->info = &adxl345_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> @@ -609,6 +595,11 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>  	indio_dev->num_channels = ARRAY_SIZE(adxl345_channels);
>  	indio_dev->available_scan_masks = adxl345_scan_masks;
>  
> +	/* Reset interrupts at start up */
> +	ret = adxl345_write_interrupts(st);
> +	if (ret)
> +		return ret;
> +
>  	if (setup) {
>  		/* Perform optional initial bus specific configuration */
>  		ret = setup(dev, st->regmap);
> @@ -659,6 +650,18 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>  	}
>  
>  	if (st->intio != ADXL345_INT_NONE) {
> +		/*
> +		 * Any bits set to 0 in the INT map register send their respective
> +		 * interrupts to the INT1 pin, whereas bits set to 1 send their respective
> +		 * interrupts to the INT2 pin. The intio shall convert this accordingly.
> +		 */
> +		regval = st->intio ? ADXL345_REG_INT_SOURCE_MSK
> +			: ~ADXL345_REG_INT_SOURCE_MSK;

This mask is another slightly odd one as it just means all bits in the register.
Maybe better just using values here? 0x00 vs 0xFF

> +
> +		ret = regmap_write(st->regmap, ADXL345_REG_INT_MAP, regval);
> +		if (ret)
> +			return ret;
> +
>  		/* FIFO_STREAM mode is going to be activated later */
>  		ret = devm_iio_kfifo_buffer_setup(dev, indio_dev, &adxl345_buffer_ops);
>  		if (ret)


