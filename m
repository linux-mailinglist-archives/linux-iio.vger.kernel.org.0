Return-Path: <linux-iio+bounces-20788-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3167CAE0A93
	for <lists+linux-iio@lfdr.de>; Thu, 19 Jun 2025 17:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFCC03A655E
	for <lists+linux-iio@lfdr.de>; Thu, 19 Jun 2025 15:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4958B235068;
	Thu, 19 Jun 2025 15:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CxrCKAEp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE9518024;
	Thu, 19 Jun 2025 15:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750347355; cv=none; b=KBjOihd693NHUdvuqxyLeI08o5muccwuMRAOVOyg+zzb73UeT0xjpTcmJlp2lug+ZB1z95u2X1PxfyzOiLiOrT6Tgyc5emoq1t3veYntYDCUmkE87aXEvrnJsNTz/claK1zlVmTsEk6Qdbw4L0Nxm2x5SDjN/VaCFV0YVKFdJJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750347355; c=relaxed/simple;
	bh=FLBk1parzQuTc39wiLqU2V5ewA+xhI87tizdVtgIMjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BzG5LbjgisYgcPky9cd40NEBf24+XFqxZyhS64yFrdvBl6rk2RIzEsEMe0tWT1H+DZ4U+0RAveMMFZmqjklizQW920NUOtOJIDOPjv2zY4UFWs9w0HI2CCA91IE0PLK0rvW8YgGaALqRHJizG/xtWnmXUw+sFcYkBwEMHzJqvkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CxrCKAEp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC772C4CEEA;
	Thu, 19 Jun 2025 15:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750347354;
	bh=FLBk1parzQuTc39wiLqU2V5ewA+xhI87tizdVtgIMjw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CxrCKAEpIwbv7rSlkUEHuD5SlOJwNU+lOK4Vln6OlpTgpFkkshadG9jpxh7ycaQzM
	 /Tl3S1cD0ORoe6TcF+xU5SzJO6xKu+ckV0Id9UzoPtVWmHxLYNbnfP+E6DsHvBFLdS
	 YRnDIeqDQYHt5EaUBs1rrrjWFANG8AwRhOWOybk66aU1PRPsmKnBCIqNwxKW0ePO7v
	 2fhm68vHeaTQtaJQs95lW/Wgp1IVxz0qsYQ3biL8mhYLY1/7yBY+3udSZl7rDUBOKx
	 SNSYG2wdggk9ilZDeW9seMaVhnhVeYZHpWpzIt5z8qI3gVgQ1DIyTApNa3S+QccA6p
	 R17O/E3qNIOjg==
Date: Thu, 19 Jun 2025 16:35:48 +0100
From: Conor Dooley <conor@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linus.walleij@linaro.org, brgl@bgdev.pl, broonie@kernel.org,
	lgirdwood@gmail.com, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v6 01/12] dt-bindings: iio: adc: Add AD4170
Message-ID: <20250619-sitter-uranium-e7298befd733@spud>
References: <cover.1750258776.git.marcelo.schmitt@analog.com>
 <6399c1eb6d8e1bbdf720f189a7244b1d75a90ed2.1750258776.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9epqL+mz31WyTolT"
Content-Disposition: inline
In-Reply-To: <6399c1eb6d8e1bbdf720f189a7244b1d75a90ed2.1750258776.git.marcelo.schmitt@analog.com>


--9epqL+mz31WyTolT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 02:34:57PM -0300, Marcelo Schmitt wrote:
> Add device tree documentation for AD4170 and similar sigma-delta ADCs.
> The AD4170 is a 24-bit, multichannel, sigma-delta ADC.
>=20
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> Change log v5 -> v6
> - Made reference-buffer string type.
> - Moved required section before patternProperties.
> - Made avss, refin1n, refin2n documentation open to accepting positive and
>   negative voltage specifications where appropriate.
>=20
> The point of making avss-supply, refin1n-supply and refin2n-supply docume=
ntation
> open to negative voltage values is to allow device tree to specify the re=
gulator
> true voltage level so the drivers won't need to workaround negative suppl=
ies in
> the future.
>=20
>  .../bindings/iio/adc/adi,ad4170.yaml          | 558 ++++++++++++++++++
>  MAINTAINERS                                   |   7 +
>  2 files changed, 565 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4170.=
yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml
> new file mode 100644
> index 000000000000..b7fe664bb87d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml
> @@ -0,0 +1,558 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad4170.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD4170 and similar Analog to Digital Converters
> +
> +maintainers:
> +  - Marcelo Schmitt <marcelo.schmitt@analog.com>
> +
> +description: |
> +  Analog Devices AD4170 series of Sigma-delta Analog to Digital Converte=
rs.
> +  Specifications can be found at:
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
ad4170-4.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
ad4190-4.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
ad4195-4.pdf
> +
> +$ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +$defs:
> +  reference-buffer:
> +    description: |
> +      Enable precharge buffer, full buffer, or skip reference buffering =
of
> +      the positive/negative voltage reference. Because the output impeda=
nce
> +      of the source driving the voltage reference inputs may be dynamic,
> +      resistive/capacitive combinations of those inputs can cause DC gain
> +      errors if the reference inputs go unbuffered into the ADC. Enable
> +      reference buffering if the provided reference source has dynamic h=
igh
> +      impedance output. Note the absolute voltage allowed on REFINn+ and=
 REFINn-
> +      inputs is from AVSS - 50 mV to AVDD + 50 mV when the reference buf=
fers are
> +      disabled but narrows to AVSS to AVDD when reference buffering is e=
nabled
> +      or in precharge mode.

> The valid options for this property are:
> +      0: Reference precharge buffer.
> +      1: Full reference buffering.
> +      2: Bypass reference buffers (buffering disabled).

You forgot to remove this text. With that gone, I think this is
Acked-by: Conor Dooley <conor.dooley@microchip.com>
and that's explicitly an ack not an r-b cos I would like to see the lads
being happy with what you've done.

--9epqL+mz31WyTolT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaFQuVAAKCRB4tDGHoIJi
0i0eAP9nTy+DeSnflGncrmUmx/nnRZMQoDV6L8vWUxd/I6iXqAD+NzVivlD4nott
ZhLPnuPue3oDTZOrsxZw62s/DeSFrQg=
=MHbv
-----END PGP SIGNATURE-----

--9epqL+mz31WyTolT--

