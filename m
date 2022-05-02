Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02DE517192
	for <lists+linux-iio@lfdr.de>; Mon,  2 May 2022 16:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349867AbiEBOco (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 May 2022 10:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385496AbiEBOcn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 May 2022 10:32:43 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D37910FF4;
        Mon,  2 May 2022 07:29:14 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id hh4so11186698qtb.10;
        Mon, 02 May 2022 07:29:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4HNuvqLkw5GUbk+NYgaaNUf5vWaZBRKwBR44lb5mJzw=;
        b=B4wo5DGeorz7C8+vsHFmrLnP26IYcTApyH6WB9nyePyEHcQmDjld/uVw6eCYbrds/7
         AkvMKdda+rBin0R21FotYnVa+UkKtuONF6h4uxzJptu6EnME8OChV0JA5c5GwOOMaRde
         NjF3MnIH853sRe3KfaiNWN+szgoDJnJeJg56Z8R1youoZK8BfG1f/tomt3NH8A7yLItd
         EINBnjJ6uWJ4tq4hZGG1hk/vXcZPWpwrTNcQHhM9qyutVtTDLIarYMtl9evgvyKooaqu
         TleCocUzl6o1yxhZ1FSWuUhCWAZA7IydFXje7QuwwPWZZ69rxGsQyFd0c5TPbFCfO4xN
         n1Qg==
X-Gm-Message-State: AOAM532Q+OftOZbFiUeA/3MIIjZkpQagu3yRrqxrwiWiJvdRqSs38A21
        acUZbXMPjsSH9ThgpJozcRO5rfd1UJMfCw==
X-Google-Smtp-Source: ABdhPJzl66vhnCret54B1u8lt4Oan1b1hm2TVAMg1FP7eTA8YMv7XevM9Y6Fb9A/GHaaMvVeZvlNJQ==
X-Received: by 2002:ac8:7d08:0:b0:2f1:e349:adb7 with SMTP id g8-20020ac87d08000000b002f1e349adb7mr10317535qtb.616.1651501753661;
        Mon, 02 May 2022 07:29:13 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id m2-20020a37a302000000b0069ff51425a2sm603071qke.120.2022.05.02.07.29.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 07:29:13 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-2f16645872fso149533907b3.4;
        Mon, 02 May 2022 07:29:13 -0700 (PDT)
X-Received: by 2002:a81:234b:0:b0:2f8:4082:bbd3 with SMTP id
 j72-20020a81234b000000b002f84082bbd3mr11241893ywj.47.1651501752992; Mon, 02
 May 2022 07:29:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220501081523.22479-1-biju.das.jz@bp.renesas.com>
 <OSZPR01MB7019299D00A457C964CC403DAAC19@OSZPR01MB7019.jpnprd01.prod.outlook.com>
 <OS0PR01MB5922CCDFA8C3648F49A10EB186C19@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB5922CCDFA8C3648F49A10EB186C19@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 2 May 2022 16:29:01 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWHemJn2KUBzYA8oVYgtG4sX2H=4-AdRuF0uZ2EgQEk6w@mail.gmail.com>
Message-ID: <CAMuHMdWHemJn2KUBzYA8oVYgtG4sX2H=4-AdRuF0uZ2EgQEk6w@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: rzg2l_adc: Add support for RZ/G2UL ADC
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
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

On Mon, May 2, 2022 at 8:18 AM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > Subject: RE: [PATCH] iio: adc: rzg2l_adc: Add support for RZ/G2UL ADC
> > > Subject: [PATCH] iio: adc: rzg2l_adc: Add support for RZ/G2UL ADC
> > >
> > > ADC found on RZ/G2UL SoC is almost identical to RZ/G2L SoC, but
> > > RZ/G2UL has 2 analog input channels compared to 8 channels on RZ/G2L.
> > > Therefore, added a new compatible to handle this difference.
> > >
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > ---
> > >  drivers/iio/adc/rzg2l_adc.c | 18 +++++++++++++-----
> > >  1 file changed, 13 insertions(+), 5 deletions(-)
> > >
> > I wonder if this changes is really required. RZ/G2UL can still use the
> > "renesas,rzg2l-adc". As the driver populates the channels depending the
> > number of elements in the array passed in the DTS and not always 8
> > channels. For example on Renesas SMARC EVK only four channels are
> > populated.
>
> For me that restriction is coming from board design, as SoC is capable of handling 8 channels,
> But board design allows only 4.
>
> But on RZ/G2UL SoC, it is capable of handling only 2 channels. Other channels are invalid for RZ/G2UL SoC.
>
> That is the difference.
>
> > With this we don't have to differentiate RZ/G2UL SoC if just add two
> > channel entries in the SoC DTSI and the driver will just create two
> > channels.
>
> > @Geert - your thoughts on this.

It depends on the meaning of the channel subnodes: do they indicate
(a) the number of channels present on the SoC, or (b) the number of
channels used on the board?  The DT bindings are not clear about that.

arch/arm64/boot/dts/renesas/r9a07g044.dtsi lists all channels and
doesn't keep any disabled, which suggests (a).
arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi does remove unused
channels, which suggests (b).

Is there any (perhaps performance?) reason we can't just use the number
of channels present in DT? "make dtbs_check" can still validate this
against the SoC-specific compatible value.

Do we need to know at runtime both the number of channels physically
present and the number of channels used?  If yes, we either need to
use the SoC-specific compatible value, or add a num-channels property.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
