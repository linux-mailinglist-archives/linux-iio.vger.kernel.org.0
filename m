Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDC02A4B97
	for <lists+linux-iio@lfdr.de>; Tue,  3 Nov 2020 17:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbgKCQcl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Nov 2020 11:32:41 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34399 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgKCQcl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 Nov 2020 11:32:41 -0500
Received: by mail-ot1-f65.google.com with SMTP id j14so6305061ots.1;
        Tue, 03 Nov 2020 08:32:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4ZFXeqJlDjuEzXJOuZFRKFCkPZar+wzQqJc5TYJxJDo=;
        b=Wvq/606totpNNBAoZpmxWlATdd0LlQzc1vKMwtxXtJd519MZMsEeF6ryemzLSYsHSN
         9CS/fGizuvdfDQlGD7Ge0wwl0o3gEt0/0C0BNKKe8vRt2z1PSWqQleXPZ8vIWCZklGZY
         /vShvdpbTT/v/sGwTa0Z0hzJ+QJIFqqnQndIXLfEcdOm6wvUr1g+uTkGfURiMJwRuRqJ
         B3878pnsdcDPOG03CvUjKzb6vg6blWYHUPyq9zhGOZXkbK5XWuiMi95jn0vOTvMC5Jhs
         XGo5gV0AQRR6XXrqrNbogW9fBffa0l1YKsflgeHanJtLcJYqpFsNOvZ8AGOahvoZNW/9
         s3Zg==
X-Gm-Message-State: AOAM530h+rblbnHl9D1o4AEsWAJb0LHMe6A6gVi+V1eXsTP5rkBJzQ6s
        Fog/+aSGZwqArGDwNC11AA==
X-Google-Smtp-Source: ABdhPJxKXOJ6HwtkICqDRpMdFRe5I5GwUDL6diOKfCdrdcaHbbS89CioI6kT930GVPTKJESCqZ4RRw==
X-Received: by 2002:a9d:744e:: with SMTP id p14mr16556633otk.135.1604421159265;
        Tue, 03 Nov 2020 08:32:39 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u138sm2291979oie.33.2020.11.03.08.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 08:32:38 -0800 (PST)
Received: (nullmailer pid 1786589 invoked by uid 1000);
        Tue, 03 Nov 2020 16:32:37 -0000
Date:   Tue, 3 Nov 2020 10:32:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sean Nyekjaer <sean.nyekjaer@prevas.dk>
Subject: Re: [PATCH 39/46] dt-bindings:iio:dac:ad5755: txt to yaml format
 conversion.
Message-ID: <20201103163237.GF1754553@bogus>
References: <20201031184854.745828-1-jic23@kernel.org>
 <20201031184854.745828-40-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201031184854.745828-40-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Oct 31, 2020 at 06:48:47PM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Straight forward conversion.  Only fiddly bit is the XOR of
> spi-cpol and spi-cpha.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
> ---
>  .../devicetree/bindings/iio/dac/ad5755.txt    | 124 ------------
>  .../bindings/iio/dac/adi,ad5755.yaml          | 178 ++++++++++++++++++
>  2 files changed, 178 insertions(+), 124 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/ad5755.txt b/Documentation/devicetree/bindings/iio/dac/ad5755.txt
> deleted file mode 100644
> index 502e1e55adbd..000000000000
> --- a/Documentation/devicetree/bindings/iio/dac/ad5755.txt
> +++ /dev/null
> @@ -1,124 +0,0 @@
> -* Analog Devices AD5755 IIO Multi-Channel DAC Linux Driver
> -
> -Required properties:
> - - compatible: Has to contain one of the following:
> -	adi,ad5755
> -	adi,ad5755-1
> -	adi,ad5757
> -	adi,ad5735
> -	adi,ad5737
> -
> - - reg: spi chip select number for the device
> - - spi-cpha or spi-cpol: is the only modes that is supported
> -
> -Recommended properties:
> - - spi-max-frequency: Definition as per
> -		Documentation/devicetree/bindings/spi/spi-bus.txt
> -
> -Optional properties:
> -See include/dt-bindings/iio/ad5755.h
> - - adi,ext-dc-dc-compenstation-resistor: boolean set if the hardware have an
> -					 external resistor and thereby bypasses
> -					 the internal compensation resistor.
> - - adi,dc-dc-phase:
> -	Valid values for DC DC Phase control is:
> -	0: All dc-to-dc converters clock on the same edge.
> -	1: Channel A and Channel B clock on the same edge,
> -	   Channel C and Channel D clock on opposite edges.
> -	2: Channel A and Channel C clock on the same edge,
> -	   Channel B and Channel D clock on opposite edges.
> -	3: Channel A, Channel B, Channel C, and Channel D
> -	   clock 90 degrees out of phase from each other.
> - - adi,dc-dc-freq-hz:
> -	Valid values for DC DC frequency is [Hz]:
> -	250000
> -	410000
> -	650000
> - - adi,dc-dc-max-microvolt:
> -	Valid values for the maximum allowed Vboost voltage supplied by
> -	the dc-to-dc converter is:
> -	23000000
> -	24500000
> -	27000000
> -	29500000
> -
> -Optional for every channel:
> - - adi,mode:
> -	Valid values for DAC modes is:
> -	0: 0 V to 5 V voltage range.
> -	1: 0 V to 10 V voltage range.
> -	2: Plus minus 5 V voltage range.
> -	3: Plus minus 10 V voltage range.
> -	4: 4 mA to 20 mA current range.
> -	5: 0 mA to 20 mA current range.
> -	6: 0 mA to 24 mA current range.
> - - adi,ext-current-sense-resistor: boolean set if the hardware a external
> -				   current sense resistor.
> - - adi,enable-voltage-overrange: boolean enable voltage overrange
> - - adi,slew: Array of slewrate settings should contain 3 fields:
> -	1: Should be either 0 or 1 in order to enable or disable slewrate.
> -	2: Slew rate settings:
> -		Valid values for the slew rate update frequency:
> -		64000
> -		32000
> -		16000
> -		8000
> -		4000
> -		2000
> -		1000
> -		500
> -		250
> -		125
> -		64
> -		32
> -		16
> -		8
> -		4
> -		0
> -	3: Slew step size:
> -		Valid values for the step size LSBs:
> -		1
> -		2
> -		4
> -		16
> -		32
> -		64
> -		128
> -		256
> -
> -Example:
> -dac@0 {
> -	#address-cells = <1>;
> -	#size-cells = <0>;
> -	compatible = "adi,ad5755";
> -	reg = <0>;
> -	spi-max-frequency = <1000000>;
> -	spi-cpha;
> -	adi,dc-dc-phase = <0>;
> -	adi,dc-dc-freq-hz = <410000>;
> -	adi,dc-dc-max-microvolt = <23000000>;
> -	channel@0 {
> -		reg = <0>;
> -		adi,mode = <4>;
> -		adi,ext-current-sense-resistor;
> -		adi,slew = <0 64000 1>;
> -	};
> -	channel@1 {
> -		reg = <1>;
> -		adi,mode = <4>;
> -		adi,ext-current-sense-resistor;
> -		adi,slew = <0 64000 1>;
> -	};
> -	channel@2 {
> -		reg = <2>;
> -		adi,mode = <4>;
> -		adi,ext-current-sense-resistor;
> -		adi,slew = <0 64000 1>;
> -	};
> -	channel@3 {
> -		reg = <3>;
> -		adi,mode = <4>;
> -		adi,ext-current-sense-resistor;
> -		adi,slew = <0 64000 1>;
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5755.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5755.yaml
> new file mode 100644
> index 000000000000..74edff3e8408
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5755.yaml
> @@ -0,0 +1,178 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/dac/adi,ad5755.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD5755 Multi-Channel DAC
> +
> +maintainers:
> +  - Sean Nyekjaer <sean.nyekjaer@prevas.dk>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad5755
> +      - adi,ad5755-1
> +      - adi,ad5757
> +      - adi,ad5735
> +      - adi,ad5737
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-cpha:
> +    description: Either this or spi-cpol but not both.
> +  spi-cpol: true
> +
> +  spi-max-frequency: true
> +
> +  adi,ext-dc-dc-compenstation-resistor:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Set if the hardware have an external resistor and thereby bypasses
> +      the internal compensation resistor.
> +
> +  adi,dc-dc-phase:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2, 3]
> +    description: |
> +      Valid values for DC DC Phase control is:
> +      0: All dc-to-dc converters clock on the same edge.
> +      1: Channel A and Channel B clock on the same edge,
> +         Channel C and Channel D clock on opposite edges.
> +      2: Channel A and Channel C clock on the same edge,
> +         Channel B and Channel D clock on opposite edges.
> +      3: Channel A, Channel B, Channel C, and Channel D
> +         clock 90 degrees out of phase from each other.
> +
> +  adi,dc-dc-freq-hz:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [250000, 410000, 650000]
> +
> +  adi,dc-dc-max-microvolt:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Maximum allowed Vboost voltage supplied by the dc-to-dc converter.
> +    enum: [23000000, 24500000, 27000000, 29500000]
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  "#io-channel-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +patternProperties:
> +  "^(channel@)[0-7]$":
> +    type: object
> +    description: Child node to describe a channel
> +    properties:
> +      reg:
> +        maxItems: 1
> +
> +      adi,mode:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 0
> +        maximum: 6
> +        description: |
> +          Valid values for DAC modes is:
> +          0: 0 V to 5 V voltage range.
> +          1: 0 V to 10 V voltage range.
> +          2: Plus minus 5 V voltage range.
> +          3: Plus minus 10 V voltage range.
> +          4: 4 mA to 20 mA current range.
> +          5: 0 mA to 20 mA current range.
> +          6: 0 mA to 24 mA current range.
> +
> +      adi,ext-current-sense-resistor:
> +        $ref: /schemas/types.yaml#/definitions/flag
> +        description:
> +          Set if the hardware has an external current sense resistor
> +
> +      adi,enable-voltage-overrange:
> +        $ref: /schemas/types.yaml#/definitions/flag
> +        description: Enable voltage overrange
> +
> +      adi,slew:
> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> +        description: |
> +          Array of slewrate settings should contain 3 fields:
> +          1: Should be either 0 or 1 in order to enable or disable slewrate.
> +          2: Slew rate update frequency
> +          3: Slew step size
> +        items:
> +          - enum: [0, 1]
> +          - enum: [64000, 32000, 16000, 8000, 4000, 2000, 1000, 500, 250, 125, 64, 32, 16, 8, 4, 0]
> +          - enum: [1, 2, 4, 16, 32, 64, 128, 256]
> +
> +    required:
> +      - reg
> +
> +    additionalProperties: false
> +
> +allOf:
> +  - $ref: '#/definitions/cpolXORcpha'
> +
> +definitions:
> +  cpolXORcpha:

Like the other one, you can drop 'definitions'.

> +    not:
> +      required: [spi-cpha, spi-cpol]
> +    oneOf:
> +      - required:
> +          - spi-cpha
> +      - required:
> +          - spi-cpol
> +
> +examples:
> +  - |
> +    #include <dt-bindings/iio/adi,ad5592r.h>
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        dac@0 {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            compatible = "adi,ad5755";
> +            reg = <0>;
> +            spi-max-frequency = <1000000>;
> +            spi-cpha;
> +            adi,dc-dc-phase = <0>;
> +            adi,dc-dc-freq-hz = <410000>;
> +            adi,dc-dc-max-microvolt = <23000000>;
> +            channel@0 {
> +                reg = <0>;
> +                adi,mode = <4>;
> +                adi,ext-current-sense-resistor;
> +                adi,slew = <0 64000 1>;
> +            };
> +            channel@1 {
> +                reg = <1>;
> +                adi,mode = <4>;
> +                adi,ext-current-sense-resistor;
> +                adi,slew = <0 64000 1>;
> +            };
> +            channel@2 {
> +                reg = <2>;
> +                adi,mode = <4>;
> +                adi,ext-current-sense-resistor;
> +                adi,slew = <0 64000 1>;
> +            };
> +            channel@3 {
> +                reg = <3>;
> +                adi,mode = <4>;
> +                adi,ext-current-sense-resistor;
> +                adi,slew = <0 64000 1>;
> +            };
> +        };
> +    };
> +...
> -- 
> 2.28.0
> 
