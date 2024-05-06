Return-Path: <linux-iio+bounces-4843-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 737C68BCFAB
	for <lists+linux-iio@lfdr.de>; Mon,  6 May 2024 16:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0175F1F225E8
	for <lists+linux-iio@lfdr.de>; Mon,  6 May 2024 14:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E86881AA3;
	Mon,  6 May 2024 14:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f//CutHQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340A515A5;
	Mon,  6 May 2024 14:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715004372; cv=none; b=Yz0jxRrZqDMRiuapRRQ9r1lkxGpoGtSNX01m1Qg1z6SDeOHvmZ+IU0B0uyNDHqxXTeAFzgpLd7wChotArEj5LwWqNaeI5qL/7hapsNft6Oq7UxQAJCz69FFbflvZbWNedAYqE5bUju2aBD0oLmpXsTHsXP5zC/YQZVMl9BQuhLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715004372; c=relaxed/simple;
	bh=cZZmZVxWa908an4uMtHbVpLQV8WR9PbqQyordvaexD4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DFsBCqdDLDXVqv5PUP4lFzm8MfAzmnED6bAObSRI7BPugJgimWxBE0Zgl5hToD/pnSArL/vDhiiknHP684snkVaKoruJoL7g2vLYlVOaL/WHXmqcEVMqOvBEzb+5BtgdY297Mz9RbvNHfmbPrYerQmyy1+UMMjfRQFs1p1/q0Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f//CutHQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1B06C116B1;
	Mon,  6 May 2024 14:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715004371;
	bh=cZZmZVxWa908an4uMtHbVpLQV8WR9PbqQyordvaexD4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f//CutHQaYJsnJznM3/58nHl0guQPZ/BTuELJ+JQt1zui4ZGKeFhABWVDnqbdtPY5
	 WXOFgbvVu1hIj39YpX4wzuvZaN7BF/EfkSj+TE8BTHtrE1F/+u9ZzPqk24sqXOUlMW
	 cUsT8oBJEn0GQfkleL7Qf1lB8dXViM/IGzmZ32l130rw8OHti+WWVv/M2pVDkxfZHm
	 0Th5KrI2LLSsRuktS7ruTgn86T4P2X4sq0PNcEChYqgmWSKSVtd//KW4DGIPR1mG/b
	 pXa7gYlUR6/Cuu0jO4FvaQAqkLR2i7nYncMbxxlSpV4fHFzl2LqKq2UnV27e2EIFfq
	 CJSH1q1yB4e9A==
Date: Mon, 6 May 2024 15:05:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Julien Stephan <jstephan@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, kernel test robot <lkp@intel.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v6 08/10] iio: adc: ad7380: add oversampling support
Message-ID: <20240506150557.1149c394@jic23-huawei>
In-Reply-To: <20240501-adding-new-ad738x-driver-v6-8-3c0741154728@baylibre.com>
References: <20240501-adding-new-ad738x-driver-v6-0-3c0741154728@baylibre.com>
	<20240501-adding-new-ad738x-driver-v6-8-3c0741154728@baylibre.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 01 May 2024 16:55:41 +0200
Julien Stephan <jstephan@baylibre.com> wrote:

> ad7380x(-4) parts are able to do oversampling to increase accuracy.
> They support 2 average modes: normal average and rolling overage.
> This commits focus on enabling normal average oversampling, which is the
> default one.

The other case got me curious.  If you do want to support the rolling average
in future, it could probably be handled as a low pass filter control rather
than a form of oversampling.  Anyhow, not relevant here!

> 
> Normal averaging involves taking a number of samples, adding them together,
> and dividing the result by the number of samples taken.
> This result is then output from the device. The sample data is cleared when
> the process completes. Because we need more samples to output a value,
> the data output rate decrease with the oversampling ratio.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
Hi Julien.

A few additional comments inline.

Jonathan

> ---
>  drivers/iio/adc/ad7380.c | 115 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 114 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
> index 020959759170..1e3869f5e48c 100644
> --- a/drivers/iio/adc/ad7380.c
> +++ b/drivers/iio/adc/ad7380.c
> @@ -88,7 +88,10 @@ struct ad7380_chip_info {
>  	.type = IIO_VOLTAGE,					\
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
>  		((diff) ? 0 : BIT(IIO_CHAN_INFO_OFFSET)),	\
> -	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
> +		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),		\
> +	.info_mask_shared_by_type_available =			\
> +		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),		\
>  	.indexed = 1,						\
>  	.differential = (diff),					\
>  	.channel = (diff) ? (2 * (index)) : (index),		\
> @@ -156,6 +159,16 @@ static const struct ad7380_timing_specs ad7380_4_timing = {
>  	.t_csh_ns = 20,
>  };
>  
> +/*
> + * Available oversampling ratios. The indices correspond
> + * with the bit value expected by the chip.
> + * The available ratios depend on the averaging mode,
> + * only normal averaging is supported for now
> + */
> +static const int ad7380_normal_average_oversampling_ratios[] = {
> +	1, 2, 4, 8, 16, 32,
> +};
> +
>  static const struct ad7380_chip_info ad7380_chip_info = {
>  	.name = "ad7380",
>  	.channels = ad7380_channels,
> @@ -231,6 +244,7 @@ static const struct ad7380_chip_info ad7384_4_chip_info = {
>  struct ad7380_state {
>  	const struct ad7380_chip_info *chip_info;
>  	struct spi_device *spi;
> +	unsigned int oversampling_ratio;
>  	struct regmap *regmap;
>  	unsigned int vref_mv;
>  	unsigned int vcm_mv[MAX_NUM_CHANNELS];
> @@ -386,6 +400,12 @@ static int ad7380_read_direct(struct ad7380_state *st,
>  	};
>  	int ret;
>  
> +	/*
> +	 * In normal average oversampling we need to wait for multiple conversions to be done
Wrap comment at 80 chars.  Generally I prefer we keep to old limit of 80 unless
there is a readability advantage.  I don't see such an advantage in this case.


> +	 */
> +	if (st->oversampling_ratio > 1)
> +		xfers[0].delay.value = T_CONVERT_NS + 500 * st->oversampling_ratio;
> +

> +
> +/**
> + * check_osr - Check the oversampling ratio
> + * @available_ratio: available ratios's array
> + * @size: size of the available_ratio array
> + * ratio: ratio to check
> + *
> + * Check if ratio is present in @available_ratio. Check for exact match.
> + * @available_ratio is an array of the available ratios (depending on the oversampling mode).
> + * The indices must correspond with the bit value expected by the chip.
> + */
> +static inline int check_osr(const int *available_ratio, int size, int ratio)
> +{
> +	int i;
> +
> +	for (i = 0; i < size; i++) {
> +		if (ratio == available_ratio[i])
> +			return i;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int ad7380_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, int val,
> +			    int val2, long mask)
> +{
> +	struct ad7380_state *st = iio_priv(indio_dev);
> +	int ret, osr;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		osr = check_osr(ad7380_normal_average_oversampling_ratios,

Nuno already pointed out function name should be prefixed.

> +				ARRAY_SIZE(ad7380_normal_average_oversampling_ratios),
> +				val);

If this is just checking, why does it return osr?  Feels like name needs
to be ad7380_osr_to_regval() or something like that.

> +
> +		if (osr < 0)
> +			return osr;
> +
> +		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> +			ret = regmap_update_bits(st->regmap, AD7380_REG_ADDR_CONFIG1,
> +						 AD7380_CONFIG1_OSR,
> +						 FIELD_PREP(AD7380_CONFIG1_OSR, osr));
> +
> +			if (ret)
> +				return ret;
> +
> +			st->oversampling_ratio = val;
> +
> +			/*
> +			 * Perform a soft reset.
> +			 * This will flush the oversampling block and FIFO but will
> +			 * maintain the content of the configurable registers.
> +			 */
> +			ret = regmap_update_bits(st->regmap, AD7380_REG_ADDR_CONFIG2,
> +						 AD7380_CONFIG2_RESET,
> +						 FIELD_PREP(AD7380_CONFIG2_RESET,
> +							    AD7380_CONFIG2_RESET_SOFT));
> +		}
> +		return 0;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -435,6 +540,8 @@ static int ad7380_read_raw(struct iio_dev *indio_dev,
>  
>  static const struct iio_info ad7380_info = {
>  	.read_raw = &ad7380_read_raw,
> +	.read_avail = &ad7380_read_avail,
> +	.write_raw = &ad7380_write_raw,
>  	.debugfs_reg_access = &ad7380_debugfs_reg_access,
>  };
>  
> @@ -458,6 +565,12 @@ static int ad7380_init(struct ad7380_state *st, struct regulator *vref)
>  	if (ret < 0)
>  		return ret;
>  
> +	/* Disable oversampling by default.
IIO comment syntax is
	/*
	 * Disable oversampling by default.

Also, curiously short lines that could definitely be wrapped nearer 80 chars!

> +	 * This is the default value after reset,
> +	 * so just initialize internal data
> +	 */
> +	st->oversampling_ratio = 1;
> +
>  	/* SPI 1-wire mode */
>  	return regmap_update_bits(st->regmap, AD7380_REG_ADDR_CONFIG2,
>  				  AD7380_CONFIG2_SDO,
> 


