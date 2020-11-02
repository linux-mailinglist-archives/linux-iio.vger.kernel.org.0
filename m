Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7BB82A32C0
	for <lists+linux-iio@lfdr.de>; Mon,  2 Nov 2020 19:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725797AbgKBSSz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Nov 2020 13:18:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37311 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725801AbgKBSSy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Nov 2020 13:18:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604341132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v/gvidkw7p7zmb7WUrYuf+STIsmAizvwcKMnuBKrX9Q=;
        b=f7Td6i3GD47RaCTa9Lx711I5A/NIW9sL15CZQalC4ahTKFrNdDOuR1hbG1qMBT7XzXFCwL
        k+MYBlJk6VfjbxPExenVdMlr8rrMYRZX9PQ77jVB5m6slZZHnX6nfgcJRqu4/2tv1ddQW4
        P205Yddxq+bY6lfu59FaUkA11v1NF2Y=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-nHFkOPfqOvyNwrcFwj32iA-1; Mon, 02 Nov 2020 13:18:48 -0500
X-MC-Unique: nHFkOPfqOvyNwrcFwj32iA-1
Received: by mail-wm1-f69.google.com with SMTP id 13so3651083wmf.0
        for <linux-iio@vger.kernel.org>; Mon, 02 Nov 2020 10:18:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v/gvidkw7p7zmb7WUrYuf+STIsmAizvwcKMnuBKrX9Q=;
        b=GTFbdSkJePootF1Dkmlr2eiDx+DjZcw0wi5I0zoS10LELUc+mTEkvT3nTGIheGnGLi
         ARWwWd+pglkUJrVVGu/BnBXScbEtLTV7Na03QzsalrIT1s8ppHrH/db9W9U0J/1X/Pk0
         7m9WzYjVMfBehd54D3PpJWhIdoC3IVFONZEUu+L8vA8hnxuFNyGA3qQUzffAAJc7jbc/
         6YBImvXRei/H8hWK3eZX0dYYcF6al5OMPPDphfbPTWxgLoJ4R2IZyLI6QgmYC3Jvsg/g
         ewbeHj7hZCEH3fbun4BFcMBf35GoFF9zWGt4ScYAc9p+bmErKrTvI3dE0S5CJLrefcwR
         JmEw==
X-Gm-Message-State: AOAM533POMfKIsAFnG83uMYGx8NpxS3u81VI3fAD5kNbzR34tqCeqLbI
        j6IwBNNyEn0M09KGANfXNIvB+ieZ1jnarvbre1rD4T4+N+q4tR1sPdCZEqVPbpjRupgoVOYSHyC
        dV20lrg6gaJZxXFTMTuHu
X-Received: by 2002:a5d:4ed2:: with SMTP id s18mr21533286wrv.36.1604341126793;
        Mon, 02 Nov 2020 10:18:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz6b0dI2riEUBhTI06fVMrnNBLJDWDx21wtzbueqX3TocxuwtjlcZ70sEuax8EPGRXPtWklyA==
X-Received: by 2002:a5d:4ed2:: with SMTP id s18mr21533248wrv.36.1604341126444;
        Mon, 02 Nov 2020 10:18:46 -0800 (PST)
Received: from localhost ([151.66.29.159])
        by smtp.gmail.com with ESMTPSA id u3sm23623255wrq.19.2020.11.02.10.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 10:18:45 -0800 (PST)
Date:   Mon, 2 Nov 2020 19:18:42 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        mario.tesi@st.com, denis.ciocca@st.com, armando.visconti@st.com
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: fix edge-trigger interrupts
Message-ID: <20201102181842.GC229825@lore-desk>
References: <f48bee8fadf3383b2569c5d3e909b494976f979c.1603358530.git.lorenzo@kernel.org>
 <20201101163354.61ac7576@archlinux>
 <20201102101521.GA229825@lore-desk>
 <20201102174450.0000077e@Huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4ZLFUWh1odzi/v6L"
Content-Disposition: inline
In-Reply-To: <20201102174450.0000077e@Huawei.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--4ZLFUWh1odzi/v6L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, 2 Nov 2020 11:15:21 +0100
> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>=20
> > > On Thu, 22 Oct 2020 11:26:53 +0200
> > > Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> > >  =20
> > > > If the device is configured to trigger edge interrupts it is possib=
le to
> > > > miss samples since the sensor can generate an interrupt while the d=
river
> > > > is still processing the previous one.
> > > > Poll FIFO status register to process all pending interrupts.
> > > > Configure IRQF_ONESHOT only for level interrupts. =20
> > >  =20
> >=20
> > Hi Jonathan,
> >=20
> > thx for the review :)
> >=20
> > > Hmm. This sort of case is often extremely prone to race conditions.
> > > I'd like to see more explanation of why we don't have one after this
> > > fix.  Edge interrupts for FIFOs are horrible!
> > >=20
> > > Dropping IRQF_ONESHOT should mean we enter the threaded handler with
> > > interrupts enabled, but if another one happens we still have to wait
> > > for the thread to finish before we schedule it again.
> > > We should only do that if we disabled the interrupt in the top half,
> > > which we haven't done here (you are working around the warnings
> > > that would be printed with the otherwise pointless top half). =20
> >=20
> > looking at handle_edge_irq (please correct me if I am wrong) IRQF_ONESH=
OT
> > takes effect only for level interrupts while for edge-sensitive interru=
pts
> > the irq handler runs with the line unmasked. In fact the IRQF_ONESHOT p=
art of
> > the patch seems not relevant for fixing the issue, I just aligned the c=
ode to
> > st_sensor general handling in st_sensors_allocate_trigger()
> > (https://elixir.bootlin.com/linux/v5.9.3/source/drivers/iio/common/st_s=
ensors/st_sensors_trigger.c#L182).
> > I think the issue is a new interrupt can fire while we are still proces=
sing
> > the previous one if watermark is low (e.g. 1) and the sensor is running=
 at high
> > ODR (e.g. 833Hz). Reading again the status register in st_lsm6dsx_handl=
er_thread()
> > fixes the issue in my tests.
> > I guess we can just drop the IRQF_ONESHOT chunk and keep the while loop=
 in
> > st_lsm6dsx_handler_thread(). What do you think?
>=20
> I'd do that.

ack, I will post a v2 with only this change.

>=20
> >=20
> > >=20
> > > I 'assume' that the interrupts are latched.  So we won't get a new
> > > interrupt until we have taken some action to clear it?  In this
> > > case that action is removing items from the fifo? =20
> >=20
> > I do not know :). Adding stm folks.
> > @mario, denis, armando: any pointer for this?
> >=20
> > >=20
> > > IIRC, if we get an interrupt whilst it is masked due to IRQF_ONESHOT
> > > then it is left pending until we exit the thread.  So that should
> > > be sufficient to close a potential edge condition where we clear
> > > the fifo, and it immediately fires again.  This pending behaviour
> > > is necessary to avoid the race that would happen in any normal handle=
r. =20
> >=20
> > I did not get you on this point.
>=20
> If an interrupt occurs, even whilst we have it masked, we shouldn't
> loose it.  If we did so then any normal handler that clears the interrupt
> at the end of doing whatever it needs to do would race against a new inte=
rrupt.
>=20
> So my suspicion is that you aren't actually missing an interrupt, but rat=
her the
> drop time is too short to be detected (or effectively not there at all).

I guess since edge interrupts run with the line unmasked a new interrupt ca=
n fire
while the irq thread is still running (so wake_up_process() will just retur=
n) but
the driver has already read fifo_status register and so it will not read new
sample. This case should be fixed reading again the fifo_status register.

Regards,
Lorenzo

>=20
> >=20
> > >=20
> > >=20
> > > Hmm. Having had a look at one of the datasheets, I'm far from convinc=
ed these
> > > parts truely support edge interrupts.  I can't see anything about min=
imum
> > > off periods etc that you need for true edge interrupts. Otherwise the=
y are
> > > going to be prone to races. =20
> >=20
> > @mario, denis, armando: any pointer for this?
> >=20
> > >=20
> > > So I think the following can happen.
> > >=20
> > > A) We drain the fifo and it stays under the limit. Hence once that
> > >    is crossed in future we will interrupt as normal.
> > >=20
> > > B) We drain the fifo but it either has a very low watermark, or is
> > >    filling very fast.   We manage to drain enough to get the interrupt
> > >    to fire again, so all is fine if less than ideal.  With you loop we
> > >    may up entering the interrupt handler when we don't actually need =
to.
> > >    If you want to avoid that you would need to disable the interrupt,
> > >    then drain the fifo and finally do a dance to successfully reenable
> > >    the interrupt, whilst ensuring no chance of missing by checking it
> > >    should not have fired (still below the threshold)
> > >=20
> > > C) We try to drain the fifo, but it is actually filling fast enough t=
hat
> > >    we never get it under the limit, so no interrupt ever fires.
> > >    With new code, we'll keep spinning to 0 so might eventually drain =
it.
> > >    That needs a timeout so we just give up eventually.
> > >=20
> > > D) watershed is one sample, we drain low enough to successfully get d=
own
> > >    to zero at the moment of the read, but very very soon after that w=
e get
> > >    one sample again. There is a window in which the interrupt line dr=
opped
> > >    but analogue electronics etc being what they are, it may not have =
been
> > >    detectable.  Hence we miss an interrupt...  What you are doing is =
reducing
> > >    the chance of hitting this.  It is nasty, but you might be able to=
 ensure
> > >    a reasonable period by widening this window.  Limit the watermark =
to 2
> > >    samples? =20
> > >=20
> > > Also needs a fixes tag :) =20
> >=20
> > ack, I will add them in v2
> >=20
> > Regards,
> > Lorenzo
> > >  =20
> > > >=20
> > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > ---
> > > >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 33 +++++++++++++++-=
----
> > > >  1 file changed, 25 insertions(+), 8 deletions(-)
> > > >=20
> > > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers=
/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > index 5e584c6026f1..d43b08ceec01 100644
> > > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > @@ -2457,22 +2457,36 @@ st_lsm6dsx_report_motion_event(struct st_ls=
m6dsx_hw *hw)
> > > >  	return data & event_settings->wakeup_src_status_mask;
> > > >  }
> > > > =20
> > > > +static irqreturn_t st_lsm6dsx_handler_irq(int irq, void *private)
> > > > +{
> > > > +	return IRQ_WAKE_THREAD;
> > > > +}
> > > > +
> > > >  static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *privat=
e)
> > > >  {
> > > >  	struct st_lsm6dsx_hw *hw =3D private;
> > > > +	int fifo_len =3D 0, len =3D 0;
> > > >  	bool event;
> > > > -	int count;
> > > > =20
> > > >  	event =3D st_lsm6dsx_report_motion_event(hw);
> > > > =20
> > > >  	if (!hw->settings->fifo_ops.read_fifo)
> > > >  		return event ? IRQ_HANDLED : IRQ_NONE;
> > > > =20
> > > > -	mutex_lock(&hw->fifo_lock);
> > > > -	count =3D hw->settings->fifo_ops.read_fifo(hw);
> > > > -	mutex_unlock(&hw->fifo_lock);
> > > > +	/*
> > > > +	 * If we are using edge IRQs, new samples can arrive while
> > > > +	 * processing current IRQ and those may be missed unless we
> > > > +	 * pick them here, so let's try read FIFO status again
> > > > +	 */
> > > > +	do {
> > > > +		mutex_lock(&hw->fifo_lock);
> > > > +		len =3D hw->settings->fifo_ops.read_fifo(hw);
> > > > +		mutex_unlock(&hw->fifo_lock);
> > > > +
> > > > +		fifo_len +=3D len;
> > > > +	} while (len > 0);
> > > > =20
> > > > -	return count || event ? IRQ_HANDLED : IRQ_NONE;
> > > > +	return fifo_len || event ? IRQ_HANDLED : IRQ_NONE;
> > > >  }
> > > > =20
> > > >  static int st_lsm6dsx_irq_setup(struct st_lsm6dsx_hw *hw)
> > > > @@ -2488,10 +2502,14 @@ static int st_lsm6dsx_irq_setup(struct st_l=
sm6dsx_hw *hw)
> > > > =20
> > > >  	switch (irq_type) {
> > > >  	case IRQF_TRIGGER_HIGH:
> > > > +		irq_type |=3D IRQF_ONESHOT;
> > > > +		fallthrough;
> > > >  	case IRQF_TRIGGER_RISING:
> > > >  		irq_active_low =3D false;
> > > >  		break;
> > > >  	case IRQF_TRIGGER_LOW:
> > > > +		irq_type |=3D IRQF_ONESHOT;
> > > > +		fallthrough;
> > > >  	case IRQF_TRIGGER_FALLING:
> > > >  		irq_active_low =3D true;
> > > >  		break;
> > > > @@ -2520,10 +2538,9 @@ static int st_lsm6dsx_irq_setup(struct st_ls=
m6dsx_hw *hw)
> > > >  	}
> > > > =20
> > > >  	err =3D devm_request_threaded_irq(hw->dev, hw->irq,
> > > > -					NULL,
> > > > +					st_lsm6dsx_handler_irq,
> > > >  					st_lsm6dsx_handler_thread,
> > > > -					irq_type | IRQF_ONESHOT,
> > > > -					"lsm6dsx", hw);
> > > > +					irq_type, "lsm6dsx", hw);
> > > >  	if (err) {
> > > >  		dev_err(hw->dev, "failed to request trigger irq %d\n",
> > > >  			hw->irq); =20
> > >  =20
> >=20
>=20

--4ZLFUWh1odzi/v6L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCX6BNgAAKCRA6cBh0uS2t
rDQJAQDfCm8xq6+myjXjtEUdUJdelMiTCrtqF9HVe7WIiP1xPgD/ZcSDlF7IjFvP
TNVU9DONNwwP8CM8KdzaI26XXq1r3QY=
=Nyd2
-----END PGP SIGNATURE-----

--4ZLFUWh1odzi/v6L--

