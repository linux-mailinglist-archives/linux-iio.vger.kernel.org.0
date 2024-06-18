Return-Path: <linux-iio+bounces-6533-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C53C190DB62
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 20:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E3DE1F21CE8
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 18:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22551158DC5;
	Tue, 18 Jun 2024 18:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U0a8szZx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF18C158DA1;
	Tue, 18 Jun 2024 18:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718734426; cv=none; b=nHEKNWg6bODYh2LN5Etzsupb0v50EWrJpC3tkrtA7SAZE9As1L16DB4SgvAaz8c4wHAVYDeVkhur+V1tYc9VMhQPmedoX/myfCCLqCY5uvBAJY8QZgj/pxXjn01WPiuCWkIHcOZe4e40fOHOcSUoIWGe53r6Xft7zYgy174GmK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718734426; c=relaxed/simple;
	bh=9zUH9Ll8lmdrhgOG1NQ2K81zFn20OOv5U9giAfUUVlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VDSVviXtjYiQ+TTbQPaFoo/dAoENZlbqDuQg5qzwe3a0gTTfUQWq8OskeZHHdZcmEkIVEA+xdwBMtJ1h3DpJAncfOlrCL2v08BlC16wGLWihQeAdv2eyPCjTdSR57FtHXAx/daTn7YexAZXa+tb9Pfe/TQbUvJ0r2ejs+ZcyiQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U0a8szZx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA62C3277B;
	Tue, 18 Jun 2024 18:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718734426;
	bh=9zUH9Ll8lmdrhgOG1NQ2K81zFn20OOv5U9giAfUUVlg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U0a8szZxpEkZnkz89V3q+qbwWYX4RIOcrANwJgcMPKH9qdV6eYTqdlnXKHVBoXuWi
	 2J7RCRNNjYZFMZ/lQaZP3/5qxP51UqiA8/xQP7GwQGZuDJG77uFeFbIyHBTBEoE79O
	 F3rdUNd2revfdMo/IEQlwX+FjeKvBQOQfySFqICbO54rUCqbFAz02nl0UMcrqVaQdc
	 a3q+Pg+Jpg3sVXHuv589HGeJA/AfLmDd2/iyt2vqoqLpOPks3J/QqXokZagkt29eTz
	 vV8knAMuSEy/3b72cY855hOhwp0T1piH+cMrOTiXcNdeCPNC/SqIHY/eVuPBS8PNd/
	 yAQdvyCc2C7NA==
Date: Tue, 18 Jun 2024 19:13:42 +0100
From: Conor Dooley <conor@kernel.org>
To: Olivier Moysan <olivier.moysan@foss.st.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] dt-bindings: iio: add sigma delta modulator backend
Message-ID: <20240618-spearmint-traverse-5981a548c158@spud>
References: <20240618160836.945242-1-olivier.moysan@foss.st.com>
 <20240618160836.945242-6-olivier.moysan@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qwZvER5iARQub2GQ"
Content-Disposition: inline
In-Reply-To: <20240618160836.945242-6-olivier.moysan@foss.st.com>


--qwZvER5iARQub2GQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 06:08:31PM +0200, Olivier Moysan wrote:
> Add documentation of device tree bindings to support
> sigma delta modulator backend in IIO framework.
>=20
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> ---
>  .../iio/adc/sd-modulator-backend.yaml         | 43 +++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/sd-modulato=
r-backend.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/sd-modulator-backe=
nd.yaml b/Documentation/devicetree/bindings/iio/adc/sd-modulator-backend.ya=
ml
> new file mode 100644
> index 000000000000..b0fa71b75cd0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/sd-modulator-backend.yaml
> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/sd-modulator-backend.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sigma delta modulator backend
> +
> +maintainers:
> +  - Olivier Moysan <olivier.moysan@foss.st.com>
> +
> +properties:
> +  compatible:
> +    description: |
> +      "sd-backend" can be used as a generic SD modulator backend,
> +      if the modulator is not specified in the compatible list.
> +    enum:
> +      - sd-backend

I'd rather not have a generic compatible like this. Something generic as
a fallback for the driver to binding against I would be fine with, but
not something that avoids people documenting their devices.

Also, I think "backend" should be dropped from the
filename/title/descriptions, the ads1201 is "just" an delta-sigma
modulator.:wq

> +      - ads1201

Missing vendor prefix.

Thanks,
Conor.


> +
> +  '#io-backend-cells':
> +    const: 0
> +
> +  reg:
> +    maxItems: 1
> +
> +  vref-supply:
> +    description: Phandle to the vref input analog reference voltage.
> +
> +required:
> +  - compatible
> +  - '#io-backend-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    ads1201: adc {
> +      compatible =3D "sd-backend";
> +      #io-backend-cells =3D <0>;
> +    };
> +
> +...
> --=20
> 2.25.1
>=20

--qwZvER5iARQub2GQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnHOVgAKCRB4tDGHoIJi
0hZ6APwII5MqafGskS98IjBG4Mq8tm9inztm5s+2Ls6k3t4/PwEApCuE1YMwLS8Z
i9Nli5EnYCSnCpcLCXtRaPaaQDHqiQE=
=3L6r
-----END PGP SIGNATURE-----

--qwZvER5iARQub2GQ--

