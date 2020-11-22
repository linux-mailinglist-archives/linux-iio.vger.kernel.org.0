Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7862BC843
	for <lists+linux-iio@lfdr.de>; Sun, 22 Nov 2020 19:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbgKVSk6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Nov 2020 13:40:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:46322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727897AbgKVSk6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 22 Nov 2020 13:40:58 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 305BB20760;
        Sun, 22 Nov 2020 18:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606070457;
        bh=9aviTWAMtKwai0TwW1wWxOJB0xevd5k1cmDQT+zvuOA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Z/F+lMDfvfhp/fuwUFoeOldmwJBLEoleTs0FHJdiutb2D+W3640bZ9EVM9S9dwxM0
         8RiJes2ks3VPzlDA4COWAJZDLfiwY6e6YP7EkX4CCXjylCIIPLtp/RvdoTKrtEKurb
         0rpj3NzfpDM9gRn4T75eqqGSlkE6BqQYcInDqmh8=
Date:   Sun, 22 Nov 2020 18:40:52 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sean Nyekjaer <sean.nyekjaer@prevas.dk>
Subject: Re: [PATCH 39/46] dt-bindings:iio:dac:ad5755: txt to yaml format
 conversion.
Message-ID: <20201122184052.141efda6@archlinux>
In-Reply-To: <20201103163237.GF1754553@bogus>
References: <20201031184854.745828-1-jic23@kernel.org>
        <20201031184854.745828-40-jic23@kernel.org>
        <20201103163237.GF1754553@bogus>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 3 Nov 2020 10:32:37 -0600
Rob Herring <robh@kernel.org> wrote:

> On Sat, Oct 31, 2020 at 06:48:47PM +0000, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Straight forward conversion.  Only fiddly bit is the XOR of
> > spi-cpol and spi-cpha.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
> > ---
> >  .../devicetree/bindings/iio/dac/ad5755.txt    | 124 ------------
> >  .../bindings/iio/dac/adi,ad5755.yaml          | 178 ++++++++++++++++++
> >  2 files changed, 178 insertions(+), 124 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/dac/ad5755.txt b/Documentation/devicetree/bindings/iio/dac/ad5755.txt
> > deleted file mode 100644
> > index 502e1e55adbd..000000000000
> > --- a/Documentation/devicetree/bindings/iio/dac/ad5755.txt
> > +++ /dev/null
> > @@ -1,124 +0,0 @@
> > -* Analog Devices AD5755 IIO Multi-Channel DAC Linux Driver
> > -
> > -Required properties:
> > - - compatible: Has to contain one of the following:
> > -	adi,ad5755
> > -	adi,ad5755-1
> > -	adi,ad5757
> > -	adi,ad5735
> > -	adi,ad5737
> > -
> > - - reg: spi chip select number for the device
> > - - spi-cpha or spi-cpol: is the only modes that is supported
> > -
> > -Recommended properties:
> > - - spi-max-frequency: Definition as per
> > -		Documentation/devicetree/bindings/spi/spi-bus.txt
> > -
> > -Optional properties:
> > -See include/dt-bindings/iio/ad5755.h
> > - - adi,ext-dc-dc-compenstation-resistor: boolean set if the hardware have an
> > -					 external resistor and thereby bypasses
> > -					 the internal compensation resistor.
> > - - adi,dc-dc-phase:
> > -	Valid values for DC DC Phase control is:
> > -	0: All dc-to-dc converters clock on the same edge.
> > -	1: Channel A and Channel B clock on the same edge,
> > -	   Channel C and Channel D clock on opposite edges.
> > -	2: Channel A and Channel C clock on the same edge,
> > -	   Channel B and Channel D clock on opposite edges.
> > -	3: Channel A, Channel B, Channel C, and Channel D
> > -	   clock 90 degrees out of phase from each other.
> > - - adi,dc-dc-freq-hz:
> > -	Valid values for DC DC frequency is [Hz]:
> > -	250000
> > -	410000
> > -	650000
> > - - adi,dc-dc-max-microvolt:
> > -	Valid values for the maximum allowed Vboost voltage supplied by
> > -	the dc-to-dc converter is:
> > -	23000000
> > -	24500000
> > -	27000000
> > -	29500000
> > -
> > -Optional for every channel:
> > - - adi,mode:
> > -	Valid values for DAC modes is:
> > -	0: 0 V to 5 V voltage range.
> > -	1: 0 V to 10 V voltage range.
> > -	2: Plus minus 5 V voltage range.
> > -	3: Plus minus 10 V voltage range.
> > -	4: 4 mA to 20 mA current range.
> > -	5: 0 mA to 20 mA current range.
> > -	6: 0 mA to 24 mA current range.
> > - - adi,ext-current-sense-resistor: boolean set if the hardware a external
> > -				   current sense resistor.
> > - - adi,enable-voltage-overrange: boolean enable voltage overrange
> > - - adi,slew: Array of slewrate settings should contain 3 fields:
> > -	1: Should be either 0 or 1 in order to enable or disable slewrate.
> > -	2: Slew rate settings:
> > -		Valid values for the slew rate update frequency:
> > -		64000
> > -		32000
> > -		16000
> > -		8000
> > -		4000
> > -		2000
> > -		1000
> > -		500
> > -		250
> > -		125
> > -		64
> > -		32
> > -		16
> > -		8
> > -		4
> > -		0
> > -	3: Slew step size:
> > -		Valid values for the step size LSBs:
> > -		1
> > -		2
> > -		4
> > -		16
> > -		32
> > -		64
> > -		128
> > -		256
> > -
> > -Example:
> > -dac@0 {
> > -	#address-cells = <1>;
> > -	#size-cells = <0>;
> > -	compatible = "adi,ad5755";
> > -	reg = <0>;
> > -	spi-max-frequency = <1000000>;
> > -	spi-cpha;
> > -	adi,dc-dc-phase = <0>;
> > -	adi,dc-dc-freq-hz = <410000>;
> > -	adi,dc-dc-max-microvolt = <23000000>;
> > -	channel@0 {
> > -		reg = <0>;
> > -		adi,mode = <4>;
> > -		adi,ext-current-sense-resistor;
> > -		adi,slew = <0 64000 1>;
> > -	};
> > -	channel@1 {
> > -		reg = <1>;
> > -		adi,mode = <4>;
> > -		adi,ext-current-sense-resistor;
> > -		adi,slew = <0 64000 1>;
> > -	};
> > -	channel@2 {
> > -		reg = <2>;
> > -		adi,mode = <4>;
> > -		adi,ext-current-sense-resistor;
> > -		adi,slew = <0 64000 1>;
> > -	};
> > -	channel@3 {
> > -		reg = <3>;
> > -		adi,mode = <4>;
> > -		adi,ext-current-sense-resistor;
> > -		adi,slew = <0 64000 1>;
> > -	};
> > -};
> > diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5755.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5755.yaml
> > new file mode 100644
> > index 000000000000..74edff3e8408
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5755.yaml
> > @@ -0,0 +1,178 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/dac/adi,ad5755.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices AD5755 Multi-Channel DAC
> > +
> > +maintainers:
> > +  - Sean Nyekjaer <sean.nyekjaer@prevas.dk>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,ad5755
> > +      - adi,ad5755-1
> > +      - adi,ad5757
> > +      - adi,ad5735
> > +      - adi,ad5737
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  spi-cpha:
> > +    description: Either this or spi-cpol but not both.
> > +  spi-cpol: true
> > +
> > +  spi-max-frequency: true
> > +
> > +  adi,ext-dc-dc-compenstation-resistor:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description:
> > +      Set if the hardware have an external resistor and thereby bypasses
> > +      the internal compensation resistor.
> > +
> > +  adi,dc-dc-phase:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [0, 1, 2, 3]
> > +    description: |
> > +      Valid values for DC DC Phase control is:
> > +      0: All dc-to-dc converters clock on the same edge.
> > +      1: Channel A and Channel B clock on the same edge,
> > +         Channel C and Channel D clock on opposite edges.
> > +      2: Channel A and Channel C clock on the same edge,
> > +         Channel B and Channel D clock on opposite edges.
> > +      3: Channel A, Channel B, Channel C, and Channel D
> > +         clock 90 degrees out of phase from each other.
> > +
> > +  adi,dc-dc-freq-hz:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [250000, 410000, 650000]
> > +
> > +  adi,dc-dc-max-microvolt:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      Maximum allowed Vboost voltage supplied by the dc-to-dc converter.
> > +    enum: [23000000, 24500000, 27000000, 29500000]
> > +
> > +  "#address-cells":
> > +    const: 1
> > +
> > +  "#size-cells":
> > +    const: 0
> > +
> > +  "#io-channel-cells":
> > +    const: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +patternProperties:
> > +  "^(channel@)[0-7]$":
> > +    type: object
> > +    description: Child node to describe a channel
> > +    properties:
> > +      reg:
> > +        maxItems: 1
> > +
> > +      adi,mode:
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        minimum: 0
> > +        maximum: 6
> > +        description: |
> > +          Valid values for DAC modes is:
> > +          0: 0 V to 5 V voltage range.
> > +          1: 0 V to 10 V voltage range.
> > +          2: Plus minus 5 V voltage range.
> > +          3: Plus minus 10 V voltage range.
> > +          4: 4 mA to 20 mA current range.
> > +          5: 0 mA to 20 mA current range.
> > +          6: 0 mA to 24 mA current range.
> > +
> > +      adi,ext-current-sense-resistor:
> > +        $ref: /schemas/types.yaml#/definitions/flag
> > +        description:
> > +          Set if the hardware has an external current sense resistor
> > +
> > +      adi,enable-voltage-overrange:
> > +        $ref: /schemas/types.yaml#/definitions/flag
> > +        description: Enable voltage overrange
> > +
> > +      adi,slew:
> > +        $ref: /schemas/types.yaml#/definitions/uint32-array
> > +        description: |
> > +          Array of slewrate settings should contain 3 fields:
> > +          1: Should be either 0 or 1 in order to enable or disable slewrate.
> > +          2: Slew rate update frequency
> > +          3: Slew step size
> > +        items:
> > +          - enum: [0, 1]
> > +          - enum: [64000, 32000, 16000, 8000, 4000, 2000, 1000, 500, 250, 125, 64, 32, 16, 8, 4, 0]
> > +          - enum: [1, 2, 4, 16, 32, 64, 128, 256]
> > +
> > +    required:
> > +      - reg
> > +
> > +    additionalProperties: false
> > +
> > +allOf:
> > +  - $ref: '#/definitions/cpolXORcpha'
> > +
> > +definitions:
> > +  cpolXORcpha:  
> 
> Like the other one, you can drop 'definitions'.

As replied to the other one I can't figure out a syntax that allows me to
do that.

Get an issues along the lines of

... iio/dac/ti,dac082s085.yaml: allOf:0: 'not' is not one of ['$ref', 'if', 'then', 'else']

(obviously that's form the other driver that does this).

Any suggestions much appreciated!

Thanks,

Jonathan


> 
> > +    not:
> > +      required: [spi-cpha, spi-cpol]
> > +    oneOf:
> > +      - required:
> > +          - spi-cpha
> > +      - required:
> > +          - spi-cpol
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/iio/adi,ad5592r.h>
> > +    spi {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        dac@0 {
> > +            #address-cells = <1>;
> > +            #size-cells = <0>;
> > +            compatible = "adi,ad5755";
> > +            reg = <0>;
> > +            spi-max-frequency = <1000000>;
> > +            spi-cpha;
> > +            adi,dc-dc-phase = <0>;
> > +            adi,dc-dc-freq-hz = <410000>;
> > +            adi,dc-dc-max-microvolt = <23000000>;
> > +            channel@0 {
> > +                reg = <0>;
> > +                adi,mode = <4>;
> > +                adi,ext-current-sense-resistor;
> > +                adi,slew = <0 64000 1>;
> > +            };
> > +            channel@1 {
> > +                reg = <1>;
> > +                adi,mode = <4>;
> > +                adi,ext-current-sense-resistor;
> > +                adi,slew = <0 64000 1>;
> > +            };
> > +            channel@2 {
> > +                reg = <2>;
> > +                adi,mode = <4>;
> > +                adi,ext-current-sense-resistor;
> > +                adi,slew = <0 64000 1>;
> > +            };
> > +            channel@3 {
> > +                reg = <3>;
> > +                adi,mode = <4>;
> > +                adi,ext-current-sense-resistor;
> > +                adi,slew = <0 64000 1>;
> > +            };
> > +        };
> > +    };
> > +...
> > -- 
> > 2.28.0
> >   

