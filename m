Return-Path: <linux-iio+bounces-6510-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEFB890D6AB
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 17:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85E7D1F22632
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 15:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB121E895;
	Tue, 18 Jun 2024 15:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYUzmmSz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA574689;
	Tue, 18 Jun 2024 15:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718723421; cv=none; b=V6XdawWXPJ62x8SFdV2zcrB9armutBj+caQfDNoVRMquXj4B+923lltILiOqznu1jPACSMaSetQW2nc4X/RxMysAopgZgmNyaKXJ5uOwcHEc1YdBgjB5BzoPAdT3mfWIkIoxlHRztESngR2zngablC7rQDC1gR0DTurxaDSOhTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718723421; c=relaxed/simple;
	bh=lQqNRhwMATkQdkE2YrgiY4aa+9P+Rk0Zwz4NXkvk11g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9HVvhDS4aOqleGJ8PS/RYszofTpxL5F7TVKR/ZOIVDW0zEMgfkAunK+/6PJm7HxXNEYNwy80rKTnk44IfwsVLOwFR4TvXKp+HCbIvK08nkCF12B2duNWRcAyKCmjbx503dIoz79gvYqKTRZ6OUKn9Yf+kboYknz1e2v5eKrQPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYUzmmSz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DF71C4AF1C;
	Tue, 18 Jun 2024 15:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718723421;
	bh=lQqNRhwMATkQdkE2YrgiY4aa+9P+Rk0Zwz4NXkvk11g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gYUzmmSz0KYwkcZx4qdmojw/HqN0D93dfSe5hro10tgcKlOjmHXNWKFk3eohjB2IY
	 s3Ws/FiClAjdDSAWVzr/SSpZ5aO3TCbleDTTncXns6gn7WkNxbQO9fEThGy4IkTjK+
	 D4nzHPW4nn7GSzK2vedVhLQlpr+rHQoLudtUDAyIxmijmGoG8lE6kueoh3eykKHt0W
	 sLzq5jDR68VoplDH59Ifwj04dedMA8ptblZD8SAzDLNJdOSV33XpVZoKvfwmYhz/Af
	 FQQPEM/Cx4jQ9+xpEHqFuTeF5IWWrQVCA0p9395LtMOB9aQrxnoZPeJJggJoqBH3i8
	 VEihOtE0XdBwg==
Date: Tue, 18 Jun 2024 16:10:15 +0100
From: Conor Dooley <conor@kernel.org>
To: Guillaume Stols <gstols@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Beniamin Bia <beniamin.bia@analog.com>,
	Stefan Popa <stefan.popa@analog.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	jstephan@baylibre.com, dlechner@baylibre.com
Subject: Re: [PATCH 6/9] dt-bindings: iio: adc: adi,ad7606: fix example
Message-ID: <20240618-rack-synthetic-1d1747b34a6a@spud>
References: <20240618-cleanup-ad7606-v1-0-f1854d5c779d@baylibre.com>
 <20240618-cleanup-ad7606-v1-6-f1854d5c779d@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KqEybsG53Fsmklth"
Content-Disposition: inline
In-Reply-To: <20240618-cleanup-ad7606-v1-6-f1854d5c779d@baylibre.com>


--KqEybsG53Fsmklth
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 02:02:38PM +0000, Guillaume Stols wrote:
> Example uses adi,ad7606-8 as compatible, but adi,sw-mode is not
> available for it. So remove this property from example.
>=20
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--KqEybsG53Fsmklth
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnGjVwAKCRB4tDGHoIJi
0lqFAQCX4SX21H8XY7GASSWedZdYZZ5vWePW1cJzZc0jzxUzFgD6A2Tr1cr6CAmF
rhhfcZNmk3CFCIh0iGPJkw/3eSYyFAU=
=mtpE
-----END PGP SIGNATURE-----

--KqEybsG53Fsmklth--

