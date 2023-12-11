Return-Path: <linux-iio+bounces-822-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF3480CF4A
	for <lists+linux-iio@lfdr.de>; Mon, 11 Dec 2023 16:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B86DF1F215D9
	for <lists+linux-iio@lfdr.de>; Mon, 11 Dec 2023 15:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57D84AF64;
	Mon, 11 Dec 2023 15:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="Cuws2eTO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (unknown [IPv6:2a01:7e01:e001:1d1::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CE8D8;
	Mon, 11 Dec 2023 07:17:55 -0800 (PST)
Received: from sunspire (unknown [188.24.94.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 9150D28B50B;
	Mon, 11 Dec 2023 15:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1702307873;
	bh=WOTMrVJ6rfXI+YlOmBSAUf+Szy3Hy69KHvBxie7cgm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Cuws2eTOT3LnOngdKqrHNkAbBJYvoxIhoRHXmdECyt8mP3HrkLyAFdN5oLQG9XB3i
	 BlTtHRZCytLFX7zXvoYbu+B816ftGjxhrzsvzwsj2vs739jDpdcbZgbZIKcsbDY08D
	 9ztUD01mCcfWzbv/cxDK+OfCBypC4dz8+F4663ZA=
Date: Mon, 11 Dec 2023 17:17:51 +0200
From: Petre Rodan <petre.rodan@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Angel Iglesias <ang.iglesiasg@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andreas Klinger <ak@it-klinger.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v8 2/2] iio: pressure: driver for Honeywell HSC/SSC series
Message-ID: <ZXcoH80lB-yrKfCU@sunspire>
References: <20231207164634.11998-1-petre.rodan@subdimension.ro>
 <20231207164634.11998-2-petre.rodan@subdimension.ro>
 <ZXIPUphL8ZEYDQxk@smile.fi.intel.com>
 <20231210121632.12ff9640@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ugamGy6o6jXmtwGC"
Content-Disposition: inline
In-Reply-To: <20231210121632.12ff9640@jic23-huawei>


--ugamGy6o6jXmtwGC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


hello!

On Sun, Dec 10, 2023 at 12:16:32PM +0000, Jonathan Cameron wrote:
> On Thu, 7 Dec 2023 20:30:42 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>=20
> > On Thu, Dec 07, 2023 at 06:46:29PM +0200, Petre Rodan wrote:
> > > Adds driver for digital Honeywell TruStability HSC and SSC series
> > > pressure and temperature sensors.
> >=20
> > There is room to improve, but I think it's good enough to be included a=
nd
> > amended later on if needed.
> That's almost always true :)
> >=20
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >=20
> Thanks
>=20
> Applied to the togreg branch of iio.git and pushed out as testing for
> 0-day to poke at it and see if it can find anything we missed.

thank you everyone.

I'm working on changes for the iio.pressure.mprls0025pa driver - add spi su=
pport,
add the honeywell,pressure-triplet property and fix the honeywell,transfer-=
function
enum property. hopefully without the need to reach 8 itterations again :)


best regards,
peter


>=20
> Thanks,
>=20
> Jonathan
>=20
>=20

--=20
petre rodan

--ugamGy6o6jXmtwGC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE2Ap/wXYVGTXsPl+pzyaZmYROfzAFAmV3KBwACgkQzyaZmYRO
fzDV5A//W0S2op8BiphWvSbUm8yuoXKF1790oDibZv9mzVmEalOgJyDbjQnBqjls
DB5UkzaiMplWx1uiUSuPsWGxKplguR+bxHSne3IMdK88mQZ768Jn95668pKNbdKG
3AzPdwj2UCwPXZitt9jt+Fy1Wjqn3Um/FkMqLeB5Mf4jourZ+DuyRL/SJJpmrUA3
n9MUuFge2284bBuMkffUL5WwqpdVVxg95UKl62A/xheqb++DoBFXsShPqCIMPqoB
KqHCnKGfIIZD8dlolTuiPwvhAGlhF+bZb/upAmqXHE6IDPrKZ4iX8KcTgJtKfsxv
PIkcu1kT7jtcjUQkZLElJHjCaq/WhbQNk4XmpGvgHE2G+SSz2bOrPzl6kfxX1Qn0
V0YcSOZDMeqM9ysJY8jXrbFb3Dmvg3MMbdhOrlXHVOeF/yQ84qYWqKSfZplmWyai
pmVpEaY++ByRhFsPP/lzO1jzzQPjZt43y7NqtpDka+820xOsVQxO0DaVCduEloAz
vjCVW6lyXs9JMpMxezhFUxlmoLHckTX+QZJoEu+HTRZoLJPjR3hPp9PMpQURJ5B7
RVSibwjrPznl+PxMxZtJLDiOH2Ywbml/160qhrQLSDGFvVpxTcjms9cQly/afzok
vt5PMF8nVbFpnKIPHZ5XIdJ1e0/SAXM7WQ0BZyHjN25Yr6VWYGI=
=De48
-----END PGP SIGNATURE-----

--ugamGy6o6jXmtwGC--

