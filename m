Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA83592353
	for <lists+linux-iio@lfdr.de>; Sun, 14 Aug 2022 18:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240539AbiHNQHQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Aug 2022 12:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240558AbiHNQHD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 Aug 2022 12:07:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0BA12D1D
        for <linux-iio@vger.kernel.org>; Sun, 14 Aug 2022 08:45:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7CA8DB80B43
        for <linux-iio@vger.kernel.org>; Sun, 14 Aug 2022 15:45:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D65D4C433D6;
        Sun, 14 Aug 2022 15:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660491925;
        bh=udPXSbnjJFZ5XlYCsq72JifrzpccfF6ZOhTEKyVv1qQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qoJuoTLbY8gUCm8kHIVcZ/Q4PdNTll08STpB9cxUly+XtZvaxyiuc/Tvz3NPucpKi
         vYy7bhU4H9z8aQjcsrGS72j2E69T7caNXuQceKAmg+30v9QTFjCrAs8cE+MdSJl2z0
         d+FZn1s8BADR0k3Bxi1RPAnMk//YHD8aYyCN/BmEGZqEeGjgQAt63P405Qwy4YvsJT
         XQ0xB+k8Pj6IsSQ0gAkPj4xCUb6fYv9XGLA5Kdzvq7251zUJqbSBlHaOBSuggGr+Gi
         VaX4xz8OuXixyyLAwu5x1Dn6XMGyq2nGo5Hpa6lyErPW1uQw5TgD8T6Dkpy+fVUu3r
         TIxO+HrG1tMLg==
Date:   Sun, 14 Aug 2022 16:55:54 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ibrahim Tilki <Ibrahim.Tilki@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <Nuno.Sa@analog.com>,
        <Nurettin.Bolucu@analog.com>
Subject: Re: [PATCH v3 2/2] dt-bindings: iio: adc: add adi,max11410.yaml
Message-ID: <20220814165554.4dabd716@jic23-huawei>
In-Reply-To: <20220811134243.111-3-Ibrahim.Tilki@analog.com>
References: <20220811134243.111-1-Ibrahim.Tilki@analog.com>
        <20220811134243.111-3-Ibrahim.Tilki@analog.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 11 Aug 2022 13:42:43 +0000
Ibrahim Tilki <Ibrahim.Tilki@analog.com> wrote:

> Adding devicetree binding documentation for max11410 adc.
> 
> Signed-off-by: Ibrahim Tilki <Ibrahim.Tilki@analog.com>
> Reviewed-by: Nurettin Bolucu <Nurettin.Bolucu@analog.com>

As a general rule, prefer to see review on list.
Whilst Analog folk are usually good at doing reviews properly some other companies have been
known to add reviewed-by tags without doing a proper job of review.  Hence we prefer
to hear from the reviewer on the public list if possible, even if it's a quick
note to say what sort of review they have done (general correctness / check against
datasheet / detailed subsystem interaction review etc) as that reduces the focus others
may put on the same areas.

I regularly do this wrong in Huawei code btw as we still do more review before posting
than we perhaps should :)

A few comments inline. Biggest is the interrupts description needing to be more
general to avoid us having problems if we extend it in future to cover the other
possible pin.

> ---
>  .../bindings/iio/adc/adi,max11410.yaml        | 165 ++++++++++++++++++
>  1 file changed, 165 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,max11410.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,max11410.yaml b/Documentation/devicetree/bindings/iio/adc/adi,max11410.yaml
> new file mode 100644
> index 000000000..a782bfcaf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,max11410.yaml
> @@ -0,0 +1,165 @@
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

There are at least two possible pins, so this binding needs to take into account which
one / ones are wired.  Hence you need interrupt-names and the driver
needs to route things appropriately or at very least give a clear 'I don't support
GPIO0 usage' error message.

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

the @ address seems to allow more than 0 to 10. Perhaps need to bring those inline and
make them both hex?  Curious. What's the 11th channel if max isn't 9?

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
> +          Select signal path of input channels. When PGA path is selected,
> +          hardwaregain property is enabled for channel. Valid values are:

A binding should not mention details of what the linux driver is doing, so drop
that bit about hardwaregain.  Whilst bindings exist in the Linux tree they
are used by various other bits of software.

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

