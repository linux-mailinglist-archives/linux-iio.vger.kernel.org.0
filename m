Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C071032FB68
	for <lists+linux-iio@lfdr.de>; Sat,  6 Mar 2021 16:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbhCFPjo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 Mar 2021 10:39:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:41306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230415AbhCFPje (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 6 Mar 2021 10:39:34 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC97164FF0;
        Sat,  6 Mar 2021 15:39:32 +0000 (UTC)
Date:   Sat, 6 Mar 2021 15:39:29 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bastien Nocera <hadess@hadess.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: event_monitor: Enable events before monitoring
Message-ID: <20210306153929.51b053bc@archlinux>
In-Reply-To: <CACRpkdZcyWPUtJbjYMS=mWZW48ZkKe=arAydJbXK6E8jyQT=hA@mail.gmail.com>
References: <20210304154205.1918124-1-linus.walleij@linaro.org>
        <969d00d5ea1e2d575a8464bebef4a8f16285ed98.camel@hadess.net>
        <CACRpkdZcyWPUtJbjYMS=mWZW48ZkKe=arAydJbXK6E8jyQT=hA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 4 Mar 2021 21:48:25 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Thu, Mar 4, 2021 at 5:00 PM Bastien Nocera <hadess@hadess.net> wrote:
> 
> > If I'm not mistaken, "-a" does that for the iio_generic_buffer tool.  
> 
> Yeah I implemented that, and I thought about doing the same here
> but ... the name of the tool sort of announce that one want to
> listen to all events so I thought it should just default-enable
> all of them in this case.
> 
> > Maybe moving enable_disable_all_channels() to a common location and
> > using that would cut down on the duplicated code?  
> 
> The event enablement is slightly different, the generic buffer
> turns on various channels, which is conceptually different
> from various events, but let's see what Jonathan says.
> 
> We are sharing most of the code already in the iio-utils.c
> but I can try to break out more if it doesn't get to abstract.

Sadly this doesn't work for many devices.
It is a common thing for hardware to only support a much smaller
set of event monitoring registers / threshold detectors than the
number of channels.  In many cases we handle that by working on
a fifo basis.  So what this will do is enable a bunch of events
which will then be replaced by later events - end result some
random event will be enabled (or maybe 2 of them across N channels)

Not intuitive at all :(

I'm fine with it being controlled by a parameter though if
that works for you.  Docs should explain it doesn't always
result in all events being enabled however if the hardware
is not capable of doing that.

Jonathan


> 
> Thanks Bastien,
> Linus Walleij

