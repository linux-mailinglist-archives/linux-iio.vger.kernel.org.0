Return-Path: <linux-iio+bounces-17351-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9905DA75AC2
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 18:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A193167C9D
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 16:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46AD1CEADB;
	Sun, 30 Mar 2025 16:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gsuFzpB9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9B82F24;
	Sun, 30 Mar 2025 16:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743350485; cv=none; b=bTNtIt4hH+9VM0Li0UZ5oLRUmnGDWzYqq8iaxVvMg0xi9adMutn6H+3AdyotfWAmp7J3oZo1J1vGUGtpu1XJQqIXC127KTD4jpip0Gr05KnnCW72hVZEIqRUUn8bE0yva/8IjvSzIwGsdVQAIYrcGOVbe0hv65WnjhZYP8k26V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743350485; c=relaxed/simple;
	bh=PYlZ9mGpPSmaJoD5evON9fcMqA/5+b+72IIFzv4frEI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HWietQZ0cvNDecFQBjxAfXLo8okpIgoqr3lPa1rJsH1thNNP5dnqRVo+kKfPC6/yZVgoFGE7SF8xwQy0VRxTvVPBmis8y64WKhv8+kTdyqTfSm7/7r1RiLTWdEyMK40jqBe8EcPTzQ6ft6W2zM045xwjKupLmmsXSK5O9sr/rAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gsuFzpB9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94F3CC4CEDD;
	Sun, 30 Mar 2025 16:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743350485;
	bh=PYlZ9mGpPSmaJoD5evON9fcMqA/5+b+72IIFzv4frEI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gsuFzpB9M0MhpmtUBMSBDlm960UpunzQS+HSVlg1Z9Jpyh4UVu+0mqysUhBEPRza2
	 zyI/FqVArr4hXS68Ldd8ujk3Jqwx6xA3R3Njj/qAuwVdYZKGAMCGO00jIj8jjBevyj
	 omxX8LJwACeSTyExnVNHP/qEBWqR4jFvGNAgd/YDW466k/AyD0v6dcDkFD8hI8gp4P
	 +XJfqYbEl+uln85aHGisiPwLuFwF4Y/ypr2qpS5oxatth2vMUsmKq/GW79nF9PKQzr
	 Hv4dxHxC68/GiS3m5t9gaC3CJ1TDMQJDoBT9QRPtxkMN7vfFQOolcQkqKOdQESn8Zb
	 Myj4wFa4Wt9yQ==
Date: Sun, 30 Mar 2025 17:01:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, "Rob Herring" <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, Nuno
 Sa <nuno.sa@analog.com>, Olivier Moysan <olivier.moysan@foss.st.com>, David
 Lechner <dlechner@baylibre.com>, "Javier Carrasco"
 <javier.carrasco.cruz@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Guillaume Stols <gstols@baylibre.com>,
 Trevor Gamblin <tgamblin@baylibre.com>, Dumitru Ceclan
 <mitrutzceclan@gmail.com>, Matteo Martelli <matteomartelli3@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>, Michael Walle
 <michael@walle.cc>, Herve Codina <herve.codina@bootlin.com>, "Thomas
 Bonnefille" <thomas.bonnefille@bootlin.com>, Dragos Bogdan
 <dragos.bogdan@analog.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] iio: adc: ad7405: add ad7405 driver
Message-ID: <20250330170111.3469040f@jic23-huawei>
In-Reply-To: <20250324090813.2775011-6-pop.ioan-daniel@analog.com>
References: <20250324090813.2775011-1-pop.ioan-daniel@analog.com>
	<20250324090813.2775011-6-pop.ioan-daniel@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 24 Mar 2025 11:08:00 +0200
Pop Ioan Daniel <pop.ioan-daniel@analog.com> wrote:

> Add support for the AD7405/ADUM770x, a high performance isolated ADC,
> 1-channel, 16-bit with a second-order =CE=A3-=CE=94 modulator that conver=
ts an
> analog input signal into a high speed, single-bit data stream.
>=20
> Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
Hi Pop,

I'll probably overlap with existing reviews but maybe there will
be other stuff.

Dragos is listed as the maintainer. If that's accurate should have a
Co-developed by and sign off.

> ---
>  drivers/iio/adc/Kconfig  |  10 ++
>  drivers/iio/adc/Makefile |   1 +
>  drivers/iio/adc/ad7405.c | 301 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 312 insertions(+)
>  create mode 100644 drivers/iio/adc/ad7405.c
>=20
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index f64b5faeb257..321a1ee7304f 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -203,6 +203,16 @@ config AD7380
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called ad7380.
> =20
> +config AD7405
> +	tristate "Analog Device AD7405 ADC Driver"
> +	select IIO_BACKEND
> +	help
> +	  Say yes here to build support for Analog Devices AD7405, ADUM7701,
> +	  ADUM7702, ADUM7703 analog to digital converters (ADC).

Maybe mention the bus?

> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called ad7405.
> +

> diff --git a/drivers/iio/adc/ad7405.c b/drivers/iio/adc/ad7405.c
> new file mode 100644
> index 000000000000..40fe072369d5
> --- /dev/null
> +++ b/drivers/iio/adc/ad7405.c
> @@ -0,0 +1,301 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Analog Devices AD7405 driver
> + *
> + * Copyright 2025 Analog Devices Inc.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/log2.h>
> +#include <linux/clk.h>
> +#include <linux/platform_device.h>
> +#include <linux/of.h>

Use property.h if you need to access firmware properties.
For the table,  use
mod_devicetable.h not of.h.


> +#include <linux/iio/iio.h>
> +#include <linux/iio/backend.h>
> +#include <linux/util_macros.h>
> +#include <linux/regulator/consumer.h>
> +
> +#define AD7405_DEFAULT_DEC_RATE 1024
> +
> +const unsigned int ad7405_dec_rates[] =3D {
> +		4096, 2048, 1024, 512, 256, 128, 64, 32,

1 tab only is enough here.

> +};
> +
> +struct ad7405_chip_info {
> +	const char *name;
> +	unsigned int num_channels;
> +	unsigned int max_rate;
> +	unsigned int min_rate;
> +	struct iio_chan_spec channel[3];
Why 3?=20

> +	const unsigned long *available_mask;
As below - this makes little sense. Drop it.

> +};
> +
> +struct ad7405_state {
> +	struct iio_backend *back;
> +	struct clk *axi_clk_gen;
> +	/* lock to protect multiple accesses to the device registers */

Why  I assume this is about read modify update sequences?=20
If so say something more about that.  For now I can't see any
happening. All we have is an update of the backend sampling frequency.

> +	struct mutex lock;
> +	struct regmap *regmap;
Note used. Drop it.=20
> +	struct iio_info iio_info;
As noted below, not obvious what this is for.

> +	const struct ad7405_chip_info *info;
> +	unsigned int sample_frequency_tbl[ARRAY_SIZE(ad7405_dec_rates)];
> +	unsigned int sample_frequency;
> +	unsigned int ref_frequency;
> +};
> +
> +static void ad7405_fill_samp_freq_table(struct ad7405_state *st)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(ad7405_dec_rates); i++)
> +		st->sample_frequency_tbl[i] =3D DIV_ROUND_CLOSEST_ULL(st->ref_frequenc=
y, ad7405_dec_rates[i]);
Wrap this line.
		st->sample_frequency_tbl[i] =3D
			DIV_ROUND_CLOSEST_ULL(st->ref_frequency, ad7405_dec_rates[i]);

> +}
> +
> +static int ad7405_set_sampling_rate(struct iio_dev *indio_dev,
> +				    const struct iio_chan_spec *chan,
> +				    unsigned int samp_rate)
> +{
> +	struct ad7405_state *st =3D iio_priv(indio_dev);
> +	unsigned int dec_rate, idx;
> +	int ret;
> +
> +	dec_rate =3D DIV_ROUND_CLOSEST_ULL(st->ref_frequency, samp_rate);
> +
> +	idx =3D find_closest_descending(dec_rate, ad7405_dec_rates,
> +				      ARRAY_SIZE(ad7405_dec_rates));
> +
> +	    dec_rate =3D ad7405_dec_rates[idx];

Odd indent.

> +
> +	ret =3D iio_backend_set_dec_rate(st->back, dec_rate);
> +	if (ret)
> +		return ret;
> +
> +	st->sample_frequency =3D DIV_ROUND_CLOSEST_ULL(st->ref_frequency, dec_r=
ate);
> +
> +	return 0;
> +}
> +
> +static int ad7405_update_scan_mode(struct iio_dev *indio_dev,
> +				   const unsigned long *scan_mask)
> +{
> +	struct ad7405_state *st =3D iio_priv(indio_dev);
> +	unsigned int c;
> +	int ret;
> +

This is odd given you only have one channel.
Either do the enable in probe() or in postenable callback and
disable in predisable callback.


> +	for (c =3D 0; c < indio_dev->num_channels; c++) {
> +		if (test_bit(c, scan_mask))
> +			ret =3D iio_backend_chan_enable(st->back, c);
> +		else
> +			ret =3D iio_backend_chan_disable(st->back, c);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ad7405_read_raw(struct iio_dev *indio_dev,
> +			   const struct iio_chan_spec *chan, int *val,
> +			   int *val2, long info)
> +{
> +	struct ad7405_state *st =3D iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +			*val =3D st->sample_frequency;
> +
> +			return IIO_VAL_INT;
> +	default:
> +			return -EINVAL;
> +	}
> +}
> +
> +static int ad7405_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, int val,
> +			    int val2, long info)
> +{
> +	switch (info) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +
> +			return ad7405_set_sampling_rate(indio_dev, chan, val);
> +
> +	default:
> +			return -EINVAL;
> +	}
> +}
> +
> +static int ad7405_read_avail(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +				 const int **vals, int *type, int *length,
> +				 long info)
> +{
> +	struct ad7405_state *st =3D iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +			*vals =3D st->sample_frequency_tbl;
> +			*length =3D ARRAY_SIZE(st->sample_frequency_tbl);
> +			*type =3D IIO_VAL_INT;
> +			return IIO_AVAIL_LIST;
> +	default:
> +			return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info ad7405_iio_info =3D {
> +	.read_raw =3D &ad7405_read_raw,
> +	.write_raw =3D &ad7405_write_raw,
> +	.read_avail =3D &ad7405_read_avail,
> +	.update_scan_mode =3D ad7405_update_scan_mode,
> +};
> +
> +#define AD7405_IIO_CHANNEL(_chan, _bits, _sign)		  \
> +	{ .type =3D IIO_VOLTAGE,					  \
	{
		.type =3D IIO_VOLTAGE,					\
etc.

That is keep to normal formatting.  If you go over 80 chars for readability
reasons that is fine.
> +	  .info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SAMP_FREQ), \
> +	  .info_mask_shared_by_all_available =3D BIT(IIO_CHAN_INFO_SAMP_FREQ), \
> +	  .indexed =3D 1,						 \
> +	  .channel =3D _chan,					 \

For now channel always 0 so just set to 0.
Bring in the parameter only when you need it.

> +	  .scan_type =3D {				\
> +		.sign =3D _sign,				\
> +		.realbits =3D _bits,			\
> +		.storagebits =3D 16,			\
> +		.shift =3D 0,				\

Never any need to set shift to 0. It's the obvious default and the c spec
ensures it is set to 0 if you leave it unspecified.

> +	  },						\
> +	}
> +
> +static const unsigned long ad7405_channel_masks[] =3D {
> +		BIT(0),

If there is only one channel this serves no useful purpose.
Drop it.

> +		0,
> +};
> +
> +static const struct ad7405_chip_info ad7405_chip_info =3D {
> +		.name =3D "AD7405",
> +		.max_rate =3D 625000UL,
> +		.min_rate =3D 4883UL,
> +		.num_channels =3D 1,
> +		.channel =3D {
> +			AD7405_IIO_CHANNEL(0, 16, 'u'),
> +		},
> +		.available_mask =3D ad7405_channel_masks,
> +};
> +
> +static const struct ad7405_chip_info adum7701_chip_info =3D {
> +		.name =3D "ADUM7701",
> +		.max_rate =3D 656250UL,
> +		.min_rate =3D 5127UL,
> +		.num_channels =3D 1,
> +		.channel =3D {
> +			AD7405_IIO_CHANNEL(0, 16, 'u'),
> +		},
> +		.available_mask =3D ad7405_channel_masks,
> +};

> +static int ad7405_probe(struct platform_device *pdev)
> +{
> +	const struct ad7405_chip_info *chip_info;
> +	struct device *dev =3D &pdev->dev;
> +	struct iio_dev *indio_dev;
> +	struct ad7405_state *st;
> +	int ret;
> +
> +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st =3D iio_priv(indio_dev);
> +
> +	ret =3D devm_mutex_init(dev, &st->lock);
> +	if (ret)
> +		return ret;
> +
> +	chip_info =3D &ad7405_chip_info;
> +
> +	platform_set_drvdata(pdev, indio_dev);
Is this used anywhere? If not drop it.

> +
> +	st->axi_clk_gen =3D devm_clk_get(dev, NULL);
> +	if (IS_ERR(st->axi_clk_gen))
> +		return PTR_ERR(st->axi_clk_gen);
> +
> +	ret =3D clk_prepare_enable(st->axi_clk_gen);

why not dev_clk_get_enabled()?

> +	if (ret)
> +		return ret;
> +
> +	ret =3D devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(ad7405_power_sup=
plies),
> +					     ad7405_power_supplies);
> +
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to get and enable supplies");
> +
> +	st->ref_frequency =3D clk_get_rate(st->axi_clk_gen);
> +
> +	ad7405_fill_samp_freq_table(st);
> +
> +	indio_dev->dev.parent =3D dev;

Set by the IIO core for you, so no need to do it explicitly unless you want
to modify it for a non obvious parent.


> +	indio_dev->name =3D pdev->dev.of_node->name;

First of all, don't use of_node directly. Always use the property.h accesso=
rs.
Secondly don't get the name from there - just hard code it so we can immedi=
ate
see what it is here. Given you are supporting multiple parts, and already
have it in the chip specific structure, just get it from there.


> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +
> +	indio_dev->channels =3D chip_info->channel;
> +	indio_dev->num_channels =3D chip_info->num_channels;
> +
> +	st->iio_info =3D ad7405_iio_info;
Why is the extra copy needed? =20
> +	indio_dev->info =3D &st->iio_info;
> +
> +	st->back =3D devm_iio_backend_get(dev, NULL);
> +	if (IS_ERR(st->back))
> +		return dev_err_probe(dev, PTR_ERR(st->back),
> +				     "failed to get IIO backend");
> +
> +	ret =3D devm_iio_backend_request_buffer(dev, st->back, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D devm_iio_backend_enable(dev, st->back);
> +	if (ret)
> +		return ret;
> +
> +	/* Reset all HDL Cores */

Needs more info.  Why is that needed for this specific part but not
for others?  I'd also expect the final one to be the devm case
if this sequence is needed.


> +	iio_backend_disable(st->back);
> +	iio_backend_enable(st->back);
> +
> +	ret =3D ad7405_set_sampling_rate(indio_dev, &indio_dev->channels[0],
> +				       chip_info->max_rate);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	return 0;

	return devm_iio...

> +}
> +
> +/* Match table for of_platform binding */
> +static const struct of_device_id ad7405_of_match[] =3D {
> +	{ .compatible =3D "adi,ad7405", .data =3D &ad7405_chip_info, },
> +	{ .compatible =3D "adi,adum7701", .data =3D &adum7701_chip_info, },
> +	{ .compatible =3D "adi,adum7702", .data =3D &adum7701_chip_info, },
> +	{ .compatible =3D "adi,adum7703", .data =3D &adum7701_chip_info, },
> +	{ /* end of list */ },
> +};

Similar to below. Common to not have a blank line here given
close association of macro and table.

> +
> +MODULE_DEVICE_TABLE(of, ad7405_of_match);
> +
> +static struct platform_driver ad7405_driver =3D {
> +	.driver =3D {
> +		.name =3D "ad7405",
> +		.owner =3D THIS_MODULE,
> +		.of_match_table =3D ad7405_of_match,
> +	},
> +	.probe =3D ad7405_probe,
> +};
> +
Common practice to not have a blank line here as the association
between the following macro and the platform_driver structure is
very close.
> +module_platform_driver(ad7405_driver);
> +
> +MODULE_AUTHOR("Dragos Bogdan <dragos.bogdan@analog.com>");

As above. If this is correct then from + sign-offs above may be inapproprit=
e.

> +MODULE_DESCRIPTION("Analog Devices AD7405 driver");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS("IIO_BACKEND");


