Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF64539D45
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2019 13:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfFHLaq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Jun 2019 07:30:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:54770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726918AbfFHLaq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 8 Jun 2019 07:30:46 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A98E62146E;
        Sat,  8 Jun 2019 11:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559993445;
        bh=vfmNW9S5XxdpSTnkv5MWwRBIv5D6gprlvQJQ9jj9iPw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iPVEtYuaD+urS3FqXEFkTfgggS0jgD/ujLvTZ1pv9PZsnTAwpHTJ4ESTsAD5LbcnO
         zYLvHHsR3VXrjDTXUavDuM/iADn6nD1L3lyf4++Twuxn/0PkiiEY2aLA5mLaB7v/B8
         uZpYFqjjjHnIsXHl2Hcb5yRP3MJ72YjHXC98ouSk=
Date:   Sat, 8 Jun 2019 12:30:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <biabeniamin@outlook.com>
Subject: Re: [PATCH v2 3/4] iio: adc: ad7606: Add support for software mode
 for ad7616
Message-ID: <20190608123039.31e691bd@archlinux>
In-Reply-To: <20190527125650.2405-3-beniamin.bia@analog.com>
References: <20190527125650.2405-1-beniamin.bia@analog.com>
        <20190527125650.2405-3-beniamin.bia@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 27 May 2019 15:56:49 +0300
Beniamin Bia <beniamin.bia@analog.com> wrote:

> Support for ad7616 running in software was added. In order
> to activate the software mode, HW_RNGSEL pins must be pulled low.
> Oversampling and input ranges are now configured in corresponding
> registers. Ad7616 has multiple scale options when it is configured
> in software mode.
> Also, in order to support multiple devices in software mode, the spi
> the calculation of registers address must be generic. Because
> the length of address and bit which specifies the read/write operation is
> different for every device, calculation of address was made generic.
>=20
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
Applied to the togreg branch of iio.git and pushed out as testing
to see if the autobuilders can find anything we have missed.

Thanks,

Jonathan

> ---
> Changes in v2:
> -squashed with the patch which introduces the reg access function.
> -some casting warnings were fixed.
>=20
>  drivers/iio/adc/ad7606.c | 171 +++++++++++++++++++++++++++++++++++++--
>  drivers/iio/adc/ad7606.h |   4 +
>  2 files changed, 167 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index aba0fd123a51..8e09ad4bb72e 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -25,8 +25,24 @@
>  #include <linux/iio/triggered_buffer.h>
>  #include <linux/iio/trigger_consumer.h>
> =20
> +#include <linux/spi/spi.h>
> +
>  #include "ad7606.h"
> =20
> +#define AD7606_RANGE_CH_ADDR(ch)	(0x03 + ((ch) >> 1))
> +#define AD7606_OS_MODE			0x08
> +
> +#define AD7616_CONFIGURATION_REGISTER	0x02
> +#define AD7616_OS_MASK			GENMASK(4,  2)
> +#define AD7616_BURST_MODE		BIT(6)
> +#define AD7616_SEQEN_MODE		BIT(5)
> +#define AD7616_RANGE_CH_ADDR_OFF	0x04
> +#define AD7616_RANGE_CH_ADDR(ch)	((((ch) & 0x1) << 1) + ((ch) >> 3))
> +#define AD7616_RANGE_CH_MSK(ch)		(GENMASK(1, 0) << ((ch) & 0x6))
> +#define AD7616_RANGE_CH_MODE(ch, mode)	((mode) << (ch & GENMASK(2, 1)))
> +
> +static int ad7616_sw_mode_config(struct iio_dev *indio_dev);
> +
>  /*
>   * Scales are computed as 5000/32768 and 10000/32768 respectively,
>   * so that when applied to the raw values they provide mV values
> @@ -35,6 +51,11 @@ static const unsigned int ad7606_scale_avail[2] =3D {
>  	152588, 305176
>  };
> =20
> +
> +static const unsigned int ad7616_sw_scale_avail[3] =3D {
> +	76293, 152588, 305176
> +};
> +
>  static const unsigned int ad7606_oversampling_avail[7] =3D {
>  	1, 2, 4, 8, 16, 32, 64,
>  };
> @@ -43,6 +64,11 @@ static const unsigned int ad7616_oversampling_avail[8]=
 =3D {
>  	1, 2, 4, 8, 16, 32, 64, 128,
>  };
> =20
> +static u16 ad7616_spi_rd_wr_cmd(int addr, char isWriteOp)
> +{
> +	return ((addr & 0x7F) << 1) | ((isWriteOp & 0x1) << 7);
> +}
> +
>  static int ad7606_reset(struct ad7606_state *st)
>  {
>  	if (st->gpio_reset) {
> @@ -55,6 +81,59 @@ static int ad7606_reset(struct ad7606_state *st)
>  	return -ENODEV;
>  }
> =20
> +static int ad7606_spi_reg_read(struct ad7606_state *st, unsigned int add=
r)
> +{
> +	struct spi_device *spi =3D to_spi_device(st->dev);
> +	struct spi_transfer t[] =3D {
> +		{
> +			.tx_buf =3D &st->d16[0],
> +			.len =3D 2,
> +			.cs_change =3D 0,
> +		}, {
> +			.rx_buf =3D &st->d16[1],
> +			.len =3D 2,
> +		},
> +	};
> +	int ret;
> +
> +	st->d16[0] =3D cpu_to_be16(st->chip_info->spi_rd_wr_cmd(addr, 0) << 8);
> +
> +	ret =3D spi_sync_transfer(spi, t, ARRAY_SIZE(t));
> +	if (ret < 0)
> +		return ret;
> +
> +	return be16_to_cpu(st->d16[1]);
> +}
> +
> +static int ad7606_spi_reg_write(struct ad7606_state *st,
> +				unsigned int addr,
> +				unsigned int val)
> +{
> +	struct spi_device *spi =3D to_spi_device(st->dev);
> +
> +	st->d16[0] =3D cpu_to_be16((st->chip_info->spi_rd_wr_cmd(addr, 1) << 8)=
 |
> +				  (val & 0x1FF));
> +
> +	return spi_write(spi, &st->d16[0], sizeof(st->d16[0]));
> +}
> +
> +static int ad7606_spi_write_mask(struct ad7606_state *st,
> +				 unsigned int addr,
> +				 unsigned long mask,
> +				 unsigned int val)
> +{
> +	int readval;
> +
> +	readval =3D ad7606_spi_reg_read(st, addr);
> +	if (readval < 0)
> +		return readval;
> +
> +	readval &=3D ~mask;
> +	readval |=3D val;
> +
> +	return ad7606_spi_reg_write(st, addr, readval);
> +}
> +
>  static int ad7606_read_samples(struct ad7606_state *st)
>  {
>  	unsigned int num =3D st->chip_info->num_channels;
> @@ -222,6 +301,26 @@ static int ad7606_write_os_hw(struct iio_dev *indio_=
dev, int val)
>  	return 0;
>  }
> =20
> +static int ad7616_write_scale_sw(struct iio_dev *indio_dev, int ch, int =
val)
> +{
> +	struct ad7606_state *st =3D iio_priv(indio_dev);
> +	unsigned int ch_addr, mode;
> +
> +	ch_addr =3D AD7616_RANGE_CH_ADDR_OFF + AD7616_RANGE_CH_ADDR(ch);
> +	mode =3D AD7616_RANGE_CH_MODE(ch, ((val + 1) & 0x3));
> +
> +	return ad7606_spi_write_mask(st, ch_addr, AD7616_RANGE_CH_MSK(ch),
> +				     mode);
> +}
> +
> +static int ad7616_write_os_sw(struct iio_dev *indio_dev, int val)
> +{
> +	struct ad7606_state *st =3D iio_priv(indio_dev);
> +
> +	return ad7606_spi_write_mask(st, AD7616_CONFIGURATION_REGISTER,
> +				     AD7616_OS_MASK, val << 2);
> +}
> +
>  static int ad7606_write_raw(struct iio_dev *indio_dev,
>  			    struct iio_chan_spec const *chan,
>  			    int val,
> @@ -308,14 +407,14 @@ static const struct attribute_group ad7606_attribut=
e_group_range =3D {
>  	.attrs =3D ad7606_attributes_range,
>  };
> =20
> -#define AD760X_CHANNEL(num, mask) {				\
> +#define AD760X_CHANNEL(num, mask_sep, mask_type, mask_all) {	\
>  		.type =3D IIO_VOLTAGE,				\
>  		.indexed =3D 1,					\
>  		.channel =3D num,					\
>  		.address =3D num,					\
> -		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),	\
> -		.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE),\
> -		.info_mask_shared_by_all =3D mask,		\
> +		.info_mask_separate =3D mask_sep,			\
> +		.info_mask_shared_by_type =3D mask_type,		\
> +		.info_mask_shared_by_all =3D mask_all,		\
>  		.scan_index =3D num,				\
>  		.scan_type =3D {					\
>  			.sign =3D 's',				\
> @@ -325,11 +424,18 @@ static const struct attribute_group ad7606_attribut=
e_group_range =3D {
>  		},						\
>  }
> =20
> -#define AD7605_CHANNEL(num)	\
> -	AD760X_CHANNEL(num, 0)
> +#define AD7605_CHANNEL(num)				\
> +	AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_RAW),	\
> +		BIT(IIO_CHAN_INFO_SCALE), 0)
> +
> +#define AD7606_CHANNEL(num)				\
> +	AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_RAW),	\
> +		BIT(IIO_CHAN_INFO_SCALE),		\
> +		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO))
> =20
> -#define AD7606_CHANNEL(num)	\
> -	AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO))
> +#define AD7616_CHANNEL(num)	\
> +	AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),\
> +		0, BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO))
> =20
>  static const struct iio_chan_spec ad7605_channels[] =3D {
>  	IIO_CHAN_SOFT_TIMESTAMP(4),
> @@ -381,6 +487,26 @@ static const struct iio_chan_spec ad7616_channels[] =
=3D {
>  	AD7606_CHANNEL(15),
>  };
> =20
> +static const struct iio_chan_spec ad7616_sw_channels[] =3D {
> +	IIO_CHAN_SOFT_TIMESTAMP(16),
> +	AD7616_CHANNEL(0),
> +	AD7616_CHANNEL(1),
> +	AD7616_CHANNEL(2),
> +	AD7616_CHANNEL(3),
> +	AD7616_CHANNEL(4),
> +	AD7616_CHANNEL(5),
> +	AD7616_CHANNEL(6),
> +	AD7616_CHANNEL(7),
> +	AD7616_CHANNEL(8),
> +	AD7616_CHANNEL(9),
> +	AD7616_CHANNEL(10),
> +	AD7616_CHANNEL(11),
> +	AD7616_CHANNEL(12),
> +	AD7616_CHANNEL(13),
> +	AD7616_CHANNEL(14),
> +	AD7616_CHANNEL(15),
> +};
> +
>  static const struct ad7606_chip_info ad7606_chip_info_tbl[] =3D {
>  	/* More devices added in future */
>  	[ID_AD7605_4] =3D {
> @@ -408,9 +534,13 @@ static const struct ad7606_chip_info ad7606_chip_inf=
o_tbl[] =3D {
>  	[ID_AD7616] =3D {
>  		.channels =3D ad7616_channels,
>  		.num_channels =3D 17,
> +		.sw_mode_config =3D ad7616_sw_mode_config,
>  		.oversampling_avail =3D ad7616_oversampling_avail,
>  		.oversampling_num =3D ARRAY_SIZE(ad7616_oversampling_avail),
>  		.os_req_reset =3D true,
> +		.spi_rd_wr_cmd =3D ad7616_spi_rd_wr_cmd,
> +		.write_scale_sw =3D ad7616_write_scale_sw,
> +		.write_os_sw =3D ad7616_write_os_sw,
>  	},
>  };
> =20
> @@ -544,6 +674,23 @@ static void ad7606_regulator_disable(void *data)
>  	regulator_disable(st->reg);
>  }
> =20
> +static int ad7616_sw_mode_config(struct iio_dev *indio_dev)
> +{
> +	struct ad7606_state *st =3D iio_priv(indio_dev);
> +
> +	/*
> +	 * Scale can be configured individually for each channel
> +	 * in software mode.
> +	 */
> +	indio_dev->channels =3D ad7616_sw_channels;
> +
> +	/* Activate Burst mode and SEQEN MODE */
> +	return ad7606_spi_write_mask(st,
> +			      AD7616_CONFIGURATION_REGISTER,
> +			      AD7616_BURST_MODE | AD7616_SEQEN_MODE,
> +			      AD7616_BURST_MODE | AD7616_SEQEN_MODE);
> +}
> +
>  int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
>  		 const char *name, unsigned int id,
>  		 const struct ad7606_bus_ops *bops)
> @@ -617,6 +764,10 @@ int ad7606_probe(struct device *dev, int irq, void _=
_iomem *base_address,
>  	if (ret)
>  		dev_warn(st->dev, "failed to RESET: no RESET GPIO specified\n");
> =20
> +	/* AD7616 requires al least 15ms to reconfigure after a reset */
> +	if (msleep_interruptible(15))
> +		return -ERESTARTSYS;
> +
>  	st->write_scale =3D ad7606_write_scale_hw;
>  	st->write_os =3D ad7606_write_os_hw;
> =20
> @@ -625,6 +776,10 @@ int ad7606_probe(struct device *dev, int irq, void _=
_iomem *base_address,
>  							 "adi,sw-mode");
> =20
>  	if (st->sw_mode_en) {
> +		/* Scale of 0.076293 is only available in sw mode */
> +		st->scale_avail =3D ad7616_sw_scale_avail;
> +		st->num_scales =3D ARRAY_SIZE(ad7616_sw_scale_avail);
> +
>  		/* After reset, in software mode, =C2=B110 V is set by default */
>  		memset32(st->range, 2, ARRAY_SIZE(st->range));
>  		indio_dev->info =3D &ad7606_info_os_and_range;
> diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
> index d8a509c2c428..154dc5d1a0cf 100644
> --- a/drivers/iio/adc/ad7606.h
> +++ b/drivers/iio/adc/ad7606.h
> @@ -16,6 +16,7 @@
>   *			oversampling ratios.
>   * @oversampling_num	number of elements stored in oversampling_avail arr=
ay
>   * @os_req_reset	some devices require a reset to update oversampling
> + * @spi_rd_wr_cmd	pointer to the function which calculates the spi addre=
ss
>   * @write_scale_sw	pointer to the function which writes the scale via spi
>  			in software mode
>   * @write_os_sw		pointer to the function which writes the os via spi
> @@ -29,6 +30,7 @@ struct ad7606_chip_info {
>  	const unsigned int		*oversampling_avail;
>  	unsigned int			oversampling_num;
>  	bool				os_req_reset;
> +	u16 (*spi_rd_wr_cmd)(int addr, char isWriteOp);
>  	int (*write_scale_sw)(struct iio_dev *indio_dev, int ch, int val);
>  	int (*write_os_sw)(struct iio_dev *indio_dev, int val);
>  	int (*sw_mode_config)(struct iio_dev *indio_dev);
> @@ -63,6 +65,7 @@ struct ad7606_chip_info {
>   * @complete		completion to indicate end of conversion
>   * @trig		The IIO trigger associated with the device.
>   * @data		buffer for reading data from the device
> + * @d16			be16 buffer for reading data from the device
>   */
>  struct ad7606_state {
>  	struct device			*dev;
> @@ -96,6 +99,7 @@ struct ad7606_state {
>  	 * 16 * 16-bit samples + 64-bit timestamp
>  	 */
>  	unsigned short			data[20] ____cacheline_aligned;
> +	__be16				d16[2];
>  };
> =20
>  /**

