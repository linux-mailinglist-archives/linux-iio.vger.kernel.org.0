Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1BE52B032
	for <lists+linux-iio@lfdr.de>; Wed, 18 May 2022 03:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbiERBu0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 May 2022 21:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiERBuZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 May 2022 21:50:25 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C056546B9;
        Tue, 17 May 2022 18:50:24 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id q8so1009994oif.13;
        Tue, 17 May 2022 18:50:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LlSxDaLCHauGZrqN/giBvHhtN9qFCAg+kdEdfUnEMW0=;
        b=Gq6goUrrsts9A7AfFXeiOUK0pkOGhZ28KgXkIVwoW0dM39SE5SMqysCAwznFWgaWVz
         u9qpmdqkeIJCofOSyFbvhdTOJ8Dmqt7tVz+hTC49gVnwUNU5Z8xDof28X7y8VcSy5g3f
         LAkqNbqyIZmQTUr4qS8Z3tr1niBsfcEKGeKvnKCxNM1m1Kpe1/L6zKk4cL/iduecOJdV
         deKScvWEfHIEUhPe8TCzRB5IvcX9d+SQsafZvUvKNF4F6qX4oP0ShJ+JRbtW2nK1uxza
         lqOq1afNEPFYHfOKZ1vRJ2zLM+dy+SejeIZqy/aExcxkgWhDLiEoMgSME1NRBQE0XIGQ
         +VJw==
X-Gm-Message-State: AOAM5328qXmBslp1JxTb9UWQU9PG+AehopmgS+KT8s8nB/hQR0sIartq
        ANoiYD0LX9tj4sl75mlPg51jVbAjsA==
X-Google-Smtp-Source: ABdhPJxt57AaLIoBe4gd7/llGhBOKO95nQjGdxw8b1GbZW2CUw2ffSQMWlHULWyl9syuQtuDjXYv/A==
X-Received: by 2002:a05:6808:238f:b0:326:d4e1:a4b6 with SMTP id bp15-20020a056808238f00b00326d4e1a4b6mr12263742oib.241.1652838623504;
        Tue, 17 May 2022 18:50:23 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f19-20020a4ae613000000b0035eb4e5a6c6sm454635oot.28.2022.05.17.18.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 18:50:22 -0700 (PDT)
Received: (nullmailer pid 2056833 invoked by uid 1000);
        Wed, 18 May 2022 01:50:21 -0000
Date:   Tue, 17 May 2022 20:50:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: Document Renesas RZ/G2UL
 ADC
Message-ID: <20220518015021.GA2049643-robh@kernel.org>
References: <20220505184037.511295-1-biju.das.jz@bp.renesas.com>
 <20220505184037.511295-2-biju.das.jz@bp.renesas.com>
 <CAMuHMdVV=MB8xa-Q-c_aZx9LGrW=9aP9iC3P-FMRSf-HiovOzA@mail.gmail.com>
 <OS0PR01MB59224E3B5A9E5D8FD5E55B2886C59@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdXDCDLhOSGgy9WWwawiHpE8C6isU2dLn6uSpY2gFAr38g@mail.gmail.com>
 <OS0PR01MB5922CD6D965A6138721F9A5886C99@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <YnqPTQVUNADk/YO4@robh.at.kernel.org>
 <OS0PR01MB59222568C4189A74FE83D6B186C99@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdVAxgsfnS1hjmrjT+pQrne8qGLejFgQ54+KDPdv=mq72g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVAxgsfnS1hjmrjT+pQrne8qGLejFgQ54+KDPdv=mq72g@mail.gmail.com>
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

On Wed, May 11, 2022 at 08:53:53AM +0200, Geert Uytterhoeven wrote:
> Hi Biju,
> 
> On Tue, May 10, 2022 at 8:31 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > > Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: Document Renesas RZ/G2UL
> > > ADC
> > > patternProperties:
> > >   '^channel@[2-7]$': false
> >
> > This fixes the validation for channels. But how do we restrict reg index between 0-1 ?
> > The below example is passing instead of failing.
> >       channel@0 {
> >         reg = <5>;
> >       };
> 
> I expect that to be flagged by the generic unit-address vs. reg check?

No such thing. All the unit-address vs. reg value checks are bus 
specific (and in dtc). David G was against any generic/default check...

Rob
