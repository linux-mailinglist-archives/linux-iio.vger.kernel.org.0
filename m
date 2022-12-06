Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B45643F29
	for <lists+linux-iio@lfdr.de>; Tue,  6 Dec 2022 09:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbiLFI5j (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Dec 2022 03:57:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbiLFI5i (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Dec 2022 03:57:38 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF77ADF9;
        Tue,  6 Dec 2022 00:57:36 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670317054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9dfAnS4HqZf/rd5GjS0GfQAhi7xSNTRWFPEALuV2ujA=;
        b=Ol25RF3dxie1Ru5oOYW4c3TCw5SyQDsb0ovog0pPwcm2HoM2K9oDSjvSQ7jtqPcU//Fi+g
        uA+7+PnsYvfM1uiGqjMfgprZpwepPFCWpA2HatyrtzoFfpCNMk72Vqfhc1dRNtTpx90h7J
        rIdiZHTyw/b97rxqecYJIGg6/pKmSExqw8wRgU+GSnxxdS01TvsoxF7uKL2VUwShyZe0/n
        7FymMTdrEFNakGlN8V/APQL8rFonlrhnBb4Snb681rTWkHF66xprgmu7u0nISfloz7jzwk
        rfaBOy+peGE+rO+LhCb/9cR1qpx32w8ShDj3/AEFugd6aRgovi2faay4MWDYXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670317054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9dfAnS4HqZf/rd5GjS0GfQAhi7xSNTRWFPEALuV2ujA=;
        b=sfZ4e+ZlvZ+0nUDoBoVL9e8fWnhhU+76MmjMfNuYHRx0mfpeej/Qc1D0hEhCWChAw4ZI6O
        xY2zjvMrbqZusPDw==
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
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
Subject: Re: [PATCH 0/6] Add RZ/V2M Compare-Match Timer (TIM) support
In-Reply-To: <CAMuHMdX2=AwerQZS2cqR4exq_QNtt=Fwp5KBcmPr1qmOBNOSAg@mail.gmail.com>
References: <20221205145955.391526-1-biju.das.jz@bp.renesas.com>
 <20221205225042.GA2812115-robh@kernel.org>
 <OS0PR01MB592211AD4D0AE23DA7075DD5861B9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdX2=AwerQZS2cqR4exq_QNtt=Fwp5KBcmPr1qmOBNOSAg@mail.gmail.com>
Date:   Tue, 06 Dec 2022 09:57:33 +0100
Message-ID: <87sfhsgb9e.ffs@tglx>
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

On Tue, Dec 06 2022 at 09:40, Geert Uytterhoeven wrote:
> On Tue, Dec 6, 2022 at 9:13 AM Biju Das <biju.das.jz@bp.renesas.com> wrote:
>> > Do you have any use case to really switch. Doing so disables the vDSO
>> > access to the clocksource.
>>
>> Not really. Architecture timer should be sufficient for clocksource.
>
> When multiple clocksources are registered, the clocksource
> subsystems picks the best one anyway, right?

As it does for the clock event devices. If there is an architected timer
then that should be always preferred.

No idea why there is a need for the extra hardware and the drivers which
are both never utilized.

Thanks,

        tglx
