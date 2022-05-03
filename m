Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44832517ECA
	for <lists+linux-iio@lfdr.de>; Tue,  3 May 2022 09:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbiECH00 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 May 2022 03:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbiECH0S (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2022 03:26:18 -0400
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAC42AEB;
        Tue,  3 May 2022 00:22:19 -0700 (PDT)
Received: by mail-qv1-f52.google.com with SMTP id c8so4540653qvh.10;
        Tue, 03 May 2022 00:22:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IUKGWDrL6/pXq4WbEOHgu62nMllQr4LM/X3ZBEoYdEo=;
        b=aijilUO3c/6SOqSFWb+phSmDR1lvU0aRFEGHa1X6Q93FRP/1GyQwP+ULPF9Z/baKmH
         XwZ6PhNXfet+aKekEOzG9LpC2Eh1CAIWFMkmXEu+l+grwj0a3INRB9+qzEXELKbs/s8V
         IudqXIKqRUJ1rB6USr6T3rYYGISgIlZ1E1qJrj14fFcxRTSh1w3cTqWteYKBTmLa93OQ
         Tb0yiNrYEljp1Sh4LIOK7C1MS0F8OhNZlKT8yAeBZpqavCyMAJtJc91Q7N8tOxdm5tA4
         KhO3rEg6WeOKVdf+phz+TXp/pN+pFLWB6jsEA8dLzjsD2V4lUV3n63F4z+SX0ZDVyan/
         5+xQ==
X-Gm-Message-State: AOAM532nsVfh9mGz9sHu06jfIypq/pLhq1d+rULnjdWcsl8wsrDmoXyu
        nOya9czyK36ldLupNm0aR1dvmYsXGTBqZw==
X-Google-Smtp-Source: ABdhPJy3MtaSz3gnQRqvIuO6T8pqGdMlC9Q/J6Y5P/n4Njip7fVVpKwMZn0gw4S2VR0fPyvkbjWGLQ==
X-Received: by 2002:a05:6214:625:b0:441:4934:3c8d with SMTP id a5-20020a056214062500b0044149343c8dmr12241375qvx.40.1651562538138;
        Tue, 03 May 2022 00:22:18 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id c5-20020ac86605000000b002f39b99f6a0sm5438087qtp.58.2022.05.03.00.22.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 00:22:17 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id s30so29705031ybi.8;
        Tue, 03 May 2022 00:22:17 -0700 (PDT)
X-Received: by 2002:a05:6902:82:b0:649:d5a0:9edd with SMTP id
 h2-20020a056902008200b00649d5a09eddmr2654052ybs.202.1651562536998; Tue, 03
 May 2022 00:22:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220501081523.22479-1-biju.das.jz@bp.renesas.com>
 <OSZPR01MB7019299D00A457C964CC403DAAC19@OSZPR01MB7019.jpnprd01.prod.outlook.com>
 <OS0PR01MB5922CCDFA8C3648F49A10EB186C19@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdWHemJn2KUBzYA8oVYgtG4sX2H=4-AdRuF0uZ2EgQEk6w@mail.gmail.com>
 <OSZPR01MB701947B40187981ACE6A271DAAC09@OSZPR01MB7019.jpnprd01.prod.outlook.com>
 <OS0PR01MB59222A7FAB923579C21D6B6286C09@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB59222A7FAB923579C21D6B6286C09@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 3 May 2022 09:22:04 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV5F9RMyKbqV=zUAhH2UZuRCoc5Y+WC_GNvG5JioMnFGA@mail.gmail.com>
Message-ID: <CAMuHMdV5F9RMyKbqV=zUAhH2UZuRCoc5Y+WC_GNvG5JioMnFGA@mail.gmail.com>
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

On Tue, May 3, 2022 at 8:54 AM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > > Subject: Re: [PATCH] iio: adc: rzg2l_adc: Add support for RZ/G2UL ADC
> > > On Mon, May 2, 2022 at 8:18 AM Biju Das <biju.das.jz@bp.renesas.com>
> > > wrote:
> > > > > Subject: RE: [PATCH] iio: adc: rzg2l_adc: Add support for RZ/G2UL
> > > > > ADC
> > > > > > Subject: [PATCH] iio: adc: rzg2l_adc: Add support for RZ/G2UL
> > > > > > ADC
> > > > > >
> > > > > > ADC found on RZ/G2UL SoC is almost identical to RZ/G2L SoC, but
> > > > > > RZ/G2UL has 2 analog input channels compared to 8 channels on
> > > RZ/G2L.
> > > > > > Therefore, added a new compatible to handle this difference.
> > > > > >
> > > > > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > > > > ---
> > > > > >  drivers/iio/adc/rzg2l_adc.c | 18 +++++++++++++-----
> > > > > >  1 file changed, 13 insertions(+), 5 deletions(-)
> > > > > >
> > > > > I wonder if this changes is really required. RZ/G2UL can still use
> > > > > the "renesas,rzg2l-adc". As the driver populates the channels
> > > > > depending the number of elements in the array passed in the DTS
> > > > > and not always 8 channels. For example on Renesas SMARC EVK only
> > > > > four channels are populated.
> > > >
> > > > For me that restriction is coming from board design, as SoC is
> > > > capable of handling 8 channels, But board design allows only 4.
> > > >
> > > > But on RZ/G2UL SoC, it is capable of handling only 2 channels. Other
> > > channels are invalid for RZ/G2UL SoC.
> > > >
> > > > That is the difference.
> > > >
> > > > > With this we don't have to differentiate RZ/G2UL SoC if just add
> > > > > two channel entries in the SoC DTSI and the driver will just
> > > > > create two channels.
> > > >
> > > > > @Geert - your thoughts on this.
> > >
> > > It depends on the meaning of the channel subnodes: do they indicate
> > > (a) the number of channels present on the SoC, or (b) the number of
> > > channels used on the board?  The DT bindings are not clear about that.
> > >
> > > arch/arm64/boot/dts/renesas/r9a07g044.dtsi lists all channels and
> > > doesn't keep any disabled, which suggests (a).
> > > arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi does remove unused
> > > channels, which suggests (b).
> > >
> > Yep its (b), since the SoC can support 8 channels the RZ/G2L SoC DTSI has
> > 8 entries, If there comes a new EVK based on RZ/RZ/G2L SOC supporting all
> > the channels so this holds good.
> >
> > > Is there any (perhaps performance?) reason we can't just use the
> > > number of channels present in DT? "make dtbs_check" can still validate
> > > this against the SoC-specific compatible value.
> > >
> > Nope performance issues. That is what the code does [0], It counts the
> > number of available channels in DTS and depending on the count it
> > populates the ADC channels. So for RZ/G2UL if we just add two channels in
> > the SoC DTSI this holds good and the driver shall populate only two
> > channels. And as you said the validation for the RZ/G2UL SoC for just two
> > channels will be done by make dtbs_check and in the driver the condition
> > still holds good 2 < 8.
> >
> > > Do we need to know at runtime both the number of channels physically
> > > present and the number of channels used?  If yes, we either need to
> > > use the SoC-specific compatible value, or add a num-channels property.
> > >
> > At runtime we just need to know the number of channels used on the board.
> >
> > [0]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree
> > /drivers/iio/adc/rzg2l_adc.c?h=v5.18-rc5#n335
> >
>
> DT describes hardware and here there is a hardware difference 2 channels(RZ/G2UL) vs 8 channel(RZ/G2L).

Yes, that's why there are two compatible values: the SoC-specific one,
and the family-specific one.

> Krzysztof Kozlowski, wants to take care this difference in dt-bindings by adding some validation checks.

The maximum number of channels is implied by the SoC-specific compatible value.
Invalid channel numbers can be verified using "make dtbs_check".

> If we all are agreeing to drop dt-binding validation for channels, I am ok with that.

No, I want to keep dt-binding validation for channels.
But I think the driver should not validate the number of channels,
as this should have been caught at dtbs_check time (and won't work
anyway).

> But from driver point, still it need SoC-specific compatible value, or add a num-channels property as
> there is hardware difference RZG2UL_ADC_MAX_CHANNELS(2) vs RZG2L_ADC_MAX_CHANNELS(8)

From reading the hardware manual, it only matters for channels actually
used. Whether the other channels are unused, or non-existent, doesn't
seem to matter at all?

TBH, I think they're really the same hardware block, they just didn't
wire up channels 3-7 on RZ/G2UL (see e.g. bits 7 to 2 in the ADM2
register, which are not fixed to zero like the upper bits, but have an
(undefined) initial value, which must be retained when written).

> Currently driver validation only holds good for RZ/G2L SoC.
>
> See [1], [2], [3] and [4]
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/iio/adc/rzg2l_adc.c?h=v5.18-rc5#n324
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/iio/adc/rzg2l_adc.c?h=v5.18-rc5#n340

These can be dropped, as dtbs_check should take care of that.

> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/iio/adc/rzg2l_adc.c?h=v5.18-rc5#n263

Looks like this condition can never happen, so the check can be removed?

> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/iio/adc/rzg2l_adc.c?h=v5.18-rc5#n293

That check can stay (RZG2L_ADC_MAX_CHANNELS is the maximum number of
channels supported by the IP block), or the limit can be replaced by
the highest channel number found, or just BITS_PER_LONG (no invalid
bits can be set anyway, and intst was masked by RZG2L_ADSTS_INTST_MASK
= 0xff).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
