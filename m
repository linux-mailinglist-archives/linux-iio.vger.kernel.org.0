Return-Path: <linux-iio+bounces-19196-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0474AAC492
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 14:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 718AC3B853F
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 12:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F14727FD51;
	Tue,  6 May 2025 12:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rb6blaLy"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F369127FB28;
	Tue,  6 May 2025 12:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746535834; cv=none; b=PplO1Ek3xy103tpojGIltBetHarShVhU4QwuPIZoP78UZdLRxemz9r84+CQaNkzmrRKe7sYuDX8ECwMyA3/plg4Rg8pmL7HdCYngeq77HnKRZMs/U7HaLu3bi+ykV8iC0RyHI9nKqhbGXNGt2S++wJssXAWbGe52R1JzuQ/qED4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746535834; c=relaxed/simple;
	bh=klELssfHMqhzXeMIBTEtaCupN5OldzmXTuU8N+vlokA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nmcV2izVOThWX7m489NWaM+dXrFSSJPdt99QCShQBu/zn/MegXkSiXqv22TjJLcFl8oBrzOmli6Jee7Mf3eQni++QRqXD4srWzdVHcPsDsFOdihW4OnEkFcBMkEUiINMQ3pdE553OrpPWTAfN0Gu1GhTTjAhD3aCeLKKeUgx5VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rb6blaLy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91341C4CEE4;
	Tue,  6 May 2025 12:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746535833;
	bh=klELssfHMqhzXeMIBTEtaCupN5OldzmXTuU8N+vlokA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rb6blaLycFzVYBCF/30YSHdP29z99IGwzZRTl3lGE2FeaIygaWzVyhBnYwrJMTeGA
	 vrUqBzraYZv1nuzzN6n1rZHvacOwNcetanECvyg/aMJeOxGqb9sbca35vCoKDAFdj0
	 5ytwyg4OuN782Y4TkpcYDcnWeimFtPnrBryYxIJg/A2HoA7RV+RMRabSO1cFl7+DE2
	 vNb7Y6QHLYd0iayY4fr8cOISRne7fl1SStlCUeeD//HFBytpnPWfdngc6UTTyte6mY
	 pGovq5Gdq1Ckv28CM1252UzHFT1uE1Qxc8HwM60DQ14ghlWb8LQt90NpSnHAXCaXN8
	 Vi57M7qPpwh4g==
Date: Tue, 6 May 2025 13:50:29 +0100
From: Conor Dooley <conor@kernel.org>
To: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, jic23@kernel.org,
	krzk+dt@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, robh@kernel.org,
	~lkcamp/patches@lists.sr.ht
Subject: Re: [PATCH v2] dt-bindings:iio:adc:st,spear600-adc: txt to yaml
 format conversion.
Message-ID: <20250506-equivocal-snooper-8a7d1ce931c8@spud>
References: <20250430-folic-skittle-06b0ccbedf35@spud>
 <20250503184800.27026-1-rodrigo.gobbi.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="U2GjYv40w+G35gJJ"
Content-Disposition: inline
In-Reply-To: <20250503184800.27026-1-rodrigo.gobbi.7@gmail.com>


--U2GjYv40w+G35gJJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 03, 2025 at 03:44:12PM -0300, Rodrigo Gobbi wrote:
> > Is 0 the default here or 1? "Single data conversion" sounds more like 1
> > sample than 0, and the default of 0 is below the minimum of 1. What's
> > going on there?
>=20
> Good point, after I`ve submitted the patch I was double checking it and n=
oticed=20
> that too. It`s stange because the public datasheet mentions "Programmable=
 averaging of results=20
> from 1 (No averaging) up to 128". Meanwhile, the spear_adc.c driver at pr=
obe
> stated the following:
>=20
> 	/*
> 	 * Optional avg_samples defaults to 0, resulting in single data
> 	 * conversion
> 	 */
> 	device_property_read_u32(dev, "average-samples", &st->avg_samples);
>=20
> Since avg_samples is inside=20
>=20
> 	struct spear_adc_state *st;
>=20
> which is allocated with devm_iio_device_alloc() (which uses the kzalloc/z=
ero filling the priv data):
>=20
> 	indio_dev =3D devm_iio_device_alloc(dev, sizeof(struct spear_adc_state));
> 	if (!indio_dev)
> 		return dev_err_probe(dev, -ENOMEM,
> 				     "failed allocating iio device\n");
>=20
> 	st =3D iio_priv(indio_dev);
>=20
> ...matches the driver comment meaning the default is actually "0", single=
 data, but it does
> not match the public datasheet in my understanding. Since I don`t have ac=
cess to a more
> detailed datasheet, I chose to describe "1" as a minimum value, but I agr=
ee it is weird.
> Maybe we could drop the minimum constraint in this case (go with default =
and max)?
> Tks and regards.

Sounds like it's a 4-bit register where the samples is (1 + written value),
and the property is expected to be written directly to the register.
I'd then expect the property to be min 0, default 0, max 127. If you
write 128 to the register, you'll accidentally set the external vref
bit. I'd maybe go as far as &ing the value to make sure out of range
stuff is not permitted?

--U2GjYv40w+G35gJJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaBoFlQAKCRB4tDGHoIJi
0kd8AQCy8PjvqyHrPoVvPOGXVeNR0WKFsj6fOykHa/GbTO7CAwEAlJgBSIudVJpe
lhGSfvBdDeVsg2bwK7ZQaiotXNm5ag8=
=28u9
-----END PGP SIGNATURE-----

--U2GjYv40w+G35gJJ--

