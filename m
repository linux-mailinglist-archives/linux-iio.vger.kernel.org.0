Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B160359AD81
	for <lists+linux-iio@lfdr.de>; Sat, 20 Aug 2022 13:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344637AbiHTLcG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 20 Aug 2022 07:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbiHTLcF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 20 Aug 2022 07:32:05 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E4A7F274
        for <linux-iio@vger.kernel.org>; Sat, 20 Aug 2022 04:32:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 22C32CE0945
        for <linux-iio@vger.kernel.org>; Sat, 20 Aug 2022 11:32:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B25C433D6;
        Sat, 20 Aug 2022 11:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660995121;
        bh=x92xyb/sVL3yQBwE0vJmCTZp2Quayp28o9eTGtsJK2s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FYzaAgMh36cJRHQPeKTYv295Q04JBUJz0rGQSeo8HUafGM+FWjQe5JjWfx8Y2ufWw
         eXDI2xWuoIYya64wpmUknLB1wpkal+YEljiJ3x2CJ8ijWGy63FYkxRizX9InJloCRk
         x4dQnjVfR9LdutFVcYAcWXYv9Gh2dgw8HU6Lt4lZlBWfu1ry99DfqjmQMqBt7tP+45
         2LzOYzyvEjBVU4WLLXkMy7G5ZEm7pY+7vBFfEtWhuyIuaFRfIPiHQBAF+IdWqq2rVV
         zDt0Uhupz2MnCPaOMc6wLnjigscuOvnSJcYxALY79wGCK5bwXWhUnwNYKFkO2w4ua3
         tqYLp9iS2a6HQ==
Date:   Sat, 20 Aug 2022 12:42:35 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Uwe =?UTF-8?B?S2xlaW5l?= =?UTF-8?B?LUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>, Heiko Stuebner <heiko@sntech.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        David Wu <david.wu@rock-chips.com>,
        Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nuno Sa <nuno.sa@analog.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Simon Xue <xxm@rock-chips.com>
Subject: Re: [PATCH 06/13] iio: adc: rockchip_saradc: Benefit from
 devm_clk_get_enabled() to simplify
Message-ID: <20220820124235.223d4a7e@jic23-huawei>
In-Reply-To: <bd8472f2-e4d0-2a63-98a5-5e1fe8ad6255@metafoo.de>
References: <20220808204740.307667-1-u.kleine-koenig@pengutronix.de>
        <20220808204740.307667-6-u.kleine-koenig@pengutronix.de>
        <20220813173142.76774c97@jic23-huawei>
        <CAHp75VeUV2+-V=TbQwx4Chr-xWU4AmRq-mG8Z8XTkwQmx4qvhQ@mail.gmail.com>
        <20220814213058.dgoxpkoxpn6s4ojj@pengutronix.de>
        <CAHp75VfD9xoDYyWH3NB9btNW2pBmTH_jBmwjOSUbOQ+Ei_k20w@mail.gmail.com>
        <20220815074149.jrkeevc3uxoo6ueb@pengutronix.de>
        <CAHp75VchZKRNtMU1awDczfx=Qq8_JsywXvLtrJJCY_8Y=n1W0g@mail.gmail.com>
        <ec9275fd-cc9a-0f42-0595-d37fb3d568b6@metafoo.de>
        <bd8472f2-e4d0-2a63-98a5-5e1fe8ad6255@metafoo.de>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 16 Aug 2022 10:38:41 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 8/16/22 10:27, Lars-Peter Clausen wrote:
> > On 8/16/22 10:20, Andy Shevchenko wrote: =20
> >> On Mon, Aug 15, 2022 at 10:42 AM Uwe Kleine-K=C3=B6nig
> >> <u.kleine-koenig@pengutronix.de> wrote: =20
> >>> On Mon, Aug 15, 2022 at 10:30:45AM +0300, Andy Shevchenko wrote: =20
> >>>> On Mon, Aug 15, 2022 at 12:31 AM Uwe Kleine-K=C3=B6nig
> >>>> <u.kleine-koenig@pengutronix.de> wrote: =20
> >>>>> On Sun, Aug 14, 2022 at 10:01:08PM +0300, Andy Shevchenko wrote: =20
> >>>>>> On Sat, Aug 13, 2022 at 7:21 PM Jonathan Cameron=20
> >>>>>> <jic23@kernel.org> wrote: =20
> >>>>>>> On Mon,=C2=A0 8 Aug 2022 22:47:33 +0200
> >>>>>>> Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:
> >>>>>>> =20
> >>>>>>>> Make use of devm_clk_get_enabled() to replace some code that=20
> >>>>>>>> effectively
> >>>>>>>> open codes this new function.
> >>>>>>>>
> >>>>>>>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> >>>>>>>> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutroni=
x.de> =20
> >>>>>>> This might have side effects as it now enables the clock before=20
> >>>>>>> calling
> >>>>>>> the clk_set_rate(). Also changes the clock start up ordering.=20
> >>>>>>> Neither is that
> >>>>>>> scary a change, but on really fussy hardware they might cause=20
> >>>>>>> problems.
> >>>>>>>
> >>>>>>> Add a few rock-chips people who have sent patches in last few yea=
rs
> >>>>>>> to hopefully take a look or even better run a test. =20
> >>>>>> I believe you found a bug in the patch. The possible solutions are:
> >>>>>> - not take the patch
> >>>>>> - disable and re-enable clock around clk_set_rate()
> >>>>>>
> >>>>>> IIRC clk_set_rate() will spit a WARN if clock is enabled. =20
> >>>>> You mean in general? I think that's wrong. There might be some=20
> >>>>> clks that
> >>>>> do that, but I'd consider them strange. If you ask me, calling
> >>>>> clk_set_rate() for a *disabled* clk is the strange concept ... =20
> >>>> I think it's correct from the logic and electrical perspective. That=
's
> >>>> why the preparation and enablement are separated in CCF. But please
> >>>> double check, because I can't remember everything by heart. =20
> >>> In my book the separation is done because "enabling" has to sleep for
> >>> some clks (e.g. PLLs) while a sleeping clk_enable() is bad for various
> >>> use cases and most clks don't sleep for enabling. =20
> >> Yeah, but the idea of changing clock rate on the fly may produce
> >> interesting side-effects on hardware level (with PLL latencies to lock
> >> the phase and possible glitches). So, changing clock against enabled
> >> hardware (not in reset / power off state) seems not a good idea. =20
> >
> > The clk_set_rate() API will internally disable the clock, if the clock=
=20
> > chip requires it. See `CLK_SET_RATE_GATE` flag. =20
> Sorry, I misremembered. If `CLK_SET_RATE_GATE` is set `set_rate` will=20
> return an error if the clock is enabled when `set_rate` is called.

Thanks for chasing that down.

In that case I definitely don't want to take this without input from those
who can test it!

Jonathan

> >
> > But I tend to agree, the better idiom is to `set_rate` we should do=20
> > that before `enable`. This will avoid any unintentional glitches on=20
> > the clock signal
> > =20
>=20

