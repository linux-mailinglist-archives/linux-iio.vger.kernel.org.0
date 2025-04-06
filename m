Return-Path: <linux-iio+bounces-17654-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E88E2A7CD63
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 11:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7DDC16DE48
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 09:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0A219E96A;
	Sun,  6 Apr 2025 09:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=it-klinger.de header.i=@it-klinger.de header.b="RCiVDabu"
X-Original-To: linux-iio@vger.kernel.org
Received: from www571.your-server.de (www571.your-server.de [78.46.3.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93F3186E20;
	Sun,  6 Apr 2025 09:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.3.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743930466; cv=none; b=GdhcfWK/keNuwJB48yF7zNYYYXfoL952y0cvqphPN/bmHu/1/JZJfKL53/uvXCY59ae8rcZAfp+WummRsgvM3FkvA07DS2Uh7b/zwTmRqW2kMB+pzPfw3J4gN1vJhgmktyQTa/73FbIaoe8oFvRAXY9xehVuU+0FNYLO4y+nwak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743930466; c=relaxed/simple;
	bh=+PWWCS63/CbxJpONq3AEhtxPWS3WKuwnVusvHLRtnAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4PaXMyOkRavowha/7v+vY0GJJ3DLFhxbQDDykvzRsDwntBXrVUftWYbS4SBXPvfvqvTsKsdL0qBaUAhyWWoSMAVgkJDvVH/2JnEQRKHZFCuZNfWGOMYKLNq6o0aG9rvsjveEz7y57jrCIDtSqt694rUT2IW7qwMG43H1c1RX3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de; spf=pass smtp.mailfrom=it-klinger.de; dkim=pass (2048-bit key) header.d=it-klinger.de header.i=@it-klinger.de header.b=RCiVDabu; arc=none smtp.client-ip=78.46.3.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=it-klinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=it-klinger.de; s=default2502; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=mhp6ovL8zavoyaSxkv5HYHmsZacM5L2V4hmeVvMF4l4=; b=RCiVDabuoQ59c0QZCA399+Bwv6
	5ORzt0YRL5HT1GFyd264QOsg6XJ3+8FLBUZh7So2Iu9wGw0tBNqM3Na2YGTaTDHcTgprycmR5Q/WJ
	UnUKlYZDcsOWKSK1NrTn3F+LOjinv3T0KFJqO+kCoi7kzTpNEigCSYXmyHOXKBPfa+qzVhmXOaXgw
	wXNOvjqew3x9s55pyh3v2SAzCTCN/RxUWtPqObMOX+m110Ei6y+ST96ngSaFLCz4kP+qoSdspNLC3
	wzxgoccsTY0xa79rikNuTNzyzkvFd0eBIchyvugd8KRbVuaYgorWG70U4SGvJ4vuaKHf5zU/cgZsk
	g7CjKDbw==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www571.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <ak@it-klinger.de>)
	id 1u1LbB-000MBB-2l;
	Sun, 06 Apr 2025 10:43:25 +0200
Received: from [31.220.115.242] (helo=mail.your-server.de)
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ak@it-klinger.de>)
	id 1u1LbB-000LS7-1S;
	Sun, 06 Apr 2025 10:43:25 +0200
Date: Sun, 6 Apr 2025 10:43:23 +0200
From: Andreas Klinger <ak@it-klinger.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	lars@metafoo.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	javier.carrasco.cruz@gmail.com, mazziesaccount@gmail.com,
	subhajit.ghosh@tweaklogic.com, muditsharma.info@gmail.com,
	arthur.becker@sentec.com, ivan.orlov0322@gmail.com
Subject: Re: [PATCH 2/3] iio: light: add support for veml6046x00 RGBIR color
 sensor
Message-ID: <Z_I-qwzUrTNz1DZp@mail.your-server.de>
References: <20250316113131.62884-1-ak@it-klinger.de>
 <20250316113131.62884-3-ak@it-klinger.de>
 <20250317115005.72a539a0@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OfXP2FohRUruAtNP"
Content-Disposition: inline
In-Reply-To: <20250317115005.72a539a0@jic23-huawei>
X-Authenticated-Sender: ak@it-klinger.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27599/Sat Apr  5 10:34:42 2025)


--OfXP2FohRUruAtNP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

I need to pick up the meaning of scale once again for clarification.

Jonathan Cameron <jic23@kernel.org> schrieb am Mo, 17. M=C3=A4r 11:50:
> On Sun, 16 Mar 2025 12:31:30 +0100
> Andreas Klinger <ak@it-klinger.de> wrote:
>=20
> > +static int veml6046x00_get_scale(struct veml6046x00_data *data,
> > +				 int *val, int *val2)
>=20
> How is this related to integration time?  I'd normally expect
> to see that read in here somewhere as well as doubling integration
> time tends to double scale.

In the documentation file "sysfs-bus-iio" it says:
"
What:           /sys/.../iio:deviceX/in_illuminanceY_raw
[...]
Description:
                Illuminance measurement, units after application of scale
                                and offset are lux.
"

This means that the scale should be the real factor and not the gain multip=
lied
by photodiode size (PDDIV) as i implemented it so far.

This means also that doubling integration time should halve the scale. The
higher raw value should lead to the same lux value.

The documentation of the sensor (veml6046x00.pdf) provides us the calculati=
on
between raw green values and lux.
Wouldn't it be better to give the user the real factor to be able to get lu=
x?

The fact that only the green channel can be used for calculation could be
documented in the driver.

Then i found the "in_illuminance_hardwaregain" property. It seems that this=
 is
exactly what the combination of gain and PDDIV is used for.

So what is the scale at the moment could become the hardwaregain and the sc=
ale
the factor from raw value to lux.


To sum up the suggested interface under /sys/bus/iio/devices/iio\:deviceX w=
ould
be something like:

in_illuminance_hardwaregain --> set and get gain and PDDIV on the sensor

integration_time            --> set and get integration time on the sensor

integration_time_available  --> show available integration time values

scale                       --> (only) get real calculation value, taken fr=
om
                                sensor documenation, e.g. 1.3440

scale_available             --> not existing anymore


What do you think?

Andreas


--OfXP2FohRUruAtNP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEE7/NrAFtB/Pj7rTUyyHDM+xwPAVEFAmfyPqsACgkQyHDM+xwP
AVGLqwv/baxRfp2PxoUBztYueZOw/nCf/0TWvxbwS+onIe8CUgUsJsyeV24ij/Ff
XUhfyo1PZZqYCSfoJ2T353NAP5e2htqrhJmZ49Mj9MOh82bXxORBuUc0pyRFlzIJ
C4bwFG2tU5ToIMRMWI3S9nZJDpKyyVK2A4xYwfZ4CXdg9rRrh6SEJll6AyL/huTA
RwqTBlJgz7r62ZW+Zh3LYLQ5FUcVh4Rald4F+SO0r4H2xT92xvs1PhoDMNh4w+jK
goLmmMYtsV6PuRgWCqotl1+9tdMnQh6O49VMa3I57mQlD8naQNDVDq7x+yBbPrS0
JlJFQyVoM/s3OSmpw8Et6TyjJn848klSEIdiZpPk0Yea2/g0ez0IO+eDZk32TzJM
3xviaZcDNa678t42Xzxkxb6OxFNiSfVmo5glD8Iq7DDp3mdwpNqd9vdROsPV0aOx
ZpSwDiMUTWsn8OXLzpLtbE56o5RcmsvK6ZE/tjhl6EdrYxOhAJfcCqZBVYjenF3P
N7YJRdJq
=wPB5
-----END PGP SIGNATURE-----

--OfXP2FohRUruAtNP--

