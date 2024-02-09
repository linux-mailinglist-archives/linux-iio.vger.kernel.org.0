Return-Path: <linux-iio+bounces-2334-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE1684F15F
	for <lists+linux-iio@lfdr.de>; Fri,  9 Feb 2024 09:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CF47284A84
	for <lists+linux-iio@lfdr.de>; Fri,  9 Feb 2024 08:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70ED383A9;
	Fri,  9 Feb 2024 08:30:22 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4797F6
	for <linux-iio@vger.kernel.org>; Fri,  9 Feb 2024 08:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707467422; cv=none; b=N/BQuTlx6ZusL/EtGJllUedtCGckhu8u1rXJN114LJaSWEbi6cljb5PTGJtw4tnLtg4uTtiO8uhGgkcvyHIt4GmsLfrY4kbIK5N02UscSegBhyXXufTmof00g7Qt7p3pLqA+mepIiTWCkxFMOm834yWK4tRulbeLvY5kcF+XKgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707467422; c=relaxed/simple;
	bh=s0EkWNrUP/Fgc0KFuWZZVYsyRDDBUvKmAep8sqg2WXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tW/wtH3x5Jh2cYaLSi1yfYnwhes/zvo5ZRvFzZ37bRhvKPxoi+qNSXPGOQrw4vhMUK4EwLCORTDjHbsGhsuSjU8NXN/YJB5J+28OBe0yy734sONrKpujOkPScFVB5wv0wE25fKXDbzI6UeZch33CUiruqjuhi/SCSoVQ+m/RSMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rYMGz-00011t-H9; Fri, 09 Feb 2024 09:30:13 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rYMGw-005NOb-Bl; Fri, 09 Feb 2024 09:30:10 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rYMGw-0017RT-0u;
	Fri, 09 Feb 2024 09:30:10 +0100
Date: Fri, 9 Feb 2024 09:30:10 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: William Breathitt Gray <william.gray@linaro.org>, nuno.sa@analog.com, 
	linux-iio@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] counter: fix privdata alignment
Message-ID: <wkabgwmjkuc7rdtnyko6j5tbhbbrtjeudalhqj5rsut6s2tefa@xry7vuvztlty>
References: <20240205-counter-align-fix-v1-1-4821ced960ab@analog.com>
 <ZcUeyN8OF49CGqij@ishi>
 <2ada0bacadf63dc4216a9a7f4d9d5d47041a8c8b.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w4togufzxp4w3zj3"
Content-Disposition: inline
In-Reply-To: <2ada0bacadf63dc4216a9a7f4d9d5d47041a8c8b.camel@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org


--w4togufzxp4w3zj3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Nuno,

On Fri, Feb 09, 2024 at 08:42:02AM +0100, Nuno S=E1 wrote:
> On Thu, 2024-02-08 at 13:34 -0500, William Breathitt Gray wrote:
> > On Mon, Feb 05, 2024 at 04:58:14PM +0100, Nuno Sa via B4 Relay wrote:
> > > diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter=
-core.c
> > > index 09c77afb33ca..073bf6b67a57 100644
> > > --- a/drivers/counter/counter-core.c
> > > +++ b/drivers/counter/counter-core.c
> > > @@ -34,7 +34,7 @@ struct counter_device_allochelper {
> > > =A0	 * This is cache line aligned to ensure private data behaves like=
 if it
> > > =A0	 * were kmalloced separately.
> > > =A0	 */
> > > -	unsigned long privdata[] ____cacheline_aligned;
> > > +	unsigned long privdata[] __aligned(ARCH_DMA_MINALIGN);
> > > =A0};
> > > =A0
> > > =A0static void counter_device_release(struct device *dev)
> > >=20
> >=20
> > This change sounds reasonable, but should the comment block above
> > privdata be updated to reflect the change?
>=20
> Yeah, maybe. I can spin a new version with that... To be sure, you mean (=
in the
> comment) private -> privdata, right?

I guess he means: "This is cache line aligned to ensure private data
behaves like if it were kmalloced separately." After your change it's
not cache line aligned any more. IMHO keeping "private" is fine.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--w4togufzxp4w3zj3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXF4pEACgkQj4D7WH0S
/k5aPQf+OaO7djYd6CMLdXkWrUMD/8RoF8ZAp3Mdrlhpcrr7O5jrZnAbOLu871Ul
sg1uLoVvMSfsVLqS2KhO1GUhJI9n44qvbzkyq8Ww3nCBFOgfLgU6abSk79xvZWyN
s6inO91LR+U0KOZqZIBQ7lRxBTTHZUeUndaj+fhOJZbPzklPgYDIYHFJgTVr1cPz
LTt2gyvs+ZVpKQ4zlBcwRCNkWZl+FUrT3L1W4Tc07stN5x6pDvpPYKe08pprZk07
xmhD0Ru/OwcvAQNrrzKxyd0FpIYFGiuYuQP5snbVKPldqN15CXHBWcJ02PFNAf0G
LAT2efswh/jf4QGVT3dYJNiVySHp/g==
=zX6S
-----END PGP SIGNATURE-----

--w4togufzxp4w3zj3--

