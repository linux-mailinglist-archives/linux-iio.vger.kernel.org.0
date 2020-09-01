Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB703259AE9
	for <lists+linux-iio@lfdr.de>; Tue,  1 Sep 2020 18:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729754AbgIAQzV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 1 Sep 2020 12:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgIAPYA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 1 Sep 2020 11:24:00 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9FCC061244
        for <linux-iio@vger.kernel.org>; Tue,  1 Sep 2020 08:24:00 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id y3so840841vsn.1
        for <linux-iio@vger.kernel.org>; Tue, 01 Sep 2020 08:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sl6xTKnd+6daHkSEhbQjHuiEQNZLZpxXWMv9V9u96KA=;
        b=dh34nKlEn2j6kHaUg6yzucVPfcrbjuQju3XuCAI6NEr8TKKUdj1llwvyq2AZxA9XM6
         ZEAJo70uPOkiuxVcE75GsMiLrFsMEIHANUGUbg7bfwm7DDQSWMCTZxHkI7DOc5saXswU
         a7pXWa3ywwG6ki/PfxnmRpVL8Ce/wWRa0mRj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sl6xTKnd+6daHkSEhbQjHuiEQNZLZpxXWMv9V9u96KA=;
        b=mbCEllcYDv87UM35fraWEUUNFvDW/4BpJUW6d39Sx8pD4qpZXSmNuTNB0P0ZOeJDkG
         JRMHMnUFo7gjY00VNIFb8zrCVkT224F6PZ0oBphdtkzu8EnwTjeckrPHxlJ4wBcvfdbT
         0tWajJvks8mPja5yCyzq4c24AvUmYPrm1gumJf+N9mjM1FA2Ax4tP8AkC2lkoY4Vg0x1
         FKaw2P+V0Of8GYVRYjfM/dn2yhDR5WZOYylSCr6W+uskWnixJs5DkkIiYvuWLJR+lxXF
         oUMlj95vI7jdpjueQlsHGZHyvgqppAYUg6jJhG2okTU5Faz4Dwo63HI+28tC1Jy//HrP
         KfoA==
X-Gm-Message-State: AOAM531CyZrR5X9xkPPysagOqsIxLKs1K3cwq16X8W5/7Y2x+an3kdlH
        m4/42jWLdmq7fNiMv3tSV6Rt80ToAe9b7w==
X-Google-Smtp-Source: ABdhPJxti7ux+tWpfv9R/+TiLKH7NTsX8t+Qwync6r2MKJLvWesgfbhtfqOOQXYxixDrgLW8sscrdA==
X-Received: by 2002:a67:f116:: with SMTP id n22mr1980856vsk.228.1598973838818;
        Tue, 01 Sep 2020 08:23:58 -0700 (PDT)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id b205sm238551vkf.54.2020.09.01.08.23.57
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 08:23:58 -0700 (PDT)
Received: by mail-ua1-f47.google.com with SMTP id y15so541947uan.9
        for <linux-iio@vger.kernel.org>; Tue, 01 Sep 2020 08:23:57 -0700 (PDT)
X-Received: by 2002:ab0:5e7:: with SMTP id e94mr1815731uae.104.1598973836853;
 Tue, 01 Sep 2020 08:23:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200828170052.1.Id02b2f451b3eed71ddd580f4b8b44b3e33e84970@changeid>
 <20200829161230.398e0051@archlinux> <CAD=FV=W3=kRFH0TzEAX0DWS7jb113LuWUJqVS686EyRzexvoRA@mail.gmail.com>
 <20200829181754.52d3cc3b@archlinux> <CAD=FV=VWrXwDwoxBK9y2ZeFEoG-edO4WktdSW0MFZLfbcS2hLQ@mail.gmail.com>
 <159894383586.334488.2938301456606601581@swboyd.mtv.corp.google.com> <20200901144520.0000576c@Huawei.com>
In-Reply-To: <20200901144520.0000576c@Huawei.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 1 Sep 2020 08:23:45 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vv++Sh_pGiG+g7qhB1wgD_O_5zXdcnS0fqcsSH5QC8kQ@mail.gmail.com>
Message-ID: <CAD=FV=Vv++Sh_pGiG+g7qhB1wgD_O_5zXdcnS0fqcsSH5QC8kQ@mail.gmail.com>
Subject: Re: [PATCH] iio: sx9310: Prefer async probe
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Daniel Campello <campello@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dtor@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On Tue, Sep 1, 2020 at 6:47 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Tue, 1 Sep 2020 00:03:55 -0700
> Stephen Boyd <swboyd@chromium.org> wrote:
>
> > Quoting Doug Anderson (2020-08-31 11:59:37)
> > > On Sat, Aug 29, 2020 at 10:18 AM Jonathan Cameron <jic23@kernel.org> wrote:
> > > > Agreed. However, I'd like a comment next to the place we turn it on
> > > > saying what delays we are trying to mitigate by enabling it in this
> > > > driver.
> > >
> > > OK, I used function graph to get a trace.  Some of the time is simply
> > > i2c transfers, which we do A LOT of during initialization (and i2c
> > > transfers aren't known for being instant).  However, that's not the
> > > big problem.  Check out the regmap_read_poll_timeout() in
> > > sx9310_init_compensation().  20 ms per sleep with a 2 second timeout.
> > > This seems to eat over around 220 ms of the time on my system.
> > >
> > > So how do you want to do this?  Do you want me to re-post the patch
> > > and mention the regmap_read_poll_timeout() in the commit message?  Do
> > > you want to just add that to the commit message yourself?
> > >
> >
> > I think the suggestion is to put a comment next to the
> > PROBE_PREFER_ASYNCHRONOUS flag indicating that
> > sx9310_init_compensation() can take a while.
>
> Yup. That's what I meant. Sorry for lack of clarity.
> A comment in the code stops others copying it without making sure they
> understand whether it is relevant in their case.  No one is going
> to look in commit messages.

OK, posted.  I expect it'll show up soon at:

https://lore.kernel.org/r/20200901081920.v2.1.Id02b2f451b3eed71ddd580f4b8b44b3e33e84970@changeid


> > Should the compensation be
> > delayed even further though to some time when userspace opens the device
> > node?
>
> It's tricky because we may hit it on an individual sysfs read.
> We could spin off a thread to do it I suppose, though that would be
> more or less the same as allowing async probe.

Also: even if we delayed the compensation further we'd still end up
with a somewhat slow probe just due to the metric buttload of i2c
transfers we do at probe time.


-Doug
