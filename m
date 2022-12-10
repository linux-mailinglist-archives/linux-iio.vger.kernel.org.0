Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47F3648E42
	for <lists+linux-iio@lfdr.de>; Sat, 10 Dec 2022 11:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiLJK7Q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 10 Dec 2022 05:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiLJK7P (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 10 Dec 2022 05:59:15 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E14BCA4;
        Sat, 10 Dec 2022 02:59:14 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670669953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iphm4QQgUglL/j++hAuj+bu5rQB4rYPNzSzGlqKLeUI=;
        b=w0hpYeT8AutCl499sXSKrBiebT4DSTsz6/JLnrc8MrFMI8TwdgxbgU8G7WrnOAqnZyqjzv
        Px4/RIaj79Ggr4bw+YPtbUP66xzi5s7E2YbhIDSwkYU+84vCg1SatWb/IkPu/dhB5XLx1z
        vpGXo14ZAaLWcYbCxeF93GWRH07mLe/6Kwd8Oe+eQiB7tGjO5rpwOmsZezO1tQWy7dLwrn
        Xd0EjFiiJps1nJAODIiLUvvG2gN0iqjrc73g6TlmA4lo8XaP6jG3Ak695qIUBwOKECI9xA
        wSE4IshBzCGDyUm/Wf1DGC39fFZ65DoFDMVI2Au6icQ+rmXHV+4OuL7PVmU31g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670669953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iphm4QQgUglL/j++hAuj+bu5rQB4rYPNzSzGlqKLeUI=;
        b=rmVcFUCHGOam9sPMXWxNgZG5hlZhACkPFkY8AeSnVSE1kw6bft2iITHjDd6SdhvhwVCwpX
        sAWtTcrmi5GZuSCg==
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        William Breathitt Gray <william.gray@linaro.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
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
In-Reply-To: <OS0PR01MB5922293733EFD0D4F3E6B270861F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221205145955.391526-1-biju.das.jz@bp.renesas.com>
 <20221205225042.GA2812115-robh@kernel.org>
 <OS0PR01MB592211AD4D0AE23DA7075DD5861B9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdX2=AwerQZS2cqR4exq_QNtt=Fwp5KBcmPr1qmOBNOSAg@mail.gmail.com>
 <87sfhsgb9e.ffs@tglx>
 <OS0PR01MB59228CED6187C7B19776CE22861A9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <878rjjfprw.ffs@tglx>
 <OS0PR01MB5922B590AB9791B9741E2A1D861A9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <87sfhrdure.ffs@tglx> <Y5O1g8/69tCfmdW6@fedora>
 <OS0PR01MB5922293733EFD0D4F3E6B270861F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Date:   Sat, 10 Dec 2022 11:59:12 +0100
Message-ID: <875yejcynz.ffs@tglx>
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

On Sat, Dec 10 2022 at 07:52, Biju Das wrote:
> scheduling tick is 4millisec. so if we want callback at 1 microsec,
> then we need to use clock_nanosleep. Getting 1 microsec callback to
> user space is challenging as the scheduling tick is only 4 millisec.

The tick is only relevant if high resolution timers are disabled because
then hrtimers are expired in the tick. If high resolution timers are
enabled then the hrtimer expiry happens at the exact expiry time.

What's challenging about the 1 microsecond accuracy is that the system
immanent latencies are already in that range. So while the timer fires
exactly, the actual execution of the woken up task in user space is not
exact as that is subject to the worst case sum of latencies in the
system.

Thanks,

        tglx
