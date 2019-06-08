Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14D6B39D41
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2019 13:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfFHL1y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Jun 2019 07:27:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:53902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726930AbfFHL1y (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 8 Jun 2019 07:27:54 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB8FE2146E;
        Sat,  8 Jun 2019 11:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559993273;
        bh=weH8EC/uoYWcA/LwWDgSVN249qFObxkBB3HcdMk5Vwk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=n5Zu/SMNePdUE37qRqXEX+OO3LbKc1ijWx8/l+GiQew032hRHjtpg/PON2vO1UuSX
         Ok1U7hnbOhLO79SGxRI2ulM9tkuaGGT5xeRJ4z1BQpA/MYM28MRQi1ga02fO8srLuI
         9KBsvspRsEIDlSX51eMEsYfIaXPC6ALlFbbkF70I=
Date:   Sat, 8 Jun 2019 12:27:46 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <biabeniamin@outlook.com>
Subject: Re: [PATCH v2 2/4] iio: adc: ad7606: Add software configuration
Message-ID: <20190608122746.1e7d4536@archlinux>
In-Reply-To: <20190527125650.2405-2-beniamin.bia@analog.com>
References: <20190527125650.2405-1-beniamin.bia@analog.com>
        <20190527125650.2405-2-beniamin.bia@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 27 May 2019 15:56:48 +0300
Beniamin Bia <beniamin.bia@analog.com> wrote:

> Because this driver will support multiple configurations for software,
> the software configuration was made generic.
>=20
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
> Acked-by: Jonathan Cameron <jic23@kernel.org>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to poke at it.

Thanks,

Jonathan

> ---
> Changes in v2:
> -nothing changed
>=20
>  drivers/iio/adc/ad7606.c | 40 +++++++++++++++++++++++++++++++++++++---
>  drivers/iio/adc/ad7606.h |  2 ++
>  2 files changed, 39 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index c66ff22f32d2..aba0fd123a51 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -140,7 +140,7 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
>  			   int *val2,
>  			   long m)
>  {
> -	int ret;
> +	int ret, ch =3D 0;
>  	struct ad7606_state *st =3D iio_priv(indio_dev);
> =20
>  	switch (m) {
> @@ -157,8 +157,10 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
>  		*val =3D (short)ret;
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
> +		if (st->sw_mode_en)
> +			ch =3D chan->address;
>  		*val =3D 0;
> -		*val2 =3D st->scale_avail[st->range[0]];
> +		*val2 =3D st->scale_avail[st->range[ch]];
>  		return IIO_VAL_INT_PLUS_MICRO;
>  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
>  		*val =3D st->oversampling;
> @@ -233,7 +235,9 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_SCALE:
>  		mutex_lock(&st->lock);
>  		i =3D find_closest(val2, st->scale_avail, st->num_scales);
> -		ret =3D st->write_scale(indio_dev, chan->address, i);
> +		if (st->sw_mode_en)
> +			ch =3D chan->address;
> +		ret =3D st->write_scale(indio_dev, ch, i);
>  		if (ret < 0) {
>  			mutex_unlock(&st->lock);
>  			return ret;
> @@ -616,6 +620,36 @@ int ad7606_probe(struct device *dev, int irq, void _=
_iomem *base_address,
>  	st->write_scale =3D ad7606_write_scale_hw;
>  	st->write_os =3D ad7606_write_os_hw;
> =20
> +	if (st->chip_info->sw_mode_config)
> +		st->sw_mode_en =3D device_property_present(st->dev,
> +							 "adi,sw-mode");
> +
> +	if (st->sw_mode_en) {
> +		/* After reset, in software mode, =C2=B110 V is set by default */
> +		memset32(st->range, 2, ARRAY_SIZE(st->range));
> +		indio_dev->info =3D &ad7606_info_os_and_range;
> +
> +		/*
> +		 * In software mode, the range gpio has no longer its function.
> +		 * Instead, the scale can be configured individually for each
> +		 * channel from the range registers.
> +		 */
> +		if (st->chip_info->write_scale_sw)
> +			st->write_scale =3D st->chip_info->write_scale_sw;
> +
> +		/*
> +		 * In software mode, the oversampling is no longer configured
> +		 * with GPIO pins. Instead, the oversampling can be configured
> +		 * in configuratiion register.
> +		 */
> +		if (st->chip_info->write_os_sw)
> +			st->write_os =3D st->chip_info->write_os_sw;
> +
> +		ret =3D st->chip_info->sw_mode_config(indio_dev);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
>  	st->trig =3D devm_iio_trigger_alloc(dev, "%s-dev%d",
>  					  indio_dev->name, indio_dev->id);
>  	if (!st->trig)
> diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
> index 143c30163df9..d8a509c2c428 100644
> --- a/drivers/iio/adc/ad7606.h
> +++ b/drivers/iio/adc/ad7606.h
> @@ -43,6 +43,7 @@ struct ad7606_chip_info {
>   * @range		voltage range selection, selects which scale to apply
>   * @oversampling	oversampling selection
>   * @base_address	address from where to read data in parallel operation
> + * @sw_mode_en		software mode enabled
>   * @scale_avail		pointer to the array which stores the available scales
>   * @num_scales		number of elements stored in the scale_avail array
>   * @oversampling_avail	pointer to the array which stores the available
> @@ -71,6 +72,7 @@ struct ad7606_state {
>  	unsigned int			range[16];
>  	unsigned int			oversampling;
>  	void __iomem			*base_address;
> +	bool				sw_mode_en;
>  	const unsigned int		*scale_avail;
>  	unsigned int			num_scales;
>  	const unsigned int		*oversampling_avail;

