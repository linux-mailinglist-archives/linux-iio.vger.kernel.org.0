Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D18893536F4
	for <lists+linux-iio@lfdr.de>; Sun,  4 Apr 2021 07:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbhDDFCQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 4 Apr 2021 01:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhDDFCP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 4 Apr 2021 01:02:15 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5105FC061756
        for <linux-iio@vger.kernel.org>; Sat,  3 Apr 2021 22:02:11 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id l9so1664988ils.6
        for <linux-iio@vger.kernel.org>; Sat, 03 Apr 2021 22:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ymBWF8RValP1w9oK7OL8uVsDNb3oVxkLvI5DJEjGf7I=;
        b=Y4/iMk3SnQ2Ojaz1Vp8+gYQBSgrEqGDHApDnxG97YpzzWfaEHkXGtm4zOWsxyKExWb
         yuS5w49MAVpZE80egscRDfeI5Bd0q5k+mNEZ+9AiqK8+8mWGPoGOsiEfbcjUxcjK7n4r
         OLoMipQnpYKmjivkBwmMK0SE6xoCM0szHSp/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ymBWF8RValP1w9oK7OL8uVsDNb3oVxkLvI5DJEjGf7I=;
        b=CUI6A6Q82BoEAZ8iXGDgL6PLq/a7Ns6opwDCMlR5nz6Y5lE2c5dHj5h4ph5YZwt/5y
         nIJz+fXsMR6GpczNYFI4cn7gzMZj+1/EciQIMa1L75XG+51xeiaGL5JPNnCpBvInNW+e
         BoBCRkTxa72b2+bR6xFyRF2soOIc7AiSku06eW58fgZ6aa2f5SAw8crn/sqH/lKIv5L2
         v3RJIko6gB+XvZpynFXu+DUnqScT1c+6SyW2kPiSacSyDQ+YN3na3pVxUAjC9DHXTS9k
         yv+zY31uT81NRZs7axzOHqdkFoyincTj/SYykhj0J8hFSCyt2KxmXnBu3eIjleJ1B5mA
         K2fA==
X-Gm-Message-State: AOAM5307IhlLqkF2Nbcr+qcrWNLNRHBzhEY0roi+KnXyQUApr8xc0J5j
        hzNFroAisg5v3gRDupZAFQFRzehBrPyO0nw8zCWttg==
X-Google-Smtp-Source: ABdhPJynHBiSQNI8YF1T69hZwPI4+AF75A+59YWAoGTswgwFZ45Ql8dQ2FN+sxym/yaU04WVUzElNNWttxRJgx6rjhQ=
X-Received: by 2002:a92:c5d0:: with SMTP id s16mr7343386ilt.149.1617512530674;
 Sat, 03 Apr 2021 22:02:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210328033639.1021599-1-gwendal@chromium.org>
 <161698755179.3012082.10332557476670862687@swboyd.mtv.corp.google.com>
 <CAPUE2usX-Tq2wyO4ekkAUaR6rRfJ3mZG3SQMqJbpzzUTMwd-0A@mail.gmail.com>
 <20210401141935.1fd2e15d@jic23-huawei> <161732394517.2260335.9268876008128877361@swboyd.mtv.corp.google.com>
 <20210402103621.7403af14@jic23-huawei>
In-Reply-To: <20210402103621.7403af14@jic23-huawei>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Sat, 3 Apr 2021 22:01:58 -0700
Message-ID: <CAPUE2ut=sxgPu9HJr16zi183NsPKpHM6eN=16BtcdxeqGz=uLQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] iio: sx9310: Add debouncer-depth parameters
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Daniel Campello <campello@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Apr 2, 2021 at 2:36 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Thu, 01 Apr 2021 17:39:05 -0700
> Stephen Boyd <swboyd@chromium.org> wrote:
>
> > Quoting Jonathan Cameron (2021-04-01 06:19:35)
> > > On Tue, 30 Mar 2021 17:38:03 -0700
> > > Gwendal Grignou <gwendal@chromium.org> wrote:
> > >
> > > > On Sun, Mar 28, 2021 at 8:12 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > > > >
> > > > > Quoting Gwendal Grignou (2021-03-27 20:36:37)
> > > > > > Semtech SX9310 SAR sensor has a debouncer filter: only when N
> > > > > > measurements are above/below the far/close threshold an event is
> > > > > > sent to the host.
> > > > > > By default the debouncer is set to 2 events for the close to far
> > > > > > transition and 1 event (no debounce) for far to close.
> > > > > > It is a balance speed of detection and false positive avoidance.
> > > > > >
> > > > > > On some chromebooks, the debouncer is set to a larger number.
> > > > > >
> > > > > > This patch applies on top of commit 103d6ec82676 ("iio: sx9310: Support ACPI properties")
> > > > >
> > > > > The near/far debounce settings are already supported via sysfs. Can you
> > > > > use those instead of putting this into DT/ACPI? See
> > > > > sx9310_read_far_debounce() and associated code.
> > > > Stephen, I missed you already proposed these bindings earlier
> > > > [https://lore.kernel.org/linux-devicetree/20200906150247.3aaef3a3@archlinux/].
> > > > After Jonathan inputs, it is done via sysfs interface
> > > > [events/thresh_{falling|rising}_period].
> > > >
> > > > The debounce parameters are in the same class as the other parameters
> > > > already present in the DT. They are calculated during tests to meet
> > > > FCC requirements, in particular the time it takes to detect a human
> > > > body near the antennas.
> >
> > The same could be said for the threshold values but those are in sysfs.
>
> Good point.
>
> >
> > > > Depending on the SAR antenna design, it is a balance between lowering
> > > > the debouncer "period" to raise an event as soon as possible, and
> > > > increasing it to prevent false posible.
> > > >
> > > > In addition to controlling it from sysfs, could it be acceptable to
> > > > have it in DT/ACPI as well?
> > > > In the meantime, I will make sure semtech,sx9310.yaml matches
> > > > in_proximityX_hardwaregain_available and connect to that attribute.
> > > >
> >
> > My understanding from the previous discussions with Jonathan was that
> > anything that could be delayed until later should be done through sysfs.
> > That's why only some properties are in DT, because they were used during
> > initial compensation of the device that happens when the device driver
> > probes. These other values like thresholds and debounce weren't required
> > for that so I put them into sysfs.
>
> My intent wasn't so much things that 'could' be delayed until later, but
> rather the divide between policy (which should be in userspace control)
> and hardware factors. We have a bit of an edge case here so not clear
> cut.
>
> I may well have been wrong in the past on this :(

Looking at the code again, the current approach makes sense, and
having access through sysfs is nice since it allows easy
experimentation.
Let's forget this patchset, I will configure the required parameters from sysfs.

Gwendal.
>
> Jonathan
>
> >
> > >
> > >
> > > Ok, add something to make it clear that these effectively tied to the board
> > > hardware because of this FCC requirement.
> > >
> > > As long as that's clear the Rob is fine with the DT binding I don't mind.
> > >
> > > Is there a requirement as a result of this FCC stuff that we should not
> > > expose them to userspace control if they are provided in DT?
> > >
> > > If so we should figure out a sensible way of doing that without breaking
> > > the existing ABI.
> > >
>
