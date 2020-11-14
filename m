Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1525F2B2E89
	for <lists+linux-iio@lfdr.de>; Sat, 14 Nov 2020 17:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgKNQsr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 Nov 2020 11:48:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:58724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbgKNQsr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 14 Nov 2020 11:48:47 -0500
Received: from localhost (unknown [151.66.8.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9378F20719;
        Sat, 14 Nov 2020 16:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605372525;
        bh=pLm8Z+i7I9xxPNxzjtd56m6ayOrcY+b/sJGh8q6wWkY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c7Lte6uMjJXJC9hvbUXEt0ESavjvINYUUKqBp0Nq+g33dX33kjAQ4tRl3E5FcvCMW
         7u5WI7zBoT9Jm67wMNtSlwNwHkTK9aVKUk0wrFeaUTdjv15pKoelzmgtE7gL71GXk3
         EwSgMCYPwrO1xNEPgetLeuh2wA4v79Xfr7EAeBYA=
Date:   Sat, 14 Nov 2020 17:48:40 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, mario.tesi@st.com, denis.ciocca@st.com,
        armando.visconti@st.com
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: fix edge-trigger interrupts
Message-ID: <20201114164840.GA3993@lore-desk>
References: <f48bee8fadf3383b2569c5d3e909b494976f979c.1603358530.git.lorenzo@kernel.org>
 <20201101163354.61ac7576@archlinux>
 <20201102101521.GA229825@lore-desk>
 <20201102174450.0000077e@Huawei.com>
 <20201102181842.GC229825@lore-desk>
 <20201108164942.094e1112@archlinux>
 <20201108182728.GA17810@lore-desk>
 <20201114150630.6d8401a6@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
In-Reply-To: <20201114150630.6d8401a6@archlinux>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sun, 8 Nov 2020 19:27:28 +0100
> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>=20
[...]
>=20
> So the thing I've been trying to say badly here is that I'm fairly sure t=
he
> issue isn't what you think it is at all.  (Note I've spent a lot of
> time with scopes on interrupt lines looking for similar issues - it's
> not fun).
>=20
> I think the actual condition here is that you have an interrupt that is n=
ot
> guaranteed to go low for long enough between being cleared and set.  Thus=
 if you are
> read the fifo at almost exactly the moment new data is written you may in=
 theory
> have the interrupt drop, but in practice analog electronics kicks in an y=
ou won't
> get an interrupt detected at all. This why the sensor needs to put guaran=
tees
> on that drop time (some do - but I'm not seeing in datasheet for this one=
).
> On a more mundane note, I'm not sure in this case that there is a guarant=
ee
> it will ever drop even in theory - this buffer could for this short perio=
d be
> filling faster than we drain it.

ack, very nice explanation :)

>=20
> The reason your change makes this much less likely to happen is that, by =
checking
> again you are generally much closer to the time of the change of the leve=
l in
> the fifo.  Thus, unless you are preempted you should clear it long before=
 it
> would be set again, and thus get a nice clean drop on the interrupt.
>=20
> So for some asci art=20

very nice :)

>=20
> Previously we have
>=20
> data samples       |       |       |
>                           _
> Read of fifo   ___________|_____=20
>                     _______ _____________
> interrupt line ____|       |              Interrupt stuck high as edge mi=
ssed.
>                            ^      =20
>                            1      =20
>=20
> With your fix
>=20
> data samples       |       |       |
>                           _
> Read of fifo   ___________|__|__=20
>                     _______ __
> interrupt line ____|       |  |____|
>                            ^       ^
>                            1       2
>=20
> So we would have missed 1, but because we check the fifo level again imme=
diate
> after we would have made it drop, if we hit this unfortunately timing we =
will
> very quickly pull new data from the sensor and result in a drop well befo=
re the
> next interrupt comes in.

in the last case, even if we introduce a little bit of burstiness, I guess =
it
works because we read both 1 and 2, right?

>=20
>=20
> >=20
> > @denis, mario, armando: can you please confirm the hw does not support =
pulsed
> > interrupts for fifo-watermark?
> >=20
> > If not one possible approach would be to disable the interrupt generati=
on on
> > the sensor at the beginning of st_lsm6dsx_handler_thread() and schedule=
 a
> > workqueue at the end of st_lsm6dsx_handler_thread() to re-enable the se=
nsor
> > interrupt generation. What do you think?
>=20
> Reenabling it in the thread should work as well.  It is a heavy weight so=
lution
> but it is what you are expected to do in cases like this.=20
>=20
> I'd be very surprised if that doesn't work.  The normal operation of edge
> interrupt handlers is to reenable in the thread after we are sure we have
> cleared the condition for the original interrupt.  That will take long en=
ough
> (as bus transaction involved) that the interrupt will definitely have dro=
pped
> for long enough to be detected.

agree it should work

>=20
> In some similar cases we've just concluded the right option is to not
> support edge interrupts. Do we know if we have boards out there that are =
using
> it in that mode and is there any chance they would support level interrup=
ts
> as that's going to be a lot simpler and more reliable for this?

I do not know about it, I just received a report about the issue from stm f=
olks.
I am fine to drop support for edge interrupts but do we have a similar issu=
e for
st sensors (acc, magn, gyro) as well? Please consider:
https://elixir.bootlin.com/linux/latest/source/drivers/iio/common/st_sensor=
s/st_sensors_trigger.c#L113

Regards,
Lorenzo

>=20
> Jonathan
> >=20
> > Regards,
> > Lorenzo
> >=20
> > >=20
> > > Jonathan
> > >=20
> > >=20
> > >=20
> > >  =20
> > > >=20
> > > > Regards,
> > > > Lorenzo
> > > >  =20
> > > > >    =20
> > > > > >    =20
> > > > > > >=20
> > > > > > >=20
> > > > > > > Hmm. Having had a look at one of the datasheets, I'm far from=
 convinced these
> > > > > > > parts truely support edge interrupts.  I can't see anything a=
bout minimum
> > > > > > > off periods etc that you need for true edge interrupts. Other=
wise they are
> > > > > > > going to be prone to races.     =20
> > > > > >=20
> > > > > > @mario, denis, armando: any pointer for this?
> > > > > >    =20
> > > > > > >=20
> > > > > > > So I think the following can happen.
> > > > > > >=20
> > > > > > > A) We drain the fifo and it stays under the limit. Hence once=
 that
> > > > > > >    is crossed in future we will interrupt as normal.
> > > > > > >=20
> > > > > > > B) We drain the fifo but it either has a very low watermark, =
or is
> > > > > > >    filling very fast.   We manage to drain enough to get the =
interrupt
> > > > > > >    to fire again, so all is fine if less than ideal.  With yo=
u loop we
> > > > > > >    may up entering the interrupt handler when we don't actual=
ly need to.
> > > > > > >    If you want to avoid that you would need to disable the in=
terrupt,
> > > > > > >    then drain the fifo and finally do a dance to successfully=
 reenable
> > > > > > >    the interrupt, whilst ensuring no chance of missing by che=
cking it
> > > > > > >    should not have fired (still below the threshold)
> > > > > > >=20
> > > > > > > C) We try to drain the fifo, but it is actually filling fast =
enough that
> > > > > > >    we never get it under the limit, so no interrupt ever fire=
s.
> > > > > > >    With new code, we'll keep spinning to 0 so might eventuall=
y drain it.
> > > > > > >    That needs a timeout so we just give up eventually.
> > > > > > >=20
> > > > > > > D) watershed is one sample, we drain low enough to successful=
ly get down
> > > > > > >    to zero at the moment of the read, but very very soon afte=
r that we get
> > > > > > >    one sample again. There is a window in which the interrupt=
 line dropped
> > > > > > >    but analogue electronics etc being what they are, it may n=
ot have been
> > > > > > >    detectable.  Hence we miss an interrupt...  What you are d=
oing is reducing
> > > > > > >    the chance of hitting this.  It is nasty, but you might be=
 able to ensure
> > > > > > >    a reasonable period by widening this window.  Limit the wa=
termark to 2
> > > > > > >    samples? =20
> > > > > > >=20
> > > > > > > Also needs a fixes tag :)     =20
> > > > > >=20
> > > > > > ack, I will add them in v2
> > > > > >=20
> > > > > > Regards,
> > > > > > Lorenzo   =20
> > > > > > >      =20
> > > > > > > >=20
> > > > > > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > > > > > ---
> > > > > > > >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 33 ++++++++=
+++++++-----
> > > > > > > >  1 file changed, 25 insertions(+), 8 deletions(-)
> > > > > > > >=20
> > > > > > > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b=
/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > > > > > index 5e584c6026f1..d43b08ceec01 100644
> > > > > > > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > > > > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > > > > > @@ -2457,22 +2457,36 @@ st_lsm6dsx_report_motion_event(stru=
ct st_lsm6dsx_hw *hw)
> > > > > > > >  	return data & event_settings->wakeup_src_status_mask;
> > > > > > > >  }
> > > > > > > > =20
> > > > > > > > +static irqreturn_t st_lsm6dsx_handler_irq(int irq, void *p=
rivate)
> > > > > > > > +{
> > > > > > > > +	return IRQ_WAKE_THREAD;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > >  static irqreturn_t st_lsm6dsx_handler_thread(int irq, void=
 *private)
> > > > > > > >  {
> > > > > > > >  	struct st_lsm6dsx_hw *hw =3D private;
> > > > > > > > +	int fifo_len =3D 0, len =3D 0;
> > > > > > > >  	bool event;
> > > > > > > > -	int count;
> > > > > > > > =20
> > > > > > > >  	event =3D st_lsm6dsx_report_motion_event(hw);
> > > > > > > > =20
> > > > > > > >  	if (!hw->settings->fifo_ops.read_fifo)
> > > > > > > >  		return event ? IRQ_HANDLED : IRQ_NONE;
> > > > > > > > =20
> > > > > > > > -	mutex_lock(&hw->fifo_lock);
> > > > > > > > -	count =3D hw->settings->fifo_ops.read_fifo(hw);
> > > > > > > > -	mutex_unlock(&hw->fifo_lock);
> > > > > > > > +	/*
> > > > > > > > +	 * If we are using edge IRQs, new samples can arrive while
> > > > > > > > +	 * processing current IRQ and those may be missed unless =
we
> > > > > > > > +	 * pick them here, so let's try read FIFO status again
> > > > > > > > +	 */
> > > > > > > > +	do {
> > > > > > > > +		mutex_lock(&hw->fifo_lock);
> > > > > > > > +		len =3D hw->settings->fifo_ops.read_fifo(hw);
> > > > > > > > +		mutex_unlock(&hw->fifo_lock);
> > > > > > > > +
> > > > > > > > +		fifo_len +=3D len;
> > > > > > > > +	} while (len > 0);
> > > > > > > > =20
> > > > > > > > -	return count || event ? IRQ_HANDLED : IRQ_NONE;
> > > > > > > > +	return fifo_len || event ? IRQ_HANDLED : IRQ_NONE;
> > > > > > > >  }
> > > > > > > > =20
> > > > > > > >  static int st_lsm6dsx_irq_setup(struct st_lsm6dsx_hw *hw)
> > > > > > > > @@ -2488,10 +2502,14 @@ static int st_lsm6dsx_irq_setup(str=
uct st_lsm6dsx_hw *hw)
> > > > > > > > =20
> > > > > > > >  	switch (irq_type) {
> > > > > > > >  	case IRQF_TRIGGER_HIGH:
> > > > > > > > +		irq_type |=3D IRQF_ONESHOT;
> > > > > > > > +		fallthrough;
> > > > > > > >  	case IRQF_TRIGGER_RISING:
> > > > > > > >  		irq_active_low =3D false;
> > > > > > > >  		break;
> > > > > > > >  	case IRQF_TRIGGER_LOW:
> > > > > > > > +		irq_type |=3D IRQF_ONESHOT;
> > > > > > > > +		fallthrough;
> > > > > > > >  	case IRQF_TRIGGER_FALLING:
> > > > > > > >  		irq_active_low =3D true;
> > > > > > > >  		break;
> > > > > > > > @@ -2520,10 +2538,9 @@ static int st_lsm6dsx_irq_setup(stru=
ct st_lsm6dsx_hw *hw)
> > > > > > > >  	}
> > > > > > > > =20
> > > > > > > >  	err =3D devm_request_threaded_irq(hw->dev, hw->irq,
> > > > > > > > -					NULL,
> > > > > > > > +					st_lsm6dsx_handler_irq,
> > > > > > > >  					st_lsm6dsx_handler_thread,
> > > > > > > > -					irq_type | IRQF_ONESHOT,
> > > > > > > > -					"lsm6dsx", hw);
> > > > > > > > +					irq_type, "lsm6dsx", hw);
> > > > > > > >  	if (err) {
> > > > > > > >  		dev_err(hw->dev, "failed to request trigger irq %d\n",
> > > > > > > >  			hw->irq);     =20
> > > > > > >      =20
> > > > > >    =20
> > > > >    =20
> > >  =20
>=20

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCX7AKZQAKCRA6cBh0uS2t
rGnJAP4gJT7Epk19vbfyanXYmhDdBaRNIG0pkRV0LCfH++7MCgEAmeRsHnZbV31Z
dUHaNGTgElw0abhPel5z+GondeDyMAg=
=8kvb
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
