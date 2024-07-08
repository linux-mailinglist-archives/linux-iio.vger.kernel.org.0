Return-Path: <linux-iio+bounces-7437-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0503B92A2C9
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jul 2024 14:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A54571F2100D
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jul 2024 12:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF1B7641D;
	Mon,  8 Jul 2024 12:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="2a9Cpoc3"
X-Original-To: linux-iio@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F223C08A;
	Mon,  8 Jul 2024 12:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720441779; cv=none; b=e9JcbIk2Njjp1td5+Hxfx120C2YUHGNhA9/di3hciF3199v4DxfBBYJ5kPBqlc0e+gk35KSknN6gvnElNB3dHKx5Uvc/5PuLLcSJOJl3+2RAwuaWSX6L5R9PctX2SeAWY+YmVZKN3UyNLMNF+BYBl5o9jYhO75nXL9tR+LPQ+ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720441779; c=relaxed/simple;
	bh=6/tJEdm3LbGFbJ6Qpev52Qt/ug+c8GBgOWAXsyW9d+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UhREGX2wI3szzm0LFg8s4AB0w9FGO2uopW18naJmLwxq6IKSVcVmS9XNrPhfxWjrKiq9gRAPzfaTomxTMnCuAByTlFshOVOLePtpBXQpLZQP7dj3hpXNobMivbndxUQp8RvVbYU+TC21d3W9lIzUcsIj+eMeeT1JOaVlxV7Zn6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=2a9Cpoc3; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720441775;
	bh=6/tJEdm3LbGFbJ6Qpev52Qt/ug+c8GBgOWAXsyW9d+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2a9Cpoc3Wb9KFno/rWDVftI+DUJbqAOYN12InSZgg3P+4krPzzpk6j58M+BhjwYss
	 B9uTGdSvdyR1CiYNqAHS2JsvEYuq41zgGYti04sIDmo1/q25dye3wTMo97iyJucoyl
	 9AL+SiE5mrFiHNgevZX19dnrgCYxEc1xAH8uloL4L4emO2G1yoVQ8GxzRvqlTMP2DC
	 ZWm2tU3gilnzJLGpBE3D1dCBf3h9xs55S9ssiMwTOY75gu8Q3woJv4V8KDD1PYgrqT
	 1N0TEPhW3J8ZrMHfDS7b97Zk2J5j28ywezJtSx0FFsiD0qTdiZ537IHGgcnzbH5hLU
	 rQXM1pvLMpngA==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B9766378042B;
	Mon,  8 Jul 2024 12:29:35 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 5907D1060623; Mon, 08 Jul 2024 14:29:35 +0200 (CEST)
Date: Mon, 8 Jul 2024 14:29:35 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Shreeya Patel <shreeya.patel@collabora.com>, Marek Vasut <marex@denx.de>, linux-iio@vger.kernel.org, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	kernel@collabora.com, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] iio: light: ltrf216a: Drop undocumented ltr,ltrf216a
 compatible string
Message-ID: <upabgip4nipc6jqb6ktei22prhhkteljrbd3jh6vzeihqp4wsp@zkbbpuaejrqx>
References: <20240705095047.90558-1-marex@denx.de>
 <3b2ca0-6687ce00-3-4dab7280@52083650>
 <98992b1d-c94a-4053-a755-32a25d7fdc46@kernel.org>
 <20240707143759.7718e0f3@jic23-huawei>
 <1effec8c-8228-482b-b476-06838128adfa@kernel.org>
 <20240707150835.40db1897@jic23-huawei>
 <9db672d4-a305-45ed-95f1-402c70a15379@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zr7qgdcztnxcpmso"
Content-Disposition: inline
In-Reply-To: <9db672d4-a305-45ed-95f1-402c70a15379@kernel.org>


--zr7qgdcztnxcpmso
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 08, 2024 at 01:25:10PM GMT, Krzysztof Kozlowski wrote:
> On 07/07/2024 16:08, Jonathan Cameron wrote:
> >>>>> We were very well aware that not documenting this was going
> >>>>> to generate a warning so   =20
> >>>>
> >>>> You *CANNOT* have undocumented compatibles.
> >>>
> >>> Why not? This corner case is a valid reason for that to be allowed.
> >>> You cannot use that compatible with DT bindings. Absolutely. The
> >>> compatible has other uses...
> >>
> >> Okay. With that approach what stops anyone from submitting DTS using
> >> that compatible (claiming there is a driver for that compatible)?
> >=20
> > That's a good point.  Perhaps we should just add a check for this?
> > Easy to add a check on the firmware type. This is a rare enough case th=
at
> > just doing it in the driver seems fine to me (rather than more general
> > infrastructure).
>=20
> Another point of slippery slope:
> 1. We accept such undocumented compatible in OF device id for ACPI
> (PRP0001).
> 2. Out-of-tree DTS uses it.
> 3. Whatever we decide to do now with that compatible, we have
> undocumented ABI exposed and used by users.
>=20
> That's the answer why we cannot have undocumented compatibles: because
> we do not want to have implicit ABI. We want explicit ABI, which is:
> 1. Clearly documented,
> 2. Reviewed/accepted explicitly.

Regarding implicit ABI, I would be much more worried about things
like this commit: 7b458a4c5d7302947556e12c83cfe4da769665d0 ("usb:
typec: Add typec_port_register_altmodes()"). It's not referenced
in the commit message, but IIRC Rob Herring ACK'd the approach
taken by Hans. I understand that it will become quite hard to get
things upstream when having to synchronize ACPI and DT first. But
it does mean vendors can (and actually did in this case) start
(ab)using the properties with DT making use of the implcit ABI.

Note that in case of Type-C there is now a proper upstream DT ABI. I
just wanted to point out that I totally understand the line of
thought Jonathan followed and demonstrate how one can have
undocumented properties (admittedly not a compatible in this case).

Greetings,

-- Sebastian

--zr7qgdcztnxcpmso
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmaL26cACgkQ2O7X88g7
+ppHXBAAqHPpYZ5LYzwaLP8y+HWnBfR6hElHxLvGnenRLMUQuvic57mHnmW9hlFA
9Xz7ncKO0ElceTHlQVkG8qp0G5IO2StnPIYLCdzrUA/8PUrZHtBkxZIUGbpsAoRz
NaoVLJAUPpBb5Ft5O0g87iabSN17oeJP8PFuMi7TXBqhxwiTpsEqXWPMavAzc+XG
foPfpfQiMCOMbcRqUvq0kczB31Asm+ecpOu7kMizXjhmtFHok0op3PgPdbMUUDBG
TQLms7dfUCt3F6/0KHHG+G30VY7Ykl15l9A3RIlHx5QOvzn1vW/D0exD1lypb+Vp
6oIzUaqnQlmpWgCFvGS129PuZzmsdmAlsSwGTDH0WiN+9SCELh/fbi7tL75dlvYo
Ktpwq7+arfNT+2+PUL0xsErU2pe8QoxCNeretCSSVa3kII4JCnECA+8DlaeZNr/i
7R2pK3JmjcfdW7pp3eSufMitdB5VNTEh9SMjRUifM1XolPCZrxv+pAjHvSH3MVrg
yywjLirYqh+y4pCylDRIOyj2KywuNl2hJ4uJnqTmx9JBsqnlGC+4eJRjCjH4FDDK
taDOQgZeY3U2LtnJU05CUMWJrau16CY23vuRuKu5WgQk1x3O4pHc4EYSTyTL9rNg
BeHdVLvYzLP24lPjMPKtf5zXhhdsABL/t0IbEiTMoV6WJuwslKU=
=e5g8
-----END PGP SIGNATURE-----

--zr7qgdcztnxcpmso--

