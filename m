Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2BE5166DC
	for <lists+linux-iio@lfdr.de>; Sun,  1 May 2022 20:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241756AbiEASMS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 May 2022 14:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiEASMS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 1 May 2022 14:12:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4384EA38;
        Sun,  1 May 2022 11:08:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26AC260DF5;
        Sun,  1 May 2022 18:08:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C5BAC385AA;
        Sun,  1 May 2022 18:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651428531;
        bh=s+pVZUtUNrW1qG7CHMVMX+luiaEQlJlYBtdfoxArY8Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=S5L0H7J49V715mecunZeqcx4ITD7NL9yDTQoQt3LGUJ/maJOqUSYtr5UP7DhlK25K
         8eYnHfm5tpVL/lri+UmUM3bg45IvPxcNx0wvrt8lWShtG2slQA8vgAAfwTHgw4s20Z
         UYZuXOOspliIGGbew3r+5SCpD3xlimX9YDxT3KNVYggivO51AmrWIkvYj9Aw9wAbj+
         efWKF4wx50sRxMf9FEz+J/vebCqFmg5lX7wQ0e2z41wu9VvmhUoWIzE+o3R/JldnRx
         hiFCL8uj257IgeTBTidrhx40Uh0pfPrIKwiLBHqJ5R/0WyosCh4GFP6uW3esFkk9FS
         1vHDfWa89yr1g==
Date:   Sun, 1 May 2022 19:17:05 +0100
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
Subject: Re: [PATCH v2] dt-bindings: iio: adc: Document Renesas RZ/G2UL ADC
Message-ID: <20220501191705.19860b69@jic23-huawei>
In-Reply-To: <20220501111952.45872-1-biju.das.jz@bp.renesas.com>
References: <20220501111952.45872-1-biju.das.jz@bp.renesas.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
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

On Sun,  1 May 2022 12:19:52 +0100
Biju Das <biju.das.jz@bp.renesas.com> wrote:

> ADC found on RZ/G2UL SoC is almost identical to RZ/G2L SoC, but RZ/G2UL
> has 2 analog input channels compared to 8 channels on RZ/G2L. Therefore,
> added a new compatible to handle this difference.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v1->v2:
>  * Removed Items and used const for RZ/G2UL compatible
>  * Add allOf:if:then restricting available channels per SoC variant.
> ---
>  .../bindings/iio/adc/renesas,rzg2l-adc.yaml   | 34 ++++++++++++++-----
>  1 file changed, 25 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
> index d66c24cae1e1..d76c5ba3d625 100644
> --- a/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
> @@ -17,11 +17,13 @@ description: |
>  
>  properties:
>    compatible:
> -    items:
> -      - enum:
> -          - renesas,r9a07g044-adc   # RZ/G2L
> -          - renesas,r9a07g054-adc   # RZ/V2L
> -      - const: renesas,rzg2l-adc
> +    oneOf:
> +      - const: renesas,renesas,r9a07g043-adc  # RZ/G2UL
> +      - items:
> +          - enum:
> +              - renesas,r9a07g044-adc   # RZ/G2L
> +              - renesas,r9a07g054-adc   # RZ/V2L
> +          - const: renesas,rzg2l-adc
>  
>    reg:
>      maxItems: 1
> @@ -76,10 +78,24 @@ patternProperties:
>      properties:
>        reg:
>          description: |
> -          The channel number. It can have up to 8 channels numbered from 0 to 7.
> -        items:
> -          - minimum: 0
> -            maximum: 7
> +          The channel number. It can have up to 8 channels numbered from 0 to 7
> +          for RZ/{G2L,V2L} SoCs or 2 channels numbered from 0 to 1 for RZ/G2UL
> +          SoC.
> +      allOf:
> +        if:
           - if:
               properties:
etc

Otherwise I think you can only have one in your allOf: which rather
removes the point of having one.

I was surprised this passed the checks, so added another if to verify my
reasoning...

Jonathan

> +          properties:
> +            compatible:
> +              contains:
> +                enum:
> +                  - renesas,renesas,r9a07g043-adc
> +        then:
> +          items:
> +            - minimum: 0
> +              maximum: 1
> +        else:
> +          items:
> +            - minimum: 0
> +              maximum: 7
>  
>      required:
>        - reg

