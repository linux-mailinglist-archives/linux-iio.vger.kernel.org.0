Return-Path: <linux-iio+bounces-25062-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D6CBDAB5F
	for <lists+linux-iio@lfdr.de>; Tue, 14 Oct 2025 18:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7421188641E
	for <lists+linux-iio@lfdr.de>; Tue, 14 Oct 2025 16:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2143043C7;
	Tue, 14 Oct 2025 16:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="yjIwtdsw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1E3303CA3;
	Tue, 14 Oct 2025 16:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760460777; cv=none; b=AGqikO1D+6+ISvXKyUH2XIV1ebgM0tFPkFVGz9xDMO/lFmAvq1qxOSQOvraLzVAT1lZjSb0xWoh/BWNe8Z0hw88sb9UiLFNajOMQ0RMEBScSpVBd4ryERBR9rq4m7hnFC0o4km2xIRSvYhN0/9BlXjOHXNKdINVQfFrl0rgUJhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760460777; c=relaxed/simple;
	bh=GKy3CsgeVEziiA5cIc4W4QjNm8fGJ8NYQLZqkXShyDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ELoLjuGGIAjTP4UcJgQo6a61RiCwKFBXUOsXFMWjk/ngvaCoXXlabeZEtZcXvTyXiFDosDm991pQ1Uwk1kQMEnkXVetDt2T4PmliGQl06jkxjTvNry8MzE44SpYtLfZKrK+Lw3qFjr/vN+wj0r1V2lNhFxh+4uFMvv1ZaUneeks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=yjIwtdsw; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire (unknown [IPv6:2a02:2f0e:3e0c:5b00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id A9007173BE2;
	Tue, 14 Oct 2025 19:52:52 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1760460773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GKy3CsgeVEziiA5cIc4W4QjNm8fGJ8NYQLZqkXShyDw=;
	b=yjIwtdswtZckUEClrroV9KVdsBJVYVuDBNpJKQM150BCjDDj0HGiXzbqbd2MKnBgBsWUBJ
	2etxvuds5SYbXCoBLEjVsp9FmWrVCSBxK0XooZR/hklBYfcV1tDoR8QeGEChSBYyRFGP1D
	pyvSJurL5yur27AzzIF84bC9lad9hkx5n8yLrpH1pZbARaveNh9G+GhJzvZdEKYhsL/ld6
	zJNoFyE2N9sjNWInLspfMU8Hv195TPFLV1lFfAGmo5w/VHpUeLc0kbp4cuKJkaSoHXyG/S
	Vsdtn+OYoBvR++Yldq3GWYsg9pfTIRPvK8PKtzz+7BHbRhz930wtTI8jhgwWIg==
Date: Tue, 14 Oct 2025 19:52:49 +0300
From: Petre Rodan <petre.rodan@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Nuno S?? <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 07/19] iio: accel: bma220: split original driver
Message-ID: <aO5_4Z7l_25Xhwrg@sunspire>
References: <20251005-b4-bma220_improvements-v4-0-0f449ba31585@subdimension.ro>
 <20251005-b4-bma220_improvements-v4-7-0f449ba31585@subdimension.ro>
 <20251012155201.137d330b@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cSLGsdkGlZvXJscF"
Content-Disposition: inline
In-Reply-To: <20251012155201.137d330b@jic23-huawei>


--cSLGsdkGlZvXJscF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi Jonathan,

On Sun, Oct 12, 2025 at 03:52:01PM +0100, Jonathan Cameron wrote:
> On Sun, 05 Oct 2025 16:12:16 +0300
> Petre Rodan <petre.rodan@subdimension.ro> wrote:
>=20
> > In preparation for the i2c module, move the original code into multiple
> > source files without any other functional change.
> >=20
> > Create the additional bma220_core module which currently is not
> > providing an abstracted bus type (this will change with the regmap
> > patch).
> > Fix a few includes in the context of this patch.
> >=20
> > Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
>=20
> It required a bit of hand tweaking after the include tweak I made in the =
previous patch.
> Also due to comments in here I tweaked a bit more:
>=20
> Please check the result on the iio.git / testing branch.

I included two trivial patches in the new series 'bma220 events' that do a
pre-cleanup of this driver.

Thank you everyone for the feedback.

best regards,
peter

--cSLGsdkGlZvXJscF
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEGiKYHD4NvFCkTqJ3dCsnp2M6SWMFAmjuf98ACgkQdCsnp2M6
SWPkkQ//SGUwmkD/fdR1PcYoNe3Hvh6N/wbE126MNIw1N9syvZJhu4S/uRfwnIIQ
f5tcX8/4QhE7972CdeSC5fLuWE0O7IzeiV4HrfwUapgE5+lhCPAZV773LOqBj8QH
ObtXMVgQ/uwWL92XR5XwZez8nPp/sy+CN7YGM93UyXIiLrjuLcgmkNn26Mwfvghx
ZijjdfbSBU3JPx89rpOiY2RCLhM+UKoAcopPKVvo5wszrzgO3g8ajyACnSlGN0Ez
Uhm4ObSwDoYr/UWdqgHDq4yJlBxT8SDlMeg7tOZb3lNpMNbBGhmgWcruJ2x7ereh
ww/QMwDxb3wqrljiWthZx2+v0mvP9v18EnKyufz8CkiWgBsRhmAsJ8gLcmelXja3
EvSHEVzToCrmbmg5MMIcou9AfzPqV5HIedh+OzYIneXX35h7hnZ9aEefRYyhRgK4
ZWfHsil/d0W8Rmv6uWdT6zzbi9kF3TUUm32/6d6oJZOXEJ25Rs/t1Gar3/+UDlcP
UpTEwGBj4plklAgl4iNKZErsq0fI4NFLchA13ckzTX9CUwhq9ngP6XukZIpBDjF5
fSA2HYYVOzXtTdC+0GY9ANc1oNBWJ/8mmL+FEZ3mhSSOU7zYqEqEGnwCQ4ZYDZ3g
sN6exKzpODmo+OTm9zeJ5+/tHEPu+f6vU3ETrbRzeBhxU5ITj9I=
=vuEw
-----END PGP SIGNATURE-----

--cSLGsdkGlZvXJscF--

