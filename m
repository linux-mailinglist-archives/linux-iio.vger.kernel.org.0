Return-Path: <linux-iio+bounces-20821-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F88AE2A7F
	for <lists+linux-iio@lfdr.de>; Sat, 21 Jun 2025 19:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3B3D3B9E91
	for <lists+linux-iio@lfdr.de>; Sat, 21 Jun 2025 17:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4CE189902;
	Sat, 21 Jun 2025 17:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HUoNbrmi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA56A5D8F0;
	Sat, 21 Jun 2025 17:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750526261; cv=none; b=sp1UGKpas3GLrcdWoVuQDwsZpxCSaSNrPmfbPGMjgaWMSxk6xDZwgK9+ETrkM6nf5gn3I58Nhn4suVk2d19RAw83qHItDkJXlj4Szu8TLSofQ9oCCbf5NgfNAvQ2scWat5Z0h5sn6TrqzJGRBMwRaX96P6e2Uj/UTnpHpcKfsP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750526261; c=relaxed/simple;
	bh=KLsfWzYYLq9bE5juKZSbNnuRVJ0JexNNbqMjR13cHvY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sKPjqqD1MBjHJqWC09N/Gjo/4FrlDCiV8my1K/Ef/Yio7TOAKkeKDBYY5JKovBr72KcdlbluJrEiCrr0vruOv5ZPjbjynuSfCZtm7mILYm9pAfQ8EEu8RkSEVLY2RITxWZVekYlJoJfGItL+xoFhe5361q3qhMDXES/qVbHQTpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HUoNbrmi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 573B1C4CEE7;
	Sat, 21 Jun 2025 17:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750526261;
	bh=KLsfWzYYLq9bE5juKZSbNnuRVJ0JexNNbqMjR13cHvY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HUoNbrmiix3vYJbIqv+sr1uIPDE7MdcMfjGixDR7FBDGJJPbBBOFCRUnkQYGhkAjm
	 Ru/ebyVN1qCSaaZzLBkj4Vwlg7Pa4CP/QM2rsJLQAwpljUOQpkRSWIHXwaNQAnX3/+
	 iREckz371tme76n5ylDyO6fbAAZg7VmiYulSJFyMQ3QkiiTygEoE91PFkp0HYV21Bo
	 e2ONJM3MCsjaDx75qfNeKpKALxjgR7zbOfGQvTUhzeJodclKi7Riiv2hXh2fuRPxU9
	 yyPzbCIHZ4mn5hX7Q22t4JKZ3juvKu1KWL8jJHZJSeKEAa0C79t0saEGZTHWPa/T3l
	 re/Rmrc79NMqw==
Date: Sat, 21 Jun 2025 18:17:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Hans de Goede <hansg@kernel.org>
Cc: Marek Vasut <marek.vasut+bmc150@mailbox.org>, linux-iio@vger.kernel.org,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, David Lechner <dlechner@baylibre.com>, Julien Stephan
 <jstephan@baylibre.com>, Peter Zijlstra <peterz@infradead.org>, Salvatore
 Bonaccorso <carnil@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: bmc150: Do not configure IRQ registers if
 no IRQ connected
Message-ID: <20250621181733.3cb6111e@jic23-huawei>
In-Reply-To: <79946c40-e2ce-4fbc-a6b2-b37f6fd69d1d@kernel.org>
References: <20250613124648.14141-1-marek.vasut+bmc150@mailbox.org>
	<79946c40-e2ce-4fbc-a6b2-b37f6fd69d1d@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 16 Jun 2025 14:42:54 +0200
Hans de Goede <hansg@kernel.org> wrote:

> Hi,
>=20
> On 13-Jun-25 14:45, Marek Vasut wrote:
> > The BMC150 on Onemix 2S does not have IRQ line described in ACPI tables,
> > which leads to bmc150_accel_core_probe() being called with irq=3D0, whi=
ch
> > leads to bmc150_accel_interrupts_setup() never being called, which leads
> > to struct bmc150_accel_data *data ->interrupts[i].info being left unset
> > to NULL. Later, userspace can indirectly trigger bmc150_accel_set_inter=
rupt()
> > which depends on struct bmc150_accel_data *data ->interrupts[i].info be=
ing
> > non-NULL, and which triggers NULL pointer dereference. This is triggered
> > e.g. from iio-sensor-proxy.
> >=20
> > Fix this by skipping the IRQ register configuration in case there is no
> > IRQ connected in hardware, in a manner similar to what the driver did in
> > the very first commit which added the driver. =20
>=20
> ...
>=20
> > Fixes: 8e22f477e143 ("iio: bmc150: refactor interrupt enabling")
> > Signed-off-by: Marek Vasut <marek.vasut+bmc150@mailbox.org>
> > ---
> > Cc: "Nuno S=C3=A1" <nuno.sa@analog.com>
> > Cc: Andy Shevchenko <andy@kernel.org>
> > Cc: David Lechner <dlechner@baylibre.com>
> > Cc: Jonathan Cameron <jic23@kernel.org>
> > Cc: Julien Stephan <jstephan@baylibre.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Salvatore Bonaccorso <carnil@debian.org>
> > Cc: linux-iio@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  drivers/iio/accel/bmc150-accel-core.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >=20
> > diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/=
bmc150-accel-core.c
> > index 744a034bb8b5..1c3583ade2b4 100644
> > --- a/drivers/iio/accel/bmc150-accel-core.c
> > +++ b/drivers/iio/accel/bmc150-accel-core.c
> > @@ -550,6 +550,9 @@ static int bmc150_accel_set_interrupt(struct bmc150=
_accel_data *data, int i,
> >  	if (ret < 0)
> >  		return ret;
> > =20
> > +	if (!info)
> > +		return 0;
> > +
> >  	/* map the interrupt to the appropriate pins */
> >  	ret =3D regmap_update_bits(data->regmap, info->map_reg, info->map_bit=
mask,
> >  				 (state ? info->map_bitmask : 0)); =20
>=20
> AFAIK the proper fix would be to not register any IIO-triggers. This fix =
will
> avoid the problem, but userspace might still try to use non-working trigg=
ers
> which will now silently fail.
>=20
> I'm not an IIO expert, but IIRC other drivers simply skip registering the=
ir triggers
> when there is no interrupt support.

Absolutely. It is annoyingly common for devices to have some or none of the=
 interrupt
lines actually wired so drivers should not present the interfaces if they a=
ren't.
It is acceptable for a new driver to just fail to probe if handling the dev=
ice with no
interrupts is particularly complex but in general at least some functionali=
ty tends
to be easy to implement so we prefer that.

Thanks,

Jonathan

>=20
> Regards,
>=20
> Hans
>=20
>=20


