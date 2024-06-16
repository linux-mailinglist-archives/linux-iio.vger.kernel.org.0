Return-Path: <linux-iio+bounces-6326-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA37909CBD
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jun 2024 11:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8B3C282075
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jun 2024 09:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F62180A82;
	Sun, 16 Jun 2024 09:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmDVbM2/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72C42F26;
	Sun, 16 Jun 2024 09:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718529326; cv=none; b=ftNLOFrNIUjFLYlObgLGDcxwKfOvfD/pxE7uGFFum33DPWX1fEiXJeTE4Gz4Obb4UNMaCucEsoHvASB5PCIJoEv6+jvMKSs1i8dLpainr0uJpoRsABrQEwLbrBAHDsqVn1IeC3J19hLGQr5xQ90KJc5+mL5KLeKSXXUjs8Vuhls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718529326; c=relaxed/simple;
	bh=WvT8AL7ujpwhivuCOGlshD+4ce411ESNtRwhA6FOzgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/QbXNdFrvZr8wcLyg3dKfhX1Ci4T/B42CPtoGhz5dZdMEWQ9raqU7CI5Cx0PQ4DIa5UoBVUvqGLM1s4e5pNxKoFdnLqSXrdWDTAONRI3nw+lSpAyja5SBfJq3ITMVSDQbIwLWiZ/PDLm++znUPS6jEY7KMP+V3XZYii5dsEm+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmDVbM2/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390A6C2BBFC;
	Sun, 16 Jun 2024 09:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718529325;
	bh=WvT8AL7ujpwhivuCOGlshD+4ce411ESNtRwhA6FOzgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jmDVbM2/KozQ/Zk5lFxe4n8vrUOGbecOSjtR3OJExH3TUlJZ6jl2ceFVm/H5KQB/0
	 4itGbxxu0TLizxebw23LTiTcCxoTdaSyM+GT43HmnSmu68XkPX/O3Ruvpx1xXjo9c2
	 eIlYsCoK7TubgIWOA92yRR8lAGTRdTCYeHEiZKMIxxbsCePYDFlGl/hfOf0nBc+GIn
	 yF3Nu8WSNvMMaZgV5NXlEKqEIUL8mhkWmmvdLpVKTnd1KVrDv5dmLzadztKn+lj4rE
	 7T2MF55Q7mdH0n6egUzafTYMV1y2/omtKIHqSzyUeM0IPO7GwR/pNFN4APNb36goLb
	 OE+A7QskTqJJQ==
Date: Sun, 16 Jun 2024 18:15:21 +0900
From: William Breathitt Gray <wbg@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Judith Mendez <jm@ti.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: ti-eqep: enable clock at probe
Message-ID: <Zm6tKQ8KvIh9nnPW@ishi>
References: <20240609-ti-eqep-enable-clock-v1-1-1e9e7626467e@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pytb5KM2k0ruc4R7"
Content-Disposition: inline
In-Reply-To: <20240609-ti-eqep-enable-clock-v1-1-1e9e7626467e@baylibre.com>


--pytb5KM2k0ruc4R7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 09, 2024 at 03:27:11PM -0500, David Lechner wrote:
> The TI eQEP clock is both a functional and interface clock. Since it is
> required for the device to function, we should be enabling it at probe.
>=20
> Up to now, we've just been lucky that the clock was enabled by something
> else on the system already.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>

It sounds like a potential bug is being fixed here. Should this have a
Fixes tag so we can get this merged in the stable trees too?

William Breathitt Gray

--pytb5KM2k0ruc4R7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZm6tKQAKCRC1SFbKvhIj
KybFAQCODh6NyeeVMOk1UWQoPI4W8t2/Wcy8LwlD+HmEzpMeHAEA0cyH/0FEP9Xu
YUh9sl4ztGHXbN6gprpeihI9UvDHfAA=
=tFKc
-----END PGP SIGNATURE-----

--pytb5KM2k0ruc4R7--

