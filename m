Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026486AAB73
	for <lists+linux-iio@lfdr.de>; Sat,  4 Mar 2023 18:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjCDRKF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Mar 2023 12:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjCDRKF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Mar 2023 12:10:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF9113510;
        Sat,  4 Mar 2023 09:10:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BBC33B8085B;
        Sat,  4 Mar 2023 17:10:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C3CC433D2;
        Sat,  4 Mar 2023 17:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677949801;
        bh=NrlHNbC0RBF/brfBYIQ1V0X3Mby6WLA9TCmdFEMGJzk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cnUz6wY4IY2OIdskNR8GlA/BKXzWYIKitsEmYEsPzCqZPsCYI7JM7Xffhj8pGMhCS
         dsOhjm3CGtp9SqsVQuxj1xSX01cbepdvnZOR6cK83g9VrPHSJry+XZg9T/58hmbP+3
         eiFnNOskVtCLz1FZaP7diqSJ8EPXPiYK3JtG9WPx9omSeRAQw+OPXqTawtMfMKT279
         4+kolmxS79iTLX1GcNVHKofFo7Iu0ZF8YsdhSwG1G4Kb06fS+PG6CP/sY2kjZ1rls0
         OrQkKnlDqUa4x+r0foIabK5nY9+IfcXF74I687fJM80Y02nV9FF4IaJxfx8Kn+CKRU
         Ep/+C+tchSySA==
Date:   Sat, 4 Mar 2023 17:09:57 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrew Hepp <andrew.hepp@ahepp.dev>
Cc:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: Add MCP9600 thermocouple EMF
 converter bindings
Message-ID: <20230304170957.4748bf10@jic23-huawei>
In-Reply-To: <20230304004109.78659-1-andrew.hepp@ahepp.dev>
References: <20230304004109.78659-1-andrew.hepp@ahepp.dev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
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

On Fri,  3 Mar 2023 16:41:08 -0800
Andrew Hepp <andrew.hepp@ahepp.dev> wrote:

> Add support for the MCP9600 thermocouple EMF converter.
> 
> Datasheet: https://ww1.microchip.com/downloads/en/DeviceDoc/MCP960X-Data-Sheet-20005426.pdf
> Signed-off-by: Andrew Hepp <andrew.hepp@ahepp.dev>
> ---
> Changes for v3:
> - Added dt-bindings
> ---
>  .../iio/temperature/microchip,mcp9600.yaml    | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml b/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml
> new file mode 100644
> index 000000000000..584d0ae42502
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml
> @@ -0,0 +1,72 @@
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
> +description: |
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
> +        - open

Perhaps make it more explicit?  open-circuit

> +        - short

Same here? short-circuit

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
> +  vdd-supply:
> +    description: Regulator that provides power to the sensor.

I'd count that one as so common it doesn't need a description.
    vdd-supply: true

would be sufficient.



> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/iio/temperature/thermocouple.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        mcp9600@60 {
> +            compatible = "microchip,mcp9600";
> +            reg = <0x60>;
> +            interrupt-parent = <&gpio>;
> +            interrupts = <25 IRQ_TYPE_EDGE_RISING>;
> +            interrupt-names = "open";
> +            thermocouple-type = <THERMOCOUPLE_TYPE_K>;
> +            vdd-supply = <&vdd>;
> +        };
> +    };

