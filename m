Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10EF0645F3A
	for <lists+linux-iio@lfdr.de>; Wed,  7 Dec 2022 17:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiLGQtQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 7 Dec 2022 11:49:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiLGQtO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Dec 2022 11:49:14 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52AA5446D;
        Wed,  7 Dec 2022 08:49:12 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670431750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7uqFvxvkYpcyFM86fQv9yXZ51d2JEFzcw8TpGHczOpc=;
        b=12yUhL53fLv0GE7ZAaNXcOe1ZHzbc1wGUzqI9k5c/bGgLjdmMIl9wtEcOvuaEiIA7hlK3C
        9waipIMlHN/s4cJrqQfof6eZXV0ScUUbJbjMNJ6xu8CoxDLwW6oyxydNvkDnYHOPeJuDsB
        HgkEa+2fm1sTdbkoYdx42LgEne5/dk5N0pG+jQatoerPFYZ/OIP1HqWX+r4KSKVRpt+hjW
        VCN1MnCVTFJhpHeUj5UfH80C3D8j0FebBCZCrsSqIxFJ0fhW9Qy1YjdxvxvfVMtmuW20c4
        u4iJSAD980pDlay0t41cD8/4flOINnLm7SzlnHqDtaVc4HS8cyUPefjsQalbvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670431750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7uqFvxvkYpcyFM86fQv9yXZ51d2JEFzcw8TpGHczOpc=;
        b=GoVe2d6hG2SwJWydJujJPKvmuwmH7o9CzDpT2eJCdMYZV39SbEMc6QKuljbDYcMxmGadQ9
        ML7WYhn2Id81AMAg==
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
In-Reply-To: <OS0PR01MB5922B590AB9791B9741E2A1D861A9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221205145955.391526-1-biju.das.jz@bp.renesas.com>
 <20221205225042.GA2812115-robh@kernel.org>
 <OS0PR01MB592211AD4D0AE23DA7075DD5861B9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdX2=AwerQZS2cqR4exq_QNtt=Fwp5KBcmPr1qmOBNOSAg@mail.gmail.com>
 <87sfhsgb9e.ffs@tglx>
 <OS0PR01MB59228CED6187C7B19776CE22861A9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <878rjjfprw.ffs@tglx>
 <OS0PR01MB5922B590AB9791B9741E2A1D861A9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Date:   Wed, 07 Dec 2022 17:49:09 +0100
Message-ID: <87sfhrdure.ffs@tglx>
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

On Wed, Dec 07 2022 at 11:35, Biju Das wrote:
>> Subject: RE: [PATCH 0/6] Add RZ/V2M Compare-Match Timer (TIM) support
>> On Wed, Dec 07 2022 at 07:52, Biju Das wrote:
>> > Basically, this HW timer is used for measuring the processing time of
>> > DRP-AI accurately compared to the CPU timer normally we use.
>> 
>> How is a slow to access timer with a lower clock frequency more accurate?
>
> But our tick frequency for arm64 defconfig is CONFIG_HZ_250=y. So we
> get timer interrupt at every 4 msec.

CONFIG_HIGH_RES_TIMERS=y

> How do we get timer event interrupt, eg: for 1 microsec?

clock_nanosleep(...);

Though 1usec is wishful thinking with either variant of timer hardware.

>> 
>> We are debating a clocksource/clockevent driver and not a counter driver,
>> right?
>
> Yes, Rob pointed out we should not misuse the compatibles as I have both
> Timer and counter bindings for a given HW timer.
>
> Timer, It can be used as broadcast and highres timer for RT.

I buy the broadcast part if you really have a ARM architected timer
which stops in deep idle states. Highres for RT, no! The arm architected
timer works perfectly fine for that.

> Counter, It can be used as measuring the processing time of DRP-AI.

Sigh. You can do that with the architected timer too, especially when
you are going to do the measurement in user space.

clock_gettime(), which uses the VDSO with the architected timer is fast
to access and accurate.

Thanks,

        tglx
