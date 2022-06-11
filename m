Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8DD547404
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jun 2022 12:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbiFKK4w (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 Jun 2022 06:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbiFKK4v (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Jun 2022 06:56:51 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED2B737B4;
        Sat, 11 Jun 2022 03:56:50 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id h19so1838756edj.0;
        Sat, 11 Jun 2022 03:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g8ivwI7+C/gMqlG//ZPcxM8fWR3MwRi0Dr8R1nkJoFM=;
        b=pGNWBSwRpyJvzpWQdQpOd7agZuQVh10uUHWfDJS9iQmSAt+gLesM/M9sA3d8JArkvF
         mMMVmqx5nODDVSwMPtNA4dEzJLrQ/9KK2ncOBrod9+d1DB80KEacLhQThqn7mifo7lFx
         ljspNsDNzqgHAhK4hwoZ6S7ELQp9kOrjvsivP1QOm+EDJupaoy4PezuhPAszdCF9F291
         RXnr6ySrq7BkzPVjKmYQQw51lRP8hUUtosCFZqnzldH9lpV+lK2DDLRgAJXgqx5EATfW
         jD7tLakJdOh18LBSwnToXXsDpx30JgpEbKqqg+PGPIt+JpAJaZfwu1rU2jyp73Nm3jBx
         EEnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g8ivwI7+C/gMqlG//ZPcxM8fWR3MwRi0Dr8R1nkJoFM=;
        b=GcxZtiJe5EhCKVTQlEoz+nybtAGVWzkEz7sPAR42MbiLVdn/iAPc3Y0Jp9TWDNh3oz
         jl7X4wOUXB6PYxUfjvuOCpLmk2fG8sTKcsKRps+gX1YSxI60XPxY28d0YqbcQCW0vXpz
         ciu9C4F/DIqYDX3UrDfHPfWTdvcS8r741y0ByIOzM3T83mWMABLAi6qUco4QhcaVOVD8
         GES3LsFJTsFex4t9GrXPVfZiiZVu6lC64kWgpYVZA7Rac8SYwJfKsz9ppEsf84HMLZ9X
         uopDo9pjndEk30uKvcp5Y6cU1py0D6CUxaNhiTWqBM5H3lqMCF7YObQLIBWvsRk0TqX9
         Tfjw==
X-Gm-Message-State: AOAM53311Kp+yc5aFVLVm0aLiepIbR4cv0Jkmr51m97aEkSd8Fkr3upi
        CvPTlkPmLBogLHE+tpw0ujoZRDvkzz1ZlpFNTTzcAn4gwV5K/g==
X-Google-Smtp-Source: ABdhPJyrrkhpGNvLRasj9HjhOP7Ld3KC4yC1xo0lYYYExWR/GIVVU45KP4brm50dNubi8napRBDTjtWFDikZ3qXvY6I=
X-Received: by 2002:a05:6402:249e:b0:42d:bb88:865b with SMTP id
 q30-20020a056402249e00b0042dbb88865bmr46388738eda.141.1654945009367; Sat, 11
 Jun 2022 03:56:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1654727058.git.jahau@rocketmail.com> <a914ca0ea6f0149cd2941d60ae6fa2f49927f66a.1654727058.git.jahau@rocketmail.com>
 <CAHp75Vdg2i8NjrFn5gtKBKNbYrWd49nq31Exy=4K2RsxHeQ1hw@mail.gmail.com> <6ac31983-698c-5333-da4b-4f562c47afc7@rocketmail.com>
In-Reply-To: <6ac31983-698c-5333-da4b-4f562c47afc7@rocketmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 11 Jun 2022 12:56:13 +0200
Message-ID: <CAHp75VeprMCdP_HqcVUhQow_OStKDMF4c2k5s1gs7RwOTzO=FQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] iio: magnetometer: yas530: Add YAS537 variant
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        phone-devel@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
        <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy
        Shevchenko <andy.shevchenko@gmail.com>," 
        <~postmarketos/upstreaming@lists.sr.ht>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Jun 11, 2022 at 1:57 AM Jakob Hauser <jahau@rocketmail.com> wrote:
> On 10.06.22 16:31, Andy Shevchenko wrote:

...

> >> +                               dev_dbg(yas5xx->dev, "register 0x%02x: %u\n",
> >> +                                       i, val);
> >
> > Please, drop all these value reads/writes debug messages, they are
> > quite expensive (by resource consuming), noisy (may spam logs), and
> > most important duplicative. regmap API has tracepoints, use them!
> >
> > Perhaps it would require an additional patch to clean this up, if
> > anything like this is present in the current code base..
>
> Ok, I'll remove those direct regmap reads in yas537_dump_calibration().

I'm not sure I understand what you are going to drop. I was talking
about debug messages, the regmap reads are fine. Or you are talking
about them as they are tightened together and one makes no sense
without the other?

> However, I'd like to keep the others. The calibration data is dumped
> before [1] and after [2] being processed by the driver. This is helpful
> to check if it was processed correctly. Dumping the data is done only
> once at probing.

Then it should be probably dev_info() in such cases.

> In yas537_dump_calibration(), I'd also like to keep dumping the
> "hard_offsets". Currently there is no linearization formula known for
> YAS537. Providing the "hard_offsets" may help to find a way.

I understand that, but per se this is not for production esp. taking
into account that regmap has a tracepoint mechanism.

-- 
With Best Regards,
Andy Shevchenko
