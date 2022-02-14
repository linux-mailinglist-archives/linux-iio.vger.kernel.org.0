Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8661C4B5D0F
	for <lists+linux-iio@lfdr.de>; Mon, 14 Feb 2022 22:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiBNVl2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Feb 2022 16:41:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbiBNVl1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Feb 2022 16:41:27 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345491732DB
        for <linux-iio@vger.kernel.org>; Mon, 14 Feb 2022 13:41:19 -0800 (PST)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 11CC43F1E8
        for <linux-iio@vger.kernel.org>; Mon, 14 Feb 2022 21:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644874878;
        bh=D4g4uyjwJpcXoUc2SbfFfY5PU28t1w1ZkaJouv3Cwjo=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=Efw+woMdORGERdh/7KSVE4CVHndA+CrTiZlkd/UtVMPEqXdQFcInqmKzfUuaYzRN/
         1UfH1CnVYUWSGB9+NFIhvNbC6LyGCnoBYgFftHdNY8xQ5x9PWDhjbxPBktVCa3S6rU
         xZ2PvTpvj3K2IlTrHXEyuCZ5WEzXrwlDzscTqzUIxCwuPLGJRPWpshzoCu7amnGJZh
         WiliS6HOyXDFgyNZ3wMfWiZ3KDdzsVtAy2zMolNWVimDGeQCmWPwiADg0+ydKdb+oH
         tAnHqxIRNdm5GkbBdhu64Y7/jQ+cYAA12lroS20qOhgY7F4+qm5i2iZofUPrStVGTf
         9JDxX5xXX3ZIQ==
Received: by mail-ej1-f70.google.com with SMTP id q3-20020a17090676c300b006a9453c33b0so6355677ejn.13
        for <linux-iio@vger.kernel.org>; Mon, 14 Feb 2022 13:41:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=D4g4uyjwJpcXoUc2SbfFfY5PU28t1w1ZkaJouv3Cwjo=;
        b=pSV9I+UdNDCldy/X6PVASWEhXOSJ+LmyMdtz9zON1aH3QEPGXYM8Uhzjtu9ay8XrXO
         sn9ewRrtXwFYQ7mRgbweEFvyck1ZSAGIMst6C9JGvHr1pR9T7c3EZtgAR1mCD+Ixcm7u
         KUr79922b8TggLApi8PNOgbNQxorXyA6glwGQ8zgq5BM5DUi4VKKQIJssRLucbcG41hs
         2hIdctY2Xu8Bx/gQ0dsq0k2353rLpoRhZRMtBgui7dZo6wSUq0HTn0EJ+t13gJPwf7b7
         ZBGRateFYrmcpVf4v+vqr/grME0xGDIYF/SlpSa0/BkQ012jxqaH8ToNtX9drm9CPX43
         IbZA==
X-Gm-Message-State: AOAM530N0bvXJTh1z4gVCOyCAzJCUhyJ6K0iZAQzUsW2Ae0ErJd1MDnV
        p6GSgzgkUoN0cQpNkR9oKqDY5acBgQKMMGgupMAPwCpHibFpyaZe4TlmqZufoH9owlG5WZ3Y87c
        z6UbZKnYldIae9ehLN6Z+0gsjMS+OtnSJJGPHcA==
X-Received: by 2002:a05:6402:23a2:: with SMTP id j34mr877916eda.5.1644874877711;
        Mon, 14 Feb 2022 13:41:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJysYArRm8bTpnwhgJNzUQ66tXM4Ay9eBAC+mx4aM8YJcNxRd6BkdPDXkiyh+B0XPzUUbIAzUw==
X-Received: by 2002:a05:6402:23a2:: with SMTP id j34mr877841eda.5.1644874876553;
        Mon, 14 Feb 2022 13:41:16 -0800 (PST)
Received: from [192.168.0.106] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id t5sm5525750edd.7.2022.02.14.13.41.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 13:41:16 -0800 (PST)
Message-ID: <1dff6f62-88dd-00e9-c9c0-bc148f4fb0b1@canonical.com>
Date:   Mon, 14 Feb 2022 22:41:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v7 2/4] dt-bindings:iio:frequency: add admv1014 binding
Content-Language: en-US
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
        robh+dt@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>
References: <20220214073418.4528-1-antoniu.miclaus@analog.com>
 <20220214073418.4528-2-antoniu.miclaus@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220214073418.4528-2-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 14/02/2022 08:34, Antoniu Miclaus wrote:
> Add device tree bindings for the ADMV1014 Upconverter.

Add spaces in subject after ':'.

> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> changes in v7:
>  - add Reviewed-by tag
>  .../bindings/iio/frequency/adi,admv1014.yaml  | 137 ++++++++++++++++++
>  1 file changed, 137 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,admv1014.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,admv1014.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,admv1014.yaml
> new file mode 100644
> index 000000000000..fe352c01dd94
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/frequency/adi,admv1014.yaml
> @@ -0,0 +1,137 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/frequency/adi,admv1014.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ADMV1014 Microwave Downconverter
> +
> +maintainers:
> +  - Antoniu Miclaus <antoniu.miclaus@analog.com>
> +
> +description: |
> +   Wideband, microwave downconverter optimized for point to point microwave
> +   radio designs operating in the 24 GHz to 44 GHz frequency range.
> +
> +   https://www.analog.com/en/products/admv1014.html
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,admv1014
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 1000000
> +
> +  clocks:
> +    minItems: 1

maxItems: 1
... or do you expect more clocks?

> +
> +  clock-names:
> +    items:
> +      - const: lo_in
> +    description:
> +      External clock that provides the Local Oscilator input.
> +
> +  vcm-supply:
> +    description:
> +      Common-mode voltage regulator.
> +
> +  vcc-if-bb-supply:
> +    description:
> +      BB and IF supply voltage regulator.
> +
> +  vcc-vga-supply:
> +    description:
> +      RF Amplifier supply voltage regulator.
> +
> +  vcc-vva-supply:
> +    description:
> +      VVA Control Circuit supply voltage regulator.
> +
> +  vcc-lna-3p3-supply:
> +    description:
> +      Low Noise Amplifier 3.3V supply voltage regulator.
> +
> +  vcc-lna-1p5-supply:
> +    description:
> +      Low Noise Amplifier 1.5V supply voltage regulator.
> +
> +  vcc-bg-supply:
> +    description:
> +      Band Gap Circuit supply voltage regulator.
> +
> +  vcc-quad-supply:
> +    description:
> +      Quadruple supply voltage regulator.
> +
> +  vcc-mixer-supply:
> +    description:
> +      Mixer supply voltage regulator.
> +
> +  adi,input-mode:
> +    description:
> +      Select the input mode.
> +      iq - in-phase quadrature (I/Q) input
> +      if - complex intermediate frequency (IF) input
> +    enum: [iq, if]
> +
> +  adi,detector-enable:
> +    description:
> +      Digital Rx Detector Enable. The Square Law Detector output is
> +      available at output pin VDET.
> +    type: boolean
> +
> +  adi,p1db-compensation-enable:
> +    description:
> +      Turn on bits to optimize P1dB.
> +    type: boolean
> +
> +  adi,quad-se-mode:
> +    description:
> +      Switch the LO path from differential to single-ended operation.
> +      se-neg - Single-Ended Mode, Negative Side Disabled.
> +      se-pos - Single-Ended Mode, Positive Side Disabled.
> +      diff - Differential Mode.
> +    enum: [se-neg, se-pos, diff]
> +
> +  '#clock-cells':
> +    const: 0

Is this really a clock provider?

> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - vcm-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      admv1014@0{

Generic node name (see Devicetree spec), so a "converter"? "wifi"?
"sensor"? "radio"?

> +        compatible = "adi,admv1014";
> +        reg = <0>;
> +        spi-max-frequency = <1000000>;
> +        clocks = <&admv1014_lo>;
> +        clock-names = "lo_in";
> +        vcm-supply = <&vcm>;
> +        vcc-if-bb-supply = <&vcc_if_bb>;
> +        vcc-vga-supply = <&vcc_vga>;
> +        vcc-vva-supply = <&vcc_vva>;
> +        vcc-lna-3p3-supply = <&vcc_lna_3p3>;
> +        vcc-lna-1p5-supply = <&vcc_lna_1p5>;
> +        vcc-bg-supply = <&vcc_bg>;
> +        vcc-quad-supply = <&vcc_quad>;
> +        vcc-mixer-supply = <&vcc_mixer>;
> +        adi,quad-se-mode = "diff";
> +        adi,detector-enable;
> +        adi,p1db-compensation-enable;
> +      };
> +    };
> +...


Best regards,
Krzysztof
