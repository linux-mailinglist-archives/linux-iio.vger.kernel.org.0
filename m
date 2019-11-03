Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15309ED367
	for <lists+linux-iio@lfdr.de>; Sun,  3 Nov 2019 14:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfKCNHC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 Nov 2019 08:07:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49008 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727377AbfKCNHC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Nov 2019 08:07:02 -0500
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E274C59455
        for <linux-iio@vger.kernel.org>; Sun,  3 Nov 2019 13:07:00 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id l184so5205330wmf.6
        for <linux-iio@vger.kernel.org>; Sun, 03 Nov 2019 05:07:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e4UZMqEylvJt4IQzH3WamGIuJFZcocw9C3O8hslNb+A=;
        b=KqdgZb2oxfLC1MgjCgC+rBEqWUdc4xWzT5Odt/3NWpcSKYjoj+VAr5c+h/vEb3Djef
         sdYq8ztcUcx8DqkNTEguZ3fDHN5BecDLC1t7a35HgpTO6BEAu70Vs+81CZGeovAS/WZ3
         8J/wGkt6XQ72lRG0xcutLWf1XI0oAyf8dC4DRIUBKebOfTCmOSOFsAqfzlHcIjw1djra
         lOsvg/jA2FFutYAvVv8jI/L4ZulIkJrawFTvnsgg6D+rJKTj2Onbsnum3X8vkUWWAKOT
         FlPUDlTt5u/lmmA3gpxrdQ4u/jBaE5U8gB99ajM8vsFnua2nC3jZNGw4ZzYgJs4flDUQ
         xXfg==
X-Gm-Message-State: APjAAAXNwHmTldxzit9igbY6Wj8x8oaAgdmLa4n9fOMKC2YjYzrsRPcZ
        1B/T5BN0RzdfFLcp65G0DE72ydI9gFHlpE9R7CRGpxlV7DoOtvRGHUUcTPpk0ocu96GZ3OUrgBK
        zY1JVSxVeDo0NaAFVUT+8
X-Received: by 2002:a1c:bc56:: with SMTP id m83mr15937404wmf.11.1572786419469;
        Sun, 03 Nov 2019 05:06:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqxq+EmZKZVLkfITkA31GAS7yjhNzRgG1bKRYjA2JdjDggmbS1E1nyg2DttEdDmRlZ4Q2EYRTg==
X-Received: by 2002:a1c:bc56:: with SMTP id m83mr15937381wmf.11.1572786418982;
        Sun, 03 Nov 2019 05:06:58 -0800 (PST)
Received: from localhost.localdomain ([176.229.194.15])
        by smtp.gmail.com with ESMTPSA id h140sm13191405wme.22.2019.11.03.05.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2019 05:06:58 -0800 (PST)
Date:   Sun, 3 Nov 2019 14:06:55 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: imu: st_lsm6dsx: express odr in HZ / 10
Message-ID: <20191103130655.GA5291@localhost.localdomain>
References: <cover.1572203759.git.lorenzo@kernel.org>
 <3d1ffc5fd083dcbd007872e5e8f5261faac69503.1572203759.git.lorenzo@kernel.org>
 <20191103101302.59356d9e@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
In-Reply-To: <20191103101302.59356d9e@archlinux>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Nov 03, Jonathan Cameron wrote:
> On Sun, 27 Oct 2019 20:21:24 +0100
> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>=20
> > Express available frequencies in HZ / 10 in order to support even
> > rational ODRs. This patch is need to fix an Android CTS failure
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |   2 +-
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 181 ++++++++++---------
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c |  23 ++-
> >  3 files changed, 106 insertions(+), 100 deletions(-)
> >=20
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/=
st_lsm6dsx/st_lsm6dsx.h
> > index 9ffc8e06f73d..b32c6389f47b 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > @@ -106,7 +106,7 @@ struct st_lsm6dsx_sensor;
> >  struct st_lsm6dsx_hw;
> > =20
> >  struct st_lsm6dsx_odr {
> > -	u16 hz;
> > +	u16 hz; /* expressed in HZ / 10 */
>=20
> That is in the non obvious category.  Maybe best bet
> is to switch to millihz and make the type bigger if needed?

Hi Jonathan,

ack, I will post a v2.

Regards,
Lorenzo

>=20
> Thanks,
>=20
> Jonathan
>=20
> >  	u8 val;
> >  };
> > =20
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio=
/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > index 2f9396745bc8..63e113725499 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > @@ -127,12 +127,12 @@ static const struct st_lsm6dsx_settings st_lsm6ds=
x_sensor_settings[] =3D {
> >  					.addr =3D 0x20,
> >  					.mask =3D GENMASK(7, 5),
> >  				},
> > -				.odr_avl[0] =3D {  10, 0x01 },
> > -				.odr_avl[1] =3D {  50, 0x02 },
> > -				.odr_avl[2] =3D { 119, 0x03 },
> > -				.odr_avl[3] =3D { 238, 0x04 },
> > -				.odr_avl[4] =3D { 476, 0x05 },
> > -				.odr_avl[5] =3D { 952, 0x06 },
> > +				.odr_avl[0] =3D {  100, 0x01 },
> > +				.odr_avl[1] =3D {  500, 0x02 },
> > +				.odr_avl[2] =3D { 1190, 0x03 },
> > +				.odr_avl[3] =3D { 2380, 0x04 },
> > +				.odr_avl[4] =3D { 4760, 0x05 },
> > +				.odr_avl[5] =3D { 9520, 0x06 },
> >  				.odr_len =3D 6,
> >  			},
> >  			[ST_LSM6DSX_ID_GYRO] =3D {
> > @@ -140,12 +140,12 @@ static const struct st_lsm6dsx_settings st_lsm6ds=
x_sensor_settings[] =3D {
> >  					.addr =3D 0x10,
> >  					.mask =3D GENMASK(7, 5),
> >  				},
> > -				.odr_avl[0] =3D {  15, 0x01 },
> > -				.odr_avl[1] =3D {  60, 0x02 },
> > -				.odr_avl[2] =3D { 119, 0x03 },
> > -				.odr_avl[3] =3D { 238, 0x04 },
> > -				.odr_avl[4] =3D { 476, 0x05 },
> > -				.odr_avl[5] =3D { 952, 0x06 },
> > +				.odr_avl[0] =3D {  149, 0x01 },
> > +				.odr_avl[1] =3D {  595, 0x02 },
> > +				.odr_avl[2] =3D { 1190, 0x03 },
> > +				.odr_avl[3] =3D { 2380, 0x04 },
> > +				.odr_avl[4] =3D { 4760, 0x05 },
> > +				.odr_avl[5] =3D { 9520, 0x06 },
> >  				.odr_len =3D 6,
> >  			},
> >  		},
> > @@ -229,12 +229,12 @@ static const struct st_lsm6dsx_settings st_lsm6ds=
x_sensor_settings[] =3D {
> >  					.addr =3D 0x10,
> >  					.mask =3D GENMASK(7, 4),
> >  				},
> > -				.odr_avl[0] =3D {  13, 0x01 },
> > -				.odr_avl[1] =3D {  26, 0x02 },
> > -				.odr_avl[2] =3D {  52, 0x03 },
> > -				.odr_avl[3] =3D { 104, 0x04 },
> > -				.odr_avl[4] =3D { 208, 0x05 },
> > -				.odr_avl[5] =3D { 416, 0x06 },
> > +				.odr_avl[0] =3D {  125, 0x01 },
> > +				.odr_avl[1] =3D {  260, 0x02 },
> > +				.odr_avl[2] =3D {  520, 0x03 },
> > +				.odr_avl[3] =3D { 1040, 0x04 },
> > +				.odr_avl[4] =3D { 2080, 0x05 },
> > +				.odr_avl[5] =3D { 4160, 0x06 },
> >  				.odr_len =3D 6,
> >  			},
> >  			[ST_LSM6DSX_ID_GYRO] =3D {
> > @@ -242,12 +242,12 @@ static const struct st_lsm6dsx_settings st_lsm6ds=
x_sensor_settings[] =3D {
> >  					.addr =3D 0x11,
> >  					.mask =3D GENMASK(7, 4),
> >  				},
> > -				.odr_avl[0] =3D {  13, 0x01 },
> > -				.odr_avl[1] =3D {  26, 0x02 },
> > -				.odr_avl[2] =3D {  52, 0x03 },
> > -				.odr_avl[3] =3D { 104, 0x04 },
> > -				.odr_avl[4] =3D { 208, 0x05 },
> > -				.odr_avl[5] =3D { 416, 0x06 },
> > +				.odr_avl[0] =3D {  125, 0x01 },
> > +				.odr_avl[1] =3D {  260, 0x02 },
> > +				.odr_avl[2] =3D {  520, 0x03 },
> > +				.odr_avl[3] =3D { 1040, 0x04 },
> > +				.odr_avl[4] =3D { 2080, 0x05 },
> > +				.odr_avl[5] =3D { 4160, 0x06 },
> >  				.odr_len =3D 6,
> >  			},
> >  		},
> > @@ -395,12 +395,12 @@ static const struct st_lsm6dsx_settings st_lsm6ds=
x_sensor_settings[] =3D {
> >  					.addr =3D 0x10,
> >  					.mask =3D GENMASK(7, 4),
> >  				},
> > -				.odr_avl[0] =3D {  13, 0x01 },
> > -				.odr_avl[1] =3D {  26, 0x02 },
> > -				.odr_avl[2] =3D {  52, 0x03 },
> > -				.odr_avl[3] =3D { 104, 0x04 },
> > -				.odr_avl[4] =3D { 208, 0x05 },
> > -				.odr_avl[5] =3D { 416, 0x06 },
> > +				.odr_avl[0] =3D {  125, 0x01 },
> > +				.odr_avl[1] =3D {  260, 0x02 },
> > +				.odr_avl[2] =3D {  520, 0x03 },
> > +				.odr_avl[3] =3D { 1040, 0x04 },
> > +				.odr_avl[4] =3D { 2080, 0x05 },
> > +				.odr_avl[5] =3D { 4160, 0x06 },
> >  				.odr_len =3D 6,
> >  			},
> >  			[ST_LSM6DSX_ID_GYRO] =3D {
> > @@ -408,12 +408,12 @@ static const struct st_lsm6dsx_settings st_lsm6ds=
x_sensor_settings[] =3D {
> >  					.addr =3D 0x11,
> >  					.mask =3D GENMASK(7, 4),
> >  				},
> > -				.odr_avl[0] =3D {  13, 0x01 },
> > -				.odr_avl[1] =3D {  26, 0x02 },
> > -				.odr_avl[2] =3D {  52, 0x03 },
> > -				.odr_avl[3] =3D { 104, 0x04 },
> > -				.odr_avl[4] =3D { 208, 0x05 },
> > -				.odr_avl[5] =3D { 416, 0x06 },
> > +				.odr_avl[0] =3D {  125, 0x01 },
> > +				.odr_avl[1] =3D {  260, 0x02 },
> > +				.odr_avl[2] =3D {  520, 0x03 },
> > +				.odr_avl[3] =3D { 1040, 0x04 },
> > +				.odr_avl[4] =3D { 2080, 0x05 },
> > +				.odr_avl[5] =3D { 4160, 0x06 },
> >  				.odr_len =3D 6,
> >  			},
> >  		},
> > @@ -570,12 +570,12 @@ static const struct st_lsm6dsx_settings st_lsm6ds=
x_sensor_settings[] =3D {
> >  					.addr =3D 0x10,
> >  					.mask =3D GENMASK(7, 4),
> >  				},
> > -				.odr_avl[0] =3D {  13, 0x01 },
> > -				.odr_avl[1] =3D {  26, 0x02 },
> > -				.odr_avl[2] =3D {  52, 0x03 },
> > -				.odr_avl[3] =3D { 104, 0x04 },
> > -				.odr_avl[4] =3D { 208, 0x05 },
> > -				.odr_avl[5] =3D { 416, 0x06 },
> > +				.odr_avl[0] =3D {  125, 0x01 },
> > +				.odr_avl[1] =3D {  260, 0x02 },
> > +				.odr_avl[2] =3D {  520, 0x03 },
> > +				.odr_avl[3] =3D { 1040, 0x04 },
> > +				.odr_avl[4] =3D { 2080, 0x05 },
> > +				.odr_avl[5] =3D { 4160, 0x06 },
> >  				.odr_len =3D 6,
> >  			},
> >  			[ST_LSM6DSX_ID_GYRO] =3D {
> > @@ -583,12 +583,12 @@ static const struct st_lsm6dsx_settings st_lsm6ds=
x_sensor_settings[] =3D {
> >  					.addr =3D 0x11,
> >  					.mask =3D GENMASK(7, 4),
> >  				},
> > -				.odr_avl[0] =3D {  13, 0x01 },
> > -				.odr_avl[1] =3D {  26, 0x02 },
> > -				.odr_avl[2] =3D {  52, 0x03 },
> > -				.odr_avl[3] =3D { 104, 0x04 },
> > -				.odr_avl[4] =3D { 208, 0x05 },
> > -				.odr_avl[5] =3D { 416, 0x06 },
> > +				.odr_avl[0] =3D {  125, 0x01 },
> > +				.odr_avl[1] =3D {  260, 0x02 },
> > +				.odr_avl[2] =3D {  520, 0x03 },
> > +				.odr_avl[3] =3D { 1040, 0x04 },
> > +				.odr_avl[4] =3D { 2080, 0x05 },
> > +				.odr_avl[5] =3D { 4160, 0x06 },
> >  				.odr_len =3D 6,
> >  			},
> >  		},
> > @@ -747,12 +747,12 @@ static const struct st_lsm6dsx_settings st_lsm6ds=
x_sensor_settings[] =3D {
> >  					.addr =3D 0x10,
> >  					.mask =3D GENMASK(7, 4),
> >  				},
> > -				.odr_avl[0] =3D {  13, 0x01 },
> > -				.odr_avl[1] =3D {  26, 0x02 },
> > -				.odr_avl[2] =3D {  52, 0x03 },
> > -				.odr_avl[3] =3D { 104, 0x04 },
> > -				.odr_avl[4] =3D { 208, 0x05 },
> > -				.odr_avl[5] =3D { 416, 0x06 },
> > +				.odr_avl[0] =3D {  125, 0x01 },
> > +				.odr_avl[1] =3D {  260, 0x02 },
> > +				.odr_avl[2] =3D {  520, 0x03 },
> > +				.odr_avl[3] =3D { 1040, 0x04 },
> > +				.odr_avl[4] =3D { 2080, 0x05 },
> > +				.odr_avl[5] =3D { 4160, 0x06 },
> >  				.odr_len =3D 6,
> >  			},
> >  			[ST_LSM6DSX_ID_GYRO] =3D {
> > @@ -760,12 +760,12 @@ static const struct st_lsm6dsx_settings st_lsm6ds=
x_sensor_settings[] =3D {
> >  					.addr =3D 0x11,
> >  					.mask =3D GENMASK(7, 4),
> >  				},
> > -				.odr_avl[0] =3D {  13, 0x01 },
> > -				.odr_avl[1] =3D {  26, 0x02 },
> > -				.odr_avl[2] =3D {  52, 0x03 },
> > -				.odr_avl[3] =3D { 104, 0x04 },
> > -				.odr_avl[4] =3D { 208, 0x05 },
> > -				.odr_avl[5] =3D { 416, 0x06 },
> > +				.odr_avl[0] =3D {  125, 0x01 },
> > +				.odr_avl[1] =3D {  260, 0x02 },
> > +				.odr_avl[2] =3D {  520, 0x03 },
> > +				.odr_avl[3] =3D { 1040, 0x04 },
> > +				.odr_avl[4] =3D { 2080, 0x05 },
> > +				.odr_avl[5] =3D { 4160, 0x06 },
> >  				.odr_len =3D 6,
> >  			},
> >  		},
> > @@ -944,12 +944,12 @@ static const struct st_lsm6dsx_settings st_lsm6ds=
x_sensor_settings[] =3D {
> >  					.addr =3D 0x10,
> >  					.mask =3D GENMASK(7, 4),
> >  				},
> > -				.odr_avl[0] =3D {  13, 0x01 },
> > -				.odr_avl[1] =3D {  26, 0x02 },
> > -				.odr_avl[2] =3D {  52, 0x03 },
> > -				.odr_avl[3] =3D { 104, 0x04 },
> > -				.odr_avl[4] =3D { 208, 0x05 },
> > -				.odr_avl[5] =3D { 416, 0x06 },
> > +				.odr_avl[0] =3D {  125, 0x01 },
> > +				.odr_avl[1] =3D {  260, 0x02 },
> > +				.odr_avl[2] =3D {  520, 0x03 },
> > +				.odr_avl[3] =3D { 1040, 0x04 },
> > +				.odr_avl[4] =3D { 2080, 0x05 },
> > +				.odr_avl[5] =3D { 4160, 0x06 },
> >  				.odr_len =3D 6,
> >  			},
> >  			[ST_LSM6DSX_ID_GYRO] =3D {
> > @@ -957,12 +957,12 @@ static const struct st_lsm6dsx_settings st_lsm6ds=
x_sensor_settings[] =3D {
> >  					.addr =3D 0x11,
> >  					.mask =3D GENMASK(7, 4),
> >  				},
> > -				.odr_avl[0] =3D {  13, 0x01 },
> > -				.odr_avl[1] =3D {  26, 0x02 },
> > -				.odr_avl[2] =3D {  52, 0x03 },
> > -				.odr_avl[3] =3D { 104, 0x04 },
> > -				.odr_avl[4] =3D { 208, 0x05 },
> > -				.odr_avl[5] =3D { 416, 0x06 },
> > +				.odr_avl[0] =3D {  125, 0x01 },
> > +				.odr_avl[1] =3D {  260, 0x02 },
> > +				.odr_avl[2] =3D {  520, 0x03 },
> > +				.odr_avl[3] =3D { 1040, 0x04 },
> > +				.odr_avl[4] =3D { 2080, 0x05 },
> > +				.odr_avl[5] =3D { 4160, 0x06 },
> >  				.odr_len =3D 6,
> >  			},
> >  		},
> > @@ -1121,12 +1121,12 @@ static const struct st_lsm6dsx_settings st_lsm6=
dsx_sensor_settings[] =3D {
> >  					.addr =3D 0x10,
> >  					.mask =3D GENMASK(7, 4),
> >  				},
> > -				.odr_avl[0] =3D {  13, 0x01 },
> > -				.odr_avl[1] =3D {  26, 0x02 },
> > -				.odr_avl[2] =3D {  52, 0x03 },
> > -				.odr_avl[3] =3D { 104, 0x04 },
> > -				.odr_avl[4] =3D { 208, 0x05 },
> > -				.odr_avl[5] =3D { 416, 0x06 },
> > +				.odr_avl[0] =3D {  125, 0x01 },
> > +				.odr_avl[1] =3D {  260, 0x02 },
> > +				.odr_avl[2] =3D {  520, 0x03 },
> > +				.odr_avl[3] =3D { 1040, 0x04 },
> > +				.odr_avl[4] =3D { 2080, 0x05 },
> > +				.odr_avl[5] =3D { 4160, 0x06 },
> >  				.odr_len =3D 6,
> >  			},
> >  			[ST_LSM6DSX_ID_GYRO] =3D {
> > @@ -1134,12 +1134,12 @@ static const struct st_lsm6dsx_settings st_lsm6=
dsx_sensor_settings[] =3D {
> >  					.addr =3D 0x11,
> >  					.mask =3D GENMASK(7, 4),
> >  				},
> > -				.odr_avl[0] =3D {  13, 0x01 },
> > -				.odr_avl[1] =3D {  26, 0x02 },
> > -				.odr_avl[2] =3D {  52, 0x03 },
> > -				.odr_avl[3] =3D { 104, 0x04 },
> > -				.odr_avl[4] =3D { 208, 0x05 },
> > -				.odr_avl[5] =3D { 416, 0x06 },
> > +				.odr_avl[0] =3D {  125, 0x01 },
> > +				.odr_avl[1] =3D {  260, 0x02 },
> > +				.odr_avl[2] =3D {  520, 0x03 },
> > +				.odr_avl[3] =3D { 1040, 0x04 },
> > +				.odr_avl[4] =3D { 2080, 0x05 },
> > +				.odr_avl[5] =3D { 4160, 0x06 },
> >  				.odr_len =3D 6,
> >  			},
> >  		},
> > @@ -1475,7 +1475,7 @@ static int st_lsm6dsx_read_oneshot(struct st_lsm6=
dsx_sensor *sensor,
> >  	if (err < 0)
> >  		return err;
> > =20
> > -	delay =3D 1000000 / sensor->odr;
> > +	delay =3D 10000000 / sensor->odr;
> >  	usleep_range(delay, 2 * delay);
> > =20
> >  	err =3D st_lsm6dsx_read_locked(hw, addr, &data, sizeof(data));
> > @@ -1507,8 +1507,9 @@ static int st_lsm6dsx_read_raw(struct iio_dev *ii=
o_dev,
> >  		iio_device_release_direct_mode(iio_dev);
> >  		break;
> >  	case IIO_CHAN_INFO_SAMP_FREQ:
> > -		*val =3D sensor->odr;
> > -		ret =3D IIO_VAL_INT;
> > +		*val =3D sensor->odr / 10;
> > +		*val2 =3D (sensor->odr % 10) * 100000;
> > +		ret =3D IIO_VAL_INT_PLUS_MICRO;
> >  		break;
> >  	case IIO_CHAN_INFO_SCALE:
> >  		*val =3D 0;
> > @@ -1541,6 +1542,7 @@ static int st_lsm6dsx_write_raw(struct iio_dev *i=
io_dev,
> >  	case IIO_CHAN_INFO_SAMP_FREQ: {
> >  		u8 data;
> > =20
> > +		val =3D val * 10 + val2 / 100000;
> >  		val =3D st_lsm6dsx_check_odr(sensor, val, &data);
> >  		if (val < 0)
> >  			err =3D val;
> > @@ -1730,8 +1732,9 @@ st_lsm6dsx_sysfs_sampling_frequency_avail(struct =
device *dev,
> > =20
> >  	odr_table =3D &sensor->hw->settings->odr_table[sensor->id];
> >  	for (i =3D 0; i < odr_table->odr_len; i++)
> > -		len +=3D scnprintf(buf + len, PAGE_SIZE - len, "%d ",
> > -				 odr_table->odr_avl[i].hz);
> > +		len +=3D scnprintf(buf + len, PAGE_SIZE - len, "%d.%d ",
> > +				 odr_table->odr_avl[i].hz / 10,
> > +				 odr_table->odr_avl[i].hz % 10);
> >  	buf[len - 1] =3D '\n';
> > =20
> >  	return len;
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio=
/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> > index e029cc05a17f..c3b124a73815 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> > @@ -51,10 +51,10 @@ static const struct st_lsm6dsx_ext_dev_settings st_=
lsm6dsx_ext_dev_table[] =3D {
> >  				.addr =3D 0x60,
> >  				.mask =3D GENMASK(3, 2),
> >  			},
> > -			.odr_avl[0] =3D {  10, 0x0 },
> > -			.odr_avl[1] =3D {  20, 0x1 },
> > -			.odr_avl[2] =3D {  50, 0x2 },
> > -			.odr_avl[3] =3D { 100, 0x3 },
> > +			.odr_avl[0] =3D {  100, 0x0 },
> > +			.odr_avl[1] =3D {  200, 0x1 },
> > +			.odr_avl[2] =3D {  500, 0x2 },
> > +			.odr_avl[3] =3D { 1000, 0x3 },
> >  			.odr_len =3D 4,
> >  		},
> >  		.fs_table =3D {
> > @@ -97,8 +97,8 @@ static void st_lsm6dsx_shub_wait_complete(struct st_l=
sm6dsx_hw *hw)
> >  	u16 odr;
> > =20
> >  	sensor =3D iio_priv(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
> > -	odr =3D (hw->enable_mask & BIT(ST_LSM6DSX_ID_ACC)) ? sensor->odr : 13;
> > -	msleep((2000U / odr) + 1);
> > +	odr =3D (hw->enable_mask & BIT(ST_LSM6DSX_ID_ACC)) ? sensor->odr : 12=
5;
> > +	msleep((20000U / odr) + 1);
> >  }
> > =20
> >  /**
> > @@ -442,7 +442,7 @@ st_lsm6dsx_shub_read_oneshot(struct st_lsm6dsx_sens=
or *sensor,
> >  	if (err < 0)
> >  		return err;
> > =20
> > -	delay =3D 1000000 / sensor->odr;
> > +	delay =3D 10000000 / sensor->odr;
> >  	usleep_range(delay, 2 * delay);
> > =20
> >  	len =3D min_t(int, sizeof(data), ch->scan_type.realbits >> 3);
> > @@ -482,8 +482,9 @@ st_lsm6dsx_shub_read_raw(struct iio_dev *iio_dev,
> >  		iio_device_release_direct_mode(iio_dev);
> >  		break;
> >  	case IIO_CHAN_INFO_SAMP_FREQ:
> > -		*val =3D sensor->odr;
> > -		ret =3D IIO_VAL_INT;
> > +		*val =3D sensor->odr / 10;
> > +		*val2 =3D (sensor->odr % 10) * 100000;
> > +		ret =3D IIO_VAL_INT_PLUS_MICRO;
> >  		break;
> >  	case IIO_CHAN_INFO_SCALE:
> >  		*val =3D 0;
> > @@ -514,6 +515,7 @@ st_lsm6dsx_shub_write_raw(struct iio_dev *iio_dev,
> >  	case IIO_CHAN_INFO_SAMP_FREQ: {
> >  		u16 data;
> > =20
> > +		val =3D val * 10 + val2 / 100000;
> >  		err =3D st_lsm6dsx_shub_get_odr_val(sensor, val, &data);
> >  		if (!err)
> >  			sensor->odr =3D val;
> > @@ -542,7 +544,8 @@ st_lsm6dsx_shub_sampling_freq_avail(struct device *=
dev,
> >  	for (i =3D 0; i < settings->odr_table.odr_len; i++) {
> >  		u16 val =3D settings->odr_table.odr_avl[i].hz;
> > =20
> > -		len +=3D scnprintf(buf + len, PAGE_SIZE - len, "%d ", val);
> > +		len +=3D scnprintf(buf + len, PAGE_SIZE - len, "%d.%d ",
> > +				 val / 10, val % 10);
> >  	}
> >  	buf[len - 1] =3D '\n';
> > =20
>=20

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXb7Q7QAKCRA6cBh0uS2t
rEKIAP9ekaVKRsT/RYzTYwZzrdeXM4QebPCDu/6MjBTZiCkh6gD/Tomn7FEh4OpH
39+eaiL1c8pJQq50FNSDWQDNmdaJXwc=
=TjCJ
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
