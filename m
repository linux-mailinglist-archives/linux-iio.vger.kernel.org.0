Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9002A27FF
	for <lists+linux-iio@lfdr.de>; Mon,  2 Nov 2020 11:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbgKBKP2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Nov 2020 05:15:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:49966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728156AbgKBKP2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 2 Nov 2020 05:15:28 -0500
Received: from localhost (unknown [151.66.29.159])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12FFC2225E;
        Mon,  2 Nov 2020 10:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604312126;
        bh=k3B6axk3dItjKnk7B/9Xy/dmuvnOKqOaXu1O4aMsLAc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JsubJCrW0QaeV4blrb6oSSSpmZkSY5qHCMgqFKvbETem/xQM2OGsPybGtxWiXfxnm
         T66tC1+a0g3cWd5AG2zcwGcrma15TzSywe1AP7Vz4ISn9kFkHi8cKMV612OK2HDqkk
         WX+AtBMvtM15vTjx07CCqgECRSI11Y+Paaj8WZTo=
Date:   Mon, 2 Nov 2020 11:15:21 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, lorenzo.bianconi@redhat.com,
        mario.tesi@st.com, denis.ciocca@st.com, armando.visconti@st.com
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: fix edge-trigger interrupts
Message-ID: <20201102101521.GA229825@lore-desk>
References: <f48bee8fadf3383b2569c5d3e909b494976f979c.1603358530.git.lorenzo@kernel.org>
 <20201101163354.61ac7576@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
In-Reply-To: <20201101163354.61ac7576@archlinux>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, 22 Oct 2020 11:26:53 +0200
> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>=20
> > If the device is configured to trigger edge interrupts it is possible to
> > miss samples since the sensor can generate an interrupt while the driver
> > is still processing the previous one.
> > Poll FIFO status register to process all pending interrupts.
> > Configure IRQF_ONESHOT only for level interrupts.
>=20

Hi Jonathan,

thx for the review :)

> Hmm. This sort of case is often extremely prone to race conditions.
> I'd like to see more explanation of why we don't have one after this
> fix.  Edge interrupts for FIFOs are horrible!
>=20
> Dropping IRQF_ONESHOT should mean we enter the threaded handler with
> interrupts enabled, but if another one happens we still have to wait
> for the thread to finish before we schedule it again.
> We should only do that if we disabled the interrupt in the top half,
> which we haven't done here (you are working around the warnings
> that would be printed with the otherwise pointless top half).

looking at handle_edge_irq (please correct me if I am wrong) IRQF_ONESHOT
takes effect only for level interrupts while for edge-sensitive interrupts
the irq handler runs with the line unmasked. In fact the IRQF_ONESHOT part =
of
the patch seems not relevant for fixing the issue, I just aligned the code =
to
st_sensor general handling in st_sensors_allocate_trigger()
(https://elixir.bootlin.com/linux/v5.9.3/source/drivers/iio/common/st_senso=
rs/st_sensors_trigger.c#L182).
I think the issue is a new interrupt can fire while we are still processing
the previous one if watermark is low (e.g. 1) and the sensor is running at =
high
ODR (e.g. 833Hz). Reading again the status register in st_lsm6dsx_handler_t=
hread()
fixes the issue in my tests.
I guess we can just drop the IRQF_ONESHOT chunk and keep the while loop in
st_lsm6dsx_handler_thread(). What do you think?

>=20
> I 'assume' that the interrupts are latched.  So we won't get a new
> interrupt until we have taken some action to clear it?  In this
> case that action is removing items from the fifo?

I do not know :). Adding stm folks.
@mario, denis, armando: any pointer for this?

>=20
> IIRC, if we get an interrupt whilst it is masked due to IRQF_ONESHOT
> then it is left pending until we exit the thread.  So that should
> be sufficient to close a potential edge condition where we clear
> the fifo, and it immediately fires again.  This pending behaviour
> is necessary to avoid the race that would happen in any normal handler.

I did not get you on this point.

>=20
>=20
> Hmm. Having had a look at one of the datasheets, I'm far from convinced t=
hese
> parts truely support edge interrupts.  I can't see anything about minimum
> off periods etc that you need for true edge interrupts. Otherwise they are
> going to be prone to races.

@mario, denis, armando: any pointer for this?

>=20
> So I think the following can happen.
>=20
> A) We drain the fifo and it stays under the limit. Hence once that
>    is crossed in future we will interrupt as normal.
>=20
> B) We drain the fifo but it either has a very low watermark, or is
>    filling very fast.   We manage to drain enough to get the interrupt
>    to fire again, so all is fine if less than ideal.  With you loop we
>    may up entering the interrupt handler when we don't actually need to.
>    If you want to avoid that you would need to disable the interrupt,
>    then drain the fifo and finally do a dance to successfully reenable
>    the interrupt, whilst ensuring no chance of missing by checking it
>    should not have fired (still below the threshold)
>=20
> C) We try to drain the fifo, but it is actually filling fast enough that
>    we never get it under the limit, so no interrupt ever fires.
>    With new code, we'll keep spinning to 0 so might eventually drain it.
>    That needs a timeout so we just give up eventually.
>=20
> D) watershed is one sample, we drain low enough to successfully get down
>    to zero at the moment of the read, but very very soon after that we get
>    one sample again. There is a window in which the interrupt line dropped
>    but analogue electronics etc being what they are, it may not have been
>    detectable.  Hence we miss an interrupt...  What you are doing is redu=
cing
>    the chance of hitting this.  It is nasty, but you might be able to ens=
ure
>    a reasonable period by widening this window.  Limit the watermark to 2
>    samples? =20
>=20
> Also needs a fixes tag :)

ack, I will add them in v2

Regards,
Lorenzo
>=20
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 33 +++++++++++++++-----
> >  1 file changed, 25 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio=
/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > index 5e584c6026f1..d43b08ceec01 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > @@ -2457,22 +2457,36 @@ st_lsm6dsx_report_motion_event(struct st_lsm6ds=
x_hw *hw)
> >  	return data & event_settings->wakeup_src_status_mask;
> >  }
> > =20
> > +static irqreturn_t st_lsm6dsx_handler_irq(int irq, void *private)
> > +{
> > +	return IRQ_WAKE_THREAD;
> > +}
> > +
> >  static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)
> >  {
> >  	struct st_lsm6dsx_hw *hw =3D private;
> > +	int fifo_len =3D 0, len =3D 0;
> >  	bool event;
> > -	int count;
> > =20
> >  	event =3D st_lsm6dsx_report_motion_event(hw);
> > =20
> >  	if (!hw->settings->fifo_ops.read_fifo)
> >  		return event ? IRQ_HANDLED : IRQ_NONE;
> > =20
> > -	mutex_lock(&hw->fifo_lock);
> > -	count =3D hw->settings->fifo_ops.read_fifo(hw);
> > -	mutex_unlock(&hw->fifo_lock);
> > +	/*
> > +	 * If we are using edge IRQs, new samples can arrive while
> > +	 * processing current IRQ and those may be missed unless we
> > +	 * pick them here, so let's try read FIFO status again
> > +	 */
> > +	do {
> > +		mutex_lock(&hw->fifo_lock);
> > +		len =3D hw->settings->fifo_ops.read_fifo(hw);
> > +		mutex_unlock(&hw->fifo_lock);
> > +
> > +		fifo_len +=3D len;
> > +	} while (len > 0);
> > =20
> > -	return count || event ? IRQ_HANDLED : IRQ_NONE;
> > +	return fifo_len || event ? IRQ_HANDLED : IRQ_NONE;
> >  }
> > =20
> >  static int st_lsm6dsx_irq_setup(struct st_lsm6dsx_hw *hw)
> > @@ -2488,10 +2502,14 @@ static int st_lsm6dsx_irq_setup(struct st_lsm6d=
sx_hw *hw)
> > =20
> >  	switch (irq_type) {
> >  	case IRQF_TRIGGER_HIGH:
> > +		irq_type |=3D IRQF_ONESHOT;
> > +		fallthrough;
> >  	case IRQF_TRIGGER_RISING:
> >  		irq_active_low =3D false;
> >  		break;
> >  	case IRQF_TRIGGER_LOW:
> > +		irq_type |=3D IRQF_ONESHOT;
> > +		fallthrough;
> >  	case IRQF_TRIGGER_FALLING:
> >  		irq_active_low =3D true;
> >  		break;
> > @@ -2520,10 +2538,9 @@ static int st_lsm6dsx_irq_setup(struct st_lsm6ds=
x_hw *hw)
> >  	}
> > =20
> >  	err =3D devm_request_threaded_irq(hw->dev, hw->irq,
> > -					NULL,
> > +					st_lsm6dsx_handler_irq,
> >  					st_lsm6dsx_handler_thread,
> > -					irq_type | IRQF_ONESHOT,
> > -					"lsm6dsx", hw);
> > +					irq_type, "lsm6dsx", hw);
> >  	if (err) {
> >  		dev_err(hw->dev, "failed to request trigger irq %d\n",
> >  			hw->irq);
>=20

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCX5/cNgAKCRA6cBh0uS2t
rCZaAQCfjjsg0bgWZ2l8M6Qpz5C6MJQ+DwsEDHghMWgLRnGRCQEAlKyaf0TovZNP
/Qgqe6ALL4eP+8cPXV/5Fo93hWul8gI=
=d1uQ
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
