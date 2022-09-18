Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20565BBE9F
	for <lists+linux-iio@lfdr.de>; Sun, 18 Sep 2022 17:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiIRPWN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Sep 2022 11:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiIRPWM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Sep 2022 11:22:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3457A186D0
        for <linux-iio@vger.kernel.org>; Sun, 18 Sep 2022 08:22:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CBF60B8104F
        for <linux-iio@vger.kernel.org>; Sun, 18 Sep 2022 15:22:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 869F2C433C1;
        Sun, 18 Sep 2022 15:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663514527;
        bh=ALZrvovsnQY3G8nujPRiUraQQsENtIHSmObAeZtJZAE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JYCXvTByBikrq96it+x2qry92kfxLDV9jqNU54vR2y5LA2e7x2LZk8ffM4Z5IkJGj
         ggesukuNmjGjIlOdzrpDVuZmTL2fsHCgSLnboO3kQPD2qv5KlhVegQs5zw/Mv1wSa/
         sdtavZMM4j3eFdK74wYasAUiRIji0TTnLMWhVyFvIkCjeOb4pk10AKxiHW7nHYTlAA
         0bCS8Qf5rR1M07dO7AhddOHb+3T3MaRu86xsAEHa7ISQ4oYrLunNbTFYL8MPRJLsqg
         96KMKXfLa+TLUQlhzak2EQmz2IGCgh2HmFt50cTZDWFoXi1B5b14MxTL4SH9i6TEw9
         TcB+E8LFmV27g==
Date:   Sun, 18 Sep 2022 16:22:11 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ibrahim Tilki <Ibrahim.Tilki@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <Nuno.Sa@analog.com>,
        <Nurettin.Bolucu@analog.com>
Subject: Re: [PATCH v4 2/3] dt-bindings: iio: adc: add adi,max11410.yaml
Message-ID: <20220918162211.7a5ebdac@jic23-huawei>
In-Reply-To: <20220908144924.205547-3-Ibrahim.Tilki@analog.com>
References: <20220908144924.205547-1-Ibrahim.Tilki@analog.com>
        <20220908144924.205547-3-Ibrahim.Tilki@analog.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 8 Sep 2022 17:49:23 +0300
Ibrahim Tilki <Ibrahim.Tilki@analog.com> wrote:

> Adding devicetree binding documentation for max11410 adc.
> 
> Signed-off-by: Ibrahim Tilki <Ibrahim.Tilki@analog.com>
> ---
>  .../bindings/iio/adc/adi,max11410.yaml        | 174 ++++++++++++++++++
>  1 file changed, 174 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,max11410.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,max11410.yaml b/Documentation/devicetree/bindings/iio/adc/adi,max11410.yaml
> new file mode 100644
> index 000000000..3ffab284b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,max11410.yaml
> @@ -0,0 +1,174 @@
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
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1

Why?  If someone wants to wire both lines, they can do so.
Then it will be up to the driver to pick which one to use.
Given we have names, we will know which is which and be able
to pick our favourite line to use.

> +
> +  interrupt-names:
> +    description: Name of the gpio pin of max11410 used for IRQ
> +    maxItems: 1
> +    items:
> +      enum:
> +        - gpio0
> +        - gpio1
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +  avdd-supply:
> +    description: Necessarry avdd supply. Used as reference when no explicit reference supplied.
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
hmm.

If explicit references are supplied and used, then will we query the voltage
of the avdd supply?  If not, it doesn't need to be supplied. Power is needed
but it might be coming from a fixed regulator no one bothered to put
in the device tree.  Perhaps we just don't care about that corner case?

> +
> +patternProperties:
> +  "^channel(@[0-9a-f]+)?$":

name isn't that flexible as we only allow reg 0-9

> +    $ref: "adc.yaml"
> +    type: object
> +    description: Represents the external channels which are connected to the ADC.
> +
> +    properties:
> +      reg:
> +        description: The channel number in single-ended mode.
> +        minimum: 0
> +        maximum: 9
> +
> +      adi,reference:
> +        description: |
> +          Select the reference source to use when converting on
> +          the specific channel. Valid values are:
> +          0: VREF0P/VREF0N
> +          1: VREF1P/VREF1N
> +          2: VREF2P/VREF2N
> +          3: AVDD/AGND
> +          4: VREF0P/AGND
> +          5: VREF1P/AGND
> +          6: VREF2P/AGND
> +          If this field is left empty, AVDD/AGND is selected.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [0, 1, 2, 3, 4, 5, 6]
> +        default: 3
> +
> +      adi,input-mode:
> +        description: |
> +          Select signal path of input channels. Valid values are:
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

This now needs to use the new spi-peripheral-props.yaml 
https://lore.kernel.org/all/20220816124321.67817-1-krzysztof.kozlowski@linaro.org/

Your series crossed with that cleanup / binding documentation refactor.

> +
> +examples:
> +  - |
> +    spi {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      adc@0 {
> +        reg = <0>;
> +        compatible = "adi,max11410";
> +        spi-max-frequency = <8000000>;
> +
> +        interrupt-parent = <&gpio>;
> +        interrupts = <25 2>;
> +        interrupt-names = "gpio1";
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

