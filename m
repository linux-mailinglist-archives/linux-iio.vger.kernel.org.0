Return-Path: <linux-iio+bounces-6605-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B1690F881
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 23:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B33761C21972
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 21:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527EB15A850;
	Wed, 19 Jun 2024 21:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r55G59yo"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038431DA23;
	Wed, 19 Jun 2024 21:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718832568; cv=none; b=GSMxjNrjXRCK4pgwFKixHyETcEu3pMzZC/Zna4DHF4lvGauuEFHDqCuvnWoxlhyqY5xZrJpJYuRs+TePVurEsUQ65uKSVh96t2iMCJgpyBaZ9TYhVB468Ds4io5XtNhkxe/20QlAprv85ewst7FsnaIOUlr/0GyDlePCbO/Ckqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718832568; c=relaxed/simple;
	bh=ZK/RJlwdXPh5HQsQ/9om81lNAfjZlF8oikBRZTzvVd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lx8W7uyRtCR879RLk/XoqM9x8YWH4fgG7qDCX5HG3YqNTOccrdUS+vCAoqhQugPQx9nFXKx6KZU3BzX063JKzMCzC95pkHkC+4hh18nW/QOpil9YR8IP1fCpyfJwHxopneMNdOVcI7+tCK1Ftyv6QD2pM3NRzFscBvxGp1T7rZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r55G59yo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 917BBC2BBFC;
	Wed, 19 Jun 2024 21:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718832567;
	bh=ZK/RJlwdXPh5HQsQ/9om81lNAfjZlF8oikBRZTzvVd8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r55G59yoDJ4xWM7nAC4KxeQ1PJGx7PmWlAz5CMhP+6X7HTohYPmhW5GYxNTIjm2MJ
	 AbKDz0EkENmhOpHxk6kXnUrFbFAI/LPjj90N1vXsgoSFH8OnC4iBMzCmjd+N/5/FJp
	 5ttWvYkEigzc8dUd4h77N04IRFd6LzKERb2uMNfLg4VG1jcyUfOhgzzebKoKhiZkQ/
	 udh+vsOz4lrBy4U72iyw72N1TYyLXtLAAazEsuBQ5eRYtErLUuqpss1idDWWnYe//B
	 hm4IR8IXi/nkywZXvmsYuFb/hTFuJacgvvx1Vzr6LJTAGKWc1ppS3PorhGfEmCNIH7
	 nowGb9xV1Jqdg==
Date: Wed, 19 Jun 2024 22:29:21 +0100
From: Mark Brown <broonie@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	nuno.sa@analog.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/6] spi: Enable controllers to extend the SPI
 protocol with MOSI idle configuration
Message-ID: <0cf9576d-c50e-4730-834a-3a4ceac6a4f8@sirena.org.uk>
References: <cover.1718749981.git.marcelo.schmitt@analog.com>
 <36eefb860f660e2cadb13b00aca04b5a65498993.1718749981.git.marcelo.schmitt@analog.com>
 <63db9349-f453-4a5b-aa09-d1857ddd8b03@baylibre.com>
 <ZnMqOAPc3IXP-eHC@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t5VeN0A55pzNIE5b"
Content-Disposition: inline
In-Reply-To: <ZnMqOAPc3IXP-eHC@debian-BULLSEYE-live-builder-AMD64>
X-Cookie: Don't I know you?


--t5VeN0A55pzNIE5b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 19, 2024 at 03:58:00PM -0300, Marcelo Schmitt wrote:
> On 06/19, David Lechner wrote:
> > On 6/18/24 6:10 PM, Marcelo Schmitt wrote:

> > > +In this extension to the usual SPI protocol, the MOSI line state is specified to
> > > +be kept high when CS is active but the controller is not clocking out data to

> > I think it would be less ambiguous to say "asserted" instead of "active".

> I'm not sure. IMHO, it looks less ambiguous to say a CS is active.
> I think the most common for CS lines is to have a CS that is active low (i.e.
> the line is at a low voltage level when the controller is selecting the device).
> To me, "assert" sounds closer to the idea o setting something (like a bit to 1),
> which is the opposite of active low CS.
> Though, no strong opinion about it.
> I go with what the maintainers prefer.

I think they're synonyms but asserted is the more common term for chip
selects.


> > > +#define SPI_CONTROLLER_MOSI_IDLE_LOW    BIT(8)  /* Can idle MOSI low */
> > > +#define SPI_CONTROLLER_MOSI_IDLE_HIGH   BIT(9)  /* Can idle MOSI high */

> > I don't see where these are used anywhere else in the series. They
> > seem redundant with SPI_MOSI_IDLE_LOW and SPI_MOSI_IDLE_HIGH.

> Good point.
> They are currently not being used.
> Comparing with what we have for SPI_CONTROLLER_MULTI_CS, I'm thinking it may be
> handy to have dt properties to indicate controller MOSI idle capabilities.
> Does that sound reasonable?

We shouldn't need DT properties, we should just know if the controller
supports this based on knowing what controller is, and I'd not expect it
to depend on board wiring.

--t5VeN0A55pzNIE5b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZzTbAACgkQJNaLcl1U
h9Bzrgf9EoiodKo75yJQEuL4g09qEKn2Vt4xzbAl+sckq5RJ9OkMLe1BA4AEQT+e
LQFBtArzEY6IjLirazsP5EHBN/YMCi/ogeOoz/5p0wCXQWOGoJTqWA69m7QJdeWN
aDADnsapiHmCsRWOWLkuRh8O7uEXCb4COpDsKWp9cGt0iVAtkyku4Ngn6aQSvaKy
vXmtkl+pzGYDApsC7ArQ9AexQGUojW8i/OuM2f4WxNgcR0XPm8ctV9MeXrw7Viyp
kMB3OoVEeOQvOxS4kEL3+KwIWIRtkEC7l/8EUh9+BNJTDtll+yv+tHSOTW1Jm6c+
07RDlnOAjW5IqiUN9/+jm1ie+q0Qnw==
=5icn
-----END PGP SIGNATURE-----

--t5VeN0A55pzNIE5b--

