Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00FD4BAF44
	for <lists+linux-iio@lfdr.de>; Mon, 23 Sep 2019 10:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437882AbfIWIWF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Sep 2019 04:22:05 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42925 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437610AbfIWIWE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Sep 2019 04:22:04 -0400
Received: by mail-wr1-f67.google.com with SMTP id n14so12826474wrw.9
        for <linux-iio@vger.kernel.org>; Mon, 23 Sep 2019 01:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=Yd8cALNY7T8j/UhdgMN+RKstjx0ZHQ7t8a2e6pRsyX8=;
        b=RYyWigXOnXaRUtn7BzWqhdrhsl4Dcv9MBFq5Id8BBzV06vwSs2ha4navJSbZCpeuqf
         IKvneIkTEcXrQ6WKym7WBu9R/QzZLCbNtYE+pYlArq01JHYXyqdsnivxTqmjvztHAlpD
         eJQIOcdox1D37rg9ddqp1kcu+JCekYG9iif8ik00gSIOsPFYflHJgtukxutp+6yKl4UR
         nO6Eh32WLMADZnf7SwxxjeXVCuY1RR+TWs34Vp36BBaj3CGhayaf19rLObJuC6kCjXfD
         /NG0yWF+PrOWH2xk7xZ35FGo5op0NtGs5HcftMT6fFd3ZjibHnNHCLAMkTc+pF3DoU2z
         CxTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=Yd8cALNY7T8j/UhdgMN+RKstjx0ZHQ7t8a2e6pRsyX8=;
        b=Q1a5BTzLTPtrN2MSdTBbqBJ61Rw/mUSGm5g5ZY0Civfp67dydvp+V50lWpz20Ae14a
         fEdrfWCqTshSF8dRo9k0MihFxNV0pz/4o41VCFYnIxfNVJuKfIyBDpWN9c45wM93AAZT
         2xoV9JYbqf81v5XG+QbKsiHNxKAc2XSMjapA+Al6rqKRQgkH313W2QWVx5QlAMhEJWxr
         75GgQzYnOrwfYRRQ5eMheza2VI1TYMd64TKh++Pj8Zl+8f8kUiBpoqgjdwOCQwLcbw/g
         6fn9PXf4rQXVERpW2hGWN1scM2DywG7nCSuI5BJYlIByuykINIDY/3GeyQRZuUxj335J
         YIdA==
X-Gm-Message-State: APjAAAVIwQojzxt574scmkWv726NO5VxqyZqNnsCPYTTaIag6P3eu7j0
        CnY0qjC2N8t+ip/te8fnoOcnoRilde0iknb7s/c=
X-Google-Smtp-Source: APXvYqygWihIbGNm9rJhh3MIDBalyGbZrTZobbK+9NFoMJNJH0WwIcZMMegmuE6N0UdsCK8yYK7OVWsyPDDOljqOoBw=
X-Received: by 2002:adf:cc87:: with SMTP id p7mr20315984wrj.43.1569226921212;
 Mon, 23 Sep 2019 01:22:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190912144310.7458-1-andrea.merello@gmail.com>
 <20190912144310.7458-5-andrea.merello@gmail.com> <f91fb6e960dfd67926b6efa44ec7b792fc667468.camel@analog.com>
 <CAN8YU5NLZhCDaocrQGUnb9TZauT-yPxY7ZQQQeYK=9696jmhCg@mail.gmail.com>
 <4a25469a-9fe6-a560-b1cb-e9b0af7209e9@essensium.com> <CAN8YU5ORoM69GDi4VVGf6iWb3A2S1ZjkiLmcV+_hUbG4446yXQ@mail.gmail.com>
 <20190921181253.43fa0071@archlinux>
In-Reply-To: <20190921181253.43fa0071@archlinux>
Reply-To: andrea.merello@gmail.com
From:   Andrea Merello <andrea.merello@gmail.com>
Date:   Mon, 23 Sep 2019 10:21:49 +0200
Message-ID: <CAN8YU5O5ouLXnpi=f1jHfbbVXGjtFOT00cG+fggWWbxDco111w@mail.gmail.com>
Subject: Re: [PATCH 4/4] iio: ad7949: fix channels mixups
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Couret Charles-Antoine <charles-antoine.couret@essensium.com>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Il giorno sab 21 set 2019 alle ore 19:12 Jonathan Cameron
<jic23@kernel.org> ha scritto:

> >
> > If we skip the configuration rewrite when the channel doesn't change -
> > as discussed above - then we actually _terminate_ the acquisition when
> > the IIO read is triggered, that is we are converting the value sampled
> > right before the IIO read.
> >
> > If this is OK then I'll go on, otherwise I think that we should always
> > do the three cycles (so that triggering IIO read always waits also for
> > a new acquisition phase)

I had a discussion about this with a HW engineer, he said that it's
probably not necessary to perform a full extra cycle (i.e. SPI xfer +
udelay(2)), rather, since the HW is already in acquisition, it should
be enough to perform the udelay(2) to make sure the internal capacitor
settles (if we change channel of course we need also the SPI xfer to
update the CFG).

So indeed it seems to me that:
- if CFG (channel) changes: we need three full SPI xfer (actual SPI
xfer + delay(2))
- if CFG (channel) doesn't change: we need a delay(2) [*]- to
guarantee the user sees a value sampled after the IIO read, as
discussed - and two full SPI xfer (actual SPI xfer + delay(2))

.. Indeed I also wonder if it would be enough to cycle the CS, without
performing a full SPI xfer, in order to start the conversion.. But
given that this whole thing seems to me a bit complicated and unclear,
I would stick to the dummy cycle for now..

> An excellent point.  I agree and suspect we may have this wrong in other
> sensors.  The question gets more interesting if running in buffered mode
> as we have had systems using a trigger generated by an external process.
> I suppose in that case we just have to deal with the offset in the fifo
> etc in userspace.

Yes. I'm not familiar with IIO buffered mode, but for a streaming,
continuous, read mode I guess that the user would expect some latency
anyway (might be due to the ADC or the buffering mechanism itself or
whatever).

I didn't look into this buffered thing to see how it works, but maybe
we can skip the first udelay(2) [*] in the driver in case of buffered
access?

> Maybe we should think about adding a note to be careful of that.  Not
> really sure where we would note it though...

IMHO clarifying what the API guarantees and what it doesn't in IIO
DocBook could be helpful (I didn't see it, but I might have missed
it)..

So, we could state that a single shot read must return a value sampled
after the read has been shot, and that on the other hand, when using
buffered mode one should expect some latency.. But indeed, since you
said that we might have a number of IIO drivers that actually behave
in a different way, then I'm not sure that it's a good idea; maybe we
could just drop this requirement and allow (and document) that a
single shot IIO read could just _terminate_ the sampling and trigger
the conversion on the current sampled signal? (so also in this driver
we can just not care about this)..

> Thanks,
>
> Jonathan
>
>
