Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9C37B8BB8
	for <lists+linux-iio@lfdr.de>; Fri, 20 Sep 2019 09:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404845AbfITHpf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Sep 2019 03:45:35 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:53516 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404836AbfITHpf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Sep 2019 03:45:35 -0400
Received: by mail-wm1-f54.google.com with SMTP id i16so1264626wmd.3
        for <linux-iio@vger.kernel.org>; Fri, 20 Sep 2019 00:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=SukYf+oYjiVAtUZonOX1f0sBqiz9F+1YDC3zOB7yEjo=;
        b=jPcWwpIdGPxQC8WpTqDH6BcyuF/ARGAhCO+l5oitaDtwk4Urr5Qe5P8pt1FQB5X3Zo
         mGgUkubZY438ataWxIWWkOM0GKnXmPFMxpKMo9CwOmOOYTkQ1L1KFo2s697CrPdV3Z4o
         tkfKsN7Q/+Q3cLt5mJZZAi39LXUgDzwp7nUREOP293xFzbOmumWs3rnPS+JtUwKUzfrF
         HWeORUR7P8/5Gn8RD9QlrAxdE2ahobRJ59Bz0uYqpvQr06q+EMkxbCBC24VVivfOgq8U
         d8406F2l/wdgrw7ZGVY/W74kSGc0y+873O3AjaAn6z0it3VRdEHtsG0F5XcFXRsakq1K
         tdiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=SukYf+oYjiVAtUZonOX1f0sBqiz9F+1YDC3zOB7yEjo=;
        b=b/lO5ulO1xfmirqg53ffG8PUY07f53KOwnmcJyWMB7Ly+ceCbIJ9tfdovWxg8sTNKI
         U+lIO8z1ErTojwwYhciG/QuQwRjKrBhoNxm7fQoSHvyFItPZta2kE42h2NpVLQY4Hsp6
         Ih1Hwo2M9INmIhyOUGxfnJKbqrbUvVKot6xzRDxIIp1oPeVR+s3sjs2iU9Y0575F8wT+
         2A96lO0CcW/UBwUcyTvpcMO6TG0lslUKa9ZMhfcqnWSw1MVNa5GnuZvg/IEWj3uqYBZX
         VPOST6wAxwTE/UICRUeXI2aSN0Bbwv8KvsrAyBBX3Jm45ZPXPwExPmo+m8OpXyaYaNzg
         9Tpg==
X-Gm-Message-State: APjAAAW9HOiwIErBhnA4Qiyxn/hevjhyvKaiJpUKpHFvwp+pUM5C1gy9
        XBlED27/n+uatgIRfBofk9y5TpHbJGYkgpGTe56X3A==
X-Google-Smtp-Source: APXvYqzvAZeHe55lOdSijkI2+CDJ+ChR2MowUWr4vegL/4ERFhDPVjWOk9923SmS+F3DTn+lKMh+mwvvbyJzf62c1Vs=
X-Received: by 2002:a1c:980e:: with SMTP id a14mr2156195wme.99.1568965532616;
 Fri, 20 Sep 2019 00:45:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190912144310.7458-1-andrea.merello@gmail.com>
 <20190912144310.7458-5-andrea.merello@gmail.com> <f91fb6e960dfd67926b6efa44ec7b792fc667468.camel@analog.com>
 <CAN8YU5NLZhCDaocrQGUnb9TZauT-yPxY7ZQQQeYK=9696jmhCg@mail.gmail.com> <4a25469a-9fe6-a560-b1cb-e9b0af7209e9@essensium.com>
In-Reply-To: <4a25469a-9fe6-a560-b1cb-e9b0af7209e9@essensium.com>
Reply-To: andrea.merello@gmail.com
From:   Andrea Merello <andrea.merello@gmail.com>
Date:   Fri, 20 Sep 2019 09:45:21 +0200
Message-ID: <CAN8YU5ORoM69GDi4VVGf6iWb3A2S1ZjkiLmcV+_hUbG4446yXQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] iio: ad7949: fix channels mixups
To:     Couret Charles-Antoine <charles-antoine.couret@essensium.com>
Cc:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Il giorno ven 13 set 2019 alle ore 13:30 Couret Charles-Antoine
<charles-antoine.couret@essensium.com> ha scritto:

> >> One thing that maybe could be optimized (for the driver), is in `ad7949_spi_read_channel()` to use the current-channel &
> >> not do a SPI write to change the channel if it doesn't change.
> >>
> >> Datasheets (in general) are not always obvious about describing chip behavior for SW (or for writing a driver), but I
> >> would suspect that if you are reading garbage data, it could be that the channel has changed.
> >> This is true for some other ADCs.
> >> And requires testing for this one.
> > Yes, it's exactly what I've seen here. If the channel does not change
> > then the AD is already in acquisition phase on the right channel (I
> > assume it's OK to keep it in such phase indefinitely), then we can
> > just trigger a new conversion (CNV low->high, that is a dummy xfer)
> > and then read the result in following xfer, as the driver already did.
> >
> > I craft a V2 that performs the extra (3rd) spi xfer only if the
> > channel has to change.
>
> This design should be ok. I didn't implement in that way because not
> enough time to optimize the driver before release (I don't have access
> to the chip anymore) and for our workflow it was not relevant (we
> scanned all channels).

I was in the process of doing this, but, thinking again about it, I'm
not completely sure it is really OK:
Should we guarantee that the value we return as outcome of a IIO read
request (i.e. we access in_voltage_raw) is sampled _after_ the user
read request?

For example, the user might setup some other HW for the measure, or
somehow wait for the right moment for doing the measure, and then
perform the read from IIO, thus it's probably not OK if we convert a
value sampled just before the IIO read request.

If we skip the configuration rewrite when the channel doesn't change -
as discussed above - then we actually _terminate_ the acquisition when
the IIO read is triggered, that is we are converting the value sampled
right before the IIO read.

If this is OK then I'll go on, otherwise I think that we should always
do the three cycles (so that triggering IIO read always waits also for
a new acquisition phase)
