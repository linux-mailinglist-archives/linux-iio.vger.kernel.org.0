Return-Path: <linux-iio+bounces-19185-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6B9AABD44
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 10:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2320B520346
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 08:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595B024BCE8;
	Tue,  6 May 2025 08:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=it-klinger.de header.i=@it-klinger.de header.b="r4DpE1ap"
X-Original-To: linux-iio@vger.kernel.org
Received: from www571.your-server.de (www571.your-server.de [78.46.3.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AF52512FB;
	Tue,  6 May 2025 08:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.3.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746520128; cv=none; b=UxJzrs03MOeq+JxkM2QFLjqGEys0yiGM2tG85yyTdYeGPpWYhGo5UoFARyblRsAtJDt8V5jU4DXnYoPNOMH2gc/tDpg7zGCrJOmvAy4oYYmlp309iTNqFwoktU4X/FexhSmz5qgm46R2P+dRCKljtCAEObkeTrdhXbshRD9ldck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746520128; c=relaxed/simple;
	bh=vFGKbj51Qajls3VjRgTkmeH70g44w/oqfB16ecKLVVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RUCV6CEY9/POGoOF67De9XkkbmuOe9tVM9oen1bPqXwsczp70yuyenponOSZ+txNpNzni1+tAheEdjP99eeST67OB52s+x4iiJSTDypVO9iTVL3Uqxsc0ThqzMIAaXfLS/zaXfQAN8VKHEVevQyOg18jRFKl2Cfs12jC4lrO7lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de; spf=pass smtp.mailfrom=it-klinger.de; dkim=pass (2048-bit key) header.d=it-klinger.de header.i=@it-klinger.de header.b=r4DpE1ap; arc=none smtp.client-ip=78.46.3.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=it-klinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=it-klinger.de; s=default2502; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=mYBx0CJRklxHg5jmra3Bhh9KqI+k6/L/yb4VoX0n7yE=; b=r4DpE1ap/lyvy7MjCmpoK/oXt0
	QWba6qFu+LQUU9ZpcogTmCO0Bk11ebGH9cpctHSxVaBbu0kOZ61bXtH4XUkM+NDassUWmnuQ5+lI4
	m2zLHzwjp7Jr3kLIqyCwV2B6DAFASf6Zq5u1SL+UCC4B02eqXJwBbbNhBY6Le5YXjO7w2S+c2S9XM
	FaYFcX1zfVmT/PYRFWWNwZI+UcIbL5J1yyZNJeGY5nrsMqhofO1peWyzNFj3xtMb+Dn/cw7U9n3bE
	tgZyTmBRpWLlBZ1X1+sgQQjIoTS1nDXlBqzr0IwsyFfB77NU2EQlVrTQ4T2IdEYiYdMlaTPjb7olq
	qn3cNbMg==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www571.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <ak@it-klinger.de>)
	id 1uCDfL-0009sJ-39;
	Tue, 06 May 2025 10:28:39 +0200
Received: from [31.220.118.240] (helo=mail.your-server.de)
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ak@it-klinger.de>)
	id 1uCDfL-000Eoj-0X;
	Tue, 06 May 2025 10:28:39 +0200
Date: Tue, 6 May 2025 10:28:38 +0200
From: Andreas Klinger <ak@it-klinger.de>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, lars@metafoo.de,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, javier.carrasco.cruz@gmail.com,
	subhajit.ghosh@tweaklogic.com, muditsharma.info@gmail.com,
	arthur.becker@sentec.com, ivan.orlov0322@gmail.com
Subject: Re: [PATCH 2/3] iio: light: add support for veml6046x00 RGBIR color
 sensor
Message-ID: <aBnINvJ0aS69kUI8@mail.your-server.de>
References: <20250316113131.62884-1-ak@it-klinger.de>
 <20250316113131.62884-3-ak@it-klinger.de>
 <20250317115005.72a539a0@jic23-huawei>
 <Z_I-qwzUrTNz1DZp@mail.your-server.de>
 <20250406120825.41b2575c@jic23-huawei>
 <ecb2844c-feb5-47d4-b4db-12171380a9cb@gmail.com>
 <aBkNHSxU4T8j4oMT@mail.your-server.de>
 <181472f0-5c00-4e1d-8f00-1d84b5c54685@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jOV+RP1UMYlBuzOh"
Content-Disposition: inline
In-Reply-To: <181472f0-5c00-4e1d-8f00-1d84b5c54685@gmail.com>
X-Authenticated-Sender: ak@it-klinger.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27629/Mon May  5 10:35:28 2025)


--jOV+RP1UMYlBuzOh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Matti,

Matti Vaittinen <mazziesaccount@gmail.com> schrieb am Di, 06. Mai 09:03:
> On 05/05/2025 22:10, Andreas Klinger wrote:
> > >=20
> > > I was CC'd due to the GTS (gain-time-scale)-helpers. The above is the=
 beef
> > > of those helpers - which, attempt to aid drivers to convert the impac=
t of
> > > the hardware gain + integration time into a single scale value. This
> > > approach has some caveats, but the goal is to fulfill the expectation=
s of
> > > those user-space apps which expect only scale to change the gain, whi=
le also
> > > need to have the integration time controllable (for example to reduce=
 the
> > > measurement time for one reason or another).
> > >=20
> > > Problem is that, especially when there are multiple channels with sep=
arate
> > > gain control but common integration time, there will be some situatio=
ns
> > > where the integration time change _will_ cause changes to "total gain=
 (E.g.
> > > scale)" too. There may also be cases where some scale values can be m=
et only
> > > with certain integration times, or where a scale for a channel can't =
be met
> > > maintaining the scale for other channels etc.
> > >=20
> > > All in all, I am not sure if the 'unchangeable hardware gain' approac=
h makes
> > > things as simple as possible - but as long as we want to have it, the=
 GTS
> > > helpers may be of use :) There are couple of drivers using them - fee=
l free
> > > to take a look. "git grep gts_ drivers/iio/light/" should point you t=
he
> > > current users.
> > >=20
> >=20
> > Thanks a lot for illustrating and explaining the GTS. I implemented the=
 driver
> > with GTS and by this learned a lot about it. But at the end i found it =
in my
> > case to be simpler to implement it without GTS for some reasons:
>=20
> Firstly, it's perfectly Ok to choose to not to use the GTS helpers. Yet, I
> would like to understand couple of things.
>=20
> > - User wants to be able to set up the integration time as well as scale=
 and the
> >    driver should not optimize it somehow.
>=20
> How does using GTS to do the conversion from
> HWGAIN + time =3D> scale
> cause optimization? Or, do you just mean that part of the functionality
> provided by these helpers wouldn't be applicable, while the conversion co=
uld
> still be done?

This functionality is not applicable. The user wants to set up the time and=
 gain
manually. There are applications in which the driver should be fast with a =
lower
integration time and others in which the best accurate result is required. =
As
i'm developing it for the sensor vendor they want to be able to demonstrate
all the different settings to their customers.

> > - There is not only a relation from the scale to the gain of the sensor=
 but also
> >    to the photodiode size. Because of this i need another helper table =
asize of
> >    GTS for translating the scale into sensor gain and photodiode size.
>=20
> I suppose that using the GTS with gains and times without PD, and then
> computing the impact of the PD size after the GTS conversions would have
> caused the available scales to be wrong, right?

Exactly this caused me most of the headache. With GTS i need to use a "virt=
ual"
scale for the calculation. When user asks for available scales or set up the
desired scale i need to convert it to the real scale and then further trans=
late
it to the register values of gain and PD.

> Couldn't you still have used two different set of gain tables (one for ea=
ch
> PD size) if you chose to use the GTS?

Of course there are solutions for it and i was about to finish one with GTS=
 as i
saw that the driver will get simpler without. As i cannot use the nice feat=
ures
of GTS it turns out to use only the data structures and functions on it. Bu=
t the
data structures don't fit exactly to this sensor as we have gain and PD in =
two
different regfields. So another table to translate the scale to the regfiel=
ds is
needed anyway.

> > I'll come up with a version 3 shortly.
>=20
> I took a very quick look at the v3 - not one worth a reviewed-by :) And, =
as
> I wrote, I have nothing against skipping the GTS. I'm not sure the values=
 in
> the multi-dimensional array were clear to me at a glance - but I assume i=
t's
> lean and efficient when one wraps his head around it.=20

The large table contains exactly the values from the datasheet for the
conversion of raw measured counts to lux. I only combined the two tables fo=
r PD
1/2 and 2/2 as hwgain x0.5 and x1 are existing twice.

> So, I'm not trying to argue you should've used GTS - I just want to under=
stand
> what was the exact issue with it :)

There is not an issue with GTS. In my opinion it's not the simplest solutio=
n for
this sensor in this case. I'm quite sure there are other cases in which it =
makes
a lot of sense to use it and as i'm now a little bit familiar with it i'll =
be
using it if appropriate.

Best regards,

Andreas


--jOV+RP1UMYlBuzOh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEE7/NrAFtB/Pj7rTUyyHDM+xwPAVEFAmgZyDUACgkQyHDM+xwP
AVHjPQwAkI4wNjatWb1gPWhQS8HazIDmrx61CLlpOpcoRaRX0gmI3y6hUwsQOLKY
GW5ieajnTYRQeiSUkDPRR2M0G07OHudhcnQ9gN+RGsBburujLxFwnjFXcSf4q/l5
4RjLjUoMsL6izBZS6QMbcapCG/FrUAQUkuNvX9sG63+pQR6B9iZv291R7MvMKQ8o
RaYB66HgFmOVI6z0+9XJdRWUOTjPzJ2lZI3SXKWUPMbMSr15WnBL8R66hPJoERyS
F0HhWH56T3sCYL34G/T0vEJCE5vK9teenupPn1hH2kZI8CqTJiCIhg7g/46jjfyZ
fFEpWTkA+y5XXqdfl+59wWWxB85UCiAqqr4oAxYNp8efD0UzKRTU6lElDv9kfjjr
1ph8GwZgMdP9uy+ugVQFPXzYOKcaqf/Cf929nOKBbj0Kn+wupa0gYARKkZyT/rJa
DvVp94d7erQDFbE+Nh0wY2LZNB7h0RTxvRyvwaHed7arqHkbfkyu8nws2jiu8mWS
NquhvVId
=xSeQ
-----END PGP SIGNATURE-----

--jOV+RP1UMYlBuzOh--

