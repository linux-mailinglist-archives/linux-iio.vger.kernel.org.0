Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0859867FFB
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jul 2019 17:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfGNPzQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Jul 2019 11:55:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:53604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726783AbfGNPzP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Jul 2019 11:55:15 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCC832063F;
        Sun, 14 Jul 2019 15:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563119714;
        bh=IZuXT8u36YOVMAUV9vDMzpDimPKi8NaM4KTVjlp3Tpw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p/HGxuwRk21dvR+Fl18Giij2aXlxEPE9M2dv0acvphjGr305BteKTDFx8IXvfpIHU
         W058LbGxLhJuPj4pnU7twCGlRhodn6leZzINAj6kw6IQsh+mBp+rMlk41l1InsCIce
         1ytAm/cFzOIPiga5uBn9Zy54ppc5RoLWjypuvYWQ=
Date:   Sun, 14 Jul 2019 16:54:59 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 4/5] iio: adc: ad7606: Add support for software mode for
 ad7616
Message-ID: <20190714165459.17e3f5d0@archlinux>
In-Reply-To: <20190703143648.24402-4-beniamin.bia@analog.com>
References: <20190703143648.24402-1-beniamin.bia@analog.com>
        <20190703143648.24402-4-beniamin.bia@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 3 Jul 2019 17:36:47 +0300
Beniamin Bia <beniamin.bia@analog.com> wrote:

> Support for ad7616 running in software was added. In order
> to activate the software mode, HW_RNGSEL pins must be pulled low.
> Oversampling and input ranges are now configured in corresponding
> registers. Ad7616 has multiple scale options when it is configured
> in software mode.
> Also, in order to support multiple devices in software mode, the spi
> calculation of registers address must be generic. Because
> the length of address and bit which specifies the read/write operation is
> different for every device, calculation of address was made generic.
>=20
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
A few minor comments inline that might improve readability a little.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7606.c     |   9 +++
>  drivers/iio/adc/ad7606.h     |  38 +++++++--
>  drivers/iio/adc/ad7606_spi.c | 148 ++++++++++++++++++++++++++++++++++-
>  3 files changed, 186 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index a6034cf7238a..be2330c8b277 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -35,6 +35,11 @@ static const unsigned int ad7606_scale_avail[2] =3D {
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
> @@ -606,6 +611,10 @@ int ad7606_probe(struct device *dev, int irq, void _=
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
> index a6aac33aa33c..eeaaa8b905db 100644
> --- a/drivers/iio/adc/ad7606.h
> +++ b/drivers/iio/adc/ad7606.h
> @@ -8,14 +8,14 @@
>  #ifndef IIO_ADC_AD7606_H_
>  #define IIO_ADC_AD7606_H_
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
> @@ -25,11 +25,18 @@
>  		},						\
>  }
> =20
> -#define AD7605_CHANNEL(num)	\
> -	AD760X_CHANNEL(num, 0)
> +#define AD7605_CHANNEL(num)				\
> +	AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_RAW),	\
> +		BIT(IIO_CHAN_INFO_SCALE), 0)
> =20
> -#define AD7606_CHANNEL(num)	\
> -	AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO))
> +#define AD7606_CHANNEL(num)				\
> +	AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_RAW),	\
> +		BIT(IIO_CHAN_INFO_SCALE),		\
> +		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO))
> +
> +#define AD7616_CHANNEL(num)	\
> +	AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),\
> +		0, BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO))
> =20
>  /**
>   * struct ad7606_chip_info - chip specific information
> @@ -77,6 +84,7 @@ struct ad7606_chip_info {
>   * @complete		completion to indicate end of conversion
>   * @trig		The IIO trigger associated with the device.
>   * @data		buffer for reading data from the device
> + * @d16			be16 buffer for reading data from the device
>   */
>  struct ad7606_state {
>  	struct device			*dev;
> @@ -110,6 +118,7 @@ struct ad7606_state {
>  	 * 16 * 16-bit samples + 64-bit timestamp
>  	 */
>  	unsigned short			data[20] ____cacheline_aligned;
> +	__be16				d16[2];
>  };
> =20
>  /**
> @@ -117,11 +126,24 @@ struct ad7606_state {
>   * @read_block		function pointer for reading blocks of data
>   * @sw_mode_config:	pointer to a function which configured the device
>   *			for software mode
> + * @reg_read	function pointer for reading spi register
> + * @reg_write	function pointer for writing spi register
> + * @write_mask	function pointer for write spi register with mask
> + * @rd_wr_cmd	pointer to the function which calculates the spi address
>   */
>  struct ad7606_bus_ops {
>  	/* more methods added in future? */
>  	int (*read_block)(struct device *dev, int num, void *data);
>  	int (*sw_mode_config)(struct iio_dev *indio_dev);
> +	int (*reg_read)(struct ad7606_state *st, unsigned int addr);
> +	int (*reg_write)(struct ad7606_state *st,
> +				unsigned int addr,
> +				unsigned int val);
> +	int (*write_mask)(struct ad7606_state *st,
> +				 unsigned int addr,
> +				 unsigned long mask,
> +				 unsigned int val);
> +	u16 (*rd_wr_cmd)(int addr, char isWriteOp);
>  };
> =20
>  int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
> diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
> index b7faef69a58f..d96d8d6d5fc5 100644
> --- a/drivers/iio/adc/ad7606_spi.c
> +++ b/drivers/iio/adc/ad7606_spi.c
> @@ -15,6 +15,40 @@
> =20
>  #define MAX_SPI_FREQ_HZ		23500000	/* VDRIVE above 4.75 V */
> =20
> +#define AD7616_CONFIGURATION_REGISTER	0x02
> +#define AD7616_OS_MASK			GENMASK(4,  2)
Extra space between , and 2
> +#define AD7616_BURST_MODE		BIT(6)
> +#define AD7616_SEQEN_MODE		BIT(5)
> +#define AD7616_RANGE_CH_ADDR_OFF	0x04
> +#define AD7616_RANGE_CH_ADDR(ch)	((((ch) & 0x1) << 1) + ((ch) >> 3))
> +#define AD7616_RANGE_CH_MSK(ch)		(GENMASK(1, 0) << ((ch) & 0x6))
> +#define AD7616_RANGE_CH_MODE(ch, mode)	((mode) << (ch & GENMASK(2, 1)))
Hmm. These 3 are rather non obvious.

GENMASK(2, 1) is 0x6, yet you used the value for the second one and not the=
 third?
ch in the last one should have brackets.

So this is complicated by the channel ordering as v0a, v0b, v1a, v1b.
I would add some comments to explain what is going on here.

> +
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
> +static u16 ad7616_spi_rd_wr_cmd(int addr, char isWriteOp)
> +{
> +	return ((addr & 0x7F) << 1) | ((isWriteOp & 0x1) << 7);
Hmm. Wrapping this up makes it harder to realise that this is only
7 bits, that we happen to shove left 1 bit (then always shift another
8 when using it).

I would make it take the value as well, and put all of the data
arrangement in one function.

> +}
> +
>  static int ad7606_spi_read_block(struct device *dev,
>  				 int count, void *buf)
>  {
> @@ -35,17 +69,129 @@ static int ad7606_spi_read_block(struct device *dev,
>  	return 0;
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
> +	st->d16[0] =3D cpu_to_be16(st->bops->rd_wr_cmd(addr, 0) << 8);
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
> +	st->d16[0] =3D cpu_to_be16((st->bops->rd_wr_cmd(addr, 1) << 8) |
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
> +	readval =3D st->bops->reg_read(st, addr);
> +	if (readval < 0)
> +		return readval;
> +
> +	readval &=3D ~mask;
> +	readval |=3D val;
> +
> +	return st->bops->reg_write(st, addr, readval);
> +}
> +
> +static int ad7616_write_scale_sw(struct iio_dev *indio_dev, int ch, int =
val)
> +{
> +	struct ad7606_state *st =3D iio_priv(indio_dev);
> +	unsigned int ch_addr, mode;
> +
> +	ch_addr =3D AD7616_RANGE_CH_ADDR_OFF + AD7616_RANGE_CH_ADDR(ch);
> +	mode =3D AD7616_RANGE_CH_MODE(ch, ((val + 1) & 0x3));
> +
> +	return st->bops->write_mask(st, ch_addr, AD7616_RANGE_CH_MSK(ch),
> +				     mode);
> +}
> +
> +static int ad7616_write_os_sw(struct iio_dev *indio_dev, int val)
> +{
> +	struct ad7606_state *st =3D iio_priv(indio_dev);
> +
> +	return st->bops->write_mask(st, AD7616_CONFIGURATION_REGISTER,
> +				     AD7616_OS_MASK, val << 2);
> +}
> +
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
> +	st->write_scale =3D ad7616_write_scale_sw;
> +	st->write_os =3D &ad7616_write_os_sw;
> +
> +	/* Activate Burst mode and SEQEN MODE */
> +	return st->bops->write_mask(st,
> +			      AD7616_CONFIGURATION_REGISTER,
> +			      AD7616_BURST_MODE | AD7616_SEQEN_MODE,
> +			      AD7616_BURST_MODE | AD7616_SEQEN_MODE);
> +}
> +
>  static const struct ad7606_bus_ops ad7606_spi_bops =3D {
>  	.read_block =3D ad7606_spi_read_block,
>  };
> =20
> +static const struct ad7606_bus_ops ad7616_spi_bops =3D {
> +	.read_block =3D ad7606_spi_read_block,
> +	.reg_read =3D ad7606_spi_reg_read,
> +	.reg_write =3D ad7606_spi_reg_write,
> +	.write_mask =3D ad7606_spi_write_mask,
> +	.rd_wr_cmd =3D ad7616_spi_rd_wr_cmd,
> +	.sw_mode_config =3D ad7616_sw_mode_config,
> +};
> +
>  static int ad7606_spi_probe(struct spi_device *spi)
>  {
>  	const struct spi_device_id *id =3D spi_get_device_id(spi);
> +	const struct ad7606_bus_ops *bops;
> +
> +	switch (id->driver_data) {
> +	case ID_AD7616:
> +		bops =3D &ad7616_spi_bops;
> +		break;
> +	default:
> +		bops =3D &ad7606_spi_bops;
> +		break;
> +	}
> =20
>  	return ad7606_probe(&spi->dev, spi->irq, NULL,
>  			    id->name, id->driver_data,
> -			    &ad7606_spi_bops);
> +			    bops);
>  }
> =20
>  static const struct spi_device_id ad7606_id_table[] =3D {

