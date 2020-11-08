Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14A1C2AACC6
	for <lists+linux-iio@lfdr.de>; Sun,  8 Nov 2020 19:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgKHS1f (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Nov 2020 13:27:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:57444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727929AbgKHS1e (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Nov 2020 13:27:34 -0500
Received: from localhost (unknown [151.66.8.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 100CA206D8;
        Sun,  8 Nov 2020 18:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604860053;
        bh=YMdERtrSjiLIClAz2zYgPW6ukLrnM4K8hPgYuKlmOJs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m8DjOiUP5QZBxQOez27zHCujbmGNzxJPaFG09Nx0Job4GxJcTPr4bXumHvCDJl285
         nth/NPrbX4IAaILx+llaWAy3UPGXlmgrUTGL+4zBcCzWxxaBrKcpF58wqZMyJr7y2B
         pGwz5ZJGjaumf19jNKzoRl7PKokKM4p91eJiwNhY=
Date:   Sun, 8 Nov 2020 19:27:28 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, mario.tesi@st.com, denis.ciocca@st.com,
        armando.visconti@st.com
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: fix edge-trigger interrupts
Message-ID: <20201108182728.GA17810@lore-desk>
References: <f48bee8fadf3383b2569c5d3e909b494976f979c.1603358530.git.lorenzo@kernel.org>
 <20201101163354.61ac7576@archlinux>
 <20201102101521.GA229825@lore-desk>
 <20201102174450.0000077e@Huawei.com>
 <20201102181842.GC229825@lore-desk>
 <20201108164942.094e1112@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
In-Reply-To: <20201108164942.094e1112@archlinux>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[...]
> >=20
> > I guess since edge interrupts run with the line unmasked a new interrup=
t can fire
> > while the irq thread is still running (so wake_up_process() will just r=
eturn) but
> > the driver has already read fifo_status register and so it will not rea=
d new
> > sample. This case should be fixed reading again the fifo_status registe=
r.
>=20
> It doesn't actually help because there is always a window after the fifo_=
status register
> is read before we exit the thread.
>=20
> I 'think' what happens (it's been a while since I dug through this stuff)=
 is
> that you end up with the task being added to the runqueue, even though it=
's
> already running. Upshot the thread gets scheduled gain.=20
>=20
> If this were not the case there would be a race with any edge based inter=
rupt
> as the thread has to reenable the interrupt and it will always be able to=
 fire
> whilst the thread is still running.

I guess this is the case (race between irq-thread and edge interrupt) since=
 afaik
handle_edge_irq() runs with the irq-line unmasked.
I agree with you this approach does not fix completely the issue but it red=
uces
the race-surface since now the interrupt can fire while processing the prev=
ious one
(the issue occurs if the interrupt fires between the end of hw->settings->f=
ifo_ops.read_fifo()
and the end of the irq-thread) while before the interrupt must always fire =
before
reading the fifo status register (in fact with the patch applied I am not a=
ble
to trigger the issue anymore).

@denis, mario, armando: can you please confirm the hw does not support puls=
ed
interrupts for fifo-watermark?

If not one possible approach would be to disable the interrupt generation on
the sensor at the beginning of st_lsm6dsx_handler_thread() and schedule a
workqueue at the end of st_lsm6dsx_handler_thread() to re-enable the sensor
interrupt generation. What do you think?

Regards,
Lorenzo

>=20
> Jonathan
>=20
>=20
>=20
>=20
> >=20
> > Regards,
> > Lorenzo
> >=20
> > >  =20
> > > >  =20
> > > > >=20
> > > > >=20
> > > > > Hmm. Having had a look at one of the datasheets, I'm far from con=
vinced these
> > > > > parts truely support edge interrupts.  I can't see anything about=
 minimum
> > > > > off periods etc that you need for true edge interrupts. Otherwise=
 they are
> > > > > going to be prone to races.   =20
> > > >=20
> > > > @mario, denis, armando: any pointer for this?
> > > >  =20
> > > > >=20
> > > > > So I think the following can happen.
> > > > >=20
> > > > > A) We drain the fifo and it stays under the limit. Hence once that
> > > > >    is crossed in future we will interrupt as normal.
> > > > >=20
> > > > > B) We drain the fifo but it either has a very low watermark, or is
> > > > >    filling very fast.   We manage to drain enough to get the inte=
rrupt
> > > > >    to fire again, so all is fine if less than ideal.  With you lo=
op we
> > > > >    may up entering the interrupt handler when we don't actually n=
eed to.
> > > > >    If you want to avoid that you would need to disable the interr=
upt,
> > > > >    then drain the fifo and finally do a dance to successfully ree=
nable
> > > > >    the interrupt, whilst ensuring no chance of missing by checkin=
g it
> > > > >    should not have fired (still below the threshold)
> > > > >=20
> > > > > C) We try to drain the fifo, but it is actually filling fast enou=
gh that
> > > > >    we never get it under the limit, so no interrupt ever fires.
> > > > >    With new code, we'll keep spinning to 0 so might eventually dr=
ain it.
> > > > >    That needs a timeout so we just give up eventually.
> > > > >=20
> > > > > D) watershed is one sample, we drain low enough to successfully g=
et down
> > > > >    to zero at the moment of the read, but very very soon after th=
at we get
> > > > >    one sample again. There is a window in which the interrupt lin=
e dropped
> > > > >    but analogue electronics etc being what they are, it may not h=
ave been
> > > > >    detectable.  Hence we miss an interrupt...  What you are doing=
 is reducing
> > > > >    the chance of hitting this.  It is nasty, but you might be abl=
e to ensure
> > > > >    a reasonable period by widening this window.  Limit the waterm=
ark to 2
> > > > >    samples? =20
> > > > >=20
> > > > > Also needs a fixes tag :)   =20
> > > >=20
> > > > ack, I will add them in v2
> > > >=20
> > > > Regards,
> > > > Lorenzo =20
> > > > >    =20
> > > > > >=20
> > > > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > > > ---
> > > > > >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 33 ++++++++++++=
+++-----
> > > > > >  1 file changed, 25 insertions(+), 8 deletions(-)
> > > > > >=20
> > > > > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/dri=
vers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > > > index 5e584c6026f1..d43b08ceec01 100644
> > > > > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > > > @@ -2457,22 +2457,36 @@ st_lsm6dsx_report_motion_event(struct s=
t_lsm6dsx_hw *hw)
> > > > > >  	return data & event_settings->wakeup_src_status_mask;
> > > > > >  }
> > > > > > =20
> > > > > > +static irqreturn_t st_lsm6dsx_handler_irq(int irq, void *priva=
te)
> > > > > > +{
> > > > > > +	return IRQ_WAKE_THREAD;
> > > > > > +}
> > > > > > +
> > > > > >  static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *pr=
ivate)
> > > > > >  {
> > > > > >  	struct st_lsm6dsx_hw *hw =3D private;
> > > > > > +	int fifo_len =3D 0, len =3D 0;
> > > > > >  	bool event;
> > > > > > -	int count;
> > > > > > =20
> > > > > >  	event =3D st_lsm6dsx_report_motion_event(hw);
> > > > > > =20
> > > > > >  	if (!hw->settings->fifo_ops.read_fifo)
> > > > > >  		return event ? IRQ_HANDLED : IRQ_NONE;
> > > > > > =20
> > > > > > -	mutex_lock(&hw->fifo_lock);
> > > > > > -	count =3D hw->settings->fifo_ops.read_fifo(hw);
> > > > > > -	mutex_unlock(&hw->fifo_lock);
> > > > > > +	/*
> > > > > > +	 * If we are using edge IRQs, new samples can arrive while
> > > > > > +	 * processing current IRQ and those may be missed unless we
> > > > > > +	 * pick them here, so let's try read FIFO status again
> > > > > > +	 */
> > > > > > +	do {
> > > > > > +		mutex_lock(&hw->fifo_lock);
> > > > > > +		len =3D hw->settings->fifo_ops.read_fifo(hw);
> > > > > > +		mutex_unlock(&hw->fifo_lock);
> > > > > > +
> > > > > > +		fifo_len +=3D len;
> > > > > > +	} while (len > 0);
> > > > > > =20
> > > > > > -	return count || event ? IRQ_HANDLED : IRQ_NONE;
> > > > > > +	return fifo_len || event ? IRQ_HANDLED : IRQ_NONE;
> > > > > >  }
> > > > > > =20
> > > > > >  static int st_lsm6dsx_irq_setup(struct st_lsm6dsx_hw *hw)
> > > > > > @@ -2488,10 +2502,14 @@ static int st_lsm6dsx_irq_setup(struct =
st_lsm6dsx_hw *hw)
> > > > > > =20
> > > > > >  	switch (irq_type) {
> > > > > >  	case IRQF_TRIGGER_HIGH:
> > > > > > +		irq_type |=3D IRQF_ONESHOT;
> > > > > > +		fallthrough;
> > > > > >  	case IRQF_TRIGGER_RISING:
> > > > > >  		irq_active_low =3D false;
> > > > > >  		break;
> > > > > >  	case IRQF_TRIGGER_LOW:
> > > > > > +		irq_type |=3D IRQF_ONESHOT;
> > > > > > +		fallthrough;
> > > > > >  	case IRQF_TRIGGER_FALLING:
> > > > > >  		irq_active_low =3D true;
> > > > > >  		break;
> > > > > > @@ -2520,10 +2538,9 @@ static int st_lsm6dsx_irq_setup(struct s=
t_lsm6dsx_hw *hw)
> > > > > >  	}
> > > > > > =20
> > > > > >  	err =3D devm_request_threaded_irq(hw->dev, hw->irq,
> > > > > > -					NULL,
> > > > > > +					st_lsm6dsx_handler_irq,
> > > > > >  					st_lsm6dsx_handler_thread,
> > > > > > -					irq_type | IRQF_ONESHOT,
> > > > > > -					"lsm6dsx", hw);
> > > > > > +					irq_type, "lsm6dsx", hw);
> > > > > >  	if (err) {
> > > > > >  		dev_err(hw->dev, "failed to request trigger irq %d\n",
> > > > > >  			hw->irq);   =20
> > > > >    =20
> > > >  =20
> > >  =20
>=20

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCX6g4jQAKCRA6cBh0uS2t
rJ5zAP9+KC98WpSex3TzLPyjk8kOPGtWcoIVNjalwhV8B2szhgEA8j3fL71/ZTLt
GilTr2viD1c6osfEr+uu2/M8FdQcTQg=
=DgYF
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
