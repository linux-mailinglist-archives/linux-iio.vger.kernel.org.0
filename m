Return-Path: <linux-iio+bounces-19395-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFD9AB1A1A
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 18:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D09834A488A
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 16:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F216D2356CB;
	Fri,  9 May 2025 16:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ir1PEOE6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A0023504C;
	Fri,  9 May 2025 16:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746807117; cv=none; b=uQkpkOoM7V3cKF7NY5N00WUfLFMPrCY+2NsPnfnEuDbU4i4hIWGAI1XF7cb/bpdEBNedp0r2IpFdkc0xqrseCvvG0ngYwA4uoBIDxq31INmThpJAIwG3Btg/A7fStRkxBt3XoFGoU6lEEDvBisLyx0WkDo+41h9Oa9dekIla5bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746807117; c=relaxed/simple;
	bh=bpNVUwzX/KLB/HdjbVioDgiKXANaTn52rgYDeJ5osuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TvQqQORKoFHaxs+Q/fPBHQ39ZGXWVQXfsV7V89BVCNBohq/neQV4sKiBs8+ock1BWqFGPc3cPOvGnzzsW1jAHWHyANSjuDZbWZDgrpZQagAyAJ8pEBNVQbUGFU3w2fzOc81361LVP/EBpWmInICkSFuuY7WK+hv90IBr78zfkSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ir1PEOE6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82D78C4CEE4;
	Fri,  9 May 2025 16:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746807116;
	bh=bpNVUwzX/KLB/HdjbVioDgiKXANaTn52rgYDeJ5osuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ir1PEOE6NRXx99Cv95+SKi9Zmr3GL4q+cUUQ6ACo61GxcHuclOom1BQ/sPtrFIU8p
	 5LMXHOnsSIAe+nvPrFDd0yCSxiBprXis4n79sI2pdHhEysHwI35W2USx55uU2MxvvA
	 AxAr/MDNALUSpPe1qIEzDG/pkYoWyt+DOxJGozKT+IvqFhS2c727Ov5LJL9rrxMsZu
	 uVqJ3G6caDo9wOpv3nc+LMBiFFPsY6kHhWFImwZLYTwlQaGHFuWuByjEE1CZ9kNeTf
	 mZK/oB4LV7bTxIrwCQL5qLsl3WmZZ5kV8Mm0L5LSmCkkIIVjOiPk8uefgZJsjpss0v
	 25OivlVSWx2hQ==
Date: Fri, 9 May 2025 17:11:50 +0100
From: Conor Dooley <conor@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	andy@kernel.org, nuno.sa@analog.com, Michael.Hennerich@analog.com,
	marcelo.schmitt@analog.com, jic23@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com,
	linus.walleij@linaro.org, brgl@bgdev.pl, lgirdwood@gmail.com,
	broonie@kernel.org, jonath4nns@gmail.com, dlechner@baylibre.com
Subject: Re: [PATCH v7 02/12] dt-bindings: trigger-source: add generic GPIO
 trigger source
Message-ID: <20250509-quickly-culprit-3334c8ec27aa@spud>
References: <cover.1746662899.git.Jonathan.Santos@analog.com>
 <f62bcaabde172e0b2880f7d05dce97d684cc04ca.1746662899.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nyVvxJAmvCbunl+H"
Content-Disposition: inline
In-Reply-To: <f62bcaabde172e0b2880f7d05dce97d684cc04ca.1746662899.git.Jonathan.Santos@analog.com>


--nyVvxJAmvCbunl+H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 08, 2025 at 02:03:17PM -0300, Jonathan Santos wrote:
> Inspired by pwm-trigger, create a new binding for using a GPIO
> line as a trigger source.
>=20
> Link: https://lore.kernel.org/linux-iio/20250207-dlech-mainline-spi-engin=
e-offload-2-v8-3-e48a489be48c@baylibre.com/
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--nyVvxJAmvCbunl+H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaB4pRgAKCRB4tDGHoIJi
0gqtAP9nbXRFuq8u75ysr6luGBqA1gRayOtqphoqvo+HTpRQxQEAzDkebqEPZycd
XtiM1brQPnJdDp3w5Ef0u3qWs5OfKgM=
=Ei/f
-----END PGP SIGNATURE-----

--nyVvxJAmvCbunl+H--

