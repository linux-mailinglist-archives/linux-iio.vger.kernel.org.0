Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 592002B2F5D
	for <lists+linux-iio@lfdr.de>; Sat, 14 Nov 2020 18:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgKNR63 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 Nov 2020 12:58:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58881 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726070AbgKNR63 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 Nov 2020 12:58:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605376705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R6XE8AlnR5SFn5/8sKSFCp5MxpO6D9uSzawftIaK9ZI=;
        b=Pro4N6MKWdZF0EQqEq4UkkXxYI9h/Ek1MhCgXwsjbfl+c+wPvth+q7/mInOr66jJd7pi5W
        ioUgDCRWaOx78oQ/CLqP6lwhOL9uS8k9B/JrrMiTNXVCmkFoksYq8GPvmEbB7RjlnMLZIZ
        /VISlHunk2ciyBgCdVN03vCnwXeuTN8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-wE5cC4TNO2-NABv-_WINbg-1; Sat, 14 Nov 2020 12:58:20 -0500
X-MC-Unique: wE5cC4TNO2-NABv-_WINbg-1
Received: by mail-wm1-f69.google.com with SMTP id j62so5806408wma.4
        for <linux-iio@vger.kernel.org>; Sat, 14 Nov 2020 09:58:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R6XE8AlnR5SFn5/8sKSFCp5MxpO6D9uSzawftIaK9ZI=;
        b=RywXOrU0/dbk3O8t0n9i4bgVgBMMKi+zh1mMvt5eJBwbxUw4kif+Es1QdygE6cS53Y
         8jPJDJfe4pFKmo0v2tsxgRRrDAU4ju/Ll+HxnoLBeaJWzmpjDJIJmm3MjLuPOsNeJHW1
         Sh/oEaPul+OnX6e2TQ2OnYU7Qgj7gyBAx8acTgQQCkFeg63sBXJ9VVhPJ7kDKE5hMqb0
         Jz6igDTS5BQqUtA3vmdQl2m1QknwwhWWjhCdK33ipQieSGhKefMq9mhFA4+CzpyV8Buw
         aqw4r+jnidyP0D9NDuew3CPOPQJ27oeiBEuVozGE/rk5xJlOG+1lg2/S2wNLQGsaqb/P
         VYUQ==
X-Gm-Message-State: AOAM531QMHq37NiWLj2k3gY31mBppwY8P9X2R9frpgGyTSBAc4J3yF5F
        XzG12gRF5GlU4ynnJCksGrR8gl+S1BVeNPJrSI5r45RsCyTd00vlCZhN8iWdAySo2wGcM6F2eja
        1zARbYBN9BVya1GZ4PiNB
X-Received: by 2002:a5d:68cb:: with SMTP id p11mr10199996wrw.89.1605376699014;
        Sat, 14 Nov 2020 09:58:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwB4WaHN8l4pDItQ3Acs/PIVhhKse34LviPG3TrB2yiXM/s35ZV6Y88h5SDW/Qrs1lXNPCoeA==
X-Received: by 2002:a5d:68cb:: with SMTP id p11mr10199977wrw.89.1605376698772;
        Sat, 14 Nov 2020 09:58:18 -0800 (PST)
Received: from localhost ([151.66.8.153])
        by smtp.gmail.com with ESMTPSA id i5sm17233989wrw.45.2020.11.14.09.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2020 09:58:18 -0800 (PST)
Date:   Sat, 14 Nov 2020 18:58:14 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, mario.tesi@st.com, denis.ciocca@st.com,
        armando.visconti@st.com
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: fix edge-trigger interrupts
Message-ID: <20201114175814.GC3993@lore-desk>
References: <f48bee8fadf3383b2569c5d3e909b494976f979c.1603358530.git.lorenzo@kernel.org>
 <20201101163354.61ac7576@archlinux>
 <20201102101521.GA229825@lore-desk>
 <20201102174450.0000077e@Huawei.com>
 <20201102181842.GC229825@lore-desk>
 <20201108164942.094e1112@archlinux>
 <20201108182728.GA17810@lore-desk>
 <20201114150630.6d8401a6@archlinux>
 <20201114164840.GA3993@lore-desk>
 <20201114173100.0d6ce33e@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="adJ1OR3c6QgCpb/j"
Content-Disposition: inline
In-Reply-To: <20201114173100.0d6ce33e@archlinux>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--adJ1OR3c6QgCpb/j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sat, 14 Nov 2020 17:48:40 +0100
> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>=20
> > > On Sun, 8 Nov 2020 19:27:28 +0100
> > > Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> > >  =20
> > [...]
> > >=20
> > > So the thing I've been trying to say badly here is that I'm fairly su=
re the
> > > issue isn't what you think it is at all.  (Note I've spent a lot of
> > > time with scopes on interrupt lines looking for similar issues - it's
> > > not fun).
> > >=20
> > > I think the actual condition here is that you have an interrupt that =
is not
> > > guaranteed to go low for long enough between being cleared and set.  =
Thus if you are
> > > read the fifo at almost exactly the moment new data is written you ma=
y in theory
> > > have the interrupt drop, but in practice analog electronics kicks in =
an you won't
> > > get an interrupt detected at all. This why the sensor needs to put gu=
arantees
> > > on that drop time (some do - but I'm not seeing in datasheet for this=
 one).
> > > On a more mundane note, I'm not sure in this case that there is a gua=
rantee
> > > it will ever drop even in theory - this buffer could for this short p=
eriod be
> > > filling faster than we drain it. =20
> >=20
> > ack, very nice explanation :)
> >=20
> > >=20
> > > The reason your change makes this much less likely to happen is that,=
 by checking
> > > again you are generally much closer to the time of the change of the =
level in
> > > the fifo.  Thus, unless you are preempted you should clear it long be=
fore it
> > > would be set again, and thus get a nice clean drop on the interrupt.
> > >=20
> > > So for some asci art  =20
> >=20
> > very nice :)
> >=20
> > >=20
> > > Previously we have
> > >=20
> > > data samples       |       |       |
> > >                           _
> > > Read of fifo   ___________|_____=20
> > >                     _______ _____________
> > > interrupt line ____|       |              Interrupt stuck high as edg=
e missed.
> > >                            ^      =20
> > >                            1      =20
> > >=20
> > > With your fix
> > >=20
> > > data samples       |       |       |
> > >                           _
> > > Read of fifo   ___________|__|__=20
> > >                     _______ __
> > > interrupt line ____|       |  |____|
> > >                            ^       ^
> > >                            1       2
> > >=20
> > > So we would have missed 1, but because we check the fifo level again =
immediate
> > > after we would have made it drop, if we hit this unfortunately timing=
 we will
> > > very quickly pull new data from the sensor and result in a drop well =
before the
> > > next interrupt comes in. =20
> >=20
> > in the last case, even if we introduce a little bit of burstiness, I gu=
ess it
> > works because we read both 1 and 2, right?
>=20
> We should always be fine, because the extra check must take a bit of time=
=2E Either
> the event happens after that time (in which case the interrupt will have =
been low
> long enough) or it doesn't and we will catch it.
>=20
> >=20
> > >=20
> > >  =20
> > > >=20

[...]

> > I do not know about it, I just received a report about the issue from s=
tm folks.
> > I am fine to drop support for edge interrupts but do we have a similar =
issue for
> > st sensors (acc, magn, gyro) as well? Please consider:
> > https://elixir.bootlin.com/linux/latest/source/drivers/iio/common/st_se=
nsors/st_sensors_trigger.c#L113
>=20
> It was a part now supported by that driver that I hit this issue on
> years ago.  As a side note, there is a bug in there though, be it one we
> probably can't hit?  stat_drdy has to be defined, if not the while loop w=
ill get
> a negative back (which is true) and loop for ever. =20
>=20
> https://elixir.bootlin.com/linux/latest/source/drivers/iio/common/st_sens=
ors/st_sensors_trigger.c#L36
> Probably want's to return 0 but print an error message.  Whilst there eve=
n better
> if that function just returns a boolean so we cant accidentally put such =
a bug
> back in again in future.

ack, I agree. I can post a fix but I have no device for testing.

>=20
> Lets go with your fix, but perhaps we should add a note to the dt binding=
 to
> say level interrupts preferred?  Saving a check or two in the common case=
 is
> definitely beneficial if the host supports level interrupts.
>=20
> If you can do a v3 with updated explanation and comments that would be gr=
eat.

sure, I will add some comments to v2 and post v3.

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
> > >=20
> > > Jonathan =20
> > > >=20
> > > > Regards,
> > > > Lorenzo
> > > >  =20
> > > > >=20
> > > > > Jonathan
> > > > >=20
> > > > >=20
> > > > >=20
> > > > >    =20
> > > > > >=20
> > > > > > Regards,
> > > > > > Lorenzo
> > > > > >    =20
> > > > > > >      =20
> > > > > > > >      =20
> > > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > > Hmm. Having had a look at one of the datasheets, I'm far =
=66rom convinced these
> > > > > > > > > parts truely support edge interrupts.  I can't see anythi=
ng about minimum
> > > > > > > > > off periods etc that you need for true edge interrupts. O=
therwise they are
> > > > > > > > > going to be prone to races.       =20
> > > > > > > >=20
> > > > > > > > @mario, denis, armando: any pointer for this?
> > > > > > > >      =20
> > > > > > > > >=20
> > > > > > > > > So I think the following can happen.
> > > > > > > > >=20
> > > > > > > > > A) We drain the fifo and it stays under the limit. Hence =
once that
> > > > > > > > >    is crossed in future we will interrupt as normal.
> > > > > > > > >=20
> > > > > > > > > B) We drain the fifo but it either has a very low waterma=
rk, or is
> > > > > > > > >    filling very fast.   We manage to drain enough to get =
the interrupt
> > > > > > > > >    to fire again, so all is fine if less than ideal.  Wit=
h you loop we
> > > > > > > > >    may up entering the interrupt handler when we don't ac=
tually need to.
> > > > > > > > >    If you want to avoid that you would need to disable th=
e interrupt,
> > > > > > > > >    then drain the fifo and finally do a dance to successf=
ully reenable
> > > > > > > > >    the interrupt, whilst ensuring no chance of missing by=
 checking it
> > > > > > > > >    should not have fired (still below the threshold)
> > > > > > > > >=20
> > > > > > > > > C) We try to drain the fifo, but it is actually filling f=
ast enough that
> > > > > > > > >    we never get it under the limit, so no interrupt ever =
fires.
> > > > > > > > >    With new code, we'll keep spinning to 0 so might event=
ually drain it.
> > > > > > > > >    That needs a timeout so we just give up eventually.
> > > > > > > > >=20
> > > > > > > > > D) watershed is one sample, we drain low enough to succes=
sfully get down
> > > > > > > > >    to zero at the moment of the read, but very very soon =
after that we get
> > > > > > > > >    one sample again. There is a window in which the inter=
rupt line dropped
> > > > > > > > >    but analogue electronics etc being what they are, it m=
ay not have been
> > > > > > > > >    detectable.  Hence we miss an interrupt...  What you a=
re doing is reducing
> > > > > > > > >    the chance of hitting this.  It is nasty, but you migh=
t be able to ensure
> > > > > > > > >    a reasonable period by widening this window.  Limit th=
e watermark to 2
> > > > > > > > >    samples? =20
> > > > > > > > >=20
> > > > > > > > > Also needs a fixes tag :)       =20
> > > > > > > >=20
> > > > > > > > ack, I will add them in v2
> > > > > > > >=20
> > > > > > > > Regards,
> > > > > > > > Lorenzo     =20
> > > > > > > > >        =20
> > > > > > > > > >=20
> > > > > > > > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > > > > > > > ---
> > > > > > > > > >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 33 ++++=
+++++++++++-----
> > > > > > > > > >  1 file changed, 25 insertions(+), 8 deletions(-)
> > > > > > > > > >=20
> > > > > > > > > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core=
=2Ec b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > > > > > > > index 5e584c6026f1..d43b08ceec01 100644
> > > > > > > > > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > > > > > > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > > > > > > > @@ -2457,22 +2457,36 @@ st_lsm6dsx_report_motion_event(=
struct st_lsm6dsx_hw *hw)
> > > > > > > > > >  	return data & event_settings->wakeup_src_status_mask;
> > > > > > > > > >  }
> > > > > > > > > > =20
> > > > > > > > > > +static irqreturn_t st_lsm6dsx_handler_irq(int irq, voi=
d *private)
> > > > > > > > > > +{
> > > > > > > > > > +	return IRQ_WAKE_THREAD;
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > >  static irqreturn_t st_lsm6dsx_handler_thread(int irq, =
void *private)
> > > > > > > > > >  {
> > > > > > > > > >  	struct st_lsm6dsx_hw *hw =3D private;
> > > > > > > > > > +	int fifo_len =3D 0, len =3D 0;
> > > > > > > > > >  	bool event;
> > > > > > > > > > -	int count;
> > > > > > > > > > =20
> > > > > > > > > >  	event =3D st_lsm6dsx_report_motion_event(hw);
> > > > > > > > > > =20
> > > > > > > > > >  	if (!hw->settings->fifo_ops.read_fifo)
> > > > > > > > > >  		return event ? IRQ_HANDLED : IRQ_NONE;
> > > > > > > > > > =20
> > > > > > > > > > -	mutex_lock(&hw->fifo_lock);
> > > > > > > > > > -	count =3D hw->settings->fifo_ops.read_fifo(hw);
> > > > > > > > > > -	mutex_unlock(&hw->fifo_lock);
> > > > > > > > > > +	/*
> > > > > > > > > > +	 * If we are using edge IRQs, new samples can arrive =
while
> > > > > > > > > > +	 * processing current IRQ and those may be missed unl=
ess we
> > > > > > > > > > +	 * pick them here, so let's try read FIFO status again
> > > > > > > > > > +	 */
> > > > > > > > > > +	do {
> > > > > > > > > > +		mutex_lock(&hw->fifo_lock);
> > > > > > > > > > +		len =3D hw->settings->fifo_ops.read_fifo(hw);
> > > > > > > > > > +		mutex_unlock(&hw->fifo_lock);
> > > > > > > > > > +
> > > > > > > > > > +		fifo_len +=3D len;
> > > > > > > > > > +	} while (len > 0);
> > > > > > > > > > =20
> > > > > > > > > > -	return count || event ? IRQ_HANDLED : IRQ_NONE;
> > > > > > > > > > +	return fifo_len || event ? IRQ_HANDLED : IRQ_NONE;
> > > > > > > > > >  }
> > > > > > > > > > =20
> > > > > > > > > >  static int st_lsm6dsx_irq_setup(struct st_lsm6dsx_hw *=
hw)
> > > > > > > > > > @@ -2488,10 +2502,14 @@ static int st_lsm6dsx_irq_setup=
(struct st_lsm6dsx_hw *hw)
> > > > > > > > > > =20
> > > > > > > > > >  	switch (irq_type) {
> > > > > > > > > >  	case IRQF_TRIGGER_HIGH:
> > > > > > > > > > +		irq_type |=3D IRQF_ONESHOT;
> > > > > > > > > > +		fallthrough;
> > > > > > > > > >  	case IRQF_TRIGGER_RISING:
> > > > > > > > > >  		irq_active_low =3D false;
> > > > > > > > > >  		break;
> > > > > > > > > >  	case IRQF_TRIGGER_LOW:
> > > > > > > > > > +		irq_type |=3D IRQF_ONESHOT;
> > > > > > > > > > +		fallthrough;
> > > > > > > > > >  	case IRQF_TRIGGER_FALLING:
> > > > > > > > > >  		irq_active_low =3D true;
> > > > > > > > > >  		break;
> > > > > > > > > > @@ -2520,10 +2538,9 @@ static int st_lsm6dsx_irq_setup(=
struct st_lsm6dsx_hw *hw)
> > > > > > > > > >  	}
> > > > > > > > > > =20
> > > > > > > > > >  	err =3D devm_request_threaded_irq(hw->dev, hw->irq,
> > > > > > > > > > -					NULL,
> > > > > > > > > > +					st_lsm6dsx_handler_irq,
> > > > > > > > > >  					st_lsm6dsx_handler_thread,
> > > > > > > > > > -					irq_type | IRQF_ONESHOT,
> > > > > > > > > > -					"lsm6dsx", hw);
> > > > > > > > > > +					irq_type, "lsm6dsx", hw);
> > > > > > > > > >  	if (err) {
> > > > > > > > > >  		dev_err(hw->dev, "failed to request trigger irq %d\n=
",
> > > > > > > > > >  			hw->irq);       =20
> > > > > > > > >        =20
> > > > > > > >      =20
> > > > > > >      =20
> > > > >    =20
> > >  =20
>=20

--adJ1OR3c6QgCpb/j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCX7AasgAKCRA6cBh0uS2t
rAQjAQCQLL7mDq/neZJGwgwn+IFkjCYWuNNfgPrFuL0qUQlNKgEAl10b0TlRW1bh
3oKqbI/SeXEvqTUwrckmOo27rOGwag4=
=3cnk
-----END PGP SIGNATURE-----

--adJ1OR3c6QgCpb/j--

