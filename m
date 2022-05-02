Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C95851754F
	for <lists+linux-iio@lfdr.de>; Mon,  2 May 2022 19:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386416AbiEBRHg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 May 2022 13:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352051AbiEBRHf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 May 2022 13:07:35 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFBB2654;
        Mon,  2 May 2022 10:04:05 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id m25so1883963oih.2;
        Mon, 02 May 2022 10:04:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RyfKQzlGnJ7L77OWzUvhlKYmJuTKqGy4tAr4aSelX70=;
        b=2RJZKOykACz5yd1R7zHldasf+0uDb/zy4u/AwcxfB97B/sv7bGKbRo2mDO4YyUirYF
         ddbsqigf817AQ0G/+4s5qyaSjfyoeRr79sl9Mg8b5YcwV55RxiWQNR3PNLtIQaOWAJN7
         a7EzFA6wj1qAcmQjL8437Im/lEcyAK1jgyDRLMKZ7AKICPjfQ1E9M7MHg+/NBrpByB59
         jriMwpjbX7RPAnoqTL1AL+XeTkU+QVs7bYz4RUXIAJMfdrJFOavkwstDmFfZ01jactbi
         rTK3+yxYv/AMvUud3Z4Xrt0gtAAc9lBnZ+4vGMWi+IMlmnI1vVzePFwRctCEhoWQU9J2
         aEgA==
X-Gm-Message-State: AOAM530qc/5jCwSLdy8g9l0WM5dT/UtIZX2nysehjiwoznuXjn2cxrZC
        Q/+FF5L5xTJZZjancv8uURtOXflEJg==
X-Google-Smtp-Source: ABdhPJwsCVRyhmjElfIJbu5IkPnmejWA+Bqc6NzMmf7NBIR1FWGQ1HhayD7q08/7M2fTop7B86o/YA==
X-Received: by 2002:a05:6808:d50:b0:322:fb1d:319d with SMTP id w16-20020a0568080d5000b00322fb1d319dmr60252oik.174.1651511044301;
        Mon, 02 May 2022 10:04:04 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w5-20020a9d3605000000b005b2353c5f4fsm3056541otb.0.2022.05.02.10.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 10:04:03 -0700 (PDT)
Received: (nullmailer pid 1338080 invoked by uid 1000);
        Mon, 02 May 2022 17:04:03 -0000
Date:   Mon, 2 May 2022 12:04:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Subject: Re: [PATCH v2] dt-bindings: iio: adc: Document Renesas RZ/G2UL ADC
Message-ID: <YnAPA9flIrt6qtfB@robh.at.kernel.org>
References: <20220501111952.45872-1-biju.das.jz@bp.renesas.com>
 <20220501191705.19860b69@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220501191705.19860b69@jic23-huawei>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, May 01, 2022 at 07:17:05PM +0100, Jonathan Cameron wrote:
> On Sun,  1 May 2022 12:19:52 +0100
> Biju Das <biju.das.jz@bp.renesas.com> wrote:
> 
> > ADC found on RZ/G2UL SoC is almost identical to RZ/G2L SoC, but RZ/G2UL
> > has 2 analog input channels compared to 8 channels on RZ/G2L. Therefore,
> > added a new compatible to handle this difference.
> > 
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> > v1->v2:
> >  * Removed Items and used const for RZ/G2UL compatible
> >  * Add allOf:if:then restricting available channels per SoC variant.
> > ---
> >  .../bindings/iio/adc/renesas,rzg2l-adc.yaml   | 34 ++++++++++++++-----
> >  1 file changed, 25 insertions(+), 9 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
> > index d66c24cae1e1..d76c5ba3d625 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
> > @@ -17,11 +17,13 @@ description: |
> >  
> >  properties:
> >    compatible:
> > -    items:
> > -      - enum:
> > -          - renesas,r9a07g044-adc   # RZ/G2L
> > -          - renesas,r9a07g054-adc   # RZ/V2L
> > -      - const: renesas,rzg2l-adc
> > +    oneOf:
> > +      - const: renesas,renesas,r9a07g043-adc  # RZ/G2UL
> > +      - items:
> > +          - enum:
> > +              - renesas,r9a07g044-adc   # RZ/G2L
> > +              - renesas,r9a07g054-adc   # RZ/V2L
> > +          - const: renesas,rzg2l-adc
> >  
> >    reg:
> >      maxItems: 1
> > @@ -76,10 +78,24 @@ patternProperties:
> >      properties:
> >        reg:
> >          description: |
> > -          The channel number. It can have up to 8 channels numbered from 0 to 7.
> > -        items:
> > -          - minimum: 0
> > -            maximum: 7
> > +          The channel number. It can have up to 8 channels numbered from 0 to 7
> > +          for RZ/{G2L,V2L} SoCs or 2 channels numbered from 0 to 1 for RZ/G2UL
> > +          SoC.
> > +      allOf:
> > +        if:
>            - if:
>                properties:
> etc
> 
> Otherwise I think you can only have one in your allOf: which rather
> removes the point of having one.
> 
> I was surprised this passed the checks, so added another if to verify my
> reasoning...

It didn't apply, so checks didn't run. But it should fail not for the 
reason you correctly identified, but because 'allOf' is a DT property 
here not json-schema vocabulary. 

Rob
