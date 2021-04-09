Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8E0335A110
	for <lists+linux-iio@lfdr.de>; Fri,  9 Apr 2021 16:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbhDIOa5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Apr 2021 10:30:57 -0400
Received: from mail-oi1-f171.google.com ([209.85.167.171]:43563 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbhDIOa4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Apr 2021 10:30:56 -0400
Received: by mail-oi1-f171.google.com with SMTP id n8so5919495oie.10;
        Fri, 09 Apr 2021 07:30:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cckdCKJqTzn6NoGTBGUXOb91sxP0LYR144qiSY0LF6w=;
        b=VmdvBEEVwcsJJ6uFm2EwnZhwd4+PN6K7db2Ae32zVFdP3yM4XU2iL5EjFimbiJG7eC
         H9XNEuwmGWXAQigw7FORRmnfZcqoh4A6a/qDjAAJhZpgCxZrkr2zgjStok5XMXvP253H
         C8BwpL/cTDoVWfqReX4G7/WscMadLwfNeGYBRwOQ+mHH4w7ftrqtV92AmYaXlTkbV7Jq
         89z80nN3Yq2ul0FGju8GgLuUnxJgG5DHqj7awX1EmrGT4yvJE4Egwx0CvwtYWJ7xCaXT
         zu+uCVaVQfMu3sBq54ShNRbal5ZqvOdlWHb9U0G+UX1w3IgMBkpEY+YU/T79AlXuFegJ
         7PMg==
X-Gm-Message-State: AOAM530FdR59bcHJe2559IVY9ulEnRAM/RH3Knj7uT5VgMlnsGd9DRZx
        w/SnwCwZ7Ho1qvBynxWkiw==
X-Google-Smtp-Source: ABdhPJxq5vzuzafroWkkBiU4YDT3MmF1vqObvg16Avjfu0OCwfHLBcHwFDSqun58QgTCxFZcJYYapw==
X-Received: by 2002:a54:450c:: with SMTP id l12mr10349070oil.133.1617978642952;
        Fri, 09 Apr 2021 07:30:42 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f8sm614767otp.71.2021.04.09.07.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 07:30:41 -0700 (PDT)
Received: (nullmailer pid 3605100 invoked by uid 1000);
        Fri, 09 Apr 2021 14:30:40 -0000
Date:   Fri, 9 Apr 2021 09:30:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sean Nyekjaer <sean.nyekjaer@prevas.dk>
Subject: Re: [PATCH 1/2] dt-bindings:iio:dac:ad5755: txt to yaml format
 conversion.
Message-ID: <20210409143040.GA3600252@robh.at.kernel.org>
References: <20210401140956.224084-1-jic23@kernel.org>
 <20210401140956.224084-2-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401140956.224084-2-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Apr 01, 2021 at 03:09:55PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Straight forward conversion.  Only fiddly bit is the XOR of
> spi-cpol and spi-cpha.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
> Link: https://lore.kernel.org/r/20201031184854.745828-40-jic23@kernel.org
> ---
>  .../devicetree/bindings/iio/dac/ad5755.txt    | 124 -------------
>  .../bindings/iio/dac/adi,ad5755.yaml          | 171 ++++++++++++++++++
>  2 files changed, 171 insertions(+), 124 deletions(-)


> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5755.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5755.yaml
> new file mode 100644
> index 000000000000..5d6a87f28b12
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5755.yaml
> @@ -0,0 +1,171 @@
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

Don't need a type ref.

> +    enum: [250000, 410000, 650000]
> +
> +  adi,dc-dc-max-microvolt:
> +    $ref: /schemas/types.yaml#/definitions/uint32

Don't need a type ref.

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

Don't need ().

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
> +oneOf:
> +  - required:
> +      - spi-cpha
> +  - required:
> +      - spi-cpol
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
> 2.31.1
> 
