Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B89317E326
	for <lists+linux-iio@lfdr.de>; Mon,  9 Mar 2020 16:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgCIPKn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Mar 2020 11:10:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:51880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbgCIPKn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 9 Mar 2020 11:10:43 -0400
Received: from lore-desk-wlan (unknown [151.48.128.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C444C208C3;
        Mon,  9 Mar 2020 15:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583766642;
        bh=D9PfhpZg80tBUUBBAOVqeKWsTaR3zO4OGE4YvIt29Dk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R4D/VBryayGl+rIuZDieXiry3Y1SbH9FE012rfJmuX9C8FM4gPZtsfSVreOkaOvFy
         vAsK724xPvze5sCuzmDc6lmBydlofTKVhUE/HWddvS/veNFZGfYqruMzWmuE0m9cKX
         B515/PrS6vFmOaRUxfOTWO0qRCmeHOB44ZD0YuAg=
Date:   Mon, 9 Mar 2020 16:10:35 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Vitor Soares <Vitor.Soares@synopsys.com>
Cc:     "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lorenzo.bianconi@redhat.com" <lorenzo.bianconi@redhat.com>,
        "mario.tesi@st.com" <mario.tesi@st.com>
Subject: Re: [PATCH v2] iio: imu: st_lsm6dsx: disable I3C support during
 device reset
Message-ID: <20200309151035.GC490054@lore-desk-wlan>
References: <c4591fcbbb63c9280532e43b39c4f96323f321c2.1583625699.git.lorenzo@kernel.org>
 <CH2PR12MB4216C6B0B5922780FB13B902AEFE0@CH2PR12MB4216.namprd12.prod.outlook.com>
 <20200309150101.GB490054@lore-desk-wlan>
 <CH2PR12MB421655D9F6A060E4199AC6CDAEFE0@CH2PR12MB4216.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zCKi3GIZzVBPywwA"
Content-Disposition: inline
In-Reply-To: <CH2PR12MB421655D9F6A060E4199AC6CDAEFE0@CH2PR12MB4216.namprd12.prod.outlook.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--zCKi3GIZzVBPywwA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Lorenzo Bianconi <lorenzo@kernel.org>
> Date: Mon, Mar 09, 2020 at 15:01:01
>=20
> > > Hi Lorenzo,
> > >=20
> > > From: Lorenzo Bianconi <lorenzo@kernel.org>
> > > Date: Sun, Mar 08, 2020 at 00:06:03
> > >=20
> > > > Disable MIPI I3C during device reset in order to avoid
> > > > possible races on interrupt line 1. If the first interrupt
> > > > line is asserted during hw reset the device will work in
> > > > I3C-only mode
> > > >=20
> >=20
> > [...]
> >=20
> > > > +
> > >=20
> > > After disable the i3c interface the dynamic address is no more access=
ible=20
> > > and fails the initialization.
> > >=20
> >=20
> > Hi Vitor,
> >=20
> > thx for testing it. What do you mean here?
> > Is int1 set to vdd in your test?
> >=20
> > Regards,
> > Lorenzo
>=20
> Yes, according with figure 14 of lsm6dso datasheet.

uhm..probably we should do this configuration if the device is not in I3C-o=
nly
mode. Are you able to test it without setting the int1 to vdd?
Unfortunately I have no devices with an I3C controller yet.

Regards,
Lorenzo

>=20
> Is there any way to clear the INT1 before the hw reset?
>=20
> Best regards,
> Vitor Soares
>=20
> >=20
> > > Best regards,
> > > Vitor Soares
> > >=20
> > > >  	/* device sw reset */
> > > >  	reg =3D &hw->settings->reset;
> > > >  	err =3D regmap_update_bits(hw->regmap, reg->addr, reg->mask,
> > > > @@ -2059,6 +2081,15 @@ static int st_lsm6dsx_init_device(struct st_=
lsm6dsx_hw *hw)
> > > > =20
> > > >  	msleep(50);
> > > > =20
> > > > +	/* enable MIPI I3C */
> > > > +	if (hw->settings->i3c_disable.addr) {
> > > > +		reg =3D &hw->settings->i3c_disable;
> > > > +		err =3D regmap_update_bits(hw->regmap, reg->addr, reg->mask,
> > > > +					 ST_LSM6DSX_SHIFT_VAL(0, reg->mask));
> > > > +		if (err < 0)
> > > > +			return err;
> > > > +	}
> > > > +
> > > >  	/* enable Block Data Update */
> > > >  	reg =3D &hw->settings->bdu;
> > > >  	err =3D regmap_update_bits(hw->regmap, reg->addr, reg->mask,
> > > > --=20
> > > > 2.24.1
> > >=20
> > >=20
>=20
>=20

--zCKi3GIZzVBPywwA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXmZcZwAKCRA6cBh0uS2t
rHSVAQCvHaz3khF9mnBdft2wlHhlmei8uZvSHNZO31tYw2+0TwD/RswIFaRsUAJh
VxLWY/7DIqtJExUe/qBggyLuYp7y2Q0=
=O9YU
-----END PGP SIGNATURE-----

--zCKi3GIZzVBPywwA--
