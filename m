Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B875B645848
	for <lists+linux-iio@lfdr.de>; Wed,  7 Dec 2022 11:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiLGKyf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 7 Dec 2022 05:54:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiLGKyQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Dec 2022 05:54:16 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4AA4B75E;
        Wed,  7 Dec 2022 02:53:58 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670410436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E++GUwZ8jMdPuuFb9HneEXTyZRdwr5VtQ85BVtWxCeE=;
        b=oVtO0rpE3zGck2ZVl3hBFOWCJnY3f7uESZgYEE4RsQfws6jDaknEoxBwE/rwwbwBp7ZCOD
        SltMM7HVQQBgD+hKx/BE327V+cYEw7GXTwS83251nQIgpo4Q9n5T49Rn6gTz77skxKdLXJ
        X9DDfdohkisS7rtB2ecRKUdvSlFVFGOIKUtzZ0L5cyPu7YHbH9ma8UdtqTzcXEq5C037bP
        OkkAutuv+kDiC6MzuJS/kkdnrFEtfsUtUHvz0ngDo4uW+HtidGqR4LmQ4SPRNs4OW3+FT2
        FnatGqy4mlOrIr1D9vt01JYtNfm8fJE6eYhE7ircLV5N8W5Q2zu2QbJFKpVcrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670410436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E++GUwZ8jMdPuuFb9HneEXTyZRdwr5VtQ85BVtWxCeE=;
        b=+hIcuhAFj3DgkyyHn9Ikp08rfUFFies/TTWH7AJusyzO9lmEFz1UIxE7Iy6JiZpJFjGkR7
        3U2i/g6yJz7MpxBA==
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        William Breathitt Gray <william.gray@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: RE: [PATCH 0/6] Add RZ/V2M Compare-Match Timer (TIM) support
In-Reply-To: <OS0PR01MB59228CED6187C7B19776CE22861A9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221205145955.391526-1-biju.das.jz@bp.renesas.com>
 <20221205225042.GA2812115-robh@kernel.org>
 <OS0PR01MB592211AD4D0AE23DA7075DD5861B9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdX2=AwerQZS2cqR4exq_QNtt=Fwp5KBcmPr1qmOBNOSAg@mail.gmail.com>
 <87sfhsgb9e.ffs@tglx>
 <OS0PR01MB59228CED6187C7B19776CE22861A9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Date:   Wed, 07 Dec 2022 11:53:55 +0100
Message-ID: <878rjjfprw.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Biju!

On Wed, Dec 07 2022 at 07:52, Biju Das wrote:
>> On Tue, Dec 06 2022 at 09:40, Geert Uytterhoeven wrote:
>> > When multiple clocksources are registered, the clocksource subsystems
>> > picks the best one anyway, right?
>> 
>> As it does for the clock event devices. If there is an architected timer
>> then that should be always preferred.
>> 
>> No idea why there is a need for the extra hardware and the drivers which
>> are both never utilized.
>
> I got feedback from BSP team for the actual usage of this timer.
>
> Basically, this HW timer is used for measuring the processing time
> of DRP-AI accurately compared to the CPU timer normally we use.

How is a slow to access timer with a lower clock frequency more
accurate?

> The example use cases,
> Timer in FREERUN mode, Check the timer value after the restart(1usec)"
> Timer in FREERUN mode, Check the timer value after the restart(10000000usec)"
>
> What is the model to be used for this kind of HW usage? Counter or Timer?
>
> I can think of one possible HW usage by using Counter model.
> Not sure how timer model can be used for this kind of HW usage??
>
> Eg: we can set ceiling values 1usec and 10000000usec using counter framework
>   And that will trigger interrupt events corresponding to the ceiling values
>   to user space and user space app can accurately measure the DRP-AI processing time.
>
> Also counter model exposes count values to user space from the counter HW.

Counter subsystem != clocksource/event subsystem.

We are debating a clocksource/clockevent driver and not a counter
driver, right?

Thanks,

        tglx

