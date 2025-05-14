Return-Path: <linux-iio+bounces-19516-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07349AB7134
	for <lists+linux-iio@lfdr.de>; Wed, 14 May 2025 18:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF6834A2959
	for <lists+linux-iio@lfdr.de>; Wed, 14 May 2025 16:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5DD27AC3A;
	Wed, 14 May 2025 16:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EAsE+C/m"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558BA1B6CEF;
	Wed, 14 May 2025 16:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747239839; cv=none; b=NcYglxh5kUa0BD0odsD0QvM1MeWg18rmyIT/z0Yfifrn61gf4sPvPbIVnoNQd64MJjafL1CAJuBNBJlOcCUJA0ShPLdW7ybeb7ISXhAnFwaiW3kbwKqKTyM/CNzv7l6tpkxAUWwOzzVa06Jou9tN5YtMF49Keb6xL9+qIYjEnD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747239839; c=relaxed/simple;
	bh=lrLhJLoo2vbTqU+2eXNTtOuTu8Dnoq3oQi1OJchUu2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rZy1wNrr9ecerpRUsD0j4gOMkuSgrMAiA4+ER5JoDa+gIs6kapMEiDcqfyZG3zPiE/zRiYtpiS0D2uNhdHuWmdpfL3kLTGbN4OnxJdbn7O5LAy5hml3Jo810+Q0zK7ZbuJSMYjl/9BA6jtbBMoxtHtUPf18dOy7Pk2XB9BY0ylw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EAsE+C/m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0115C4CEE9;
	Wed, 14 May 2025 16:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747239838;
	bh=lrLhJLoo2vbTqU+2eXNTtOuTu8Dnoq3oQi1OJchUu2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EAsE+C/myC7TcmYfp5eVcVbUzequD8dGG+1+v1bui65JDj5F2IxLTukY0glmet1Mh
	 ijmodMEaDdLUKgT0Vpe4bKzdwtdgy/A2UpS0KssUMsJa+9/sb0rJV99IhypGM6gjQP
	 xl0BB+8p42Cwrg4TLlZ89WKr+LnwjK0nrpgPlJHlI8PkGmpB4rOZPAgNe54/vVuXqF
	 +yNBzWAmWeA1b8dZaq3UQ/r0dO5/bhxbGVIshZq1Nw68ICF67L5awnscCgcJWlFXOa
	 E3wWyFuDCy9W7uXYAAtDXJS9syhYMY2Y97tNJqemvARkYWjUHTQSvK3QckZKgNC2x2
	 3x1CI8s5s0PLw==
Date: Wed, 14 May 2025 17:23:54 +0100
From: Conor Dooley <conor@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: iio: adc: Add ROHM BD79100G
Message-ID: <20250514-elope-ultimate-0c44ed3be88b@spud>
References: <4907a096eee1f54afae834213cf721b551382d4e.1747203712.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hb+DHPO2trCPQpoC"
Content-Disposition: inline
In-Reply-To: <4907a096eee1f54afae834213cf721b551382d4e.1747203712.git.mazziesaccount@gmail.com>


--hb+DHPO2trCPQpoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 09:25:13AM +0300, Matti Vaittinen wrote:
> The ROHM BD79100G is a 12-bit ADC which can be read over SPI. Device has
> no MOSI pin. ADC results can be read from MISO by clocking in 16 bits.
> The 4 leading bits will be zero, last 12 containig the data.
>=20
> Device has only VCC supply pin, which acts also as a VFS, determining the
> voltage for full 12-bits. Specifying it is mandatory.
>=20
> This seems identical to the ti,ads7866.
>=20
> Support ROHM BU79100G using ti,ads7866 as a fallback.
>=20
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--hb+DHPO2trCPQpoC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaCTDmgAKCRB4tDGHoIJi
0uOYAQCKuYQfMWcQTIc9ajlwT+1A4gLc9JqW4h9bDgW5awfqYgEA3xIoRxpnGPMM
jckhRaYx/Z09P6R2VfMn38JBB8CQdAY=
=dwKe
-----END PGP SIGNATURE-----

--hb+DHPO2trCPQpoC--

