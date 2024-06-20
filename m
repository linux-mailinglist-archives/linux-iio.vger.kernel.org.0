Return-Path: <linux-iio+bounces-6643-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19ECC9112B3
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jun 2024 22:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC669283ECE
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jun 2024 20:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697521B4C4C;
	Thu, 20 Jun 2024 20:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfCh2TYY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE5B39ADD;
	Thu, 20 Jun 2024 20:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718913750; cv=none; b=j9u/MGpIlCJg9MaVVgcCjOIaNmtnZnLPKXlWlce1bCIlZBM6BxmHIC16O/oVou6YCoU+8i8TC2bU5pmVIizSKX5PL3T339LJvPUIJ33CPg+jEka1auax4gqS0e6X18RNnSaPnPd0OpABaB6U7wwsXspNH+jHkx+TuMGH3VDVayA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718913750; c=relaxed/simple;
	bh=boFmBkvFSZHjeEcIa9NGTHUPZQwae/WRy+i4UJgp3dk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d0aDkFngv5ubCdVNd+hCbziyGwjHiVT3QqUoXjSe+pn/oqcUkH13zi1adbD8pbFIqx0/zIBbzFpKgTmuEGM5mHiNe2zdVZo22MPZExcfKschPjk8KmxwL80sKa4epWrxwbWD8cs/FowaJPwYFYxSwK67GJFvaXUtx0qqLIkF8Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfCh2TYY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D35F0C2BD10;
	Thu, 20 Jun 2024 20:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718913749;
	bh=boFmBkvFSZHjeEcIa9NGTHUPZQwae/WRy+i4UJgp3dk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hfCh2TYYOgfzSWOPDG9qS+7fQE6jFoZxlAP5+w8ZMck0CTEzzSOxTDuLWewq8V7Nr
	 mzKVKnkSPg2auDvd+QmjK2qviROCStc/T/nUDoQYxPtp6MKg3XubtchTRAnvujLIW2
	 9AhS9kKPgrslsl1KC+SLGTfxpsznnPk0HRnxdipFAEFRSXHMN7kOa++W0dHEwhLA/i
	 9K+KUem5CExo3Wvfr3ZYCiy9c4GO2GT47RBrLLQ4JeuZov/Ne/5y5GflMllhoZdnkv
	 pf/qrcInpn7BWzSlFrg1PfGU/I3IoGEKH8TVokhXs00/scGA9CMy8mc4YhQarGTm/B
	 ieNAPre7dd22w==
Date: Thu, 20 Jun 2024 21:02:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <broonie@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
 <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
 <conor+dt@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
 <marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-spi@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 6/6] iio: adc: Add support for AD4000
Message-ID: <20240620210220.3c1dd94d@jic23-huawei>
In-Reply-To: <e77a00d1020baa178cb6a0201053b66cb27c39a9.1718749981.git.marcelo.schmitt@analog.com>
References: <cover.1718749981.git.marcelo.schmitt@analog.com>
	<e77a00d1020baa178cb6a0201053b66cb27c39a9.1718749981.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jun 2024 20:12:37 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> Add support for AD4000 series of low noise, low power, high speed,
> successive aproximation register (SAR) ADCs.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Hi Marcelo,

A few comments inline.

Thanks,

Jonathan

> ---
>  MAINTAINERS              |   1 +
>  drivers/iio/adc/Kconfig  |  12 +
>  drivers/iio/adc/Makefile |   1 +
>  drivers/iio/adc/ad4000.c | 715 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 729 insertions(+)
>  create mode 100644 drivers/iio/adc/ad4000.c


> diff --git a/drivers/iio/adc/ad4000.c b/drivers/iio/adc/ad4000.c
> new file mode 100644
> index 000000000000..310f81a2a1d9
> --- /dev/null
> +++ b/drivers/iio/adc/ad4000.c

> +
> +/* AD4000 Configuration Register programmable bits */
> +#define AD4000_CFG_STATUS		BIT(4) /* Status bits output */
> +#define AD4000_CFG_SPAN_COMP		BIT(3) /* Input span compression  */
> +#define AD4000_CFG_HIGHZ		BIT(2) /* High impedance mode  */
> +#define AD4000_CFG_TURBO		BIT(1) /* Turbo mode */
> +
> +#define AD4000_TQUIET1_NS		190
> +#define AD4000_TQUIET2_NS		60
> +#define AD4000_TCONV_NS			320
> +
> +#define AD4000_18BIT_MSK	GENMASK(31, 14)
> +#define AD4000_20BIT_MSK	GENMASK(31, 12)

See below. These masks made me wonder what you were doing with them given everything
they represent is provided by other paths.

> +
> +#define AD4000_DIFF_CHANNEL(_sign, _real_bits, _3wire)				\
> +{										\
> +	.type = IIO_VOLTAGE,							\
> +	.indexed = 1,								\
> +	.differential = 1,							\
> +	.channel = 0,								\
> +	.channel2 = 1,								\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |				\
> +			      BIT(IIO_CHAN_INFO_SCALE),				\
> +	.info_mask_separate_available = _3wire ? BIT(IIO_CHAN_INFO_SCALE) : 0,	\
> +	.scan_type = {								\
> +		.sign = _sign,							\
> +		.realbits = _real_bits,						\
> +		.storagebits = _real_bits > 16 ? 32 : 16,			\
> +		.shift = _real_bits > 16 ? 32 - _real_bits : 0,			\
> +		.endianness = IIO_BE,						\
> +	},									\
> +}
> +
> +#define AD4000_PSEUDO_DIFF_CHANNEL(_sign, _real_bits, _3wire)			\
> +{										\
> +	.type = IIO_VOLTAGE,							\
> +	.indexed = 1,								\
> +	.channel = 0,								\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |				\
> +			      BIT(IIO_CHAN_INFO_SCALE) |			\
> +			      BIT(IIO_CHAN_INFO_OFFSET),			\
> +	.info_mask_separate_available = _3wire ? BIT(IIO_CHAN_INFO_SCALE) : 0,	\
> +	.scan_type = {								\
> +		.sign = _sign,							\
> +		.realbits = _real_bits,						\
> +		.storagebits = _real_bits > 16 ? 32 : 16,			\
> +		.shift = _real_bits > 16 ? 32 - _real_bits : 0,			\

I wonder if it's worth another level of macro so that you can compute storage bits
in one place.  The dance for shift then just becomes _storage_bits - _read_bits.
e.g.

#define __AD4000_PSEUDO_DIFF_CHANNEL(_sign, _real_bits, _storage_bits, _3wire)			\
{										\
	.type = IIO_VOLTAGE,							\
	.indexed = 1,								\
	.channel = 0,								\
	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |				\
			      BIT(IIO_CHAN_INFO_SCALE) |			\
			      BIT(IIO_CHAN_INFO_OFFSET),			\
	.info_mask_separate_available = _3wire ? BIT(IIO_CHAN_INFO_SCALE) : 0,	\
	.scan_type = {								\
		.sign = _sign,							\
		.realbits = _real_bits,						\
		.storagebits = _storage_bits,					\
		.shift = _storage_bits - read_bits,				\
		.endianness = IIO_BE,						\
	},									\
}
#define AD4000_PSEUDO_DIFF_CHANNEL(_sign, _real_bits, _3wire) \
	__AD4000_PSEUDO_DIFF_CHANNEL((_sign), (_read_bits), (_real_bits) > 16 ? 32 : 16, (_3wire))
 
> +		.endianness = IIO_BE,						\
> +	},									\
> +}

> +struct ad4000_chip_info {
> +	const char *dev_name;
> +	struct iio_chan_spec chan_spec;
> +	struct iio_chan_spec three_w_chan_spec;
As mentioned below add

> +};

> +
> +struct ad4000_state {
> +	struct spi_device *spi;
> +	struct gpio_desc *cnv_gpio;
> +	struct spi_transfer xfers[2];
> +	struct spi_message msg;
> +	int vref_mv;
> +	enum ad4000_spi_mode spi_mode;
> +	bool span_comp;
> +	bool turbo_mode;
> +	u16 gain_milli;
> +	int scale_tbl[2][2];
> +
> +	/*
> +	 * DMA (thus cache coherency maintenance) requires the
> +	 * transfer buffers to live in their own cache lines.
> +	 */

Wrapped a bit sort. Go up to 80 chars.

> +	struct {
> +		union {
> +			__be16 sample_buf16;
> +			__be32 sample_buf32;
> +		} data;
> +		s64 timestamp __aligned(8);
> +	} scan __aligned(IIO_DMA_MINALIGN);
> +	__be16 tx_buf;
> +	__be16 rx_buf;
As below, I think these are u8 ...

> +};


> +
> +static int ad4000_write_reg(struct ad4000_state *st, uint8_t val)
> +{
> +	st->tx_buf = cpu_to_be16(AD4000_WRITE_COMMAND << BITS_PER_BYTE | val);

Use u8 tx_buf[2] and fill the two bytes separately given one is the command
and the other the data.

> +	return spi_write(st->spi, &st->tx_buf, sizeof(st->tx_buf));
> +}
> +
> +static int ad4000_read_reg(struct ad4000_state *st, unsigned int *val)
> +{
> +	struct spi_transfer t[] = {
> +		{
> +			.tx_buf = &st->tx_buf,
> +			.rx_buf = &st->rx_buf,
> +			.len = 2,
> +		},
> +	};
> +	int ret;
> +
> +	st->tx_buf = cpu_to_be16(AD4000_READ_COMMAND << BITS_PER_BYTE);

Interesting dance. Really necessary?  This looks like a classic
write address byte then read register contents sequency.
	u8 tx = AD4000_READ_COMMAND;
	u8 rx;

	ret = spi_write_then_read(spi, tx, 1, rx, 1);
	if (ret < 0)
		return ret;

	*val = rx;

	return ret;


> +	ret = spi_sync_transfer(st->spi, t, ARRAY_SIZE(t));
> +	if (ret < 0)
> +		return ret;
> +
> +	*val = be16_to_cpu(st->rx_buf);
> +
> +	return ret;
> +}
> +
> +static void ad4000_unoptimize_msg(void *msg)
> +{
> +	spi_unoptimize_message(msg);
> +}

Makes me wonder if a devm_spi_optimize_msg() would make sense... 

+static int ad4000_single_conversion(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan, int *val)
+{
+	struct ad4000_state *st = iio_priv(indio_dev);
+	u32 sample;
+	int ret;
+
+	ret = ad4000_convert_and_acquire(st);
+	if (ret < 0)
+		return ret;
+
+	if (chan->scan_type.storagebits > 16)
+		sample = be32_to_cpu(st->scan.data.sample_buf32);
+	else
+		sample = be16_to_cpu(st->scan.data.sample_buf16);
+
	I'd probably just do
	sample >>= chan->scan_type.shift;

+	switch (chan->scan_type.realbits) {
+	case 16:
+		break;
+	case 18:
+		sample = FIELD_GET(AD4000_18BIT_MSK, sample);
+		break;
+	case 20:
+		sample = FIELD_GET(AD4000_20BIT_MSK, sample);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (chan->scan_type.sign == 's')
+		*val = sign_extend32(sample, chan->scan_type.realbits - 1);
+
+	return IIO_VAL_INT;
+}
+


> +static int ad4000_read_avail(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     const int **vals, int *type, int *length,
> +			     long info)
> +{
> +	struct ad4000_state *st = iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_SCALE:
> +		*vals = (int *)st->scale_tbl;
> +		*length = 2 * 2;
I'd use a define for the length of the array (of pairs) and reuse that
here.

> +		*type = IIO_VAL_INT_PLUS_NANO;
> +		return IIO_AVAIL_LIST;
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +static int ad4000_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, int val, int val2,
> +			    long mask)
> +{
> +	struct ad4000_state *st = iio_priv(indio_dev);
> +	unsigned int reg_val;
> +	bool span_comp_en;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
If you are going to do a read modify write cycle, you should hold a local
lock to avoid races.

Relying on the implementation of iio_device_claim_direct_coped() for that
isn't a good idea as that may change in the future.


> +			ret = ad4000_read_reg(st, &reg_val);
> +			if (ret < 0)
> +				return ret;
> +
> +			span_comp_en = val2 == st->scale_tbl[1][1];
> +			reg_val &= ~AD4000_CFG_SPAN_COMP;
> +			reg_val |= FIELD_PREP(AD4000_CFG_SPAN_COMP, span_comp_en);
> +
> +			ret = ad4000_write_reg(st, reg_val);
> +			if (ret < 0)
> +				return ret;
> +
> +			st->span_comp = span_comp_en;
> +			return 0;
> +		}
> +		unreachable();
> +	default:
> +		return -EINVAL;
> +	}
> +}


> +
> +static int ad4000_probe(struct spi_device *spi)
> +{
> +	const struct ad4000_chip_info *chip;
> +	struct iio_dev *indio_dev;
> +	struct ad4000_state *st;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	chip = spi_get_device_match_data(spi);
> +	if (!chip)
> +		return -EINVAL;
> +
> +	st = iio_priv(indio_dev);
> +	st->spi = spi;
> +
> +	ret = devm_regulator_get_enable(&spi->dev, "vdd");

A lot of spi->dev, I'd add a
struct device *dev = spi->dev; and use that throughout.

> +	if (ret)
> +		return dev_err_probe(&spi->dev, ret, "Failed to enable VDD supply\n");
> +
>
...

> +	indio_dev->name = chip->dev_name;
> +	indio_dev->num_channels = 1;
> +
> +	/* Hardware gain only applies to ADAQ devices */

Probably best not to rely on the DT binding sanity. So I'd add a flag for
support of this to your chip info structures and only try reading the
property if you have an adaq.  With that in place you can probably
drop the comment as well as it will be easy to tell by seeing who
as set st->has_hardware_gain (name up to you)
> +	st->gain_milli = 1000;
> +	if (device_property_present(&spi->dev, "adi,gain-milli")) {
> +		ret = device_property_read_u16(&spi->dev, "adi,gain-milli",
> +					       &st->gain_milli);
> +		if (ret)
> +			return dev_err_probe(&spi->dev, ret,
> +					     "Failed to read gain property\n");
> +	}
We are often lazy on parameters with a clear default and just do
	device_property_read_*()
without checking the return value.  That will only overwrite the output
parameter it it succeeds. Otherwise we get the default you set before
the call.

If you prefer the more protective form I don't mind that much.

> +
> +	ad4000_fill_scale_tbl(st, indio_dev->channels);
> +
> +	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
> +					      &iio_pollfunc_store_time,
> +					      &ad4000_trigger_handler, NULL);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(&spi->dev, indio_dev);
> +}

