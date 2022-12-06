Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87A4643EE5
	for <lists+linux-iio@lfdr.de>; Tue,  6 Dec 2022 09:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbiLFIkh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Dec 2022 03:40:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiLFIkg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Dec 2022 03:40:36 -0500
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9412655;
        Tue,  6 Dec 2022 00:40:35 -0800 (PST)
Received: by mail-qt1-f182.google.com with SMTP id a27so13235829qtw.10;
        Tue, 06 Dec 2022 00:40:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=14rwrwErRJ+tInD2pg649j4kt6uhDdkQ30O3vQ8WKAg=;
        b=GBLPlvwihuL+UGK+MI27KVuB/WWHde1+BzQKn1aboAPiY+xlKaf1kldwwdIWcy6/zP
         LrV/kL/h1IqUxwelaS/+WKPM7V6Q8Oq7TJw7k83Ww1fn7ZS59bo7Unt1OTGU5aHI+YsP
         i3rtEDyj/O7e8mTcoPcTat9ssW+ZIfiXfeIfKPCuvjmVE0JYQTpGoYIwP050tOhsoBtj
         TTDm3NdaZdtfBd9dCg7KMbM7DwEm/+Dy/Va2b+hAzniW7HaRJ0xKxInjyMOD95ix3FPN
         jmK2gDpmP+9IrNTmou0/nzZQnvMEhI6bhqBB+1URhgfVOFkSQwj+hbzJBaNUTCVASXBl
         ROBA==
X-Gm-Message-State: ANoB5pl5L6aT7mN1XxcGPfPCFCYD6M82x33SdIgD+uM3+ekIhHI2v07O
        RoJod0tL20ccU3rkqcZPzSc6RgGc1Fh45Q==
X-Google-Smtp-Source: AA0mqf5a48KAVVJL92fXditk3rGn0KqCE7wIj7zt5afPGZ0uMfDZtKMxjw4PIr3NaoyXxqn7eRgqfw==
X-Received: by 2002:ac8:528a:0:b0:3a6:9b81:665a with SMTP id s10-20020ac8528a000000b003a69b81665amr14832468qtn.670.1670316033947;
        Tue, 06 Dec 2022 00:40:33 -0800 (PST)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id u6-20020a05620a430600b006fc5a1d9cd4sm14338729qko.34.2022.12.06.00.40.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 00:40:33 -0800 (PST)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-3e45d25de97so88319977b3.6;
        Tue, 06 Dec 2022 00:40:33 -0800 (PST)
X-Received: by 2002:a81:a8a:0:b0:37e:6806:a5f9 with SMTP id
 132-20020a810a8a000000b0037e6806a5f9mr659593ywk.47.1670316032857; Tue, 06 Dec
 2022 00:40:32 -0800 (PST)
MIME-Version: 1.0
References: <20221205145955.391526-1-biju.das.jz@bp.renesas.com>
 <20221205225042.GA2812115-robh@kernel.org> <OS0PR01MB592211AD4D0AE23DA7075DD5861B9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB592211AD4D0AE23DA7075DD5861B9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 6 Dec 2022 09:40:21 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX2=AwerQZS2cqR4exq_QNtt=Fwp5KBcmPr1qmOBNOSAg@mail.gmail.com>
Message-ID: <CAMuHMdX2=AwerQZS2cqR4exq_QNtt=Fwp5KBcmPr1qmOBNOSAg@mail.gmail.com>
Subject: Re: [PATCH 0/6] Add RZ/V2M Compare-Match Timer (TIM) support
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        William Breathitt Gray <william.gray@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Biju,

On Tue, Dec 6, 2022 at 9:13 AM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > Subject: Re: [PATCH 0/6] Add RZ/V2M Compare-Match Timer (TIM) support
> > On Mon, Dec 05, 2022 at 02:59:49PM +0000, Biju Das wrote:
> > > This patch series aims to add support for Compare-Match Timer (TIM)
> > > module found on RZ/V2M SoC.
> > >
> > > it is composed of 32 channels and channels 0-7 and 24-32 are reserved
> > > for ISP usage.
> > >
> > > Channel 22 is modelled as clock source and Channel 23 is modelled as
> > > clock event driver and the rest of the channels are modelled as
> > > counter driver as it provides
> >
> > Why did you pick those 2 counters for those functions?
>
> Currently it uses architecture timer for broadcast timer, so I thought
> Since TIM has 24 channels, use 1 channel for broadcast timer and 1
> Channel for clock source. But having said that SoC has an aarch64 architecture
> clock source strictly speaking we don't need this.
>
> > Unless the h/w blocks are different, this is an abuse of compatible
> > strings. What's the h/w difference that makes you care which counter the
> > OS picks? That's what the DT should describe. If any timer will do, just
> > let the OS pick.
>
> There is no HW difference. Same HW block can be used for mutually exclusive
> functionality.
>
> One is for Linux Clock source/event functionality((scheduler tick/broadcast tick etc) and
>
> the other purpose is to expose count and event ticks from this module to user space,
> so that wide range of applications can make use of it.
>
> If it is an abuse of compatible strings for mutually exclusive functionality
> , then I would like to drop clock source and use all the channels as
> Either clock events(for broadcast ticks and real time usage??) or as counters.
>
> If this is not OK, then I need to pick one. I will go with counters.
>
> Please share your thoughts.

Can't you handle this like sh_cmt.c does:

        /*
         * Use the first channel as a clock event device and the second channel
         * as a clock source. If only one channel is available use it for both.
         */

> > > 1) counter for counting
> > > 2) configurable counter value for generating timer interrupt
> > > 3) userspace event for each interrupt.
> > >
> > > logs:-
> > > Counter driver:
> > > Counter driver is tested by reading counts and interrupts tested by
> > > counter-example in tools/counter/counter_example.c
> > >
> > > Count snapshot value:
> > > 3114
> > > Output from counter_example when it triggers interrupts:
> > > Timestamp 0: 24142152969        Count 0: 5
> > > Error Message 0: Success
> > >
> > > Clock source:
> > > Clock source driver is tested by clock-source-switch app.
> > > [ 1275.703567] clocksource: Switched to clocksource arch_sys_counter
> > > [ 1275.710189] clocksource: Switched to clocksource a4000b00.timer
> >
> > Do you have any use case to really switch. Doing so disables the vDSO
> > access to the clocksource.
>
> Not really. Architecture timer should be sufficient for clocksource.

When multiple clocksources are registered, the clocksource
subsystems picks the best one anyway, right?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
