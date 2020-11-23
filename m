Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1485C2C01B1
	for <lists+linux-iio@lfdr.de>; Mon, 23 Nov 2020 09:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgKWIvd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Nov 2020 03:51:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:35728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725275AbgKWIvd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Nov 2020 03:51:33 -0500
Received: from localhost (unknown [151.66.8.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A9B220658;
        Mon, 23 Nov 2020 08:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606121492;
        bh=lrw/nlZqya+k9XMSaXmFkhjkav8NJsmNCmJDPD8QR9w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2YgDK4OLP7WX5lHs2/zO4bIMI1vS6sesQdW7Ga3AsOWs2e/OFIAc6W+Q+Q5Naq2tw
         Jx8CAddxOudzNen5yjypooEch2It6dJREbD5NQJ6mh9w4lKIH22BuP2pnMReIxx8/p
         XffK9qbDJzqGWC3lkF+aLIhBv+c5ZO6qjcE5ArLs=
Date:   Mon, 23 Nov 2020 09:51:26 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     lorenzo.bianconi@redhat.com, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio: imu: st_lsm6dsx: add vdd-vddio voltage
 regulator
Message-ID: <20201123085126.GA2115@lore-desk>
References: <cover.1605631305.git.lorenzo@kernel.org>
 <a0427a66360bdec73c3b1fb536a46240f96b2ae7.1605631305.git.lorenzo@kernel.org>
 <20201121154938.0a9d3b4d@archlinux>
 <20201122103644.GA14218@lore-desk>
 <20201122190834.0a862808@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
In-Reply-To: <20201122190834.0a862808@archlinux>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sun, 22 Nov 2020 11:36:44 +0100
> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>=20
> > > On Tue, 17 Nov 2020 17:47:25 +0100
> > > Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> > >  =20
> > > > Like all other ST sensors, st_lsm6dsx devices have VDD and VDDIO po=
wer
> > > > lines. Introduce voltage regulators to control them.
> > > >=20
> > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org> =20
> > > Oops. I should have pointed out the dev_err_probe more appropriate
> > > to avoid complaining when we just tried to probe to early in the
> > > sequence and will try again later.  I'll hopefully fix this
> > > up an apply once I've picked up my own patch to do the yaml conversio=
n.
> > >  =20
> >=20
> > ack, fine for me otherwise I can just send v3. Up to you.
> I've done it and applied both this and patch 2 to the togreg branch of
> iio.git (having earlier applied the binding conversion patch).
>=20
> Please take a quick look and make sure it all looks right to you.

ack, it is fine, thanks Jonathan.

Regards,
Lorenzo

>=20
> Thanks,
>=20
> Jonathan
>=20
> >=20
> > Regards,
> > Lorenzo
> >=20
> > > Jonathan
> > >  =20
> > > > ---
> > > >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  3 ++
> > > >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 42 ++++++++++++++++=
++++
> > > >  2 files changed, 45 insertions(+)
> > > >=20
> > > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/=
imu/st_lsm6dsx/st_lsm6dsx.h
> > > > index 1f31657a7a0e..4b4ec39d4400 100644
> > > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > > > @@ -13,6 +13,7 @@
> > > > =20
> > > >  #include <linux/device.h>
> > > >  #include <linux/iio/iio.h>
> > > > +#include <linux/regulator/consumer.h>
> > > > =20
> > > >  #define ST_LSM6DS3_DEV_NAME	"lsm6ds3"
> > > >  #define ST_LSM6DS3H_DEV_NAME	"lsm6ds3h"
> > > > @@ -368,6 +369,7 @@ struct st_lsm6dsx_sensor {
> > > >   * struct st_lsm6dsx_hw - ST IMU MEMS hw instance
> > > >   * @dev: Pointer to instance of struct device (I2C or SPI).
> > > >   * @regmap: Register map of the device.
> > > > + * @regulators: VDD/VDDIO voltage regulators.
> > > >   * @irq: Device interrupt line (I2C or SPI).
> > > >   * @fifo_lock: Mutex to prevent concurrent access to the hw FIFO.
> > > >   * @conf_lock: Mutex to prevent concurrent FIFO configuration upda=
te.
> > > > @@ -390,6 +392,7 @@ struct st_lsm6dsx_sensor {
> > > >  struct st_lsm6dsx_hw {
> > > >  	struct device *dev;
> > > >  	struct regmap *regmap;
> > > > +	struct regulator_bulk_data regulators[2];
> > > >  	int irq;
> > > > =20
> > > >  	struct mutex fifo_lock;
> > > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers=
/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > index 5e584c6026f1..fde46377826c 100644
> > > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > @@ -2533,6 +2533,40 @@ static int st_lsm6dsx_irq_setup(struct st_ls=
m6dsx_hw *hw)
> > > >  	return 0;
> > > >  }
> > > > =20
> > > > +static int st_lsm6dsx_init_regulators(struct device *dev)
> > > > +{
> > > > +	struct st_lsm6dsx_hw *hw =3D dev_get_drvdata(dev);
> > > > +	int err;
> > > > +
> > > > +	/* vdd-vddio power regulators */
> > > > +	hw->regulators[0].supply =3D "vdd";
> > > > +	hw->regulators[1].supply =3D "vddio";
> > > > +	err =3D devm_regulator_bulk_get(dev, ARRAY_SIZE(hw->regulators),
> > > > +				      hw->regulators);
> > > > +	if (err) {
> > > > +		dev_err(dev, "failed to get regulators: %d\n", err);
> > > > +		return err;
> > > > +	}
> > > > +
> > > > +	err =3D regulator_bulk_enable(ARRAY_SIZE(hw->regulators),
> > > > +				    hw->regulators);
> > > > +	if (err) {
> > > > +		dev_err(dev, "failed to enable regulators: %d\n", err);
> > > > +		return err;
> > > > +	}
> > > > +
> > > > +	msleep(50);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static void st_lsm6dsx_chip_uninit(void *data)
> > > > +{
> > > > +	struct st_lsm6dsx_hw *hw =3D data;
> > > > +
> > > > +	regulator_bulk_disable(ARRAY_SIZE(hw->regulators), hw->regulators=
);
> > > > +}
> > > > +
> > > >  int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
> > > >  		     struct regmap *regmap)
> > > >  {
> > > > @@ -2552,6 +2586,14 @@ int st_lsm6dsx_probe(struct device *dev, int=
 irq, int hw_id,
> > > >  	mutex_init(&hw->conf_lock);
> > > >  	mutex_init(&hw->page_lock);
> > > > =20
> > > > +	err =3D st_lsm6dsx_init_regulators(dev);
> > > > +	if (err)
> > > > +		return err;
> > > > +
> > > > +	err =3D devm_add_action_or_reset(dev, st_lsm6dsx_chip_uninit, hw);
> > > > +	if (err)
> > > > +		return err;
> > > > +
> > > >  	hw->buff =3D devm_kzalloc(dev, ST_LSM6DSX_BUFF_SIZE, GFP_KERNEL);
> > > >  	if (!hw->buff)
> > > >  		return -ENOMEM; =20
> > >  =20
>=20

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCX7t4CwAKCRA6cBh0uS2t
rPdbAQCM9PI+q+FTlDwncqB4tK6xjNc9P8Na40bilXcK+A+m9QEA7Jf3bpwLHYGe
cY3rmouq7rQtgA9o+GpoNkcm+k1RTQU=
=81xd
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
