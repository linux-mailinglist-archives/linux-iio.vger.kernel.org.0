Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 880694F503
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2019 11:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbfFVJzc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 Jun 2019 05:55:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:42986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726187AbfFVJzc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 Jun 2019 05:55:32 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B61FC20673;
        Sat, 22 Jun 2019 09:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561197331;
        bh=f1tT8ANuSXj5QdCxsCtKxySr/sG4aHEslLVrUKBFimY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X2WDNB4pFqvIQQbGf7NCAlqH44uWqjwM4nKGYTEjGhFEm3PcduebFehZ6vEJL4UOQ
         TBjK0xMClB9YOWPQ3kmvLETot/RdiXwD6gYelGy1sM0Yz8PLl5TcguO5MXOgLuQaH9
         l+uKjRZybjSkXPnPCseYCj9RyZwlgHABmKJ/+A78=
Date:   Sat, 22 Jun 2019 10:55:27 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Sean Nyekjaer <sean@geanix.com>, linux-iio@vger.kernel.org,
        lorenzo.bianconi83@gmail.com, martin@geanix.com
Subject: Re: [PATCH 4/5] iio: imu: st_lsm6dsx: always enter interrupt thread
Message-ID: <20190622105527.6ed23da3@archlinux>
In-Reply-To: <20190618202413.GB930@localhost.localdomain>
References: <20190618125939.105903-1-sean@geanix.com>
        <20190618125939.105903-5-sean@geanix.com>
        <20190618155527.GD20044@localhost.localdomain>
        <3c1f1f3c-7de8-160a-a5bf-b9abfca78d50@geanix.com>
        <20190618202413.GB930@localhost.localdomain>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 18 Jun 2019 22:24:14 +0200
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> On Jun 18, Sean Nyekjaer wrote:
> >=20
> >=20
> > On 18/06/2019 17.55, Lorenzo Bianconi wrote: =20
> > > > The interrupt source can come from multiple sources, fifo and wake =
interrupts.
> > > > Enter interrupt thread to check which interrupt that has fired.
> > > >=20
> > > > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> > > > ---
> > > >   drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 30 +++++++++++++++=
-----
> > > >   1 file changed, 23 insertions(+), 7 deletions(-)
> > > >=20
> > > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers=
/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > index 59a34894e495..76aec5024d83 100644
> > > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > @@ -78,6 +78,12 @@
> > > >   #define ST_LSM6DSX_REG_GYRO_OUT_Y_L_ADDR	0x24
> > > >   #define ST_LSM6DSX_REG_GYRO_OUT_Z_L_ADDR	0x26
> > > > +#define ST_LSM6DSX_REG_WAKE_UP_SRC_ADDR		0x1B
> > > > +#define ST_LSM6DSX_REG_WAKE_UP_SRC_Z_WU_MASK	BIT(0)
> > > > +#define ST_LSM6DSX_REG_WAKE_UP_SRC_Y_WU_MASK	BIT(1)
> > > > +#define ST_LSM6DSX_REG_WAKE_UP_SRC_X_WU_MASK	BIT(2)
> > > > +#define ST_LSM6DSX_REG_WAKE_UP_SRC_WU_MASK	BIT(4)
> > > > +
> > > >   #define ST_LSM6DSX_REG_TAP_CFG_ADDR		0x58
> > > >   #define ST_LSM6DSX_REG_TAP_CFG_INT_EN_MASK	BIT(7)
> > > >   #define ST_LSM6DSX_REG_TAP_CFG_INACT_EN_MASK	GENMASK(6, 5)
> > > > @@ -946,19 +952,29 @@ int st_lsm6dsx_event_setup(struct st_lsm6dsx_=
hw *hw)
> > > >   static irqreturn_t st_lsm6dsx_handler_irq(int irq, void *private)
> > > >   {
> > > > -	struct st_lsm6dsx_hw *hw =3D private;
> > > > -
> > > > -	return hw->sip > 0 ? IRQ_WAKE_THREAD : IRQ_NONE;
> > > > +	return IRQ_WAKE_THREAD; =20
> > >=20
> > > I guess this will break shared interrupt, isn't it? =20
> >=20
> > When you write shared interrupt you mean: the drdy-int-pin stuff?
> > I need to add so we can use all this functionality with the INT2 as wel=
l... =20
>=20
> nope, shared IRQ line with other devices (when you set drive-open-drain d=
ts
> property)

It's been a while since I looked at this, but...

It shouldn't be broken.  When using shared interrupts, all interrupt handle=
rs
tend to get run, whether or not a given one return IRQ_NONE.

Nothing stops multiple devices setting their interrupt lines at the same
time.

See __handle_irq_event_percpu in kernel/irq/handle.c which is probably
the right code. No return values are taken notice of until all registered
handlers have run.

Jonathan

>=20
> >  =20
> > >  =20
> > > >   }
> > > >   static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *priva=
te)
> > > >   {
> > > >   	struct st_lsm6dsx_hw *hw =3D private;
> > > > -	int count;
> > > > +	int count =3D 0;
> > > > +	int data, err;
> > > > +
> > > > +	if (hw->enable_event) {
> > > > +		err =3D regmap_read(hw->regmap,
> > > > +				  ST_LSM6DSX_REG_WAKE_UP_SRC_ADDR, &data);
> > > > +		if (err < 0)
> > > > +			goto try_fifo; =20
> > >=20
> > > You can simplify this just doing something like:
> > >=20
> > > 		if (err < 0 && !hw->sip)
> > > 			return IRQ_NONE;
> > >  =20
> > Will apply :-)
> >=20
> > Thanks for the review Lorenzo... =20
>=20
> Thanks for working on this :)
>=20
> Regards,
> Lorenzo
>=20
> >=20
> > --=20
> > Best regards,
> > Sean Nyekj=C3=A6r
> > Embedded Linux Consultant
> >=20
> > +45 42427326
> > sean@geanix.com
> >=20
> > Geanix ApS
> > https://geanix.com
> > DK39600706 =20

