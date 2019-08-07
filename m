Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D14784D92
	for <lists+linux-iio@lfdr.de>; Wed,  7 Aug 2019 15:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388411AbfHGNim (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 7 Aug 2019 09:38:42 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40628 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388306AbfHGNim (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Aug 2019 09:38:42 -0400
Received: by mail-ed1-f66.google.com with SMTP id k8so86238089eds.7
        for <linux-iio@vger.kernel.org>; Wed, 07 Aug 2019 06:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yX9lEy1eIykEiCGi0dNbf5cBImnr6fHn7uE5y9QaXtA=;
        b=JDWBeuiQgQUJwUvfYvsB7+KP/t2cGBTp9ViMOgIN2F4oVmgaH/syhCZp6qVdbZ5SmU
         7YFOai3LfF4DqkvVP4RfB15O2vEINB4a2Sxmorr+4Ts9PbdLjEni8LGkxuEfqIiZaGe4
         eAFt+9Rc+G5o7j6MG634S2wXOM4B9hmGcgu1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yX9lEy1eIykEiCGi0dNbf5cBImnr6fHn7uE5y9QaXtA=;
        b=Ui6Ic4hq22YUxp6xvvRJycTJeN8lmbn6fbKwYrKOAV/vRqevFWq78YZ4oWRxKX2url
         mRf333Tsr16OUKme8YSAtoef93Ic8itvBerzOebkGqg3rRbmbtMoGG5E7uOm+IpwSXFG
         OlAne+7Q+KhV7qFlk0t6nVyc0AMIuNSAafXvTKy73Ba37sv8NL6tsPwcoRGV0ITKY27f
         9T/gr2o4p3VhmmO1+zzGswPAAQFmLNldNdy5hd+TekFh3oYXZ7etq5s6MfesJyBnT+TI
         WeVWHJyl0FCbQLRJaLqkiERMn4Yka7u9qQ1LKX3I2aLENNrPyhp/hV+1War/SsCvcuYS
         nnFg==
X-Gm-Message-State: APjAAAXop2w8f4Wd1sycPAZaY1ab7/wIg+W9JN5yIoQwd2qihoFSAS5T
        a/fNNQ+cZUKjpN0kKySAPBLcJLXsqzGZSg==
X-Google-Smtp-Source: APXvYqxnIL/Je79pz3uCpz1OdYxAYZg0Dxn4V/ebMsoQjHtMucrUL1Ah/tViRBFN5S3VbM3y20H+Hg==
X-Received: by 2002:aa7:d297:: with SMTP id w23mr9613413edq.128.1565185120380;
        Wed, 07 Aug 2019 06:38:40 -0700 (PDT)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id k10sm21100138eda.9.2019.08.07.06.38.37
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 06:38:37 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id p77so1682023wme.0
        for <linux-iio@vger.kernel.org>; Wed, 07 Aug 2019 06:38:37 -0700 (PDT)
X-Received: by 2002:a1c:407:: with SMTP id 7mr6104wme.113.1565185117043; Wed,
 07 Aug 2019 06:38:37 -0700 (PDT)
MIME-Version: 1.0
References: <20181017075242.21790-1-henryhsu@chromium.org> <CAAFQd5AL2CnnWLk+i133RRa36HTa0baFkezRhpTXf9YP0DSF1Q@mail.gmail.com>
 <CAHNYxRwbSSp02Zr4a1z5gh0q6cHUUDnZCqRQU7QtP8LMe3Jp2A@mail.gmail.com>
 <1610184.U7oo9Z4Yep@avalon> <CAAFQd5A7k2VgmawF-x=AcKhJiG-shrJiCP4Tu9054J0eE91+9w@mail.gmail.com>
 <d79e0857-c6ae-9e57-52e2-e596864a68f8@metafoo.de> <CAAFQd5C_QucJiZMUgCpztC52Mi3p6HDThHNkcNOm9C+SZUDDYQ@mail.gmail.com>
 <20190313012451.GR891@pendragon.ideasonboard.com> <CAAFQd5DtSD3TrXz8jaFnmBgpRQ6Gnq+LKxyY+LNZrqiM1pxNVA@mail.gmail.com>
 <CAAFQd5DreQkUsG9PnUxWMUDo6c+AxQMHm4ErZQFPjGqJz=wmCg@mail.gmail.com> <7c76f7ce-57ca-d7d5-fd81-70607f97b792@ideasonboard.com>
In-Reply-To: <7c76f7ce-57ca-d7d5-fd81-70607f97b792@ideasonboard.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 7 Aug 2019 22:38:24 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DNA=ixWqq584r0goNitHs8bb7-h27jNGD_DMyt6jHp5A@mail.gmail.com>
Message-ID: <CAAFQd5DNA=ixWqq584r0goNitHs8bb7-h27jNGD_DMyt6jHp5A@mail.gmail.com>
Subject: Re: [PATCH] media: uvcvideo: Add boottime clock support
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Alexandru Stan <amstan@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Gwendal Grignou <gwendal@chromium.org>,
        Heng-Ruey Hsu <henryhsu@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ricky Liang <jcliang@chromium.org>, linux-iio@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        =?UTF-8?B?SnVuZ28gTGluICjmnpfmmI7kv4op?= <jungo.lin@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Aug 6, 2019 at 5:34 PM Kieran Bingham
<kieran.bingham@ideasonboard.com> wrote:
>
> Hi Tomasz,
>
> On 06/08/2019 05:15, Tomasz Figa wrote:
> > On Wed, Mar 13, 2019 at 11:38 AM Tomasz Figa <tfiga@chromium.org> wrote:
> >>
> >> On Wed, Mar 13, 2019 at 10:25 AM Laurent Pinchart
> >> <laurent.pinchart@ideasonboard.com> wrote:
> >>>
> >>> Hi Tomasz,
> >>>
> >>> On Fri, Nov 23, 2018 at 11:46:43PM +0900, Tomasz Figa wrote:
> >>>> On Fri, Nov 2, 2018 at 12:03 AM Lars-Peter Clausen wrote:
> >>>>> On 11/01/2018 03:30 PM, Tomasz Figa wrote:
> >>>>>> On Thu, Nov 1, 2018 at 11:03 PM Laurent Pinchart wrote:
> >>>>>>> On Thursday, 18 October 2018 20:28:06 EET Alexandru M Stan wrote:
> >>>>>>>> On Wed, Oct 17, 2018 at 9:31 PM, Tomasz Figa wrote:
> >>>>>>>>> On Thu, Oct 18, 2018 at 5:50 AM Laurent Pinchart wrote:
> >>>>>>>>>> On Wednesday, 17 October 2018 11:28:52 EEST Tomasz Figa wrote:
> >>>>>>>>>>> On Wed, Oct 17, 2018 at 5:02 PM Laurent Pinchart wrote:
> >>>>>>>>>>>> On Wednesday, 17 October 2018 10:52:42 EEST Heng-Ruey Hsu wrote:
> >>>>>>>>>>>>> Android requires camera timestamps to be reported with
> >>>>>>>>>>>>> CLOCK_BOOTTIME to sync timestamp with other sensor sources.
> >>>>>>>>>>>>
> >>>>>>>>>>>> What's the rationale behind this, why can't CLOCK_MONOTONIC work ? If
> >>>>>>>>>>>> the monotonic clock has shortcomings that make its use impossible for
> >>>>>>>>>>>> proper synchronization, then we should consider switching to
> >>>>>>>>>>>> CLOCK_BOOTTIME globally in V4L2, not in selected drivers only.
> >>>>>>>>>>>
> >>>>>>>>>>> CLOCK_BOOTTIME includes the time spent in suspend, while
> >>>>>>>>>>> CLOCK_MONOTONIC doesn't. I can imagine the former being much more
> >>>>>>>>>>> useful for anything that cares about the actual, long term, time
> >>>>>>>>>>> tracking. Especially important since suspend is a very common event on
> >>>>>>>>>>> Android and doesn't stop the time flow there, i.e. applications might
> >>>>>>>>>>> wake up the device to perform various tasks at necessary times.
> >>>>>>>>>>
> >>>>>>>>>> Sure, but this patch mentions timestamp synchronization with other
> >>>>>>>>>> sensors, and from that point of view, I'd like to know what is wrong with
> >>>>>>>>>> the monotonic clock if all devices use it.
> >>>>>>>>>
> >>>>>>>>> AFAIK the sensors mentioned there are not camera sensors, but rather
> >>>>>>>>> things we normally put under IIO, e.g. accelerometers, gyroscopes and
> >>>>>>>>> so on. I'm not sure how IIO deals with timestamps, but Android seems
> >>>>>>>>> to operate in the CLOCK_BOTTIME domain. Let me add some IIO folks.
> >>>>>>>>>
> >>>>>>>>> Gwendal, Alexandru, do you think you could shed some light on how we
> >>>>>>>>> handle IIO sensors timestamps across the kernel, Chrome OS and
> >>>>>>>>> Android?
> >>>>>>>>
> >>>>>>>> On our devices of interest have a specialized "sensor" that comes via
> >>>>>>>> IIO (from the EC, cros-ec-ring driver) that can be used to more
> >>>>>>>> accurately timestamp each frame (since it's recorded with very low
> >>>>>>>> jitter by a realtime-ish OS). In some high level userspace thing
> >>>>>>>> (specifically the Android Camera HAL) we try to pick the best
> >>>>>>>> timestamp from the IIO, whatever's closest to what the V4L stuff gives
> >>>>>>>> us.
> >>>>>>>>
> >>>>>>>> I guess the Android convention is for sensor timestamps to be in
> >>>>>>>> CLOCK_BOOTTIME (maybe because it likes sleeping so much). There's
> >>>>>>>> probably no advantage to using one over the other, but the important
> >>>>>>>> thing is that they have to be the same, otherwise the closest match
> >>>>>>>> logic would fail.
> >>>>>>>
> >>>>>>> That's my understanding too, I don't think CLOCK_BOOTTIME really brings much
> >>>>>>> benefit in this case,
> >>>>>>
> >>>>>> I think it does have a significant benefit. CLOCK_MONOTONIC stops when
> >>>>>> the device is sleeping, but the sensors can still capture various
> >>>>>> actions. We would lose the time keeping of those actions if we use
> >>>>>> CLOCK_MONOTONIC.
>
> That's an important distinction. If there are operations that can run
> while the main host is in 'suspend' and still maintain "relative"
> timestamps in any form - then time must continue during suspend.
>
>
> >>>>>>> but it's important than all timestamps use the same
> >>>>>>> clock. The question is thus which clock we should select. Mainline mostly uses
> >>>>>>> CLOCK_MONOTONIC, and Android CLOCK_BOOTTIME. Would you like to submit patches
> >>>>>>> to switch Android to CLOCK_MONOTONIC ? :-)
> >>>>>> Is it Android using CLOCK_BOOTTIME or the sensors (IIO?). I have
> >>>>>> almost zero familiarity with the IIO subsystem and was hoping someone
> >>>>>> from there could comment on what time domain is used for those
> >>>>>> sensors.
> >>>>>
> >>>>> IIO has the option to choose between BOOTTIME or MONOTONIC (and a few
> >>>>> others) for the timestamp on a per device basis.
> >>>>>
> >>>>> There was a bit of a discussion about this a while back. See
> >>>>> https://lkml.org/lkml/2018/7/10/432 and the following thread.
> >>>>
> >>>> Given that IIO supports BOOTTIME in upstream already and also the
> >>>> important advantage of using it over MONOTONIC for systems which keep
> >>>> capturing events during sleep, do you think we could move on with some
> >>>> way to support it in uvcvideo or preferably V4L2 in general?
> >>>
> >>> I'm not opposed to that, but I don't think we should approach that from
> >>> a UVC point of view. The issue should be addressed in V4L2, and then
> >>> driver-specific support could be added, if needed.
>
> Agreed, this is a V4L2 topic - not a UVC specific topic.
>
>
> >> Yes, fully agreed. The purpose of sending this patch was just to start
> >> the discussion on how to support this.
> >>
> >> Do you think something like a buffer flag called
> >> V4L2_BUF_FLAG_TIMESTAMP_BOOTTIME that could be set by the userspace at
> >> QBUF could work here? (That would change the timestamp flags
> >> semantics, because it used to be just the information from the driver,
> >> but shouldn't have any compatibility implications.) I suppose we would
> >> also need some capability flag for querying purposes, possibly added
> >> to the capability flags returned by REQBUFS/CREATE_BUFS?
>
> What kind of 'compatibility' do we actually need to maintain here?

The existing applications would expect the timestamps to come from
CLOCK_MONOTONIC, so I believe that we can't make CLOCK_BOOTTIME the
default.

> IMO -
> CLOCK_BOOTTIME makes much more sense globally for video, because it's
> more representative of the temporal difference between frames captured
> if a system goes into suspend.
>
> If frames are captured:
>
> A B         C D
>    <suspend>
>
> Then I believe it would be correct for the timestamp delta between B-C
> to be large <representative of the suspend duration/real time>
>'

Indeed.

>
> > Any thoughts?
>
> Aha, there might be some gotchas around non-live sources operating
> across suspend-resume boundaries .. so perhaps there are certainly
> use-cases where both _MONOTONIC and _BOOTTIME have their relevance ...
>

What would be an example of such a non-live source?

>
> > Adding Hans and Kieran for more insight.
>
> I think if we're talking about core-V4L2, Hans' opinion takes more
> weight than my mumblings :-) - but overall - supporting _BOOTTIME in
> some form sounds beneficial to me.
>

Your input is very valuable. Thanks a lot! :)

>
> > Best regards,
> > Tomasz
> >
>
> --
> Regards
> --
> Kieran
