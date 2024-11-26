Return-Path: <linux-iio+bounces-12695-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A43EA9D9CFF
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 18:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B297285779
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 17:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0361DC18F;
	Tue, 26 Nov 2024 17:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huA6gbY2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A91D299;
	Tue, 26 Nov 2024 17:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732643898; cv=none; b=ku51hS5mN7njgKiLAhI35Y/EC1h45nveJvj0bBABDPOOz4bI5x1xVF/TXyiJgnDRHRZIvs+s0mHIfZ4sBuWENc17F3oOq0gnag2xwQWDABKX93EQe+BrnpSsed3lxA/lH8vkoXjYjERmqfjPTXb3iYzfLkrLfioutENsXveSicA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732643898; c=relaxed/simple;
	bh=IDyL1pulAzUpnCICZ2IVyP2Lsx+Gle/0XJ4/G7Zn+0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KVVvrI9o/CaUo+XWYRKVFG3BZuGtGgzU8RavW4VZvW9SOgvZE/TKzS7zb4ArHKe6svXOYtuGZkvkQC3mN2ih/l4eh17q9iGwIMOSWhqNZY/n9Ogtn8Ltd+eoFWvGsubPkFDIBk6ItnJHGjSgkxZfXeb4PW+fJVX3j+IQIXKTrLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huA6gbY2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B874C4CECF;
	Tue, 26 Nov 2024 17:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732643897;
	bh=IDyL1pulAzUpnCICZ2IVyP2Lsx+Gle/0XJ4/G7Zn+0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=huA6gbY2lE5dDy+0x+tm3yHSKuwnCNcQxIyL30aWJTvSZOCU8GkgKdpQmHVLBCT70
	 bHwN117Wn/ApYDnSBK6Lw+iswXvGAMoa04S6o1T7caJRaiGpI19Z5WVFICqpdtEdNI
	 Zu+1UFAFP2g7O6fOfvSYtR3Dh2dAtUxeUHaX/rvwxCjj6/80knxXTncrvJfCBwbPBC
	 gvcRn80elYFOidWYq6zf3TUuj/393MvVRoMaaRynTl5HtSXliJSqC86bSqnwhfJlFj
	 G3iJTB+7JenPrWAQYGy1B1gSuyGqdnM9UU7akk+XomH93G2zqGJsHYPxNwkC7pu9yp
	 QP/xganUQ2pEg==
Date: Tue, 26 Nov 2024 17:58:13 +0000
From: Conor Dooley <conor@kernel.org>
To: Ming Yu <a0282524688@gmail.com>
Cc: tmyu0@nuvoton.com, jic23@kernel.org, lars@metafoo.de, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, cmo@melexis.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: iio: temperature: Add support for
 NCT7718W
Message-ID: <20241126-shimmer-such-35cf44076981@spud>
References: <20241126074005.546447-1-tmyu0@nuvoton.com>
 <20241126074005.546447-2-tmyu0@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dNtPWRtJs9yXj6o/"
Content-Disposition: inline
In-Reply-To: <20241126074005.546447-2-tmyu0@nuvoton.com>


--dNtPWRtJs9yXj6o/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 03:40:04PM +0800, Ming Yu wrote:
> Add devicetree binding document for Nuvoton NCT7718W thermal sensor.
>=20
> Signed-off-by: Ming Yu <tmyu0@nuvoton.com>
> ---
>  .../iio/temperature/nuvoton,nct7718.yaml      | 44 +++++++++++++++++++
>  MAINTAINERS                                   |  6 +++
>  2 files changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/nuv=
oton,nct7718.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/temperature/nuvoton,nc=
t7718.yaml b/Documentation/devicetree/bindings/iio/temperature/nuvoton,nct7=
718.yaml
> new file mode 100644
> index 000000000000..a3573e3d454d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/temperature/nuvoton,nct7718.y=
aml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/temperature/nuvoton,nct7718.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nuvoton NCT7718W Thermal Sensor IC
> +
> +maintainers:
> +  - Ming Yu <tmyu0@nuvoton.com>
> +
> +description:
> +  https://www.nuvoton.com/resource-files/Nuvoton_NCT7718W_Datasheet_V11.=
pdf
> +
> +properties:
> +  compatible:
> +    const: nuvoton,nct7718
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg

Please add the vdd supply as a required property.

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        temp-sensor@4c {

The generic node name is actually temperature-sensor.

Thanks,
Conor.

--dNtPWRtJs9yXj6o/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ0YMNQAKCRB4tDGHoIJi
0nokAQDoyXilFegkgBLlN8uAdhsEDKKTDTM7KyXTgD69rrMOQAD8CHTTuHl20Ra7
tbOHlPE/7Q6aPc/faLPpUVLHe3lfSwU=
=1jDZ
-----END PGP SIGNATURE-----

--dNtPWRtJs9yXj6o/--

