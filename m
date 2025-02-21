Return-Path: <linux-iio+bounces-15918-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE07A3FCA0
	for <lists+linux-iio@lfdr.de>; Fri, 21 Feb 2025 18:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F65B1891EC2
	for <lists+linux-iio@lfdr.de>; Fri, 21 Feb 2025 16:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E298021D5B6;
	Fri, 21 Feb 2025 16:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rejCUcjj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989382153E4;
	Fri, 21 Feb 2025 16:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740157000; cv=none; b=vBRWgPVfTNdxLHCmuKMuUkwhR05/HuwlrgU3UIDtCDkfZ3xm9RDp9YlOhCvHB5rJX5FvNQfIxEITEdi6mMP/ZSwDrqkJUO2ONQcLZmJVUdS6ghN0MeGVX4w56MuhNGMWDQOWEg2sfbZybAcBSAJz4qx+Tq4Ih98p4OHe79Nm1cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740157000; c=relaxed/simple;
	bh=4NYNCyUlBCcUiP2flqZ7vpZ04JrfY05TT3Q9of0jt1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iWgmcLC5FSZddkLGvWnJZ0Ii1IwhQFAvJvuXpjpwCLsXsOWh83XCM+8Kfbmr0F1RikARKc6WH4BRaIABxj9BAojuFw93U288mx0LG/lQw8JIyaKqOXTFbFT1grW6fTIKGfWnnm/Ot2CjJtbARlzP9SZ0NAq6esFc94QNGNlqWhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rejCUcjj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87EC6C4CED6;
	Fri, 21 Feb 2025 16:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740157000;
	bh=4NYNCyUlBCcUiP2flqZ7vpZ04JrfY05TT3Q9of0jt1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rejCUcjjFUhWfC4zPJeNa1HrBYGq2xsIqO0ZPaU8aMD1mp8MbDX81KHJKm8uC1N4G
	 nZ1Uip6A11axdtE8FsNCFX7Aq9EnYmS46aoACenNEv0ma2HctX5SbNSwqAZRLyGMWC
	 lyRKYCXrGs8JR1p66yMCStilgPUAaCcbaXQ27IRa0daLgmqXucCHpzWn1c9qzULyVJ
	 bwWxE7Mf0fc1oE0RYZRole8xO6UtHf1xx1VmsUr2I9YVpWXkODSr265pUQVWcajUh/
	 Fqo0kKew/oQiCo693InP0JB0KlhaxgZKb72mseLhCyftg1IVG/4hTFdDfhBQnUOejn
	 40vGGHGGJiz4A==
Date: Fri, 21 Feb 2025 16:56:32 +0000
From: Conor Dooley <conor@kernel.org>
To: Eason Yang <j2anfernee@gmail.com>
Cc: avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
	venture@google.com, yuenn@google.com, benjaminfair@google.com,
	jic23@kernel.org, lars@metafoo.de, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, nuno.sa@analog.com,
	dlechner@baylibre.com, javier.carrasco.cruz@gmail.com,
	andriy.shevchenko@linux.intel.com, gstols@baylibre.com,
	olivier.moysan@foss.st.com, mitrutzceclan@gmail.com,
	tgamblin@baylibre.com, matteomartelli3@gmail.com,
	marcelo.schmitt@analog.com, alisadariana@gmail.com,
	joao.goncalves@toradex.com, thomas.bonnefille@bootlin.com,
	ramona.nechita@analog.com, herve.codina@bootlin.com,
	chanh@os.amperecomputing.com, KWLIU@nuvoton.com,
	yhyang2@nuvoton.com, openbmc@lists.ozlabs.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: adc: add NCT7201 ADCs
Message-ID: <20250221-spinout-opt-7d9b5a529610@spud>
References: <20250221090918.1487689-1-j2anfernee@gmail.com>
 <20250221090918.1487689-2-j2anfernee@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JLz+NO4dK9qNL/Og"
Content-Disposition: inline
In-Reply-To: <20250221090918.1487689-2-j2anfernee@gmail.com>


--JLz+NO4dK9qNL/Og
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 05:09:17PM +0800, Eason Yang wrote:
> Add a binding specification for the Nuvoton NCT7201/NCT7202 up to 12-bit
> ADCs with I2C interface.
>=20
> Signed-off-by: Eason Yang <j2anfernee@gmail.com>
> ---
>  .../bindings/iio/adc/nuvoton,nct7201.yaml     | 57 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoton,nct=
7201.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/nuvoton,nct7201.ya=
ml b/Documentation/devicetree/bindings/iio/adc/nuvoton,nct7201.yaml
> new file mode 100644
> index 000000000000..830c37fd9f22
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/nuvoton,nct7201.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/nuvoton,nct7201.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nuvoton nct7201 and similar ADCs
> +
> +maintainers:
> +  - Eason Yang <j2anfernee@gmail.com>
> +
> +description: |
> +  The NCT7201/NCT7202 is a Nuvoton Hardware Monitor IC, contains up to 1=
2 voltage
> +  monitoring channels, with SMBus interface, and up to 4 sets SMBus addr=
ess
> +  selection by ADDR connection. It also provides ALERT# signal for event
> +  notification and reset input RSTIN# to recover it from a fault conditi=
on.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nuvoton,nct7201
> +      - nuvoton,nct7202

When you respin, please add a note about what differs between these
devices that requires different handling in the driver.

Cheers,
Conor.

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        adc@1d {
> +            compatible =3D "nuvoton,nct7202";
> +            reg =3D <0x1d>;
> +            interrupt-parent =3D <&gpio3>;
> +            interrupts =3D <30 IRQ_TYPE_LEVEL_LOW>;
> +            reset-gpios =3D <&gpio3 28 GPIO_ACTIVE_LOW>;
> +        };
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3864d473f52f..fdc4aa5c7eff 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2831,6 +2831,7 @@ L:	openbmc@lists.ozlabs.org (moderated for non-subs=
cribers)
>  S:	Supported
>  F:	Documentation/devicetree/bindings/*/*/*npcm*
>  F:	Documentation/devicetree/bindings/*/*npcm*
> +F:	Documentation/devicetree/bindings/iio/adc/nuvoton,nct7201.yaml
>  F:	Documentation/devicetree/bindings/rtc/nuvoton,nct3018y.yaml
>  F:	arch/arm/boot/dts/nuvoton/nuvoton-npcm*
>  F:	arch/arm/mach-npcm/
> --=20
> 2.34.1
>=20

--JLz+NO4dK9qNL/Og
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ7iwQAAKCRB4tDGHoIJi
0lg0AQDsCEVD4EkUP/fg7wjfm3Cmgy9UN51JuRZ9eaXp870WdQD6A/esC7erCxcf
CxjVOVmPKf/shRAcubLnpnBnLq4xlQI=
=Az49
-----END PGP SIGNATURE-----

--JLz+NO4dK9qNL/Og--

