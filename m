Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11FA33B972A
	for <lists+linux-iio@lfdr.de>; Thu,  1 Jul 2021 22:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbhGAUYS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Jul 2021 16:24:18 -0400
Received: from mail-io1-f52.google.com ([209.85.166.52]:42750 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbhGAUYS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Jul 2021 16:24:18 -0400
Received: by mail-io1-f52.google.com with SMTP id v3so9058291ioq.9;
        Thu, 01 Jul 2021 13:21:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SZFqor6VUT+2tI4cySm/1psSxonDwYwfdmlsp9lZDbY=;
        b=Wq6xb285b0dotoySSY3MUFZeM0GH0gT0mNz2c/teCsJV6Jb1j8Za9hLYfjfr8OQck4
         dGmXO6htLh7Ch8I3XPwT3hAJhp2NxKzCP/RnCdUo871r7PDMLEUQnScbqsMTkT3CPVW1
         6dOm98I/LrtptCC9bCYWelOhRn81rzNRsPE0NdHWGPB2qrMgLKC/Abnd+EU5gT70FTXH
         luDnuz3CJmwU8IJ87cMSjR28H5IA88u2zm5DxSRKyLS5Yc54bygA0i5xWKeUXaSPGvb5
         o2C91KvqKMVs0M+RhU58T/a2PocpQqE2To/dVdTmKqBYWmQ76rhEn6WGoss1EXDRabWv
         3PsQ==
X-Gm-Message-State: AOAM531vGlVgRb03zuADKUs4oE//H/HaV5WVTFuJi6aU9TwfWXv5rEYv
        IPiCvo1K8SAamSVCxSjsfQ==
X-Google-Smtp-Source: ABdhPJy2OW1If6NtGJSwFvA6qt5W2VGn++818oodI2sfRiSPCgxQPaYdFWDSoZ36dIn6PpCC1gX3Iw==
X-Received: by 2002:a5d:858b:: with SMTP id f11mr946359ioj.156.1625170905722;
        Thu, 01 Jul 2021 13:21:45 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id f19sm547435ilr.48.2021.07.01.13.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 13:21:45 -0700 (PDT)
Received: (nullmailer pid 2862921 invoked by uid 1000);
        Thu, 01 Jul 2021 20:21:41 -0000
Date:   Thu, 1 Jul 2021 14:21:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: Add binding documentation for
 Renesas RZ/G2L A/D converter
Message-ID: <20210701202141.GA2859816@robh.at.kernel.org>
References: <20210629220328.13366-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20210629220328.13366-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210629220328.13366-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jun 29, 2021 at 11:03:27PM +0100, Lad Prabhakar wrote:
> Add binding documentation for Renesas RZ/G2L A/D converter block.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  .../bindings/iio/adc/renesas,rzg2l-adc.yaml   | 121 ++++++++++++++++++
>  1 file changed, 121 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
> new file mode 100644
> index 000000000000..db935d6d59eb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
> @@ -0,0 +1,121 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/renesas,rzg2l-adc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas RZ/G2L ADC
> +
> +maintainers:
> +  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> +
> +description: |
> +  A/D Converter block is a successive approximation analog-to-digital converter
> +  with a 12-bit accuracy. Up to eight analog input channels can be selected.
> +  Conversions can be performed in single or repeat mode. Result of the ADC is
> +  stored in a 32-bit data register corresponding to each channel.
> +
> +properties:
> +  compatible:
> +    oneOf:

You can drop oneOf here.

> +      - items:
> +          - enum:
> +              - renesas,r9a07g044-adc   # RZ/G2{L,LC}
> +          - const: renesas,rzg2l-adc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: converter clock
> +      - description: peripheral clock
> +
> +  clock-names:
> +    items:
> +      - const: adclk
> +      - const: pclk
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 2
> +
> +  reset-names:
> +    items:
> +      - const: presetn
> +      - const: adrst-n
> +
> +  renesas-rzg2l,adc-trigger-mode:
> +    $ref: /schemas/types.yaml#/definitions/uint8
> +    description: Trigger mode for A/D converter
> +    enum:
> +      - 0 # Software trigger mode (Defaults)
> +      - 1 # Asynchronous trigger using ADC_TRG trigger input pin
> +      - 2 # Synchronous trigger (Trigger from MTU3a/GPT)
> +    default: 0
> +
> +  gpios:

A named gpio is preferred. trigger-gpios?

> +    description:
> +      ADC_TRG trigger input pin
> +    maxItems: 1
> +
> +  renesas-rzg2l,adc-channels:
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    description: Input channels available on platform
> +    uniqueItems: true
> +    minItems: 1
> +    maxItems: 8
> +    items:
> +      enum: [0, 1, 2, 3, 4, 5, 6, 7]
> +
> +  "#io-channel-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - power-domains
> +  - resets
> +  - reset-names
> +  - renesas-rzg2l,adc-channels
> +  - "#io-channel-cells"
> +
> +allOf:
> +  - if:
> +      properties:
> +        renesas-rzg2l,adc-trigger-mode:
> +          const: 1
> +    then:
> +      required:
> +        - gpios
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/r9a07g044-cpg.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    adc: adc@10059000 {
> +      compatible = "renesas,r9a07g044-adc", "renesas,rzg2l-adc";
> +      reg = <0x10059000 0x400>;
> +      interrupts = <GIC_SPI 347 IRQ_TYPE_EDGE_RISING>;
> +      clocks = <&cpg CPG_MOD R9A07G044_ADC_ADCLK>,
> +               <&cpg CPG_MOD R9A07G044_ADC_PCLK>;
> +      clock-names = "adclk", "pclk";
> +      power-domains = <&cpg>;
> +      resets = <&cpg R9A07G044_ADC_PRESETN>,
> +               <&cpg R9A07G044_ADC_ADRST_N>;
> +      reset-names = "presetn", "adrst-n";
> +      #io-channel-cells = <1>;
> +      renesas-rzg2l,adc-trigger-mode = /bits/ 8 <0>;
> +      renesas-rzg2l,adc-channels = /bits/ 8 <0 1 2 3 4 5 6>;
> +    };
> -- 
> 2.17.1
> 
> 
