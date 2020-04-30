Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03C4E1BF61D
	for <lists+linux-iio@lfdr.de>; Thu, 30 Apr 2020 13:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgD3LIL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Apr 2020 07:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725280AbgD3LIL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Apr 2020 07:08:11 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DE4C035494;
        Thu, 30 Apr 2020 04:08:11 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id w65so2704728pfc.12;
        Thu, 30 Apr 2020 04:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3YzQNid97kqBggOZQ18C1LhT5mfiq53k4mzAIfsUnLE=;
        b=Jh9fqjv2seVUJxCv/tidEAfVPLwykN/tjVlbnkkjoSUllix6GJx0sA1bkBpuDMvlg8
         Q26m7CUN6bKkMgtjL86m1BCF8Gd8EvabNZKCXtk77FTpf/A0sJDw9TKOoYhv7HrHcdJ2
         pG4VMzVF899pxXlvXpLkrpZ0IJmjVU7flM6DhEdsEqcahH3ACQD09mK+PVh3Vva4jHFy
         vzZ/1NlcqM9bMNbr78wcol1D//PW0CV16tqheLsPDJR2f57Ab+trEX4DN2eJi9RugWY8
         +7VKtJ+PRVH4wewh/r0X4LgLhMNkxE52CpT0xWSVGt5pSb+QFFkj46k6hYQPtXwxU8hX
         GG/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3YzQNid97kqBggOZQ18C1LhT5mfiq53k4mzAIfsUnLE=;
        b=ObrWDDR+WW4xbw2vSbnPzz55ywjXzzWZtBjRSk1y3F8BcOjK49wllnay9jPjvztKKG
         wO2mviefs3xTwCK8T6xzSu/Z/Gq08LM6e+Mfn1wcI5gWe5g+GEYNMATC7OyCEQ9YCPOF
         hK9JqRv/l0WQmrm7VTGsE12PREVsd5FN3ybbgUPHt1QXxp2kACSVADsXv18TjKLSUflN
         B97qHz9J5ZflIY06XiSDhn3KP1x3Z4IVOJOWi8Vd6yt2PQGGyPaps0crA2vU31Jn5G9m
         t0fJBYoi2P/mtx+mc6t6LQu1UiZ407Ijg6ynsUhNy3oQ4QWIxDpgk/f7jzQUKGtG4UIE
         Inig==
X-Gm-Message-State: AGi0PuYqgxFE4b5m2/fkwfzJ5fHKDwLSnCCFZeAgtBjM3SFFoO6vgN+3
        VkxepNmlECoAqYtd+03Sa8GwCSNS34k/cuDQShPlZCgW
X-Google-Smtp-Source: APiQypKoZgytgfpRIRcYTrUfB53T910MQX77K+M78+bkpG732U7uQjhCU+J1dF6vFKP8u87Fp6FhwxUKKz1hRMXWsJw=
X-Received: by 2002:aa7:8f26:: with SMTP id y6mr3119423pfr.36.1588244890479;
 Thu, 30 Apr 2020 04:08:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200415162030.16414-1-sravanhome@gmail.com> <20200415162030.16414-3-sravanhome@gmail.com>
 <20200424071822.GM3612@dell> <8ff17d07-8030-fcfe-8d8a-3011e4077778@gmail.com>
 <20200424093720.GA3542@dell> <864eb6ad-a605-c0a0-c3e7-23c0c70f5ede@gmail.com>
 <20200424105319.GD8414@dell> <c62cd5f2-6d82-0a2a-5ee5-a3e99e188a05@gmail.com>
 <20200427085149.GF3559@dell> <6063ad6e-444c-b905-b858-d8f94d700748@gmail.com> <4585179d-826b-6240-38a2-18fe757bc810@gmail.com>
In-Reply-To: <4585179d-826b-6240-38a2-18fe757bc810@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 30 Apr 2020 14:07:59 +0300
Message-ID: <CAHp75Vf_PUQdcOVdao0KUjiLapicMOFHK6f5+gf-bi-k6hVgkA@mail.gmail.com>
Subject: Re: [PATCH v9 2/6] mfd: mp2629: Add support for mps battery charger
To:     saravanan sekar <sravanhome@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Sebastian Reichel <sre@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Apr 30, 2020 at 1:39 PM saravanan sekar <sravanhome@gmail.com> wrote:
> On 27/04/20 11:30 am, saravanan sekar wrote:
> > On 27/04/20 10:51 am, Lee Jones wrote:
> >> On Fri, 24 Apr 2020, saravanan sekar wrote:
> >>> On 24/04/20 12:53 pm, Lee Jones wrote:
> >>>> On Fri, 24 Apr 2020, saravanan sekar wrote:
> >>>>> On 24/04/20 11:37 am, Lee Jones wrote:
> >>>>>> On Fri, 24 Apr 2020, saravanan sekar wrote:

...

> >>>>>> Then how about using 'simple-mfd' and 'syscon'?
> >>>>>>
> >>>>>> Then you can omit this driver completely.
> >>>>> The exception is to support for non device tree platform as well,
> >>>>> but I have
> >>>>> tested only for ARM device tree platform.
> >>>> Is that a reality though?
> >>>>
> >>>> How else do you see this realistically being registered?
> >>>>
> >>> I understand that acpi related device table are not covered here,
> >>> well I
> >>> don't have to platform to test so.
> >>> If you ask me to cover acpi related table, I can do but hard to test.
> >> I don't know of any reasons why syscon can't be used by ACPI.
> >>
> >> Please try to solve this issue using 'simple-mfd' and 'syscon'.
> > Well the simple-mfd and syscon topic recommended by you when Device
> > tree alone is used.
> > I wounder still I receive review/improvements comments for this mfd
> > patch and also another
> > to omit this driver using simple-mfd (rework the series).
> > Confused, not sure which is valid and will be accepted at the end.
>
> I had look into syscon, as far my understanding syscon is supported only
> for memory mapped IO. MP2629
> device is over I2C bus, could you share your thought about syscon for
> this device?

My understanding too, but I didn't dug into it.
Something like general regmap support is missing (or I am missing the
way how to pass it to syscon).

-- 
With Best Regards,
Andy Shevchenko
