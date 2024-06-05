Return-Path: <linux-iio+bounces-5832-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 666468FCE7C
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 15:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86E091C22445
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 13:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826091BE22B;
	Wed,  5 Jun 2024 12:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RejSWuMT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AE719AD92;
	Wed,  5 Jun 2024 12:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717590281; cv=none; b=ZyOW6BORxqRCbJircAjMMMD+ZM/fv7MU3Xh2Qr8L9POsa34kDSMCpS7G58pBzHOFe7/uHeljpkbUDtNqdEl/D46hUjI26IxSiz+fYYdnOdzwMBslgWT2kgq4CbzreBQ1CPJZZEqXZx6ZG0aukLLmR/EiP+QaOpbwtNIsEqAY/VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717590281; c=relaxed/simple;
	bh=nGTFRil33Cf7booPAwWDBm5uj0Ablwum3J22FiGthRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cykCUg1FSQ0Aan+XsZEVNnWCf5v+3hD6lj6clslxSGKpdKScfo1J6tkM+d4Rm7vbGrnTmlBXh7npXU2+60JtiNQw/2MHFNo3Bi4kvEXm4P0WjmbxGbZvYusxxZVTWdf05LkEEpk0JLNkFVng4Xjddzz09khsmlvrJUcjx7VxOmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RejSWuMT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED176C3277B;
	Wed,  5 Jun 2024 12:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717590281;
	bh=nGTFRil33Cf7booPAwWDBm5uj0Ablwum3J22FiGthRM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RejSWuMT9WnUO7WLChIm6whFz9uS1iD1LLLju+n/vwAuvlzEmMtHcYhIgSCFRV0Ra
	 ccBNdi0Yg7hoI9t+55l/W2CUe5DEEDPhYP0MABEfcSxHFnT4wG0ecAU1QG+zNWYlrL
	 qznLhW3Azkp4ri2VAwkPxhyY0ArvF2ZJv//o+ls+BxupRN4ki06hXpQhr1m6om5tUH
	 sd24EE2ZcNONIy3DeOteDQwm/Mz0pgVAbNXeGNMAyJBos7ESNMBILxTSlcK7kZCJgY
	 D8oE/ZMDrmmbd7PNZysY3vKcGgb7dL7iJgU4UJiyYixp0Fpp9mcn/r8g4gfKxXlATA
	 SU2WenzpdeMSA==
Date: Wed, 5 Jun 2024 13:24:33 +0100
From: Mark Brown <broonie@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
	marcelo.schmitt1@gmail.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] spi: Add SPI mode bit for MOSI idle state
 configuration
Message-ID: <0a716b10-0ae0-425f-919a-ea5d8b7975b6@sirena.org.uk>
References: <cover.1717539384.git.marcelo.schmitt@analog.com>
 <e1d5d57f7a7481c84f64a764f9898122e278739b.1717539384.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/ai5QVhWnEmXwiWy"
Content-Disposition: inline
In-Reply-To: <e1d5d57f7a7481c84f64a764f9898122e278739b.1717539384.git.marcelo.schmitt@analog.com>
X-Cookie: Simulated picture.


--/ai5QVhWnEmXwiWy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 04, 2024 at 07:41:47PM -0300, Marcelo Schmitt wrote:

> The behavior of an SPI controller data output line (SDO or MOSI or COPI
> (Controller Output Peripheral Input) for disambiguation) is not specified
> when the controller is not clocking out data on SCLK edges. However, there
> exist SPI peripherals that require specific COPI line state when data is
> not being clocked out of the controller.

This is an optimisation for accelerating devices that need a specific
value, really if these devices need a value they should send it.

>  #define SPI_MOSI_IDLE_LOW	_BITUL(17)	/* leave mosi line low when idle */
> +#define SPI_MOSI_IDLE_HIGH	_BITUL(18)	/* leave mosi line high when idle */

Realistically we'll have a large set of drivers that are expecting the
line to be held low so I'm not sure we need that option.  I would also
expect to have an implementation of these options in the core which
supplies buffers with the relevant data for use with controllers that
don't have the feature (similar to how _MUST_TX and _MUST_RX are done).
Even without that we'd need feature detection so that drivers that try
to use this aren't just buggy when used with a controller that doesn't
implement it, but once you're detecting you may as well just make things
work.

--/ai5QVhWnEmXwiWy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZgWQEACgkQJNaLcl1U
h9BzVwf/XOcTR4d09YYBn0fjTHLD5RTAADKdYqwP/EXFklqqszGee4v3Q6MrGCke
1sfN9zIt5WxA7ETFjlpAF+jOjOxk/uaRgytTArEdFGh92N7fsIvcXpR+bKG6L5h5
DoHrUaEMPoWSC0ZPtCtE/Mtp/CIfa8zwjHMfkmYRgh+YIL1XnA+0BZ8H7N5bEQ5e
T4SLBCfgfqck2SlIDFU/+X3Z3nM4TF9g4/D2E1dLH5W/KHhX6ErFbhZVUcRvWh8R
mT3qNkxo+0hx+t5gwZR6TUSIUulew59oyKfDSr6yRvUj0RhdI1BvJsm74GlubUpw
fQerDO3rspJBANa5nCTDRkubmDR0Ag==
=7FcH
-----END PGP SIGNATURE-----

--/ai5QVhWnEmXwiWy--

