Return-Path: <linux-iio+bounces-26868-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D035CAB247
	for <lists+linux-iio@lfdr.de>; Sun, 07 Dec 2025 07:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 90C6A3008552
	for <lists+linux-iio@lfdr.de>; Sun,  7 Dec 2025 06:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD0F2E1EF4;
	Sun,  7 Dec 2025 06:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="05fuBmbY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A958C2D593E;
	Sun,  7 Dec 2025 06:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765090724; cv=none; b=YKO0z29cTkdyBk28RuhdyNaNs9AJ307OVmX+DBsu7EtABxcwBFNbQXgzlShghDPcc3OPl7iyWyyq7kxatwD0flU+jrtQdY0zMgoCQ/btODX7i2h5GEaUcH0usRIscl3zpABYVvMCHGulV3BK2cYJoR341CsfxQYLoGBX+jF6cck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765090724; c=relaxed/simple;
	bh=Rj+cBQTuoFKUXNCiEWcTtFjgLfh7SzJNFYxeDYswCdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AjnWfyPtOSs+QNDvX/WvLnqXzC3r2DNMLWjqD9OVYsY5R39hkIgKAvcIy/eltMPhQtV/bKeds/3xqKn70Iy24upZh0S5EV/ceT33AkZTRjHiNC7d9NbH+H80k8PXoFM5kzWD6zPsmgSNFaFs6PukWCQIg2Cytmy+IRhcJFHSyOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=05fuBmbY; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire.home.arpa (unknown [IPv6:2a02:2f0e:3402:a400:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 999F9160209;
	Sun, 07 Dec 2025 08:58:39 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1765090720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vNYqDFxmnHanesdjb9oic57DVhqZX916YNdOdPgzAk4=;
	b=05fuBmbY6YumZH7ZyKlWrrmjbSb+ofzoOjB87HNiH+k5g+nJNwpuXM5SpQiK0iR22CwZvY
	MBJwW8/Izpay2M3GTXYO/257md12gppz9r5DrIPzWAuLG6VLvPqoNlHEVI8PgjebLZDOTK
	yvEQQMaM3XtpkITZm9Jn6PaHS2GoBpHmreoVqhYroncgNzB372F7hHsI8oku1bSKK7FLCq
	1awUE9DiRdAdarUngApl6SbFaqShlsEdVTQ884FzQ84dc7CXD8JkZzApeACz4ACV7Wbpxp
	nLXKbfiDb26sqOeZ/Qc3LwiLkiL8BwY24JZcMEEvMkAEjYEArzaFkqkU662oUA==
Date: Sun, 7 Dec 2025 08:58:36 +0200
From: Petre Rodan <petre.rodan@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Nuno S?? <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: pressure: add Honeywell ABP2 driver
Message-ID: <aTUlnJTuZwvoSUPh@sunspire.home.arpa>
References: <20251204-honeywell_abp2_driver-v3-0-ad3275bad35e@subdimension.ro>
 <20251204-honeywell_abp2_driver-v3-2-ad3275bad35e@subdimension.ro>
 <20251206205407.6ba41d76@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k2oeZaQilhKo86D/"
Content-Disposition: inline
In-Reply-To: <20251206205407.6ba41d76@jic23-huawei>


--k2oeZaQilhKo86D/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hello Jonathan,

thank you for the review.

I actually heard about structs who's elements are 64byte padded so they don=
't end up in the same cache update in another context but up until today I =
did not make the connection with what is going on here.
thank you for the detailed explanation.

On Sat, Dec 06, 2025 at 08:54:07PM +0000, Jonathan Cameron wrote:
> On Thu, 04 Dec 2025 17:12:56 +0200
> Petre Rodan <petre.rodan@subdimension.ro> wrote:
>=20
> > Adds driver for digital Honeywell ABP2 series of board mount
> > pressure and temperature sensors.

[..]

> Nice clean driver.

well, thank you. I will be sending in a few modifications to my other Honey=
well
drivers based on feedback received here.

> > +#include <linux/jiffies.h>
>=20
> I'm not immediately spotting use of this but I might well be missing it!

it's an indirect include for the definition of 'HZ'. requested by Andy.

> > +	data->scan.chan[0] =3D get_unaligned_be24(&data->rx_buf[1]);
> > +	data->scan.chan[1] =3D get_unaligned_be24(&data->rx_buf[4]);
> Turn on just the second channel and run the test in tools/iio/ for buffer=
ed
> reads.
>=20
> You'll see data from the first channel not the one userspace asked for.
> Set available_scan_masks =3D { 0x3, 0 };
> allows the IIO core to know this is what is happening and shuffle the
> data as necessary for you.

nice catch. it was outputing pure garbage (not the first channel) but your =
change
fixed it.

best regards,
peter

--k2oeZaQilhKo86D/
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEGiKYHD4NvFCkTqJ3dCsnp2M6SWMFAmk1JZoACgkQdCsnp2M6
SWO1Mw/8DExzhW+lthw18pyB6HG+RLUoGE+GQUDt1QkOM9ykprjPG/25ldzKiJ9X
7wcOii2Q0uMwKotceS31Jq1WmVJiQyN5kOy31EEkBTo6hff2aYgbfdtznkHVAVgg
Ekoz1vU/fxVeQfYct2356sWetcUBqew6zUbC1Fn7sqE9VXgzVXYiGWEhm/JbkzIG
LNLwSRSYZf7LrAEN7fgfJCRwXxfDq6iV1Yv1H4GA2UOY7O+iscgukMaTUirEi9sq
yYBZEo+IfTpRSCtBsnayxyEz2UhL7sJidvHJEYNXz1CBROGKAZTlXTPHVOnKSea1
61WmRuvP6rc6MZ4nsrO/Wck232Ct3o8GoaYzh9/Oi0u5J53UoZ31I/dHXwBC9qre
lOkJQrZuqVTy/qxPu1h+2mOXQSoJvFxcKi1T9WlrG+3VW0nnzK+Bobk0cU6Qt6sK
PdTzhNhJ//gbRfRuyPpewlkmVrB7DX+6MxcJsVBMzAKkooR27LQuJKOn1wzAV3Sp
8lNznPJjnOWLfFkbxfaA/vzQ51/BIw/WjBLgS8NxNosle2H/Oeh1yZ4la2yXsJus
qZawLTA5epxTBEb8caCMpEjRhe6TRYZxb4W3RA0L9ExZ7lXwOhpri5J6W7WKd2bY
oaERASmJAkL9+L5APLxnIOs1IFb8iEE3KZYuh3bwoZFtSAdvwFw=
=XiKR
-----END PGP SIGNATURE-----

--k2oeZaQilhKo86D/--

