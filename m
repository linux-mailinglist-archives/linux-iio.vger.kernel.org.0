Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3CBC595849
	for <lists+linux-iio@lfdr.de>; Tue, 16 Aug 2022 12:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbiHPKam (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Aug 2022 06:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234500AbiHPKaQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 16 Aug 2022 06:30:16 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C244B08A2
        for <linux-iio@vger.kernel.org>; Tue, 16 Aug 2022 01:21:28 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id cr9so7589629qtb.13
        for <linux-iio@vger.kernel.org>; Tue, 16 Aug 2022 01:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=fYHmP9nI26bndG24CrDj747p91gEFez7K8IdDoPef1k=;
        b=Qev/MvMbksIPoHOs+NBfQs1ePC3IRBSvrglI3CqFhSD5a7rVU2nwTfwn/m8M/4OklO
         +YpvWxYiWBHwswool4eZMejmEV8mTw4IboDn3DQKTFO+MNjtWFa/VfRls9xzMxz4Vqb1
         fXWJbjYnp8xBmTjVK+gFAiu8TkeHssSCCUbaY8Wahngm0z8MOvVbin6GCKSEXOU/L5gP
         95J7fw9s1yRMIdZCZUC6rebzZgFIA1te9CCzRRhCDEXgKAZMAyeOxLDv/AIGsLjhnkZR
         90ZAmRqPvX8u7ShO9l5bhuGYF6rYhggC2YAOiWSOxi3rvdHUfGbEj7d/KWGcZyZWGsG2
         p8Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=fYHmP9nI26bndG24CrDj747p91gEFez7K8IdDoPef1k=;
        b=dBgVyXJS7e8MqeYuNe/jtxeg5+TVpw05zBPSGBCFx/ZZTaQlBPHsb0IfLP2GsF6oXg
         XCBvjLsgRhugrOz2QTfCpSZoEOMJbCG20FMmNwtUwdSjELMhJsuwu1XGm++79BVrBXI1
         oyTzvh9jUyiFVvbIR0QgOHgdrFzr/G50jmUs6NtpHyZiUanfbftTipzChPdNISe5afN1
         Kk0ZXajkmlOaPOtXeiwIRbaJVGfxZa2fsBEZi9hskda7yQ2eB9NnXctlUBHaBwsMMrAm
         HinHzYWF8b0Cu0LJqJYWZMa0dThih8xh2zQUEvzkzAwTPg5Q6v4BcPP/uAtINT6uU8dJ
         F6gg==
X-Gm-Message-State: ACgBeo1UsI7mSSZJeQ2xZxlxKUqxOYgXXECSrje5kw15d/hsDRabppaN
        Zy1yHPn12OB1yXjKRmNB98Bx+kdcD296SVyV/BU=
X-Google-Smtp-Source: AA6agR5tP7BKjTgTXO0DeCUdO3zSTV2/Rwu1cXq4UoPGpQbctBuF25fl6g+xxqZqeLBopbrgES1cTtM1LLvVGLRHEWI=
X-Received: by 2002:ac8:5786:0:b0:343:3051:170d with SMTP id
 v6-20020ac85786000000b003433051170dmr17012395qta.429.1660638087213; Tue, 16
 Aug 2022 01:21:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220808204740.307667-1-u.kleine-koenig@pengutronix.de>
 <20220808204740.307667-6-u.kleine-koenig@pengutronix.de> <20220813173142.76774c97@jic23-huawei>
 <CAHp75VeUV2+-V=TbQwx4Chr-xWU4AmRq-mG8Z8XTkwQmx4qvhQ@mail.gmail.com>
 <20220814213058.dgoxpkoxpn6s4ojj@pengutronix.de> <CAHp75VfD9xoDYyWH3NB9btNW2pBmTH_jBmwjOSUbOQ+Ei_k20w@mail.gmail.com>
 <20220815074149.jrkeevc3uxoo6ueb@pengutronix.de>
In-Reply-To: <20220815074149.jrkeevc3uxoo6ueb@pengutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 16 Aug 2022 11:20:51 +0300
Message-ID: <CAHp75VchZKRNtMU1awDczfx=Qq8_JsywXvLtrJJCY_8Y=n1W0g@mail.gmail.com>
Subject: Re: [PATCH 06/13] iio: adc: rockchip_saradc: Benefit from
 devm_clk_get_enabled() to simplify
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Heiko Stuebner <heiko@sntech.de>,
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
        Jonathan Cameron <jic23@kernel.org>,
        Simon Xue <xxm@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 15, 2022 at 10:42 AM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Mon, Aug 15, 2022 at 10:30:45AM +0300, Andy Shevchenko wrote:
> > On Mon, Aug 15, 2022 at 12:31 AM Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > > On Sun, Aug 14, 2022 at 10:01:08PM +0300, Andy Shevchenko wrote:
> > > > On Sat, Aug 13, 2022 at 7:21 PM Jonathan Cameron <jic23@kernel.org>=
 wrote:
> > > > > On Mon,  8 Aug 2022 22:47:33 +0200
> > > > > Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:
> > > > >
> > > > > > Make use of devm_clk_get_enabled() to replace some code that ef=
fectively
> > > > > > open codes this new function.
> > > > > >
> > > > > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > > > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutron=
ix.de>
> > > > >
> > > > > This might have side effects as it now enables the clock before c=
alling
> > > > > the clk_set_rate(). Also changes the clock start up ordering. Nei=
ther is that
> > > > > scary a change, but on really fussy hardware they might cause pro=
blems.
> > > > >
> > > > > Add a few rock-chips people who have sent patches in last few yea=
rs
> > > > > to hopefully take a look or even better run a test.
> > > >
> > > > I believe you found a bug in the patch. The possible solutions are:
> > > > - not take the patch
> > > > - disable and re-enable clock around clk_set_rate()
> > > >
> > > > IIRC clk_set_rate() will spit a WARN if clock is enabled.
> > >
> > > You mean in general? I think that's wrong. There might be some clks t=
hat
> > > do that, but I'd consider them strange. If you ask me, calling
> > > clk_set_rate() for a *disabled* clk is the strange concept ...
> >
> > I think it's correct from the logic and electrical perspective. That's
> > why the preparation and enablement are separated in CCF. But please
> > double check, because I can't remember everything by heart.
>
> In my book the separation is done because "enabling" has to sleep for
> some clks (e.g. PLLs) while a sleeping clk_enable() is bad for various
> use cases and most clks don't sleep for enabling.

Yeah, but the idea of changing clock rate on the fly may produce
interesting side-effects on hardware level (with PLL latencies to lock
the phase and possible glitches). So, changing clock against enabled
hardware (not in reset / power off state) seems not a good idea.

--=20
With Best Regards,
Andy Shevchenko
