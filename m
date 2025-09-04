Return-Path: <linux-iio+bounces-23724-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CDFB44651
	for <lists+linux-iio@lfdr.de>; Thu,  4 Sep 2025 21:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACC8C1CC3A9C
	for <lists+linux-iio@lfdr.de>; Thu,  4 Sep 2025 19:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153352727E3;
	Thu,  4 Sep 2025 19:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gp3+Ln+h"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B687915DBC1;
	Thu,  4 Sep 2025 19:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757013850; cv=none; b=cluZMhdtDCGUw+hW7+XLp2+C3TejE+revnsiMZ1TGNtZofL1ATvA2MrTPyauzdaOMAZskxquz1eBWp4Pqu06ui9OhF1RqEc2r0dS3liivje2Q2jZXKZV5fdBEilm71PeNGYW5Z1O1HneTJikByp1xw1VJX0Y63jefACNTzUbnp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757013850; c=relaxed/simple;
	bh=DcZBwbvCs/APcDLJmkpflaT6uT/JUTX4N2f8nqi57sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RkIYsHGyWGqDauWJwQdeBy1szEu7C1HooWifexcYJc4UtqcFXNAJY4OP9YkczUHkLA7IZg5NF6j6NAUCsQaNKb6AmXTVMWiXPEYj9QIyx9WuNur5w/wQ9Z/2VicyA0aleF+Z9ohXMXZvjmU/qMcmIvzG/v9tcuiXWmLQpyvPOTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gp3+Ln+h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7D14C4CEF0;
	Thu,  4 Sep 2025 19:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757013850;
	bh=DcZBwbvCs/APcDLJmkpflaT6uT/JUTX4N2f8nqi57sg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gp3+Ln+hhB1+8+lkFXXSillDiYum+dAPdUfELaZ7FRDiOTzBpVrgbAwIhJ+3hXR1s
	 dOn4PqmUueHjXKJUs635qGZN7SZRDdWsMXwiPlPWkYDXvLnR8QGou6xrYNB97GTIXE
	 PbOMK2KV0EMEuszui0Rr+3gdzdcyUC3XFFgRw1qNt7Jarycl+lPLEq7BWZZWAuS7pO
	 SpxTYO34dGmrwlyYX+yQTNkv3IentC7g/DdNwluX0DVdFU7WWzab0K57zoWo9IXl+E
	 OVGDEjjhcfpPp6NAjNrqHvOxoSDwRDe09WSFwDba3EIevvWIpnxJAEsbyA48Y61ecz
	 kz8xv94usKF6A==
Date: Thu, 4 Sep 2025 20:24:02 +0100
From: Conor Dooley <conor@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Tobias Sperling <tobias.sperling@softing.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Esteban Blanc <eblanc@baylibre.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	Eason Yang <j2anfernee@gmail.com>,
	Pop Ioan Daniel <pop.ioan-daniel@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: adc: ROHM BD79112 ADC/GPIO
Message-ID: <20250904-suffering-napping-cfb886addf1e@spud>
References: <cover.1756988028.git.mazziesaccount@gmail.com>
 <af7292dea5cebe97553af67a8897e092bef3ec56.1756988028.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TYMVqA+xISrwz0kg"
Content-Disposition: inline
In-Reply-To: <af7292dea5cebe97553af67a8897e092bef3ec56.1756988028.git.mazziesaccount@gmail.com>


--TYMVqA+xISrwz0kg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 04, 2025 at 03:36:30PM +0300, Matti Vaittinen wrote:
> The ROHM BD79112 is an ADC/GPIO with 32 channels. The channel inputs can
> be used as ADC or GPIO. Using the GPIOs as IRQ sources isn't supported.
>=20
> The ADC is 12-bit, supporting input voltages up to 5.7V, and separate I/O
> voltage supply. Maximum SPI clock rate is 20 MHz (10 MHz with
> daisy-chain configuration) and maximum sampling rate is 1MSPS.
>=20
> Add a device tree binding document for the ROHM BD79112.
>=20
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--TYMVqA+xISrwz0kg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaLnnUgAKCRB4tDGHoIJi
0hpgAQDEQSDG09i4H4ASWiQgAGYg6VSHoZz4ZF4QmHuzBaKuagD/ScVzBQXl5SZQ
ctKeXmDU5aEZNzQzIDFHLgQG0q0O6w4=
=YMPt
-----END PGP SIGNATURE-----

--TYMVqA+xISrwz0kg--

