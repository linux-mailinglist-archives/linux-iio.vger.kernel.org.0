Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D73617E2F5
	for <lists+linux-iio@lfdr.de>; Mon,  9 Mar 2020 16:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgCIPBH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Mar 2020 11:01:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:46634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726837AbgCIPBH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 9 Mar 2020 11:01:07 -0400
Received: from lore-desk-wlan (unknown [151.48.128.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 516D521655;
        Mon,  9 Mar 2020 15:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583766066;
        bh=CzzWLxruIIYkhuclLMr6OEKDq5xJZC5HgDTt8hX3Hds=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QoDWwKJ9dTcpq3PqeybKlptpFwx77rso4+gF+Rc9X0s9y9x0ZO6A6OJgxXVEy0LNV
         Tl1K4uysgB9QsCu39jhRCQid0AQXj/jHzP+5MN4CMPacMk/ZMhGqBNko3qsCaUX4gE
         O7cZt17lG4ywpzyv5Xi03PpCZj7sdjo9jMO6rJ0M=
Date:   Mon, 9 Mar 2020 16:01:01 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Vitor Soares <Vitor.Soares@synopsys.com>
Cc:     "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lorenzo.bianconi@redhat.com" <lorenzo.bianconi@redhat.com>,
        "mario.tesi@st.com" <mario.tesi@st.com>
Subject: Re: [PATCH v2] iio: imu: st_lsm6dsx: disable I3C support during
 device reset
Message-ID: <20200309150101.GB490054@lore-desk-wlan>
References: <c4591fcbbb63c9280532e43b39c4f96323f321c2.1583625699.git.lorenzo@kernel.org>
 <CH2PR12MB4216C6B0B5922780FB13B902AEFE0@CH2PR12MB4216.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bCsyhTFzCvuiizWE"
Content-Disposition: inline
In-Reply-To: <CH2PR12MB4216C6B0B5922780FB13B902AEFE0@CH2PR12MB4216.namprd12.prod.outlook.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--bCsyhTFzCvuiizWE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi Lorenzo,
>=20
> From: Lorenzo Bianconi <lorenzo@kernel.org>
> Date: Sun, Mar 08, 2020 at 00:06:03
>=20
> > Disable MIPI I3C during device reset in order to avoid
> > possible races on interrupt line 1. If the first interrupt
> > line is asserted during hw reset the device will work in
> > I3C-only mode
> >=20

[...]

> > +
>=20
> After disable the i3c interface the dynamic address is no more accessible=
=20
> and fails the initialization.
>=20

Hi Vitor,

thx for testing it. What do you mean here?
Is int1 set to vdd in your test?

Regards,
Lorenzo

> Best regards,
> Vitor Soares
>=20
> >  	/* device sw reset */
> >  	reg =3D &hw->settings->reset;
> >  	err =3D regmap_update_bits(hw->regmap, reg->addr, reg->mask,
> > @@ -2059,6 +2081,15 @@ static int st_lsm6dsx_init_device(struct st_lsm6=
dsx_hw *hw)
> > =20
> >  	msleep(50);
> > =20
> > +	/* enable MIPI I3C */
> > +	if (hw->settings->i3c_disable.addr) {
> > +		reg =3D &hw->settings->i3c_disable;
> > +		err =3D regmap_update_bits(hw->regmap, reg->addr, reg->mask,
> > +					 ST_LSM6DSX_SHIFT_VAL(0, reg->mask));
> > +		if (err < 0)
> > +			return err;
> > +	}
> > +
> >  	/* enable Block Data Update */
> >  	reg =3D &hw->settings->bdu;
> >  	err =3D regmap_update_bits(hw->regmap, reg->addr, reg->mask,
> > --=20
> > 2.24.1
>=20
>=20

--bCsyhTFzCvuiizWE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXmZaKQAKCRA6cBh0uS2t
rLEiAP41p+IOROb3ZyFGQ1L0JspFL62/HMAJGpc4044zqZ5xxQEA1gT8UGOxFnHb
AvendsYAuhJTov9hjwVXNnP1xAwZaAA=
=8Z3t
-----END PGP SIGNATURE-----

--bCsyhTFzCvuiizWE--
