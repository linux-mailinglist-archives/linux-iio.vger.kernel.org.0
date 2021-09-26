Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6AB4188F0
	for <lists+linux-iio@lfdr.de>; Sun, 26 Sep 2021 14:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbhIZNA2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Sep 2021 09:00:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42842 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231450AbhIZNA1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Sep 2021 09:00:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632661131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QbL+eLTxm6YSmBJWXQYDoAmR9iWlnP8x+EGAg/vUkC4=;
        b=ECNISYbQZaPaZpDkdrwiCdeZB/vwkF8StuYvfg8bCPSIN8mCot65SnXp8zy4lNt9HVsCkA
        u6XUO/caNfKDQfpTd/dCOaIhvN0dQR+P2A6aWgzNFDi2hGHOAZFobe/pqC7gfWUyCA0/xl
        hRGWrbac9F3ZdNaJwKx4tcgrMdtDQbs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-520-gnMp1UssOSuzA691Hbpb5A-1; Sun, 26 Sep 2021 08:58:49 -0400
X-MC-Unique: gnMp1UssOSuzA691Hbpb5A-1
Received: by mail-ed1-f70.google.com with SMTP id 14-20020a508e4e000000b003d84544f33eso15051109edx.2
        for <linux-iio@vger.kernel.org>; Sun, 26 Sep 2021 05:58:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QbL+eLTxm6YSmBJWXQYDoAmR9iWlnP8x+EGAg/vUkC4=;
        b=tER+HZjp19fxuZhKJKRYjaxhNNC9woOpgv3caqU+FTJqUUPGlADKLNrIsc9JJp43Xv
         oSmtr0p12FyHGeCWTflXxaoOLyqHFAyzfOyDtnD+XnpxrtoGMcz8+m7qd9weclpDpN2U
         WIhhmTCvbgSmGkaD+bMrnTmK4KZSBNq21G8B9HWDvDfbpE0ELlzlXsu9bQuXQ09tdEWM
         MfZ/PJXVKXInEeEq0qlbVxfeyokkxkEA6pO44zGAJAJuKw8BGHU6nIbXSlECtJtTntx4
         FWhsJ11aKh5+YLGGfUemm1P54rrhG8ykYpwBYXZbHJge6lhC6HyqyEGVvrJpg/KDyOXy
         v1QA==
X-Gm-Message-State: AOAM533s6BrE+MNr0JNy7eo7aFcaY/jyrinnOxvle7B3FlO/7KCQiMyT
        F8+I9RGFtUFq2vU/ItaVx3yOJg3RyON18ewTDCMPIFsSfZeMv7QOQeHGhptQPxnsMz5HcdlI4Qx
        42pkfH4f4/F9xB1QdjTBg
X-Received: by 2002:a17:906:4d53:: with SMTP id b19mr20823276ejv.180.1632661128210;
        Sun, 26 Sep 2021 05:58:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzFDo1MF89e0Zm+KY+oLhU7lcrCQ3EANeS6+8vpKGWh+GbFsgDJHVher+haQ4fpsRovq16FeQ==
X-Received: by 2002:a17:906:4d53:: with SMTP id b19mr20823259ejv.180.1632661127954;
        Sun, 26 Sep 2021 05:58:47 -0700 (PDT)
Received: from localhost (net-130-25-199-50.cust.vodafonedsl.it. [130.25.199.50])
        by smtp.gmail.com with ESMTPSA id s3sm7310652eja.87.2021.09.26.05.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 05:58:47 -0700 (PDT)
Date:   Sun, 26 Sep 2021 14:58:45 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: move max_fifo_size in
 st_lsm6dsx_fifo_ops
Message-ID: <YVBuhVU/fcJjgTU6@lore-desk>
References: <b2981cb9a00784a84fec0ea62183629216ec3b38.1632388011.git.lorenzo@kernel.org>
 <20210926125916.6540ba7a@jic23-huawei>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/O13q6dssv33KFVT"
Content-Disposition: inline
In-Reply-To: <20210926125916.6540ba7a@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--/O13q6dssv33KFVT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, 23 Sep 2021 11:08:24 +0200
> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>=20
> > This patch does not introduce any logic change, just small code
> > rearrangement.
> Hi Lorenzo,=20
>=20
> Why?  I can make an educated guess that it is to put all the fifo related=
 stuff
> in one place, but you probably need to state that in the patch descriptio=
n.

yes, it seems to me it is logically correct to have fifo configuration in
fifo_ops. I will post v2 adding this in the commit log.

Regards,
Lorenzo

>=20
> Thanks,
>=20
> Jonathan
>=20
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  4 ++--
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 16 +++++++++-------
> >  2 files changed, 11 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/=
st_lsm6dsx/st_lsm6dsx.h
> > index 5ef55763a6cc..6ac4eac36458 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > @@ -143,6 +143,7 @@ struct st_lsm6dsx_fs_table_entry {
> >   * @read_fifo: Read FIFO callback.
> >   * @fifo_th: FIFO threshold register info (addr + mask).
> >   * @fifo_diff: FIFO diff status register info (addr + mask).
> > + * @max_size: Sensor max fifo length in FIFO words.
> >   * @th_wl: FIFO threshold word length.
> >   */
> >  struct st_lsm6dsx_fifo_ops {
> > @@ -156,6 +157,7 @@ struct st_lsm6dsx_fifo_ops {
> >  		u8 addr;
> >  		u16 mask;
> >  	} fifo_diff;
> > +	u16 max_size;
> >  	u8 th_wl;
> >  };
> > =20
> > @@ -271,7 +273,6 @@ struct st_lsm6dsx_ext_dev_settings {
> >   * @reset: register address for reset.
> >   * @boot: register address for boot.
> >   * @bdu: register address for Block Data Update.
> > - * @max_fifo_size: Sensor max fifo length in FIFO words.
> >   * @id: List of hw id/device name supported by the driver configuratio=
n.
> >   * @channels: IIO channels supported by the device.
> >   * @irq_config: interrupts related registers.
> > @@ -288,7 +289,6 @@ struct st_lsm6dsx_settings {
> >  	struct st_lsm6dsx_reg reset;
> >  	struct st_lsm6dsx_reg boot;
> >  	struct st_lsm6dsx_reg bdu;
> > -	u16 max_fifo_size;
> >  	struct {
> >  		enum st_lsm6dsx_hw_id hw_id;
> >  		const char *name;
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio=
/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > index db45f1fc0b81..0f54df85134a 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > @@ -102,7 +102,6 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_=
sensor_settings[] =3D {
> >  			.addr =3D 0x22,
> >  			.mask =3D BIT(6),
> >  		},
> > -		.max_fifo_size =3D 32,
> >  		.id =3D {
> >  			{
> >  				.hw_id =3D ST_LSM9DS1_ID,
> > @@ -194,6 +193,9 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_=
sensor_settings[] =3D {
> >  				.mask =3D BIT(4),
> >  			},
> >  		},
> > +		.fifo_ops =3D {
> > +			.max_size =3D 32,
> > +		},
> >  	},
> >  	{
> >  		.reset =3D {
> > @@ -208,7 +210,6 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_=
sensor_settings[] =3D {
> >  			.addr =3D 0x12,
> >  			.mask =3D BIT(6),
> >  		},
> > -		.max_fifo_size =3D 1365,
> >  		.id =3D {
> >  			{
> >  				.hw_id =3D ST_LSM6DS3_ID,
> > @@ -329,6 +330,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_=
sensor_settings[] =3D {
> >  				.addr =3D 0x3a,
> >  				.mask =3D GENMASK(11, 0),
> >  			},
> > +			.max_size =3D 1365,
> >  			.th_wl =3D 3, /* 1LSB =3D 2B */
> >  		},
> >  		.ts_settings =3D {
> > @@ -374,7 +376,6 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_=
sensor_settings[] =3D {
> >  			.addr =3D 0x12,
> >  			.mask =3D BIT(6),
> >  		},
> > -		.max_fifo_size =3D 682,
> >  		.id =3D {
> >  			{
> >  				.hw_id =3D ST_LSM6DS3H_ID,
> > @@ -495,6 +496,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_=
sensor_settings[] =3D {
> >  				.addr =3D 0x3a,
> >  				.mask =3D GENMASK(11, 0),
> >  			},
> > +			.max_size =3D 682,
> >  			.th_wl =3D 3, /* 1LSB =3D 2B */
> >  		},
> >  		.ts_settings =3D {
> > @@ -540,7 +542,6 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_=
sensor_settings[] =3D {
> >  			.addr =3D 0x12,
> >  			.mask =3D BIT(6),
> >  		},
> > -		.max_fifo_size =3D 682,
> >  		.id =3D {
> >  			{
> >  				.hw_id =3D ST_LSM6DSL_ID,
> > @@ -677,6 +678,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_=
sensor_settings[] =3D {
> >  				.addr =3D 0x3a,
> >  				.mask =3D GENMASK(10, 0),
> >  			},
> > +			.max_size =3D 682,
> >  			.th_wl =3D 3, /* 1LSB =3D 2B */
> >  		},
> >  		.ts_settings =3D {
> > @@ -759,7 +761,6 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_=
sensor_settings[] =3D {
> >  			.addr =3D 0x12,
> >  			.mask =3D BIT(6),
> >  		},
> > -		.max_fifo_size =3D 512,
> >  		.id =3D {
> >  			{
> >  				.hw_id =3D ST_LSM6DSR_ID,
> > @@ -910,6 +911,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_=
sensor_settings[] =3D {
> >  				.addr =3D 0x3a,
> >  				.mask =3D GENMASK(9, 0),
> >  			},
> > +			.max_size =3D 512,
> >  			.th_wl =3D 1,
> >  		},
> >  		.ts_settings =3D {
> > @@ -984,7 +986,6 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_=
sensor_settings[] =3D {
> >  			.addr =3D 0x12,
> >  			.mask =3D BIT(6),
> >  		},
> > -		.max_fifo_size =3D 512,
> >  		.id =3D {
> >  			{
> >  				.hw_id =3D ST_ASM330LHH_ID,
> > @@ -1119,6 +1120,7 @@ static const struct st_lsm6dsx_settings st_lsm6ds=
x_sensor_settings[] =3D {
> >  				.addr =3D 0x3a,
> >  				.mask =3D GENMASK(9, 0),
> >  			},
> > +			.max_size =3D 512,
> >  			.th_wl =3D 1,
> >  		},
> >  		.ts_settings =3D {
> > @@ -1603,7 +1605,7 @@ int st_lsm6dsx_set_watermark(struct iio_dev *iio_=
dev, unsigned int val)
> >  	struct st_lsm6dsx_hw *hw =3D sensor->hw;
> >  	int err;
> > =20
> > -	if (val < 1 || val > hw->settings->max_fifo_size)
> > +	if (val < 1 || val > hw->settings->fifo_ops.max_size)
> >  		return -EINVAL;
> > =20
> >  	mutex_lock(&hw->conf_lock);
>=20

--/O13q6dssv33KFVT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYVBuhQAKCRA6cBh0uS2t
rLf7AQD83Tib8/kUJiUqG+gJyCIbFKaQlHwUmdHvfBez0AlMcAEAvytXfCxTi8f1
LOSS4v+/1tf7UEW8SJR12cprjq8xMQQ=
=KuQd
-----END PGP SIGNATURE-----

--/O13q6dssv33KFVT--

