Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D3C517FAE
	for <lists+linux-iio@lfdr.de>; Tue,  3 May 2022 10:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbiECI2B (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 May 2022 04:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbiECI2B (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2022 04:28:01 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1329C29800;
        Tue,  3 May 2022 01:24:29 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id fu47so12840636qtb.5;
        Tue, 03 May 2022 01:24:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9YnP6vfJr9TbfGLMjvmqv2bLcwhcFhdlsyuTJheg4pQ=;
        b=ZO2B810hT/H8jtfDkKGQluG7GIu/w1M0S5mHu2mabH8BTYLEjMTO/LbY9aZNti8Rpw
         ndIAFfFjLXK04LAJa982sIN7xa1033MU406pGDYyM/CFOFMnKEYnzHyDaCA75RaphPhz
         i8RrgNSyGmUksv2W7HZ1486NjV7CVA/A5Vw/zyDG7jOfA7qySXNK/pY5wRCwUHMwY4m9
         VqgKrkKqFiKtnFIoiR6iERr4xPKtVMqV93YK9TqIuRx+Sh06ftkXWI+KvSEM3E/2pBE4
         elMk1zmtZtfi9MT9+kOSdjT8pyiVe6N2KvQLxHDOH6ghV4hYgCPe/MNstUJkINqMedgK
         hs2Q==
X-Gm-Message-State: AOAM531eHyxMwtWgVDn9tNlZB/tr7WXs2M5V4/pCq7UmsMQDJnA2VgC9
        //RHPmZgMA+45387HxlzGTcv40VJMONi5A==
X-Google-Smtp-Source: ABdhPJxLhZB+BFv6U4nRiTaAorrPo4ao71BBtJis8n9ErltZ/vgZ/bZCaolRhEIfS4NAbB5cRlE5Eg==
X-Received: by 2002:a05:622a:64f:b0:2e0:6a11:7b0d with SMTP id a15-20020a05622a064f00b002e06a117b0dmr13556043qtb.9.1651566268059;
        Tue, 03 May 2022 01:24:28 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id c15-20020a05620a268f00b0069ff48599c5sm1743511qkp.107.2022.05.03.01.24.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 01:24:27 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id r11so7026209ybg.6;
        Tue, 03 May 2022 01:24:27 -0700 (PDT)
X-Received: by 2002:a05:6902:82:b0:649:d5a0:9edd with SMTP id
 h2-20020a056902008200b00649d5a09eddmr2751350ybs.202.1651566266746; Tue, 03
 May 2022 01:24:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220501081523.22479-1-biju.das.jz@bp.renesas.com>
 <OSZPR01MB7019299D00A457C964CC403DAAC19@OSZPR01MB7019.jpnprd01.prod.outlook.com>
 <OS0PR01MB5922CCDFA8C3648F49A10EB186C19@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdWHemJn2KUBzYA8oVYgtG4sX2H=4-AdRuF0uZ2EgQEk6w@mail.gmail.com>
 <OSZPR01MB701947B40187981ACE6A271DAAC09@OSZPR01MB7019.jpnprd01.prod.outlook.com>
 <OS0PR01MB59222A7FAB923579C21D6B6286C09@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdV5F9RMyKbqV=zUAhH2UZuRCoc5Y+WC_GNvG5JioMnFGA@mail.gmail.com>
 <OS0PR01MB5922BCC070E328A9B5AA6AA486C09@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdWy9-68EUdjZOVDU-DTAYgijeUZ1u+_nGE0pVBZSX=e1w@mail.gmail.com> <OS0PR01MB5922EE8A730DB8A97C9CEF5086C09@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB5922EE8A730DB8A97C9CEF5086C09@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 3 May 2022 10:24:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVj9bshjPHeoamKE2oLmctJxNA6wnUsqr7gAVLj9xLEEQ@mail.gmail.com>
Message-ID: <CAMuHMdVj9bshjPHeoamKE2oLmctJxNA6wnUsqr7gAVLj9xLEEQ@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Biju,

On Tue, May 3, 2022 at 10:05 AM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > Subject: Re: [PATCH] iio: adc: rzg2l_adc: Add support for RZ/G2UL ADC
> > On Tue, May 3, 2022 at 9:47 AM Biju Das <biju.das.jz@bp.renesas.com>
> > wrote:
> > > > Subject: Re: [PATCH] iio: adc: rzg2l_adc: Add support for RZ/G2UL
> > > >ADC  On Tue, May 3, 2022 at 8:54 AM Biju Das
> > > > These can be dropped, as dtbs_check should take care of that.
> > >
> > > OK, Will remove this.
> >
> > Actually it's OK to keep them, as they are the upper limits supported by
> > the hardware block.
>
> You mean use upper limit of 2 for RZ/G2UL and 8 for RZ/G2L, right?

No, I did mean RZG2L_ADC_MAX_CHANNELS, which is the upper limit of
the hardware block.

> For eg:-
>  If we use, Channel0 and channel 2 :- this will be caught in dtbs as
>
> /home/biju/rzg2l-linux/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.example.dtb: adc@10059000: channel@2:reg:0:0: 2 is greater than the maximum of 1
>
> But for run time, we don't want to this to happen for RZ/G2UL??

It will be caught at "make dtbs_check" time.
And at test time, as it won't work anyway --- do not post un-tested
patches ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
