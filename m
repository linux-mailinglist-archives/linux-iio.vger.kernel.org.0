Return-Path: <linux-iio+bounces-19202-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC80CAACAB8
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 18:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08BF31C43052
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 16:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D075127FD6F;
	Tue,  6 May 2025 16:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="msQO03P7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D624B1E6E;
	Tue,  6 May 2025 16:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746548347; cv=none; b=nbKlRXECVQodHhlIqVGaO0WaLrPAv26OLwD3evf8D/2fkVwxy2lH0QvPZo4ra3VV86pp4vkSN4nk0433NaojbvLzobqCWymf635djAxO6inc3y8nhn0K4MdJoPpn2IlTpY2dVYxhCEUprzdDyPDinuTdau+gIzHduL0Ad3iE/sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746548347; c=relaxed/simple;
	bh=mQ9szpH5CHBWVPw4QRxpXJXW5vLnDhRWc/A4oxy+Xeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UoIyNr+hIjPCgRPQTCPILh1j5xukUcUWQkNaGii2451dWbHIwLcFx/n3Gt166znhvv5Vffy/BvSi1xGsAoKKkKc2CWyg7EdpOlZ7gYbqFLmqeSOpvyJSOByNGEJltlTjGvFewa9+1uGVoWJDOLndQK/MvHFghVHCl3u5a/7jkcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=msQO03P7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 574B5C4CEE4;
	Tue,  6 May 2025 16:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746548347;
	bh=mQ9szpH5CHBWVPw4QRxpXJXW5vLnDhRWc/A4oxy+Xeo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=msQO03P766ezQIt6BZpctYN0mfM5WEL0BUz6CUILRZRO3QndyuhB9zReNeEKORHLN
	 25zc0EGHNxuQr6kpeXWcDkjom7MIA2bYwgeG18mYCCUZnaNO53roBLy5vWRAccseos
	 wd+Dith/lw02+hPNgIMzvT5i+ciLgwJZDWmrbh0VyXeXSGF4WmhDLtnP30bok9Aucc
	 ZFokw7pVRbmAlBpn65j2TrF4D1taZ1KdeCeQS9KgSfqIEyEHks9HkGdYoxg9GzggBN
	 2ik64e7AETF39voFsHQy/bkzryDO5sKP1SCCETyW0Fv1CZL80K8lXvY59GRKZal7ZJ
	 D7Crxcb/di3HA==
Date: Tue, 6 May 2025 17:19:01 +0100
From: Conor Dooley <conor@kernel.org>
To: Jianping.Shen@de.bosch.com
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, dima.fedrau@gmail.com,
	marcelo.schmitt1@gmail.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Christian.Lorenz3@de.bosch.com, Ulrike.Frauendorf@de.bosch.com,
	Kai.Dolde@de.bosch.com
Subject: Re: [PATCH v1 2/3] dt-bindings: iio: imu: smi330: Add binding
Message-ID: <20250506-supply-machine-ad65dbc84cb7@spud>
References: <20250505151641.52878-1-Jianping.Shen@de.bosch.com>
 <20250505151641.52878-3-Jianping.Shen@de.bosch.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gNb2cwIBZg8xSODA"
Content-Disposition: inline
In-Reply-To: <20250505151641.52878-3-Jianping.Shen@de.bosch.com>


--gNb2cwIBZg8xSODA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 05, 2025 at 05:16:40PM +0200, Jianping.Shen@de.bosch.com wrote:
> From: Jianping Shen <Jianping.Shen@de.bosch.com>
>=20
> Add devicetree binding for Bosch imu smi330.
> The smi330 is a combined three axis angular rate and
> three axis acceleration sensor module.
>=20
> Signed-off-by: Jianping Shen <Jianping.Shen@de.bosch.com>
> ---
>  .../bindings/iio/imu/bosch,smi330.yaml        | 89 +++++++++++++++++++
>  1 file changed, 89 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,smi33=
0.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/imu/bosch,smi330.yaml =
b/Documentation/devicetree/bindings/iio/imu/bosch,smi330.yaml
> new file mode 100644
> index 00000000000..fb65bd26ada
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/imu/bosch,smi330.yaml
> @@ -0,0 +1,89 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/imu/bosch,smi330.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Bosch SMI330 6-Axis IMU
> +
> +maintainers:
> +  - Stefan Gutmann <stefam.gutmann@de.bosch.com>
> +
> +description:
> +  SMI330 is a 6-axis inertial measurement unit that supports acceleratio=
n and
> +  gyroscopic measurements with hardware fifo buffering. Sensor also prov=
ides
> +  events information such as motion, no-motion and tilt detection.
> +
> +properties:
> +  compatible:
> +    const: bosch,smi330
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: provide VDD power to the sensor.
> +
> +  vddio-supply:
> +    description: provide VDD IO power to the sensor.
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 2
> +
> +  interrupt-names:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      enum:
> +        - INT1
> +        - INT2
> +
> +  drive-open-drain:

This property is missing a type, no? boolean or flag

> +    description:
> +      set if the specified interrupt pin should be configured as
> +      open drain. If not set, defaults to push-pull.

What "specified interrupt pin"? You've got two interrupts, does this
apply to one? Both?

--gNb2cwIBZg8xSODA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaBo2dQAKCRB4tDGHoIJi
0vLbAP4jzJ3PKvpPiMQX4ypHlbGv4oe/1++WGNpJnreaPZDcpQEAmJRv4mQmm1Bb
TK60CDpIbHAtiRFVFnWaV7N3iZU61gs=
=NINq
-----END PGP SIGNATURE-----

--gNb2cwIBZg8xSODA--

