Return-Path: <linux-iio+bounces-10852-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F1F9A6799
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 14:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83AE3283D4A
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 12:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCAE1EBA1B;
	Mon, 21 Oct 2024 12:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HKCIKkCt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3F71EABB1;
	Mon, 21 Oct 2024 12:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729512484; cv=none; b=pDgGDd57fX+hh7VmqFtUGKrnG/35IrEEwtviV3flBw1qZq9pNaP5H/AYQmtsRNEbwxl3/xE8/Y8uDpNvTZm+/4mU+mvNuuP406HoYZvVPqaPQ2t+PHjcJmDUlAFf+ePHOHqoUU2NtfQtvmgqfIILjSgX8GWJJUoHoY+uFdMVcKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729512484; c=relaxed/simple;
	bh=IG9XDXEq+BLfchmvTYcHZHyseUpd2sq/XSmsM6ziurs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dG5pz1cZ9UMVl2UVyXjOhl93U0iL3a5FK7Ovv3ue6lRNLgkt9poke8geTEAbd8HcK7ZbI8V8JK+wNHkM+5+O/Guxa5DUZWH2j4PIAME+Ph7IL7PJf1pucra9KDURBmmsymvn+vrWf91mwnDmURuwXfJfJNPZArf4bcRW6ximm1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HKCIKkCt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A9B5C4CEC3;
	Mon, 21 Oct 2024 12:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729512483;
	bh=IG9XDXEq+BLfchmvTYcHZHyseUpd2sq/XSmsM6ziurs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HKCIKkCtOnttc8iy62OKInHm6/+gTzQulfFw1e7TZBQCZRTV2Ht5whxS44PYWdB82
	 XiCOxHg1BKuVkuOv0jyW21Bre7UXm8qlfJh/o956sFapSNFgEK6kDGZ1VBuD8rF95b
	 ek5VJWc+UbN4Py1IZ4pmdATgQegMAuVIUOQN/5hBr+sSjdkfbZdPbHAk97E1xzYVRT
	 abaEbZe5JtH/rukigwEeUomqIlfewU+q7D42uTT5KefNMZ4xDCd3nUsTMN9jU/HOW1
	 iIS7QHg2jxjjFf7haQgDugGAfHj2G8CW58PzrUMH+KwZOw5skZZUpXHoVVnMmUMZXj
	 iwazIMxD7j9Ig==
Date: Mon, 21 Oct 2024 13:07:58 +0100
From: Conor Dooley <conor@kernel.org>
To: Julien Stephan <jstephan@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: iio: adc: ad7380: fix ad7380-4
 reference supply
Message-ID: <20241021-opium-wannabe-28e314e7cd8d@spud>
References: <20241021-ad7380-fix-supplies-v2-0-2ca551b3352a@baylibre.com>
 <20241021-ad7380-fix-supplies-v2-1-2ca551b3352a@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3CQy50hiodQh6fxs"
Content-Disposition: inline
In-Reply-To: <20241021-ad7380-fix-supplies-v2-1-2ca551b3352a@baylibre.com>


--3CQy50hiodQh6fxs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 12:00:09PM +0200, Julien Stephan wrote:
> ad7380-4 is the only device from ad738x family that doesn't have an
> internal reference. Moreover its external reference is called REFIN in
> the datasheet while all other use REFIO as an optional external
> reference. If refio-supply is omitted the internal reference is
> used.
>=20
> Fix the binding by adding refin-supply and makes it required for
> ad7380-4 only.
>=20
> Fixes: 1a291cc8ee17 ("dt-bindings: iio: adc: ad7380: add support for ad73=
8x-4 4 channels variants")
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--3CQy50hiodQh6fxs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZxZEHgAKCRB4tDGHoIJi
0tIfAQCQZDqmd/HZBsyPscpNXfoYg9pdSBN8BomB/P3G6ypm7AEA1XvE1WBzyI/C
PqfpRwu6kuPdCnST3NwocwOrBIQOEQ0=
=Y5UJ
-----END PGP SIGNATURE-----

--3CQy50hiodQh6fxs--

