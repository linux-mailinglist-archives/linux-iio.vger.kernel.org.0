Return-Path: <linux-iio+bounces-129-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B86687EE6CA
	for <lists+linux-iio@lfdr.de>; Thu, 16 Nov 2023 19:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72BF22811C2
	for <lists+linux-iio@lfdr.de>; Thu, 16 Nov 2023 18:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C50C30CFA;
	Thu, 16 Nov 2023 18:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxzYQgfX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD42A46524;
	Thu, 16 Nov 2023 18:34:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C348C433C8;
	Thu, 16 Nov 2023 18:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700159660;
	bh=8EhJKo8rDeezKqxLzMDL7DCLOC6nqzPZCy8ff/Ayqe8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GxzYQgfX6q6Qrk30HeKvn5JTCTDM4xnC9E62Ky78pyXCsCpuwnhHWYNOLpqJeoS69
	 jXrNYndJ1RNR0GrPzvtu4KF+txcfx6nxgKaaM/yebJ+PrZ4wTvQUdpo9CkKFR6aq9f
	 liU+UUd76DmQahOVwgWLldkF3hUEc352EUWtArptO1Z7R7rk/ai32G/x0K5ui3Jvw/
	 lB1kfJ3/YMyar+tzvnnBJGmr8j43nmyddwH5G+2pw6mriYvglmKOOwi1+igINbrv5O
	 mOwuEcanj2bpiv0H8AEugX4oZ+ohKmJ/amHFUkQ28APHiNOW9NEfoGjC3kCYn6ynU8
	 W30nira3eBMzQ==
Date: Thu, 16 Nov 2023 18:34:16 +0000
From: Conor Dooley <conor@kernel.org>
To: Andreas Klinger <ak@it-klinger.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Petre Rodan <petre.rodan@subdimension.ro>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: honeywell,mprls0025pa.yaml: fix function numbering
Message-ID: <20231116-grudge-hankering-b7a71d831b93@squawk>
References: <20231116182443.7290-1-ak@it-klinger.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hdaK5Truep84srtq"
Content-Disposition: inline
In-Reply-To: <20231116182443.7290-1-ak@it-klinger.de>


--hdaK5Truep84srtq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2023 at 07:24:43PM +0100, Andreas Klinger wrote:
> Fix wrongly documented numbering of transfer functions.
>=20
> Fixes: a765c985e696 ("dt-bindings: iio: pressure: Support Honeywell mprls=
0025pa sensor")
>

No blank line here.

> Suggested-by: Petre Rodan <petre.rodan@subdimension.ro>

This should be Reported-by.

> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> ---
>  .../bindings/iio/pressure/honeywell,mprls0025pa.yaml        | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/pressure/honeywell,mpr=
ls0025pa.yaml b/Documentation/devicetree/bindings/iio/pressure/honeywell,mp=
rls0025pa.yaml
> index b31f8120f14e..61775eff1128 100644
> --- a/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025p=
a.yaml
> +++ b/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025p=
a.yaml
> @@ -64,9 +64,9 @@ properties:
>      description: |
>        Transfer function which defines the range of valid values delivere=
d by the
>        sensor.
> -      1 - A, 10% to 90% of 2^24 (1677722 .. 15099494)
> -      2 - B, 2.5% to 22.5% of 2^24 (419430 .. 3774874)
> -      3 - C, 20% to 80% of 2^24 (3355443 .. 13421773)
> +      0 - A, 10% to 90% of 2^24 (1677722 .. 15099494)
> +      1 - B, 2.5% to 22.5% of 2^24 (419430 .. 3774874)
> +      2 - C, 20% to 80% of 2^24 (3355443 .. 13421773)

I don't understand. These are arbitrary numbers in a dt-binding, why
does zero or one indexing make any difference here?
Can't you just fix up the driver to correctly map the dt-binding to
whatever needs to be written to registers in the hardware?

Cheers,
Conor.

>      $ref: /schemas/types.yaml#/definitions/uint32
> =20
>    vdd-supply:
> --=20
> 2.39.2
>=20

--hdaK5Truep84srtq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVZgpQAKCRB4tDGHoIJi
0ro9AP41/miHXh7XhWfNmwyktMkO3qn/gHtMyuEiySwMJSiQygEA5W0rZahN92ag
PUp2JscwQiOwmt7fQzs1cJb7N8aOvgI=
=C+WP
-----END PGP SIGNATURE-----

--hdaK5Truep84srtq--

