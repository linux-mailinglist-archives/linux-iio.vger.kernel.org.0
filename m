Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0CDF11AD12
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2019 15:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729664AbfLKOKK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Dec 2019 09:10:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:53612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729513AbfLKOKK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 11 Dec 2019 09:10:10 -0500
Received: from localhost.localdomain (unknown [66.187.232.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7CBF214AF;
        Wed, 11 Dec 2019 14:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576073409;
        bh=tFcLqDQ+66duBKfGDT2fvei57EUZv7U5MiDnvVO01W0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U2p1Kij+l9/yXQ1rh/ckqSEaeod0iMpSqPEDUICMgeBQpG6bfNZE0lC87MHzg1hK3
         Nf+sJe5m0jtmv6XWk8C0LDn/lR5I06M6jsJ582BaYSbUaFnRBREMgz3FQlAWSxLA1j
         VWXgfIyfDLGdf7TDQ2fRYIxuREuUTiLGvLssegDE=
Date:   Wed, 11 Dec 2019 15:10:06 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: Fix selection of ST_LSM6DS3_ID
Message-ID: <20191211141006.GA3779@localhost.localdomain>
References: <20191209170541.198206-1-stephan@gerhold.net>
 <20191209214852.GA2485@localhost.localdomain>
 <20191210082253.GA867@gerhold.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
In-Reply-To: <20191210082253.GA867@gerhold.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, Dec 09, 2019 at 10:48:52PM +0100, Lorenzo Bianconi wrote:
> > > At the moment, attempting to probe a device with ST_LSM6DS3_ID
> > > (e.g. using the st,lsm6ds3 compatible) fails with:
> > >=20
> > >     st_lsm6dsx_i2c 1-006b: unsupported whoami [69]
> > >=20
> > > ... even though 0x69 is the whoami listed for ST_LSM6DS3_ID.
> > >=20
> >=20
> > Hi Stephan,
> >=20
> > thx for working on this. I guess we can skip 'void' iterations defining=
 the
> > array real size, do you agree?
> >=20
>=20
> I'm not sure I understand you correctly.
> Do you mean having something like:
>=20
> struct st_lsm6dsx_settings {
> 	u8 wai;
> 	/* ... */
> 	struct {
> 		enum st_lsm6dsx_hw_id hw_id;
> 		const char *name;
> 	} id[ST_LSM6DSX_MAX_ID];
> 	int id_num; /* Add this field */
> 	/* ... */
> };
>=20
> And then change the loop to use .id_num instead?
>=20
> I think it is pretty easy to forget to update "id_num"
> when adding new entries. Right now there is no need to worry about that.

Uhm..this approach is even more safe if someone forgets to set name for a g=
iven
device. So for the patch:

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

Regards,
Lorenzo

>=20
> Thanks,
> Stephan
>=20
> > Regards,
> > Lorenzo
> >=20
> > > This happens because st_lsm6dsx_check_whoami() also attempts
> > > to match unspecified (zero-initialized) entries in the "id" array.
> > > ST_LSM6DS3_ID =3D 0 will therefore match any entry in
> > > st_lsm6dsx_sensor_settings (here: the first), because none of them
> > > actually have all 12 entries listed in the "id" array.
> > >=20
> > > Avoid this by additionally checking if "name" is set,
> > > which is only set for valid entries in the "id" array.
> > >=20
> > > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> > > ---
> > >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/i=
io/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > index a7d40c02ce6b..b921dd9e108f 100644
> > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > @@ -1301,7 +1301,8 @@ static int st_lsm6dsx_check_whoami(struct st_ls=
m6dsx_hw *hw, int id,
> > > =20
> > >  	for (i =3D 0; i < ARRAY_SIZE(st_lsm6dsx_sensor_settings); i++) {
> > >  		for (j =3D 0; j < ST_LSM6DSX_MAX_ID; j++) {
> > > -			if (id =3D=3D st_lsm6dsx_sensor_settings[i].id[j].hw_id)
> > > +			if (st_lsm6dsx_sensor_settings[i].id[j].name &&
> > > +			    id =3D=3D st_lsm6dsx_sensor_settings[i].id[j].hw_id)
> > >  				break;
> > >  		}
> > >  		if (j < ST_LSM6DSX_MAX_ID)
> > > --=20
> > > 2.24.0
> > >=20
>=20
>=20

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXfD4uwAKCRA6cBh0uS2t
rLVgAQCg4H3E6AhGwuXapLfEqTRrMDk4Jasyn0qvPUmDsKOoygD/TImhsmqF3bLU
RlRUUI62+wm5K12qetW7KDA6DkUm+g0=
=kk1/
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
