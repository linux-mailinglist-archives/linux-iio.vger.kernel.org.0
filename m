Return-Path: <linux-iio+bounces-18846-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E317AA0FC2
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 16:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB3CE189C978
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 14:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3807021A94D;
	Tue, 29 Apr 2025 14:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PK41a2TV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A0A1DE4F3;
	Tue, 29 Apr 2025 14:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745938616; cv=none; b=rCQ3gDltrl8c5T9xtuRWG+RwFA9d9Q9pXmV7qh/0Ho1nBt8ocQTNGgu8Wmu3q9mO9OO6tRlR562Z6e5r+W/Mmxswha6mPYpdfuwGZ1EmWNlM/qsD18VJJXHOYsNA1DbuFcid/uE5G7tNkF6dDkis9kN177S4bHPsQpM3RTurDDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745938616; c=relaxed/simple;
	bh=TrUU+M1F4SQVXD7iadCxRa4FaQ+mnKlBzxagUQ1A3Yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TPd+6kETB5wKwksf1UCF6ZfGy19b7RC5aGiDTC2HyBEFqTxUIiod9zlChVYNarx7uGeFW811gv+ZmancHCx1Z56nnILNLX3HHdt6vYbkBV0sdTb+FHQCbdccr6MTK555+XZUBJttxP7BDowAwTKCz1zNjLoAWEAwAR5LbQ7rSaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PK41a2TV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E605CC4CEE3;
	Tue, 29 Apr 2025 14:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745938614;
	bh=TrUU+M1F4SQVXD7iadCxRa4FaQ+mnKlBzxagUQ1A3Yo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PK41a2TVkkURAhJcJlYrBHdcjcLNua9tmjhOd9oe0wEb7v3lCEWM3PwhQQFcfZTt2
	 lbpIEIiaDTP9zUTOOXJGhJxjWYxar0k8WJfr2re/cH53Bu8pK9cC0dIOkgu+d14liD
	 XPIkkjbKRPdYICmyZRjsV8XrHCrmhbzmJpXYH/BlhNYACHMHWP5JB9gEOoJiaI/C+f
	 58fjYrI6FWSLU+pe8d93wnEsWRuwBov+DPYcNR7Z+TfI8SEABTrdNhGzxd7BIcOrVI
	 HGhsAsgNdnDu7/98LUEOMmrE7E3H/4J3Fnpxqq/lIkOA/paoSv67P4aUJ7V3xmL/VE
	 sNgBcYgSSnPRQ==
Date: Tue, 29 Apr 2025 15:56:49 +0100
From: Conor Dooley <conor@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 4/5] dt-bindings: iio: adc: adi,ad7606: add gain
 calibration support
Message-ID: <20250429-irritably-cacti-b7287dbdc3d8@spud>
References: <20250429-wip-bl-ad7606-calibration-v1-0-eb4d4821b172@baylibre.com>
 <20250429-wip-bl-ad7606-calibration-v1-4-eb4d4821b172@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="u3SN/e233iO0AJsN"
Content-Disposition: inline
In-Reply-To: <20250429-wip-bl-ad7606-calibration-v1-4-eb4d4821b172@baylibre.com>


--u3SN/e233iO0AJsN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 03:06:48PM +0200, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
>=20
> Add gain calibration support by a per-channel resistor value.
>=20
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--u3SN/e233iO0AJsN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaBDosQAKCRB4tDGHoIJi
0n7VAP9zBmDK1EdgInc5dNcBH+0CC1vKZpP5v6NG2zoBXcWc/wD/RCJONyK9ylp2
dH/IUzZo0vEQoP1ZpeYMXVOf8XU16Qs=
=V640
-----END PGP SIGNATURE-----

--u3SN/e233iO0AJsN--

