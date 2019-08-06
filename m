Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68DFC82A3A
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2019 06:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725853AbfHFEXe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Aug 2019 00:23:34 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44966 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfHFEXe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Aug 2019 00:23:34 -0400
Received: by mail-ed1-f65.google.com with SMTP id k8so80989635edr.11
        for <linux-iio@vger.kernel.org>; Mon, 05 Aug 2019 21:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pl4laxveqxbFoLVSBJBsq2q/ipMs/mfndz3RNUveMcY=;
        b=DzyWmD70Zod3tb8nY7SBaJ4s0DWTv5hzieoY1t3GEvpTHlT0z0PqeA5HuhuyPtBXeO
         ssFzaWqQydsNv2erkIXMw18neZsvg1hmc5NXlBGD3cK5nXU8UlbWgbWVvWG1eFtUd9J1
         9chrOStlqltKvAyh1pVAZbCTr1c3uxL9tphL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pl4laxveqxbFoLVSBJBsq2q/ipMs/mfndz3RNUveMcY=;
        b=Sg34wc6sjrjY/sN99By+SErsFRQ+YCSzBmHr3sJ85dN67IxwNF9xxWxtNhSuSNpiQc
         /RChwtpRu5KikqJPmPYJ45QDv13ebuZupF5Gh376ekzKrFKXiWZvYKq1Y0YnCfvQuARg
         GSOdOdRVN7y3XxqTPEChkvAlmYvpYx52JUo8HaYoz8oDKDKg5pacAlXZ79aTgdXQmAf4
         bw9gRBYhvXdiENcSHT2dKeywmFBfpZHAPdaKUvquqPdrColpf68QATeNFVrwQIqFsBxR
         nKXObEJa9PF9m8sKQYIPSf4cMRGt+Rizp/m3Aj+wp3xnIFb3P8UGOwEXMObAyC8cmRvu
         7PSw==
X-Gm-Message-State: APjAAAWWq+7yymwS9U8uMf9wvKNeZusjnUaCGBXONSxPoylY7liMHJ0y
        4378+KZo8kqwiXEwrJuVLzvWpzXxP1ne/Q==
X-Google-Smtp-Source: APXvYqxeN9fJC9eFB0ZApWEYAs4X4dowUJjk9rtZRqH2u2ktSO6fZRr55vksowkjkXzv9lleYTSmsg==
X-Received: by 2002:a17:906:1911:: with SMTP id a17mr1244847eje.290.1565065411143;
        Mon, 05 Aug 2019 21:23:31 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id x21sm20426467edb.0.2019.08.05.21.23.31
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 21:23:31 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id u25so64606434wmc.4
        for <linux-iio@vger.kernel.org>; Mon, 05 Aug 2019 21:23:31 -0700 (PDT)
X-Received: by 2002:a1c:407:: with SMTP id 7mr1839604wme.113.1565064969579;
 Mon, 05 Aug 2019 21:16:09 -0700 (PDT)
MIME-Version: 1.0
References: <20181017075242.21790-1-henryhsu@chromium.org> <CAAFQd5AL2CnnWLk+i133RRa36HTa0baFkezRhpTXf9YP0DSF1Q@mail.gmail.com>
 <CAHNYxRwbSSp02Zr4a1z5gh0q6cHUUDnZCqRQU7QtP8LMe3Jp2A@mail.gmail.com>
 <1610184.U7oo9Z4Yep@avalon> <CAAFQd5A7k2VgmawF-x=AcKhJiG-shrJiCP4Tu9054J0eE91+9w@mail.gmail.com>
 <d79e0857-c6ae-9e57-52e2-e596864a68f8@metafoo.de> <CAAFQd5C_QucJiZMUgCpztC52Mi3p6HDThHNkcNOm9C+SZUDDYQ@mail.gmail.com>
 <20190313012451.GR891@pendragon.ideasonboard.com> <CAAFQd5DtSD3TrXz8jaFnmBgpRQ6Gnq+LKxyY+LNZrqiM1pxNVA@mail.gmail.com>
In-Reply-To: <CAAFQd5DtSD3TrXz8jaFnmBgpRQ6Gnq+LKxyY+LNZrqiM1pxNVA@mail.gmail.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Tue, 6 Aug 2019 13:15:57 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DreQkUsG9PnUxWMUDo6c+AxQMHm4ErZQFPjGqJz=wmCg@mail.gmail.com>
Message-ID: <CAAFQd5DreQkUsG9PnUxWMUDo6c+AxQMHm4ErZQFPjGqJz=wmCg@mail.gmail.com>
Subject: Re: [PATCH] media: uvcvideo: Add boottime clock support
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Alexandru Stan <amstan@chromium.org>,
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

On Wed, Mar 13, 2019 at 11:38 AM Tomasz Figa <tfiga@chromium.org> wrote:
>
> On Wed, Mar 13, 2019 at 10:25 AM Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
> >
> > Hi Tomasz,
> >
> > On Fri, Nov 23, 2018 at 11:46:43PM +0900, Tomasz Figa wrote:
> > > On Fri, Nov 2, 2018 at 12:03 AM Lars-Peter Clausen wrote:
> > > > On 11/01/2018 03:30 PM, Tomasz Figa wrote:
> > > >> On Thu, Nov 1, 2018 at 11:03 PM Laurent Pinchart wrote:
> > > >>> On Thursday, 18 October 2018 20:28:06 EET Alexandru M Stan wrote:
> > > >>>> On Wed, Oct 17, 2018 at 9:31 PM, Tomasz Figa wrote:
> > > >>>>> On Thu, Oct 18, 2018 at 5:50 AM Laurent Pinchart wrote:
> > > >>>>>> On Wednesday, 17 October 2018 11:28:52 EEST Tomasz Figa wrote:
> > > >>>>>>> On Wed, Oct 17, 2018 at 5:02 PM Laurent Pinchart wrote:
> > > >>>>>>>> On Wednesday, 17 October 2018 10:52:42 EEST Heng-Ruey Hsu wrote:
> > > >>>>>>>>> Android requires camera timestamps to be reported with
> > > >>>>>>>>> CLOCK_BOOTTIME to sync timestamp with other sensor sources.
> > > >>>>>>>>
> > > >>>>>>>> What's the rationale behind this, why can't CLOCK_MONOTONIC work ? If
> > > >>>>>>>> the monotonic clock has shortcomings that make its use impossible for
> > > >>>>>>>> proper synchronization, then we should consider switching to
> > > >>>>>>>> CLOCK_BOOTTIME globally in V4L2, not in selected drivers only.
> > > >>>>>>>
> > > >>>>>>> CLOCK_BOOTTIME includes the time spent in suspend, while
> > > >>>>>>> CLOCK_MONOTONIC doesn't. I can imagine the former being much more
> > > >>>>>>> useful for anything that cares about the actual, long term, time
> > > >>>>>>> tracking. Especially important since suspend is a very common event on
> > > >>>>>>> Android and doesn't stop the time flow there, i.e. applications might
> > > >>>>>>> wake up the device to perform various tasks at necessary times.
> > > >>>>>>
> > > >>>>>> Sure, but this patch mentions timestamp synchronization with other
> > > >>>>>> sensors, and from that point of view, I'd like to know what is wrong with
> > > >>>>>> the monotonic clock if all devices use it.
> > > >>>>>
> > > >>>>> AFAIK the sensors mentioned there are not camera sensors, but rather
> > > >>>>> things we normally put under IIO, e.g. accelerometers, gyroscopes and
> > > >>>>> so on. I'm not sure how IIO deals with timestamps, but Android seems
> > > >>>>> to operate in the CLOCK_BOTTIME domain. Let me add some IIO folks.
> > > >>>>>
> > > >>>>> Gwendal, Alexandru, do you think you could shed some light on how we
> > > >>>>> handle IIO sensors timestamps across the kernel, Chrome OS and
> > > >>>>> Android?
> > > >>>>
> > > >>>> On our devices of interest have a specialized "sensor" that comes via
> > > >>>> IIO (from the EC, cros-ec-ring driver) that can be used to more
> > > >>>> accurately timestamp each frame (since it's recorded with very low
> > > >>>> jitter by a realtime-ish OS). In some high level userspace thing
> > > >>>> (specifically the Android Camera HAL) we try to pick the best
> > > >>>> timestamp from the IIO, whatever's closest to what the V4L stuff gives
> > > >>>> us.
> > > >>>>
> > > >>>> I guess the Android convention is for sensor timestamps to be in
> > > >>>> CLOCK_BOOTTIME (maybe because it likes sleeping so much). There's
> > > >>>> probably no advantage to using one over the other, but the important
> > > >>>> thing is that they have to be the same, otherwise the closest match
> > > >>>> logic would fail.
> > > >>>
> > > >>> That's my understanding too, I don't think CLOCK_BOOTTIME really brings much
> > > >>> benefit in this case,
> > > >>
> > > >> I think it does have a significant benefit. CLOCK_MONOTONIC stops when
> > > >> the device is sleeping, but the sensors can still capture various
> > > >> actions. We would lose the time keeping of those actions if we use
> > > >> CLOCK_MONOTONIC.
> > > >>
> > > >>> but it's important than all timestamps use the same
> > > >>> clock. The question is thus which clock we should select. Mainline mostly uses
> > > >>> CLOCK_MONOTONIC, and Android CLOCK_BOOTTIME. Would you like to submit patches
> > > >>> to switch Android to CLOCK_MONOTONIC ? :-)
> > > >>
> > > >> Is it Android using CLOCK_BOOTTIME or the sensors (IIO?). I have
> > > >> almost zero familiarity with the IIO subsystem and was hoping someone
> > > >> from there could comment on what time domain is used for those
> > > >> sensors.
> > > >
> > > > IIO has the option to choose between BOOTTIME or MONOTONIC (and a few
> > > > others) for the timestamp on a per device basis.
> > > >
> > > > There was a bit of a discussion about this a while back. See
> > > > https://lkml.org/lkml/2018/7/10/432 and the following thread.
> > >
> > > Given that IIO supports BOOTTIME in upstream already and also the
> > > important advantage of using it over MONOTONIC for systems which keep
> > > capturing events during sleep, do you think we could move on with some
> > > way to support it in uvcvideo or preferably V4L2 in general?
> >
> > I'm not opposed to that, but I don't think we should approach that from
> > a UVC point of view. The issue should be addressed in V4L2, and then
> > driver-specific support could be added, if needed.
>
> Yes, fully agreed. The purpose of sending this patch was just to start
> the discussion on how to support this.
>
> Do you think something like a buffer flag called
> V4L2_BUF_FLAG_TIMESTAMP_BOOTTIME that could be set by the userspace at
> QBUF could work here? (That would change the timestamp flags
> semantics, because it used to be just the information from the driver,
> but shouldn't have any compatibility implications.) I suppose we would
> also need some capability flag for querying purposes, possibly added
> to the capability flags returned by REQBUFS/CREATE_BUFS?

Any thoughts?

Adding Hans and Kieran for more insight.

Best regards,
Tomasz
