Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1275F517D94
	for <lists+linux-iio@lfdr.de>; Tue,  3 May 2022 08:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiECGxZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Tue, 3 May 2022 02:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiECGxQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2022 02:53:16 -0400
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FBE38BC4;
        Mon,  2 May 2022 23:49:44 -0700 (PDT)
Received: by mail-qv1-f42.google.com with SMTP id ke5so11646639qvb.5;
        Mon, 02 May 2022 23:49:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GhPHIExV0gCYsFX1w3+Px8FQyneaGHXK6eUlIN/2vv4=;
        b=H0Ajqcxp4LWX7+pxJ+EWYLYLe/NfllnEb2PLNA6C6ut9Wgc66v3AFlMfpuKH2dy/Fm
         WXH8y3c8kqm25Pz8KhTz8uhZDGx3O0S8EZokvxioOsL809din+dg0pKfGPc3b0GT+2RQ
         y4phiKoUTrcxw84mnTR1XvRXLMyfD2+wIz4JiPGsy4oYdI9XwOW58SS14VYw4T9imN56
         RDeaCz8fvSShLm0FST1zRLuhfvoJbf9DLzQa/LqBArNbY07o1CxC9noR/Oz1vpCAFFJt
         Kl1NbuZm0qBkZzx+cmKtKlYlAsTV/NxuifrZeW/HNQ/LqnwzDc7xeZCtFu+ZGtzW5lX5
         Zj1w==
X-Gm-Message-State: AOAM530vzUAwD8PRRWN9atpb/v+nhdMvClRd7993VXztgEFmB0ttR4xc
        iKfrCZ6erBlRY2E+bduPmcxXQlY7h6ePVQ==
X-Google-Smtp-Source: ABdhPJzBnooPXwhNfb2HO0JLCwbBVlBO8Gyg5yhlhHK4EKQm3HE/9Gghz881yZrDY+4C5DgkTLgYXQ==
X-Received: by 2002:ad4:5f05:0:b0:456:306d:333d with SMTP id fo5-20020ad45f05000000b00456306d333dmr12513189qvb.16.1651560583602;
        Mon, 02 May 2022 23:49:43 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id d26-20020ac847da000000b002f39b99f66esm5511575qtr.8.2022.05.02.23.49.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 23:49:43 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-2ebf4b91212so170313017b3.8;
        Mon, 02 May 2022 23:49:43 -0700 (PDT)
X-Received: by 2002:a0d:d953:0:b0:2f7:d5ce:f204 with SMTP id
 b80-20020a0dd953000000b002f7d5cef204mr13859507ywe.502.1651560582837; Mon, 02
 May 2022 23:49:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220501081523.22479-1-biju.das.jz@bp.renesas.com>
 <OSZPR01MB7019299D00A457C964CC403DAAC19@OSZPR01MB7019.jpnprd01.prod.outlook.com>
 <OS0PR01MB5922CCDFA8C3648F49A10EB186C19@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdWHemJn2KUBzYA8oVYgtG4sX2H=4-AdRuF0uZ2EgQEk6w@mail.gmail.com> <OSZPR01MB701947B40187981ACE6A271DAAC09@OSZPR01MB7019.jpnprd01.prod.outlook.com>
In-Reply-To: <OSZPR01MB701947B40187981ACE6A271DAAC09@OSZPR01MB7019.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 3 May 2022 08:49:31 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWuA806Hbcw1Yw972ApKB+Jp8M5DYu-zdLenB564H4zFA@mail.gmail.com>
Message-ID: <CAMuHMdWuA806Hbcw1Yw972ApKB+Jp8M5DYu-zdLenB564H4zFA@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: rzg2l_adc: Add support for RZ/G2UL ADC
To:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Prabhakar,

On Tue, May 3, 2022 at 8:32 AM Prabhakar Mahadev Lad
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > -----Original Message-----
> > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > Sent: 02 May 2022 15:29
> > To: Biju Das <biju.das.jz@bp.renesas.com>
> > Cc: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>;
> > Jonathan Cameron <jic23@kernel.org>; Lars-Peter Clausen <lars@metafoo.de>;
> > linux-iio@vger.kernel.org; linux-renesas-soc@vger.kernel.org; Chris
> > Paterson <Chris.Paterson2@renesas.com>; Biju Das <biju.das@bp.renesas.com>
> > Subject: Re: [PATCH] iio: adc: rzg2l_adc: Add support for RZ/G2UL ADC
> >
> > On Mon, May 2, 2022 at 8:18 AM Biju Das <biju.das.jz@bp.renesas.com>
> > wrote:
> > > > Subject: RE: [PATCH] iio: adc: rzg2l_adc: Add support for RZ/G2UL
> > > > ADC
> > > > > Subject: [PATCH] iio: adc: rzg2l_adc: Add support for RZ/G2UL ADC
> > > > >
> > > > > ADC found on RZ/G2UL SoC is almost identical to RZ/G2L SoC, but
> > > > > RZ/G2UL has 2 analog input channels compared to 8 channels on
> > RZ/G2L.
> > > > > Therefore, added a new compatible to handle this difference.
> > > > >
> > > > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > > > ---
> > > > >  drivers/iio/adc/rzg2l_adc.c | 18 +++++++++++++-----
> > > > >  1 file changed, 13 insertions(+), 5 deletions(-)
> > > > >
> > > > I wonder if this changes is really required. RZ/G2UL can still use
> > > > the "renesas,rzg2l-adc". As the driver populates the channels
> > > > depending the number of elements in the array passed in the DTS and
> > > > not always 8 channels. For example on Renesas SMARC EVK only four
> > > > channels are populated.
> > >
> > > For me that restriction is coming from board design, as SoC is capable
> > > of handling 8 channels, But board design allows only 4.
> > >
> > > But on RZ/G2UL SoC, it is capable of handling only 2 channels. Other
> > channels are invalid for RZ/G2UL SoC.
> > >
> > > That is the difference.
> > >
> > > > With this we don't have to differentiate RZ/G2UL SoC if just add two
> > > > channel entries in the SoC DTSI and the driver will just create two
> > > > channels.
> > >
> > > > @Geert - your thoughts on this.
> >
> > It depends on the meaning of the channel subnodes: do they indicate
> > (a) the number of channels present on the SoC, or (b) the number of
> > channels used on the board?  The DT bindings are not clear about that.
> >
> > arch/arm64/boot/dts/renesas/r9a07g044.dtsi lists all channels and doesn't
> > keep any disabled, which suggests (a).
> > arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi does remove unused
> > channels, which suggests (b).
> >
> Yep its (b), since the SoC can support 8 channels the RZ/G2L SoC DTSI has 8 entries, If there comes a new EVK based on RZ/RZ/G2L SOC supporting all the channels so this holds good.
>
> > Is there any (perhaps performance?) reason we can't just use the number of
> > channels present in DT? "make dtbs_check" can still validate this against
> > the SoC-specific compatible value.
> >
> Nope performance issues. That is what the code does [0], It counts the number of available channels in DTS and depending on the count it populates the ADC channels. So for RZ/G2UL if we just add two channels in the SoC DTSI this holds good and the driver shall populate only two channels. And as you said the validation for the RZ/G2UL SoC for just two channels will be done by make dtbs_check and in the driver the condition still holds good 2 < 8.
>
> > Do we need to know at runtime both the number of channels physically
> > present and the number of channels used?  If yes, we either need to use
> > the SoC-specific compatible value, or add a num-channels property.
> >
> At runtime we just need to know the number of channels used on the board.

Then I think the driver can just match against the family-specific
compatible value, while "make dtbs_check" can use the SoC-specific
compatible value to validate the number of channels.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
