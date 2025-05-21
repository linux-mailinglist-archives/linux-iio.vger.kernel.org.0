Return-Path: <linux-iio+bounces-19779-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF441ABFAAA
	for <lists+linux-iio@lfdr.de>; Wed, 21 May 2025 18:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 697B11889CC0
	for <lists+linux-iio@lfdr.de>; Wed, 21 May 2025 15:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC10221F1E;
	Wed, 21 May 2025 15:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l32UhK7f"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F478221F1C;
	Wed, 21 May 2025 15:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747842623; cv=none; b=H4CZdfGoD6Z5OO0eVfKlZLC7c3V9IxEjYKIQtEhSJdx465UgNB5GKRJUHm8GTg8PZME3phrmwCdeLrHeAvhrv8ItzbrnLM4mWGK0WcldnSh2NQ5/pILj8qGN+Af+I+ZADpEB87xq5QMdMIoPraHgaMNjT/AizbuJSRJxT/rxntw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747842623; c=relaxed/simple;
	bh=nhhhjr3ZsIPlHboQ0WAI79csQhBTmrt+G+gEWWUy9AM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A4wd/iDDi5YH/bfxTulrX7WB4B8RbqLsAmC+3uB7UQYcQQGxYrbl3wuQG96ALK8uMPcAlkNuswwSK/UoFU/wxOTWqShgclcNynwuQyhqb7j8ntP3j0pjMXrihjN11/RB+7/9jCT494qxI0thhBlVuOIfCC4J1SosBVpIEZFof5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l32UhK7f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A30C4CEE4;
	Wed, 21 May 2025 15:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747842622;
	bh=nhhhjr3ZsIPlHboQ0WAI79csQhBTmrt+G+gEWWUy9AM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l32UhK7fB3bt4qTi87Y9k9ADVMu1chT7/U3WUgudrGPmm++LMMIn9JYghsMRHgsxT
	 aIuRB+IdUlZzbRC8nYvx3KxEDCH1zYFfNnipqxQshMIpdAQPGLX2HgkFTUpDOKPREY
	 VN2lWQ1Mdr8PBt1xDeWSMiuLO/g1IXcW+Wey3ATrExTmccfqAUXTJz8b8oHlx15+ey
	 zpzo6WvmCiO0OLkUiTvg3XpYwgKpZlmd+4e79cwsn9eClOn2hI4JNAM3cBMOxqPXj+
	 2qTwwKM3DVYZriMwr2UME9WPMvG/3FXN9Zg3wYUVecOOFL/Q9nJR73gvVU8FeerbLj
	 CsUSKn1fa1TVA==
Date: Wed, 21 May 2025 16:50:18 +0100
From: Conor Dooley <conor@kernel.org>
To: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, jic23@kernel.org,
	krzk+dt@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, robh@kernel.org,
	~lkcamp/patches@lists.sr.ht
Subject: Re: [PATCH v2] dt-bindings:iio:adc:st,spear600-adc: txt to yaml
 format conversion.
Message-ID: <20250521-grew-rotting-7081d2939477@spud>
References: <20250506-equivocal-snooper-8a7d1ce931c8@spud>
 <20250520204720.11448-1-rodrigo.gobbi.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+INKktWV1RqG/D4m"
Content-Disposition: inline
In-Reply-To: <20250520204720.11448-1-rodrigo.gobbi.7@gmail.com>


--+INKktWV1RqG/D4m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 05:43:45PM -0300, Rodrigo Gobbi wrote:
> > Sounds like it's a 4-bit register where the samples is (1 + written val=
ue),
> > and the property is expected to be written directly to the register.
> > I'd then expect the property to be min 0, default 0, max 127. If you
> > write 128 to the register, you'll accidentally set the external vref
> > bit. I'd maybe go as far as &ing the value to make sure out of range
> > stuff is not permitted?
>=20
> Well, it looks like 4bit as you said (bits 5,6,7 and 8) and 9th bit is vr=
ef.
> But, in this case, it looks to me that we can only configure 0x15 as a ma=
x value,
> (didn`t see that before) which doesn`t fit the datasheet sentence that I`=
ve mentioned before:
>=20
> "Programmable averaging of results from 1 (No averaging) up to 128"
>=20
> I mean, I`m not sure how many samples are configured when using
> SPEAR_ADC_STATUS_AVG_SAMPLE(0xD) since we don`t have a register map descr=
ibing
> how it encodes that internally. Maybe we can change the requirements for =
this field to be
> min 0, default 0, max 15?

I think so, since that matches the behaviour that's been there in the
driver since the property was introduced.

--+INKktWV1RqG/D4m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaC32OgAKCRB4tDGHoIJi
0pMwAQCDZihQlhX5Bi8Mg+rqgAd6gPrq3eDco7Kd2Lhz0Kr3RQD+NWNDjNsRH6au
nI8rDj4s3sx4QI7SadpcRWJL/jvOSwQ=
=VqKC
-----END PGP SIGNATURE-----

--+INKktWV1RqG/D4m--

