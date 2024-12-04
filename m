Return-Path: <linux-iio+bounces-13087-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 876239E3D38
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 15:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 505CD1630D6
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 14:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D69920B7FB;
	Wed,  4 Dec 2024 14:49:59 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C77820ADD8;
	Wed,  4 Dec 2024 14:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.233.101.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733323799; cv=none; b=q9q20E6+XZVnI+1cjBDkSkCH/SYrJxumerr8FrRW/CfngUwdIDrqFRIH24Nb7zNTMniO9lWJ2OXbLE6ql5Ai+YmC/7SRJ+S1JR1qTQiQNozY1gaWXuP6HeQtSDz/jRkyBD2riqRU9hvPsjl6cnmN4C7PmWjGTvTiXyjEkYFmJUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733323799; c=relaxed/simple;
	bh=bXoOo221xUwCnbX7R8WuAO+TIq3l4xTdXpLcxUomPwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S5DmgaIQZel91ptBh+FrsVD8F1dQ7Y1cvfxauB1dG2Dz6uGFTizkx8Q2zOeott3pj1uze6hiepTqh8WLgkqJ6LXHWdu/wNA6jscKaW13+QBsi1j09XAHY/MOrDEIdPbE2JTEdyk3fUaB5RGJ0vGlgfm7X0LgWHPH1qMBRp4mgqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sys-base.io; spf=pass smtp.mailfrom=sys-base.io; arc=none smtp.client-ip=185.233.101.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
	by leonov.paulk.fr (Postfix) with ESMTPS id 7C0941F0004F;
	Wed,  4 Dec 2024 14:49:49 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
	id F208EA6751D; Wed,  4 Dec 2024 14:49:47 +0000 (UTC)
X-Spam-Level: 
Received: from collins (unknown [192.168.1.1])
	by laika.paulk.fr (Postfix) with ESMTPSA id 41819A67516;
	Wed,  4 Dec 2024 14:49:46 +0000 (UTC)
Date: Wed, 4 Dec 2024 15:49:43 +0100
From: Paul Kocialkowski <paulk@sys-base.io>
To: Mehdi Djait <mehdi.djait@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 2/2] iio: light: Add support for the TI OPT4048 color
 sensor
Message-ID: <Z1BsBxsIKmQkHKmD@collins>
References: <20241130174212.3298371-1-paulk@sys-base.io>
 <20241130174212.3298371-2-paulk@sys-base.io>
 <20241201115529.1375c6c3@jic23-huawei>
 <Z0yjTkXt0JhqdD15@collins>
 <20241202110659.00000171@huawei.com>
 <2yc2igv2lxh3u4kmkz73httg3sp24ziagcoaa7unfupagji7zk@ezaue3umwe44>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/tsIYVWsj1EIUdB7"
Content-Disposition: inline
In-Reply-To: <2yc2igv2lxh3u4kmkz73httg3sp24ziagcoaa7unfupagji7zk@ezaue3umwe44>


--/tsIYVWsj1EIUdB7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mehdi,

Glad to see you active here :)

Le Mon 02 Dec 24, 15:55, Mehdi Djait a =C3=A9crit :
> Hello Paul :)
>=20
> On Mon, Dec 02, 2024 at 11:06:59AM +0000, Jonathan Cameron wrote:
> > On Sun, 1 Dec 2024 18:56:30 +0100
> > Paul Kocialkowski <paulk@sys-base.io> wrote:
> >=20
> > > Hi Jonathan,
> > >=20
> > > Le Sun 01 Dec 24, 11:55, Jonathan Cameron a =C3=A9crit :
> > > > On Sat, 30 Nov 2024 18:42:12 +0100
> > > > Paul Kocialkowski <paulk@sys-base.io> wrote:
> > > >  =20
> > > > > The Texas Instruments OPT4048 is a XYZ tristimulus color sensor,
> > > > > with an additional wide (visible + IR) channel.
> > > > >=20
> > > > > This driver implements support for all channels, with configurable
> > > > > integration time and auto-gain. Both direct reading and
> > > > > triggered-buffer modes are supported.
> > > > >=20
> > > > > Note that the Y channel is also reported as a separate illuminance
> > > > > channel, for which a scale is provided (following the datasheet) =
to
> > > > > convert it to lux units. Falling and rising thresholds are suppor=
ted
> > > > > for this channel.
> > > > >=20
> > > > > The device's interrupt can be used to sample all channels at the =
end
> > > > > of conversion and is optional.
> > > > >=20
> > > > > Signed-off-by: Paul Kocialkowski <paulk@sys-base.io> =20
> > > > Hi Paul,
> > > >=20
> > > > Various comments inline. Most significant is that this seems to be
> > > > suitable for a simple dataready trigger that will make your various
> > > > interrupt and non interrupt flows more similar. =20
> > >=20
> > > And thanks for the fast review and insightful comments!
> > >=20
> > > I considered implementing a trigger in the driver, but the issue I fo=
und
> > > is that the trigger is expected to be called from hard irq context,
> > > while the new values are read in the bottom half.=20
> >=20
> > The trigger can be called from either the hard irq context or from
> > a thread.  See iio_trigger_poll_nested()
> > There is a quirk that you then don't end up calling the registered
> > hard irq handler for the trigger so sometimes a bit of fiddly code
> > is needed to ensure timestamps etc are grabbed.  Not sure that matters
> > here.
> >=20
>=20
> If the timestamps do matter: here is a (maybe relevant?) discussion for
> an issue I faced with timestamps for a driver that supports both FIFO
> and triggered buffer mode
>=20
> Please note that iio_trigger_poll_nested() was called
> iio_trigger_poll_chained() back in that discussion.
>=20
> https://lore.kernel.org/linux-iio/Y+6QoBLh1k82cJVN@carbian/

Thanks for the hint! I'll definitely look it up for details.

Cheers,

Paul

> > > I understand the triggered
> > > buffer callbacks are executed as a thread as well, so there would be =
race
> > > between the two which could result in previous values being returned.
> >=20
> > With the above nested call it is all run in the same thread
> > See handle_nested_irq() in particular the function docs.
> > https://elixir.bootlin.com/linux/v6.12.1/source/kernel/irq/chip.c#L459
> >=20
> > > So I concluded that it was more beneficial to preserve the synchronou=
s reading
> > > mechanism over implementing the trigger.
> >=20
> > Definite preference for a trigger approach, but I may well still be mis=
sing
> > a detail.
>=20
> --
> Kind Regards
> Mehdi Djait

--=20
Paul Kocialkowski,

Independent contractor - sys-base - https://www.sys-base.io/
Free software developer - https://www.paulk.fr/

Expert in multimedia, graphics and embedded hardware support with Linux.

--/tsIYVWsj1EIUdB7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAmdQbAcACgkQhP3B6o/u
lQwKixAAmXxZLS4V0z+oSrzrze+9q4oHHWWJtMguYnuHikHkgPc05uq/2Hf0x+OQ
V/np9Pbz1AlObo9q9Upk2WcU9ngpof6FxSwutt6EqWqHn4sXXiGoFUec3nSFmHA4
QvcQSeSf3BeowlM2uWDJ7/og5s7QeUqeCgNnuQ4x1cw7KMJnLqPVm80Tv4qwsUPC
qSNK+HQvXIM2HQeNOAZAuS/3oOe9C2BWv7vuE0NCUUnHxXRtsQ3mKVQSHx+/prgo
fkQWACxhsUcl0erxt7xuapRO4eVcGb4xHobiLYju8pK508gUEtJK/GGOPz69XaMu
77FChx02zsrtPscVrD/ooiRCSK+9dqWlP5Cs7CyCi8ezJByWHE2cIeLvm2tW0ygu
6xKe10+KEKgapshlpjAo+uKg/1BwkiutqR3IqNml0XUpphig26SHPXEYpQIAsEr7
IcYyGiDk/NsSMvS5bdDRsv9MB1sAmtrGPNhJ3nJQO44sr7ZuXfdJl7ZQVYtqydqo
ZeBHv6t5IzSHHFNv0VHVHcwqkYvCZTzNxQ3c+O9jhDBiHd01Th4wYgbrGUYX7XhL
kY6BNzrPOO45c2xH9bSbaBpntGlM8TthEOOyY2aFq34jugUpsjHTpTpEWNjbeRsP
Ar0zGG2yK2sRaLTOZdnGc0STnLjRE6WXoka29uKXb6QupVdEdvQ=
=OO2/
-----END PGP SIGNATURE-----

--/tsIYVWsj1EIUdB7--

