Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A14E19C49B
	for <lists+linux-iio@lfdr.de>; Sun, 25 Aug 2019 17:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbfHYPOq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 25 Aug 2019 11:14:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:49014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728375AbfHYPOq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 25 Aug 2019 11:14:46 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63A01206B7;
        Sun, 25 Aug 2019 15:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566746084;
        bh=qjwEBraheWHlj8Os3PEoVZsF51PQd7XqwJ5bz7YciA0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=USXLXaildTceq/36hns7i+XTIHoqpLw+yoD2FqQSEEVVNdXUh9B2ZTMWoZI1s9aXF
         HrGpRmDmgqJOg+UJCE+n35MqpUHFDfpikuakDaASXwWehgs2TECX2KCjra2Gz4wf+c
         h8fkrzy5eGUM36ZkBMUh70r1S7cEimipgiN6V1OA=
Date:   Sun, 25 Aug 2019 16:14:38 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <paulmck@linux.ibm.com>,
        <mchehab+samsung@kernel.org>, <linus.walleij@linaro.org>,
        <nicolas.ferre@microchip.com>, <biabeniamin@outlook.com>,
        Stefan Popa <stefan.popa@analog.com>
Subject: Re: [PATCH v3 1/4] iio: adc: ad7606: Add support for AD7606B ADC
Message-ID: <20190825161438.0b2b6177@archlinux>
In-Reply-To: <20190821141656.4815-1-beniamin.bia@analog.com>
References: <20190821141656.4815-1-beniamin.bia@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 21 Aug 2019 17:16:53 +0300
Beniamin Bia <beniamin.bia@analog.com> wrote:

> From: Stefan Popa <stefan.popa@analog.com>
>=20
> The AD7606B is a 16-bit ADC that supports simultaneous sampling of 8
> channels. It is pin compatible to AD7606, but adds extra modes by
> writing to the register map.
>=20
> The AD7606B can be configured to work in software mode by setting all
> oversampling pins to high. This mode is selected by default.
> The oversampling ratio is configured from the OS_MODE register (address
> 0x08) with the addition of OS=3D128 and OS=3D256 that were not available =
in
> hardware mode.
>=20
> The device is configured to output data on a single spi channel, but this
> configuration must be done right after restart. That is why the delay was
> removed for devices which doesn't require it.
>=20
> Moreover, in software mode, the range gpio has no longer its function.
> Instead, the scale can be configured individually for each channel from
> the RANGE_CH registers (address 0x03 to 0x06). Besides the already
> supported =C2=B110 V and =C2=B15 V ranges, software mode can also accommo=
date the
> =C2=B12.5 V range.
>=20
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> Co-developed-by: Beniamin Bia <beniamin.bia@analog.com>
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan


> ---
> Changes in v3:
> -comments reworked
> -isWriteOp renamed to is_write_op
>=20
>  drivers/iio/adc/ad7606.c     |  13 ++++-
>  drivers/iio/adc/ad7606.h     |   4 ++
>  drivers/iio/adc/ad7606_spi.c | 109 ++++++++++++++++++++++++++++++++++-
>  3 files changed, 123 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index ed2d08437e5d..f5ba94c03a8d 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -410,12 +410,19 @@ static const struct ad7606_chip_info ad7606_chip_in=
fo_tbl[] =3D {
>  		.oversampling_avail =3D ad7606_oversampling_avail,
>  		.oversampling_num =3D ARRAY_SIZE(ad7606_oversampling_avail),
>  	},
> +	[ID_AD7606B] =3D {
> +		.channels =3D ad7606_channels,
> +		.num_channels =3D 9,
> +		.oversampling_avail =3D ad7606_oversampling_avail,
> +		.oversampling_num =3D ARRAY_SIZE(ad7606_oversampling_avail),
> +	},
>  	[ID_AD7616] =3D {
>  		.channels =3D ad7616_channels,
>  		.num_channels =3D 17,
>  		.oversampling_avail =3D ad7616_oversampling_avail,
>  		.oversampling_num =3D ARRAY_SIZE(ad7616_oversampling_avail),
>  		.os_req_reset =3D true,
> +		.init_delay_ms =3D 15,
>  	},
>  };
> =20
> @@ -631,8 +638,10 @@ int ad7606_probe(struct device *dev, int irq, void _=
_iomem *base_address,
>  		dev_warn(st->dev, "failed to RESET: no RESET GPIO specified\n");
> =20
>  	/* AD7616 requires al least 15ms to reconfigure after a reset */
> -	if (msleep_interruptible(15))
> -		return -ERESTARTSYS;
> +	if (st->chip_info->init_delay_ms) {
> +		if (msleep_interruptible(st->chip_info->init_delay_ms))
> +			return -ERESTARTSYS;
> +	}
> =20
>  	st->write_scale =3D ad7606_write_scale_hw;
>  	st->write_os =3D ad7606_write_os_hw;
> diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
> index eeaaa8b905db..9350ef1f63b5 100644
> --- a/drivers/iio/adc/ad7606.h
> +++ b/drivers/iio/adc/ad7606.h
> @@ -46,6 +46,8 @@
>   *			oversampling ratios.
>   * @oversampling_num	number of elements stored in oversampling_avail arr=
ay
>   * @os_req_reset	some devices require a reset to update oversampling
> + * @init_delay_ms	required delay in miliseconds for initialization
> + *			after a restart
>   */
>  struct ad7606_chip_info {
>  	const struct iio_chan_spec	*channels;
> @@ -53,6 +55,7 @@ struct ad7606_chip_info {
>  	const unsigned int		*oversampling_avail;
>  	unsigned int			oversampling_num;
>  	bool				os_req_reset;
> +	unsigned long			init_delay_ms;
>  };
> =20
>  /**
> @@ -155,6 +158,7 @@ enum ad7606_supported_device_ids {
>  	ID_AD7606_8,
>  	ID_AD7606_6,
>  	ID_AD7606_4,
> +	ID_AD7606B,
>  	ID_AD7616,
>  };
> =20
> diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
> index 98ed52b74507..29945ad07dca 100644
> --- a/drivers/iio/adc/ad7606_spi.c
> +++ b/drivers/iio/adc/ad7606_spi.c
> @@ -28,9 +28,23 @@
>   * an offset of 2 for register address.
>   */
>  #define AD7616_RANGE_CH_ADDR(ch)	((ch) >> 2)
> -/* The range of the channel is stored on 2 bits*/
> +/* The range of the channel is stored in 2 bits */
>  #define AD7616_RANGE_CH_MSK(ch)		(0b11 << (((ch) & 0b11) * 2))
>  #define AD7616_RANGE_CH_MODE(ch, mode)	((mode) << ((((ch) & 0b11)) * 2))
> +
> +#define AD7606_CONFIGURATION_REGISTER	0x02
> +#define AD7606_SINGLE_DOUT		0x00
> +
> +/*
> + * Range for AD7606B channels are stored in registers starting with addr=
ess 0x3.
> + * Each register stores range for 2 channels(4 bits per channel).
> + */
> +#define AD7606_RANGE_CH_MSK(ch)		(GENMASK(3, 0) << (4 * ((ch) & 0x1)))
> +#define AD7606_RANGE_CH_MODE(ch, mode)	\
> +	((GENMASK(3, 0) & mode) << (4 * ((ch) & 0x1)))
> +#define AD7606_RANGE_CH_ADDR(ch)	(0x03 + ((ch) >> 1))
> +#define AD7606_OS_MODE			0x08
> +
>  static const struct iio_chan_spec ad7616_sw_channels[] =3D {
>  	IIO_CHAN_SOFT_TIMESTAMP(16),
>  	AD7616_CHANNEL(0),
> @@ -51,6 +65,22 @@ static const struct iio_chan_spec ad7616_sw_channels[]=
 =3D {
>  	AD7616_CHANNEL(15),
>  };
> =20
> +static const struct iio_chan_spec ad7606b_sw_channels[] =3D {
> +	IIO_CHAN_SOFT_TIMESTAMP(8),
> +	AD7616_CHANNEL(0),
> +	AD7616_CHANNEL(1),
> +	AD7616_CHANNEL(2),
> +	AD7616_CHANNEL(3),
> +	AD7616_CHANNEL(4),
> +	AD7616_CHANNEL(5),
> +	AD7616_CHANNEL(6),
> +	AD7616_CHANNEL(7),
> +};
> +
> +static const unsigned int ad7606B_oversampling_avail[9] =3D {
> +	1, 2, 4, 8, 16, 32, 64, 128, 256
> +};
> +
>  static u16 ad7616_spi_rd_wr_cmd(int addr, char isWriteOp)
>  {
>  	/*
> @@ -60,6 +90,16 @@ static u16 ad7616_spi_rd_wr_cmd(int addr, char isWrite=
Op)
>  	return ((addr & 0x7F) << 1) | ((isWriteOp & 0x1) << 7);
>  }
> =20
> +static u16 ad7606B_spi_rd_wr_cmd(int addr, char is_write_op)
> +{
> +	/*
> +	 * The address of register consists of one bit which
> +	 * specifies a read command placed in bit 6, followed by
> +	 * 6 bits of address.
> +	 */
> +	return (addr & 0x3F) | (((~is_write_op) & 0x1) << 6);
> +}
> +
>  static int ad7606_spi_read_block(struct device *dev,
>  				 int count, void *buf)
>  {
> @@ -169,6 +209,23 @@ static int ad7616_write_os_sw(struct iio_dev *indio_=
dev, int val)
>  				     AD7616_OS_MASK, val << 2);
>  }
> =20
> +static int ad7606_write_scale_sw(struct iio_dev *indio_dev, int ch, int =
val)
> +{
> +	struct ad7606_state *st =3D iio_priv(indio_dev);
> +
> +	return ad7606_spi_write_mask(st,
> +				     AD7606_RANGE_CH_ADDR(ch),
> +				     AD7606_RANGE_CH_MSK(ch),
> +				     AD7606_RANGE_CH_MODE(ch, val));
> +}
> +
> +static int ad7606_write_os_sw(struct iio_dev *indio_dev, int val)
> +{
> +	struct ad7606_state *st =3D iio_priv(indio_dev);
> +
> +	return ad7606_spi_reg_write(st, AD7606_OS_MODE, val);
> +}
> +
>  static int ad7616_sw_mode_config(struct iio_dev *indio_dev)
>  {
>  	struct ad7606_state *st =3D iio_priv(indio_dev);
> @@ -189,6 +246,42 @@ static int ad7616_sw_mode_config(struct iio_dev *ind=
io_dev)
>  			      AD7616_BURST_MODE | AD7616_SEQEN_MODE);
>  }
> =20
> +static int ad7606B_sw_mode_config(struct iio_dev *indio_dev)
> +{
> +	struct ad7606_state *st =3D iio_priv(indio_dev);
> +	unsigned long os[3] =3D {1};
> +
> +	/*
> +	 * Software mode is enabled when all three oversampling
> +	 * pins are set to high. If oversampling gpios are defined
> +	 * in the device tree, then they need to be set to high,
> +	 * otherwise, they must be hardwired to VDD
> +	 */
> +	if (st->gpio_os) {
> +		gpiod_set_array_value(ARRAY_SIZE(os),
> +				      st->gpio_os->desc, st->gpio_os->info, os);
> +	}
> +	/* OS of 128 and 256 are available only in software mode */
> +	st->oversampling_avail =3D ad7606B_oversampling_avail;
> +	st->num_os_ratios =3D ARRAY_SIZE(ad7606B_oversampling_avail);
> +
> +	st->write_scale =3D ad7606_write_scale_sw;
> +	st->write_os =3D &ad7606_write_os_sw;
> +
> +	/* Configure device spi to output on a single channel */
> +	st->bops->reg_write(st,
> +			    AD7606_CONFIGURATION_REGISTER,
> +			    AD7606_SINGLE_DOUT);
> +
> +	/*
> +	 * Scale can be configured individually for each channel
> +	 * in software mode.
> +	 */
> +	indio_dev->channels =3D ad7606b_sw_channels;
> +
> +	return 0;
> +}
> +
>  static const struct ad7606_bus_ops ad7606_spi_bops =3D {
>  	.read_block =3D ad7606_spi_read_block,
>  };
> @@ -202,6 +295,15 @@ static const struct ad7606_bus_ops ad7616_spi_bops =
=3D {
>  	.sw_mode_config =3D ad7616_sw_mode_config,
>  };
> =20
> +static const struct ad7606_bus_ops ad7606B_spi_bops =3D {
> +	.read_block =3D ad7606_spi_read_block,
> +	.reg_read =3D ad7606_spi_reg_read,
> +	.reg_write =3D ad7606_spi_reg_write,
> +	.write_mask =3D ad7606_spi_write_mask,
> +	.rd_wr_cmd =3D ad7606B_spi_rd_wr_cmd,
> +	.sw_mode_config =3D ad7606B_sw_mode_config,
> +};
> +
>  static int ad7606_spi_probe(struct spi_device *spi)
>  {
>  	const struct spi_device_id *id =3D spi_get_device_id(spi);
> @@ -211,6 +313,9 @@ static int ad7606_spi_probe(struct spi_device *spi)
>  	case ID_AD7616:
>  		bops =3D &ad7616_spi_bops;
>  		break;
> +	case ID_AD7606B:
> +		bops =3D &ad7606B_spi_bops;
> +		break;
>  	default:
>  		bops =3D &ad7606_spi_bops;
>  		break;
> @@ -226,6 +331,7 @@ static const struct spi_device_id ad7606_id_table[] =
=3D {
>  	{ "ad7606-4", ID_AD7606_4 },
>  	{ "ad7606-6", ID_AD7606_6 },
>  	{ "ad7606-8", ID_AD7606_8 },
> +	{ "ad7606b",  ID_AD7606B },
>  	{ "ad7616",   ID_AD7616 },
>  	{}
>  };
> @@ -236,6 +342,7 @@ static const struct of_device_id ad7606_of_match[] =
=3D {
>  	{ .compatible =3D "adi,ad7606-4" },
>  	{ .compatible =3D "adi,ad7606-6" },
>  	{ .compatible =3D "adi,ad7606-8" },
> +	{ .compatible =3D "adi,ad7606b" },
>  	{ .compatible =3D "adi,ad7616" },
>  	{ },
>  };

