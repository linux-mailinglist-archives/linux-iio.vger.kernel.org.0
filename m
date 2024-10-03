Return-Path: <linux-iio+bounces-10048-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAEB98F414
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 18:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFB2C1F23278
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 16:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54961ABED6;
	Thu,  3 Oct 2024 16:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pn7mgsri"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7E31AB6FA;
	Thu,  3 Oct 2024 16:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727972174; cv=none; b=AbFFfnyJuD3ZlbL5fArtWBnXLcpWMW1ahzx5NEHqrVOfbqb/cqsP0MOjzBzskUoJP8vjxYAMY0vAZaWQBwHYt/JoCFL2YYvJ24SoVNccu/eqyU3nBbmuveMs774ibWe8CRtapAytl/AtCcMpicCG4Bej+ZcviHnXU48YLgC68n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727972174; c=relaxed/simple;
	bh=gOc8IUVj3AiYcz7YG9NiN2oe6gotMo6t3a8ZTVcHaLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iNc56O24iqggaBxDlqPcIYrNQFquZLk2HG7s5M5dcZJgAIrzT9Z9e2Z+6ZpGPw7nqw+JcGIbeapJSyt3wKa7yGHO/PWYLzQ9ukQo8bLiEH5w7p8OFmpX6M8MoyQFKt0J8g5If4J/hpUR8J5JgphsxXR/SdCWRtI94yAySMZ3qFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pn7mgsri; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5609C4CECF;
	Thu,  3 Oct 2024 16:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727972174;
	bh=gOc8IUVj3AiYcz7YG9NiN2oe6gotMo6t3a8ZTVcHaLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pn7mgsriIruuXqXljWeABAFcSyIsV+crnNGeCywXQw6BgzHpve0v02BC205nmr9Ky
	 2BDUp56NcLSzYY3L1Err7ecjzi0Jny4jMSiPMjDQWBc4Xv412DkvscuRcveRe2rAwe
	 G8JhBpRq3E86P3Nada+eZdL6CJlBxcNgxghfhIE466/UR8t5CUb8bHNQDuF33dZsbi
	 oZW/sl7VS6bJlFX7xO9Tc8ZM0xb5N4oKhRfto4/5BjA+ddhMHSo0MSnFIN+D3NBm7k
	 2dP7zl6DcYFyg4ST3cBn5Rx6jOwgn0SVNWvGnY8ycwTvwYyisehjA6SaW/mUs/tCqf
	 gAcVF+zw3Er7g==
Date: Thu, 3 Oct 2024 17:16:09 +0100
From: Conor Dooley <conor@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Ian Ray <ian.ray@gehealthcare.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: iio: adc: Add the GE HealthCare PMC
 ADC
Message-ID: <20241003-decent-bronchial-bcc75464b57a@spud>
References: <20241003114641.672086-1-herve.codina@bootlin.com>
 <20241003114641.672086-3-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XDLIAj6ZAcj9yoe+"
Content-Disposition: inline
In-Reply-To: <20241003114641.672086-3-herve.codina@bootlin.com>


--XDLIAj6ZAcj9yoe+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 03, 2024 at 01:46:39PM +0200, Herve Codina wrote:
> The GE HealthCare PMC Analog to Digital Converter (ADC) is a 16-Channel
> (voltage and current), 16-Bit ADC with an I2C Interface.
>=20
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--XDLIAj6ZAcj9yoe+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZv7DSQAKCRB4tDGHoIJi
0k6BAQDP6eavZiI9hSsnpqn33+iNnVmVtvptBBtanS4K59HHlgEAqwvKf5LL/oJS
pO8gVA3YidpHYO8gCNq38qtR5kLA7Aw=
=DujG
-----END PGP SIGNATURE-----

--XDLIAj6ZAcj9yoe+--

