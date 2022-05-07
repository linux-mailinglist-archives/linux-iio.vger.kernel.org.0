Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4DA51E478
	for <lists+linux-iio@lfdr.de>; Sat,  7 May 2022 07:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357622AbiEGFnB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 May 2022 01:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351869AbiEGFnA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 7 May 2022 01:43:00 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6533BBCD;
        Fri,  6 May 2022 22:39:13 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-2f7b815ac06so100464117b3.3;
        Fri, 06 May 2022 22:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LYRdsO+0UlNlQ+DkmAIOZqldyfEk/u6PC/HY88MOfZU=;
        b=c+4l6A8UWMG8n7Sn8ONMpc7+JtZAn2WbMIU8DdP4ZpDfap9Hs2Kj8bX4KgvBY2aBO7
         W8gm5EYTOye4CKnCZirb99S8zDaY4iwd4YfzyWUUuoHX+o4PG1J7ZGhZUbl3Dhgr2yaG
         NL4dlS1J7gC91dkN5C7tCydrViq9XnyHb1wKW9Ly9jJ8xcEFRc57+jRb5/ieVCAJSQAx
         KFB8rR9OsUbfajQ9ex1IF7VQTJBU11f3IaE2EP70zU074+HTKLTBGtkzxdVADC9q4dZH
         pbPrdJ188jMfNyp10mDCh2txqlMG1AKo2YJHZH9yUcbL3VkdDlC2IcqOsPhqx4qrVyOR
         oGYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LYRdsO+0UlNlQ+DkmAIOZqldyfEk/u6PC/HY88MOfZU=;
        b=4cr/UObEQvXbKAmWp1aBxK7iJk+ZL/z+cnlHudwr40hKMEOBf62T8cxnzwHRfIHc4R
         QbVmy8qe06WEHGqemfwxCBGoBMZ8Kgayvqy6MHm/CdS6JtYUfwBepBZ5RpS2Lz8SV7LN
         0xt1wkLd1niZjMT+dDYKICB826hMC7rVLNRoulawXNQDweqsemdXdUiFs9FF+gBFK+gv
         7s23lAMWd3e2htYUeBmZJzNrS+B8BFWNGeGUP8CJIWLhV5f1RStLNG/n3hJenaeIxDxq
         T1qErsR7/HxvLGNBYu8e8Tt4PVZBfuV8VAxLcND7euJcQx9VLMdvGw9ozpUzLGufEBMo
         jQJg==
X-Gm-Message-State: AOAM533NpxIqb8gig610p/gwZVWoXD5WPlWO9h5MrrCbgp0lyMt2Lswz
        Pp8ND6HQveun6bt0by1sIMB8SfrQhOD6nui08Ys=
X-Google-Smtp-Source: ABdhPJyrHTSZ5/KuR98/r+1DH2SsqqSrkEbzQZ2r3/x0mf/RW9I1q9CL/9jTDr4d7KTicCYcUUWPTYPpghD5dsihfYg=
X-Received: by 2002:a81:9210:0:b0:2f4:d8f7:98e9 with SMTP id
 j16-20020a819210000000b002f4d8f798e9mr5694090ywg.265.1651901952525; Fri, 06
 May 2022 22:39:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220505184037.511295-1-biju.das.jz@bp.renesas.com> <20220505184037.511295-2-biju.das.jz@bp.renesas.com>
In-Reply-To: <20220505184037.511295-2-biju.das.jz@bp.renesas.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Sat, 7 May 2022 06:38:45 +0100
Message-ID: <CA+V-a8ufv29KYREU3qhMx+hTRq=vTDO9vbHrsPQQE1Sm2NybWQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: Document Renesas RZ/G2UL ADC
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Biju,

Thank you for the patch.

On Fri, May 6, 2022 at 2:09 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
>
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

Can the above hunk be replaced by else instead?

Cheers,
Prabhakar

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
> --
> 2.25.1
>
