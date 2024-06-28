Return-Path: <linux-iio+bounces-7019-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB96191C43B
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jun 2024 18:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85E791F22A3A
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jun 2024 16:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2051CB306;
	Fri, 28 Jun 2024 16:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eTPzQGDT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757CF1CB31D;
	Fri, 28 Jun 2024 16:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719593736; cv=none; b=YJAvpg68N6SHd38PECM2YQ1cbTB3Kg9vSUnnvmxOJwSAL1y7P8XKrGSKC+35cXGzPEMPE0+GjnP+FJJi+Fmul5Ithh2efTlTsDbyT5lg4QrJ+3Qcphc8JHdQ1mhf5HNzP6wLVw3kO8MLNDq0eBJSg1mA+OX/TO+Owcfu/4AGbHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719593736; c=relaxed/simple;
	bh=Pd+7NBlLsmAzz1QimnTRzsiSfj0EsfrN9P0KZ8kQCRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ETB2uy8v/zhsP9UN9YnUKnIpsEzu5JNays3zYpzJJ6ITyNJS8dV68W/F+zhEkyz6jn9OOZXTGm0TYjtBZZSg3dyFEA3Z9ZsSWkifGsX/MjPEVC/N6AKefB8VVDc8dhfVxIz5aZmSFIMQ+UN++x6x58dX3DmBHkbxBR/NSzciuHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eTPzQGDT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A1F4C32786;
	Fri, 28 Jun 2024 16:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719593736;
	bh=Pd+7NBlLsmAzz1QimnTRzsiSfj0EsfrN9P0KZ8kQCRY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eTPzQGDT73HXe4C2+OccCM3aQMgLkoLzgS3s99YwDKWqgPqh1yr8234P5jRVO7aqv
	 BSrHayga5hvuVssJXBvFeLGNVJGtW1AORb3vWh6po00i3OnVvkm/95CdED6trwPZMt
	 iJfhQBW2W+qwClWQDL4/sl/UlGMTfVz6kDx2n73ajtHZ6nanbqRScmgqYDI0oswu3T
	 /hmr09eoZKj1s5aTAbwWGjW6gySsXbKojjFEEZ1KFOefAtHCi+JU3P5y1jYUHrGQfP
	 R7vyuLkhPV7Dkynk8mzwzjzlmR0vp8XuvpkFeTkuizXIeEgBVDy6DTj4yni1jinYuw
	 nKpKpl2RjuesQ==
Date: Fri, 28 Jun 2024 17:55:31 +0100
From: Conor Dooley <conor@kernel.org>
To: Esteban Blanc <eblanc@baylibre.com>
Cc: baylibre-upstreaming@groups.io, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH RFC 1/5] dt-bindings: iio: adc: add ADI ad4030 and ad4630
Message-ID: <20240628-gents-bath-7af7ecd9e7d5@spud>
References: <20240627-eblanc-ad4630_v1-v1-0-fdc0610c23b0@baylibre.com>
 <20240627-eblanc-ad4630_v1-v1-1-fdc0610c23b0@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oYZhIyDc3nJvZaZH"
Content-Disposition: inline
In-Reply-To: <20240627-eblanc-ad4630_v1-v1-1-fdc0610c23b0@baylibre.com>


--oYZhIyDc3nJvZaZH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 01:59:12PM +0200, Esteban Blanc wrote:
> This adds a binding specification for the Analog Devices Inc. AD4030 and
> AD4630 families of ADCs.
>=20
> Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,ad4030.yaml    | 113 +++++++++++++++=
++++++
>  MAINTAINERS                                        |   8 ++
>  2 files changed, 121 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
> new file mode 100644
> index 000000000000..7957c0c0ac7a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
> @@ -0,0 +1,113 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright 2024 Analog Devices Inc.
> +# Copyright 2024 BayLibre, SAS.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad4030.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD4030 and AD4630 ADC family device driver
> +
> +maintainers:
> +  - Nuno Sa <nuno.sa@analog.com>
> +  - Michael Hennerich <michael.hennerich@analog.com>
> +
> +description: |
> +  Analog Devices AD4030 single channel and AD4630 dual channel precision=
 SAR ADC
> +  family
> +
> +  * https://www.analog.com/media/en/technical-documentation/data-sheets/=
ad4030-24-4032-24.pdf
> +  * https://www.analog.com/media/en/technical-documentation/data-sheets/=
ad4630-24_ad4632-24.pdf
> +  * https://www.analog.com/media/en/technical-documentation/data-sheets/=
ad4630-16-4632-16.pdf
> +
> +properties:
> +
> +  compatible:
> +    enum:
> +      - adi,ad4030-24
> +      - adi,ad4630-16
> +      - adi,ad4630-24
> +      - adi,ad4632-16
> +      - adi,ad4632-24

I think this binding is fine, but I'd appreciate a note in the commit
message that mentions why these devices are not compatible. I presume it
is because the 16 and 24 denote how many bits there are and the number
of channels vary, but why the 4632-16 and 4630-16 aren't isn't as clear.

Cheers,
Conor.

--oYZhIyDc3nJvZaZH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZn7rAwAKCRB4tDGHoIJi
0sgmAQC5feD40ST7WVauPDpH0hzN8Xvkqy7VHitAjytrCj5u0QEAqzLafgR8LS6B
9NBiXjVaCrBgkF8M3x5YiWlLgXTl2Ac=
=Actx
-----END PGP SIGNATURE-----

--oYZhIyDc3nJvZaZH--

