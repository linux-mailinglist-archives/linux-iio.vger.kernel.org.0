Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3D531AF307
	for <lists+linux-iio@lfdr.de>; Sat, 18 Apr 2020 20:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbgDRSFO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Apr 2020 14:05:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:45238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725824AbgDRSFN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Apr 2020 14:05:13 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5212221F7;
        Sat, 18 Apr 2020 18:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587233113;
        bh=aFt/t+QixrMMhZc9iDNmw+15QdJdDJicEA9NNiDa52k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sOsnuZNYWDkrln3yYM+cWcslPYPZ7hFBDCuZEvRhBDw76CZy3eA1IdaWPJeuRJoOp
         u+yXv1NHJF/pMPTZ+xzrqxDt0tJGPG6iU7vrwa5Xc52eUawQnnXNKkwgbGhapQYTjP
         3qaGvi6lTPtr5PQl7bYd6u9cEH9A/GxMJu/JJ7HU=
Date:   Sat, 18 Apr 2020 19:05:08 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Guido =?UTF-8?B?R8O8bnRoZXI=?= <agx@sigxcpu.org>
Cc:     Tomas Novotny <tomas@novotny.cz>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Nishant Malpani <nish.malpani25@gmail.com>
Subject: Re: [PATCH v4 4/5] iio: vcnl4000: Export near level property for
 proximity sensor
Message-ID: <20200418190508.49cc05ee@archlinux>
In-Reply-To: <cfd5373665c4d314764c4dbe20b55de14fb6ba34.1586094535.git.agx@sigxcpu.org>
References: <cover.1586094535.git.agx@sigxcpu.org>
        <cfd5373665c4d314764c4dbe20b55de14fb6ba34.1586094535.git.agx@sigxcpu.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun,  5 Apr 2020 15:50:31 +0200
Guido G=C3=BCnther <agx@sigxcpu.org> wrote:

> When an object can be considered close to the sensor is hardware
> dependent. Allowing to configure the property via device tree
> allows to configure this device specific value.
>=20
> This is useful for e.g. iio-sensor-proxy to indicate to userspace
> if an object is close to the sensor.
>=20
> Signed-off-by: Guido G=C3=BCnther <agx@sigxcpu.org>
Applied.  Thanks,
> ---
>  drivers/iio/light/vcnl4000.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>=20
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index ec803c1e81df..985cc39ede8e 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -83,6 +83,7 @@ struct vcnl4000_data {
>  	struct mutex vcnl4000_lock;
>  	struct vcnl4200_channel vcnl4200_al;
>  	struct vcnl4200_channel vcnl4200_ps;
> +	uint32_t near_level;
>  };
> =20
>  struct vcnl4000_chip_spec {
> @@ -343,6 +344,25 @@ static const struct vcnl4000_chip_spec vcnl4000_chip=
_spec_cfg[] =3D {
>  	},
>  };
> =20
> +static ssize_t vcnl4000_read_near_level(struct iio_dev *indio_dev,
> +					uintptr_t priv,
> +					const struct iio_chan_spec *chan,
> +					char *buf)
> +{
> +	struct vcnl4000_data *data =3D iio_priv(indio_dev);
> +
> +	return sprintf(buf, "%u\n", data->near_level);
> +}
> +
> +static const struct iio_chan_spec_ext_info vcnl4000_ext_info[] =3D {
> +	{
> +		.name =3D "nearlevel",
> +		.shared =3D IIO_SEPARATE,
> +		.read =3D vcnl4000_read_near_level,
> +	},
> +	{ /* sentinel */ }
> +};
> +
>  static const struct iio_chan_spec vcnl4000_channels[] =3D {
>  	{
>  		.type =3D IIO_LIGHT,
> @@ -351,6 +371,7 @@ static const struct iio_chan_spec vcnl4000_channels[]=
 =3D {
>  	}, {
>  		.type =3D IIO_PROXIMITY,
>  		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),
> +		.ext_info =3D vcnl4000_ext_info,
>  	}
>  };
> =20
> @@ -440,6 +461,10 @@ static int vcnl4000_probe(struct i2c_client *client,
>  	dev_dbg(&client->dev, "%s Ambient light/proximity sensor, Rev: %02x\n",
>  		data->chip_spec->prod, data->rev);
> =20
> +	if (device_property_read_u32(&client->dev, "proximity-near-level",
> +				     &data->near_level))
> +		data->near_level =3D 0;
> +
>  	indio_dev->dev.parent =3D &client->dev;
>  	indio_dev->info =3D &vcnl4000_info;
>  	indio_dev->channels =3D vcnl4000_channels;

