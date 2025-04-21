Return-Path: <linux-iio+bounces-18451-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C90A95209
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 15:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 605E53B2902
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 13:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967DA26656F;
	Mon, 21 Apr 2025 13:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mbPi7tsl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5223E26560B;
	Mon, 21 Apr 2025 13:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745243664; cv=none; b=QjJwEOJ8HvRFI9y3BSwGqzrmk24HF73HXksto48bZGcc2KCXCvLdfLvqJ1VDLylLIA6gcfooAbyHsv0OD+Q3cSuq4kGdlwRWdwSv/G/v/Z42cyZlFrPbaEq4WAqqm8gZH6zy5Vp0VtY9T/7LSL0F+jdAq5YZ+DCKfvJFnFL5tkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745243664; c=relaxed/simple;
	bh=rU7Ggx3GhiggYhFh1HE1Uv7111GkC/g9wfMSFuv1JSY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aDPKKKQFsSReFQP1JOzs6A2ymtB6uSAUBR59x7DGYMom5KkljR0H0oFVO+JVDOJg4PVKFlE76BKFsF7oUBeEY8ccy7ntIDalhjIYQhgA21nrDRFM1SJ9FID7ItRPNkcyD5uFzG4TU+O/zp06GrcskbXWZwcK4kNnNO/JklPU4g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mbPi7tsl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A115C4CEE4;
	Mon, 21 Apr 2025 13:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745243664;
	bh=rU7Ggx3GhiggYhFh1HE1Uv7111GkC/g9wfMSFuv1JSY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mbPi7tsloXCZnRjTCL5o0yiF9pXM0BdgvJ0ARufgEdyUySammASRwoSBhV75vQo0E
	 2w3YpLxxUz1MH/2Ik7uRmIdlUtzfFGBOHyQaUWj7t8bOQB1jy9L8uAgpt5lhBu/7SK
	 2zsraq4VoTDpAAlFa8NJzRIWbw1THFNgORe056KW1lF0q+h3SjxI+fFBDgwakejFkQ
	 1CWhqraZV6BLBFEeWBBrWMN1NLOgYacnmNzl6kJ1BF30AxcKsjtQ+b6DvZGM3Kpdt5
	 Q8RtmU31aTjX2Tsx1q8NV7kz5lLxg9+DfgawbX/7U08ObJ1gMK3uk2ucx5KD3UBSnb
	 LGRS3NXBDiUkw==
Date: Mon, 21 Apr 2025 14:54:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v6 09/11] iio: accel: adxl345: add inactivity feature
Message-ID: <20250421145417.571b862a@jic23-huawei>
In-Reply-To: <CAFXKEHYsMKHMYoBq7U5n02=0wnVmp0_CUrbvxxFFRLJDayS7Kg@mail.gmail.com>
References: <20250414184245.100280-1-l.rubusch@gmail.com>
	<20250414184245.100280-10-l.rubusch@gmail.com>
	<20250418193411.406bd974@jic23-huawei>
	<CAFXKEHary=PcCh3GEEXznJQgcxj54ZmGR0jmzBdpx8ZVtk2_0g@mail.gmail.com>
	<20250421112228.453dfa89@jic23-huawei>
	<CAFXKEHYsMKHMYoBq7U5n02=0wnVmp0_CUrbvxxFFRLJDayS7Kg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 21 Apr 2025 15:39:33 +0200
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> On Mon, Apr 21, 2025 at 12:22=E2=80=AFPM Jonathan Cameron <jic23@kernel.o=
rg> wrote:
> >
> > On Mon, 21 Apr 2025 00:12:17 +0200
> > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > =20
> > > Happy Easter (again)!
> > >
> > > On Fri, Apr 18, 2025 at 8:34=E2=80=AFPM Jonathan Cameron <jic23@kerne=
l.org> wrote: =20
> > > >
> > > > On Mon, 14 Apr 2025 18:42:43 +0000
> > > > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > > > =20
> > > > > Add the inactivity feature of the sensor. When activity and inact=
ivity
> > > > > are enabled, a link bit will be set linking activity and inactivi=
ty
> > > > > handling. Additionally, the auto-sleep mode will be enabled. Due =
to the
> > > > > link bit the sensor is going to auto-sleep when inactivity was
> > > > > detected.
> > > > >
> > > > > Inactivity detection needs a threshold to be configured, and a ti=
me
> > > > > after which it will go into inactivity state if measurements under
> > > > > threshold.
> > > > >
> > > > > When a ODR is configured this time for inactivity is adjusted wit=
h a
> > > > > corresponding reasonable default value, in order to have higher
> > > > > frequencies and lower inactivity times, and lower sample frequenc=
y but
> > > > > give more time until inactivity. Both with reasonable upper and l=
ower
> > > > > boundaries, since many of the sensor's features (e.g. auto-sleep)=
 will
> > > > > need to operate beween 12.5 Hz and 400 Hz. This is a default sett=
ing
> > > > > when actively changing sample frequency, explicitly setting the t=
ime
> > > > > until inactivity will overwrite the default.
> > > > >
> > > > > Similarly, setting the g-range will provide a default value for t=
he
> > > > > activity and inactivity thresholds. Both are implicit defaults, b=
ut
> > > > > equally can be overwritten to be explicitly configured.
> > > > >
> > > > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com> =20
> > > > Hi Lothar,
> > > >
> > > > Patches 6-8 look good to me.
> > > >
> > > > This runs into a similar issue to the freefall one. I haven't dug i=
nto
> > > > the datasheet but does it report on one channel going inactive, or
> > > > all being inactive at the same time?  I checked and it is the all
> > > > case so we should be both on a pseudo channel to describe it right
> > > > and reporting IIO_MOD_X_AND_Y_AND_Z not the OR form.
> > > >
> > > > Sorry again that I'm only realising this on v6 :( =20
> > >
> > > No problem at all! Sure, I'm still in this phase where counting every
> > > single commit upstream makes my ego greater. On the long run, though,
> > > I guess it's better to build up knowledge and end up with a decent
> > > implementation quality, than just increasing a commit counter. For me
> > > it's fine. I also hope it's not too annoying for you.
> > > =20
> > > >
> > > > Difference is for Activity the definition is:
> > > > "The activity bit is set when acceleration greater than the value
> > > > stored in the THRESH_ACT register (Address 0x24) is experienced
> > > > on _any_ participating axis, set by the ACT_INACT_CTL register
> > > > (Address 0x27)."
> > > > vs Inactivity:
> > > > "The inactivity bit is set when acceleration of less than the value
> > > > stored in the THRESH_INACT register (Address 0x25) is experienced
> > > > for more time than is specified in the TIME_INACT
> > > > register (Address 0x26) on _all_ participating axes, as set by the
> > > > ACT_INACT_CTL register (Address 0x27). "
> > > >
> > > > So all vs any.
> > > > =20
> > >
> > > I think I  see your point. At least I change here for inactivity, too,
> > > to AND'ed axis.
> > >
> > > IMHO, if I set OR here, the first axis raising the inactivity will put
> > > the sensor to sleep mode,
> > > where AND needs all three axis in inactivity state. I'm not sure if
> > > this works out, I need to verify
> > > it still with the hardware, for now I'll change this to AND. =20
> >
> > I'd be surprised if it worked differently but indeed good to check!
> > =20
> > > =20
> > > > > +
> > > > > +/**
> > > > > + * adxl345_set_inact_time_s - Configure inactivity time explicit=
ly or by ODR.
> > > > > + * @st: The sensor state instance.
> > > > > + * @val_s: A desired time value, between 0 and 255.
> > > > > + *
> > > > > + * Inactivity time can be configured between 1 and 255 sec. If a=
 val_s of 0
> > > > > + * is configured by a user, then a default inactivity time will =
be computed.
> > > > > + *
> > > > > + * In such case, it should take power consumption into considera=
tion. Thus it
> > > > > + * shall be shorter for higher frequencies and longer for lower =
frequencies.
> > > > > + * Hence, frequencies above 255 Hz shall default to 10 s and fre=
quencies below
> > > > > + * 10 Hz shall result in 255 s to detect inactivity.
> > > > > + *
> > > > > + * The approach simply subtracts the pre-decimal figure of the c=
onfigured
> > > > > + * sample frequency from 255 s to compute inactivity time [s]. S=
ub-Hz are thus
> > > > > + * ignored in this estimation. The recommended ODRs for various =
features
> > > > > + * (activity/inactivity, sleep modes, free fall, etc.) lie betwe=
en 12.5 Hz and
> > > > > + * 400 Hz, thus higher or lower frequencies will result in the b=
oundary
> > > > > + * defaults or need to be explicitly specified via val_s.
> > > > > + *
> > > > > + * Return: 0 or error value.
> > > > > + */
> > > > > +static int adxl345_set_inact_time_s(struct adxl345_state *st, u3=
2 val_s)
> > > > > +{
> > > > > +     unsigned int max_boundary =3D 255;
> > > > > +     unsigned int min_boundary =3D 10;
> > > > > +     unsigned int val =3D min(val_s, max_boundary);
> > > > > +     enum adxl345_odr odr;
> > > > > +     unsigned int regval;
> > > > > +     int ret;
> > > > > +
> > > > > +     if (val =3D=3D 0) {
> > > > > +             ret =3D regmap_read(st->regmap, ADXL345_REG_BW_RATE=
, &regval);
> > > > > +             if (ret)
> > > > > +                     return ret;
> > > > > +             odr =3D FIELD_GET(ADXL345_BW_RATE_MSK, regval);
> > > > > +
> > > > > +             val =3D (adxl345_odr_tbl[odr][0] > max_boundary)
> > > > > +                     ? min_boundary : max_boundary - adxl345_odr=
_tbl[odr][0];
> > > > > +     }
> > > > > +
> > > > > +     return regmap_write(st->regmap, ADXL345_REG_TIME_INACT, val=
);
> > > > >  }
> > > > >
> > > > >  /* tap */
> > > > > @@ -837,6 +943,13 @@ static int adxl345_read_event_config(struct =
iio_dev *indio_dev,
> > > > >                       if (ret)
> > > > >                               return ret;
> > > > >                       return int_en;
> > > > > +             case IIO_EV_DIR_FALLING:
> > > > > +                     ret =3D adxl345_is_act_inact_en(st, chan->c=
hannel2, =20
> > > >
> > > > Does it makes sense to allow inactivity detection on a subset of ch=
annels but then
> > > > report it as XYZ?  I guess it didn't matter when it was and OR, but=
 if we
> > > > change to AND as suggested that is going to be misleading.
> > > >
> > > > we might have to allow separate enables but report an event as the =
combination
> > > > of channels that are enabled X_AND_Y, X_AND_Z etc  I guess we can i=
mprove activity
> > > > channel case as well by doing that with the X_OR_Y etc
> > > > =20
> > >
> > > Well, initially I guess I only had one enable for inactivity.
> > >
> > > This was kind of confusing to me. There is a register to enable
> > > activity and inactivity on a per axis base [ACT_INACT_CTL, 0x27]. =20
> >
> > Agreed this is a slightly odd concept.
> > =20
> > >
> > > The interrupt event will set a single bit for inactivity or activity
> > > [INT_SOURCE, 0x30]. In the interrupt handler further one can read out
> > > the [ACT_TAP_STATUS, 0x2B], which contains tap and activity
> > > directions, but no information about inactivity axis.
> > >
> > > In summary, for the ADXL345 inactivity can be configured on a per axis
> > > base, but the event won't tell about the axis that fell into
> > > inactivity, i.e. the first inactivity is supposed to put the sensor
> > > into power save (with link bit and power modes set - I think
> > > inactivity should mainly be seen in the context of their/Analog's
> > > power save concept). As said before, initially I only provided a
> > > single "inactivity enable". Then I saw actually I could set and offer
> > > this per axis. I don't know if there are use cases only to observe
> > > particularly the x-axis for a general power save. Probably rather not.
> > >
> > > So, I agree. But if you don't tell me explicitely to replace per axis
> > > enables by a single one, I'll probably leave it as is. It implements
> > > most transparently what the sensor can offer for configuration. =20
> >
> > The snag is what I mentioned for freefall. It becomes very hard to indi=
cate
> > to userspace what it might expect for the x&y&z cases.  If inactivity r=
equires
> > them all to be inactive, I think separate enables is going to be really
> > tricky to build a consistent ABI around :(
> >
> > Some devices we've had in the past have allowed specific configuration =
of
> > and / or for axis combinations. For those we've normally kept clear bec=
ause
> > the number of combinations gets sill quickly.
> >
> > If we don't have a separate channel enable usecase today I think we sho=
uld
> > go ahead with general inactivity / activity (and/or as appropriate) and
> > perhaps solve the per axis case if anyone ever cares about it.
> > =20
>=20
> Well, I think here we need to distinguish:
> Activity: would allow per axis enables and events indicate per axis activ=
ity
> Inactivity: allows per axis enables, but only a generic inactivity indica=
tion

Ah. I had it in my head it was only one set of per axis enables for the two
types of event. It's not! So indeed your description is what it should be.

>=20
> So, also here, what's still missing? When doing it similarly  to my
> understanding of freefall now, for a v7 of the patches...
>=20
> Activity:
> - I would leave activity as is (is this ok?)

I think so given the separate enables.

>=20
> Inactivity:
> - I replace single three axis enables by a generic enable, setting and
> unsetting all three axis for inactivity
> - I need probably also to provide a similar virtual channel

Is it the same one?  I think so but maybe I've lost track.

> - The axis for this channel are AND'ed
> - Now, with the virtual channel, usage will be "separate" instead of
> "shared", which will result in a single enable handle in sysfs
>=20
> Is this a correct understanding of what is +/- missing? Can you agree
> to the points I listed up, or is something's missing (documentation of
> course later)?
Looks good to me!

Jonathan


