Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052BC51E7C4
	for <lists+linux-iio@lfdr.de>; Sat,  7 May 2022 16:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385568AbiEGO0b (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 May 2022 10:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352940AbiEGO0R (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 7 May 2022 10:26:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40026443F3;
        Sat,  7 May 2022 07:22:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98CC860A67;
        Sat,  7 May 2022 14:22:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C16ADC385A6;
        Sat,  7 May 2022 14:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651933342;
        bh=NX6zU5mYz2IXYYR3JRzT2xiH9d3YoBqJpybuFUJ4HxA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Vv7tvywFGpXkM9eDbAEHVca5hbErjET2QNfFxdT42Sb0lYB8RxdM7eEqesryhcK19
         KpO4F3uyLRgn7rVTbRazG8Oy+A1tPuJ4SE11MOQRZmaa2hc2lJAugylEtbJn/ZLoPv
         uKjmu/5+dT/8zaDll0yoGMkBiYmud0Vq+7C9vBLFCN2rUWJIq19qBybycwJYovssfO
         ZFrQWwyi3KWa66shAP0I9kF5jS6GRC98Apsq3uDopNeZTqRwtzcvZuBLLuyV4cXdws
         sUQmJqinsE8vnx7BJunrAsBsyiB6IeZx0zu5GKzUapF7vmVyjAoiN5ivQlRw2lou2T
         FnawdK5Za4/9w==
Date:   Sat, 7 May 2022 15:30:48 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: Document Renesas RZ/G2UL
 ADC
Message-ID: <20220507153048.38fd0b67@jic23-huawei>
In-Reply-To: <20220505184037.511295-2-biju.das.jz@bp.renesas.com>
References: <20220505184037.511295-1-biju.das.jz@bp.renesas.com>
        <20220505184037.511295-2-biju.das.jz@bp.renesas.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  5 May 2022 19:40:36 +0100
Biju Das <biju.das.jz@bp.renesas.com> wrote:

> Document Renesas RZ/G2UL ADC bindings. RZ/G2UL ADC is almost identical
> to RZ/G2L, but it has 2 analog input channels compared to 8 channels
> on the RZ/G2L.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v1->v2:
>  * Started using generic compatible for RZ/G2UL and added SoC specific validation
>    for channels.
> ---
>  .../bindings/iio/adc/renesas,rzg2l-adc.yaml   | 45 ++++++++++++++++---
>  1 file changed, 38 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
> index d66c24cae1e1..2da3538a3543 100644
> --- a/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
> @@ -19,6 +19,7 @@ properties:
>    compatible:
>      items:
>        - enum:
> +          - renesas,r9a07g043-adc   # RZ/G2UL
>            - renesas,r9a07g044-adc   # RZ/G2L
>            - renesas,r9a07g054-adc   # RZ/V2L
>        - const: renesas,rzg2l-adc
> @@ -74,18 +75,48 @@ patternProperties:
>        Represents the external channels which are connected to the ADC.
>  
>      properties:
> -      reg:
> -        description: |
> -          The channel number. It can have up to 8 channels numbered from 0 to 7.
Leave 
	   description: | 
	     The channel number.
here.  The rest of this description is obvious from the below schema so doesn't
need to also be in the descriptions.

> -        items:
> -          - minimum: 0
> -            maximum: 7
> -
> +      reg: true
>      required:
>        - reg
>  
>      additionalProperties: false
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: renesas,r9a07g043-adc
> +    then:
> +      patternProperties:
> +        "^channel@[0-7]$":
> +          type: object
> +          properties:
> +            reg:
> +              description: |
> +                The channel number. It can have up to 2 channels numbered from 0 to 1.
> +              items:
> +                - minimum: 0
> +                  maximum: 1
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - renesas,r9a07g044-adc
> +              - renesas,r9a07g054-adc
> +    then:
> +      patternProperties:
> +        "^channel@[0-7]$":
> +          type: object
> +          properties:
> +            reg:
> +              description: |
> +                The channel number. It can have up to 8 channels numbered from 0 to 7.
> +              items:
> +                - minimum: 0
> +                  maximum: 7
> +
>  additionalProperties: false
>  
>  examples:

