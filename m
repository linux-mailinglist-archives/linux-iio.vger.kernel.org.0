Return-Path: <linux-iio+bounces-7014-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F47191C256
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jun 2024 17:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AE431F221AB
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jun 2024 15:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393E91C8FB9;
	Fri, 28 Jun 2024 15:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJf6Few/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8E01C232A;
	Fri, 28 Jun 2024 15:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719587718; cv=none; b=q5xUchnkSYO0LzlPAxbHJJTFWyNjMd421DDEuVktdg8g0or0Eq/aXKHQiShZxilmU0EJNZG46gbEWdQxPJ3Oylvq8p2NW6r+zWR0geTJFDJCtGLFp4cLa1HTjLxXRC3GtIIEBgrfsix1LAj96XapIl9BneLYVQE1dUl4UJAtEIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719587718; c=relaxed/simple;
	bh=bu0ftpyAijuweDhRTmvWJVpSDGx2EDgXAxaHL4ijmww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=buYhbFJZq3ROZfo8E6dTrt/JjcTmqxTzVhGcQNfQzt98TxAocMbbYOBXShnEkfJax/iFsGS3945nJumHzYDE11Ey014PKhYogh8vnQBuzdRyUDHjWGqbXTxV1CDOKsxOFmVe91YqSOGYQ8Z6Ml6wAzsQ66A1PVAiGGWmfrWjFik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sJf6Few/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0030C116B1;
	Fri, 28 Jun 2024 15:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719587717;
	bh=bu0ftpyAijuweDhRTmvWJVpSDGx2EDgXAxaHL4ijmww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sJf6Few/SMza311Oz8Dt5No3XiJ94XiQWAasODCybdXBiSeYvzAQlejnBa1Lato5U
	 wyG5175CnhPJqSxeIQ4zw+MjsyidmYSmnGjSefsTbqXU+jgjx80Wq99amKuWLsyb3y
	 sLqmVURhq4h1hUOVoA0w10ibFAEBciW1t5MIPGBYrBrNQI6DivjGg/VNHW1/ag6i3T
	 IYKSCrRPCE7moJNURIlvC/3aBPQtVxe7onVmb1SIQ3t1o9Lz8ziKQThZdD6KgQHLBT
	 5IsYpjJOsLaMI2D0zXH5RvL+lfV7LOjCIC8R2avOqMX6SHf2IH3JPrkurxMUYdVV2I
	 vGQQG9lKR8L+A==
Date: Fri, 28 Jun 2024 16:15:12 +0100
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
Subject: Re: [PATCH v2 07/10] dt-bindings: iio: adc: adi,ad7606: add
 conditions
Message-ID: <20240628-sworn-vegan-be51d695ba52@spud>
References: <20240628-cleanup-ad7606-v2-0-96e02f90256d@baylibre.com>
 <20240628-cleanup-ad7606-v2-7-96e02f90256d@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ob35nofspRrl+sWJ"
Content-Disposition: inline
In-Reply-To: <20240628-cleanup-ad7606-v2-7-96e02f90256d@baylibre.com>


--Ob35nofspRrl+sWJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 02:48:25PM +0000, Guillaume Stols wrote:
> Since the driver supports several parts that present differences in
> their layout and behaviour, it is necessary to describe the differences
> from one chip to another.
>=20
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--Ob35nofspRrl+sWJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZn7TgAAKCRB4tDGHoIJi
0hwmAQCgf6axhPpHJtKMRQ8eQghjEx/GYthNpPnlr84dT1Dx4gD+IkxcDULr6X7B
Sfpy2VDtjIBcy2tPFuuIcLbOx3/+CQ0=
=N0JU
-----END PGP SIGNATURE-----

--Ob35nofspRrl+sWJ--

