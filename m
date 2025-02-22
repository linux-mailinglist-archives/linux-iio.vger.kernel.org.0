Return-Path: <linux-iio+bounces-15973-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFE1A40A8E
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 18:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55DC3420F1D
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 17:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108CE207DF0;
	Sat, 22 Feb 2025 17:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GrEx7Gk0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B632D12E7F;
	Sat, 22 Feb 2025 17:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740244352; cv=none; b=JW18LHRIUbZ/+bYoDULE0/oqI5n1WqifWJTu3yiRPy6dAUQTivoOpa+kHGfhNrcBxVY94pm3COYtOMf3wj1jtim48NL+WPs2N6c9axknrFyg3IntiKksSkiQURJgNGIgEqnP3zwoLhZ8d5qkSrPvd8zZ6c5L8P/b3nmSwJcp3ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740244352; c=relaxed/simple;
	bh=rj2K4wXoPdVpJajMF164VvORiACpTNNc5ZCqqV9d44I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n95y0i9NKtmjf/eV1qHYsNtlcaFZFSTWxP5mgbpkPdUu3u++tVKt0i26kwVF8Kqv0M3P9LtDeRhURqSZfSqcSzYsqSgaqJYmopDLFQBIMZsvikCT4reeEEwf8iO91rfi/1rXcQDaHZteSGl+zK+iEZuLG+3cew4aryNk/mB4ttA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GrEx7Gk0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5B46C4CED1;
	Sat, 22 Feb 2025 17:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740244351;
	bh=rj2K4wXoPdVpJajMF164VvORiACpTNNc5ZCqqV9d44I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GrEx7Gk0HSTUOPa9hVNVK3bjoa/GN+FcuvmdLTID2Fb7663UbxrrQIrU09xnS6e9P
	 GaHbnjymrelyqQ4ySZkOyK4a0X+PxlQMx5tHUYkK6kTaK6daByKWDtgHByhwVUJPeU
	 dPWWqsGWBcxJ4hZQ2A57eNz0lmX878g5WMip88BQqQ82vwpK5HfArLP6/oMgmV75g5
	 hzGrqjzHotzcR1GCzvQkfMw5NvYd/9UIof+gOL30ojpjG8d3tjgFRijZGrUWcuwMKn
	 yO41eXM5R+Get3/jrq9GjgBNZhranHrHAnJCC1JMcYcMGx4pRPmBCUK5uoXJd0TatR
	 frstxquxhgDWA==
Date: Sat, 22 Feb 2025 17:12:24 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 13/14] iio: adc: ad4080: add driver support
Message-ID: <20250222171224.10b9dea8@jic23-huawei>
In-Reply-To: <20250220135429.8615-14-antoniu.miclaus@analog.com>
References: <20250220135429.8615-1-antoniu.miclaus@analog.com>
	<20250220135429.8615-14-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Feb 2025 15:54:23 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add support for AD4080 high-speed, low noise, low distortion,
> 20-bit, Easy Drive, successive approximation register (SAR)
> analog-to-digital converter (ADC).
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Hi Antoniu,

Some fairly superficial comments inline.  The bigger questions have
been raised by others.

Jonathan

> ---
>  drivers/iio/adc/Kconfig  |  15 +
>  drivers/iio/adc/Makefile |   1 +
>  drivers/iio/adc/ad4080.c | 768 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 784 insertions(+)
>  create mode 100644 drivers/iio/adc/ad4080.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 27413516216c..b198a93c10b7 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -47,6 +47,21 @@ config AD4030
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called ad4030.
>  
> +config AD4080
> +	tristate "Analog Devices AD4080 high speed ADC"
> +	depends on SPI
> +	select REGMAP_SPI
> +	select IIO_BACKEND
> +	help
> +	  Say yes here to build support for Analog Devices AD4080
> +	  high speed, low noise, low distortion, 20-bit, Easy Drive,
> +	  successive approximation register (SAR) analog-to-digital
> +	  converter (ADC).

Good to give some clue on what sort of bus / backend this connects to in this
description.

> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called ad4080.
> +

One blank line only.

> +
>  config AD4130
>  	tristate "Analog Device AD4130 ADC Driver"
>  	depends on SPI


> diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
> new file mode 100644
> index 000000000000..71c443965e10
> --- /dev/null
> +++ b/drivers/iio/adc/ad4080.c
> @@ -0,0 +1,768 @@

> +
> +/** Miscellaneous Definitions */

Not kernel-doc I think, so /* only

> +#define AD4080_SW_RESET				(BIT(7) | BIT(0))
> +#define AD4080_SPI_READ				BIT(7)
> +#define BYTE_ADDR_H				GENMASK(15, 8)
> +#define BYTE_ADDR_L				GENMASK(7, 0)
Makes little sense as a define and isn't used.


> +#define AD4080_CHIP_ID				GENMASK(2, 0)

> +struct ad4080_state {
> +	struct spi_device		*spi;
> +	struct regmap			*regmap;
> +	struct clk			*clk;
> +	struct iio_backend		*back;
> +	const struct ad4080_chip_info	*info;
> +	/*
> +	 * Synchronize access to members the of driver state, and ensure
> +	 * atomicity of consecutive regmap operations.

Check for those if you can use the regmap provided update functions.

> +	 */
> +	struct mutex			lock;
> +	unsigned int			num_lanes;
> +	enum ad4080_dec_rate		dec_rate;
> +	enum ad4080_filter_sel		filter_mode;
> +	bool				filter_enabled;
> +};

> +static int ad4080_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long m)
> +{
> +	struct ad4080_state *st = iio_priv(indio_dev);
> +	int dec_rate;
> +
> +	switch (m) {
> +	case IIO_CHAN_INFO_SCALE:
> +		return ad4080_get_scale(st, val, val2);
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		if (st->filter_mode == SINC_5_COMP)
> +			dec_rate = ad4080_dec_rate_value[st->dec_rate] * 2;
> +		else
> +			dec_rate = ad4080_dec_rate_value[st->dec_rate];
> +		if (st->filter_enabled)
> +			*val = DIV_ROUND_CLOSEST(clk_get_rate(st->clk), dec_rate);
> +		else
> +			*val = clk_get_rate(st->clk);
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad4080_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long mask)
> +{
> +	struct ad4080_state *st = iio_priv(indio_dev);
> +	unsigned long s_clk;
> +	int dec_rate = 1;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		return -EINVAL;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		s_clk = clk_round_rate(st->clk, val);
> +
> +		if (st->filter_enabled) {
> +			if (st->filter_mode == SINC_5_COMP)
> +				dec_rate = ad4080_dec_rate_value[st->dec_rate] * 2;
> +			else
> +				dec_rate = ad4080_dec_rate_value[st->dec_rate];
> +		}
> +
> +		s_clk *= dec_rate;
> +
> +		if (s_clk < AD4080_MIN_SAMP_FREQ)
> +			s_clk = AD4080_MIN_SAMP_FREQ;
> +		if (s_clk > AD4080_MAX_SAMP_FREQ)
> +			s_clk = AD4080_MAX_SAMP_FREQ;
> +
> +		return clk_set_rate(st->clk, s_clk);
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
can't get here so drop this.

> +}
> +
> +static ssize_t ad4080_lvds_sync_write(struct iio_dev *indio_dev,
> +				      uintptr_t private,
> +				      const struct iio_chan_spec *chan,
> +				      const char *buf, size_t len)
> +{
> +	struct ad4080_state *st = iio_priv(indio_dev);
> +	unsigned int timeout = 100;
> +	bool sync_en;
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +	if (st->num_lanes == 1)
> +		ret = regmap_write(st->regmap, AD4080_REG_ADC_DATA_INTF_CONFIG_A,
> +				   AD4080_RESERVED_CONFIG_A_MSK |
> +				   AD4080_INTF_CHK_EN_MSK);
> +	else
> +		ret = regmap_write(st->regmap, AD4080_REG_ADC_DATA_INTF_CONFIG_A,
> +				   AD4080_RESERVED_CONFIG_A_MSK |
> +				   AD4080_INTF_CHK_EN_MSK |
> +				   AD4080_SPI_LVDS_LANES_MSK);
> +	if (ret)
> +		return ret;
> +
> +	ret = iio_backend_self_sync_enable(st->back);
> +	if (ret)
> +		return ret;
> +
> +	ret = iio_backend_num_lanes_set(st->back, st->num_lanes);
> +	if (ret)
> +		return ret;
> +
> +	ret = iio_backend_bitslip_enable(st->back);
> +	if (ret)
> +		return ret;
> +
> +	do {
> +		ret = iio_backend_sync_status_get(st->back, &sync_en);
> +		if (ret)
> +			return ret;
> +
> +		if (!sync_en)
> +			dev_info(&st->spi->dev, "Not Locked: Running Bit Slip\n");

too noisy. dev_dbg() for something like this.


> +		else
> +			break;
> +	} while (--timeout);
whilst (--timeout && !sync_en) maybe?

> +
> +	if (timeout) {
> +		dev_info(&st->spi->dev, "Success: Pattern correct and Locked!\n");
> +		if (st->num_lanes == 1)
> +			ret = regmap_write(st->regmap, AD4080_REG_ADC_DATA_INTF_CONFIG_A,
> +					   AD4080_RESERVED_CONFIG_A_MSK);
> +		else
> +			ret = regmap_write(st->regmap, AD4080_REG_ADC_DATA_INTF_CONFIG_A,
> +					   AD4080_RESERVED_CONFIG_A_MSK |
> +					   AD4080_SPI_LVDS_LANES_MSK);
> +	} else {
> +		dev_info(&st->spi->dev, "LVDS Sync Timeout.\n");
> +		if (st->num_lanes == 1)
> +			ret = regmap_write(st->regmap, AD4080_REG_ADC_DATA_INTF_CONFIG_A,
> +					   AD4080_RESERVED_CONFIG_A_MSK);
> +		else
> +			ret = regmap_write(st->regmap, AD4080_REG_ADC_DATA_INTF_CONFIG_A,
> +					   AD4080_RESERVED_CONFIG_A_MSK |
> +					   AD4080_SPI_LVDS_LANES_MSK);
> +		ret = -ETIME;
return -ETIME;

However why are you overwriting the values you just put in ret?  Don't store
them into ret if you don't want them.  I'd do this case first before the good one
and return early.


> +	}
> +
> +	return ret ? ret : len;
> +}
.
> +
> +static ssize_t ad4080_lvds_cnv_en_write(struct iio_dev *indio_dev,
> +					uintptr_t private,
> +					const struct iio_chan_spec *chan,
> +					const char *buf, size_t len)
> +{
> +	struct ad4080_state *st = iio_priv(indio_dev);
> +	bool en;
> +	unsigned int data;
> +	int ret;
> +
> +	ret = kstrtobool(buf, &en);
> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	ret = regmap_read(st->regmap, AD4080_REG_ADC_DATA_INTF_CONFIG_B, &data);
> +	if (ret)
> +		return ret;
> +
> +	data &= ~AD4080_LVDS_CNV_EN_MSK;
> +	data |= en;
> +
> +	ret = regmap_write(st->regmap, AD4080_REG_ADC_DATA_INTF_CONFIG_B, data);
regmap_update_bits()? and consider if the regmap lock is enough.

> +
> +	return ret ? ret : len;
> +}
> +
> +static ssize_t ad4080_get_filter_mode(struct iio_dev *dev,
> +				      const struct iio_chan_spec *chan)
> +{
> +	struct ad4080_state *st = iio_priv(dev);
> +	unsigned int data;
> +	int ret;
> +
> +	ret = regmap_read(st->regmap, AD4080_REG_FILTER_CONFIG, &data);
> +	if (ret)
> +		return ret;
> +
> +	data = FIELD_GET(GENMASK(1, 0), data);
That GENMASK should probably be a define for the field in the register.

> +
> +	return data;
return FIELD_GET() 
In general not good to use same local variable for the register contents
and the field.  It doesn't help readability. Here you don't need a second
one but if you do, give it a name reflecting what it is.

> +}
> +
> +static int ad4080_set_filter_mode(struct iio_dev *dev,
> +				  const struct iio_chan_spec *chan,
> +				  unsigned int mode)
> +{
> +	struct ad4080_state *st = iio_priv(dev);
> +	int ret;
> +	unsigned int data;
> +	unsigned int reg_val;
> +
> +	if (mode >= SINC_5 && st->dec_rate >= DEC_512)
> +		return -EINVAL;
> +
> +	guard(mutex)(&st->lock);
> +	if (mode) {
> +		ret = iio_backend_filter_enable(st->back);
> +		if (ret)
> +			return ret;
> +
> +		st->filter_enabled = true;

st->filter_enabled = mode; and drop it out of the conditional part.

> +	} else {
> +		ret = iio_backend_filter_enable(st->back);

Enable in both paths?

> +		if (ret)
> +			return ret;
> +
> +		st->filter_enabled = false;
> +	}
> +	ret = regmap_read(st->regmap, AD4080_REG_FILTER_CONFIG, &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	data = ((reg_val & AD4080_SINC_DEC_RATE_MSK)) |
> +	       (mode & AD4080_FILTER_SEL_MSK);
Excess brackets on first line.
> +
> +	ret = regmap_write(st->regmap, AD4080_REG_FILTER_CONFIG, data);
> +	if (ret)
> +		return ret;
> +
> +	st->filter_mode = mode;
> +
> +	return ret;
> +}
> +
> +static ssize_t ad4080_get_dec_rate(struct iio_dev *dev,
> +				   const struct iio_chan_spec *chan)
> +{
> +	struct ad4080_state *st = iio_priv(dev);
> +	int ret;
> +	unsigned int data;
> +
> +	ret = regmap_read(st->regmap, AD4080_REG_FILTER_CONFIG, &data);
> +	if (ret)
> +		return ret;
> +
> +	data = FIELD_GET(AD4080_SINC_DEC_RATE_MSK, data);
> +
> +	return data;
return FEILD_GET()

> +}
> +
> +static int ad4080_set_dec_rate(struct iio_dev *dev,
> +			       const struct iio_chan_spec *chan,
> +			       unsigned int mode)
> +{
> +	struct ad4080_state *st = iio_priv(dev);
> +	int ret;
> +	unsigned int data;
> +	unsigned int reg_val;
> +
> +	if (st->filter_mode >= SINC_5 && mode >= DEC_512)
> +		return -EINVAL;
> +
> +	guard(mutex)(&st->lock);
> +	ret = regmap_read(st->regmap, AD4080_REG_FILTER_CONFIG, &reg_val);

If it's a filter thing I'm guessing it's averaging multiple samples? If so
that's oversampling as David pointed out - so standard ABI.
Slight complexity is sampling frequency is after oversampling is applied
so they end up coupled.


> +	if (ret)
> +		return ret;
> +
> +	data = (mode << 3) | (reg_val & AD4080_FILTER_SEL_MSK);
> +	ret = regmap_write(st->regmap, AD4080_REG_FILTER_CONFIG, data);
> +	if (ret)
> +		return ret;
> +
> +	st->dec_rate = mode;
> +
> +	return ret;
> +}

> +static struct iio_chan_spec_ext_info ad4080_ext_info[] = {
> +	{
> +	 .name = "lvds_sync",
1 tab further in than the {
> +	 .write = ad4080_lvds_sync_write,
> +	 .shared = IIO_SHARED_BY_ALL,
> +	 },
> +	{
> +	 .name = "lvds_cnv",
> +	 .read = ad4080_lvds_cnv_en_read,
> +	 .write = ad4080_lvds_cnv_en_write,
> +	 .shared = IIO_SHARED_BY_ALL,
> +	},
> +	IIO_ENUM("sinc_dec_rate",
> +		 IIO_SHARED_BY_ALL,
> +		 &ad4080_dec_rate_enum),

Wrap at 80 chars.

> +	IIO_ENUM_AVAILABLE("sinc_dec_rate",
> +			   IIO_SHARED_BY_ALL,
> +			   &ad4080_dec_rate_enum),
> +	IIO_ENUM("filter_sel",
> +		 IIO_SHARED_BY_ALL,
> +		 &ad4080_filter_mode_enum),
> +	IIO_ENUM_AVAILABLE("filter_sel",
> +			   IIO_SHARED_BY_ALL,
> +			   &ad4080_filter_mode_enum),
> +	{},
No comma on 'terminators' like this.

> +};

> +
> +static int ad4080_post_setup(struct iio_dev *indio_dev)
> +{
> +	struct ad4080_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = iio_backend_num_lanes_set(st->back, st->num_lanes);
> +	if (ret)
> +		return ret;
> +
> +	return iio_backend_self_sync_enable(st->back);
> +}
> +
> +static int ad4080_setup(struct iio_dev *indio_dev)
> +{
> +	struct ad4080_state *st = iio_priv(indio_dev);
> +	unsigned int id;
> +	int ret;
> +
> +	ret = regmap_write(st->regmap, AD4080_REG_INTERFACE_CONFIG_A,
> +			   AD4080_SW_RESET);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, AD4080_REG_INTERFACE_CONFIG_A,
> +			   AD4080_SDO_ENABLE_MSK);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(st->regmap, AD4080_REG_CHIP_TYPE, &id);
> +	if (ret)
> +		return ret;
> +
> +	if (id != AD4080_CHIP_ID) {

If only called during probe just return dev_err_probe()

> +		dev_err(&st->spi->dev, "Unrecognized CHIP_ID 0x%X\n", id);
> +		return -EINVAL;
> +	}
> +
> +	if (st->num_lanes)
> +		regmap_write(st->regmap, AD4080_REG_ADC_DATA_INTF_CONFIG_B,
> +			     FIELD_PREP(AD4080_LVDS_CNV_CLK_CNT_MSK, 7) |
> +			     AD4080_LVDS_CNV_EN_MSK);
Check return value on these
> +	else
> +		regmap_write(st->regmap, AD4080_REG_ADC_DATA_INTF_CONFIG_B,
> +			     AD4080_LVDS_CNV_EN_MSK);
> +
> +	ret = regmap_set_bits(st->regmap, AD4080_REG_GPIO_CONFIG_A,
> +			      AD4080_GPO_1_EN);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, AD4080_REG_GPIO_CONFIG_B,
> +			   FIELD_PREP(AD4080_GPIO_1_SEL, 3));
> +	if (ret)
> +		return ret;
> +
> +	return ad4080_post_setup(indio_dev);
What does that give you?  Just put those few lines here.
> +}
> +
> +static int ad4080_properties_parse(struct ad4080_state *st)
> +{
> +	unsigned int val;
> +	int ret;
> +
> +	ret = device_property_read_u32(&st->spi->dev, "adi,num_lanes", &val);
> +	if (!ret)
> +		st->num_lanes = val;
> +	else
> +		st->num_lanes = 1;
For cases with a default the pattern to use is:

	st->num_lanes = 1;
	device_property_read_u32(&st->spi->dev, "adi,num_lanes", &val);

No point in have a return type if you always return 0 - that just
implies a check is needed when it is not.

> +
> +	return 0;
> +}

> +static const struct spi_device_id ad4080_id[] = {
> +	{ "ad4080", (kernel_ulong_t)&ad4080_chip_info },

Unless you have support planned in the near future for more parts, we tend
not to add the flexibility of chip specific data until the series that
adds support for a second part.  Sometimes this has been added in the
past, no other part ever got supported, and we carry extra complexity
for no reason.   Good to mention if you are planning to add more
parts in this patches description.

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, ad4080_id);
> +
> +static const struct of_device_id ad4080_of_match[] = {
> +	{ .compatible = "adi,ad4080", &ad4080_chip_info },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ad4080_of_match);

