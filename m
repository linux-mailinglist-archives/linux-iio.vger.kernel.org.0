Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D206522CF2
	for <lists+linux-iio@lfdr.de>; Wed, 11 May 2022 09:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241028AbiEKHN6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 May 2022 03:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234003AbiEKHN4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 May 2022 03:13:56 -0400
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEE86FD1F;
        Wed, 11 May 2022 00:13:55 -0700 (PDT)
Received: by mail-qv1-f51.google.com with SMTP id n10so1493844qvi.5;
        Wed, 11 May 2022 00:13:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tbpujvy+yKLfcJgrFJ+v4Kcv6jitXcPGM+E32YlO9vI=;
        b=touwP5vjlmtPLfeyl+cHBYo8gLIFh8L0bo0qomuV7n1EDZ22Wgbm2XGgHZQ4D2hgtr
         jqZpmIml4ZjIquUvaIBMaSKE6G8yHy0YFNtTF9ohOntIgLEi2bEFU3VooN8ciOSkCSFv
         5SW+cFBLimYvWMWhvm0iz/cjqtpQTKFxJy2aJJtpjYrsxRGn/UNhd78VpSdGFRqXVGaM
         oTIZAlpZD0SRtWQkg5FnPh/3R82JTtOAWTUDHolH3g6y+oB3qFYrNmazwQywVqjz/xyg
         MAh5I+MWn1ZSIACUks2xkD+0QRtQr/HP+GXxhnADSmshbdlW5PJ1uwQZVALyJgkieH45
         HFtw==
X-Gm-Message-State: AOAM532ombIl0TqGFj4+u4+4zM9QWt21f0AnaruCl8UzIaTS3eDgrZGJ
        g9QYSMnXgCLdkaaIqfcuC4l9Fv20UsWrjg==
X-Google-Smtp-Source: ABdhPJwyKKOSUoq4pIoEgSwIYnJ6vYjx6PSPJ9EzmpO3jHDDIg22FE4/sqzX0QdtG6nFMIBFceamfA==
X-Received: by 2002:a05:6214:246f:b0:45a:c441:4744 with SMTP id im15-20020a056214246f00b0045ac4414744mr21235315qvb.13.1652253234503;
        Wed, 11 May 2022 00:13:54 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id p124-20020a37a682000000b0069fcdbabdb4sm775564qke.69.2022.05.11.00.13.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 00:13:54 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id s30so2230366ybi.8;
        Wed, 11 May 2022 00:13:53 -0700 (PDT)
X-Received: by 2002:a25:4506:0:b0:648:cfc2:301d with SMTP id
 s6-20020a254506000000b00648cfc2301dmr21693536yba.380.1652253233501; Wed, 11
 May 2022 00:13:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220511070443.30231-1-biju.das.jz@bp.renesas.com> <20220511070443.30231-2-biju.das.jz@bp.renesas.com>
In-Reply-To: <20220511070443.30231-2-biju.das.jz@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 11 May 2022 09:13:42 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWNP_H9FNcygXZp0Ysw=wGXzV71Q_U7Hs=wH_Vctnz1pg@mail.gmail.com>
Message-ID: <CAMuHMdWNP_H9FNcygXZp0Ysw=wGXzV71Q_U7Hs=wH_Vctnz1pg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: adc: Document Renesas RZ/G2UL ADC
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

On Wed, May 11, 2022 at 9:04 AM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> Document Renesas RZ/G2UL ADC bindings. RZ/G2UL ADC is almost identical
> to RZ/G2L, but it has 2 analog input channels compared to 8 channels
> on the RZ/G2L.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v2->v3:
>  * Added generic description for reg.
>  * Improved schema validation by restricting both channel and reg to [0-1].

Thanks for the update!

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
> @@ -76,16 +77,43 @@ patternProperties:
>      properties:
>        reg:
>          description: |
> -          The channel number. It can have up to 8 channels numbered from 0 to 7.
> -        items:
> -          - minimum: 0
> -            maximum: 7
> +          The channel number.
>
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
> +        "^channel@[2-7]$": false
> +        "^channel@[0-1]$":
> +          type: object
> +          properties:
> +            reg:
> +              description: |
> +                It can have up to 2 channels numbered from 0 to 1.

IMHO the description doesn't add any value, as it's equivalent to
the logic below.

> +              items:

I don't think the "items" is needed or wanted, as there can be
only one?

> +                - minimum: 0
> +                  maximum: 1

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
