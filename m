Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30853522CA8
	for <lists+linux-iio@lfdr.de>; Wed, 11 May 2022 08:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbiEKGyJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 May 2022 02:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbiEKGyI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 May 2022 02:54:08 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8DE243101;
        Tue, 10 May 2022 23:54:06 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id v14so193601qtc.3;
        Tue, 10 May 2022 23:54:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/QsfijfhkpwL1HOkthPrJtGvx7zmE52NS4pRcIJdNx8=;
        b=msgmJ6AvG2JajmxHiH10ftlKx97GEQqDONU/2NzmZ2hPCXbwIyB2RUT6uUS5EyME4v
         DxryYNCMk+s3UBtDCJ118FpMT/W1bxxJs4nJLgSt/AQ/j+jC4hF4Ud7WndC+swOI1ngk
         Z7FhUvCjGYHMEVp6OQLnUutoU+i8RIGOXJBLTju+FgjQNh/Ku5tHoRVMM2deCBLr7E3w
         a+WO2/p+pJi6R+uhx+qPWwgHOw7oksK2RUrHY8G6RFmuaMCMyMc/2CLtwe9AyZqn0cdz
         Clk0QRXfgitKk/+aoX5iF1WPW5efjsXt03pUOBulkJJZIioiiEtGmw46hK0ldwYhZRcR
         iKHg==
X-Gm-Message-State: AOAM5325GwlWTNQJzaVTVmBlY66f/afG9YpRxFu+qE+D44LFkLGnbW5b
        vSC5Cpl4TyxZAUb5Pi4ao66kupkBqQPWtA==
X-Google-Smtp-Source: ABdhPJwE9juGbXwbZxpwQCLgOGVgVn2mv3lERNMq54baAngIJNCqnUMUjRT/b6hajXpznJJTvGFvTw==
X-Received: by 2002:ac8:5d94:0:b0:2f3:cfc1:aa9f with SMTP id d20-20020ac85d94000000b002f3cfc1aa9fmr17497012qtx.281.1652252045765;
        Tue, 10 May 2022 23:54:05 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id n207-20020a3740d8000000b006a03cbb1323sm713242qka.65.2022.05.10.23.54.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 23:54:05 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id w187so2193221ybe.2;
        Tue, 10 May 2022 23:54:05 -0700 (PDT)
X-Received: by 2002:a25:6157:0:b0:645:8d0e:f782 with SMTP id
 v84-20020a256157000000b006458d0ef782mr23298730ybb.36.1652252044857; Tue, 10
 May 2022 23:54:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220505184037.511295-1-biju.das.jz@bp.renesas.com>
 <20220505184037.511295-2-biju.das.jz@bp.renesas.com> <CAMuHMdVV=MB8xa-Q-c_aZx9LGrW=9aP9iC3P-FMRSf-HiovOzA@mail.gmail.com>
 <OS0PR01MB59224E3B5A9E5D8FD5E55B2886C59@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdXDCDLhOSGgy9WWwawiHpE8C6isU2dLn6uSpY2gFAr38g@mail.gmail.com>
 <OS0PR01MB5922CD6D965A6138721F9A5886C99@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <YnqPTQVUNADk/YO4@robh.at.kernel.org> <OS0PR01MB59222568C4189A74FE83D6B186C99@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB59222568C4189A74FE83D6B186C99@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 11 May 2022 08:53:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVAxgsfnS1hjmrjT+pQrne8qGLejFgQ54+KDPdv=mq72g@mail.gmail.com>
Message-ID: <CAMuHMdVAxgsfnS1hjmrjT+pQrne8qGLejFgQ54+KDPdv=mq72g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: Document Renesas RZ/G2UL ADC
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Rob Herring <robh@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
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

On Tue, May 10, 2022 at 8:31 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: Document Renesas RZ/G2UL
> > ADC
> > patternProperties:
> >   '^channel@[2-7]$': false
>
> This fixes the validation for channels. But how do we restrict reg index between 0-1 ?
> The below example is passing instead of failing.
>       channel@0 {
>         reg = <5>;
>       };

I expect that to be flagged by the generic unit-address vs. reg check?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
