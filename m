Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56E4965739
	for <lists+linux-iio@lfdr.de>; Thu, 11 Jul 2019 14:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbfGKMoK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 11 Jul 2019 08:44:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:32832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726016AbfGKMoK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 11 Jul 2019 08:44:10 -0400
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA8A92084B;
        Thu, 11 Jul 2019 12:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562849048;
        bh=lZFM/H31Fs5Z6ab6aWawrjKOVYQXr73MU24M7sjvFzo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FG78Uq6t54M6qxvPOcrTnLDhy+6LJohKCZpA2CPYzB2MPWd9Qd9tY1vmmCipDQ+wW
         iYDntFTTzMth2Ap++Ryozpuep3KcsORzj++qwyZ+DSpbxNE5D38yOoArb+RiplWHE7
         ZALKy+/h4kyUrx7A2QSc/aaBvtAt16pbMdQ3qaes=
Date:   Thu, 11 Jul 2019 14:44:02 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Vitor Soares <Vitor.Soares@synopsys.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "bbrezillon@knernel.org" <bbrezillon@knernel.org>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>
Subject: Re: [PATCH v3 3/3] iio: imu: st_lsm6dsx: add i3c basic support for
 LSM6DSO and LSM6DSR
Message-ID: <20190711124402.GC3452@localhost.localdomain>
References: <cover.1562767521.git.vitor.soares@synopsys.com>
 <73955529ae0c31f428221abb88031ab3b4165659.1562767521.git.vitor.soares@synopsys.com>
 <20190710194405.GA10520@lore-desk-wlan.lan>
 <SN6PR12MB2655AC6DF4A959A1705FC8A4AEF30@SN6PR12MB2655.namprd12.prod.outlook.com>
 <SN6PR12MB2655939CB14D0EF848B4F4A8AEF30@SN6PR12MB2655.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KDt/GgjP6HVcx58l"
Content-Disposition: inline
In-Reply-To: <SN6PR12MB2655939CB14D0EF848B4F4A8AEF30@SN6PR12MB2655.namprd12.prod.outlook.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--KDt/GgjP6HVcx58l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Vitor Soares <soares@synopsys.com>
> Date: Thu, Jul 11, 2019 at 11:12:34
>=20
> > Hi Lorenzo,
> >=20
> > From: Lorenzo Bianconi <lorenzo@kernel.org>
> > Date: Wed, Jul 10, 2019 at 20:44:05
> >=20
> > > > For today the st_lsm6dsx driver support LSM6DSO and LSM6DSR sensor =
only in
> > > > spi and i2c mode.
> > > >=20
> > > > The LSM6DSO and LSM6DSR are also i3c capable so lets give i3c suppo=
rt to
> > > > them.
> > >=20
> > > Hi Vitor,
> > >=20
> > > just few comments inline.
> > >=20
> > > Regards,
> > > Lorenzo
> > >=20
> > > >=20
> > > > Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
> > > > Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > ---
> > > > Changes in v3:
> > > >   Remove unnecessary st_lsm6dsx_i3c_data table used to hold device =
name
> > > >   Use st_lsm6dsx_probe new form
> > > >=20
> > > > Changes in v2:
> > > >   Add support for LSM6DSR
> > > >   Set pm_ops to st_lsm6dsx_pm_ops
> > > >=20
> > > >  drivers/iio/imu/st_lsm6dsx/Kconfig          |  8 +++-
> > > >  drivers/iio/imu/st_lsm6dsx/Makefile         |  1 +
> > > >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c | 61 +++++++++++++++++=
++++++++++++
> > > >  3 files changed, 69 insertions(+), 1 deletion(-)
> > > >  create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
> > > >=20
> > >=20
> > > [...]
> > > > +static int st_lsm6dsx_i3c_probe(struct i3c_device *i3cdev)
> > > > +{
> > > > +	const struct i3c_device_id *id =3D i3c_device_match_id(i3cdev,
> > > > +							    st_lsm6dsx_i3c_ids);
> > >=20
> > > i3c_device_match_id can theoretically fail so is it better to check
> > > return value here? (maybe I am too paranoid :))
>=20
> I was preparing the patch and if the i3c_device_match_id() fail it return=
=20
> NULL so the st_lsm6dsx_probe() will fail automatically.
> Checking the spi_get_device_id(), the drivers don't test the return value=
=20
> too.

multiple drivers deference it directly so I am fine to skip this check.

Regards,
Lorenzo

>=20
> Do you think it is really necessary to test it before the=20
> st_lsm6dsx_probe() function?
>=20
> Best regards,
> Vitor Soares

--KDt/GgjP6HVcx58l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXScvDwAKCRA6cBh0uS2t
rFqeAQCzrowWY6v6CrwXaKkUC1U9wBmyu7LaicNrBFZvExOFZQEAupmsvMoZ9yTZ
gOS6GkPOJEh4byeeFrEweGB5tbWlNg8=
=Ueu9
-----END PGP SIGNATURE-----

--KDt/GgjP6HVcx58l--
