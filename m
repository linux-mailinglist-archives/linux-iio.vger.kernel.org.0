Return-Path: <linux-iio+bounces-13030-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C659E2748
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 17:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E281B163EDD
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 16:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B961F8938;
	Tue,  3 Dec 2024 16:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOBUUvEr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39711F7567;
	Tue,  3 Dec 2024 16:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733242921; cv=none; b=nkVJ/3oxDzYe24q09kpLc6/7D+/h6VNEtKUCt+Kq0ZcZAjjcAVP8XzjaMZVv+tMUyXrNOOkQIYa14hbIioQudQQbuaZAs9agBmK7ZDQSS6BlQ04GJaYBkm6dtucb+tmkpP85w0qtUEIPjDokpmwtCzqxUae31CTyqsaBPB0lnPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733242921; c=relaxed/simple;
	bh=+/623WfFUntZz6Adt2ME1N7H20GK+UzhRI1z3wBv6Qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QlhVyL69VdEP5FgNq2sfwhQk5NVauxffJH/Qn0cJ1Xzq2j01ew1dPJnUdkOpiojoWgFT3Wwu8lgC94J5/MSHuBSX1rJ+h3593kqbazSiRjkfH2nRC7sRemR0s2OadPJaIfPub3Q2v97QuWiEbna1lYSDb7tKqcqsYv65XdWmeuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOBUUvEr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41781C4CECF;
	Tue,  3 Dec 2024 16:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733242921;
	bh=+/623WfFUntZz6Adt2ME1N7H20GK+UzhRI1z3wBv6Qc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bOBUUvErIOGvT37FVKVJ+vxmGbw8ElElYNdxy/kq2M24ElgXe1d6upjC4BDwPhbGx
	 FIsValtUqLTWzBJk+W4Dm/SWH9h12y0D5KlR72RKgUR0tsjacmpMYQ777zvG9KhuQS
	 GiWUbsgf/GTeEmpPcVxxfPZF6vQ4c5ubPO0+XwOyynlDE+HWuSXzGluT45135elRrJ
	 /z6bflmDHQGloYL6teJQyBhIwDVp8lqOjdrQwQsFafFywNwJFGDfmgYaq8rHIPRB2w
	 skZl5r3kKCRhij0HC6WIV2uKqdn0fOKKivysrzL4b+c9gfYQ8h0QhhbCIxiAWsAphb
	 iglWr2fRgH4jQ==
Date: Tue, 3 Dec 2024 16:21:55 +0000
From: Conor Dooley <conor@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-iio@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Renato Lui Geh <renatogeh@gmail.com>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	devicetree@vger.kernel.org, Nuno Sa <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Alexandru Ardelean <aardelean@baylibre.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Trevor Gamblin <tgamblin@baylibre.com>
Subject: Re: [PATCH v5 03/10] dt-bindings: iio: adc:
 adi,ad7{124,173,192,780}: Allow specifications of a gpio for irq line
Message-ID: <20241203-endanger-dwindle-a0b38ba38d4a@spud>
References: <20241203110019.1520071-12-u.kleine-koenig@baylibre.com>
 <20241203110019.1520071-15-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WNtzPII5NAERjECQ"
Content-Disposition: inline
In-Reply-To: <20241203110019.1520071-15-u.kleine-koenig@baylibre.com>


--WNtzPII5NAERjECQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 03, 2024 at 12:00:23PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> For the AD7124 chip and some of its cousins the logical irq line (=CC=85R=
=CC=85D=CC=85Y)
> is physically on the same pin as the spi MISO output (DOUT) and so
> reading a register might trigger an interrupt. For correct operation
> it's critical that the actual state of the pin can be read to judge if
> an interrupt event is a real one or just a spurious one triggered by
> toggling the line in its MISO mode.
>=20
> Allow specification of an "rdy-gpios" property that references a GPIO
> that can be used for that purpose. While this is typically the same GPIO
> also used (implicitly) as interrupt source, it is still supposed that
> the interrupt is specified as before and usual.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--WNtzPII5NAERjECQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ08wIwAKCRB4tDGHoIJi
0r04AQD5OskPybIUqdRXN0HTwDIONalSRhOdqqUK3ALo+OE4YwEAuEn1vZn7Sdfn
Qv++X43fv7S4PiRFt3W7Ve3p6llYuAI=
=lCpS
-----END PGP SIGNATURE-----

--WNtzPII5NAERjECQ--

