Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAC3322320
	for <lists+linux-iio@lfdr.de>; Sat, 18 May 2019 12:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbfERKU5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 May 2019 06:20:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:38964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727286AbfERKU5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 May 2019 06:20:57 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7ED2920B7C;
        Sat, 18 May 2019 10:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558174855;
        bh=L2QavqgoKZTPfEfcnaeMTRj+WgFIra18OpGUJXXhnrw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NfRENGIEJe/R9moIle0lzZDUXfTLt8bMu5wjvjZKnmhcdj2DPYLRd8JgHiJdx3oTD
         JsYlxFvLrCmZ/HZaj0Hw8Lgc0KSfsEri3Kr7AwmYkDRWBE74ssYYrvDN43X4CeiEN1
         uZRo1wSPqql1/oBFiisPzV6mMJWoaQCL7GnBoH/c=
Date:   Sat, 18 May 2019 11:20:50 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <biabeniamin@outlook.com>
Subject: Re: [PATCH 4/5] iio: adc: ad7606: Add support for software mode for
 ad7616
Message-ID: <20190518112050.35a99bbc@archlinux>
In-Reply-To: <20190516143208.19294-4-beniamin.bia@analog.com>
References: <20190516143208.19294-1-beniamin.bia@analog.com>
 <20190516143208.19294-4-beniamin.bia@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 May 2019 17:32:07 +0300
Beniamin Bia <beniamin.bia@analog.com> wrote:

> Support for ad7616 running in software was added. In order
> to activate the software mode, HW_RNGSEL pins must be pulled low.
> Oversampling and input ranges are now configured in corresponding
> registers. Ad7616 has multiple scale options when it is configured
> in software mode.
>=20
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
Looks good subject to comments on the previous.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7606.c | 111 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 103 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index 6df81117cacc..f77df3efe43f 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -29,6 +29,20 @@
> =20
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
> @@ -37,6 +51,11 @@ static const unsigned int ad7606_scale_avail[2] =3D {
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
> @@ -282,6 +301,26 @@ static int ad7606_write_os_hw(struct iio_dev *indio_=
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
> @@ -368,14 +407,14 @@ static const struct attribute_group ad7606_attribut=
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
> @@ -385,11 +424,18 @@ static const struct attribute_group ad7606_attribut=
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
> @@ -441,6 +487,26 @@ static const struct iio_chan_spec ad7616_channels[] =
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
> @@ -468,9 +534,13 @@ static const struct ad7606_chip_info ad7606_chip_inf=
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
> @@ -604,6 +674,23 @@ static void ad7606_regulator_disable(void *data)
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
> @@ -677,6 +764,10 @@ int ad7606_probe(struct device *dev, int irq, void _=
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
> @@ -685,6 +776,10 @@ int ad7606_probe(struct device *dev, int irq, void _=
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

