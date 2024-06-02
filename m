Return-Path: <linux-iio+bounces-5632-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6EB8D75C0
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 15:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74EF1B20FA9
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 13:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EDE3B7AC;
	Sun,  2 Jun 2024 13:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kRdn+J97"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2E11173F;
	Sun,  2 Jun 2024 13:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717335300; cv=none; b=rC6PrURBjDciUfzZkIZaUhe6Tn18tXknFytcKzR2ThH4qeOg1+PhIjvO/163tciqTdchmtXclmDqjvYZTfsI3nBkiXviZoq9nKmu0lBmVW4COaEx11YzZHhLyUePEbzAOSJEoVw4hYPxAA+mw6m/IQ6jYgK73CTGbciIGJmK1lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717335300; c=relaxed/simple;
	bh=fGo0CkAMVlwKZk/3VQRHsXRBENz0lBseVBEwFCY/wg0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ipr9LqFTxXeAFAlL2czUTReBcvCQpCYsMW3GtBAL+B5W8QBvan5rWt+VyVxZkWgKtI8fpWAPCuztR/EJ/x24LKc9ruQL2e0xfkaZmBUm1I53dKL7hFiWAI2GbiZTYifEWATxXKYYM8zQrBojkIvOX1xUyTzBNniGgXFUcuTo58U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kRdn+J97; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD1B8C2BBFC;
	Sun,  2 Jun 2024 13:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717335300;
	bh=fGo0CkAMVlwKZk/3VQRHsXRBENz0lBseVBEwFCY/wg0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kRdn+J97mVKvljg+4exXX0lmX9OKbJ4xFvbyIK8mYZsD/gsvRE5jmicKWU1Z0CxVd
	 ukpyfUVReVBF3ubjghbtFdhm/ITvs3pXYBRJIS+z5UnXi1uQhK3aedWF2KMDdLUeXV
	 FQreJfdtXtU2PoR4nnKDzgsdhEF0UK5uSgAGEoo1TytPioVXs0ObQKvxf/+OzcHE7U
	 KTie0TTsdZoSxeJgJ6ig0ECUUbjslcRkV5nzzr/k+BisCfay2U/lfWe/IzfLitybRR
	 sbJpjkhz333WTZd5HMYkOUuhonbNhuwogPPxow0vlA/i2bGo11jo9WstUDAtog5vXn
	 PJjS777xFoOhg==
Date: Sun, 2 Jun 2024 14:34:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Yasin Lee <yasin.lee.x@outlook.com>
Cc: andy.shevchenko@gmail.com, lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, nuno.a@analog.com, swboyd@chromium.org,
 u.kleine-koenig@pengutronix.de, yasin.lee.x@gmail.com
Subject: Re: [PATCH v3 1/2] dt-bindings:iio:proximity: Add hx9023s binding
Message-ID: <20240602143449.44491d98@jic23-huawei>
In-Reply-To: <SN7PR12MB8101FD306CBFC84DDF3D2466A4F22@SN7PR12MB8101.namprd12.prod.outlook.com>
References: <20240519162438.17af0ff8@jic23-huawei>
	<20240529045749.530039-1-yasin.lee.x@outlook.com>
	<SN7PR12MB8101FD306CBFC84DDF3D2466A4F22@SN7PR12MB8101.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 29 May 2024 12:57:48 +0800
Yasin Lee <yasin.lee.x@outlook.com> wrote:

> From: Yasin Lee <yasin.lee.x@gmail.com>
>=20
> A capacitive proximity sensor
>=20
> Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
Hi Yasin,

Some comments inline.

A lot of what you have here sounds like it should be under userspace
control, not in the dt-binding.

Also, look at how we handled optional channels for ADCs and copy that
approach here.

Jonathan


> ---
>  .../bindings/iio/proximity/tyhx,hx9023s.yaml  | 106 ++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>  2 files changed, 108 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/tyhx,=
hx9023s.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s=
.yaml b/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
> new file mode 100644
> index 000000000000..ba4d7343bb30
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
> @@ -0,0 +1,106 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/proximity/tyhx,hx9023s.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TYHX HX9023S capacitive proximity sensor
> +
> +maintainers:
> +  - Yasin Lee <yasin.lee.x@gmail.com>
> +
> +description: |
> +  TYHX HX9023S proximity sensor
> +
> +allOf:
> +  - $ref: /schemas/iio/iio.yaml#
> +
> +properties:
> +  compatible:
> +    const: tyhx,hx9023s
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    description: |
> +      Generated by device to announce preceding read request has finished
> +      and data is available or that a close/far proximity event has happ=
ened.
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: Main power supply
vdd-supply: true
is enough.  vdd is pretty much always used for the main power supply so the
docs are are redundant.
> +
> +  accuracy:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Accuracy level of the sensor

No idea what this means!

> +
> +  channel-used-flag:
> +    description: Bit flag indicating which channels are used
> +    $ref: /schemas/types.yaml#/definitions/uint32
As below - subnodes not a bunch of arrays. If the subnode is there
it should be used.

> +
> +  odr:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Set ODR for all channenls.

I assume output data rate?  That's something for userspace not the DT bindi=
ng.

> +
> +  integration-sample:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Set Integration number and Sample number for each chann=
enl.
Ok. This one might possibly be hardware related as it depends on the wiring
and physical elements of the board.  If so give a good description on how
this should be set.

> +
> +  osr:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description: Set number of OSR for each channenl.
Expand the acronym.  This sounds like oversampling ratio which
would be odd to see alongside an average control. Hence
more detail needed and consider if it should be controlled by
the dt binding.

> +
> +  avg:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description: Set number of AVG for each channenl.

This sounds like oversampling? If so that is normally a userspace
problem not a binding thing.  Is it related to the physical wiring?
If not don't put it in the binding.

> +
> +  lp-alpha:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description: Set lp-alpha for each channenl.
Spell check.

Also this needs more description.
> +
> +  cs-position:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description: |
> +      Position of the CS pins.
> +      Indicates the corresponding bit for each CS pin in the register.

I've no idea what this. Add more description. Normally CS is chip select
and there is only one of those.  Also this not general dt binding material
so vendor prefix this stuff.

> +
> +  channel-positive:

Use per channel nodes.  There are examples in for example adc/adc.yaml
on how to do this.  Not having a child node is a lot easier to follow
than magic values to say something isn't there.

=46rom what is here these look like differential channels. Use the adc
style binding for that.


> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description: Positive channel assignments. Use 255 for not connected
> +
> +  channel-negative:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description: |
> +      Negative channel assignments. Use 255 for not connected
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +      hx9023s@2a {

As was pointed out in earlier patch review - generic node names only.

> +        compatible =3D "tyhx,hx9023s";
> +        reg =3D <0x2a>;
> +        interrupt-parent =3D <&pio>;
> +        interrupts =3D <16 IRQ_TYPE_EDGE_FALLING>;
> +        vdd-supply =3D <&pp1800_prox>;
> +        accuracy =3D <16>;
> +        channel-used-flag =3D <0x1F>;
> +        odr =3D <0x17>;
> +        integration-sample =3D <0x0065>;
> +        osr =3D <0x4 0x4 0x4 0x0 0x0>;
> +        avg =3D <0x3 0x3 0x3 0x0 0x0>;
> +        lp-alpha =3D <0x8 0x8 0x8 0x8 0x2>;
> +        cs-position =3D <0 2 4 6 8>;
> +        channel-positive =3D <0 1 2 3 4>;
> +        channel-negative =3D <255 255 255 255 255>;
> +      };
> +    };
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Doc=
umentation/devicetree/bindings/vendor-prefixes.yaml
> index b97d298b3eb6..e2224eea9ab9 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -1507,6 +1507,8 @@ patternProperties:
>      description: Turing Machines, Inc.
>    "^tyan,.*":
>      description: Tyan Computer Corporation
> +  "^tyhx,.*":
> +    description: NanjingTianyihexin Electronics Ltd.

Convention is separate patch for vendor prefix editions. Makes it
easier for people to cherrypick them for a different device driver binding.

>    "^u-blox,.*":
>      description: u-blox
>    "^u-boot,.*":


