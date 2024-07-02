Return-Path: <linux-iio+bounces-7140-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD24F9241DB
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 17:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFAC31C20885
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 15:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F1E1BB695;
	Tue,  2 Jul 2024 15:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGzhkgzG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1FE1BA86B;
	Tue,  2 Jul 2024 15:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719932735; cv=none; b=JFJoIlADJeAZs8oi7wuyfx0gmMRQuoJRE8NSHgH2mBptK3qX/ah3/wEQVu91N5KLPuyRSH+ggyg3X9tA7KtmzB9NSeDzjHPPtenvOtf/B86i6LJajASe89BNTf0MCRN/LdNYQ1BjJp+Tt5znO7t/PAtQ2QZDJWc+6ttjeAvsw1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719932735; c=relaxed/simple;
	bh=vljTgaMnlA18Uh3V7Gov/YHLaLqJkTpDNli5OHuiyh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=feWToVVLB3z2zh2cDqwLo9a2pksLj0iF9l2y82ovePCUeGsZNxImLx0nhtCZ/clExitHUGdDuBhsAXumRUh0gkfXuQhpc3hj1Ya7SjPYdwX5IObfbBzS5TlV222TApt6yMY+OaXcZgjBsWMKV/5HMzsYFZxRT6R4+Xf0mwLppT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGzhkgzG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F47EC116B1;
	Tue,  2 Jul 2024 15:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719932734;
	bh=vljTgaMnlA18Uh3V7Gov/YHLaLqJkTpDNli5OHuiyh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VGzhkgzGTsx3MN6lYMWQytb4II5wNFl66tJ2Im6geQ9nD7WB1MLhCj5QAcAka42R3
	 LlyybUbaPAwDrd/ogcJGqLBO4X24f46/oeaZgl+FIoNMhJZNN7+O7D9UG5FtGnJ2mM
	 8Xt12DVY7+EkpYpBV7W+ebTp7TfXvr4gxQIYoh6SvaZGe+fR+1kn8PvLq85/E3ARq1
	 jmn49Ds5Kp/I1L4XL16PkmotV2sUiZuAG09xNwISD/YR24UyAgahBiJacRR2S9bEXw
	 t8+1t19AoLeBfqmZvw8BAVwONuxB9atnSkvqfwAKjpYtP95vXm+kaZ+uNRX8sLiJ8h
	 GG8xNdVStbvbA==
Date: Tue, 2 Jul 2024 16:05:29 +0100
From: Conor Dooley <conor@kernel.org>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Dimitri Fedrau <dima.fedrau@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Subject: Re: [PATCH v5 5/6] dt-bindings: iio: dac: Add adi,ltc2672.yaml
Message-ID: <20240702-genetics-paralysis-4745d9497f02@spud>
References: <20240702030025.57078-1-kimseer.paller@analog.com>
 <20240702030025.57078-6-kimseer.paller@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="utth3hHHG/1o6B0+"
Content-Disposition: inline
In-Reply-To: <20240702030025.57078-6-kimseer.paller@analog.com>


--utth3hHHG/1o6B0+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 02, 2024 at 11:00:24AM +0800, Kim Seer Paller wrote:
> Add documentation for ltc2672.
>=20
> Co-developed-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--utth3hHHG/1o6B0+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZoQXOQAKCRB4tDGHoIJi
0tJeAP40exkCe58c2IhJ+zY35TP2IXR+3kMVd3LmlOdb/9rWGQEAltEwpDK9DA3g
RB939lKa/RFL5HLYVoqPcouCedrWCgQ=
=uRal
-----END PGP SIGNATURE-----

--utth3hHHG/1o6B0+--

