Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8686488A98
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jan 2022 17:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234012AbiAIQf7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Jan 2022 11:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiAIQf7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 Jan 2022 11:35:59 -0500
Received: from haggis.mythic-beasts.com (haggis.mythic-beasts.com [IPv6:2a00:1098:0:86:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA34EC06173F
        for <linux-iio@vger.kernel.org>; Sun,  9 Jan 2022 08:35:58 -0800 (PST)
Received: from [81.101.6.87] (port=47174 helo=jic23-huawei)
        by haggis.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <jic23@jic23.retrosnub.co.uk>)
        id 1n6bAh-0005pt-Kz; Sun, 09 Jan 2022 16:35:56 +0000
Date:   Sun, 9 Jan 2022 16:41:50 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v10 3/5] iio: proximity: Add SX9324 support
Message-ID: <20220109164142.618e6fd4@jic23-huawei>
In-Reply-To: <CAHp75VdPs6BcA2uka3irNr3mNBY9T-Dtw7J0M=Emm7_RPo+1yw@mail.gmail.com>
References: <20220101203817.290512-1-gwendal@chromium.org>
        <20220101203817.290512-4-gwendal@chromium.org>
        <CAHp75VdPs6BcA2uka3irNr3mNBY9T-Dtw7J0M=Emm7_RPo+1yw@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 4
X-Spam-Status: No, score=0.4
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 9 Jan 2022 14:19:44 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sun, Jan 2, 2022 at 6:28 PM Gwendal Grignou <gwendal@chromium.org> wrote:
> >
> > Semtech SAR sensor SX9324 is an evolution of the SX9310:
> > It has 4 phases that can be configure to capture and process data
> > from any of 3 CS pins and provide independent detection:
> > proximity, table proximity or body proximity.
> >
> > Gather antenna data:
> >   echo sx9324-dev3 > trigger/current_trigger
> >   echo 1 > scan_elements/in_proximity0_en
> >   echo 1 > buffer/enable
> >   od -v -An --endian=big -t d2 -w2 /dev/iio\:device3
> >   (at 10Hz, the default).
> >
> > Trigger events:
> > Setting:
> >   thresh_falling_period: 2 (events)
> >   thresh_rising_period: 2 (events)
> >   in_proximity0_thresh_either_value: 300
> >   in_proximity0_thresh_either_hysteresis: 72
> >
> > using iio_event_monitor /dev/iio\:deviceX, approaching my hand to the
> > antenna pad, I see:
> > ...
> > Event: time: 1634763907532035297, type: proximity, channel: 0, evtype:
> > thresh, direction: falling
> > Event: time: 1634763910138104640, type: proximity, channel: 0, evtype:
> > thresh, direction: rising
> > ...
> >
> > Datasheet:
> > https://edit.wpgdadawant.com/uploads/news_file/program/2019/30184/tech_files/program_30184_suggest_other_file.pdf  
> 
> Jonathan, I noticed you have applied this to testing, can you please
> make Datasheet a real tag?
> I.o.w. put it to one line and drop the following blank line.
> 
Sure.  Can roll other fixes in as well until rc1 shows up and I rebase the tree.

I tidied up the other patch naming in here to make it more consistent whilst
I was there.

New tree pushed out.
Thanks,

Jonathan


