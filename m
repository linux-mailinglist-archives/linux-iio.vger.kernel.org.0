Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED03A9CB75
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2019 10:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730516AbfHZIW1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Aug 2019 04:22:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:41600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729690AbfHZIW0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 26 Aug 2019 04:22:26 -0400
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CBC52080C;
        Mon, 26 Aug 2019 08:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566807746;
        bh=gg8GCKZkgqNgqCvquwJAWk3Wae/scpxmraZjw5clvW8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t9u4UhI6QYsCahNjwHbQ8ib1MvU0/crUiEuC58xG8VzqNGZLKCfGXUftfcPufy3hm
         my8OM/cBt4fy015NFns48apfp3qzTgM7BfujGjUV3KFHVU/suhli477EZkdUR1YuDZ
         TK75VjYcubRhSswuhTJbdkLAAKimGxmaCkQKccRE=
Date:   Mon, 26 Aug 2019 10:22:20 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Mario Tesi <martepisa@gmail.com>, lorenzo.bianconi83@gmail.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mario.tesi@st.com
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: Fix FIFO diff mask for tagged fifo
Message-ID: <20190826082220.GA5328@localhost.localdomain>
References: <1566480139-4015-1-git-send-email-martepisa@gmail.com>
 <20190826091537.66e07ec9@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
In-Reply-To: <20190826091537.66e07ec9@archlinux>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, 22 Aug 2019 15:22:19 +0200
> Mario Tesi <martepisa@gmail.com> wrote:
>=20
> > From: mario tesi <mario.tesi@st.com>
> >=20
> > 	According to the latest version of datasheet the mask
> > 	for number of unread sensor data in FIFO_STATUS registers
> > 	has been extended to 10 bits
> >=20
> > 	The devices involved are:
> > 	 - LSM6DSO
> > 	 - LSM6DSOX
> > 	 - ASM330LHH
> > 	 - LSM6DSR
> > 	 - ISM330DHCX
> >=20
> > Signed-off-by: mario tesi <mario.tesi@st.com>
>=20
> Seems straight forward and should be side effect free I think.
> Hence I won't wait for Lorenzo to take a look (though there
> is still a small window for comments whilst the autobuilders
> poke at it!)
>=20
> Applied to the togreg branch of iio.git and pushed out as testing
> for the autobuilders to take a look.
>=20
> Thanks,

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

>=20
> Jonathan
>=20
> > ---
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio=
/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > index 85824d6..47b77d0 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > @@ -497,7 +497,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_=
sensor_settings[] =3D {
> >  			},
> >  			.fifo_diff =3D {
> >  				.addr =3D 0x3a,
> > -				.mask =3D GENMASK(8, 0),
> > +				.mask =3D GENMASK(9, 0),
> >  			},
> >  			.th_wl =3D 1,
> >  		},
> > @@ -623,7 +623,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_=
sensor_settings[] =3D {
> >  			},
> >  			.fifo_diff =3D {
> >  				.addr =3D 0x3a,
> > -				.mask =3D GENMASK(8, 0),
> > +				.mask =3D GENMASK(9, 0),
> >  			},
> >  			.th_wl =3D 1,
> >  		},
> > @@ -726,7 +726,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_=
sensor_settings[] =3D {
> >  			},
> >  			.fifo_diff =3D {
> >  				.addr =3D 0x3a,
> > -				.mask =3D GENMASK(8, 0),
> > +				.mask =3D GENMASK(9, 0),
> >  			},
> >  			.th_wl =3D 1,
> >  		},
>=20

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXWOWuQAKCRA6cBh0uS2t
rOxUAP9PeGCm1kbLypWdOkwk9Nx86J99Fvt1iC/qqFEpTv6BUgEA1WuXpNgvVpU/
VqBWhhSjSfKCPalEUdykSO7e1pSS4Q0=
=y/uL
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
