Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D34522DAD
	for <lists+linux-iio@lfdr.de>; Wed, 11 May 2022 09:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243132AbiEKHwa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 May 2022 03:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243157AbiEKHw1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 May 2022 03:52:27 -0400
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B1E3EABC;
        Wed, 11 May 2022 00:52:25 -0700 (PDT)
Received: by mail-qt1-f169.google.com with SMTP id hf18so1459514qtb.0;
        Wed, 11 May 2022 00:52:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g3sAO+uEhs9gv0j3M1h9NOrpEuUi3l2QX0eLu6vKpDY=;
        b=S/n+GnPNeKtdlkFiLdpJv5Vd825loxk8UXh4aR2XszXPNzPSqMV5yb7qeycNOXUsP9
         EU4wTBndg/BbOc0gzqnYY+cwfwHx/dApM0mZklv8S/H1t7h/9F/DbDknUqnVzhg8jMNf
         BrFjWKk6OuERyXRFe42pkO9GJ03BalrEsOByFy71Ey/ti5vbnWKrZh3L9CSi3uxJDUui
         WRbIf9hDxxoJ6Ux2xW2Q5MTEPzS+wj8haGm4zOvClhtzTi4aMO3ydQuanGNQJ6OCjbYN
         zMH9I5PX27AreDTidDydpFaCfC+YZ9zGLItltUztzifO0+hcj0tNje4f2KWz5qg9DgPk
         wg8Q==
X-Gm-Message-State: AOAM531dZKZ8+onMF4U1FLOWnNFRDJVVVOl+4GMr7uFYYJlHLfQCbEB6
        rncI4nhhas7sUL/vgW2gu/d7b/BlkDNicw==
X-Google-Smtp-Source: ABdhPJx0QtUUKCXnDCZAz4O7sB7TSJkjizbOd5l16TRZ9Gr+W6tvb2HW5ifdibeI76X92XygOUpoJg==
X-Received: by 2002:a05:622a:1115:b0:2f3:bd60:a33b with SMTP id e21-20020a05622a111500b002f3bd60a33bmr22809516qty.292.1652255544231;
        Wed, 11 May 2022 00:52:24 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id b186-20020a3767c3000000b0069fd21d0b09sm774974qkc.0.2022.05.11.00.52.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 00:52:23 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-2f16645872fso11380267b3.4;
        Wed, 11 May 2022 00:52:23 -0700 (PDT)
X-Received: by 2002:a0d:d689:0:b0:2fb:9a57:8517 with SMTP id
 y131-20020a0dd689000000b002fb9a578517mr1363707ywd.502.1652255543143; Wed, 11
 May 2022 00:52:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220511070443.30231-1-biju.das.jz@bp.renesas.com>
 <20220511070443.30231-2-biju.das.jz@bp.renesas.com> <CAMuHMdWNP_H9FNcygXZp0Ysw=wGXzV71Q_U7Hs=wH_Vctnz1pg@mail.gmail.com>
 <OS0PR01MB5922FF4C6F417DFF1C3BED5186C89@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB5922FF4C6F417DFF1C3BED5186C89@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 11 May 2022 09:52:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW3+HG+7JXBH2CjwK8GM5frKyP-kbXL1JXUD9R8j2MYkg@mail.gmail.com>
Message-ID: <CAMuHMdW3+HG+7JXBH2CjwK8GM5frKyP-kbXL1JXUD9R8j2MYkg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: adc: Document Renesas RZ/G2UL ADC
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

On Wed, May 11, 2022 at 9:39 AM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > Subject: Re: [PATCH v3 1/2] dt-bindings: iio: adc: Document Renesas RZ/G2UL
> > ADC
> > On Wed, May 11, 2022 at 9:04 AM Biju Das <biju.das.jz@bp.renesas.com>
> > wrote:
> > > Document Renesas RZ/G2UL ADC bindings. RZ/G2UL ADC is almost identical
> > > to RZ/G2L, but it has 2 analog input channels compared to 8 channels
> > > on the RZ/G2L.
> > >
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

> > > --- a/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
> > > @@ -19,6 +19,7 @@ properties:
> > >    compatible:
> > >      items:
> > >        - enum:
> > > +          - renesas,r9a07g043-adc   # RZ/G2UL
> > >            - renesas,r9a07g044-adc   # RZ/G2L
> > >            - renesas,r9a07g054-adc   # RZ/V2L
> > >        - const: renesas,rzg2l-adc
> > > @@ -76,16 +77,43 @@ patternProperties:
> > >      properties:
> > >        reg:
> > >          description: |
> > > -          The channel number. It can have up to 8 channels numbered from
> > 0 to 7.
> > > -        items:
> > > -          - minimum: 0
> > > -            maximum: 7
> > > +          The channel number.
> > >
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
> > > +        "^channel@[2-7]$": false
> > > +        "^channel@[0-1]$":
> > > +          type: object
> > > +          properties:
> > > +            reg:
> > > +              description: |
> > > +                It can have up to 2 channels numbered from 0 to 1.
> >
> > IMHO the description doesn't add any value, as it's equivalent to the logic
> > below.
>
> It is suggested by Jonathan on my previous version. If there is no objection,
> I can drop this.

OK.

> > > +              items:
> >
> > I don't think the "items" is needed or wanted, as there can be only one?
>
> It will be 2 right? eg:- reg = <0> and reg = <1>;
>
> Without this reg index validation fails.

I mean just drop the "items", but keep the rest:

    properties:
      reg:
        minimum: 0
        maximum: 1

(taken from Documentation/devicetree/bindings/ata/pata-common.yaml ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
