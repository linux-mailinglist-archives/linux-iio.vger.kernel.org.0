Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951EB56A70F
	for <lists+linux-iio@lfdr.de>; Thu,  7 Jul 2022 17:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235231AbiGGPib (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 7 Jul 2022 11:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235202AbiGGPia (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 7 Jul 2022 11:38:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3689DF33
        for <linux-iio@vger.kernel.org>; Thu,  7 Jul 2022 08:38:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A0D06234A
        for <linux-iio@vger.kernel.org>; Thu,  7 Jul 2022 15:38:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50216C3411E;
        Thu,  7 Jul 2022 15:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657208307;
        bh=K5aXsxT2z+KpdHQh2SHkwoJHq6gOy+YsgyFwF1XU4gU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZihBTJWh/Kdp9Apiz4oQMlTrLtWyvZVYb+mL0Dok6486zrWwqKEG7YwkmFeRutlIC
         UTJgycBttXGCOgzQqvETHDKgAt5jz+lQoK2CiBXVbqHT3C3021TqpUBDbh5cRhQ+rR
         qnZUbXL9DFcViGp5tQK5pPZi/e6Db/jMjWMyU9DW6bLuWSezvUfCqXSjzQeMWF+skR
         00tdo3rcoBB/yXJnW39xt2HD5gJUv7XeW1wYx9STX06XrLnLl2Fh7mCHmB+ncfvGAL
         oy2oh3soV7t7lprDEIvQCPdJv+0dLrJ2EP33rjDODKrUij9lPDTeowqlThrQctUOm5
         k8c9HSYDyRlwA==
Date:   Thu, 7 Jul 2022 16:48:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ibrahim Tilki <Ibrahim.Tilki@analog.com>
Cc:     <andy.shevchenko@gmail.com>, <linux-iio@vger.kernel.org>,
        <Nuno.Sa@analog.com>, <Nurettin.Bolucu@analog.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: iio: adc: add adi,max11410.yaml
Message-ID: <20220707164810.7811fbb0@jic23-huawei>
In-Reply-To: <20220707083126.181-3-Ibrahim.Tilki@analog.com>
References: <20220707083126.181-1-Ibrahim.Tilki@analog.com>
        <20220707083126.181-3-Ibrahim.Tilki@analog.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 7 Jul 2022 08:31:26 +0000
Ibrahim Tilki <Ibrahim.Tilki@analog.com> wrote:

> Adding devicetree binding documentation for max11410 adc.
> 
> Signed-off-by: Ibrahim Tilki <Ibrahim.Tilki@analog.com>
> Reviewed-by: Nurettin Bolucu <Nurettin.Bolucu@analog.com>

Hi.

A few questions inline. Mostly stuff I couldn't figure out from a quick
scan through the datasheet.

> ---
>  .../bindings/iio/adc/adi,max11410.yaml        | 168 ++++++++++++++++++
>  1 file changed, 168 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,max11410.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,max11410.yaml b/Documentation/devicetree/bindings/iio/adc/adi,max11410.yaml
> new file mode 100644
> index 000000000..f28d29fb2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,max11410.yaml
> @@ -0,0 +1,168 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2022 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,max11410.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices MAX11410 ADC device driver
> +
> +maintainers:
> +  - Ibrahim Tilki <ibrahim.tilki@analog.com>
> +
> +description: |
> +  Bindings for the Analog Devices MAX11410 ADC device. Datasheet can be
> +  found here:
> +    https://datasheets.maximintegrated.com/en/ds/MAX11410.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,max11410
> +
> +  reg:
> +    description: SPI chip select number for the device

Description not needed as same for all SPI devices.

> +    maxItems: 1
> +
> +  interrupts:
> +    description: IRQ line for the ADC
The description doesn't tell us anything so drop it.
There is no need to provide description lines for self documenting
items like this.
> +    maxItems: 1
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +  avdd-supply:
> +    description: avdd supply can be used as reference for conversion.

Mention it's also a necessary power supply.  As mentioned in driver review
I'd suggest you actually treat this as 'no explicit reference supplied'.
That simplifies the meaning of the adi,reference below.

> +
> +  vref0p-supply:
> +    description: vref0p supply can be used as reference for conversion.
> +
> +  vref1p-supply:
> +    description: vref1p supply can be used as reference for conversion.
> +
> +  vref2p-supply:
> +    description: vref2p supply can be used as reference for conversion.
> +
> +  vref0n-supply:
> +    description: vref0n supply can be used as reference for conversion.
> +
> +  vref1n-supply:
> +    description: vref1n supply can be used as reference for conversion.
> +
> +  vref2n-supply:
> +    description: vref2n supply can be used as reference for conversion.
> +
> +  spi-max-frequency:
> +    maximum: 8000000
> +
> +required:
> +  - compatible
> +  - reg
> +  - avdd-supply
> +
> +patternProperties:
> +  "^channel(@[0-9a-f]+)?$":
> +    $ref: "adc.yaml"
> +    type: object
> +    description: Represents the external channels which are connected to the ADC.
> +
> +    properties:
> +      reg:
> +        description: The channel number in single-ended mode.
> +        minimum: 0
> +        maximum: 10
> +
> +      adi,reference:
> +        description: |
> +          Select the reference source to use when converting on
> +          the specific channel. Valid values are:
> +          0: REF0P/REF0N

VREF0P etc to match namign above.

> +          1: REF1P/REF1N
> +          2: REF2P/REF2N
> +          3: AVDD/AGND
> +          4: REF0P/AGND
> +          5: REF1P/AGND
> +          6: REF2P/AGND

Is it valid to use REF0P/AGND for a differential channel?  If not
I would reduce this list to 0-2 only.  If it is valid (so actually
useful to do so) then we are stuck with this.  That does make me wonder
if there is a difference between 3 and 7?  If not, just don't list 7

> +          7: AVDD/AGND
> +          If this field is left empty, AVDD/AGND is selected.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [0, 1, 2, 3, 4, 5, 6, 7]
> +        default: 7
> +
> +      adi,input-mode:
> +        description: |
> +          Select signal path of input channels. When PGA path is selected,
> +          hardwaregain property is enabled for channel. Valid values are:
> +          0: Buffered, low-power, unity-gain path (default)
> +          1: Bypass path
> +          2: PGA path
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [0, 1, 2]
> +        default: 0
> +
> +      diff-channels: true
> +
> +      bipolar: true
> +
> +      settling-time-us: true
> +
> +      adi,buffered-vrefp:
> +        description: Enable buffered mode for positive reference.
> +        type: boolean
> +
> +      adi,buffered-vrefn:
> +        description: Enable buffered mode for negative reference.
> +        type: boolean
> +
> +    required:
> +      - reg
> +
> +    additionalProperties: false
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      adc@0 {
> +        compatible = "adi,max11410";
> +        reg = <0>;
> +        spi-max-frequency = <8000000>;
> +        interrupts = <25 2>;
> +        interrupt-parent = <&gpio>;
> +
> +        avdd-supply = <&adc_avdd>;
> +
> +        vref1p-supply = <&adc_vref1p>;
> +        vref1n-supply = <&adc_vref1n>;
> +
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        channel@0 {
> +          reg = <0>;
> +        };
> +
> +        channel@1 {
> +          reg = <1>;
> +          diff-channels = <2 3>;
> +          adi,reference = <1>;
> +          bipolar;
> +          settling-time-us = <100000>;
> +        };
> +
> +        channel@2 {
> +          reg = <2>;
> +          diff-channels = <7 9>;
> +          adi,reference = <5>;
> +          adi,input-mode = <2>;
> +          settling-time-us = <50000>;
> +        };
> +      };
> +    };

