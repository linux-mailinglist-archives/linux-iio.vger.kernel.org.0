Return-Path: <linux-iio+bounces-54-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5F97E9D68
	for <lists+linux-iio@lfdr.de>; Mon, 13 Nov 2023 14:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48C4F280DB3
	for <lists+linux-iio@lfdr.de>; Mon, 13 Nov 2023 13:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC56208BA;
	Mon, 13 Nov 2023 13:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8gmxtls"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC70D63A;
	Mon, 13 Nov 2023 13:41:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD88C433C8;
	Mon, 13 Nov 2023 13:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699882890;
	bh=imLL6/JRDLObZt2bzkUsGUWoL8XyvG0qghRtgDvjR5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m8gmxtlsMGBbAMpANUoXzVGxYTH4QhlWK1vKrzcg+G3BhfltwSQHUOITxgkdJwMww
	 AmT0TgCTjCgzz7R76KE9Py8aNI0dQPTMDjlrIoimulE+dvXww02LbgwQfH248lSWC9
	 xu5Z8NOUOehgf87pE1yaNhrxiQkqS1lzPd9aml0X5XMHRQIpQ4SqM5T9aRLl1bIZw/
	 HuoTeB5/MMar5/ew9JXFa3mPqRBJtQXcfgAC1yIyJZDEjLjIHKSSs2wLXverAtDbxY
	 rfgQ41vpatoY3vwKsD+qV2L1JECmg0fxM5AlmBNAOefFX5wREQOwbG41tMfPZks+vu
	 7J2kbTCa8pp9Q==
Date: Mon, 13 Nov 2023 13:41:27 +0000
From: Conor Dooley <conor@kernel.org>
To: Ana-Maria Cusco <anamaria.cuscoo@gmail.com>
Cc: Ana-Maria Cusco <ana-maria.cusco@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: iio: hmc425a: add entry for ADRF5740
 Attenuator
Message-ID: <20231113-left-patchwork-09a1f88b0fa2@squawk>
References: <20231113102535.51074-1-anamaria.cuscoo@gmail.com>
 <20231113102535.51074-3-anamaria.cuscoo@gmail.com>
 <20231113-discourse-sushi-e8fea2450a44@squawk>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8+VS1xS0nEywSzDR"
Content-Disposition: inline
In-Reply-To: <20231113-discourse-sushi-e8fea2450a44@squawk>


--8+VS1xS0nEywSzDR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 13, 2023 at 01:40:40PM +0000, Conor Dooley wrote:
> On Mon, Nov 13, 2023 at 12:25:35PM +0200, Ana-Maria Cusco wrote:
> > From: Ana-Maria Cusco <ana-maria.cusco@analog.com>
> >=20
> > The ADRF5740 is a silicon, 4-bit digital attenuator with 22 dB
> > attenuation control range in 2 dB steps.
> >=20
> > Signed-off-by: Ana-Maria Cusco <ana-maria.cusco@analog.com>
>=20
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

One thing though, the bindings patch should come before the driver patch
in your series.

Thanks,
conor.

--8+VS1xS0nEywSzDR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVInhAAKCRB4tDGHoIJi
0vF8AQDT2fFMriDRdvgwr5oeud6DLkelqFt/Wd4NvVbI/S/hHQEAiaffvbhzd8SU
kQsIvfzMAG/8jXl/nKH6AF9mVx2vvgE=
=bgqF
-----END PGP SIGNATURE-----

--8+VS1xS0nEywSzDR--

