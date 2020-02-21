Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2836C167D11
	for <lists+linux-iio@lfdr.de>; Fri, 21 Feb 2020 13:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbgBUMFZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Feb 2020 07:05:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:50672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbgBUMFZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 21 Feb 2020 07:05:25 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80F4B24656;
        Fri, 21 Feb 2020 12:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582286724;
        bh=WIk1USnqAYkVxVYxm8jkcz/+F+dnJUCoVZThI8VfNkg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KtCnfAra6d8zyENZqf6RSr+3ZUy4jJnz9Yaz0D7BcMlgtGksKzAbq0l4pFEU86z2x
         f4y550bi4rYlZk7WqL7Pg0yNOULb3Zlumegz4RCtIY+ZuKwjVYMU0V11WV68JBByrH
         wvRgl1HEziNnUgsB5cqI9CHcH4+x1SizLQeRiGo8=
Date:   Fri, 21 Feb 2020 12:05:19 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Guido =?UTF-8?B?R8O8bnRoZXI=?= <agx@sigxcpu.org>
Cc:     Tomas Novotny <tomas@novotny.cz>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: vcnl4000: Export near level property for
 proximity sensor
Message-ID: <20200221120519.43b72007@archlinux>
In-Reply-To: <4a8075acde807225a2d9aeb4164fff881013bbe2.1581947007.git.agx@sigxcpu.org>
References: <cover.1581947007.git.agx@sigxcpu.org>
        <4a8075acde807225a2d9aeb4164fff881013bbe2.1581947007.git.agx@sigxcpu.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 17 Feb 2020 14:44:47 +0100
Guido G=C3=BCnther <agx@sigxcpu.org> wrote:

> When an object can be considered close to the sensor is hardware
> dependent. Allowing to configure the property via device tree
> allows to configure this device specific value.
>=20
> This is useful for e.g. iio-sensor-proxy to indicate to userspace
> if an object is close to the sensor.
>=20
> Signed-off-by: Guido G=C3=BCnther <agx@sigxcpu.org>

I'd like this to sit for a while on the mailing list and hopefully get
some input from others.

However, it needs documentation and I think this should be in the
generic docs, or at least proximity specific ones.

Documentation/ABI/testing/sysfs-bus-iio-proximity would be the obvious
place.

Thanks,

Jonathan

> ---
>  drivers/iio/light/vcnl4000.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>=20
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index 38fcd9a26046..7111118e0fda 100644
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
> @@ -342,6 +343,26 @@ static const struct vcnl4000_chip_spec vcnl4000_chip=
_spec_cfg[] =3D {
>  	},
>  };
> =20
> +
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
> +		.name =3D "near_level",
> +		.shared =3D IIO_SEPARATE,
> +		.read =3D vcnl4000_read_near_level,
> +	},
> +	{ /* sentinel */ }
> +};
> +
>  static const struct iio_chan_spec vcnl4000_channels[] =3D {
>  	{
>  		.type =3D IIO_LIGHT,
> @@ -350,6 +371,7 @@ static const struct iio_chan_spec vcnl4000_channels[]=
 =3D {
>  	}, {
>  		.type =3D IIO_PROXIMITY,
>  		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),
> +		.ext_info =3D vcnl4000_ext_info,
>  	}
>  };
> =20
> @@ -439,6 +461,10 @@ static int vcnl4000_probe(struct i2c_client *client,
>  	dev_dbg(&client->dev, "%s Ambient light/proximity sensor, Rev: %02x\n",
>  		data->chip_spec->prod, data->rev);
> =20
> +	if (device_property_read_u32(&client->dev, "near-level",
> +				     &data->near_level) < 0)
> +		data->near_level =3D 0;
> +
>  	indio_dev->dev.parent =3D &client->dev;
>  	indio_dev->info =3D &vcnl4000_info;
>  	indio_dev->channels =3D vcnl4000_channels;

