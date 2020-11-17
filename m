Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D70752B69C5
	for <lists+linux-iio@lfdr.de>; Tue, 17 Nov 2020 17:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgKQQR5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Nov 2020 11:17:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:46244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726854AbgKQQR5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 17 Nov 2020 11:17:57 -0500
Received: from localhost (unknown [151.66.8.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45DFB20897;
        Tue, 17 Nov 2020 16:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605629876;
        bh=hy16ffRPWMRaQuWUaBmTQjp1UvwrgSDxEHy0QZMekS8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qZ97cIHfIDl1Sk7p70Ql0/Pu7m3g7of0zkDJyMfqpI868jJxFf9QeFS+YTdaSOvaN
         FFJR+0EaJAI+iOLY+ajhpa6DhGTZv53SY/MmWXG9z/i8WZKIs31oqyBonLLpVOnRyw
         Dov/wBkQe5c34RmzDA0TingQKK1x+O1kiNTCU5E4=
Date:   Tue, 17 Nov 2020 17:17:51 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     jic23@kernel.org, lorenzo.bianconi@redhat.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: iio: imu: st_lsm6dsx: introduce
 vdd-vddio regulators bindings
Message-ID: <20201117161751.GC149198@lore-desk>
References: <cover.1605625579.git.lorenzo@kernel.org>
 <fd692095f2cdda5a99327f57e69c34a4ffce232f.1605625579.git.lorenzo@kernel.org>
 <20201117160618.00003807@Huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/e2eDi0V/xtL+Mc8"
Content-Disposition: inline
In-Reply-To: <20201117160618.00003807@Huawei.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--/e2eDi0V/xtL+Mc8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Tue, 17 Nov 2020 16:11:38 +0100
> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt | 4 ++++
> >  1 file changed, 4 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt b=
/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
> > index 7c6742d3e992..bc3448df9647 100644
> > --- a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
> > +++ b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
> > @@ -20,6 +20,10 @@ Required properties:
> >  - reg: i2c address of the sensor / spi cs line
> > =20
> >  Optional properties:
> > +- vdd-supply: an optional regulator that needs to be on to provide VDD
> > +  power to the sensor.
> > +- vddio-supply: an optional regulator that needs to be on to provide t=
he
> > +  VDD IO power to the sensor.
> >  - st,drdy-int-pin: the pin on the package that will be used to signal
> >    "data ready" (valid values: 1 or 2).
> >  - st,pullups : enable/disable internal i2c controller pullup resistors.
>=20
> Hi Lorenzo,
>=20
> Please could you rebase this on top of=20
> https://lore.kernel.org/linux-iio/20201031184854.745828-13-jic23@kernel.o=
rg/
>=20
> Which does a yaml conversion of this file.

Hi Jonathan,

sure, no worries. I was quite sure the yaml conversion was merged but then I
discovered it was not :) I will post v2 soon.

Regards,
Lorenzo

>=20
> I'm working my way through backlog of those this week so will pick that up
> at some point very soon.
>=20
> I'll resend a v2 of some patches in those series, but only those where th=
ere
> are outstanding comments that aren't trivial.
>=20
> (Rob's acked most with a few requested tweaks).
>=20
> Thanks,
>=20
> Jonathan

--/e2eDi0V/xtL+Mc8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCX7P3rQAKCRA6cBh0uS2t
rB4MAQDS5p9xXBz0f8bv3d+jrB8v75pPz2reYxbVgi8PgloWiAD/XB7xLSjIWivi
xXe2z1mVKtxDUknDJGo4ND1dCbQ7zgw=
=Yxs6
-----END PGP SIGNATURE-----

--/e2eDi0V/xtL+Mc8--
