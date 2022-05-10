Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977F45220D9
	for <lists+linux-iio@lfdr.de>; Tue, 10 May 2022 18:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344405AbiEJQSI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 10 May 2022 12:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243286AbiEJQSF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 May 2022 12:18:05 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1005127E680;
        Tue, 10 May 2022 09:14:08 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id l16so19037737oil.6;
        Tue, 10 May 2022 09:14:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=twyOekr5lcReEOJrFoajS7C2Vqd64CFZqhetA36D0+4=;
        b=hf49OawfjPZkYQPLU++G9VbNcN/rvJ+IFYPJrLkdsCu0QlQKNHDskOHiwi/+Ov8jbx
         dizHxDektQJlt7iWCY1CkoGLEveRqKXdut0dHADBdWdM8KpfveAzYaWA+qmxBGsmjdVC
         Wb8CGxSB2Mia4stSYCSTA+JhB/9ts8YZUjYip/zG5bVh6ca0nlVhMh1fA9/nqLN2CHL2
         QUZHusu/QUmEFPIFOBmuyq0MCR9ODZYZSB+gLrvy1T6Lk+Zv+pzUvHTS1bQXIPliLjEu
         aANGukOCfHHcY3MoslLqKjCldz9nghj61m2bj1tIMgVAfTvlZOvTtaN2+Z2M8596jWxz
         ENrA==
X-Gm-Message-State: AOAM531xFLgPmcTE623IaYrjcv06VMlBXEXvWVjhtY+cRDWt/YEQGwGT
        22fH9uZmi7KHDftClAdv0g==
X-Google-Smtp-Source: ABdhPJx3kZiSEKHMbhkuRcw/WunWjZIOzCU3x9eNZ8ytFAjHlNlsfZUH1bWHLvKUu2LtM7sP3AfPcQ==
X-Received: by 2002:a05:6808:1287:b0:326:d23f:f251 with SMTP id a7-20020a056808128700b00326d23ff251mr389186oiw.155.1652199247227;
        Tue, 10 May 2022 09:14:07 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r22-20020a056830081600b0060603221261sm5987187ots.49.2022.05.10.09.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 09:14:06 -0700 (PDT)
Received: (nullmailer pid 2119596 invoked by uid 1000);
        Tue, 10 May 2022 16:14:05 -0000
Date:   Tue, 10 May 2022 11:14:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Jonathan Cameron <jic23@kernel.org>,
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
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: Document Renesas RZ/G2UL
 ADC
Message-ID: <YnqPTQVUNADk/YO4@robh.at.kernel.org>
References: <20220505184037.511295-1-biju.das.jz@bp.renesas.com>
 <20220505184037.511295-2-biju.das.jz@bp.renesas.com>
 <CAMuHMdVV=MB8xa-Q-c_aZx9LGrW=9aP9iC3P-FMRSf-HiovOzA@mail.gmail.com>
 <OS0PR01MB59224E3B5A9E5D8FD5E55B2886C59@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdXDCDLhOSGgy9WWwawiHpE8C6isU2dLn6uSpY2gFAr38g@mail.gmail.com>
 <OS0PR01MB5922CD6D965A6138721F9A5886C99@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OS0PR01MB5922CD6D965A6138721F9A5886C99@OS0PR01MB5922.jpnprd01.prod.outlook.com>
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

On Tue, May 10, 2022 at 05:54:59AM +0000, Biju Das wrote:
> Hi Geert,
> 
> Thanks for the feedback.
> 
> > Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: Document Renesas RZ/G2UL
> > ADC
> > 
> > Hi Biju,
> > 
> > On Fri, May 6, 2022 at 10:40 AM Biju Das <biju.das.jz@bp.renesas.com>
> > wrote:
> > > > Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: Document Renesas
> > > > RZ/G2UL On Thu, May 5, 2022 at 8:40 PM Biju Das
> > <biju.das.jz@bp.renesas.com> wrote:
> > > > > Document Renesas RZ/G2UL ADC bindings. RZ/G2UL ADC is almost
> > > > > identical to RZ/G2L, but it has 2 analog input channels compared
> > > > > to 8 channels on the RZ/G2L.
> > > > >
> > > > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > 
> > > > > ---
> > > > > a/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
> > > > > +++ b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.
> > > > > +++ yaml
> > > > > @@ -74,18 +75,48 @@ patternProperties:
> > > > >        Represents the external channels which are connected to the
> > ADC.
> > > > >
> > > > >      properties:
> > > > > -      reg:
> > > > > -        description: |
> > > > > -          The channel number. It can have up to 8 channels numbered
> > from
> > > > 0 to 7.
> > > > > -        items:
> > > > > -          - minimum: 0
> > > > > -            maximum: 7
> > > > > -
> > > > > +      reg: true
> > > > >      required:
> > > > >        - reg
> > > > >
> > > > >      additionalProperties: false
> > > > >
> > > > > +allOf:
> > > > > +  - if:
> > > > > +      properties:
> > > > > +        compatible:
> > > > > +          contains:
> > > > > +            const: renesas,r9a07g043-adc
> > > > > +    then:
> > > > > +      patternProperties:
> > > > > +        "^channel@[0-7]$":
> > > >
> > > > [0-1]
> > >
> > > Looks like with this change, validation doesn't work as expected.
> > 
> > OK, keep it at [0-7].
> 
> OK.
> 
> > 
> > > > > +          type: object
> > > > > +          properties:
> > > > > +            reg:
> > > > > +              description: |
> > > > > +                The channel number. It can have up to 2 channels
> > > > numbered from 0 to 1.
> > > > > +              items:
> > > > > +                - minimum: 0
> > > > > +                  maximum: 1
> > > > > +  - if:
> > > > > +      properties:
> > > > > +        compatible:
> > > > > +          contains:
> > > > > +            enum:
> > > > > +              - renesas,r9a07g044-adc
> > > > > +              - renesas,r9a07g054-adc
> > > > > +    then:
> > > > > +      patternProperties:
> > > > > +        "^channel@[0-7]$":
> > > > > +          type: object
> > > > > +          properties:
> > > > > +            reg:
> > > > > +              description: |
> > > > > +                The channel number. It can have up to 8 channels
> > > > numbered from 0 to 7.
> > > > > +              items:
> > > > > +                - minimum: 0
> > > > > +                  maximum: 7
> > > > > +
> > > > >  additionalProperties: false
> > > > >
> > > > >  examples:
> > > >
> > > > The rest LGTM, but I'm wondering if more of the channel subnodes
> > > > description can be factored out to the common part?
> > >
> > > You mean above reg: true?? ie, add as part of the below description??
> > >
> > > type: object
> > >     description: |
> > >       Represents the external channels which are connected to the ADC.
> > 
> > I think I've found a solution while converting the R-Car Gen2 USB PHY
> > bindings.  You can mark channels 3-7 false on RZ/G2UL, cfr. the second
> > channel on RZ/G1C in "[PATCH] dt-bindings:
> 
> I just added similar check for RZ/G2UL by making channel@2-7 false and But dt-binding checks is passing
> with channel@2-7 present in the example. Validation should fail, but it is passing. I will go with current implementation, as it does proper validation.
> 
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        const: renesas,r9a07g043-adc
> +  then:
> +    properties:
> +      channel@2: false
> +      channel@3: false
> +      channel@4: false
> +      channel@5: false
> +      channel@6: false
> +      channel@7: false

patternProperties:
  '^channel@[2-7]$': false

>  
>  additionalProperties: false
>  
> @@ -125,7 +105,7 @@ examples:
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
>  
>      adc: adc@10059000 {
> -      compatible = "renesas,r9a07g044-adc", "renesas,rzg2l-adc";
> +      compatible = "renesas,r9a07g043-adc", "renesas,rzg2l-adc";
> 
> $ make ARCH=arm64 DT_CHECKER_FLAGS=-m DT_SCHEMA_FILES=Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml CROSS_COMPILE=~/gcc-arm-10.3-2021.07-x86_64-aarch64-none-linux-gnu/bin/aarch64-none-linux-gnu- dt_binding_check -j8
>   LINT    Documentation/devicetree/bindings
>   DTEX    Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.example.dts
>   CHKDT   Documentation/devicetree/bindings/processed-schema.json
>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>   DTC     Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.example.dtb
>   CHECK   Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.example.dtb
> 
> Cheers,
> Biju
> 
> 
