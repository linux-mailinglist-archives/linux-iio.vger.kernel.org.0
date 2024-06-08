Return-Path: <linux-iio+bounces-6067-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D5F9012DC
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 18:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B64DF1C21394
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 16:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157F12E417;
	Sat,  8 Jun 2024 16:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxoEBJvD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFA66BFD4;
	Sat,  8 Jun 2024 16:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717865887; cv=none; b=mr7l55OxdHuRqKEJrV0cFNwJ8vMm2YJLH5VdwiZl7sTfJq4Q/aRyTvapSf8yL+HHG/P8ZuqdXU8CZB9oRRBJ0N2tpz7R9qBFV5+owMtPg+x0WT9pdX4AQjAdNAyuMmxBkkTAOyBTqith02X3VhVpL9fL4Gp+nDQggkAL4tJ5cfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717865887; c=relaxed/simple;
	bh=cneqwz7LEfUXNP4OwZRkoStIq/D8LnoM4XEbBA8K1QM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lhJpEnXmEFOnWabF5panLEq3YQdaENKhiWjbFLpcd6wAFHNEgqV4PcmpUDD08+H4fHFBmEOQhYorPMQE4tYUDt3l7BZ6J8uPB3aEvc3LdbdyJ6CW48APOithLrX0USAwCzHe0n7ENzepG38Rkl/if2eDroJF3Lr6d8QGPNNoAaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dxoEBJvD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDC71C2BD11;
	Sat,  8 Jun 2024 16:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717865887;
	bh=cneqwz7LEfUXNP4OwZRkoStIq/D8LnoM4XEbBA8K1QM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dxoEBJvDii4nhZC2oSqTlH67cctyuN3bN7p2rdZVxXEv7HfizfmTVJ1uHF74OUsMR
	 lPj/BL2Ocp3cEjz3O6fCdwDMKiq7QSzptNZWuTG8fSUjfL8GqCQMypJGzd1j0eygPp
	 lTT3qcLFKVd8CO+qZ7Jq29iLm0oe0wAqYu2hXsZ2IivDDQdCu9/9vraVCi1yWf9VNI
	 6LGekzCqBawYpXEtbgQrY155/A6+KcqtwakaZcLRn9S9oDDrQPYZ+q1qDX/zmJdT1y
	 sLuROietflRqU1241onTzQc6HB2Rhg0MQZdxqy4vh5Y8WlDFFVXoJQwFj8yJOzVHBO
	 a8E4SjKmzrDPQ==
Date: Sat, 8 Jun 2024 17:57:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Yasin Lee <yasin.lee.x@outlook.com>
Cc: andy.shevchenko@gmail.com, lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, nuno.a@analog.com, swboyd@chromium.org,
 u.kleine-koenig@pengutronix.de, yasin.lee.x@gmail.com
Subject: Re: [PATCH v4 1/2] dt-bindings:iio:proximity: Add hx9023s binding
Message-ID: <20240608175758.73396584@jic23-huawei>
In-Reply-To: <SN7PR12MB810129D8180B1C9593A8E078A4FB2@SN7PR12MB8101.namprd12.prod.outlook.com>
References: <20240607114138.390272-1-yasin.lee.x@outlook.com>
	<SN7PR12MB810129D8180B1C9593A8E078A4FB2@SN7PR12MB8101.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  7 Jun 2024 19:41:37 +0800
Yasin Lee <yasin.lee.x@outlook.com> wrote:

> From: Yasin Lee <yasin.lee.x@gmail.com>
> 
> A capacitive proximity sensor
> 
> Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
Hi Yasin

Some improvements but seems you missed some of the feedback on v3.

See inline.

Jonathan

> ---
>  .../bindings/iio/proximity/tyhx,hx9023s.yaml  | 103 ++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>  2 files changed, 105 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml b/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
> new file mode 100644
> index 000000000000..50bf2849d823
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
> @@ -0,0 +1,103 @@
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

A device like this needs at least one power supply.  Make sure to document
all such supplies and make the ones that are required for functionality part of
your required properties.  Note that you should do this even if on your
board they are always turned on.

> +
> +  interrupts:
> +    description: |
> +      Generated by device to announce preceding read request has finished
> +      and data is available or that a close/far proximity event has happened.
> +    maxItems: 1
> +
> +  vdd-supply:
> +    true
  vdd-supply: true

on single line is commonly done for these.

> +
> +  channel-in-use:
> +    description: |
> +      Bit flag indicating which channels are used,
> +      depends on the hardware circuit design.
> +    $ref: /schemas/types.yaml#/definitions/uint32

Presence of the channel nodes below should make this clear
without a separate element.


> +
> +patternProperties:
> +  "^channel@[0-9]+$":
> +    type: object
> +    properties:
> +      reg:
> +        description: Channel register address
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +      channel-positive:
> +        description: Positive channel assignments
> +        $ref: /schemas/types.yaml#/definitions/uint32

That size seems implausible.  What are the limits. What does
255 mean?

In review of previous version I pointed you at the differential
channel bindings for ADCs.  If they cannot be applied here
explain why in your patch description.

> +      channel-negative:
> +        description: Negative channel assignments
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +    required:
> +      - reg
> +      - channel-positive
> +      - channel-negative
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
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      hx9023s@2a {
> +        compatible = "tyhx,hx9023s";
> +        reg = <0x2a>;
> +        interrupt-parent = <&pio>;
> +        interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
> +        vdd-supply = <&pp1800_prox>;
> +        channel-in-use = <0x1F>;
> +        channel@0 {
> +          reg = <0>;
> +          channel-positive = <0>;
> +          channel-negative = <255>;
> +        };
> +        channel@1 {
> +          reg = <1>;
> +          channel-positive = <1>;
> +          channel-negative = <255>;
> +        };
> +        channel@2 {
> +          reg = <2>;
> +          channel-positive = <2>;
> +          channel-negative = <255>;
> +        };
> +        channel@3 {
> +          reg = <3>;
> +          channel-positive = <3>;
> +          channel-negative = <255>;
> +        };
> +        channel@4 {
> +          reg = <4>;
> +          channel-positive = <4>;
> +          channel-negative = <255>;
> +        };
> +      };
> +    };
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index b97d298b3eb6..e2224eea9ab9 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -1507,6 +1507,8 @@ patternProperties:
>      description: Turing Machines, Inc.
>    "^tyan,.*":
>      description: Tyan Computer Corporation
> +  "^tyhx,.*":
> +    description: NanjingTianyihexin Electronics Ltd.

Use a separate patch for the new vendor prefix.  Makes it easier for people to cherrypick that
if they are backporting some other tyhx dt binding.

>    "^u-blox,.*":
>      description: u-blox
>    "^u-boot,.*":


