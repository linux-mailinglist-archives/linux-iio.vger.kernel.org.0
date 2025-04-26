Return-Path: <linux-iio+bounces-18687-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08417A9DAFA
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 15:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 456F2465843
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 13:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262AD13633F;
	Sat, 26 Apr 2025 13:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="drKcie37"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AEFC148;
	Sat, 26 Apr 2025 13:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745673202; cv=none; b=baToVltHN/ceHTDlUCvH9zbJXYDm3u9jSbpS7zugPl8FBzTn2mZRXtAdQuYC+upfYuontSzmsQern3zG8Jq0A0LLff9BZx3pnCrk5YRJmykMZAnMWT3wlxeEaTUAl+FC4RjcjoGV0Xkbw4cUueEqmCjw38r+YS6ZhVfuhl0LCec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745673202; c=relaxed/simple;
	bh=jRCW9GwSmNMNrv0JZ5SK1hKvcXJ1Yb89YAwtysPGlXY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=meJ4vI1ZdoUzq39bsMoN/ZaPcAjkxSBbLCHFteoqze2/dXWngEfg2tyt8sWTghfO8z28+LTEsiorigUZjQCdWjnvFXgh/TtE2pCc+PNQTEtYqzS9yl79vSH24CCQTrXH5uYUjnLcxBPsa58iIMloOm32IZz7L4whBc/iWNGhgXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=drKcie37; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EB22C4CEE2;
	Sat, 26 Apr 2025 13:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745673202;
	bh=jRCW9GwSmNMNrv0JZ5SK1hKvcXJ1Yb89YAwtysPGlXY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=drKcie378hmS8vpUBf645zEaeXhrKf3lDQTekMw7FmDzcV+ya8z2CsWptvbQYIoQf
	 ioosjiSb9AckiZE4Z1RNskf9KfZAkS1C/nApPADfGAywn9+yhsBQN4VJkWYR7Qmsym
	 /GDE7GOdkIu5tCNv0551k4eBaUkMlM7zvMiyqbn9qH72ciGgY2y3YrkDNaPwWO2pfj
	 4cvRZTRBL0a2/xxKIwJCu0sgjflu4Uw7jx1Q+U4PQDdxUJPu/uWf+4UU7cIVIZGF96
	 olr+nPqQbbVrzqySJSoHhr4iVWgl0/BwLNTayVLYlVWZAP03a5HI2cQZ6waB03nEc0
	 JnMGo811XBz6Q==
Date: Sat, 26 Apr 2025 14:13:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 11/11] iio: adc: ad4080: add driver support
Message-ID: <20250426141316.5c87d138@jic23-huawei>
In-Reply-To: <20250425112538.59792-12-antoniu.miclaus@analog.com>
References: <20250425112538.59792-1-antoniu.miclaus@analog.com>
	<20250425112538.59792-12-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Apr 2025 14:25:38 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add support for AD4080 high-speed, low noise, low distortion,
> 20-bit, Easy Drive, successive approximation register (SAR)
> analog-to-digital converter (ADC).
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Hi Antoniu

I noticed a few things on a fresh read through I'd missed on earlier versions.
Sorry about that!

In particular I think moving to explicitly just updating the bits you need
to in a few paths around sync will simplify the code quite a bit and make
sure the stuff related to sync is all that happens in there.

The use of _MSK defines for single bits is fine if you also use FIELD_PREP()
to set them to 0 / 1 as appropriate, but it is confusing if you just
use them directly to write the values as we can't see at that point in the
code that they are single bit masks.  I'd drop the _MSK postfix on those.

Thanks

Jonathan

> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 9f26d5eca822..e6efed5b4e7a 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_AB8500_GPADC) += ab8500-gpadc.o
>  obj-$(CONFIG_AD_SIGMA_DELTA) += ad_sigma_delta.o
>  obj-$(CONFIG_AD4000) += ad4000.o
>  obj-$(CONFIG_AD4030) += ad4030.o
> +obj-$(CONFIG_AD4080) += ad4080.o
>  obj-$(CONFIG_AD4130) += ad4130.o
>  obj-$(CONFIG_AD4695) += ad4695.o
>  obj-$(CONFIG_AD4851) += ad4851.o
> diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
> new file mode 100644
> index 000000000000..b51893253941
> --- /dev/null
> +++ b/drivers/iio/adc/ad4080.c
> @@ -0,0 +1,618 @@

> +/* AD4080_REG_INTERFACE_CONFIG_A Bit Definition */
> +#define AD4080_INTERFACE_CONFIG_A_SW_RESET_MSK			(BIT(7) | BIT(0))
> +#define AD4080_INTERFACE_CONFIG_A_ADDR_ASC_MSK			BIT(5)
> +#define AD4080_INTERFACE_CONFIG_A_SDO_ENABLE_MSK		BIT(4)
> +
> +/* AD4080_REG_INTERFACE_CONFIG_B Bit Definition */
> +#define AD4080_INTERFACE_CONFIG_B_SINGLE_INST_MSK		BIT(7)
> +#define AD4080_INTERFACE_CONFIG_B_SHORT_INST_MSK		BIT(3)
> +
> +/* AD4080_REG_DEVICE_CONFIG Bit Definition */
> +#define AD4080_DEVICE_CONFIG_OPERATING_MODES_MSK		GENMASK(1, 0)
> +
> +/* AD4080_REG_TRANSFER_CONFIG Bit Definition */
> +#define AD4080_TRANSFER_CONFIG_KEEP_STREAM_LENGTH_VAL_MSK	BIT(2)
> +
> +/* AD4080_REG_INTERFACE_CONFIG_C Bit Definition */
> +#define AD4080_INTERFACE_CONFIG_C_STRICT_REG_ACCESS_MSK		BIT(5)
> +
> +/* AD4080_REG_ADC_DATA_INTF_CONFIG_A Bit Definition */
> +#define AD4080_ADC_DATA_INTF_CONFIG_A_RESERVED_CONFIG_A_MSK	BIT(6)

If we are going to call these masks we should be using field prep to specify
the values.   Dropping the _MSK postfix is also fine for single bit values
ant which point just | them into register values looks less odd.

> +#define AD4080_ADC_DATA_INTF_CONFIG_A_INTF_CHK_EN_MSK		BIT(4)
> +#define AD4080_ADC_DATA_INTF_CONFIG_A_SPI_LVDS_LANES_MSK	BIT(2)
> +#define AD4080_ADC_DATA_INTF_CONFIG_A_DATA_INTF_MODE_MSK	BIT(0)
> +
> +/* AD4080_REG_ADC_DATA_INTF_CONFIG_B Bit Definition */
> +#define AD4080_ADC_DATA_INTF_CONFIG_B_LVDS_CNV_CLK_CNT_MSK	GENMASK(7, 4)
> +#define AD4080_ADC_DATA_INTF_CONFIG_B_LVDS_SELF_CLK_MODE_MSK	BIT(3)
> +#define AD4080_ADC_DATA_INTF_CONFIG_B_LVDS_CNV_EN_MSK		BIT(0)
> +
> +/* AD4080_REG_ADC_DATA_INTF_CONFIG_C Bit Definition */
> +#define AD4080_ADC_DATA_INTF_CONFIG_C_LVDS_VOD_MSK		GENMASK(6, 4)
> +
> +/* AD4080_REG_PWR_CTRL Bit Definition */
> +#define AD4080_PWR_CTRL_ANA_DIG_LDO_PD_MSK			BIT(1)
> +#define AD4080_PWR_CTRL_INTF_LDO_PD_MSK				BIT(0)
> +
> +/* AD4080_REG_GPIO_CONFIG_A Bit Definition */
> +#define AD4080_GPIO_CONFIG_A_GPO_1_EN_MSK			BIT(1)
> +#define AD4080_GPIO_CONFIG_A_GPO_0_EN_MSK			BIT(0)
> +
> +/* AD4080_REG_GPIO_CONFIG_B Bit Definition */
> +#define AD4080_GPIO_CONFIG_B_GPIO_1_SEL				GENMASK(7, 4)
> +#define AD4080_GPIO_CONFIG_B_GPIO_0_SEL				GENMASK(3, 0)
> +
> +/* AD4080_REG_FIFO_CONFIG Bit Definition */
> +#define AD4080_FIFO_CONFIG_FIFO_MODE_MSK			GENMASK(1, 0)
> +
> +/* AD4080_REG_FILTER_CONFIG Bit Definition */
> +#define AD4080_FILTER_CONFIG_SINC_DEC_RATE_MSK			GENMASK(6, 3)
> +#define AD4080_FILTER_CONFIG_FILTER_SEL_MSK			GENMASK(1, 0)
> +
> +/* Miscellaneous Definitions */
> +#define AD4080_SPI_READ						BIT(7)
> +#define AD4080_CHIP_ID						GENMASK(2, 0)
> +
> +#define AD4080_MAX_SAMP_FREQ					40000000
> +#define AD4080_MIN_SAMP_FREQ					1250000
> +
> +enum ad4080_filter_type {
> +	FILTER_DISABLE,
> +	SINC_1,
> +	SINC_5,
> +	SINC_5_COMP
> +};
> +
> +static const unsigned int ad4080_scale_table[][2] = {
> +	{ 6000, 0},
space before } 

Check for other instances of this.

Also, why does this exist?  If you have other device support on the way where
this will change I don't mind having this table, but if not then just encode the
values inline.

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
> +	2, 4, 8, 16, 32, 64, 128, 256, 512, 1024,
> +};
> +
> +static const char * const ad4080_power_supplies[] = {
> +	"vdd33", "vdd11", "vddldo", "iovdd", "vrefin",
> +};
> +
> +struct ad4080_chip_info {
> +	const char *name;
> +	unsigned int product_id;
> +	int num_scales;
> +	const unsigned int (*scale_table)[2];
> +	const struct iio_chan_spec *channels;
> +	unsigned int num_channels;
> +};
> +
> +struct ad4080_state {
> +	struct spi_device		*spi;
> +	struct regmap			*regmap;
> +	struct clk			*clk;
> +	struct iio_backend		*back;
> +	const struct ad4080_chip_info	*info;
> +	/*
> +	 * Synchronize access to members the of driver state, and ensure
> +	 * atomicity of consecutive regmap operations.
> +	 */
> +	struct mutex			lock;
> +	unsigned int			num_lanes;
> +	unsigned int			dec_rate;
> +	enum ad4080_filter_type		filter_type;
> +	bool				lvds_cnv_en;
> +};

> +
> +static int ad4080_lvds_sync_write(struct ad4080_state *st)
> +{
> +	unsigned int timeout = 100;
> +	bool sync_en;
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +	if (st->num_lanes == 1)
> +		ret = regmap_write(st->regmap, AD4080_REG_ADC_DATA_INTF_CONFIG_A,
> +				   AD4080_ADC_DATA_INTF_CONFIG_A_RESERVED_CONFIG_A_MSK |
Writing a reserved bit is unusual... (though I see it defaults to on)

Maybe you are better off just not touching that bit in the driver explicitly and instead
use.
		ret = regmap_set_bits(st->regmap, AD4080_REG_ADC_DATA_INTF_CONFIG_A,
				      AD4080_ADC_DATA_INTF_CONFIG_A_INTF_CHK_EN_MSK);   

> +				   AD4080_ADC_DATA_INTF_CONFIG_A_INTF_CHK_EN_MSK);
> +	else
> +		ret = regmap_write(st->regmap, AD4080_REG_ADC_DATA_INTF_CONFIG_A,
> +				   AD4080_ADC_DATA_INTF_CONFIG_A_RESERVED_CONFIG_A_MSK |
> +				   AD4080_ADC_DATA_INTF_CONFIG_A_INTF_CHK_EN_MSK |
> +				   AD4080_ADC_DATA_INTF_CONFIG_A_SPI_LVDS_LANES_MSK);

The lanes field doesn't seem to have anything directly to do with sync.
So should that perhaps be a separate regmap_set_bits() call before this function?
There is already some num_lanes related code in ad4080_setup().

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
> +
> +		fsleep(500);
> +	} while (--timeout && !sync_en);
> +
> +	if (timeout) {
> +		dev_info(&st->spi->dev, "Success: Pattern correct and Locked!\n");
dev_dbg() on success tings.

> +		if (st->num_lanes == 1)
> +			return regmap_write(st->regmap, AD4080_REG_ADC_DATA_INTF_CONFIG_A,
> +					    AD4080_ADC_DATA_INTF_CONFIG_A_RESERVED_CONFIG_A_MSK);

These triggered comment above on using FIELD_PREP() for things called _MSK even
if they are single bit. The _MSK naming normally implies they are multi bit making this
code look somewhat odd.

If you were to use regmap_clear_bits(st->regmap, AD4080_REG_ADC_DATA_INF_CONFIG_A,
				     AD4080_DATA_INF_CONFIG_A_INTF_CHK_EN_MSK);

then you don't need to make it depend on the number of lanes.


> +		else
> +			return regmap_write(st->regmap, AD4080_REG_ADC_DATA_INTF_CONFIG_A,
> +					    AD4080_ADC_DATA_INTF_CONFIG_A_RESERVED_CONFIG_A_MSK |
> +					    AD4080_ADC_DATA_INTF_CONFIG_A_SPI_LVDS_LANES_MSK);
> +	} else {
> +		dev_info(&st->spi->dev, "LVDS Sync Timeout.\n");

dev_err() given it's a failure is probably appropriate.

> +		if (st->num_lanes == 1) {
> +			ret = regmap_write(st->regmap, AD4080_REG_ADC_DATA_INTF_CONFIG_A,
> +					   AD4080_ADC_DATA_INTF_CONFIG_A_RESERVED_CONFIG_A_MSK);
> +			if (ret)
> +				return ret;
> +		} else {
> +			ret = regmap_write(st->regmap, AD4080_REG_ADC_DATA_INTF_CONFIG_A,
> +					   AD4080_ADC_DATA_INTF_CONFIG_A_RESERVED_CONFIG_A_MSK |
> +					   AD4080_ADC_DATA_INTF_CONFIG_A_SPI_LVDS_LANES_MSK);
Here you can use regmap_clear_bits() as well.  That will also reduce the amount of duplicate
code so there is less reason to try and share it.

> +			if (ret)
> +				return ret;

Not clear to me we should return this error rather than -ETIMEDOUT in these cases
(as that was the first thing to go wrong).

> +		}
> +
> +		return -ETIMEDOUT;
> +	}
> +}

> +static const struct iio_chan_spec ad4080_channels[] = {
> +	{
> +		.type = IIO_VOLTAGE,
> +		.indexed = 1,
> +		.channel = 0,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> +				BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +		.info_mask_shared_by_all_available =
> +				BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +		.ext_info = ad4080_ext_info,
> +		.scan_index = 0,
> +		.scan_type = {
> +			.sign = 's',
> +			.realbits = 20,
> +			.storagebits = 32,
> +			.shift = 0,

Trivial but we normally don't bother specifying shift explicitly if it is 0
as that's (kind of) the obvious default value.

> +		},
> +	}
> +};


