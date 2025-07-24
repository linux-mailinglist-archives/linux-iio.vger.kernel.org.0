Return-Path: <linux-iio+bounces-21977-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B9EB10BBA
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 15:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11D541896B0A
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 13:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471282D877E;
	Thu, 24 Jul 2025 13:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sTZKxbdl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F7513BC0C
	for <linux-iio@vger.kernel.org>; Thu, 24 Jul 2025 13:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753364488; cv=none; b=Hp4i4JApxKHX4vaBIx3spMXuprtU3VJHwo7HLu8Nz+ersAntqt6Ik623ixcII52F9tLlDSBxaM1FKy3eyWRDP0/scnunVv8aM0dkytsI9TM/C0HToWC6BxDBYKmh59bFRrkvKQDeVFZ5jKi2mPeXoaSuI/0j66pSchjzCNQV2zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753364488; c=relaxed/simple;
	bh=uHhPCSqQJW1UWbP1A8sTLLg0lvYBs5z7i91BmSE6bxU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GsNIh4q75HQsIgGivuAq5/x8co+f8kWiLEoH+yxKurwCYzxkvnw9HfpNvbFGwbJe6ddjXujomHlN1Jbby9U5Cx81lgiEw+U3bDFO0N2F/sZfkY8PsEe3w5eK5BqDLUT5MkDJT0fP3Hx9lavmuchB1r2okkS666cQhNmfcyWjqGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sTZKxbdl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89475C4CEED;
	Thu, 24 Jul 2025 13:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753364487;
	bh=uHhPCSqQJW1UWbP1A8sTLLg0lvYBs5z7i91BmSE6bxU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sTZKxbdl6lxs2HqVkfIgrIvZsOmdTDg3rJIRgRoCNSRGShHm1gINzpG2k8tUw8nOp
	 EgpxN4ZRErqZUtLeHe7BKY6DGHNyqYUUEoPMgoIgz7Bk10XVJg3tDwyJ57XA1ctZHh
	 9DcAizJ0jrs0F6+yZ6yxQUZt1+coNVy49AB/5fr4jOk0cC/so2ODhEDEVJZ/L7+i4s
	 McoL6m0hFpLuvLZs62X5o09Tus3GSI58nMKz/0RixwMjOPNmd7QZ1ewbGwa8GneVv3
	 W8k5cCOHaytnuk9uoCwWachwPbBmoaxdiWQk5cbSxuEYpinSfgt1Td0nvpgGfSN5vI
	 Hztsw4konwKmg==
Date: Thu, 24 Jul 2025 14:41:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Cc: Hans de Goede <hansg@kernel.org>, Marek Vasut
 <marek.vasut+bmc150@mailbox.org>, linux-iio@vger.kernel.org, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Julien Stephan
 <jstephan@baylibre.com>, Peter Zijlstra <peterz@infradead.org>, Salvatore
 Bonaccorso <carnil@debian.org>
Subject: Re: [PATCH] iio: accel: bmc150: Do not configure IRQ registers if
 no IRQ connected
Message-ID: <20250724144119.399e977b@jic23-huawei>
In-Reply-To: <6oyvsvp2erynwu3evulbg6gtdryabeuoo46qzku2grxg3jxptf@jszhnvmj2ffc>
References: <20250613124648.14141-1-marek.vasut+bmc150@mailbox.org>
	<79946c40-e2ce-4fbc-a6b2-b37f6fd69d1d@kernel.org>
	<6oyvsvp2erynwu3evulbg6gtdryabeuoo46qzku2grxg3jxptf@jszhnvmj2ffc>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 22 Jul 2025 10:55:29 +0200
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote:

> Hello,
>=20
> On Mon, Jun 16, 2025 at 02:42:54PM +0200, Hans de Goede wrote:
> > > diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/acce=
l/bmc150-accel-core.c
> > > index 744a034bb8b5..1c3583ade2b4 100644
> > > --- a/drivers/iio/accel/bmc150-accel-core.c
> > > +++ b/drivers/iio/accel/bmc150-accel-core.c
> > > @@ -550,6 +550,9 @@ static int bmc150_accel_set_interrupt(struct bmc1=
50_accel_data *data, int i,
> > >  	if (ret < 0)
> > >  		return ret;
> > > =20
> > > +	if (!info)
> > > +		return 0;
> > > +
> > >  	/* map the interrupt to the appropriate pins */
> > >  	ret =3D regmap_update_bits(data->regmap, info->map_reg, info->map_b=
itmask,
> > >  				 (state ? info->map_bitmask : 0)); =20
> >=20
> > AFAIK the proper fix would be to not register any IIO-triggers. This fi=
x will
> > avoid the problem, but userspace might still try to use non-working tri=
ggers
> > which will now silently fail. =20
>=20
> I don't have a system that triggers the problem, but there is
> https://bugs.debian.org/1106411 which I guess is the same problem.
>=20
> I think the suggestion to not register the triggers in the absence of an
> irq would be implemented by

I was going to say don't do this because it break other triggers being used=
 with this
driver, but...=20

We have a validate_trigger callback so this driver can only use a trigger r=
egistered
by this driver.  That's a bit of a horrible limitation that we tend to only=
 do
if there is a nasty interaction between event handling and data acquisition.

Here there is such an interaction as a result (I think) of it handling the =
fifo
off the back of a trigger which is something we don't do in newer drivers.

So this is all a bit nasty but this should work and doesn't require a more
substantial rework.

I think there may be a similar issue though for the events.  For those
we need to switch to a different iio_info instance + different channel array
where the events stuff is all missing if we don't have an irq.

Jonathan




>=20
> diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bm=
c150-accel-core.c
> index be5fbb0c5d29..8d90802e65fd 100644
> --- a/drivers/iio/accel/bmc150-accel-core.c
> +++ b/drivers/iio/accel/bmc150-accel-core.c
> @@ -1687,18 +1687,18 @@ int bmc150_accel_core_probe(struct device *dev, s=
truct regmap *regmap, int irq,
>  		fifo_attrs =3D NULL;
>  	}
> =20
> -	ret =3D iio_triggered_buffer_setup_ext(indio_dev,
> -					     &iio_pollfunc_store_time,
> -					     bmc150_accel_trigger_handler,
> -					     IIO_BUFFER_DIRECTION_IN,
> -					     &bmc150_accel_buffer_ops,
> -					     fifo_attrs);
> -	if (ret < 0) {
> -		dev_err(dev, "Failed: iio triggered buffer setup\n");
> -		goto err_disable_regulators;
> -	}
> -
>  	if (irq > 0) {
> +		ret =3D iio_triggered_buffer_setup_ext(indio_dev,
> +						     &iio_pollfunc_store_time,
> +						     bmc150_accel_trigger_handler,
> +						     IIO_BUFFER_DIRECTION_IN,
> +						     &bmc150_accel_buffer_ops,
> +						     fifo_attrs);
> +		if (ret < 0) {
> +			dev_err(dev, "Failed: iio triggered buffer setup\n");
> +			goto err_disable_regulators;
> +		}
> +
>  		ret =3D devm_request_threaded_irq(dev, irq,
>  						bmc150_accel_irq_handler,
>  						bmc150_accel_irq_thread_handler,
>=20
>=20
> But given that bmc150_accel_write_event_config() also calls
> bmc150_accel_set_interrupt() this might not be a complete fix.
>=20
> Best regards
> Uwe


