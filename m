Return-Path: <linux-iio+bounces-8894-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0851D9662B5
	for <lists+linux-iio@lfdr.de>; Fri, 30 Aug 2024 15:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B56F12865ED
	for <lists+linux-iio@lfdr.de>; Fri, 30 Aug 2024 13:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543301A7AF2;
	Fri, 30 Aug 2024 13:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aI2lZoKd"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0189B18E378;
	Fri, 30 Aug 2024 13:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725023667; cv=none; b=bEzXXiEeklM8Sxxrg1X+zZS1Lv/iwXlw8ZGCW6PNzCvPg9XmJ9buNC6PLiKTahZ3e6WKRtWKhCsSEeBb7H0s9D/ZSxFABQ65i23gs0913sKlisYKCoC/QcWH1G6D5qK1G67Xkonob9t9R21b2+4/GACcu8n8+HLktoWsIbqqN2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725023667; c=relaxed/simple;
	bh=TySXN9cetRSmWCN4veZ0Z+ZRgq1TPvA79rVPiBwac+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3auLFJI92jTUxK8JmZMMfBCo2Ru9XcRD907QTUKm5L2uNdcH+4tvE0/iEPOuuAsL7qPklM7/DTAOtAHEa7vge8TcnYdHE/xzvEgtytHedTNKr8TpV91XqAZEgRPJVYrE3lO4sTxfiWlI4pv5xhw1vW/IY+qRPHH0tQiNmPlfNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aI2lZoKd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9E2DC4CEC7;
	Fri, 30 Aug 2024 13:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725023665;
	bh=TySXN9cetRSmWCN4veZ0Z+ZRgq1TPvA79rVPiBwac+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aI2lZoKdVO4xG0+gXii7ySQH3bs/WeE3GnlzN0ACXWuE8tQ+9WUgN4Zt4xfDHYJ3T
	 hcfihE9fHi01molNCNcOd2meJ1QJIB+N8s4Ryz3S8XDuIIeqpWPNHLxSrJ54IxdsN0
	 /1gskhy8CUBTDquIJE6AfgDEapIcSqLBsN2AlvWgAKBz++w0AI4DiY0P/PtKsM8Xgd
	 dKjXb0ElyWB5NGP4RhIpf5qAgf3ebFIribKNoD08hSYFGTN9e97M2A/GfhcRMXhhuz
	 sCZFCyY+/9QbCmcIgWxt7ygcOyjsSoUikJF3nFN1cIQgVoqRp2CkVdgCit6aXnRlTu
	 BfF/EOCO6N46Q==
Date: Fri, 30 Aug 2024 14:14:20 +0100
From: Conor Dooley <conor@kernel.org>
To: "Sperling, Tobias" <Tobias.Sperling@softing.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"jdelvare@suse.com" <jdelvare@suse.com>,
	"linux@roeck-us.net" <linux@roeck-us.net>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"corbet@lwn.net" <corbet@lwn.net>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: Introduce ADS71x8
Message-ID: <20240830-chaos-unrivaled-04c5c4c6add9@spud>
References: <BE1P281MB24208CB90AF549578AA5C384EF972@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lRANKpXNUz7vXikp"
Content-Disposition: inline
In-Reply-To: <BE1P281MB24208CB90AF549578AA5C384EF972@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>


--lRANKpXNUz7vXikp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Tobias, Guenter, Jonathan,

On Fri, Aug 30, 2024 at 11:49:53AM +0000, Sperling, Tobias wrote:
> From b2e04ce5500faf274654be5284be9db4f3abefce Mon Sep 17 00:00:00 2001
> From: Tobias Sperling <tobias.sperling@softing.com>
> Date: Fri, 23 Aug 2024 12:08:33 +0200
> Subject: [PATCH 1/2] dt-bindings: hwmon: Introduce ADS71x8
>=20
> Add documentation for the driver of ADS7128 and ADS7138 12-bit, 8-channel
> analog-to-digital converters. These ADCs have a wide operating range and
> a wide feature set. Communication is based on an I2C interface.
> The driver provides the functionality of manually reading single channels
> or sequentially reading all channels automatically.
>=20
> Signed-off-by: Tobias Sperling <tobias.sperling@softing.com>
> ---
>  .../devicetree/bindings/hwmon/ti,ads71x8.yaml |  85 +++++++++++

If this is a "generic" adc, why is it going into hwmon?
I would have expected this to be in iio/adc, and use more typical adc
bindings, even if the driver is in hwmon.

Guenter/Jonathan wdyt?

>  Documentation/hwmon/ads71x8.rst               | 140 ++++++++++++++++++
>  Documentation/hwmon/index.rst                 |   1 +

And these two documents are not dt-bindings, so they should either be in
their own commit or alongside the driver. Not sure how Guenter likes
things.

>  3 files changed, 226 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/ti,ads71x8.ya=
ml

>  create mode 100644 Documentation/hwmon/ads71x8.rst
>=20
> diff --git a/Documentation/devicetree/bindings/hwmon/ti,ads71x8.yaml b/Do=
cumentation/devicetree/bindings/hwmon/ti,ads71x8.yaml
> new file mode 100644
> index 000000000000..e422c4ebd207
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/ti,ads71x8.yaml

Please make the filename match a compatible.

> @@ -0,0 +1,85 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +
> +$id: http://devicetree.org/schemas/hwmon/ti,ads71x8.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments ADS7128/ADS7138 Analog to Digital Converter (AD=
C)
> +
> +maintainers:
> +  - None

Nice trick..

> +description: |
> +  The ADS7128 is 12-Bit, 8-Channel Sampling Analog to Digital Converter =
(ADC)
> +  with an I2C interface.
> +
> +  Datasheets:
> +    https://www.ti.com/product/ADS7128
> +    https://www.ti.com/product/ADS7138
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,ads7128
> +      - ti,ads7138
> +
> +  reg:
> +    maxItems: 1
> +
> +  avdd-supply:

There's also a dvdd on the ads7128.

> +    description:
> +      The regulator used as analog supply voltage as well as reference v=
oltage.
> +
> +  ti,mode:
> +    $ref: /schemas/types.yaml#/definitions/uint8
> +    description: |
> +      Operation mode
> +      Mode 0 - Manual mode. A channel is only sampled when the according=
 input
> +        in the sysfs is read.
> +      Mode 1 - Auto mode. All channels are automatically sampled sequent=
ially.
> +        Reading an input returns the last valid sample. In this mode fur=
ther
> +        features like statistics and interrupts are available.
> +    default: 0

I don't think this ti,mode property is suitable for bindings. sysfs is a
linux implementation detail, when to do sampling is an implementation
detail of your driver. Bindings are only supposed to describe properties
of the hardware, not set software policy.

> +
> +  ti,interval:
> +    $ref: /schemas/types.yaml#/definitions/uint16
> +    description: |
> +      Only considered in mode 1!
> +      Interval in microseconds a new sample is triggered. Is set to clos=
est
> +      possible interval, see datasheet.

For iio devices, this is usually set from userspace, not from
devicetree, because it is usually not a hardware property, but rather
something a user may want to change at runtime.

> +    default: 1
> +
> +  interrupts:
> +    description: |
> +      Only considered in mode 1!
> +      Interrupt specifier the device's ALERT pin is connected to. Level =
must be
> +      IRQ_TYPE_LEVEL_LOW. If not configured the digital window comparato=
r (DWC)
> +      is not available.
> +    maxItems: 1

You've got 8 channels on the device, so I would be expecting to see
these described here, with a reference to adc.yaml, even if the only
suitable property is "label".

> +
> +required:
> +  - compatible
> +  - reg
> +  - avdd-supply
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
> +        ads7138@10 {

This should just be "dac@".

> +            compatible =3D "ti,ads7138";
> +            reg =3D <0x10>;
> +            avdd-supply =3D <&reg_stb_3v3>;
> +            ti,mode =3D /bits/ 8 <1>;
> +            ti,interval =3D /bits/ 16 <1000>;
> +            interrupt-parent =3D <&gpio2>;
> +            interrupts =3D <12 IRQ_TYPE_LEVEL_LOW>;
> +            status =3D "okay";
> +        };
> +    };
oCheers,
Conor.

--lRANKpXNUz7vXikp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZtHFrAAKCRB4tDGHoIJi
0gGJAQDSrH+O91oma7P5k9E+GjH8BM9eGLiFTeSHh/mDeLBU0wEAnUlaR0cOocD3
A5ar/PwXWSn7o6e3pz50rpHfAO4Iew8=
=zvjM
-----END PGP SIGNATURE-----

--lRANKpXNUz7vXikp--

