Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B237DA729
	for <lists+linux-iio@lfdr.de>; Sat, 28 Oct 2023 15:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbjJ1NUZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Oct 2023 09:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjJ1NUY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 Oct 2023 09:20:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56984E0
        for <linux-iio@vger.kernel.org>; Sat, 28 Oct 2023 06:20:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A628EC433C8;
        Sat, 28 Oct 2023 13:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698499221;
        bh=HMIbKdE+7pP6FjaD+r0mc7H7tiphE1xO2v7OzEIp3bE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KMrpCxX5khDM78I/Q2a68w9M1v5VDnWWysfUZsUFmCCApnKa072llcSj0wNzmb2Fa
         ABoq7p1gfjL5wgGu2HiamEVsjdhNnov/UO9RgTbZZl9venQKWvoPSCIDhSP5WhzPVo
         A6Cy/n/b9zMRcrrcyZAJ7aX1URAT/DA02ko3VCdMOLJMOO0fl/38yP8ntXNMG9S5v8
         qPDPA43YevvS9pmxWQIA7UUjogYnHgNuIcVweJFTyVxjWjeE5FmOkJjeZobgnsboEv
         7RBG/g/EY6szhkGbCNFHVdYvXNR4ZPdBATy4K0DvzwhFaKpYTngGfbDCabSyMXG4ac
         HN3SgqImUpfIw==
Date:   Sat, 28 Oct 2023 14:19:48 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrew Hepp <andrew.hepp@ahepp.dev>
Cc:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [v7,PATCH 1/2] dt-bindings: iio: Add MCP9600 thermocouple EMF
 converter
Message-ID: <20231028141948.5ec4b542@jic23-huawei>
In-Reply-To: <20231025233153.5454-1-andrew.hepp@ahepp.dev>
References: <20231025233153.5454-1-andrew.hepp@ahepp.dev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 25 Oct 2023 16:31:52 -0700
Andrew Hepp <andrew.hepp@ahepp.dev> wrote:

> Add support for the MCP9600 thermocouple electromotive force converter. The sensor has  integrated cold junction compensation and a typical accuracy of 0.5 degrees Celsius. The driver supports a resolution of 0.0625 degrees Celsius.
> 
> Datasheet: https://ww1.microchip.com/downloads/en/DeviceDoc/MCP960X-Data-Sheet-20005426.pdf
> Signed-off-by: Andrew Hepp <andrew.hepp@ahepp.dev>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Hi Andrew,

Series applied to the togreg branch of iio.git.
I will be rebasing that tree once rc1 is out in a few weeks time
so in the meantime I will only push this out as testing for 0-day to take
a look at it and see if we missed anything,

Thanks,

Jonathan

> ---
> Changes for v7:
> - none
> Changes for v6:
> - none
> Changes for v5:
> - remove "bindings" from subject
> - change unevaluatedProperties to additionalProperties
> Changes for v4:
> - use descriptive names for open/short circuit interrupts
> - remove vdd regulator description
> - remove unused import
> - use generic sensor name in example
> - don't use literal style for doc description
> Changes for v3:
> - Added dt-bindings
> ---
>  .../iio/temperature/microchip,mcp9600.yaml    | 70 +++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml b/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml
> new file mode 100644
> index 000000000000..d2cafa38a544
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml
> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/temperature/microchip,mcp9600.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip MCP9600 thermocouple EMF converter
> +
> +maintainers:
> +  - Andrew Hepp <andrew.hepp@ahepp.dev>
> +
> +description:
> +  https://ww1.microchip.com/downloads/en/DeviceDoc/MCP960X-Data-Sheet-20005426.pdf
> +
> +properties:
> +  compatible:
> +    const: microchip,mcp9600
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 6
> +
> +  interrupt-names:
> +    minItems: 1
> +    maxItems: 6
> +    items:
> +      enum:
> +        - open-circuit
> +        - short-circuit
> +        - alert1
> +        - alert2
> +        - alert3
> +        - alert4
> +
> +  thermocouple-type:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Type of thermocouple (THERMOCOUPLE_TYPE_K if omitted).
> +      Use defines in dt-bindings/iio/temperature/thermocouple.h.
> +      Supported types are B, E, J, K, N, R, S, T.
> +
> +  vdd-supply: true
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/iio/temperature/thermocouple.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        temperature-sensor@60 {
> +            compatible = "microchip,mcp9600";
> +            reg = <0x60>;
> +            interrupt-parent = <&gpio>;
> +            interrupts = <25 IRQ_TYPE_EDGE_RISING>;
> +            interrupt-names = "open-circuit";
> +            thermocouple-type = <THERMOCOUPLE_TYPE_K>;
> +            vdd-supply = <&vdd>;
> +        };
> +    };

