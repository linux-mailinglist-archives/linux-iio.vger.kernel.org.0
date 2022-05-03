Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C100517F3C
	for <lists+linux-iio@lfdr.de>; Tue,  3 May 2022 09:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbiECH5O (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 May 2022 03:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbiECH5M (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2022 03:57:12 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1410022B39;
        Tue,  3 May 2022 00:53:40 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id x9so12804551qts.6;
        Tue, 03 May 2022 00:53:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SsE0cW4sgvMKofwRBe5+2vmNNBLcxmEvN1ZNpDOsjIw=;
        b=oxNrBi0UV6nOtlwdqxKmtsiywIuTdTkcvCPHYDvhWV8Q0O5IhDq1nZ7KB2rArK3a4A
         hkJgjtvr+y2jkYDQnCVjO2HFzMz3Tq7dcVCCJsGWFZG+Te07gJu54b87pUe43/1VPKXo
         MTeDN5S3H9GmZ8G4ewqIEm9NE/5+3/PG5R3fUrCZCdLPuoakfUhXjlkXnDTWXwaqnC0v
         tZv+lG7WCqAkX9IjSpQa6C6xETV4Zj0avM5hd1SBPx4JdN82Y12DBlHHue4BjnuHaNdb
         M4+XKaaI3jyMdICw+HNCUZPb6MklaPxRzgcer7LqgeeT5Y/RXwtyCJY0NXGci7D4/7HN
         426A==
X-Gm-Message-State: AOAM5324urSswy8aVVP9cUeDhECg1im8yw32zjd6CP4lM2ba/YqtLRd0
        6pG7HTXht5PsfopLdh1D3DH8bk/Zd52ReA==
X-Google-Smtp-Source: ABdhPJxFsthAuoeG25TSMO3bKsEcD12prc9L0cQrw7FXABbzQXxrm6gj0jR5pFRDbDHp597zMmx8yA==
X-Received: by 2002:ac8:5f8e:0:b0:2f3:5f89:e4ec with SMTP id j14-20020ac85f8e000000b002f35f89e4ecmr13699644qta.262.1651564419048;
        Tue, 03 May 2022 00:53:39 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id w24-20020a05620a095800b0069fc13ce23csm5325578qkw.109.2022.05.03.00.53.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 00:53:38 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-2f7d19cac0bso171147907b3.13;
        Tue, 03 May 2022 00:53:38 -0700 (PDT)
X-Received: by 2002:a81:6588:0:b0:2f8:b75e:1e1a with SMTP id
 z130-20020a816588000000b002f8b75e1e1amr14598522ywb.358.1651564417875; Tue, 03
 May 2022 00:53:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220501081523.22479-1-biju.das.jz@bp.renesas.com>
 <OSZPR01MB7019299D00A457C964CC403DAAC19@OSZPR01MB7019.jpnprd01.prod.outlook.com>
 <OS0PR01MB5922CCDFA8C3648F49A10EB186C19@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdWHemJn2KUBzYA8oVYgtG4sX2H=4-AdRuF0uZ2EgQEk6w@mail.gmail.com>
 <OSZPR01MB701947B40187981ACE6A271DAAC09@OSZPR01MB7019.jpnprd01.prod.outlook.com>
 <OS0PR01MB59222A7FAB923579C21D6B6286C09@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdV5F9RMyKbqV=zUAhH2UZuRCoc5Y+WC_GNvG5JioMnFGA@mail.gmail.com> <OS0PR01MB5922BCC070E328A9B5AA6AA486C09@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB5922BCC070E328A9B5AA6AA486C09@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 3 May 2022 09:53:26 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWy9-68EUdjZOVDU-DTAYgijeUZ1u+_nGE0pVBZSX=e1w@mail.gmail.com>
Message-ID: <CAMuHMdWy9-68EUdjZOVDU-DTAYgijeUZ1u+_nGE0pVBZSX=e1w@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: rzg2l_adc: Add support for RZ/G2UL ADC
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
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

On Tue, May 3, 2022 at 9:47 AM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > Subject: Re: [PATCH] iio: adc: rzg2l_adc: Add support for RZ/G2UL ADC
> > On Tue, May 3, 2022 at 8:54 AM Biju Das <biju.das.jz@bp.renesas.com>
> > wrote:
> >https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/iio/adc/rzg2l_adc.c?h=v5.18-rc5#n324
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/iio/adc/rzg2l_adc.c?h=v5.18-rc5#n340
> > These can be dropped, as dtbs_check should take care of that.
>
> OK, Will remove this.

Actually it's OK to keep them, as they are the upper limits supported
by the hardware block.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
