Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE7882DCB
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2019 10:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbfHFIe4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Aug 2019 04:34:56 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:32828 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731835AbfHFIez (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Aug 2019 04:34:55 -0400
Received: from [192.168.0.20] (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 10F942F9;
        Tue,  6 Aug 2019 10:34:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1565080491;
        bh=1EJ90QSULyAIN2/TqvfMCU/CwyF3VdoamOhXihEJFEI=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=a0Cw175mzK645ftUDLnAhQp5BDqqLtEVwLHqCHbP4j3Yybku9Ki7t9tk8xVm95cKR
         allKTKsMO53lWfd171u5nxJKjGBcDb0Z8tJSMyh0ueodgggZPFYbEp7uf/jraypxZC
         HX30AwxJlcJce+267Y1I8sAq+9BZkr2Eu6zd7u/k=
Reply-To: kieran.bingham@ideasonboard.com
Subject: Re: [PATCH] media: uvcvideo: Add boottime clock support
To:     Tomasz Figa <tfiga@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
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
References: <20181017075242.21790-1-henryhsu@chromium.org>
 <CAAFQd5AL2CnnWLk+i133RRa36HTa0baFkezRhpTXf9YP0DSF1Q@mail.gmail.com>
 <CAHNYxRwbSSp02Zr4a1z5gh0q6cHUUDnZCqRQU7QtP8LMe3Jp2A@mail.gmail.com>
 <1610184.U7oo9Z4Yep@avalon>
 <CAAFQd5A7k2VgmawF-x=AcKhJiG-shrJiCP4Tu9054J0eE91+9w@mail.gmail.com>
 <d79e0857-c6ae-9e57-52e2-e596864a68f8@metafoo.de>
 <CAAFQd5C_QucJiZMUgCpztC52Mi3p6HDThHNkcNOm9C+SZUDDYQ@mail.gmail.com>
 <20190313012451.GR891@pendragon.ideasonboard.com>
 <CAAFQd5DtSD3TrXz8jaFnmBgpRQ6Gnq+LKxyY+LNZrqiM1pxNVA@mail.gmail.com>
 <CAAFQd5DreQkUsG9PnUxWMUDo6c+AxQMHm4ErZQFPjGqJz=wmCg@mail.gmail.com>
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
Openpgp: preference=signencrypt
Autocrypt: addr=kieran.bingham@ideasonboard.com; keydata=
 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
 sbsRB8KNNvVXBOVNwko86rQqF9drZuw=
Organization: Ideas on Board
Message-ID: <7c76f7ce-57ca-d7d5-fd81-70607f97b792@ideasonboard.com>
Date:   Tue, 6 Aug 2019 09:34:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAAFQd5DreQkUsG9PnUxWMUDo6c+AxQMHm4ErZQFPjGqJz=wmCg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Tomasz,

On 06/08/2019 05:15, Tomasz Figa wrote:
> On Wed, Mar 13, 2019 at 11:38 AM Tomasz Figa <tfiga@chromium.org> wrote:
>>
>> On Wed, Mar 13, 2019 at 10:25 AM Laurent Pinchart
>> <laurent.pinchart@ideasonboard.com> wrote:
>>>
>>> Hi Tomasz,
>>>
>>> On Fri, Nov 23, 2018 at 11:46:43PM +0900, Tomasz Figa wrote:
>>>> On Fri, Nov 2, 2018 at 12:03 AM Lars-Peter Clausen wrote:
>>>>> On 11/01/2018 03:30 PM, Tomasz Figa wrote:
>>>>>> On Thu, Nov 1, 2018 at 11:03 PM Laurent Pinchart wrote:
>>>>>>> On Thursday, 18 October 2018 20:28:06 EET Alexandru M Stan wrote:
>>>>>>>> On Wed, Oct 17, 2018 at 9:31 PM, Tomasz Figa wrote:
>>>>>>>>> On Thu, Oct 18, 2018 at 5:50 AM Laurent Pinchart wrote:
>>>>>>>>>> On Wednesday, 17 October 2018 11:28:52 EEST Tomasz Figa wrote:
>>>>>>>>>>> On Wed, Oct 17, 2018 at 5:02 PM Laurent Pinchart wrote:
>>>>>>>>>>>> On Wednesday, 17 October 2018 10:52:42 EEST Heng-Ruey Hsu wrote:
>>>>>>>>>>>>> Android requires camera timestamps to be reported with
>>>>>>>>>>>>> CLOCK_BOOTTIME to sync timestamp with other sensor sources.
>>>>>>>>>>>>
>>>>>>>>>>>> What's the rationale behind this, why can't CLOCK_MONOTONIC work ? If
>>>>>>>>>>>> the monotonic clock has shortcomings that make its use impossible for
>>>>>>>>>>>> proper synchronization, then we should consider switching to
>>>>>>>>>>>> CLOCK_BOOTTIME globally in V4L2, not in selected drivers only.
>>>>>>>>>>>
>>>>>>>>>>> CLOCK_BOOTTIME includes the time spent in suspend, while
>>>>>>>>>>> CLOCK_MONOTONIC doesn't. I can imagine the former being much more
>>>>>>>>>>> useful for anything that cares about the actual, long term, time
>>>>>>>>>>> tracking. Especially important since suspend is a very common event on
>>>>>>>>>>> Android and doesn't stop the time flow there, i.e. applications might
>>>>>>>>>>> wake up the device to perform various tasks at necessary times.
>>>>>>>>>>
>>>>>>>>>> Sure, but this patch mentions timestamp synchronization with other
>>>>>>>>>> sensors, and from that point of view, I'd like to know what is wrong with
>>>>>>>>>> the monotonic clock if all devices use it.
>>>>>>>>>
>>>>>>>>> AFAIK the sensors mentioned there are not camera sensors, but rather
>>>>>>>>> things we normally put under IIO, e.g. accelerometers, gyroscopes and
>>>>>>>>> so on. I'm not sure how IIO deals with timestamps, but Android seems
>>>>>>>>> to operate in the CLOCK_BOTTIME domain. Let me add some IIO folks.
>>>>>>>>>
>>>>>>>>> Gwendal, Alexandru, do you think you could shed some light on how we
>>>>>>>>> handle IIO sensors timestamps across the kernel, Chrome OS and
>>>>>>>>> Android?
>>>>>>>>
>>>>>>>> On our devices of interest have a specialized "sensor" that comes via
>>>>>>>> IIO (from the EC, cros-ec-ring driver) that can be used to more
>>>>>>>> accurately timestamp each frame (since it's recorded with very low
>>>>>>>> jitter by a realtime-ish OS). In some high level userspace thing
>>>>>>>> (specifically the Android Camera HAL) we try to pick the best
>>>>>>>> timestamp from the IIO, whatever's closest to what the V4L stuff gives
>>>>>>>> us.
>>>>>>>>
>>>>>>>> I guess the Android convention is for sensor timestamps to be in
>>>>>>>> CLOCK_BOOTTIME (maybe because it likes sleeping so much). There's
>>>>>>>> probably no advantage to using one over the other, but the important
>>>>>>>> thing is that they have to be the same, otherwise the closest match
>>>>>>>> logic would fail.
>>>>>>>
>>>>>>> That's my understanding too, I don't think CLOCK_BOOTTIME really brings much
>>>>>>> benefit in this case,
>>>>>>
>>>>>> I think it does have a significant benefit. CLOCK_MONOTONIC stops when
>>>>>> the device is sleeping, but the sensors can still capture various
>>>>>> actions. We would lose the time keeping of those actions if we use
>>>>>> CLOCK_MONOTONIC.

That's an important distinction. If there are operations that can run
while the main host is in 'suspend' and still maintain "relative"
timestamps in any form - then time must continue during suspend.


>>>>>>> but it's important than all timestamps use the same
>>>>>>> clock. The question is thus which clock we should select. Mainline mostly uses
>>>>>>> CLOCK_MONOTONIC, and Android CLOCK_BOOTTIME. Would you like to submit patches
>>>>>>> to switch Android to CLOCK_MONOTONIC ? :-)
>>>>>> Is it Android using CLOCK_BOOTTIME or the sensors (IIO?). I have
>>>>>> almost zero familiarity with the IIO subsystem and was hoping someone
>>>>>> from there could comment on what time domain is used for those
>>>>>> sensors.
>>>>>
>>>>> IIO has the option to choose between BOOTTIME or MONOTONIC (and a few
>>>>> others) for the timestamp on a per device basis.
>>>>>
>>>>> There was a bit of a discussion about this a while back. See
>>>>> https://lkml.org/lkml/2018/7/10/432 and the following thread.
>>>>
>>>> Given that IIO supports BOOTTIME in upstream already and also the
>>>> important advantage of using it over MONOTONIC for systems which keep
>>>> capturing events during sleep, do you think we could move on with some
>>>> way to support it in uvcvideo or preferably V4L2 in general?
>>>
>>> I'm not opposed to that, but I don't think we should approach that from
>>> a UVC point of view. The issue should be addressed in V4L2, and then
>>> driver-specific support could be added, if needed.

Agreed, this is a V4L2 topic - not a UVC specific topic.


>> Yes, fully agreed. The purpose of sending this patch was just to start
>> the discussion on how to support this.
>>
>> Do you think something like a buffer flag called
>> V4L2_BUF_FLAG_TIMESTAMP_BOOTTIME that could be set by the userspace at
>> QBUF could work here? (That would change the timestamp flags
>> semantics, because it used to be just the information from the driver,
>> but shouldn't have any compatibility implications.) I suppose we would
>> also need some capability flag for querying purposes, possibly added
>> to the capability flags returned by REQBUFS/CREATE_BUFS?

What kind of 'compatibility' do we actually need to maintain here? IMO -
CLOCK_BOOTTIME makes much more sense globally for video, because it's
more representative of the temporal difference between frames captured
if a system goes into suspend.

If frames are captured:

A B         C D
   <suspend>

Then I believe it would be correct for the timestamp delta between B-C
to be large <representative of the suspend duration/real time>


> Any thoughts?

Aha, there might be some gotchas around non-live sources operating
across suspend-resume boundaries .. so perhaps there are certainly
use-cases where both _MONOTONIC and _BOOTTIME have their relevance ...


> Adding Hans and Kieran for more insight.

I think if we're talking about core-V4L2, Hans' opinion takes more
weight than my mumblings :-) - but overall - supporting _BOOTTIME in
some form sounds beneficial to me.


> Best regards,
> Tomasz
> 

-- 
Regards
--
Kieran
