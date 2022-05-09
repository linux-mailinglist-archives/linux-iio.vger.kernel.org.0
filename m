Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C78651FD6B
	for <lists+linux-iio@lfdr.de>; Mon,  9 May 2022 14:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234877AbiEIMwt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 May 2022 08:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234858AbiEIMwq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 May 2022 08:52:46 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50061A9ACD;
        Mon,  9 May 2022 05:48:52 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id x9so10850918qts.6;
        Mon, 09 May 2022 05:48:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HPFsZbEvwzFtxYQPhoDO5rz/R82Uf8l5zkcCKFQ6xbo=;
        b=CBQyVpkQ/pSyRAH3RckWZs1T7vQOB+neJuQ9RQFPWsM0YJdFqoD0yqlbbP6RzV2cZH
         KlwuqPwBBppPtLsFC7h01o4m2P6wqQngCdMcgiJwvDH8tDUGMcoTNEufcRlXdmIZ9Bmk
         0gOlzAmzRjLdjdDrPA5dH75WZ957fBtJ16ZM9nsBG9hmshyPi6cA0cPiHT814NlWdnff
         ktqEBBREb1Imnk8DzlUY8FkOPBXw4ZearR/9iWsegfne9lz5dOn+6OF4J/07l6U/Pf9e
         2hB9IbiNv6W8O88e0fKQI25o9vRelhl8fO+uU8GOya1r3yi30fms7AP7rrB7vGqP9Sug
         OOmg==
X-Gm-Message-State: AOAM531Q4W6cZb6lujFdHxqsppsRB5WrdEEJSzQfYNkUju1OG2Tgqrgw
        XiBwaHlyP4dy9mIBI9EiKYRcwjF6H4uRrg==
X-Google-Smtp-Source: ABdhPJzO8OYfohK1/YMKNEBIXi1DBdzzuGTjgBRofgc02mLJjck0BZEGKZEIloFhbv7MEbuiFL5HHA==
X-Received: by 2002:a05:622a:1115:b0:2f3:bd60:a33b with SMTP id e21-20020a05622a111500b002f3bd60a33bmr14469795qty.292.1652100531626;
        Mon, 09 May 2022 05:48:51 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id c68-20020a379a47000000b006a03cbb1323sm6344001qke.65.2022.05.09.05.48.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 05:48:51 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-2f7d621d1caso142673827b3.11;
        Mon, 09 May 2022 05:48:50 -0700 (PDT)
X-Received: by 2002:a81:913:0:b0:2f7:c833:f304 with SMTP id
 19-20020a810913000000b002f7c833f304mr14135523ywj.283.1652100530441; Mon, 09
 May 2022 05:48:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220505184037.511295-1-biju.das.jz@bp.renesas.com>
 <20220505184037.511295-2-biju.das.jz@bp.renesas.com> <CAMuHMdVV=MB8xa-Q-c_aZx9LGrW=9aP9iC3P-FMRSf-HiovOzA@mail.gmail.com>
 <OS0PR01MB59224E3B5A9E5D8FD5E55B2886C59@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB59224E3B5A9E5D8FD5E55B2886C59@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 9 May 2022 14:48:38 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXDCDLhOSGgy9WWwawiHpE8C6isU2dLn6uSpY2gFAr38g@mail.gmail.com>
Message-ID: <CAMuHMdXDCDLhOSGgy9WWwawiHpE8C6isU2dLn6uSpY2gFAr38g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: Document Renesas RZ/G2UL ADC
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Biju,

On Fri, May 6, 2022 at 10:40 AM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: Document Renesas RZ/G2UL
> > On Thu, May 5, 2022 at 8:40 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > > Document Renesas RZ/G2UL ADC bindings. RZ/G2UL ADC is almost identical
> > > to RZ/G2L, but it has 2 analog input channels compared to 8 channels
> > > on the RZ/G2L.
> > >
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

> > > --- a/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
> > > @@ -74,18 +75,48 @@ patternProperties:
> > >        Represents the external channels which are connected to the ADC.
> > >
> > >      properties:
> > > -      reg:
> > > -        description: |
> > > -          The channel number. It can have up to 8 channels numbered from
> > 0 to 7.
> > > -        items:
> > > -          - minimum: 0
> > > -            maximum: 7
> > > -
> > > +      reg: true
> > >      required:
> > >        - reg
> > >
> > >      additionalProperties: false
> > >
> > > +allOf:
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            const: renesas,r9a07g043-adc
> > > +    then:
> > > +      patternProperties:
> > > +        "^channel@[0-7]$":
> >
> > [0-1]
>
> Looks like with this change, validation doesn't work as expected.

OK, keep it at [0-7].

> > > +          type: object
> > > +          properties:
> > > +            reg:
> > > +              description: |
> > > +                The channel number. It can have up to 2 channels
> > numbered from 0 to 1.
> > > +              items:
> > > +                - minimum: 0
> > > +                  maximum: 1
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            enum:
> > > +              - renesas,r9a07g044-adc
> > > +              - renesas,r9a07g054-adc
> > > +    then:
> > > +      patternProperties:
> > > +        "^channel@[0-7]$":
> > > +          type: object
> > > +          properties:
> > > +            reg:
> > > +              description: |
> > > +                The channel number. It can have up to 8 channels
> > numbered from 0 to 7.
> > > +              items:
> > > +                - minimum: 0
> > > +                  maximum: 7
> > > +
> > >  additionalProperties: false
> > >
> > >  examples:
> >
> > The rest LGTM, but I'm wondering if more of the channel subnodes
> > description can be factored out to the common part?
>
> You mean above reg: true?? ie, add as part of the below description??
>
> type: object
>     description: |
>       Represents the external channels which are connected to the ADC.

I think I've found a solution while converting the R-Car Gen2
USB PHY bindings.  You can mark channels 3-7 false on RZ/G2UL,
cfr. the second channel on RZ/G1C in "[PATCH] dt-bindings:
phy: renesas,rcar-gen2-usb-phy: Convert to json-schema"
https://lore.kernel.org/r/8e48edc5e7b65f8dfd8b76c583e0265b9b97e62b.1652099944.git.geert+renesas@glider.be/

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
