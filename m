Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0462D17E449
	for <lists+linux-iio@lfdr.de>; Mon,  9 Mar 2020 17:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgCIQH1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Mar 2020 12:07:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:42388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726758AbgCIQH0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 9 Mar 2020 12:07:26 -0400
Received: from lore-desk-wlan (unknown [151.48.128.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FE2A20828;
        Mon,  9 Mar 2020 16:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583770045;
        bh=PIZ3+D6wO7jIZfWR5eUuCZHcMdbBgKqM7D5nDqeYxpE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dNPPDI7Lt5tHac+24GM6sDTjgfJe4tUK12u11dn9q4FIk422zEaJLB7lB2jmkd6rQ
         B5/CY1Ukzl5DWZjAojpdq4Yeuzx5Ty5IGZfl6kiqt/oml5OVhWgXbaZfXY4iCfFrwn
         D5WKUgTnJbm3XmDrurSF6OaDEkI7Tkx0pmZf08Is=
Date:   Mon, 9 Mar 2020 17:07:14 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Vitor Soares <Vitor.Soares@synopsys.com>
Cc:     "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lorenzo.bianconi@redhat.com" <lorenzo.bianconi@redhat.com>,
        "mario.tesi@st.com" <mario.tesi@st.com>
Subject: Re: [PATCH v2] iio: imu: st_lsm6dsx: disable I3C support during
 device reset
Message-ID: <20200309160714.GD490054@lore-desk-wlan>
References: <c4591fcbbb63c9280532e43b39c4f96323f321c2.1583625699.git.lorenzo@kernel.org>
 <CH2PR12MB4216C6B0B5922780FB13B902AEFE0@CH2PR12MB4216.namprd12.prod.outlook.com>
 <20200309150101.GB490054@lore-desk-wlan>
 <CH2PR12MB421655D9F6A060E4199AC6CDAEFE0@CH2PR12MB4216.namprd12.prod.outlook.com>
 <20200309151035.GC490054@lore-desk-wlan>
 <CH2PR12MB42164216A155A4EB5F2EC8A8AEFE0@CH2PR12MB4216.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ylS2wUBXLOxYXZFQ"
Content-Disposition: inline
In-Reply-To: <CH2PR12MB42164216A155A4EB5F2EC8A8AEFE0@CH2PR12MB4216.namprd12.prod.outlook.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--ylS2wUBXLOxYXZFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Lorenzo Bianconi <lorenzo@kernel.org>
> Date: Mon, Mar 09, 2020 at 15:10:35
>=20
> > > From: Lorenzo Bianconi <lorenzo@kernel.org>
> > > Date: Mon, Mar 09, 2020 at 15:01:01
> > >=20
> > > > > Hi Lorenzo,
> > > > >=20
> > > > > From: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > > Date: Sun, Mar 08, 2020 at 00:06:03
> > > > >=20
> > > > > > Disable MIPI I3C during device reset in order to avoid
> > > > > > possible races on interrupt line 1. If the first interrupt
> > > > > > line is asserted during hw reset the device will work in
> > > > > > I3C-only mode
> > > > > >=20
> > > >=20
> > > > [...]
> > > >=20
> > > > > > +
> > > > >=20
> > > > > After disable the i3c interface the dynamic address is no more ac=
cessible=20
> > > > > and fails the initialization.
> > > > >=20
> > > >=20
> > > > Hi Vitor,
> > > >=20
> > > > thx for testing it. What do you mean here?
> > > > Is int1 set to vdd in your test?
> > > >=20
> > > > Regards,
> > > > Lorenzo
> > >=20
> > > Yes, according with figure 14 of lsm6dso datasheet.
> >=20
> > uhm..probably we should do this configuration if the device is not in I=
3C-only
> > mode. Are you able to test it without setting the int1 to vdd?
> > Unfortunately I have no devices with an I3C controller yet.
> >=20
> > Regards,
> > Lorenzo
> >=20
>=20
> Yes, I can test but I suspect we will have the same issue because it lost=
=20
> the dynamic address. I would say to add a flag during the probe to=20
> indicate the interface and bypass this if in I3C mode.

I am not an i3c expert but I think the dynamic address is reset during the =
boot
procedure of the sensor (this is done even if you do not disable i3c).
Re-thinking about it, we should avoid it if the device if working in i3c-on=
ly
(int1 set to vdd) but I think it would be necessary in i3c-mixed (int1 set 0
gnd). Could you please test it in the latter case? Thanks.

Regards,
Lorenzo

>=20
> This may be useful when address the In-band interrupts.
>=20
> Best regards,
> Vitor Soares
>=20
> > >=20
> > > Is there any way to clear the INT1 before the hw reset?
> > >=20
> > > Best regards,
> > > Vitor Soares
> > >=20
> > > >=20
> > > > > Best regards,
> > > > > Vitor Soares
> > > > >=20
> > > > > >  	/* device sw reset */
> > > > > >  	reg =3D &hw->settings->reset;
> > > > > >  	err =3D regmap_update_bits(hw->regmap, reg->addr, reg->mask,
> > > > > > @@ -2059,6 +2081,15 @@ static int st_lsm6dsx_init_device(struct=
 st_lsm6dsx_hw *hw)
> > > > > > =20
> > > > > >  	msleep(50);
> > > > > > =20
> > > > > > +	/* enable MIPI I3C */
> > > > > > +	if (hw->settings->i3c_disable.addr) {
> > > > > > +		reg =3D &hw->settings->i3c_disable;
> > > > > > +		err =3D regmap_update_bits(hw->regmap, reg->addr, reg->mask,
> > > > > > +					 ST_LSM6DSX_SHIFT_VAL(0, reg->mask));
> > > > > > +		if (err < 0)
> > > > > > +			return err;
> > > > > > +	}
> > > > > > +
> > > > > >  	/* enable Block Data Update */
> > > > > >  	reg =3D &hw->settings->bdu;
> > > > > >  	err =3D regmap_update_bits(hw->regmap, reg->addr, reg->mask,
> > > > > > --=20
> > > > > > 2.24.1
> > > > >=20
> > > > >=20
> > >=20
> > >=20
>=20
>=20

--ylS2wUBXLOxYXZFQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXmZprwAKCRA6cBh0uS2t
rHrzAQDPLMW5WPHB35cj4jUi04D3YvyU07eUZMt3Y54aq6R6MgD/ckBu9ixmzKnc
WiE0+xf5NXn9ldrKEgdY2cI0pqNWswg=
=E/ZU
-----END PGP SIGNATURE-----

--ylS2wUBXLOxYXZFQ--
