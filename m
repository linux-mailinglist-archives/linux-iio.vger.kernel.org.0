Return-Path: <linux-iio+bounces-22050-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B5DB13015
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 17:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE72218908D0
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 15:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D1C216E26;
	Sun, 27 Jul 2025 15:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jf10we7M"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2B864A8F;
	Sun, 27 Jul 2025 15:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753630694; cv=none; b=HVn8b8u8mikFZmlGVnqBDdM7oSqq6KMlN/JfeYqgSVJU+Sfy4N7Nc25REYdGyUxCuLQgLo1eaRoV+8jwkrem7MEjDmhY5scxWiTrcWGDMny/+C5/wJAT9aJiXqM2SnOUrMYNWgDtqdsCYDadYTSfXZPTgy09BDAtMHXYXn9TPKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753630694; c=relaxed/simple;
	bh=BVBmqlghRoIOUBH2Fl0BlcHtM8mlbRV8a+aE2Bkg2Pk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RzbdNRRO6BUmm3noNdS7XltPyQsMMOy+GBCHWWcklQlbt8LNPAcoQoOF78KA1X+37L2+ikNrQc+ek7qV/jgii5OKyOaD4nxRP5UTnIcVrcS1ifVhAZn4pcefMvUipc7VGuAeK33VGm5qpQs4TxCclYfWqXNsp9OysmwlaSAvguc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jf10we7M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98A2FC4CEEB;
	Sun, 27 Jul 2025 15:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753630693;
	bh=BVBmqlghRoIOUBH2Fl0BlcHtM8mlbRV8a+aE2Bkg2Pk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jf10we7M0yOUw+k1y0MdBwOqB34mFwN4HHYReGympL7Yo2R5qgSRHhUwOC6uXLL4e
	 rh7pA1OFjmEckDGr9cWeL0UR2l2huC+9Cw6bloJdMOKOayO/d2Hz31kNaQ2pO7x1Kw
	 6oxOemteKYMDZsmMqzfQAq869MdwIynGcpMzvOfpNt5HxUkaMgGaPQ8l5J1WPcjDQ/
	 YDJuwr/m/ZQd3mYbTbzhnHGUntE62El9KKbUmzQKIClG46OXrm59146NbHVZsooOlV
	 ZcTwDQL5KMLrpNGrdYR+xbXPqENvFS6Xwo7FAG7WN2K9uTwh15/+V8YMR3HhikAI3k
	 v0HxclxPb+KVQ==
Date: Sun, 27 Jul 2025 16:38:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Santos <jonath4nns@gmail.com>
Cc: 20250719130844.7559e322@jic23-huawei.smtp.subspace.kernel.org, Nuno
 =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>, Jonathan Santos
 <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, lars@metafoo.de,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, "Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?="
 <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH] iio: adc: ad7768-1: disable IRQ autoenable
Message-ID: <20250727163806.1e76c14f@jic23-huawei>
In-Reply-To: <aIPilIRYMgKcSjZW@JSANTO12-L01.ad.analog.com>
References: <20250718013307.153281-1-Jonathan.Santos@analog.com>
	<5llfgo2wifyi43zj24rv7ph5gebevcszrxl3hp3yc3ibaglcr3@fqdejauv6rmo>
	<20250719130844.7559e322@jic23-huawei>
	<aIPilIRYMgKcSjZW@JSANTO12-L01.ad.analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 25 Jul 2025 17:01:24 -0300
Jonathan Santos <jonath4nns@gmail.com> wrote:

> On 07/19, Jonathan Cameron wrote:
> > On Fri, 18 Jul 2025 10:18:56 +0100
> > Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> >  =20
> > > On Thu, Jul 17, 2025 at 10:33:07PM -0300, Jonathan Santos wrote: =20
> > > > The device continuously converts data while powered up, generating
> > > > interrupts in the background. Configure the IRQ to be enabled and
> > > > disabled manually as needed to avoid unnecessary CPU load. =20
> >=20
> > This generates interrupts continuously even when in oneshot mode?
> >  =20
>=20
> No, but oneshot mode is only enabled for a brief moment when reading the =
raw data. The rest of the time it stays in continuous conversion mode becau=
se datasheet says it is necessary to make configuration changes.

Hmm.  So if we want to suppress interrupts we would need to switch out of=20
continuous mode.  That might be helpful, though with the sync in pulse
in the mix we might not need it.  There are complications though.

>=20
> > > >=20
> > > > Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> > > > ---   =20
> > >=20
> > > LGTM,
> > >=20
> > > Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > >  =20
> > > >  drivers/iio/adc/ad7768-1.c | 18 +++++++++++++++++-
> > > >  1 file changed, 17 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> > > > index a2e061f0cb08..3eea03c004c3 100644
> > > > --- a/drivers/iio/adc/ad7768-1.c
> > > > +++ b/drivers/iio/adc/ad7768-1.c
> > > > @@ -395,8 +395,10 @@ static int ad7768_scan_direct(struct iio_dev *=
indio_dev)
> > > >  	if (ret < 0)
> > > >  		return ret;
> > > > =20
> > > > +	enable_irq(st->spi->irq); =20
> >=20
> > Looks racey to me in a number of ways.
> >=20
> > Before this patch:
> > In continuous mode, reinit_completion called then interrupt before we e=
nter
> >  oneshot mode. What was captured?=20
> >=20
> > After this patch
> > Oneshot mode starts - hardware interrupt happens but enable_irq() is no=
t set
> > so we miss it - or do we get another pulse later?
> >  =20
>=20
> After some debugging, i think the device gets the last interrupt before
> getting into oneshot mode because I don't see any DRDY later. it should h=
ave a sync_in pulse after to
> update the data value, as you said.
>=20
> > I'm not sure how to solve this as a device generating a stream of garba=
ge
> > interrupts is near impossible to deal with.
> >=20
> > I'm not following the datasheet description of this features vs the cod=
e=20
> > though. It refers to oneshot mode requiring a pulse on sync in which I =
can't
> > find.
> >  =20
>=20
> If we made something like this wouldn't sufice?

Yes. I think that looks fine but it is relying on particular behavior
of the interrupt controller.

>=20
> ...
> 	reinit_completion(&st->completion);
>=20
> 	ret =3D ad7768_set_mode(st, AD7768_ONE_SHOT);
> 	if (ret < 0)
> 		return ret;
>=20
> 	enable_irq(st->spi->irq);

In some interrupt controllers, IIRC interrupts are annoyingly queued
when disable_irq() has been called, so when you next enable_irq() you
may immediately get one. If it happens, should happen very fast though
I'm not 100% sure it will happen before we return to here which makes
dealing with that race hard.

Do we have a way to check the interrupt was due to the sync pulse?
If not maybe we need a flag that we set here - but that will race
with a slow response to a previously queued interrupt. Maybe that case
doesn't actually exist though - I'm not sure we got that far with
analysizing the guarantees.=20

+CC Uwe who I think was dealing with this a while back with the
ad_sigma_delta library and might remember it a clearer than me.

https://lore.kernel.org/all/io53lznz3qp3jd5rohqsjhosnmdzd6d44sdbwu5jcfrs3rz=
2a2@orquwgflrtyc/
was the main thread in which Thomas Gleixner replied.

Jonathan


> 	ad7768_send_sync_pulse(st);
>=20
> 	ret =3D wait_for_completion_timeout(&st->completion,
> 					  msecs_to_jiffies(1000));
> 	disable_irq(st->spi->irq);
> 	if (!ret)
> 		return -ETIMEDOUT;
> ...
>=20
>=20
> > > >  	ret =3D wait_for_completion_timeout(&st->completion,
> > > >  					  msecs_to_jiffies(1000));
> > > > +	disable_irq(st->spi->irq);
> > > >  	if (!ret)
> > > >  		return -ETIMEDOUT;
> > > > =20
> > > > @@ -1130,7 +1132,21 @@ static const struct iio_buffer_setup_ops ad7=
768_buffer_ops =3D {
> > > >  	.predisable =3D &ad7768_buffer_predisable,
> > > >  };
> > > > =20
> > > > +static int ad7768_set_trigger_state(struct iio_trigger *trig, bool=
 enable)
> > > > +{
> > > > +	struct iio_dev *indio_dev =3D iio_trigger_get_drvdata(trig);
> > > > +	struct ad7768_state *st =3D iio_priv(indio_dev);
> > > > +
> > > > +	if (enable)
> > > > +		enable_irq(st->spi->irq);
> > > > +	else
> > > > +		disable_irq(st->spi->irq);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > >  static const struct iio_trigger_ops ad7768_trigger_ops =3D {
> > > > +	.set_trigger_state =3D ad7768_set_trigger_state,
> > > >  	.validate_device =3D iio_trigger_validate_own_device,
> > > >  };
> > > > =20
> > > > @@ -1417,7 +1433,7 @@ static int ad7768_probe(struct spi_device *sp=
i)
> > > > =20
> > > >  	ret =3D devm_request_irq(&spi->dev, spi->irq,
> > > >  			       &ad7768_interrupt,
> > > > -			       IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> > > > +			       IRQF_TRIGGER_RISING | IRQF_NO_AUTOEN, =20
> >=20
> > Why drop oneshot?
> >  =20
> > > >  			       indio_dev->name, indio_dev);
> > > >  	if (ret)
> > > >  		return ret;
> > > >=20
> > > > base-commit: 0a686b9c4f847dc21346df8e56d5b119918fefef
> > > > --=20
> > > > 2.34.1
> > > >    =20
> > >  =20
> >  =20
>=20


