Return-Path: <linux-iio+bounces-2336-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 543EC84F2BF
	for <lists+linux-iio@lfdr.de>; Fri,  9 Feb 2024 10:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4E411F2315C
	for <lists+linux-iio@lfdr.de>; Fri,  9 Feb 2024 09:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A9D69319;
	Fri,  9 Feb 2024 09:53:14 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F160067E66
	for <linux-iio@vger.kernel.org>; Fri,  9 Feb 2024 09:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707472394; cv=none; b=K5PPodBG2Hkf0uHnmXdh3fD6bge5d9xErZUcrAmAR7EezsYdDjxnnNHigE9j9tG/7X3klg0otWucRe2wbQO6I3zEelUOKKq7MTVcoSLr4VRh+IPHaZ5k7UnlvxNpmPDZEv27r/Pvi9smTuXR5UundCLsqV99UmcwrYeMYFhsILo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707472394; c=relaxed/simple;
	bh=2IzTCvfVd7DW7ZrhwIX2VCDOzl3o1YjUbi6XJt3Tyzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dFW57qkxi9rRtJbLLhSujD1etvdYHQEANtmvN6zrgdLs1FxlXnla4zBlCt0grisPZ1q6e5MRZZSES+NcUz30rZKTlUiDTVVCgjPmXIEQt2up3jbIMWyliGEOk+Jm62Yeb0a1240IcONKsAYHujRDLH1EOSVjuwv9TX7+6E/hheQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA3A8C433C7;
	Fri,  9 Feb 2024 09:53:12 +0000 (UTC)
Date: Fri, 9 Feb 2024 04:53:10 -0500
From: William Breathitt Gray <william.gray@linaro.org>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	nuno.sa@analog.com, linux-iio@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] counter: fix privdata alignment
Message-ID: <ZcX2BohmfzwF1_Is@ishi>
References: <20240205-counter-align-fix-v1-1-4821ced960ab@analog.com>
 <ZcUeyN8OF49CGqij@ishi>
 <2ada0bacadf63dc4216a9a7f4d9d5d47041a8c8b.camel@gmail.com>
 <wkabgwmjkuc7rdtnyko6j5tbhbbrtjeudalhqj5rsut6s2tefa@xry7vuvztlty>
 <9abe545667599a085b346bd280fe96201d66f59a.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XMlHQKal9VtaqFx8"
Content-Disposition: inline
In-Reply-To: <9abe545667599a085b346bd280fe96201d66f59a.camel@gmail.com>


--XMlHQKal9VtaqFx8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 09, 2024 at 10:07:19AM +0100, Nuno S=E1 wrote:
> On Fri, 2024-02-09 at 09:30 +0100, Uwe Kleine-K=F6nig wrote:
> > Hi Nuno,
> >=20
> > On Fri, Feb 09, 2024 at 08:42:02AM +0100, Nuno S=E1 wrote:
> > > On Thu, 2024-02-08 at 13:34 -0500, William Breathitt Gray wrote:
> > > > On Mon, Feb 05, 2024 at 04:58:14PM +0100, Nuno Sa via B4 Relay wrot=
e:
> > > > > diff --git a/drivers/counter/counter-core.c b/drivers/counter/cou=
nter-
> > > > > core.c
> > > > > index 09c77afb33ca..073bf6b67a57 100644
> > > > > --- a/drivers/counter/counter-core.c
> > > > > +++ b/drivers/counter/counter-core.c
> > > > > @@ -34,7 +34,7 @@ struct counter_device_allochelper {
> > > > > =A0	 * This is cache line aligned to ensure private data behaves
> > > > > like if it
> > > > > =A0	 * were kmalloced separately.
> > > > > =A0	 */
> > > > > -	unsigned long privdata[] ____cacheline_aligned;
> > > > > +	unsigned long privdata[] __aligned(ARCH_DMA_MINALIGN);
> > > > > =A0};
> > > > > =A0
> > > > > =A0static void counter_device_release(struct device *dev)
> > > > >=20
> > > >=20
> > > > This change sounds reasonable, but should the comment block above
> > > > privdata be updated to reflect the change?
> > >=20
> > > Yeah, maybe. I can spin a new version with that... To be sure, you me=
an (in
> > > the
> > > comment) private -> privdata, right?
> >=20
> > I guess he means: "This is cache line aligned to ensure private data
> > behaves like if it were kmalloced separately." After your change it's
> > not cache line aligned any more. IMHO keeping "private" is fine.
> >=20
> >=20
>=20
> Oh yeah...
>=20
> Yeah, it will depend on the platform. In some, it will still be cache ali=
gned
> but in others (as x86 which is DMA coeherent I think), it won't be and we=
 can
> actually safe some memory.
>=20
> - Nuno S=E1

Yes, I was referring to the possibility that it won't be cache aligned
anymore in some platforms as you mentioned, so a different comment would
be better there now. You can keep the "private" wording if you like, or
use "privdata" if you think it's clearer.

Thanks,

William Breathitt Gray

--XMlHQKal9VtaqFx8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZcX2BgAKCRC1SFbKvhIj
K/9VAQDGKNJbQhNyauNyg+Yvqsv88LNUA7U6mLMqjS+JF5bu9gD/T/tgPC0NL7jS
JjwSoUddFfF9O5TK+JVd5BuAkpoOnAk=
=wGD6
-----END PGP SIGNATURE-----

--XMlHQKal9VtaqFx8--

