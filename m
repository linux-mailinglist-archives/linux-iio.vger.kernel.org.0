Return-Path: <linux-iio+bounces-4956-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E82CF8C3173
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2024 15:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2AD52821B5
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2024 13:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E215028F;
	Sat, 11 May 2024 13:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ge1Rk6gx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450EA50275;
	Sat, 11 May 2024 13:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715432445; cv=none; b=hqH4FIS73QnZH0Z5313/TbGfdyrE7lquH2fF5XA2jV1SR08pjKFcDbPIjchlJgv8Dof+kU8p6au2YaBQ+uDEcXwAtvz+Z2wVZ6PwTZZFpIxD4DDzoREcKAgLH8AnzzyAG1OUxziVNbGWV7Rod18g/nb1UJQNPqcH4oWoRa6cAgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715432445; c=relaxed/simple;
	bh=zAazAJjTUB4nJ8VTdDibP5JqXkNudqdZe1Z87mZ41dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bGUSPwfw6W1hNrBpKlEBjyCIkiQI5Yq5lgL4QqnUk6AA/q/x5arWsqwgRmzFQAHPz7gR2pWLEnc2JCx5dOaHxKdoZPJ9jkgMM7L/SZAFMVl+h7qGHHIfuHJ8if3GA+CiM1f954sHu1eLzxtQX+q5h7N2t1eKpv75vn4cNHNXDhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ge1Rk6gx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2365C2BBFC;
	Sat, 11 May 2024 13:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715432444;
	bh=zAazAJjTUB4nJ8VTdDibP5JqXkNudqdZe1Z87mZ41dc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ge1Rk6gxYgyMuhybscP7lqf5ukMVRH4v0xTDy+cAel6X++5XOAVdXOFX4jojqvBU3
	 AHt7DguVJ15+O7RY1pdC993CZSz7+kCJPxYDqwjo8vrxUufXD3a/gIApW95UWdspao
	 FaarQQKQ0waILGk1WcWOV5UexiSqxe1JqAVTqoNJtjDplOrvHY8ZG/pT/x41V+Iups
	 XSjp2Wd/D67V95neRAz3XSy8aaUr0LvtMplp2hxOATIExrC1El3qSJ0LXvD2CGJa2V
	 6qb7piOf0yptflYE61JsQ4IdLu+EIvh0ppCzl5WVx1++HSHKJwbBuJ1hneSnTYImak
	 +URxUyjgnldvw==
Date: Sat, 11 May 2024 14:00:40 +0100
From: Conor Dooley <conor@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: adc: adi,axi-adc: tweak example node
 name
Message-ID: <20240511-overeater-prodigy-7f41e66762ac@spud>
References: <20240510-b4-iio-axi-adc-dt-binding-tweak-v1-1-a1f633c4602c@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="K5DPPS7jZq//yKtM"
Content-Disposition: inline
In-Reply-To: <20240510-b4-iio-axi-adc-dt-binding-tweak-v1-1-a1f633c4602c@baylibre.com>


--K5DPPS7jZq//yKtM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 04:04:38PM -0500, David Lechner wrote:
> It is always recommended to use generic node names for devicetree nodes.
> The documentation [1] of the AXI ADC IP core says "The most important
> part of the core is the Receiver PHY module.", so using phy as the node
> name seems appropriate.
>=20
> [1]: https://wiki.analog.com/resources/fpga/docs/axi_adc_ip
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--K5DPPS7jZq//yKtM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZj9r+AAKCRB4tDGHoIJi
0tu4AP4mOt0IB8mX1CV52TlA22Otdc3QKwbIiJUCeguPFCRQHQEA434eC9bWN9p7
0z5Eur/l+U7NFnSRm0hqZB239kmVjQY=
=flVT
-----END PGP SIGNATURE-----

--K5DPPS7jZq//yKtM--

