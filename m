Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4F8330094
	for <lists+linux-iio@lfdr.de>; Sun,  7 Mar 2021 12:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbhCGLza (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Mar 2021 06:55:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:35518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231147AbhCGLzE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Mar 2021 06:55:04 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08C466501D;
        Sun,  7 Mar 2021 11:55:02 +0000 (UTC)
Date:   Sun, 7 Mar 2021 11:54:58 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bastien Nocera <hadess@hadess.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: event_monitor: Enable events before monitoring
Message-ID: <20210307115458.2be0854b@archlinux>
In-Reply-To: <CACRpkdaNWyQhdCDOHmRA6yWyeSXfi1WBBUauR73wdVTtFOjfUA@mail.gmail.com>
References: <20210304154205.1918124-1-linus.walleij@linaro.org>
        <969d00d5ea1e2d575a8464bebef4a8f16285ed98.camel@hadess.net>
        <CACRpkdZcyWPUtJbjYMS=mWZW48ZkKe=arAydJbXK6E8jyQT=hA@mail.gmail.com>
        <20210306153929.51b053bc@archlinux>
        <CACRpkdaNWyQhdCDOHmRA6yWyeSXfi1WBBUauR73wdVTtFOjfUA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 6 Mar 2021 22:29:41 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Sat, Mar 6, 2021 at 4:39 PM Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > Sadly this doesn't work for many devices.
> > It is a common thing for hardware to only support a much smaller
> > set of event monitoring registers / threshold detectors than the
> > number of channels.  In many cases we handle that by working on
> > a fifo basis.  So what this will do is enable a bunch of events
> > which will then be replaced by later events - end result some
> > random event will be enabled (or maybe 2 of them across N channels)  
> 
> I understand.
> 
> What about augmenting the heuristics like this:
> 
> 1. Count the available events.
> 2. If they are just one, then enable that event and disable after use.
> 
> This will make all proximity sensors and other things that just
> provide a single event work out of the box.

Rather unintuitive interface.  I think we are better off just
adding a -a parameter like we have for the buffer example.

If people get used to it enabling sensible events for a simple device
then move on to a more complex one where the heuristic breaks down
then they will be very confused.

J

> 
> Yours,
> Linus Walleij

