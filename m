Return-Path: <linux-iio+bounces-15739-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B35A3A3D8
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2025 18:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2174E17651C
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2025 17:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48FB26FDAC;
	Tue, 18 Feb 2025 17:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ksu2lZaa"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CB026FD99;
	Tue, 18 Feb 2025 17:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739898828; cv=none; b=RCD27ORRQMflzUzqJ0DMWzKGTnc+Os/h2SmZOuVYDLNG546qxsGdXKYKCd8M55DMQzE8pVgM9LqZnxtJVMuPistkagZZO9gbAq5LRT8ANd+eXO270kNvZZXe1AjARifYVClqzx/2cx7hjiJ/GB0FGvbdaxPL6QyZtznbHgC/0NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739898828; c=relaxed/simple;
	bh=zMBG5U0y5k0fAXa5nBTK3Y5aZzrRhzGrNTjaVJUvAHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fIQpcuhl+HvtmNDCF0kPXpRCvfUKJVN/WcpBRPWGLhi03YjdLeH8La36dyTTxUTyeCZGrpPvPfOY95i6k5ph6sAXT8/Tu6vZlY+eZFkgiFteymEWkco5x0s8YvpaHtRe4m+Ss35pHDnY744PPySPG4quywSqjkopw8jhjigECUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ksu2lZaa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8C1CC4CEE2;
	Tue, 18 Feb 2025 17:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739898827;
	bh=zMBG5U0y5k0fAXa5nBTK3Y5aZzrRhzGrNTjaVJUvAHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ksu2lZaakOto5UkVGseoZ948bXS4+zoqZKlxwoJ7T9LCElMhPfUmxGFfGyZBRANAM
	 ZI75jXLhiZUABGl0X/E72U03C0eaLuWll1e4h2MwPw/e1Kn2oasNTDtUM5lDNmx4QI
	 VgsBSfcaeybkLRY5cZj7D7icpWmEZzIHvnkh2296g9EIEg6dXhTmXVSr04DGgwzS5X
	 QA1p63m0KPbKxBy+RAoJaLwHsb+nzYksUMSsJ3kJx1lLIxVu1IXAzy8VCl/CPQ3UCW
	 4bvRXOZVlyqzYxUv1edgrvKhY5aWCA3TwVo0Xb9RTMdG7yG1ndRS9EiW+lK8f6phqn
	 XIa2Qd8sRG3wg==
Date: Tue, 18 Feb 2025 17:13:41 +0000
From: Conor Dooley <conor@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Emil Gedenryd <emil.gedenryd@axis.com>,
	Arthur Becker <arthur.becker@sentec.com>,
	Mudit Sharma <muditsharma.info@gmail.com>,
	Per-Daniel Olsson <perdaniel.olsson@axis.com>,
	Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	Ivan Orlov <ivan.orlov0322@gmail.com>,
	David Heidelberg <david@ixit.cz>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v1 1/3] dt-bindings: iio: light: al3010: add al3000a
 support
Message-ID: <20250218-browse-animator-50e846a616b0@spud>
References: <20250212064657.5683-1-clamor95@gmail.com>
 <20250212064657.5683-2-clamor95@gmail.com>
 <20250212-unwritten-compile-7011777a11b3@spud>
 <CAPVz0n0xR_nGPdWn800H=HhMCPqnRUhqP-s1P4eMhtpZdxpxzg@mail.gmail.com>
 <20250213-reflex-earlobe-ebbeaece6fad@spud>
 <CAPVz0n1aw1+kKhvGwOUi_58HqRqo0fHxDNRQZt_2O4yJ=ws56w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9aHkRpTM7X6bOBao"
Content-Disposition: inline
In-Reply-To: <CAPVz0n1aw1+kKhvGwOUi_58HqRqo0fHxDNRQZt_2O4yJ=ws56w@mail.gmail.com>


--9aHkRpTM7X6bOBao
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 08:21:03AM +0200, Svyatoslav Ryhel wrote:
> =D1=87=D1=82, 13 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 22:15 Co=
nor Dooley <conor@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Wed, Feb 12, 2025 at 09:39:06PM +0200, Svyatoslav Ryhel wrote:
> > > =D1=81=D1=80, 12 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 21:2=
0 Conor Dooley <conor@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > > >
> > > > On Wed, Feb 12, 2025 at 08:46:55AM +0200, Svyatoslav Ryhel wrote:
> > > > > AL3000a is an ambient light sensor quite closely related to
> > > > > exising AL3010 and can re-use exising schema for AL3010.
> > > >
> > > > Quite close you say, but the driver is entirely different it seems.=
 How
> > > > closely related is the hardware itself?
> > > >
> > >
> > > Well, I can simply duplicate al3010 or al3320a schema if re-using
> > > schema is not allowed. AL3000a has no available datasheet online.
> > > Downstream code for al3000a and al3010 seems to have same principles,
> > > apart from light measurements.
> >
> > It's probably more of a question as to why you're duplicating the driver
> > for them, rather than telling you not to put both bindings together.
> > That said, information on what's actually different is helpful in the
> > binding, to explain why you're not using a fallback compatible etc.
> >
>=20
> Quoting writing-bindings.rst:
> DON'T refer to Linux or "device driver" in bindings. Bindings should
> be based on what the hardware has, not what an OS and driver currently
> support.

No need to quite that back at me, I'm the one usually attempting to
enforce these things. I just expect more information about the
similiarties/differences when you're content splitting into two drivers
but want to reuse the same binding.

>=20
> From all available data, hw configuration of al3000a closely matches
> al3010 and seems to be part of same sensor lineup. It is not
> prohibited to add new compatibles to existing schema. Schema does not
> take in account way of processing data generated by sensor and this is
> the main difference between al3000a and al3010

Please mention this in your commit message.

Cheers,
Conor.

--9aHkRpTM7X6bOBao
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ7S/xQAKCRB4tDGHoIJi
0iZLAP9TckPYqEb93zq2HyljnW8ogxHQF5BWPdBZFfXYC7ZbTAEA9FAUL1hTR9S/
NqdS/aPc+GE5mlLICMyhaTI8PnmoIwA=
=GuzI
-----END PGP SIGNATURE-----

--9aHkRpTM7X6bOBao--

