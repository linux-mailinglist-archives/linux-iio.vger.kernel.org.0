Return-Path: <linux-iio+bounces-20601-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 523F5AD8FC6
	for <lists+linux-iio@lfdr.de>; Fri, 13 Jun 2025 16:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7F321893608
	for <lists+linux-iio@lfdr.de>; Fri, 13 Jun 2025 14:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323E81993B9;
	Fri, 13 Jun 2025 14:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5Ov7966"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0E1198E8C;
	Fri, 13 Jun 2025 14:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749825626; cv=none; b=QrHZE3MKcL/IyX6R5kYR+QFLke7Q+fdchC3Ic2ISm8aqp25U8HlFWS7F8RwMeHizVU++EKMP4+6IOjZ39ydZOuT4DSWPYn1MB+LhGNVJODq1DAF18nKkRqZJymHnyRqUqur880MlGKcyEshSuPoQOfxsorQBPDQMkgjLvVCctu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749825626; c=relaxed/simple;
	bh=G8rFJk861KqPrLLERWkejR/HukON16JAfyXw01ERfwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gvoyncSRnre+dcxWdTlY/og4ihZMBowYlHyyVueL/xnH6duezZbQq/wHxpv/JfNWazYhO9qdnqyS9lt5IWWZHmPdwfVuyG5hllb5DoUhkgxPWwrTmTCzetF2OycYC3AdiFjDkszbKQjFIXo2NldSsrQI3Wr/JSDDdEXfwGvMwfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5Ov7966; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3544DC4CEED;
	Fri, 13 Jun 2025 14:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749825625;
	bh=G8rFJk861KqPrLLERWkejR/HukON16JAfyXw01ERfwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H5Ov7966R6z4xv/MxB6xeP3MSov3C71Yy6dhRWaVmXU0CRIwm2F81FTy7nWn6BYJR
	 PfcTjxfe871A+TruQy+g0g2INu3sNALpOSlL/PwzCHV6R9sNVkE24mhpocsxDv29vc
	 4Ldtjm6RPjOVCOOLk7aEwygkcynzRn7flyEIyMCj85N/YCf0LP+V+XwwvuPbZTJojC
	 KwEZrmSztugFFB025xw/Tcv36xaFYzz0NWFLFdUzTnUEK9sL6AI/luKlMaecR4Z0YO
	 qHHqiGFJTAqxfXMn+rJp4CNUdPbyGiwN7Kl4k2TTmoXY4si2zgy+q0nqoMZ/cfad8k
	 n1QmfXxfSl5tg==
Date: Fri, 13 Jun 2025 15:40:21 +0100
From: Conor Dooley <conor@kernel.org>
To: victor.duicu@microchip.com
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, marius.cristea@microchip.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: temperature: add support for
 MCP998X
Message-ID: <20250613-undergo-reviving-a97dca8f3b69@spud>
References: <20250613130207.8560-1-victor.duicu@microchip.com>
 <20250613130207.8560-2-victor.duicu@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GiFAnyVgEONdrGXM"
Content-Disposition: inline
In-Reply-To: <20250613130207.8560-2-victor.duicu@microchip.com>


--GiFAnyVgEONdrGXM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 04:02:06PM +0300, victor.duicu@microchip.com wrote:
> From: Victor Duicu <victor.duicu@microchip.com>
>=20
> This is the devicetree schema for Microchip MCP998X/33 and
> MCP998XD/33D Automotive Temperature Monitor Family.
>=20
> Signed-off-by: Victor Duicu <victor.duicu@microchip.com>
> ---
>  .../iio/temperature/microchip,mcp9982.yaml    | 211 ++++++++++++++++++
>  1 file changed, 211 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/mic=
rochip,mcp9982.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/temperature/microchip,=
mcp9982.yaml b/Documentation/devicetree/bindings/iio/temperature/microchip,=
mcp9982.yaml
> new file mode 100644
> index 000000000000..ec939d463612
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9982=
=2Eyaml
> @@ -0,0 +1,211 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/temperature/microchip,mcp9982.yam=
l#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip MCP998X/33 and MCP998XD/33D Multichannel Automotive
> +       Temperature Monitor Family
> +
> +maintainers:
> +  - Victor Duicu <victor.duicu@microchip.com>
> +
> +description: |
> +  The MCP998X/33 and MCP998XD/33D family is a high-accuracy 2-wire multi=
channel
> +  automotive temperature monitor.
> +  The datasheet can be found here:
> +    https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/Prod=
uctDocuments/DataSheets/MCP998X-Family-Data-Sheet-DS20006827.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - microchip,mcp9933
> +      - microchip,mcp9933d
> +      - microchip,mcp9982
> +      - microchip,mcp9982d
> +      - microchip,mcp9983
> +      - microchip,mcp9983d
> +      - microchip,mcp9984
> +      - microchip,mcp9984d
> +      - microchip,mcp9985
> +      - microchip,mcp9985d
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    minItems: 2
> +    maxItems: 2
> +
> +  interrupt-names:
> +    description:
> +      -alert-therm is used to handle a HIGH or LOW limit.
> +      -therm-addr is used to handle a THERM limit on chips
> +      without "D" in the name.
> +      -sys-shutdown is used to handle a THERM limit on chips
> +      with "D" in the name.
> +    items:
> +      - const: alert-therm
> +      - const: therm-addr
> +      - const: sys-shutdown
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  microchip,enable-anti-parallel:
> +    description:
> +      Enable anti-parallel diode mode operation.
> +      MCP9984/84D/85/85D and MCP9933/33D support reading two external di=
odes
> +      in anti-parallel connection on the same set of pins.
> +    type: boolean
> +
> +  microchip,beta1:
> +    description:
> +      Set beta compensation value for external channel 1.
> +      <0> 0.050
> +      <1> 0.066
> +      <2> 0.087
> +      <3> 0.114
> +      <4> 0.150
> +      <5> 0.197
> +      <6> 0.260
> +      <7> 0.342
> +      <8> 0.449
> +      <9> 0.591
> +      <10> 0.778
> +      <11> 1.024
> +      <12> 1.348
> +      <13> 1.773
> +      <14> 2.333
> +      <15> Diode_Mode
> +      <16> Auto
> +      - Diode_Mode is used when measuring a discrete thermal diode
> +      or a CPU diode that functions like a discrete thermal diode.
> +      - Auto enables beta auto-detection. The chip monitors
> +      external diode/transistor and determines the optimum
> +      setting.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 16

Missing max/min constraints on the property.

> +
> +  microchip,beta2:
> +    description:
> +      Set beta compensation value for external channel 2.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 16
> +
> +  microchip,resistance-comp-ch1-2-enable:
> +    description:
> +      Enable resistance error correction(REC) for external channels 1 an=
d 2.
> +      The chip internal hardware counterbalances the parasitic resistanc=
e in
> +      series with the external diodes. The compensation can be activated=
 or
> +      disabled in hardware for both channels 1 and 2 at the same time.
> +    type: boolean

On the previous version I objected to this wording for the property,
where it is being used as an enable, and instead said that it should
indicate the presence of the parasitic resistance. Did I miss some sort
of new justification for it still talking about being an enable?


> +  microchip,resistance-comp-ch3-4-enable:
> +    description:
> +      Enable resistance error correction(REC) for external channels 3 an=
d 4.
> +      The chip internal hardware counterbalances the parasitic resistanc=
e in
> +      series with the external diodes. The compensation can be activated=
 or
> +      disabled in hardware for both channels 3 and 4 at the same time.
> +    type: boolean

Cheers,
Conor.

--GiFAnyVgEONdrGXM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaEw4VAAKCRB4tDGHoIJi
0mwmAQDew5SpZ30kpLSUmEH21jXuflCEUQxJr1shipMAysEfxQD/VU4aDW13CHd/
NSLDi+a1WL4+sorUxL4dtXWJmVWKdQs=
=e2Hw
-----END PGP SIGNATURE-----

--GiFAnyVgEONdrGXM--

