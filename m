Return-Path: <linux-iio+bounces-17662-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C3EA7CDB0
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 13:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E68FE188BE9B
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 11:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1E01A238A;
	Sun,  6 Apr 2025 11:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSoJOgs7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83950126C02;
	Sun,  6 Apr 2025 11:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743938311; cv=none; b=bbhXezGbum+EqTNSljneoGe/u6EOSn73aiJWfmYPVQWOWvCyNHREm2/lLUbUnKMGcs4zi0WMoOM40MJQ28L+7yI6bHibDE0WFCJX36iXpBmjSqW9jq50mCTqnn12V05yuFjZ8c0EYVFJWX79VPJgKBRPOxHUcnuwE4Gj3j9l3oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743938311; c=relaxed/simple;
	bh=ACTsy/WilsbTvDenV6k21+r4RQebg/ehbTmpIRB/ixM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ns/6F++s3OLkN6J0GEiiVtv0zd0/BA+eXuez6Mv42FcgTe94SZHkthcU4Tk28nk/x0r5ifNN+uu9vwJXwPYX6eh+XfoiGMSLk1Me+L1TmSQAsiLeBKk7Gsw6gPwpHkwE3iIXFyWb0F+jyEmGIuW9wbrgDU1Xl8f3ZPv/P8cvAEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WSoJOgs7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CAD0C4CEE3;
	Sun,  6 Apr 2025 11:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743938310;
	bh=ACTsy/WilsbTvDenV6k21+r4RQebg/ehbTmpIRB/ixM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WSoJOgs7ccQNDti5E0TOFdW/KSFI0NWCnh2hpmCzEotV21EtGzaOuxhpiF2NdW/lX
	 lzN1PGRUUUH5Rw2hmzK/Ag+I+4RotKIQuZycGkWT/BQDzHgd9kmqQ7O5tRCuveD40/
	 20ggFW0xHIq63LSytttqedYtBN415t40iakD7imd+j3TGXeL6KTY/bYKYPbms+eC7s
	 u1CqT3z7edn+cTUhGzWJpfgiY3H/kYT+Cz1J4KadttmY+H4DuKCXcxOFHJ0L/4RI++
	 5O3t+RsdD2NAxrGQnJoXsUXELo1+3iMEGDQP4R7Szj8koKPaZ7w9ylmyDi0owO2fWk
	 2wrgXV+9DA3bw==
Date: Sun, 6 Apr 2025 12:18:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v5 05/11] iio: accel: adxl345: add freefall feature
Message-ID: <20250406121825.3d4836b1@jic23-huawei>
In-Reply-To: <CAFXKEHYMgv1-rt6Sc65fCoki14v==NqQTY6J3WnQBG+ASoLeaw@mail.gmail.com>
References: <20250318230843.76068-1-l.rubusch@gmail.com>
	<20250318230843.76068-6-l.rubusch@gmail.com>
	<20250331112839.78c2bc71@jic23-huawei>
	<CAFXKEHYMgv1-rt6Sc65fCoki14v==NqQTY6J3WnQBG+ASoLeaw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 31 Mar 2025 19:23:22 +0200
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Hi Jonathan & IIO Mailing List'ers
>=20
> On Mon, Mar 31, 2025 at 12:28=E2=80=AFPM Jonathan Cameron <jic23@kernel.o=
rg> wrote:
> >
> > On Tue, 18 Mar 2025 23:08:37 +0000
> > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > =20
> > > Add the freefall detection of the sensor together with a threshold and
> > > time parameter. A freefall event is detected if the measuring signal
> > > falls below the threshold.
> > >
> > > Introduce a freefall threshold stored in regmap cache, and a freefall
> > > time, having the scaled time value stored as a member variable in the
> > > state instance.
> > >
> > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com> =20
> > Hi Lothar,
> >
> > Apologies for the slow review!  Just catching up after travel
> > and I did it reverse order. =20
>=20
> No problem a all, hope you had a great trip! I'm glad this goes for
> another version. In the meanwhile I was messing with the zephyr driver
> implementation for this sensor and had some findings and final
> thoughts about the ADXL345.
>=20
> First, set_measure_en() I use to enable/disable the measurement by
> setting a bit in the POWER_CTL register using regmap_write(). This was
> ok until adding the act/inact feature. For adding power modes to
> inactivity, I'm going to set the link bit in the same POWER_CTL reg.
> So you already guess, yet another call  to set_measure_en() simply
> wipes this link bit out immediately. I'll probably replace
> regmap_write() using regmap_update_bits() still in this series.
>=20
> Second, while playing with the zephyr driver and another setup I
> discovered, that probably the sensor is capable of mapping events to
> both interrupt lines in parallel. Currently, either all events to to
> INT1 or to INT2, not both. This affects actually 8 interrupt events:
> data ready, single tap, double tap, activity, inactivity, free fall,
> watermark, overrun. Actually they could individually be mapped either
> to INT1 or INT2.
> Initially I assumed they all need to go either to INT1 or INT2
> altogether. I appologize for this, I was wrong due to the breakout
> board I was using. That's a kind of crazy feature, and I think of
> implement it perhaps in a follow up series. Anyway, I was curisous
> about the approach, currently only can think of introducing 8x new DTS
> properties. Are you aware of sensors with similar features, what is
> usually the approach how to implement that? What is your oppinion on
> this?

It's not a board wiring thing if both are available (unless we are
dealing with the complexity of external hardware driven by the interrupts).
It is a policy thing for the driver.  So all DT should tell us is what
is wired.  Note this is very common on more complex sensors (take a look
at all the ADIS IMUs for instance). In practice it hasn't often proved
useful to route different interrupts to different pins so we haven't
bothered.  Linux drivers tend to always check what the interrupt was
anyway (to detect false interrupts, share lines etc) so once you are doing
that there is little point in splitting the handler in two. For RTOS
cases it may make more sense.


>=20
> Third item, there are 4 FIFO modes: Bypass and Streaming are currently
> used. There is another FIFO mode and further a Trigger mode i.e. only
> when the sensor got triggered it fills up the FIFO with data (also
> this is mappable by the INT1 or INT2 line then).

ah. This tends to happen in devices that do things like impact detection.
We have never really supported that properly (and the one driver that
was in staging went away recently as it's now end of life and no
one seemed to care).

> What would be a way
> to configure such feature? I know many of the Analog accelerometers
> seem to have FIFO modes. Is this to be configured by DT properties?

This is definitely policy so doesn't belong in DT at all.

> What would be means to configure it? Also, this would be a separate
> patch set.

The closest we get to this is probably the complex stm32 triggering
but that is not necessarily something I'd base such a feature on as
it is really about interactions across a lot of different system
elements even though it incorporates a grab N samples on event Y element.

We'd need a way to add new richer description around the fifo + trigger.
It's kind of a mixture of both because a trigger causing a bunch of
scan's to be taken. In general that might be limited by the fifo or
it might just be always take 'N' samples.

Before spending too much time on this I'd consider whether there is
a use case to justify the work.  They exist on paper, but we haven't
yet had anyone actually implement it in a driver which makes me
wonder if people care!

Jonathan

>=20
> Best,
> L
>=20
> > =20
> > > +
> > > +static int adxl345_set_ff_en(struct adxl345_state *st, bool cmd_en)
> > > +{
> > > +     unsigned int regval, ff_threshold;
> > > +     const unsigned int freefall_mask =3D 0x02; =20
> >
> > Where did this mask come from?   Feels like it should be a define
> > (just use ADXL345_INT_FREE_FALL probably)
> > or if not that at lest use BIT(1) to make it clear it's a bit rather
> > than the number 2.
> > =20
> > > +     bool en;
> > > +     int ret;
> > > +
> > > +     ret =3D regmap_read(st->regmap, ADXL345_REG_THRESH_FF, &ff_thre=
shold);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     en =3D cmd_en && ff_threshold > 0 && st->ff_time_ms > 0;
> > > +
> > > +     regval =3D en ? ADXL345_INT_FREE_FALL : 0x00;
> > > +
> > > +     return regmap_update_bits(st->regmap, ADXL345_REG_INT_ENABLE,
> > > +                               freefall_mask, regval);
> > > +} =20
> >
> > Jonathan =20


