Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 452C01A5E3C
	for <lists+linux-iio@lfdr.de>; Sun, 12 Apr 2020 13:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgDLLWu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Apr 2020 07:22:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:57556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgDLLWt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 12 Apr 2020 07:22:49 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20721206E9;
        Sun, 12 Apr 2020 11:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586690568;
        bh=XvYRX6ctcSE0Q/TtYr8mAFjPYD/cCS0ds5otmcmblQw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RLjtHG2xit/4D9D7uTiq2XfCaNgh9YT1iDoyZZwThyVc/+qiuu6LkKf9sV7nvlcgQ
         LrWO2Baxn2Y5CRzwwoVxu9xGyqtsm2KxQW31OmOGmEYiKvxOqbNZn18lhY0Uki/F8W
         7ZoYwofAormvGgKCRo5WM3nicnug2ZQ18b3RpIm4=
Date:   Sun, 12 Apr 2020 12:22:45 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     yarl-baudig@mailoo.org
Cc:     denis.ciocca@st.com, linux-iio@vger.kernel.org
Subject: Re: lsm303dlhc magnetometer: please help
Message-ID: <20200412122245.5435678b@archlinux>
In-Reply-To: <ea-mime-5e8c7cb3-95a-5209a24d@www-1.mailo.com>
References: <20200405140356.15700701@archlinux>
        <ea-mime-5e8c7cb3-95a-5209a24d@www-1.mailo.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue,  7 Apr 2020 15:14:27 +0200 (CEST)
yarl-baudig@mailoo.org wrote:

> ---- Message d'origine ----
> > De : Jonathan Cameron <jic23@kernel.org>
> > =C3=80 : yarl-baudig@mailoo.org
> > Sujet : Re: lsm303dlhc magnetometer: please help
> > Date : 05/04/2020 15:03:56 Europe/Paris
> > Copie =C3=A0 : denis.ciocca@st.com;
> >       linux-iio@vger.kernel.org
> >=20
> > On Sat,  4 Apr 2020 14:43:04 +0200 (CEST)
> > yarl-baudig@mailoo.org wrote:
> >  =20
> > > Good afternoun,
> > >=20
> > > I have an lsm303dlhc that I'm trying to get to work with a triggered =
 =20
> > buffer, the magnetometer part of it. =20
> > > The problem with this sensor is that the dataready signal has, I thin=
k, a  =20
> > different =20
> > > meaning than the one expected by the ST sensor driver set.
> > > On this sensor the signal is always high except when the sensor is wr=
iting  =20
> > new values to its data =20
> > > registers. The problem with the driver is that it expects the sensor =
to  =20
> > have a register =20
> > > to check if new data is available:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/tree/dr=
ivers/ =20
> > iio/common/st_sensors/st_sensors_trigger.c?h=3Dtesting#n36 =20
> > > the lsm303dlhc magnetometer is not configured with such a register:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/tree/dr=
ivers/ =20
> > iio/magnetometer/st_magn_core.c?h=3Dtesting#n183 =20
> > > There is one in the sensor but the dataready bit is just the value of=
 the  =20
> > signal, so =20
> > > even if I added the address and mask for this information, the meanin=
g  =20
> > would be =20
> > > wrong from the point of view of  function and the while loop would ru=
n  =20
> > endlessly: =20
> > > https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/tree/dr=
ivers/ =20
> > iio/common/st_sensors/st_sensors_trigger.c?h=3Dtesting#n113 =20
> > >  =20
> > Looking at the datasheet, it is a rather dumb device isn't it and the=20
> > datasheet
> > doesn't supply anywhere near enough info..  It says it's a system in=20
> > package
> > so in theory we could find out what the sensor actually is and that mig=
ht
> > have a better datasheet.
> >=20
> > Then we have the data ready bit as you say and a lock bit that fires wh=
en=20
> > we
> > successfully start reading (ensuring we get a full set from the same=20
> > 'scan')
> > The dataready bit description says:
> > "Data-ready bit. This bit is when a new set of measurements is availabl=
e."
> > I admit I'm reading between the lines, but that sounds like it will cle=
ar=20
> > when
> > the data has been read.  If it clears on it's own then there isn't much
> > we can do reliably.
> >=20
> > We could just treat the irq as a iio-trigger-interrupt trigger as long =
as we=20
> > definitely don't
> > need to do anything to clear it.  That will not hit any of the paths yo=
u=20
> > are
> > looking at as will directly call st_sensors_trigger_handler.
> >=20
> > Unfortunately that doesn't seem to have a device tree binding yet=20
> > (obviously
> > not much used except on very old platforms). I don't have a handy platf=
orm=20
> > to
> > test it on at the moment unfortunately but should just be a case of add=
ing
> > a device tree id table to the driver.  Then the dt entry will simply=20
> > contain
> > the interrupt line.
> >=20
> > Denis, any more info on this part and whether the using a dumb interrup=
t=20
> > trigger
> > is the way to go or if we can do anything more clever?
> >=20
> > It may be a case where the best bet is to ignore that line and use a hi=
gh
> > resolution time trigger running at half the raw sampling frequency of t=
he=20
> > device
> > (to avoid repeated values)
> >=20
> > Thanks,
> >=20
> > Jonathan
> >  =20
>=20
> Thank you for answering. I will probably try as you say, use an hrtimer.
>=20
> Anyway I want to precise one thing I just saw using the patch I showed yo=
u.
> The lsm303dlhc contains an accelerometer and a magnetometer.
> When the buffer for the accelerometer is disabled, the magnetometer "work=
s"
> the way I described in my last mail: one out of two times.
> When the buffer for the accelerometer is enabled: the magnetometer works,
> every time...

That is odd.  Any chance the interrupt lines are shared - i.e. wired
to the same pin?  Otherwise maybe there is an electrical short causing
problems...

Jonathan

> >  =20
> > > I then modified a bit, patch below.
> > >=20
> > > Let me first tell you that it work one out of two time:
> > > I boot, load this device-tree:
> > > ---
> > > /dts-v1/;
> > > /plugin/;
> > >=20
> > > / {
> > >   compatible =3D "brcm,bcm2708";
> > >=20
> > >   fragment@0 {
> > >     target =3D <&gpio>;
> > >     __overlay__ {
> > >       magn_pins: nine_dof_pins {
> > >         brcm,pins =3D <27>;
> > >         brcm,function =3D <0>;
> > >         brcm,pull =3D <1>;
> > >         status =3D "okay";
> > >       };
> > >     };
> > >   };
> > >=20
> > >   fragment@1 {
> > >     target =3D <&i2c_arm>;
> > >     __overlay__ {
> > >       status =3D "okay";
> > >       #address-cells =3D <1>;
> > >       #size-cells =3D <0>;
> > >       magn@1e {
> > >         compatible =3D "st,lsm303dlhc-magn";
> > >         reg =3D <0x1e>;
> > >         status =3D "okay";
> > >         interrupt-parent =3D <&gpio>;
> > >         interrupts =3D <27 1>;
> > >       };
> > >     };
> > >   };
> > > };
> > > ---
> > > I then enable scan_elements, enable buffer (echo 1 > buffer/enable)
> > > interrupts are coming regularly at sampling_frequency. It works fine.
> > > If I now disable the buffer then re-enable it, one and only interrupt,
> > > doesn't work fine..
> > > re-disable, re-re-enable: works fine!
> > > and it seem to be always that, it works modulo 2.
> > >=20
> > > On my first try I didn't change st_magn_buffer_preenable and  =20
> > st_magn_buffer_postenable =20
> > > But I thought that maybe, the problem was some sort of bad writting, =
 =20
> > reading timing =20
> > > because=20
> > > (1) request_threaded_irq is called for a rising signal while it is al=
ready  =20
> > high. =20
> > >=20
> > > I make a break here and ask you a question:
> > > As you read, I am a kernel newbie: is doing (1) bad? =20
> > Interesting question.  There is so little info in the datasheet that it=
 is=20
> > hard
> > to tell. It might be a level_high interrupt.
> >  =20
> > > end of break.
> > >=20
> > > So I added st_magn_buffer_preenable and modified st_magn_buffer_poste=
nable  =20
> > to =20
> > > try to mask the irq during the arppropriate interval.
> > >=20
> > > No visible change.
> > > I never almost never wrote kernel code before.
> > > I tried to get closer to what was happening using gdb/kgdb, first tim=
e I  =20
> > used this. =20
> > > I am now pretty discouraged and any suggestions are welcome.
> > >=20
> > > Thank you.
> > >=20
> > > ---
> > >  drivers/iio/common/st_sensors/st_sensors_core.c | 11 +++++++++++
> > >  .../iio/common/st_sensors/st_sensors_trigger.c  |  9 +++++++++
> > >  drivers/iio/magnetometer/st_magn_buffer.c       | 17 +++++++++++++++=
+-
> > >  drivers/iio/magnetometer/st_magn_core.c         |  3 +++
> > >  include/linux/iio/common/st_sensors.h           |  2 ++
> > >  5 files changed, 41 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c  =20
> > b/drivers/iio/common/st_sensors/st_sensors_core.c =20
> > > index 09279e40c55c..fef6b70976b4 100644
> > > --- a/drivers/iio/common/st_sensors/st_sensors_core.c
> > > +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
> > > @@ -480,6 +480,17 @@ int st_sensors_set_dataready_irq(struct iio_dev =
 =20
> > *indio_dev, bool enable) =20
> > >  	u8 drdy_addr, drdy_mask;
> > >  	struct st_sensor_data *sdata =3D iio_priv(indio_dev);
> > > =20
> > > +	if (sdata->sensor_settings->drdy_irq.simple) {
> > > +		/*
> > > +		 * some devices very simple. No register to enable, disable
> > > +		 * or configure the signal. Actually, when it is low it means that
> > > +		 * sensor is writing data to its register, when it is high it
> > > +		 * means that data can be read. i.e when rising new data is availa=
ble.
> > > +		 */
> > > +		sdata->hw_irq_trigger =3D enable;
> > > +		return 0;
> > > +	}
> > > +
> > >  	if (!sdata->sensor_settings->drdy_irq.int1.addr &&
> > >  	    !sdata->sensor_settings->drdy_irq.int2.addr) {
> > >  		/*
> > > diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c  =20
> > b/drivers/iio/common/st_sensors/st_sensors_trigger.c =20
> > > index fdcc5a891958..146aaae0a85c 100644
> > > --- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
> > > +++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> > > @@ -30,6 +30,13 @@ static int st_sensors_new_samples_available(struct=
  =20
> > iio_dev *indio_dev, =20
> > >  	u8 status;
> > >  	int ret;
> > > =20
> > > +	/* We simply trust the signal */
> > > +	if (sdata->sensor_settings->drdy_irq.simple) {
> > > +		if (indio_dev->active_scan_mask)
> > > +			return 1;
> > > +		return 0;
> > > +	}
> > > +
> > >  	/* How would I know if I can't check it? */
> > >  	if (!sdata->sensor_settings->drdy_irq.stat_drdy.addr)
> > >  		return -EINVAL;
> > > @@ -90,6 +97,8 @@ static irqreturn_t st_sensors_irq_thread(int irq, v=
oid  =20
> > *p) =20
> > >  	if (sdata->hw_irq_trigger &&
> > >  	    st_sensors_new_samples_available(indio_dev, sdata)) {
> > >  		iio_trigger_poll_chained(p);
> > > +		if (sdata->sensor_settings->drdy_irq.simple)
> > > +			return IRQ_HANDLED;
> > >  	} else {
> > >  		dev_dbg(sdata->dev, "spurious IRQ\n");
> > >  		return IRQ_NONE;
> > > diff --git a/drivers/iio/magnetometer/st_magn_buffer.c  =20
> > b/drivers/iio/magnetometer/st_magn_buffer.c =20
> > > index 37ab30566464..ae13e4339127 100644
> > > --- a/drivers/iio/magnetometer/st_magn_buffer.c
> > > +++ b/drivers/iio/magnetometer/st_magn_buffer.c
> > > @@ -30,6 +30,16 @@ int st_magn_trig_set_state(struct iio_trigger *tri=
g,  =20
> > bool state) =20
> > >  	return st_sensors_set_dataready_irq(indio_dev, state);
> > >  }
> > > =20
> > > +static int st_magn_buffer_preenable(struct iio_dev *indio_dev)
> > > +{
> > > +	struct st_sensor_data *mdata =3D iio_priv(indio_dev);
> > > +
> > > +	if (mdata->sensor_settings->drdy_irq.simple) {
> > > +		disable_irq(mdata->get_irq_data_ready(indio_dev));
> > > +	}
> > > +	return 0;
> > > +}
> > > +
> > >  static int st_magn_buffer_postenable(struct iio_dev *indio_dev)
> > >  {
> > >  	int err;
> > > @@ -45,7 +55,11 @@ static int st_magn_buffer_postenable(struct iio_de=
v  =20
> > *indio_dev) =20
> > >  	if (err < 0)
> > >  		goto st_magn_buffer_postenable_error;
> > > =20
> > > -	return st_sensors_set_enable(indio_dev, true);
> > > +	err =3D st_sensors_set_enable(indio_dev, true);
> > > +
> > > +	enable_irq(mdata->get_irq_data_ready(indio_dev));
> > > +
> > > +	return err;
> > > =20
> > >  st_magn_buffer_postenable_error:
> > >  	kfree(mdata->buffer_data);
> > > @@ -70,6 +84,7 @@ static int st_magn_buffer_predisable(struct iio_dev=
  =20
> > *indio_dev) =20
> > >  }
> > > =20
> > >  static const struct iio_buffer_setup_ops st_magn_buffer_setup_ops =
=3D {
> > > +	.preenable =3D &st_magn_buffer_preenable,
> > >  	.postenable =3D &st_magn_buffer_postenable,
> > >  	.predisable =3D &st_magn_buffer_predisable,
> > >  };
> > > diff --git a/drivers/iio/magnetometer/st_magn_core.c  =20
> > b/drivers/iio/magnetometer/st_magn_core.c =20
> > > index 72f6d1335a04..0fb0915529e9 100644
> > > --- a/drivers/iio/magnetometer/st_magn_core.c
> > > +++ b/drivers/iio/magnetometer/st_magn_core.c
> > > @@ -259,6 +259,9 @@ static const struct st_sensor_settings  =20
> > st_magn_sensors_settings[] =3D { =20
> > >  				},
> > >  			},
> > >  		},
> > > +    .drdy_irq =3D {
> > > +      .simple =3D true,
> > > +    },
> > >  		.multi_read_bit =3D false,
> > >  		.bootime =3D 2,
> > >  	},
> > > diff --git a/include/linux/iio/common/st_sensors.h  =20
> > b/include/linux/iio/common/st_sensors.h =20
> > > index f9bd6e8ab138..e25b5f033557 100644
> > > --- a/include/linux/iio/common/st_sensors.h
> > > +++ b/include/linux/iio/common/st_sensors.h
> > > @@ -154,6 +154,7 @@ struct st_sensor_int_drdy {
> > >   * struct ig1 - represents the Interrupt Generator 1 of sensors.
> > >   * @en_addr: address of the enable ig1 register.
> > >   * @en_mask: mask to write the on/off value for enable.
> > > + * @simple: the data-ready is a "very simple implementation".
> > >   */
> > >  struct st_sensor_data_ready_irq {
> > >  	struct st_sensor_int_drdy int1;
> > > @@ -168,6 +169,7 @@ struct st_sensor_data_ready_irq {
> > >  		u8 en_addr;
> > >  		u8 en_mask;
> > >  	} ig1;
> > > +	bool simple;
> > >  };
> > >=20
> > >  =20
> >=20
> >  =20
>=20
>=20

