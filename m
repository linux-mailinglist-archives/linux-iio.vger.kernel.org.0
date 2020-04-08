Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6E51A27C5
	for <lists+linux-iio@lfdr.de>; Wed,  8 Apr 2020 19:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgDHRKp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 Apr 2020 13:10:45 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34523 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730529AbgDHRKo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 Apr 2020 13:10:44 -0400
Received: by mail-io1-f66.google.com with SMTP id f3so892612ioj.1
        for <linux-iio@vger.kernel.org>; Wed, 08 Apr 2020 10:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EVMc1OHJHB8VvA0TWlbmWmPavYiZYAI6v/n+zzq1Wf0=;
        b=JlEGM/DOa4q8siqwVYUAftU8gmZWjOLtOYJEE+Bp5LCO4tlR1jInMjHa136elkQI5X
         fM45YgN4JD3Wm3RtLmMIac1umB86TBoz7VTMsdvJzqdYMKwkFn6ta31nyfuRuxYniSow
         reddZXCDRqSsCYkcqfJA8aQ7XAHdHC0hXldCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EVMc1OHJHB8VvA0TWlbmWmPavYiZYAI6v/n+zzq1Wf0=;
        b=lGj1UtGSLTYXnTQHMePZPM4q9XtEKLLbS2ykDvAkK2iT2ExDXFyabMjWwcuXb400gK
         YpxtlHeJIsUHapmdgoAPYmdIMi+PtRsLusnPxynnNGhJ+nplKmEy1HWEmPcs2SiXsWcu
         HZaXK6JSwjY5saQ/Y3MkGObeuRz+SmrBY08aAo6ZUBJ6LvdruvJfnyzVYUYsmGjLA189
         n7wjXfyABxPZNG1SDl94qFHeKF/eGuXBfSPlu1R4ZqIbwJbrGWM88tehSMt6ecPCbmOa
         DhlaMzAmmbQOaaMbbAULIpwNWYgL4M3JxDgfp+9u6L/ImOY7tShzYmlMU989cy0xIfNB
         NBkQ==
X-Gm-Message-State: AGi0PuYWdfcGufP4bAfTyweNHizHWjE1u8M+KkGAFdKpy4C04+0Cay4r
        iq7MYh3SxiW5Wm8YdUOmpqPOlnHqBSMBrmRps+clrA==
X-Google-Smtp-Source: APiQypJJEoOGQVIJXcXfMbzaBXaiK4IXHxoudhmAmL2UMkWJOUiQXKhncget2FEh09Lc9nSdPCYNibmpUlv56cYFUCg=
X-Received: by 2002:a02:cac4:: with SMTP id f4mr7518997jap.51.1586365841562;
 Wed, 08 Apr 2020 10:10:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1566563833.git.fabien.lahoudere@collabora.com>
 <d985a8a811996148e8cda78b9fe47bb87b884b56.1566563833.git.fabien.lahoudere@collabora.com>
 <20190826095612.7455cb05@archlinux> <8abbe9360938ab851d16c2c1494ba56034775823.camel@collabora.com>
 <6b50bdff184e6af664b7a61e0a8a2cddc5718f0a.camel@collabora.com>
 <20191110151408.GB3984@icarus> <20191111114955.00001031@huawei.com> <20191112011618.GA62259@icarus>
In-Reply-To: <20191112011618.GA62259@icarus>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Wed, 8 Apr 2020 10:10:28 -0700
Message-ID: <CAPUE2uvDiAfE68uCzWdTN3T2L_PR3JPeyGWDrc5ToLieEpGH1A@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] counter: cros_ec: Add synchronization sensor
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        Enrico Granata <egranata@chromium.org>,
        Collabora kernel ML <kernel@collabora.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Nick Vaccaro <nvaccaro@chromium.org>,
        linux-iio <linux-iio@vger.kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

I resend a counter driver for the EC at
https://patchwork.kernel.org/patch/11479437/

I tried a timestamp only IIO sensor, but this is not allowed, as the
timestamp channel is very specific: no extended parameters can be
added.
I did not add a COUNTER_COUNT_TALLY type, as a newer function
COUNTER_COUNT_FUNCTION_INCREASE, fits the counter better.
I am still using IIO_COUNT (inspired by the st counter driver) to
gather the event in real time on the iio side.

Gwendal.


On Mon, Nov 11, 2019 at 5:16 PM William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:
>
> On Mon, Nov 11, 2019 at 11:49:55AM +0000, Jonathan Cameron wrote:
> > On Sun, 10 Nov 2019 10:14:08 -0500
> > William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
> >
> > > On Tue, Sep 24, 2019 at 04:20:51PM +0200, Fabien Lahoudere wrote:
> > > > Hi all,
> > > >
> > > > After some discussions and investigation, the timestamp is very
> > > > important for that sync driver.
> > > > Google team uses that timestamp to compare with gyroscope timestamp.
> > > >
> > > > So the important data is timestamp and counter value is useless.
> > > > Just the event of counter increment is important to get a timestamp.
> > > >
> > > > In that case, my idea was to just use an IIO driver with a single
> > > > channel with IIO_TIMESTAMP. We discuss this here and it seems
> > > > controversial.
> > > >
> > > > So my question to Jonathan is if we have a timestamp coming from the EC
> > > > itself, can we consider this timestamp as a good IIO driver?
> > > >
> > > > Any other idea is welcome, however Google team would like to manage
> > > > only IIO drivers if possible.
> > > >
> > > > Thanks
> > >
> > > Jonathan,
> > >
> > > Should the the timestamp from the EC be introduced as an IIO driver
> > > using IIO_TIMESTAMP?
> >
> > It is is a rather odd driver but I suppose it would be fine with lots
> > of clear docs on why it is how it is...
> >
> > >
> > > Since there is no corresponding EC Counter driver in the baseline right
> > > now we don't have a conflict yet. If the EC timestamp is introduced as
> > > an IIO driver then we should make any future EC Counter driver mutually
> > > exclusive with the IIO driver in order to prevent any memory space
> > > conflict. At that point we may deprecate the IIO driver and move the
> > > timestamp functionality to the corresponding Counter driver.
> >
> > That route does become somewhat of a mess so I suspect we'd have to have
> > a single driver supporting both userspace interfaces.  If you are happy
> > that we'd be adding a bit of legacy to support for ever then we can go
> > that way.
>
> Generally I'd prefer all components of a device to be supported, but
> if this is as Fabien suggests that due to the nature of this particular
> device the counter value is of no interest, then a Counter driver is of
> little practical use here. In this particular case, it seems better to
> restrict the driver support to just the timestamp functionality that
> will be used, rather than introduce extra code to expose values that
> will likely be ignored and risk adding code to the kernel that becomes
> unmaintained due to lack of exposure or interest.
>
> William Breathitt Gray
>
> >
> > >
> > > That's assuming someone is interested in the Count component enough to
> > > implement an EC Counter driver; otherwise, the IIO driver will serve
> > > just fine if timestamp is the only data desired from this device.
> > >
> > > William Breathitt Gray
> >
> >
