Return-Path: <linux-iio+bounces-19169-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD2CAA9C9C
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 21:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 816C57A1DB9
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 19:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A70226FDA5;
	Mon,  5 May 2025 19:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=it-klinger.de header.i=@it-klinger.de header.b="AD+e3bFa"
X-Original-To: linux-iio@vger.kernel.org
Received: from www571.your-server.de (www571.your-server.de [78.46.3.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE112701AD;
	Mon,  5 May 2025 19:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.3.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746473167; cv=none; b=UKqQ47u5K270eDTtua2MvBTnG4jAHEcVP1EVWZ9/BrvSNQpe2ZfhZKjPhsXvwTXOLHRgEDV/vajm1My/kQcWKZoBhSw9+T7Ymau4N671EvpDoXKrA4JVUHpMg2UtB3qk9+hPUFIYQAb9zF4CSiMdrcQpAmkgXZI0stqxtZP85gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746473167; c=relaxed/simple;
	bh=erLII/mmON5+5Rvm5sYc6e5eOqi2HGcTxk1Y6msZzqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BjP7/ZLwiR5xtjUSrow7VnsONRZY5pf1Ast6fB4MuVvSUHYB/mgvSxAu7cbZgP4GvgtYoqIbESfliLNEkZvseonh5308jmA5p2YFiONrNBZPhYK5YQbODXHXsCM8/ir5znzXUwvm4fpZsD3WVvgY6T7OU3JLnkiqT02xXFWxcII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de; spf=pass smtp.mailfrom=it-klinger.de; dkim=pass (2048-bit key) header.d=it-klinger.de header.i=@it-klinger.de header.b=AD+e3bFa; arc=none smtp.client-ip=78.46.3.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=it-klinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=it-klinger.de; s=default2502; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=mXzZCIiXFkvY3wmMVtP0xagcjYmlfECJnCu8DYISA34=; b=AD+e3bFaBarbAC5QgufiQdNbqH
	JWvWTEezsL/bDmN5PlAdJwwrlzF9r0P2eoYENoSTaO6Qtx76rjiV7obgohsEUZ+Tznhh+wvX1zADj
	P8oJZgqUVAE3ZxzWyWvNukjEfeeljHqWRgMoTBjM7rcGuINxk/HgIK1lrgO3eVjk1x8jjz57NIU6v
	qjhsab6RcxYAYDD/l90P4CQJNRJXYxDPLimLV54Vukb7SHqh3OXwiGp7QUMBWrS06ilPQVBjQGwHG
	1BgBPTvPkVVhndAdrQH1LhaVkbnS1EUJ9KQYXDufB4Nx44wWn4iEoGYe1GuJE7WXNif22SUosnonZ
	qB8iDuKw==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www571.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <ak@it-klinger.de>)
	id 1uC1Cp-000Pr4-27;
	Mon, 05 May 2025 21:10:23 +0200
Received: from [31.220.118.240] (helo=mail.your-server.de)
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ak@it-klinger.de>)
	id 1uC1Co-0000k7-31;
	Mon, 05 May 2025 21:10:23 +0200
Date: Mon, 5 May 2025 21:10:21 +0200
From: Andreas Klinger <ak@it-klinger.de>
To: Jonathan Cameron <jic23@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	lars@metafoo.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	javier.carrasco.cruz@gmail.com, subhajit.ghosh@tweaklogic.com,
	muditsharma.info@gmail.com, arthur.becker@sentec.com,
	ivan.orlov0322@gmail.com
Subject: Re: [PATCH 2/3] iio: light: add support for veml6046x00 RGBIR color
 sensor
Message-ID: <aBkNHSxU4T8j4oMT@mail.your-server.de>
References: <20250316113131.62884-1-ak@it-klinger.de>
 <20250316113131.62884-3-ak@it-klinger.de>
 <20250317115005.72a539a0@jic23-huawei>
 <Z_I-qwzUrTNz1DZp@mail.your-server.de>
 <20250406120825.41b2575c@jic23-huawei>
 <ecb2844c-feb5-47d4-b4db-12171380a9cb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ga5BT2NOkCzKwCye"
Content-Disposition: inline
In-Reply-To: <ecb2844c-feb5-47d4-b4db-12171380a9cb@gmail.com>
X-Authenticated-Sender: ak@it-klinger.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27629/Mon May  5 10:35:28 2025)


--ga5BT2NOkCzKwCye
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,
hi Matti,

Matti Vaittinen <mazziesaccount@gmail.com> schrieb am Mo, 07. Apr 08:52:
> On 06/04/2025 14:08, Jonathan Cameron wrote:
> > On Sun, 6 Apr 2025 10:43:23 +0200
> > Andreas Klinger <ak@it-klinger.de> wrote:
> >=20
> > > Hi Jonathan,
> > >=20
> > > I need to pick up the meaning of scale once again for clarification.
> > >=20
> > > Jonathan Cameron <jic23@kernel.org> schrieb am Mo, 17. M=C3=A4r 11:50:
> > > > On Sun, 16 Mar 2025 12:31:30 +0100
> > > > Andreas Klinger <ak@it-klinger.de> wrote:
> > > > > +static int veml6046x00_get_scale(struct veml6046x00_data *data,
> > > > > +				 int *val, int *val2)
> > > >=20
> > > > How is this related to integration time?  I'd normally expect
> > > > to see that read in here somewhere as well as doubling integration
> > > > time tends to double scale.
> > >=20
> > > In the documentation file "sysfs-bus-iio" it says:
> > > "
> > > What:           /sys/.../iio:deviceX/in_illuminanceY_raw
> > > [...]
> > > Description:
> > >                  Illuminance measurement, units after application of =
scale
> > >                                  and offset are lux.
> > > "
> > >=20
> > > This means that the scale should be the real factor and not the gain =
multiplied
> > > by photodiode size (PDDIV) as i implemented it so far.
> > >=20
> > > This means also that doubling integration time should halve the scale=
=2E The
> > > higher raw value should lead to the same lux value.
> >=20
> > Sounds correct.
>=20
> I was CC'd due to the GTS (gain-time-scale)-helpers. The above is the beef
> of those helpers - which, attempt to aid drivers to convert the impact of
> the hardware gain + integration time into a single scale value. This
> approach has some caveats, but the goal is to fulfill the expectations of
> those user-space apps which expect only scale to change the gain, while a=
lso
> need to have the integration time controllable (for example to reduce the
> measurement time for one reason or another).
>=20
> Problem is that, especially when there are multiple channels with separate
> gain control but common integration time, there will be some situations
> where the integration time change _will_ cause changes to "total gain (E.=
g.
> scale)" too. There may also be cases where some scale values can be met o=
nly
> with certain integration times, or where a scale for a channel can't be m=
et
> maintaining the scale for other channels etc.
>=20
> All in all, I am not sure if the 'unchangeable hardware gain' approach ma=
kes
> things as simple as possible - but as long as we want to have it, the GTS
> helpers may be of use :) There are couple of drivers using them - feel fr=
ee
> to take a look. "git grep gts_ drivers/iio/light/" should point you the
> current users.
>=20

Thanks a lot for illustrating and explaining the GTS. I implemented the dri=
ver
with GTS and by this learned a lot about it. But at the end i found it in my
case to be simpler to implement it without GTS for some reasons:
- User wants to be able to set up the integration time as well as scale and=
 the
  driver should not optimize it somehow.
- There is not only a relation from the scale to the gain of the sensor but=
 also
  to the photodiode size. Because of this i need another helper table asize=
 of
  GTS for translating the scale into sensor gain and photodiode size.

I'll come up with a version 3 shortly.

Andreas



--ga5BT2NOkCzKwCye
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEE7/NrAFtB/Pj7rTUyyHDM+xwPAVEFAmgZDR0ACgkQyHDM+xwP
AVG6lgwAr5MoPoUtUc10n/jCrF4oU2/jdI7w9KxznRNqANsXs+a/bOVQAqGXiSjh
qTgGkZk8vDwDm2QE+bs/ychhXnEUGfo3oXlFX86O0f6bifkzQI9av/Vp+ofjoQS+
TZz8nMvrEsAJhOGOW0c7eFDQvlBypXZ6h0h1UzjWuD55Uxv3c1W2YB6O2Zu3dwhw
55rWBG8XkM+vWMhgBWJe1PMNMxTIB6TXHOMMzVqNn4aQCjDUlVpNL0YcBk5NUYpu
HEbR83SoVSf+AiG+1V+J7cPR9WYR8on5hlp44WUw1Dfn/OhB7VQQ+xdx/tiDbv70
SdlUUwwmLR0Yf80rx2E3ApS2tZ0JO/9U859Il09Gfhd1njT+orZ2oQDi0gKDcUqk
1b8uhpvBASzF85yDkFCYAnJfOuRxBjhN4OKNWewRAhLJuttnc9YjdJJFKmzbOyTM
1PX1HSHIF4qVRYxmMC/98cluieyg7F3zQ3dwlnZjp5r6dAWK/OAX8J1zjHI+oFwu
8q5dDWQ0
=ZWOw
-----END PGP SIGNATURE-----

--ga5BT2NOkCzKwCye--

