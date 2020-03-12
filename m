Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD19183BDA
	for <lists+linux-iio@lfdr.de>; Thu, 12 Mar 2020 23:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgCLWCW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Mar 2020 18:02:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:40610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbgCLWCW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 12 Mar 2020 18:02:22 -0400
Received: from lore-desk-wlan (unknown [151.48.128.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F60A206CD;
        Thu, 12 Mar 2020 22:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584050541;
        bh=aKQDvZUMTPKofahhTdc7C6BfLztfCVs7MQzcyMSKulo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vfl4ynvaw5zRfyVQnFynzCrQIvhe+D7RxfclSeYJV1CgJBfMmIIvUOmk73m3867mj
         JKAIJX2sEpkIPk7E+m5C0ZW1cp3rhQwtzvTr7Zr+xfhGl+ORpqDzcXYl3fAunWIFjv
         N0/ODzwknO8LLmh1i7q9rOOB8EPMx6Pb3me24jts=
Date:   Thu, 12 Mar 2020 23:02:15 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     "lorenzo.bianconi@redhat.com" <lorenzo.bianconi@redhat.com>
Cc:     Vitor Soares <Vitor.Soares@synopsys.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "mario.tesi@st.com" <mario.tesi@st.com>, armando.visconti@st.com,
        denis.ciocca@st.com
Subject: Re: [PATCH v2] iio: imu: st_lsm6dsx: disable I3C support during
 device reset
Message-ID: <20200312220215.GD2125633@lore-desk-wlan>
References: <c4591fcbbb63c9280532e43b39c4f96323f321c2.1583625699.git.lorenzo@kernel.org>
 <CH2PR12MB4216C6B0B5922780FB13B902AEFE0@CH2PR12MB4216.namprd12.prod.outlook.com>
 <20200309150101.GB490054@lore-desk-wlan>
 <CH2PR12MB421655D9F6A060E4199AC6CDAEFE0@CH2PR12MB4216.namprd12.prod.outlook.com>
 <20200309151035.GC490054@lore-desk-wlan>
 <CH2PR12MB42164216A155A4EB5F2EC8A8AEFE0@CH2PR12MB4216.namprd12.prod.outlook.com>
 <20200309160714.GD490054@lore-desk-wlan>
 <CH2PR12MB4216D86F9B6885C60E40C1CDAEFF0@CH2PR12MB4216.namprd12.prod.outlook.com>
 <20200310135610.GB1990966@lore-desk-wlan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jCrbxBqMcLqd4mOl"
Content-Disposition: inline
In-Reply-To: <20200310135610.GB1990966@lore-desk-wlan>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--jCrbxBqMcLqd4mOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > From: Lorenzo Bianconi <lorenzo@kernel.org>
> > Date: Mon, Mar 09, 2020 at 16:07:14
> >=20
> > > > From: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > Date: Mon, Mar 09, 2020 at 15:10:35
> > > >=20
> > > > > > From: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > > > Date: Mon, Mar 09, 2020 at 15:01:01
> > > > > >=20
> > > > > > > > Hi Lorenzo,
> > > > > > > >=20
> > > > > > > > From: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > > > > > Date: Sun, Mar 08, 2020 at 00:06:03
> > > > > > > >=20
> > > > > > > > > Disable MIPI I3C during device reset in order to avoid
> > > > > > > > > possible races on interrupt line 1. If the first interrupt
> > > > > > > > > line is asserted during hw reset the device will work in
> > > > > > > > > I3C-only mode
> > > > > > > > >=20
> > > > > > >=20
> > > > > > > [...]
> > > > > > >=20
> > > > > > > > > +
> > > > > > > >=20
> > > > > > > > After disable the i3c interface the dynamic address is no m=
ore accessible=20
> > > > > > > > and fails the initialization.
> > > > > > > >=20
> > > > > > >=20
> > > > > > > Hi Vitor,
> > > > > > >=20
> > > > > > > thx for testing it. What do you mean here?
> > > > > > > Is int1 set to vdd in your test?
> > > > > > >=20
> > > > > > > Regards,
> > > > > > > Lorenzo
> > > > > >=20
> > > > > > Yes, according with figure 14 of lsm6dso datasheet.
> > > > >=20
> > > > > uhm..probably we should do this configuration if the device is no=
t in I3C-only
> > > > > mode. Are you able to test it without setting the int1 to vdd?
> > > > > Unfortunately I have no devices with an I3C controller yet.
> > > > >=20
> > > > > Regards,
> > > > > Lorenzo
> > > > >=20
> > > >=20
> > > > Yes, I can test but I suspect we will have the same issue because i=
t lost=20
> > > > the dynamic address. I would say to add a flag during the probe to=
=20
> > > > indicate the interface and bypass this if in I3C mode.
> > >=20
> > > I am not an i3c expert but I think the dynamic address is reset durin=
g the boot
> > > procedure of the sensor (this is done even if you do not disable i3c).
> >=20
> > It can't because the dynamic address assignment (1) and the sensor boot=
=20
> > (2) are made in different steps.
> >   1. probe of i3c master driver;
> >   2. probe of sensor driver;
> >=20
> > > Re-thinking about it, we should avoid it if the device if working in =
i3c-only
> > > (int1 set to vdd) but I think it would be necessary in i3c-mixed (int=
1 set 0
> > > gnd). Could you please test it in the latter case? Thanks.
> > >=20
> > > Regards,
> > > Lorenzo
> >=20
> > I test and get the same behavior. I thought it goes back to I2C mode bu=
t=20
> > not and neither the I3C DA is addressable.
>=20
> Hi Vitor,
>=20
> thx a lot for testing :) Maybe this would be important just when DSO/DSR =
are
> working in i2c. We need some info from st I guess
>=20
> + st folks

Mario suggested me we can fix the issue even flushing the FIFO before the r=
eset.
I will post a v3 using this approach.

Regards,
Lorenzo

>=20
> Regards,
> Lorenzo
>=20
> >=20
> > Best regards,
> > Vitor Soares
> >=20
> > >=20
> > > >=20
> > > > This may be useful when address the In-band interrupts.
> > > >=20
> > > > Best regards,
> > > > Vitor Soares
> > > >=20
> > > > > >=20
> > > > > > Is there any way to clear the INT1 before the hw reset?
> > > > > >=20
> > > > > > Best regards,
> > > > > > Vitor Soares
> > > > > >=20
> > > > > > >=20
> > > > > > > > Best regards,
> > > > > > > > Vitor Soares
> > > > > > > >=20
> > > > > > > > >  	/* device sw reset */
> > > > > > > > >  	reg =3D &hw->settings->reset;
> > > > > > > > >  	err =3D regmap_update_bits(hw->regmap, reg->addr, reg->=
mask,
> > > > > > > > > @@ -2059,6 +2081,15 @@ static int st_lsm6dsx_init_device(=
struct st_lsm6dsx_hw *hw)
> > > > > > > > > =20
> > > > > > > > >  	msleep(50);
> > > > > > > > > =20
> > > > > > > > > +	/* enable MIPI I3C */
> > > > > > > > > +	if (hw->settings->i3c_disable.addr) {
> > > > > > > > > +		reg =3D &hw->settings->i3c_disable;
> > > > > > > > > +		err =3D regmap_update_bits(hw->regmap, reg->addr, reg-=
>mask,
> > > > > > > > > +					 ST_LSM6DSX_SHIFT_VAL(0, reg->mask));
> > > > > > > > > +		if (err < 0)
> > > > > > > > > +			return err;
> > > > > > > > > +	}
> > > > > > > > > +
> > > > > > > > >  	/* enable Block Data Update */
> > > > > > > > >  	reg =3D &hw->settings->bdu;
> > > > > > > > >  	err =3D regmap_update_bits(hw->regmap, reg->addr, reg->=
mask,
> > > > > > > > > --=20
> > > > > > > > > 2.24.1
> > > > > > > >=20
> > > > > > > >=20
> > > > > >=20
> > > > > >=20
> > > >=20
> > > >=20
> >=20
> >=20



--jCrbxBqMcLqd4mOl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXmqxZAAKCRA6cBh0uS2t
rHcmAP4sLMb+QOUSI2vu2G2BQEiCFBmLJNlb500zk9F8xFGSQwEArAXszdU0ZJ2q
+qV/y5Z7JFDoGb5XClLVR90PA3vl2QQ=
=zsZB
-----END PGP SIGNATURE-----

--jCrbxBqMcLqd4mOl--
