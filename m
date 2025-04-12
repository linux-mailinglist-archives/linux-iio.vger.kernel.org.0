Return-Path: <linux-iio+bounces-18019-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84708A86E62
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 19:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FA2019E17A3
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 17:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BD71F03EC;
	Sat, 12 Apr 2025 17:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PjwDMYZA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C062818C93C;
	Sat, 12 Apr 2025 17:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744478349; cv=none; b=sYNIKwJpp0LNqbqnthPl0pXgtWywrR4FS0jTurO2x/GgiqbTbJ120OTQE8I2VazipACm/gZfwe8o/MQgICrxjfsiuoHZ/jJ7U/nUfDoUWmKgj5lHGl0uBmjZ4CKMwflo9fJkoKlmWln5p/CE2GFjaclg//OS05ELKGYMs/PwFpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744478349; c=relaxed/simple;
	bh=CC1mCMcELtJG4r7ykvk965wJP0bgpiZTexGFMbIEiH8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VMf7/ID8f7A8ZT7h9teVjlNeJbYxmFv90sFog0BqecoBo1LSJZo797E/lSloz+UxJu8UkOlzmXyDrnkzzzXxHUBfHJ5X3YWnUs+f3OEE6nsNrOx0f1Pv72SAlIpN6SNKKp/WlAELQXLcBJntTpbctXzWVi2Hnn7lL78u17wdneA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PjwDMYZA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C1FC4CEE5;
	Sat, 12 Apr 2025 17:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744478349;
	bh=CC1mCMcELtJG4r7ykvk965wJP0bgpiZTexGFMbIEiH8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PjwDMYZAI1WyoT6qMu/K8jAbxypWhFvnVMYgOVyIjMDBOxdbFzcpPfSfQFtUtc8RE
	 dbFyt2WltGFtc/P62YRERuHq8RU2kyW5DrMVSibnpDzZ19SNZVkZu4WUYhF1lcr4TZ
	 u2vUSQX8HQLvZRglx4xrPGIKaKck+66A/inRaTqeZZ2cjjDO5EMLHX2z6Ilv/tqZhX
	 3IMEPaZ0XmHcrbsRCxNdfRte4c43ZHUlCKHa/wX5pdxVLJzop6Ev79sWUPFPbseLZl
	 G+iSXE/R5wBdZSlvr8C1u+SfZulB4h4ZQAdZvScrWIIom93ReBruzX4ShNBwmGF9Vl
	 x5Yo/Os/ASryQ==
Date: Sat, 12 Apr 2025 18:19:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 13/13] iio: adc: ad4080: add driver support
Message-ID: <20250412181902.16492ffb@jic23-huawei>
In-Reply-To: <20250411123627.6114-14-antoniu.miclaus@analog.com>
References: <20250411123627.6114-1-antoniu.miclaus@analog.com>
	<20250411123627.6114-14-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Apr 2025 15:36:27 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add support for AD4080 high-speed, low noise, low distortion,
> 20-bit, Easy Drive, successive approximation register (SAR)
> analog-to-digital converter (ADC).
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
I'll leave the backend stuff to Nuno who has a better feel than
me for what fits in that interface.  So this is just a review
of the rest of this driver.

Various minor comments inline

Thanks,

Jonathan

> diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
> new file mode 100644
> index 000000000000..3a0b1ad13765
> --- /dev/null
> +++ b/drivers/iio/adc/ad4080.c

> +/* AD4080_REG_GPIO_CONFIG_B Bit Definition */
> +#define AD4080_GPIO_1_SEL			GENMASK(7, 4)
> +#define AD4080_GPIO_0_SEL			GENMASK(3, 0)
> +
> +/* AD4080_REG_FIFO_CONFIG Bit Definition */
> +#define AD4080_FIFO_MODE_MSK			GENMASK(1, 0)
> +
> +/* AD4080_REG_FILTER_CONFIG Bit Definition */
Better to name the defines to make that association explicit.
#define AD4080_FILTER_CONFIG_SINC_DEC_RATE_MSK etc

> +#define AD4080_SINC_DEC_RATE_MSK		GENMASK(6, 3)
> +#define AD4080_FILTER_SEL_MSK			GENMASK(1, 0)
> +
> +/* Miscellaneous Definitions */
> +#define AD4080_SW_RESET				(BIT(7) | BIT(0))
> +#define AD4080_SPI_READ				BIT(7)
> +#define BYTE_ADDR_H				GENMASK(15, 8)
> +#define BYTE_ADDR_L				GENMASK(7, 0)
Definitely not on those two!

If you are going this you are probably reading into the wrong data type.

> +static const unsigned int ad4080_scale_table[][2] = {
> +	{6000, 0},
	{ 6000, 0 },
> +};
> +
> +static const char *const ad4080_filter_type_iio_enum[] = {
> +	[FILTER_DISABLE]   = "disabled",
> +	[SINC_1]           = "sinc1",
> +	[SINC_5]           = "sinc5",
> +	[SINC_5_COMP]      = "sinc5_plus_compensation",
> +};
> +
> +static const int ad4080_dec_rate_iio_enum[] = {
> +	2, 4, 8, 16, 32, 64, 128, 256, 512, 1024
Convention is keep a trailing comma except when we have
an explicit terminating entry (NULL etc)

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
> +	if (st->filter_type >= SINC_5 && mode >= 512)
> +		return -EINVAL;
> +
> +	guard(mutex)(&st->lock);
> +	ret = regmap_read(st->regmap, AD4080_REG_FILTER_CONFIG, &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	data = ((ilog2(mode) - 1) << 3) | (reg_val & AD4080_FILTER_SEL_MSK);

As below. Odd to keep stuff with explicit mask like this rather than more
normal masking out what we are placing. &= ~SINC_RET_DATA_MSK; etc
 

> +	ret = regmap_write(st->regmap, AD4080_REG_FILTER_CONFIG, data);
> +	if (ret)
> +		return ret;
> +
> +	st->dec_rate = mode;
> +
> +	return ret;
> +}

> +static int ad4080_lvds_sync_write(struct ad4080_state *st)
> +{
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
> +	ret = iio_backend_data_alignment_enable(st->back);
> +	if (ret)
> +		return ret;
> +
> +	do {
> +		ret = iio_backend_sync_status_get(st->back, &sync_en);
> +		if (ret)
> +			return ret;
> +
> +		if (!sync_en)
> +			dev_dbg(&st->spi->dev, "Not Locked: Running Bit Slip\n");

Maybe sleep a bit before trying again?  Tight loops are very dependent on the
host CPU which is probably not what you want here.

> +	} while (--timeout && !sync_en);
> +
> +	if (timeout) {
> +		dev_info(&st->spi->dev, "Success: Pattern correct and Locked!\n");
> +		if (st->num_lanes == 1)
> +			return regmap_write(st->regmap, AD4080_REG_ADC_DATA_INTF_CONFIG_A,
> +					    AD4080_RESERVED_CONFIG_A_MSK);
> +		else
> +			return regmap_write(st->regmap, AD4080_REG_ADC_DATA_INTF_CONFIG_A,
> +					    AD4080_RESERVED_CONFIG_A_MSK |
> +					    AD4080_SPI_LVDS_LANES_MSK);
> +	} else {
> +		dev_info(&st->spi->dev, "LVDS Sync Timeout.\n");
> +		if (st->num_lanes == 1) {
> +			ret = regmap_write(st->regmap, AD4080_REG_ADC_DATA_INTF_CONFIG_A,
> +					   AD4080_RESERVED_CONFIG_A_MSK);
> +			if (ret)
> +				return ret;
> +		} else {
> +			ret = regmap_write(st->regmap, AD4080_REG_ADC_DATA_INTF_CONFIG_A,
> +					   AD4080_RESERVED_CONFIG_A_MSK |
> +					   AD4080_SPI_LVDS_LANES_MSK);
> +			if (ret)
> +				return ret;
> +		}
> +
> +		return -ETIMEDOUT;
> +	}
> +}

> +
> +static int ad4080_set_filter_type(struct iio_dev *dev,
> +				  const struct iio_chan_spec *chan,
> +				  unsigned int mode)
> +{
> +	struct ad4080_state *st = iio_priv(dev);
> +	int ret;
> +	unsigned int data;
> +	unsigned int reg_val;
> +
> +	if (mode >= SINC_5 && st->dec_rate >= 512)
> +		return -EINVAL;
> +
> +	guard(mutex)(&st->lock);
> +	if (mode)
> +		ret = iio_backend_filter_enable(st->back);
> +	else
> +		ret = iio_backend_filter_disable(st->back);
> +	if (ret)
> +		return ret;
> +
> +	st->filter_en = mode;
> +
> +	ret = regmap_read(st->regmap, AD4080_REG_FILTER_CONFIG, &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	data = (reg_val & AD4080_SINC_DEC_RATE_MSK) |
> +	       (mode & AD4080_FILTER_SEL_MSK);

FIELD_PREP() for the second part.
The first is hanging on to one field.  Maybe just pull that out with
a FIELD_GET() and write it back again with FIELD_PREP?
Will be more code, but a little less subtle to read!


> +
> +	ret = regmap_write(st->regmap, AD4080_REG_FILTER_CONFIG, data);
> +	if (ret)
> +		return ret;
> +
> +	st->filter_type = mode;
> +
> +	return ret;
> +}

> +static struct iio_chan_spec_ext_info ad4080_ext_info[] = {
> +	IIO_ENUM("filter_type",
> +		 IIO_SHARED_BY_ALL,
> +		 &ad4080_filter_type_enum),
very short line wrap - aim for nearer 80 chars.

> +	IIO_ENUM_AVAILABLE("filter_type",
> +			   IIO_SHARED_BY_ALL,
> +			   &ad4080_filter_type_enum),
> +	{}
Trivial preference for 
	{ }

> +};
> +
> +#define AD4080_CHAN(_chan, _si, _bits, _sign, _shift)		\
> +	{ .type = IIO_VOLTAGE,	
Odd indent. Better perhaps as simpler
	{ \
		.indexed = 1, 
etc.					\
> +	  .indexed = 1,							\
> +	  .channel = _chan,						\
> +	  .info_mask_separate = BIT(IIO_CHAN_INFO_SCALE),		\
> +	  .info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |	\
> +		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),			\
> +	  .info_mask_shared_by_all_available =				\
> +		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),			\
> +	  .ext_info = ad4080_ext_info,					\
> +	  .scan_index = _si,						\
> +	  .scan_type = {						\
> +			.sign = _sign,					\
Current indent makes this look really wierd!

> +			.realbits = _bits,				\
> +			.storagebits = 32,				\
> +			.shift = _shift,				\
> +	  },								\
> +	}
> +
> +static const struct iio_chan_spec ad4080_channels[] = {
> +	AD4080_CHAN(0, 0, 20, 's', 0)
Don't bother with the macro as it doesn't add anything. Just put that
stuff all here. That will let you skip setting obvious defaults to 0
like the shift.

> +};
> +
> +static const struct ad4080_chip_info ad4080_chip_info = {
> +	.name = "AD4080",
> +	.product_id = AD4080_CHIP_ID,
> +	.scale_table = ad4080_scale_table,
> +	.num_scales = ARRAY_SIZE(ad4080_scale_table),
> +	.num_channels = 1,
> +	.channels = ad4080_channels,
> +};
> +
> +static int ad4080_setup(struct iio_dev *indio_dev)
> +{

> +	if (id != AD4080_CHIP_ID)
> +		return dev_err_probe(&st->spi->dev, -EINVAL,
> +				     "Unrecognized CHIP_ID 0x%X\n", id);
A mismatch on ID should not be treated as an error. That breaks the
use of fallback dt compatibles.  So convention on these is a dev_info()
and carry on anyway.  We've left breadcrumbs if things don't work but
not our role to make sure it is definitely the right hardware in the
firmware description.

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
> +	ret = iio_backend_num_lanes_set(st->back, st->num_lanes);
> +	if (ret)
> +		return ret;
> +
> +	ret = iio_backend_self_sync_enable(st->back);
> +	if (ret)
> +		return ret;
> +
> +	if (st->lvds_cnv_en) {
I'd flip this unless you expect to shortly add more optional stuff after this
code

	if (!st->lvds_cnv_en)
		return 0;

	..

> +		if (st->num_lanes) {
> +			ret = regmap_update_bits(st->regmap,
> +						 AD4080_REG_ADC_DATA_INTF_CONFIG_B,
> +						 AD4080_LVDS_CNV_CLK_CNT_MSK,
> +						 FIELD_PREP(AD4080_LVDS_CNV_CLK_CNT_MSK, 7));
> +			if (ret)
> +				return ret;
> +		}
> +
> +		ret = regmap_set_bits(st->regmap,
> +				      AD4080_REG_ADC_DATA_INTF_CONFIG_B,
> +				      AD4080_LVDS_CNV_EN_MSK);
> +		if (ret)
> +			return ret;
> +
> +		return ad4080_lvds_sync_write(st);
> +	}
> +
> +	return 0;
> +}
> +
> +static void ad4080_properties_parse(struct ad4080_state *st)
> +{
> +	unsigned int val;
> +	int ret;
> +
> +	st->lvds_cnv_en = device_property_read_bool(&st->spi->dev,
> +						    "adi,lvds-cnv-enable");
> +
> +	st->num_lanes = 1;
> +	ret = device_property_read_u32(&st->spi->dev, "adi,num_lanes", &val);
> +	if (!ret)
> +		st->num_lanes = val;
Usual trick on these places were we have a default is to pick types correctly 
and do.

	st->num_lanes = 1;
	device_property_read_u32(&st->spi->dev, "adi,num_lanes", &st->num_lanes);

That is, rely on the call being side effect free on error.
 
> +}


