Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFBE551D21A
	for <lists+linux-iio@lfdr.de>; Fri,  6 May 2022 09:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389462AbiEFHVE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 6 May 2022 03:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389463AbiEFHVD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 6 May 2022 03:21:03 -0400
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08E466FA3;
        Fri,  6 May 2022 00:17:21 -0700 (PDT)
Received: by mail-qv1-f51.google.com with SMTP id eq14so4873608qvb.4;
        Fri, 06 May 2022 00:17:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7gUvCTF+zeKrO8IXhhvoks9ehUWGZScLpF4J5EMWPB8=;
        b=P9Y09TMYsGP5Sa49nvp8fv2JGQ6qvaz0VFisV/JJwZPD8fIT0zrOFPXYSfvPVZ67Lp
         MVHwaKeYhhhZJRWiZIVOqv4Iou3Jp3fPJfiD9zUnx3P7ypbWCnDtS2CV9gy1lMIfOrsp
         eCnqfVsW2YA10AE3B2OjhqA2to/Cx8/HMoB6VZP+HkeC30oPqEvPCCxb3bCQbZySIT9X
         fYCbuiSopdNzabeDL0kKL90vxzKGP6suJ8xf0M4tC5ZalFFTouy5ekVMMLIbvvM/sdqS
         jM0FZu66tT5YQmy28mmrKcxCv0tNp82smbxpKQFPfQ1NsIMeV55FvSZcSozpJ6ZUOXp7
         JDBQ==
X-Gm-Message-State: AOAM530LDTZYRB0qE2GSlaxBxxyXNvk3lBl5PoDVMxu/dzMj8KFQC8IS
        HLrzaYzw80Sb+N4oUOOVThhh5kuiTY4hOw==
X-Google-Smtp-Source: ABdhPJwNZeIyBW5WSdhqLXco8Z2k2Ug+MDLskdTc00IPsnzQm6QfmMHLxrdSkPBvN3B2vK9R+YmwsA==
X-Received: by 2002:ad4:4387:0:b0:456:cf82:2b9c with SMTP id s7-20020ad44387000000b00456cf822b9cmr1513922qvr.57.1651821440309;
        Fri, 06 May 2022 00:17:20 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id g13-20020a05620a40cd00b0069fc13ce1fasm2211931qko.43.2022.05.06.00.17.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 00:17:19 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id w187so11430621ybe.2;
        Fri, 06 May 2022 00:17:19 -0700 (PDT)
X-Received: by 2002:a05:6902:905:b0:64a:2089:f487 with SMTP id
 bu5-20020a056902090500b0064a2089f487mr1303655ybb.202.1651821439212; Fri, 06
 May 2022 00:17:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220505184037.511295-1-biju.das.jz@bp.renesas.com> <20220505184037.511295-2-biju.das.jz@bp.renesas.com>
In-Reply-To: <20220505184037.511295-2-biju.das.jz@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 6 May 2022 09:17:07 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVV=MB8xa-Q-c_aZx9LGrW=9aP9iC3P-FMRSf-HiovOzA@mail.gmail.com>
Message-ID: <CAMuHMdVV=MB8xa-Q-c_aZx9LGrW=9aP9iC3P-FMRSf-HiovOzA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: Document Renesas RZ/G2UL ADC
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Biju,

On Thu, May 5, 2022 at 8:40 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> Document Renesas RZ/G2UL ADC bindings. RZ/G2UL ADC is almost identical
> to RZ/G2L, but it has 2 analog input channels compared to 8 channels
> on the RZ/G2L.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v1->v2:
>  * Started using generic compatible for RZ/G2UL and added SoC specific validation
>    for channels.

Thanks for the update!

> --- a/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
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

[0-1]

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

The rest LGTM, but I'm wondering if more of the channel subnodes
description can be factored out to the common part?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
