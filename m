Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9284E1A339F
	for <lists+linux-iio@lfdr.de>; Thu,  9 Apr 2020 13:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgDIL6R (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 Apr 2020 07:58:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:57134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbgDIL6Q (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 9 Apr 2020 07:58:16 -0400
Received: from lore-desk-wlan (unknown [151.48.151.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B826B20A8B;
        Thu,  9 Apr 2020 11:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586433496;
        bh=ooTd+UBBWpk++UBZK9EBlEZdaZXEOaguROOwmmWujz8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wwQJcmsUa+4AHL/APhDJnFmTKwdXdHgBdZYejeyK777h4w11LnK9JhiAC/FWf2JYy
         K8yQVey+mwwc+aSERFrihJWRmosBglgjIGXYFrGw/zppvrSH+t5juTypjV5Ztl9hH7
         l/Ohk4eAUBqmsXidsOri8tPwOL+k4/K6sse4BweU=
Date:   Thu, 9 Apr 2020 13:58:10 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Alexandre Bard <alexandre.bard@netmodule.com>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        lorenzo.bianconi83@gmail.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: Fix reading array out of bounds
Message-ID: <20200409115810.GA6385@lore-desk-wlan>
References: <20200409085818.9533-1-alexandre.bard@netmodule.com>
 <20200409110128.GA53758@gerhold.net>
 <3954c87f-ffcd-69ab-06b9-0615fbd85c71@netmodule.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
In-Reply-To: <3954c87f-ffcd-69ab-06b9-0615fbd85c71@netmodule.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Le 09.04.20 =E0 13:01, Stephan Gerhold a =E9crit=A0:
> > On Thu, Apr 09, 2020 at 10:58:18AM +0200, Alexandre Bard wrote:
> >> Former code was iterating through all possible IDs whereas only a few
> >> per settings array are really available. Leading to several out of
> >> bounds readings.
> >>
> >> Line is now longer than 80 characters. But since it is a classic for
> >> loop I think it is better to keep it like this than splitting it.
> >>
> >> Signed-off-by: Alexandre Bard <alexandre.bard@netmodule.com>
> >> ---
> >>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/ii=
o/imu/st_lsm6dsx/st_lsm6dsx_core.c
> >> index 84d219ae6aee..be8882ff30eb 100644
> >> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> >> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> >> @@ -1350,7 +1350,7 @@ static int st_lsm6dsx_check_whoami(struct st_lsm=
6dsx_hw *hw, int id,
> >>  	int err, i, j, data;
> >> =20
> >>  	for (i =3D 0; i < ARRAY_SIZE(st_lsm6dsx_sensor_settings); i++) {
> >> -		for (j =3D 0; j < ST_LSM6DSX_MAX_ID; j++) {
> >> +		for (j =3D 0; j < ARRAY_SIZE(st_lsm6dsx_sensor_settings[i].id); j++=
) {
> > id in st_lsm6dsx_settings is declared as:
> >
> > 	struct {
> > 		enum st_lsm6dsx_hw_id hw_id;
> > 		const char *name;
> > 	} id[ST_LSM6DSX_MAX_ID];
> >
> > so it's always ST_LSM6DSX_MAX_ID long
> > (additional entries are just zero-initialized).
> >
> > Isn't ARRAY_SIZE(st_lsm6dsx_sensor_settings[i].id) =3D=3D ST_LSM6DSX_MA=
X_ID
> > in this case?
> Yes, you are right, I missed that. But there is still a problem :
> parsing 0-initialized fields can lead to a false positive when looking fo=
r the
> value ST_LSM6DS3_ID which is the first element of an enum. So either the =
enum
> must be patched to start at 1 or the length of valid ids in a settings mu=
st be
> retrieved somehow.

for un-initialized entries st_lsm6dsx_sensor_settings[i].id[j].name will be=
 NULL
so I guess there is no issue there. Am I missing something?

Regards,
Lorenzo

>=20
> Or is there another way ? Or am I wrong ?
> >
> >>  			if (st_lsm6dsx_sensor_settings[i].id[j].name &&
> >>  			    id =3D=3D st_lsm6dsx_sensor_settings[i].id[j].hw_id)
> >>  				break;
> >> --=20
> >> 2.20.1
> >>

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXo8N0AAKCRA6cBh0uS2t
rEhbAP4hOkUV1tFOaJ1KZKlI30ScfFUzeewGnizNLC+QxsJ/EQD+N9RE5wdDhMVo
Js4G4UaXMH8t4NzFxxDnRvE7hHFkDQo=
=gVAa
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
