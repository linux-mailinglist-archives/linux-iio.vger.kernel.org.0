Return-Path: <linux-iio+bounces-23297-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F32B35931
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 11:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1DCF2A7542
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 09:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E34A3128C8;
	Tue, 26 Aug 2025 09:38:30 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45022FD7D7;
	Tue, 26 Aug 2025 09:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756201110; cv=none; b=kjbJiZDLCbtAypm0sxvbITaSp12xa3mL2F6qVbdHei8Jd96dXMr4te7/nu/nqUI+is46yGWRG4CGMD/agPZtPrlSAyS9AxFMtXLlyzN6WfgMWelLQqVuM1AEnGRfAzxE4x6QmeNckrnZ8dfUxTl3pzwpN661jESRUqZL56nNnQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756201110; c=relaxed/simple;
	bh=oLZ0ROrKpy3Tvz9pYzDHlh6fcBWaxmorbf6mAjrFGqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TlcbaA4gFnDpf2ka8SPUogwT5BZw4SLqxyn7TLJRrGED/FIvpYRqiNaq/d5sHK/uqf5qcbTC+go0ncv+095GtPzB6lcG3saaWra9ZYD8nsgMHLDih7M+AC9MBuORQaNXtrW/w/uC3htuKURhhsZoXww0yNcZoYQlPzAWXoBl/Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 26 Aug 2025 05:38:16 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ben Collins <bcollins@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Antoniu Miclaus <antoniu.miclaus@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/5] iio: mcp9600: Implement IIR feature and add iio
 core support
Message-ID: <2025082605-grumpy-heron-02ec32@boujee-and-buff>
Mail-Followup-To: Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	Antoniu Miclaus <antoniu.miclaus@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250825-mcp9600-iir-v7-0-2ba676a52589@kernel.org>
 <CAHp75Vf_QL4Nm8KDCVT5GQaOqeQtpg_Tz7HTNt5YNFQ0fAAUEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tylbrxaetarwdnkk"
Content-Disposition: inline
In-Reply-To: <CAHp75Vf_QL4Nm8KDCVT5GQaOqeQtpg_Tz7HTNt5YNFQ0fAAUEQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT


--tylbrxaetarwdnkk
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v7 0/5] iio: mcp9600: Implement IIR feature and add iio
 core support
MIME-Version: 1.0

On Tue, Aug 26, 2025 at 11:14:58AM -0500, Andy Shevchenko wrote:
> On Tue, Aug 26, 2025 at 3:10=E2=80=AFAM Ben Collins <bcollins@kernel.org>=
 wrote:
> >
> > ChangeLog:
> > v6 -> v7:
> >   - Remove extra space before trailing \
> >   - Don't add extra white-space
> >   - Remove mcp9600_write_raw_get_fmt
> >   - Separate out the mcp9600 IIR series into its own series as there is
> >     a lot of conversation around implementation.
> >   - Add rework of ad4080 to match filter_type "none" logic
>=20
> Wasn't v6 already applied?

v8 of the mcp9600 feature patch series was. This is the IIR series, of
which, none of it has been accepted, yet.

--=20
 Ben Collins
 https://libjwt.io
 https://github.com/benmcollins
 --
 3EC9 7598 1672 961A 1139  173A 5D5A 57C7 242B 22CF

--tylbrxaetarwdnkk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEPsl1mBZylhoRORc6XVpXxyQrIs8FAmitgIgACgkQXVpXxyQr
Is8phA/+I/SMNGvi+iNk2ZQ2oaaKa9YR1KlowYTpY7YuJNKbF5b/q+3i0JMSIKte
nHDugAkzDHm611wSwHndHiupLMq1sJUMIo04pSxYVTShYq7M+5AXzt/LOakD1wLq
bmfOzGy7vJcj6Ssd2h3cJwM8LJjDUVTQ4lJgMAR04aZZKCkfB/rHfxW9R6dFZszY
55nIXO06yCx+XYPtN8XhxHzMO6QVDrDXJhgNdx3qXhuuS1Rd330qtJu0uRRtK9Ul
pyelKVkH3HE9cPfaEPHZrMN1lkH5JFKoFal0thAHHADf4JxwDZakX0UsoQjbZ9YT
a9ZX4M+pe8LUvNy7mqmCaIjEACjogXlwXDlOOAYbz9nMx7ID6/q4o+RyPMqJowkl
MQ7dRyCsRdPVU1g305Sgry8foe+SejR8cutrkSc+VbFlX+JVbSURkFL+RmyERx3a
iwWa7hT6h1eA3rD4G681j3k7ji0enVNfu7Swm1/kSMuOBwTefLTm3Bzif46RJDuS
owW8cJvax+gs6EVh9iitiurkN1mtCIGUqXqLAmRbuXl6VO3MKuHWfb24yMZD8mcj
ru4Gg+Yy4iavG/tvU4AouKsB1+1j8WogvV71tyYwaQlc6EnGjVdHZ4RqvzpfKXD7
0dlb/LtsaP3vZovF2Y/Dkqy1C/lQL7zzgefu/Bi41pXs66Nna9c=
=rbit
-----END PGP SIGNATURE-----

--tylbrxaetarwdnkk--

