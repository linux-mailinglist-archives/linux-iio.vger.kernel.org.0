Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832004BA4C2
	for <lists+linux-iio@lfdr.de>; Thu, 17 Feb 2022 16:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242717AbiBQPpD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 17 Feb 2022 10:45:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242696AbiBQPpB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 17 Feb 2022 10:45:01 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90BF92B1025
        for <linux-iio@vger.kernel.org>; Thu, 17 Feb 2022 07:44:46 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 40CEE3F338
        for <linux-iio@vger.kernel.org>; Thu, 17 Feb 2022 15:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645112685;
        bh=WGHZYNCZxYLhYQVH3r6oPz7+X4RqZVH5DdrjHvN9FI8=;
        h=Message-ID:Date:MIME-Version:Subject:To:References:From:
         In-Reply-To:Content-Type;
        b=lBBjVyCf0cGkzb+EwSkIfZBZ7IT5x5BjmjFDIBIaOQvpYVNa9E61nZv0CZou0M44/
         OI7/XVco/Xu2WbM4PCztYL+QMalcGfURcEfoTMBJcZWbjQJYGiKPp+KX1X84BUvUO6
         P2CY3yTgDx1/OxfycVOsHbs1FE1zLp4E/ZQ0mWn9SGVvo+KGYeiRL9PhDoWc33Nm6U
         vBuzt/0GhT2gH7KdhsrovNYK5sgatP4iZVIpJqQKpVLOBgEOOncWqjUzun2Wlxptkd
         ckU6p+IbA8FwHbiXRgVC0Qpp8PefobZOWPiSfq+9rfUFyDU8pLY8sdZ+FCks3woyRU
         RcR7yYq+2lqYQ==
Received: by mail-ed1-f69.google.com with SMTP id o8-20020a056402438800b00410b9609a62so3746504edc.3
        for <linux-iio@vger.kernel.org>; Thu, 17 Feb 2022 07:44:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WGHZYNCZxYLhYQVH3r6oPz7+X4RqZVH5DdrjHvN9FI8=;
        b=LeuAzb9Zz/d2ka/xQwOXoSOAV/AZJHi0TYA40BsLgOrPITOTUepLcekaUaYU3RxMbF
         KkFJUwMRBNARRwSyjKkYNwLeK4/qQO7hverMtxxdPG8fK2R3D8AjQ4dn+XGaCEqU7d4y
         92Qn+Eg85WNBiumSv2fbMSrcyAUrieoUPBCU/AxUwphePXC3oxKsmGV0oC69Z8WLRoy3
         IwvvIgQf4Q7VEuNvsiLpqDN64Ceye0n7VEU/QpDSC+5/UBo+3RXle+N/bABHyRgG/lgk
         EZ0R10Ft+vSAWkkD2YC9Fwr6MeexzOXayRF6EdH8RIG8uM6Ij2aQaH/4Mcb1n1LzH+mJ
         +P4Q==
X-Gm-Message-State: AOAM5339RgEDXO7zAWYConygWqGD8emzf/xr+snmjzLgd6YsvzawYpgM
        7dteBab4bQbFATLZ+GMuh68AtmbBo6EA46YEQYyrSWbyPuvVoifwBh8WynT7qWnb2+ZETUwVfoa
        NofnCpSg7CeOM2W5rF7INbX9LZUwYoSG4DQtp/Q==
X-Received: by 2002:a50:8a89:0:b0:410:c862:40b2 with SMTP id j9-20020a508a89000000b00410c86240b2mr3184922edj.81.1645112684878;
        Thu, 17 Feb 2022 07:44:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwCVFJaxE1RX1vNgq47/NAOe5g98U3YwoPi2hMlaXwOYTw9korgwhqA41WY65+xX9+z6HgFzQ==
X-Received: by 2002:a50:8a89:0:b0:410:c862:40b2 with SMTP id j9-20020a508a89000000b00410c86240b2mr3184886edj.81.1645112684543;
        Thu, 17 Feb 2022 07:44:44 -0800 (PST)
Received: from [192.168.0.112] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id u2sm1287758ejb.127.2022.02.17.07.44.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 07:44:43 -0800 (PST)
Message-ID: <9c9485c4-78d7-4be7-a529-708f4d0f2ae8@canonical.com>
Date:   Thu, 17 Feb 2022 16:44:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/3] dt-bindings: iio: add ADE9078
Content-Language: en-US
To:     chegbeli <ciprian.hegbeli@analog.com>, jic23@kernel.org,
        robh+dt@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220217135140.5658-1-ciprian.hegbeli@analog.com>
 <20220217135140.5658-3-ciprian.hegbeli@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220217135140.5658-3-ciprian.hegbeli@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 17/02/2022 14:51, chegbeli wrote:
> Added device tree bindings for the ADE9078
> 
> Signed-off-by: chegbeli <ciprian.hegbeli@analog.com>
> ---
>  .../bindings/iio/meter/adi,ade9078.yaml       | 153 ++++++++++++++++++
>  include/dt-bindings/iio/meter/adi,ade9078.h   |  21 +++
>  2 files changed, 174 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/meter/adi,ade9078.yaml
>  create mode 100644 include/dt-bindings/iio/meter/adi,ade9078.h
> 
> diff --git a/Documentation/devicetree/bindings/iio/meter/adi,ade9078.yaml b/Documentation/devicetree/bindings/iio/meter/adi,ade9078.yaml
> new file mode 100644
> index 000000000000..e27d52e06e32
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/meter/adi,ade9078.yaml
> @@ -0,0 +1,153 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2021 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bindings/iio/addac/adi,ade9078.yaml#

Did you test your schema with dt_binding_check? This should fail.

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices ADE9078 High Performance, Polyphase Energy Metering driver
> +
> +mainterners:
> +  -Ciprian Hegbeli <ciprian.hegbeli@analog.com>

Space after '-'.

> +
> +description: |
> +  The ADE9078 1 is a highly accurate, fully integrated energy
> +  metering device. Interfacing with both current transformer
> +  (CT) and Rogowski coil sensors, the ADE9078 enables users to
> +  develop a 3-phase metrology platform, which achieves high
> +  performance for Class 1 up to Class 0.2 meters.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ade9078
> +
> +    reg:
> +      maxItems: 1
> +
> +    '#address-cells':
> +      const: 1
> +
> +    '#size-cells':
> +      const: 0
> +
> +    spi-max-frequency:
> +      maximum: 1000000
> +
> +    interrupts:
> +      maxItems: 2
> +
> +    reset-gpios:
> +      description: |
> +        Must be the device tree identifier of the RESET pin. As the line is
> +        active low, it should be marked GPIO_ACTIVE_LOW.
> +      maxItems: 1
> +
> +    interrupt-names:
> +      description: |
> +        Names to be attributed to the interrupts of the device. Should be "irq0"
> +        or "irq1"

Skip description but instead list items ( - const: irq0 ...)

> +
> +    adi,wf-cap-sel:
> +      description: |
> +        This bit selects whether the waveform buffer is filled with resampled
> +        data or fixed data rate data
> +        0 - WF_RESAMPLED_DATA
> +        1 - WF_FIXED_DATA_RATE
> +      maxItems: 1
> +      minimum: 0
> +      maximum: 1

1. You need a type definition.
2. This looks like bool.
3. maxItems seems wrong here.
4. Do not describe registers and their bits but a feature of the device.

This applies to fields below as well.

> +
> +    adi,wf-mode:
> +      description: |
> +        Fixed data rate waveforms filling and trigger based modes.
> +        0 - WFB_FULL_MODE (Stop when waveform buffer is full)
> +        1 - WFB_EN_TRIG_MODE (Continuous fill—stop only on enabled trigger events)
> +        2 - WFB_CENTER_EN_TRIG_MODE (Continuous filling—center capture around enabled trigger events)
> +        3 - WFB_SVAE_EN_TRIG_MODE (Continuous fill—save event address of enabled trigger events)
> +      maxItems: 1
> +      minimum: 0
> +      maximum: 3

Everything above + this looks like an enum, so use enum, instead of min/max.

> +
> +    adi,wf-src:
> +      description: |
> +        Waveform buffer source and DREADY, data ready update rate, selection.
> +        0 - WFB_SRC_SINC4 (Sinc4 output, at 16 kSPS)
> +        1 - Reserved
> +        2 - WFB_SRC_SINC4_IIR_LPF (Sinc4 + IIR LPF output, at 4 kSPS)
> +        3 - WFB_SRC_DSP (Current and voltage channel waveform samples,processed by the DSP
> +            (xI_PCF, xV_PCF) at 4 kSPS)
> +      maxItems: 1
> +      minimum: 0
> +      maximum: 3
> +
> +    adi,wf-in-en:
> +      description: |
> +        This setting determines whether the IN waveform samples are read out of
> +        the waveform buffer through SPI.
> +        0 - WFB_IN_DISABLE
> +        1 - WFB_IN_EN
> +      maxItems: 1
> +      minimum: 0
> +      maximum: 1

Also bool.

> +
> +  required:
> +    - compatible
> +    - reg
> +    - reset-gpios
> +    - interrupts
> +    - interrupt-names
> +    - adi,wf-cap-sel
> +    - adi,wf-mode
> +    - adi,wf-src
> +    - adi,wf-in-en
> +
> +patternProperties:
> +  "^phase@[0-3]$":
> +    type: object
> +    description: |
> +      Represents the external phases which are externally connected. Each phase
> +      has a current, voltage and power component
> +
> +    properties:
> +      reg:
> +        description: |
> +          The phase represented by a number
> +          0 - Phase A
> +          1 - unused
> +          2 - Phase B
> +          3 - unused
> +          4 - Phase C
> +        maxItems: 1
> +        minimum: 0
> +        maximum: 4
> +
> +    required:
> +      - reg
> +
> +examples:
> +  - |
> +    ade9078@0 {

Generic node name. Please pick something appropriate. Maybe "meter"?

> +	compatible = "adi,ade9078";

You have entirely broken indentation here. Use four spaces for DTS example.

> +	reg = <0>;
> +	spi-max-frequency = <7000000>;
> +
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	reset-gpios = <&gpio 4 GPIO_ACTIVE_LOW>;
> +	interrupts = <2 IRQ_TYPE_EDGE_FALLING>, <3 IRQ_TYPE_EDGE_FALLING>;

You clearly did not test it... this won't work without headers.

> +	interrupt-names = "irq0", "irq1";
> +	interrupt-parent = <&gpio>;


Best regards,
Krzysztof
