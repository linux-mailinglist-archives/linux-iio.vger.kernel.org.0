Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCB72428A1C
	for <lists+linux-iio@lfdr.de>; Mon, 11 Oct 2021 11:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235573AbhJKJt2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Oct 2021 05:49:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:43520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235539AbhJKJt2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 11 Oct 2021 05:49:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B370260D07;
        Mon, 11 Oct 2021 09:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633945648;
        bh=vB/8tYwO/Zfs45j4rAaUI7XHZeBWjc49gNuQjGutcoU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=coJ5KbQZlymBO0G8Sbc6a5iqQnWrSlhnuEkEUvudOmeny2EN0Y/KeRxdBULIqHoGz
         C9WqO/tQo9K+krtq4wexsUJWZU3HIl76U5tEb/AfQwUEe0TMHIRb1ZvoRTUOWFOxov
         8pkMQ/pwhG2cA9JBkyJDfIY7RKM/JcXepvIr9LIOLmZMpeAIBP7H2sU55k/D1rrXb8
         vnjC7LOj1lV1im+UCNGARZJ0j68QfL2G5f0ElsNQKtzEEGFE1goTagsQdKJRI1oB5B
         EI+15FZAiZBHbL90r69f400MVcuIuiba8icA+wpf8B4yb4kabo44hPpz0goAyjnL6z
         zLiXbUxQTcHvA==
Date:   Mon, 11 Oct 2021 11:47:24 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Teng Qi <starmiku1207184332@gmail.com>,
        lorenzo.bianconi83@gmail.com, jic23@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        islituo@gmail.com, baijiaju1990@gmail.com,
        TOTE Robot <oslab@tsinghua.edu.cn>
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: Fix an array overflow in
 st_lsm6dsx_set_odr()
Message-ID: <YWQILPRHZw2BsAYu@lore-desk>
References: <20211010091230.895549-1-starmiku1207184332@gmail.com>
 <8efeaffd-ae9a-d0ef-0222-6c94c0e31e7e@metafoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gLTk5hY2TkhJnKDu"
Content-Disposition: inline
In-Reply-To: <8efeaffd-ae9a-d0ef-0222-6c94c0e31e7e@metafoo.de>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--gLTk5hY2TkhJnKDu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 10/10/21 11:12 AM, Teng Qi wrote:
> > The length of hw->settings->odr_table is 2 and ref_sensor->id is an enum
> > variable whose value is between 0 and 5.
> > However, the value ST_LSM6DSX_ID_MAX (i.e. 5) is not catched properly in
> >   switch (sensor->id) {
> >=20
> > If ref_sensor->id is ST_LSM6DSX_ID_MAX, an array overflow will ocurrs in
> > function st_lsm6dsx_check_odr():
> >    odr_table =3D &sensor->hw->settings->odr_table[sensor->id];
> >=20
> > and in function st_lsm6dsx_set_odr():
> >    reg =3D &hw->settings->odr_table[ref_sensor->id].reg;
> >=20
> > To fix this possible array overflow, ref_sensor->id should be checked
> > first. If it is greater than or equal to 2, the function
> > st_lsm6dsx_set_odr() returns -EINVAL.
> >=20
> > Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
> > Signed-off-by: Teng Qi <starmiku1207184332@gmail.com>
>=20
> Hi,
>=20
> Thanks for the patch, good catch. But there are a few things to improve
> here, the goal should not be to silence the output of your checker, but to
> write good code.
>=20
> Let's start with ST_LSM6DSX_ID_MAX. As the name suggests this is an entry=
 at
> the end of the enum that is used to get the size of the enum. But its val=
ue
> itself is never assigned to any variable of that type. This is a very com=
mon
> pattern. So strictly speaking there is no bug, since the out-of-range val=
ue
> of ST_LSM6DSX_ID_MAX is never used.
>=20
> The other thing is that we usually don't want to hardcode range checks for
> array sizes with integer literals, but rather use ARRAY_SIZE() instead. T=
his
> makes sure that the code stays correct when the array size changes.
>=20
> If you really wanted to modify the code sot that your code checker does n=
ot
> detect a false positive I'd modify the switch statement to explicitly han=
dle
> ST_LSM6DSX_ID_GYRO and ST_LSM6DSX_ID_ACCEL and the return an error for the
> default case with a comment that default case should never occur.

+1 :)

Regards,
Lorenzo

>=20
> - Lars
>=20
> > ---
> >   drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> >=20
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio=
/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > index db45f1fc0b81..edf5d33dd256 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > @@ -1308,6 +1308,10 @@ st_lsm6dsx_set_odr(struct st_lsm6dsx_sensor *sen=
sor, u32 req_odr)
> >   		break;
> >   	}
> > +	if (ref_sensor->id >=3D 2) {
> > +		return -EINVAL;
> > +	}
> > +
> >   	if (req_odr > 0) {
> >   		err =3D st_lsm6dsx_check_odr(ref_sensor, req_odr, &val);
> >   		if (err < 0)
>=20
>=20

--gLTk5hY2TkhJnKDu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYWQILAAKCRA6cBh0uS2t
rB6iAQCIGK44O0mznjUHIz1nfCz74dh/KY7G2nH0FupurFNatwD7BaTRDpzoNjdX
oV4e2lPCW+wy7PU1cXyPRA7hWIz/3AQ=
=Vtt3
-----END PGP SIGNATURE-----

--gLTk5hY2TkhJnKDu--
