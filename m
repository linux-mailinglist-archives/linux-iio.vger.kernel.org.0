Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF55B557A30
	for <lists+linux-iio@lfdr.de>; Thu, 23 Jun 2022 14:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbiFWMVo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 23 Jun 2022 08:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbiFWMVn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Jun 2022 08:21:43 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30AB2F3AE
        for <linux-iio@vger.kernel.org>; Thu, 23 Jun 2022 05:21:42 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-3137316bb69so191812397b3.10
        for <linux-iio@vger.kernel.org>; Thu, 23 Jun 2022 05:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5ZAX7YJT6NRdQsycAPfVOz2A8M7vZaZDDETi6cRa5pk=;
        b=vzNpgpqq711oNduko6AaaZmKj3A645woCZoQbRSvf6d7q4/P7lbsKHha6gBwP7kfVH
         TuI0VopnGzCoOVA96qWVouxn56INwjAnWbUUoes1Nw64/58N2HeHdCNxvMR+UHJvCAcV
         Dp9l5G/ozqVEVO+bZv8dw4W+U/EPXarn97IA2bHB7jGRukj3XeH8R2U7Yiw6/vKozmxu
         3tu3vTrVoCzsVkYJ89TkwYn6gTmaeDea30XRPcoL0y+JEUCwquu30o1SM2ndEKzcKIqz
         DPvGrFTYJCintyiucRVymxcnWDbPdRIDbuAd55eO64PcT94MK4CBzKKfNBPYle4B7E+w
         l0IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5ZAX7YJT6NRdQsycAPfVOz2A8M7vZaZDDETi6cRa5pk=;
        b=WPer9ro9UANfGsTAiMVk9rqEgrFdQGVaDo8718qk/e+EYw3Nhm/1eqKQ0ofgP8qzES
         m9cg00Yn9wr9inN7jgvgmFRx/f90th+2X2BpIwnQL/UAy4bTd4wNHg0bScRYd50zm+nS
         BEtwDxucxK1kyrK5b6u0DQv5ItTmqo8ex/MQBztjd8ROe/zFUWB02gQAdF+oETP582Kf
         XuuS/OO18NrldMghyoNabylwWmfdu0h9OBAXizNzCy+9uZpdhoNvK6JnSRZsyYVB2ViB
         tYA40TB8aVIzMNXO1HLs4DQISl3i+gcyI80BxGKwoBwzGtXT+nmDjd1psn8O01V79aq7
         RgmA==
X-Gm-Message-State: AJIora/fUBvCNpy6ccczobJE2ubae/5L+HLjQ7EUQqk1Z10izDK79/LC
        LXPF4N5Cewfvmfz6G3Ub9WySVSmxA4LPo3QzrnMLNg==
X-Google-Smtp-Source: AGRyM1tZpWg8CDQYbO6TqSUStNRV39BFYJatEIDpv3h1qnl/HotVHofDAFGQFyugQpZxGynDYZ3RyLIZEAQPQK8B4Vc=
X-Received: by 2002:a0d:e20a:0:b0:317:ce36:a3a0 with SMTP id
 l10-20020a0de20a000000b00317ce36a3a0mr10658381ywe.448.1655986902018; Thu, 23
 Jun 2022 05:21:42 -0700 (PDT)
MIME-Version: 1.0
References: <BYAPR11MB3240148739EBB945211DD77BE1AF9@BYAPR11MB3240.namprd11.prod.outlook.com>
 <44170bf8-5777-e30b-b74d-a6835b1937e2@metafoo.de> <YqxOl8W2yzp9CcBP@smile.fi.intel.com>
 <CACRpkdbeQ_67V3jkw_-KfTwe54TxrK_LA7N8Nwj1qEpTELN9dQ@mail.gmail.com> <ad7e53d1bd2448b4971af65483fe3542@intel.com>
In-Reply-To: <ad7e53d1bd2448b4971af65483fe3542@intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 23 Jun 2022 14:21:30 +0200
Message-ID: <CACRpkda63TNWLdTjY+_xxXb4df4qCZi1EaXL3pXK=+Hon-0RLQ@mail.gmail.com>
Subject: Re: Intel Timed-IO driver in IIO/Counter subsystem
To:     "Hall, Christopher S" <christopher.s.hall@intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Kent Gibson <warthog618@gmail.com>
Cc:     "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        Dipen Patel <dipenp@nvidia.com>,
        "N, Pandith" <pandith.n@intel.com>,
        "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "vilhelm.gray@gmail.com" <vilhelm.gray@gmail.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "T R, Thejesh Reddy" <thejesh.reddy.t.r@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Jun 18, 2022 at 4:01 AM Hall, Christopher S
<christopher.s.hall@intel.com> wrote:
> Friday, June 17, 2022 4:40 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> > For 2. I am uncertain. Periodic events sound like PWM to me.
>
> I do not think TGPIO periodic output is useful for PWM. There are two output
> modes: edge output and pulse output. In edge mode output, where the an edge
> is produced periodically based on the programmed period the duty cycle is
> always 50%. In pulse mode output where a pulse is produced each output
> period, the width of the pulse is two ART ticks which on current Intel
> client platforms is about 50 ns. The pulse width is not adjustable.
>
> We want to be able to output a clock from 1 Hz (1 PPS) up to 1 KHz that is
> synchronized with the system clock.
>
> It is possible to represent the periodic output function as a PWM device,
> but the PWM subsystem output - without modification - is not aligned to
> any clock which breaks the timing application.

Is it "just" a clock then? As in drivers/clk?

It's of course annoying that the functionality of a certain hardware falls
between the subsystems so we end up using pieces of a subsystem in
another one, but there are several precedents, like network switch chips
and USB UART chips with GPIO inside them, or graphic chips with
clock dividers inside.

> > If a "single event" is something
> > like pulling a GPIO line high/low at a specific (wall clock) time in the
> > future, it should probably be in the GPIO subsystem, like a triggered
> > GPIO event or so, that sounds a bit hard but certainly doable with some
> > thinking and tinkering.
>
> Earlier, we proposed a linereq_write() method in addition to the already
> existing linereq_read().
>
> https://lkml.org/lkml/2021/8/24/807

This might be a good approach for this part of the hardware, as long
as we can make sure we get the userspace API abstract enough
that other hardware can make use of it and userspace does not
need to know what provides the timed output, just that there is
some hardware that does.

The ABI in the patch looks a bit dangerous, what happens if
you set an event like that and something decides to shake the
line by setting the output while the scheduled event is pending?

The direction seems sound however, but Bartosz and Kent need
to look at it in detail, their effort on the userspace ABI has been
tremendous.

Yours,
Linus Walleij
