Return-Path: <linux-iio+bounces-27998-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C9FD3B5C8
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 19:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A15F3053FB0
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 18:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F72D36405A;
	Mon, 19 Jan 2026 18:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ic/BtdYJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209D1320CCD;
	Mon, 19 Jan 2026 18:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768847301; cv=none; b=DcCaL3UdVovpq2hDNWbFIg+pVWXmhwM+gQ8FfPebssLQLUDh5UiIxG24l3GbE+bIX3/FZ5sPLel6BtIgGcbv+E5CsHWvMBhVG30ivkvRSnQf+e7Q/z7gti/i6Z0KHZjbCi2WP//BZHcfatYCsei6bHyKodkY7sEnO6sKPnU+Cag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768847301; c=relaxed/simple;
	bh=LVhgTN9sl42SHBg9euBfTXv1XUArmYxne6RfG9Ow7LI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjrrazQ4xan5sbzioy0jrV1psTPLAMTIfcPWv+FuovyU6eacc8zIiHDB0zJb2IJ49kxeCRR4utAAk2l8yjJ5qX0z3Vx6xGfyvxRKgsE7mvGmdodkgjd1+YjAvn0PNPBEvDosuj4yNBFKWXOIzPShkX8pchfNSMrnlnYJOu7h8QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ic/BtdYJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47378C116C6;
	Mon, 19 Jan 2026 18:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768847300;
	bh=LVhgTN9sl42SHBg9euBfTXv1XUArmYxne6RfG9Ow7LI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ic/BtdYJm2tvYwa6HljAXQ9CwNsAP1WxaqBYl4yl6CTEpVk068GClGnkV+kQjsn1U
	 dxDc/QLdBBPv0Hg/vd01l8P6srnifBWvxgUq9aEhOQZdc/A826DSKWYBs/8XCtZ4Bd
	 Mk0UNlTd9ab43iJ6867CD5Iw1QSjmal2I2c+94jtMXfwMeZh8dvenqKlp6zlOB2zX4
	 EaOps0xFQ/oJ8E2mrHV2TsqcBncaJGtV3NvdRtyvbUbTSLXFIH1zCw2DM7L7paAXiX
	 2+E6wgwZzG4qIWiZctSO9TjP9n89hqADBkzv/HxAckWRVGn+Zkjltb9TmUQr+NM5Fu
	 rya2QrZkqZ9hQ==
Date: Mon, 19 Jan 2026 18:28:15 +0000
From: Conor Dooley <conor@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	David Jander <david@protonic.nl>
Subject: Re: [PATCH v1 1/8] dt-bindings: iio: dac: maxim,ds4424: add
 ds4402/ds4404
Message-ID: <20260119-surely-body-39fcb39f8c9d@spud>
References: <20260119182424.1660601-1-o.rempel@pengutronix.de>
 <20260119182424.1660601-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MHg01/COA5mRbyFj"
Content-Disposition: inline
In-Reply-To: <20260119182424.1660601-2-o.rempel@pengutronix.de>


--MHg01/COA5mRbyFj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 07:24:17PM +0100, Oleksij Rempel wrote:
> Add compatible strings for Maxim DS4402 and DS4404 current DACs.
> These devices are 5-bit variants of the DS4422/DS4424 family.
>=20
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--MHg01/COA5mRbyFj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaW53vwAKCRB4tDGHoIJi
0iwEAQDtHDuVdrJ0qNRz7YJEIsxDBGsPlFRWPNeEEM/hqOq31QD/YbxiY1JKv0ll
w+dtLduG0FXrVJY6SgZfqld0DYB6+Qo=
=qI4Q
-----END PGP SIGNATURE-----

--MHg01/COA5mRbyFj--

