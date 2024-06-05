Return-Path: <linux-iio+bounces-5840-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DE58FD3B9
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 19:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 106931F25588
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 17:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D37618FC87;
	Wed,  5 Jun 2024 17:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NsWaI9Tg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9022575A;
	Wed,  5 Jun 2024 17:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717607679; cv=none; b=q+o4axCIML9sV88JVM1i0MISo6xY4yqIMSUgGFEUFZvaQ2uVtE4fiUrc+OYBG1R7Q+UiWnEPWGI8ROqTZ+pYb3z5uFxBZh3QnPkPI+QQeMXbeSxTJEDWP6I+S/pibBKCcQ0lwTvctl8XWsQ909ns+Shy2VRd+SRlEZwcmL0TVDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717607679; c=relaxed/simple;
	bh=xbm4/YzVfLN2iM3EWSGBH8ZyZKLCsErFhi94mPM6aO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oAWzQxuMcVdXNonRdPzWGo73HcYKkFSNYHsmwkJ/tXLGifkCxn/J49IHpR5Ba0guybj1P9HWQqo8tvZBREaODxSw0dxSB6622r6poLfXPa4EQoP6JYmFDiuf1I3KIib+2Z0BcXm6OGVQ1vLw5lpbpkS+wjWR1XkWcSOYy92SpNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NsWaI9Tg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D064BC2BD11;
	Wed,  5 Jun 2024 17:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717607678;
	bh=xbm4/YzVfLN2iM3EWSGBH8ZyZKLCsErFhi94mPM6aO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NsWaI9Tg+jOffHs91J+u2B0joNQl6OXwv4w6dRHJdO1zqKQXlCcKEGrZbLlUaH+fH
	 1lFOr+TUc7pFkAgO+aeDkVnzgFeYEeVKff2WgRGsngzlcp6qJ8aBmheGq+ZFaBw8Vr
	 UXwKPYDyi598g130CPm3f9mcJG22IWpG8ETia+25TSLb7ESKViFTz6AhNQANzvSrU8
	 TrwWkmonq1jlBQjyknDqleyd7X2FpjG7TwVU0SKICryTWaiyJPGECYnOGREBkFqjEj
	 y5QBKpXKcV+6Mf0Ky6Z/jKZsP0CwZT0nJrn+lBKPFMx0SIhABjE4V0VFc4ocIxfAv0
	 UHkuq2LyJDc5g==
Date: Wed, 5 Jun 2024 18:14:33 +0100
From: Conor Dooley <conor@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: broonie@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	jic23@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	nuno.sa@analog.com, dlechner@baylibre.com,
	marcelo.schmitt1@gmail.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/6] dt-bindings: iio: adc: Add AD4000
Message-ID: <20240605-tables-pectin-66d4d4dd12b5@spud>
References: <cover.1717539384.git.marcelo.schmitt@analog.com>
 <b8a211e09c17f5a9f0a6aa6e11d6375ff398c918.1717539384.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DJx7WiAB+sjuOmGe"
Content-Disposition: inline
In-Reply-To: <b8a211e09c17f5a9f0a6aa6e11d6375ff398c918.1717539384.git.marcelo.schmitt@analog.com>


--DJx7WiAB+sjuOmGe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 04, 2024 at 07:43:53PM -0300, Marcelo Schmitt wrote:
> Add device tree documentation for AD4000 series of ADC devices.
>=20
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-s=
heets/ad4000-4004-4008.pdf
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-s=
heets/ad4001-4005.pdf
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-s=
heets/ad4002-4006-4010.pdf
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-s=
heets/ad4003-4007-4011.pdf
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-s=
heets/ad4020-4021-4022.pdf
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-s=
heets/adaq4001.pdf
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-s=
heets/adaq4003.pdf
>=20
> Suggested-by: David Lechner <dlechner@baylibre.com>

A suggested-by on a binding? That's unusual...

> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> Even though didn't pick all suggestions to the dt-bindings, I did pick mo=
st them
> so kept David's Suggested-by tag.
>=20
>  .../bindings/iio/adc/adi,ad4000.yaml          | 207 ++++++++++++++++++
>  MAINTAINERS                                   |   7 +
>  2 files changed, 214 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4000.=
yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
> new file mode 100644
> index 000000000000..7470d386906b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
> @@ -0,0 +1,207 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad4000.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD4000 and similar Analog to Digital Converters
> +
> +maintainers:
> +  - Marcelo Schmitt <marcelo.schmitt@analog.com>
> +
> +description: |
> +  Analog Devices AD4000 family of Analog to Digital Converters with SPI =
support.
> +  Specifications can be found at:
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
ad4000-4004-4008.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
ad4001-4005.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
ad4002-4006-4010.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
ad4003-4007-4011.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
ad4020-4021-4022.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
adaq4001.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
adaq4003.pdf
> +
> +$ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad4000
> +      - adi,ad4001
> +      - adi,ad4002
> +      - adi,ad4003
> +      - adi,ad4004
> +      - adi,ad4005
> +      - adi,ad4006
> +      - adi,ad4007
> +      - adi,ad4008
> +      - adi,ad4010
> +      - adi,ad4011
> +      - adi,ad4020
> +      - adi,ad4021
> +      - adi,ad4022
> +      - adi,adaq4001
> +      - adi,adaq4003

Are all these actually incompatible? I'd like a note in the commit
message as to why that's the case. A quick look at the driver showed
that the differences in the driver between the ad402{0,1,2} are limited
to the "dev_name". Same went for some other devices, like the
ad40{02,06,10}.

Thanks,
Conor.

--DJx7WiAB+sjuOmGe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmCc+QAKCRB4tDGHoIJi
0tYLAQClUT+CgwIyyshiteGnaNVLzxkrRS6CHgEq3C9VUci5MgD7BctHVCI69sVX
ZXRyV7r4lmR290oWiMA3qh627lefdAA=
=FtyO
-----END PGP SIGNATURE-----

--DJx7WiAB+sjuOmGe--

