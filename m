Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 047074ABA6
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2019 22:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730555AbfFRUYU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 Jun 2019 16:24:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:48296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730634AbfFRUYU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 18 Jun 2019 16:24:20 -0400
Received: from localhost.localdomain (unknown [151.66.61.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C69C206E0;
        Tue, 18 Jun 2019 20:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560889459;
        bh=tIcwEu8V7KwjRZdjxLuhJ1oPJXQABL1xIW+w59FXmzo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p+xjrJgCrM46eBFCnLeTmhqZWFZylxwQ7wy6cOZkKoQ2vosFsnF6phPplXZEfyvMU
         dc3uVPlBsACmVoCu+V4MbpRLRPnzpyc2RS4JEZYR0vxzM0MdDJVIIILH3IbPkJ1O3Y
         9ButDLPbetRdKdqEkKGmVSeWMHh4DYINc8bKq584=
Date:   Tue, 18 Jun 2019 22:24:14 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com, martin@geanix.com
Subject: Re: [PATCH 4/5] iio: imu: st_lsm6dsx: always enter interrupt thread
Message-ID: <20190618202413.GB930@localhost.localdomain>
References: <20190618125939.105903-1-sean@geanix.com>
 <20190618125939.105903-5-sean@geanix.com>
 <20190618155527.GD20044@localhost.localdomain>
 <3c1f1f3c-7de8-160a-a5bf-b9abfca78d50@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nVMJ2NtxeReIH9PS"
Content-Disposition: inline
In-Reply-To: <3c1f1f3c-7de8-160a-a5bf-b9abfca78d50@geanix.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--nVMJ2NtxeReIH9PS
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jun 18, Sean Nyekjaer wrote:
>=20
>=20
> On 18/06/2019 17.55, Lorenzo Bianconi wrote:
> > > The interrupt source can come from multiple sources, fifo and wake in=
terrupts.
> > > Enter interrupt thread to check which interrupt that has fired.
> > >=20
> > > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> > > ---
> > >   drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 30 +++++++++++++++--=
---
> > >   1 file changed, 23 insertions(+), 7 deletions(-)
> > >=20
> > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/i=
io/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > index 59a34894e495..76aec5024d83 100644
> > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > @@ -78,6 +78,12 @@
> > >   #define ST_LSM6DSX_REG_GYRO_OUT_Y_L_ADDR	0x24
> > >   #define ST_LSM6DSX_REG_GYRO_OUT_Z_L_ADDR	0x26
> > > +#define ST_LSM6DSX_REG_WAKE_UP_SRC_ADDR		0x1B
> > > +#define ST_LSM6DSX_REG_WAKE_UP_SRC_Z_WU_MASK	BIT(0)
> > > +#define ST_LSM6DSX_REG_WAKE_UP_SRC_Y_WU_MASK	BIT(1)
> > > +#define ST_LSM6DSX_REG_WAKE_UP_SRC_X_WU_MASK	BIT(2)
> > > +#define ST_LSM6DSX_REG_WAKE_UP_SRC_WU_MASK	BIT(4)
> > > +
> > >   #define ST_LSM6DSX_REG_TAP_CFG_ADDR		0x58
> > >   #define ST_LSM6DSX_REG_TAP_CFG_INT_EN_MASK	BIT(7)
> > >   #define ST_LSM6DSX_REG_TAP_CFG_INACT_EN_MASK	GENMASK(6, 5)
> > > @@ -946,19 +952,29 @@ int st_lsm6dsx_event_setup(struct st_lsm6dsx_hw=
 *hw)
> > >   static irqreturn_t st_lsm6dsx_handler_irq(int irq, void *private)
> > >   {
> > > -	struct st_lsm6dsx_hw *hw =3D private;
> > > -
> > > -	return hw->sip > 0 ? IRQ_WAKE_THREAD : IRQ_NONE;
> > > +	return IRQ_WAKE_THREAD;
> >=20
> > I guess this will break shared interrupt, isn't it?
>=20
> When you write shared interrupt you mean: the drdy-int-pin stuff?
> I need to add so we can use all this functionality with the INT2 as well.=
=2E.

nope, shared IRQ line with other devices (when you set drive-open-drain dts
property)

>=20
> >=20
> > >   }
> > >   static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)
> > >   {
> > >   	struct st_lsm6dsx_hw *hw =3D private;
> > > -	int count;
> > > +	int count =3D 0;
> > > +	int data, err;
> > > +
> > > +	if (hw->enable_event) {
> > > +		err =3D regmap_read(hw->regmap,
> > > +				  ST_LSM6DSX_REG_WAKE_UP_SRC_ADDR, &data);
> > > +		if (err < 0)
> > > +			goto try_fifo;
> >=20
> > You can simplify this just doing something like:
> >=20
> > 		if (err < 0 && !hw->sip)
> > 			return IRQ_NONE;
> >=20
> Will apply :-)
>=20
> Thanks for the review Lorenzo...

Thanks for working on this :)

Regards,
Lorenzo

>=20
> --=20
> Best regards,
> Sean Nyekj=E6r
> Embedded Linux Consultant
>=20
> +45 42427326
> sean@geanix.com
>=20
> Geanix ApS
> https://geanix.com
> DK39600706

--nVMJ2NtxeReIH9PS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXQlIagAKCRA6cBh0uS2t
rDQ3AP9sBUml3Cm9A8KgQgIg/tfXfmY/eWps1omJqG6cDEH4rQD/XgSSnVy6LoND
vrMQ6A8fv3LDhgRG7vkuk8jMp+Ffhw0=
=ajWY
-----END PGP SIGNATURE-----

--nVMJ2NtxeReIH9PS--
