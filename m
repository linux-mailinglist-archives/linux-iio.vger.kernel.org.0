Return-Path: <linux-iio+bounces-9965-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F80198C373
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2024 18:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AD24B22EBC
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2024 16:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9F51CB33D;
	Tue,  1 Oct 2024 16:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXKCKTEB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C2D1C6889;
	Tue,  1 Oct 2024 16:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727800265; cv=none; b=DVizmRC6vJpC238UV9XSsScN/mVEC8xn4PATCXIna1Hg0R1h5LuTXhZp21wlhDmcALk4GRQCAQ1Eg27qZSXnfnCN+xgm9X8d2fQKbPahzNM5oGmf8eGEU86ukrbhJ/v7IYAKJqDHKIeCoXya3iIPAYjnoteRsGqHf22CUVhoha0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727800265; c=relaxed/simple;
	bh=QgVPcOM3o0Kq7RqDI/SUeOlNzo3Y7dfS0Do08vgt/1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RA+fRD5yWYwhJ4Orvp4nPbDj2oySfHH6495qPxJ9KFa2yOFwKJ8r8A/CAuOYiHjsTZnxexoEndJaFHgRdz3kBVeM4Hj3L/sjNpHJwK5SiraKys1IojfP8AoOLzOBIA2OyYmca8JV8jvy6hA8xG2uMfLrDab8CTF8MB3W4b/QuSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXKCKTEB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB187C4CEC6;
	Tue,  1 Oct 2024 16:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727800265;
	bh=QgVPcOM3o0Kq7RqDI/SUeOlNzo3Y7dfS0Do08vgt/1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kXKCKTEBXhOglnmN5ytvXFx0QTyC/OJxB58EnVOTKAj+z507UNE4AnH9gCUv123Hy
	 UNvAPJfMHLmVeArMxOLPT9LEtMkSzHLu8p0zLnRJp52Xh+PBDpIO2wx6oj/qHbWKaN
	 WDJbZQbv3QW6cpoHLDEGmBP4jThSS63yzkp9huU/sVhVkC0Ls+NAEqJf7uxX1u1IWJ
	 dOfme2xQxwr8uyBYPLorinPTcrxA1a0JP8R0CjzFeknEN+CodbAn76yYub34GrUC84
	 WwtU2l4XWXPKoff3IMVwS5+crPKYP217peULnQlO5fsrReqI7Gyl4bFE2xQeTLb4fS
	 GNUkKJuAE7F2A==
Date: Tue, 1 Oct 2024 17:31:00 +0100
From: Conor Dooley <conor@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Ian Ray <ian.ray@gehealthcare.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 1/4] dt-bindings: vendor-prefixes: Add an entry for GE
 HealthCare
Message-ID: <20241001-reusable-thermos-6263386b5ed5@spud>
References: <20241001074618.350785-1-herve.codina@bootlin.com>
 <20241001074618.350785-2-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fszP1xD3fpRamcxt"
Content-Disposition: inline
In-Reply-To: <20241001074618.350785-2-herve.codina@bootlin.com>


--fszP1xD3fpRamcxt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 01, 2024 at 09:46:15AM +0200, Herve Codina wrote:
> Add the "gehc" entry for GE HealthCare.
> https://www.gehealthcare.com
>=20
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--fszP1xD3fpRamcxt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvwjxAAKCRB4tDGHoIJi
0jCYAQDc2C4+W5UzhbZ7HUYeDVyeTymoZvA8IvBrS0e63Yt9+QEAuj2AOD7PBTm6
pcoPFYa/1KLXgk5ITRfuarWYT6uJCA0=
=KNww
-----END PGP SIGNATURE-----

--fszP1xD3fpRamcxt--

