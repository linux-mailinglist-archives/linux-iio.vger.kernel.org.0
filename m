Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6589817FF94
	for <lists+linux-iio@lfdr.de>; Tue, 10 Mar 2020 14:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgCJN4T (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 10 Mar 2020 09:56:19 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32804 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726269AbgCJN4T (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Mar 2020 09:56:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583848577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cpMwlzGo3jibE0hFRUKvjvoGFeBeL4qt4EvNAvo1y7I=;
        b=RD5/xTgSdn4MKTD+aAQ/KJVTdS3c5pAnc0u/1O0u/IR5vZcHYxzqc5OJGEhlJIch2leejj
        RTg3h1X+Bz58xrr9yBIIV1IBq8fjiPggyKb5Cb26BJVlZSirwZFHHiyMeEaBnBTTmKRH4w
        gdf/XfOY8h94274mB4XfrIFtsx/dVCs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-Z5nidqBTMYeNVgbXdmaHKg-1; Tue, 10 Mar 2020 09:56:16 -0400
X-MC-Unique: Z5nidqBTMYeNVgbXdmaHKg-1
Received: by mail-wr1-f70.google.com with SMTP id u18so6771818wrn.11
        for <linux-iio@vger.kernel.org>; Tue, 10 Mar 2020 06:56:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cpMwlzGo3jibE0hFRUKvjvoGFeBeL4qt4EvNAvo1y7I=;
        b=iCkk0bZjeIdg9X4ETicF8ozwlFTmh4xG+cZ/3ASzC1mG/kvUhi2E3jdQ7zTxydsikJ
         8PGGziv4WMfyHCygXkR0KHBmwBPRSnPk+xAIzRJLBZYcSdi5C8e5uF/eYTSyrpX9dO4U
         PXfNaZZzQ1OO6nEIE4aNmPvIN+iv9KboAT+5zwvRVOtCnLTn1g2FAzCUnMlmkmHD5ywO
         dz11CgMOhHBC0T6X3NEs3uL463TRxnKhns+p724QA6gGPFv0xw5SeZ4JiORzivC/h0lv
         5splA+rJvqoBcQ08W0axLcxHQ/aH1jkcM1gX5FTYtcs/ICC0eXWuuxI3vpbqTdalpYKZ
         qjTA==
X-Gm-Message-State: ANhLgQ0JSUkMyGwirUMp/vecDGzgAa29cDP563s7surjmnyJjcWFcKtR
        o6Dka0atC2YB+PkZhg7t5nlJojtCmAwp/f7Du6OoinuX7jBGbJtx72XJE6OHgcnni2rs0KXwmdv
        rsjc/WQlnLy06cPJE+yRw
X-Received: by 2002:adf:f70f:: with SMTP id r15mr28004203wrp.269.1583848575001;
        Tue, 10 Mar 2020 06:56:15 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtE04ec4LTXpZyvfGtI2XrNpbexRU7lC0OdQxyjaBAhZCnXmVvxqqnvykAeHqB7urJTedxu0w==
X-Received: by 2002:adf:f70f:: with SMTP id r15mr28004194wrp.269.1583848574748;
        Tue, 10 Mar 2020 06:56:14 -0700 (PDT)
Received: from lore-desk-wlan ([151.48.128.122])
        by smtp.gmail.com with ESMTPSA id z135sm4292175wmc.20.2020.03.10.06.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 06:56:13 -0700 (PDT)
Date:   Tue, 10 Mar 2020 14:56:10 +0100
From:   "lorenzo.bianconi@redhat.com" <lorenzo.bianconi@redhat.com>
To:     Vitor Soares <Vitor.Soares@synopsys.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "mario.tesi@st.com" <mario.tesi@st.com>, armando.visconti@st.com,
        denis.ciocca@st.com
Subject: Re: [PATCH v2] iio: imu: st_lsm6dsx: disable I3C support during
 device reset
Message-ID: <20200310135610.GB1990966@lore-desk-wlan>
References: <c4591fcbbb63c9280532e43b39c4f96323f321c2.1583625699.git.lorenzo@kernel.org>
 <CH2PR12MB4216C6B0B5922780FB13B902AEFE0@CH2PR12MB4216.namprd12.prod.outlook.com>
 <20200309150101.GB490054@lore-desk-wlan>
 <CH2PR12MB421655D9F6A060E4199AC6CDAEFE0@CH2PR12MB4216.namprd12.prod.outlook.com>
 <20200309151035.GC490054@lore-desk-wlan>
 <CH2PR12MB42164216A155A4EB5F2EC8A8AEFE0@CH2PR12MB4216.namprd12.prod.outlook.com>
 <20200309160714.GD490054@lore-desk-wlan>
 <CH2PR12MB4216D86F9B6885C60E40C1CDAEFF0@CH2PR12MB4216.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="24zk1gE8NUlDmwG9"
Content-Disposition: inline
In-Reply-To: <CH2PR12MB4216D86F9B6885C60E40C1CDAEFF0@CH2PR12MB4216.namprd12.prod.outlook.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--24zk1gE8NUlDmwG9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Lorenzo Bianconi <lorenzo@kernel.org>
> Date: Mon, Mar 09, 2020 at 16:07:14
>=20
> > > From: Lorenzo Bianconi <lorenzo@kernel.org>
> > > Date: Mon, Mar 09, 2020 at 15:10:35
> > >=20
> > > > > From: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > > Date: Mon, Mar 09, 2020 at 15:01:01
> > > > >=20
> > > > > > > Hi Lorenzo,
> > > > > > >=20
> > > > > > > From: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > > > > Date: Sun, Mar 08, 2020 at 00:06:03
> > > > > > >=20
> > > > > > > > Disable MIPI I3C during device reset in order to avoid
> > > > > > > > possible races on interrupt line 1. If the first interrupt
> > > > > > > > line is asserted during hw reset the device will work in
> > > > > > > > I3C-only mode
> > > > > > > >=20
> > > > > >=20
> > > > > > [...]
> > > > > >=20
> > > > > > > > +
> > > > > > >=20
> > > > > > > After disable the i3c interface the dynamic address is no mor=
e accessible=20
> > > > > > > and fails the initialization.
> > > > > > >=20
> > > > > >=20
> > > > > > Hi Vitor,
> > > > > >=20
> > > > > > thx for testing it. What do you mean here?
> > > > > > Is int1 set to vdd in your test?
> > > > > >=20
> > > > > > Regards,
> > > > > > Lorenzo
> > > > >=20
> > > > > Yes, according with figure 14 of lsm6dso datasheet.
> > > >=20
> > > > uhm..probably we should do this configuration if the device is not =
in I3C-only
> > > > mode. Are you able to test it without setting the int1 to vdd?
> > > > Unfortunately I have no devices with an I3C controller yet.
> > > >=20
> > > > Regards,
> > > > Lorenzo
> > > >=20
> > >=20
> > > Yes, I can test but I suspect we will have the same issue because it =
lost=20
> > > the dynamic address. I would say to add a flag during the probe to=20
> > > indicate the interface and bypass this if in I3C mode.
> >=20
> > I am not an i3c expert but I think the dynamic address is reset during =
the boot
> > procedure of the sensor (this is done even if you do not disable i3c).
>=20
> It can't because the dynamic address assignment (1) and the sensor boot=
=20
> (2) are made in different steps.
>   1. probe of i3c master driver;
>   2. probe of sensor driver;
>=20
> > Re-thinking about it, we should avoid it if the device if working in i3=
c-only
> > (int1 set to vdd) but I think it would be necessary in i3c-mixed (int1 =
set 0
> > gnd). Could you please test it in the latter case? Thanks.
> >=20
> > Regards,
> > Lorenzo
>=20
> I test and get the same behavior. I thought it goes back to I2C mode but=
=20
> not and neither the I3C DA is addressable.

Hi Vitor,

thx a lot for testing :) Maybe this would be important just when DSO/DSR are
working in i2c. We need some info from st I guess

+ st folks

Regards,
Lorenzo

>=20
> Best regards,
> Vitor Soares
>=20
> >=20
> > >=20
> > > This may be useful when address the In-band interrupts.
> > >=20
> > > Best regards,
> > > Vitor Soares
> > >=20
> > > > >=20
> > > > > Is there any way to clear the INT1 before the hw reset?
> > > > >=20
> > > > > Best regards,
> > > > > Vitor Soares
> > > > >=20
> > > > > >=20
> > > > > > > Best regards,
> > > > > > > Vitor Soares
> > > > > > >=20
> > > > > > > >  	/* device sw reset */
> > > > > > > >  	reg =3D &hw->settings->reset;
> > > > > > > >  	err =3D regmap_update_bits(hw->regmap, reg->addr, reg->ma=
sk,
> > > > > > > > @@ -2059,6 +2081,15 @@ static int st_lsm6dsx_init_device(st=
ruct st_lsm6dsx_hw *hw)
> > > > > > > > =20
> > > > > > > >  	msleep(50);
> > > > > > > > =20
> > > > > > > > +	/* enable MIPI I3C */
> > > > > > > > +	if (hw->settings->i3c_disable.addr) {
> > > > > > > > +		reg =3D &hw->settings->i3c_disable;
> > > > > > > > +		err =3D regmap_update_bits(hw->regmap, reg->addr, reg->m=
ask,
> > > > > > > > +					 ST_LSM6DSX_SHIFT_VAL(0, reg->mask));
> > > > > > > > +		if (err < 0)
> > > > > > > > +			return err;
> > > > > > > > +	}
> > > > > > > > +
> > > > > > > >  	/* enable Block Data Update */
> > > > > > > >  	reg =3D &hw->settings->bdu;
> > > > > > > >  	err =3D regmap_update_bits(hw->regmap, reg->addr, reg->ma=
sk,
> > > > > > > > --=20
> > > > > > > > 2.24.1
> > > > > > >=20
> > > > > > >=20
> > > > >=20
> > > > >=20
> > >=20
> > >=20
>=20
>=20

--24zk1gE8NUlDmwG9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXmecdwAKCRA6cBh0uS2t
rDNzAQCwsdKfAj6cqkRUcCUvhP5pTjrx8dWuWeBvYP/YX/jlSQD+Jh+nDDPFHUDf
Zy2VAdMLL2cxstgC3QAufncAmCsaewc=
=9r9Z
-----END PGP SIGNATURE-----

--24zk1gE8NUlDmwG9--

