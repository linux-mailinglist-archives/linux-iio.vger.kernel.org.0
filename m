Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 847C524137D
	for <lists+linux-iio@lfdr.de>; Tue, 11 Aug 2020 01:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgHJXCZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 Aug 2020 19:02:25 -0400
Received: from vern.gendns.com ([98.142.107.122]:34202 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726898AbgHJXCX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 10 Aug 2020 19:02:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=COPUQmhMmE40ax9+ruamAVXzEdZykIbuPN7Gjhr2bCY=; b=kAIN0l4m57JuWS9/SFazOs1njE
        aMMLTE0XHi3CyiA/w8lIoGuQwYGaYlCouVS+3bYLTolOVAHZoTqdVM6ix34cS40fbHfNp9xqFfEPp
        /t9vyq8uV92lI2gn/AoXs27nzPprvOKYZ61gpZK5M4vQOP7bf2MqUvIDH+ZWfCGVs7RuDiqllAyew
        LFiTZ9tEnUSna02UUHxjm1XWzV57RQWNf/5eAeRFiKUEArLVMxueGdhXB/MwyEqn4aDR1TELQ9R78
        bISUY1yGTXo7iTLKNHkHjrms0SVx56c9UGwepY4T3IKNpUE+kcVDAvKrmGrfaPQpvOjL3b614F8X2
        AXrybHww==;
Received: from [2600:1700:4830:165f::19e] (port=45710)
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <david@lechnology.com>)
        id 1k5Go7-0006WG-Cg; Mon, 10 Aug 2020 19:02:19 -0400
Subject: Re: [PATCH v4 3/5] counter: Add character device interface
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     jic23@kernel.org, kamel.bouhara@bootlin.com, gwendal@chromium.org,
        alexandre.belloni@bootlin.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
References: <cover.1595358237.git.vilhelm.gray@gmail.com>
 <08b3ac7349a59ba7fa5cd438bbe78360842ccd11.1595358237.git.vilhelm.gray@gmail.com>
 <415ee9ad-255e-cee7-22a6-ffa977999691@lechnology.com>
 <20200809145107.GA6542@shinobu>
From:   David Lechner <david@lechnology.com>
Message-ID: <ddf07574-56f3-ad5f-b417-6ed9a3ba78cb@lechnology.com>
Date:   Mon, 10 Aug 2020 18:02:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200809145107.GA6542@shinobu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 8/9/20 9:51 AM, William Breathitt Gray wrote:
> On Tue, Jul 28, 2020 at 07:20:03PM -0500, David Lechner wrote:
>> On 7/21/20 2:35 PM, William Breathitt Gray wrote:
>>> This patch introduces a character device interface for the Counter
>>> subsystem. Device data is exposed through standard character device read
>>> operations. Device data is gathered when a Counter event is pushed by
>>> the respective Counter device driver. Configuration is handled via ioctl
>>> operations on the respective Counter character device node.
>>
>> This sounds similar to triggers and buffers in the iio subsystem. And
>> I can see how it might be useful in some cases. But I think it would not
>> give the desired results when performance is important.
>>
>> Thinking through a few cases here...
>>
>> Suppose there was a new counter device that used the I2C bus. This would
>> either have to be periodically polled for events or it might have a
>> separate GPIO line to notify the MCU. In any case, with the proposed
>> implementation, there would be a separate I2C transaction for each data
>> point for that event. So none of the data for that event would actually
>> be from the same point in time. And with I2C, this time difference could
>> be significant.
>>
>> With the TI eQEP I have been working with, there are special latched
>> registers for some events. To make use of these with events, we would have
>> add extensions for each one we want to use (and expose it in sysfs). But
>> really, the fact that we are using a latched register should be an
>> implementation detail in the driver and not something userspace should have
>> to know about.
>>
>> So, I'm wondering if it would make sense to keep things simpler and have
>> events like the input subsystem where the event value is directly tied
>> to the event. It would probably be rare for an event to have more than
>> one or two values. And error events probably would not have a value at
>> all.
>>
>> For example, with the TI eQEP, there is a unit timer time out event.
>> This latches the position count, the timer count and the timer period.
>> To translate this to an event data structure, the latched time would
>> be the event timestamp and the position count would be the event value.
>> The timer period should already be known since we would have configured
>> the timer ourselves. There is also a count event that works similarly.
>> In this case, the latched time would be the event timestamp and the
>> latched timer period would be the event value. We would know the count
>> already since we get an event for each count (and a separate direction
>> change event if the direction changes).
> 
> There are use-cases where it would be useful to have the extension reads
> occur as close to the event trigger as possible (e.g. multiple-axes
> positioning with boundary sensor flags) so I don't think this
> functionality should be completely abadoned, but I think your argument
> for standard event types makes sense.
> 
> We could treat those extensions reads as an optional feature that can be
> enabled and configured by ioctls. However, the use-case you are
> concerned with, we can redesign Counter events to return specific data
> based on the specific event type.
> 
> For example, we could have a COUNTER_EVENT_INDEX which occurs when an
> Index signal edge is detected, and the return data is the Count value
> for that channel; we can also have a COUNTER_EVENT_TIMEOUT which occurs
> when a unit timer times out, and returns the data you mentioned you are
> interested in seeing.
> 
> These Counter event types would be standard, so user applications
> wouldn't need to know driver/device implementation details, but instead
> just follow the API to get the data they expect for that particular
> event type. Would this kind of design work for your needs?


Yes. After trying (and failing) to implement my suggestions here, I
came to the conclusion that it was not sufficient to only have one
value per event. And it doesn't seem as obvious as I initially thought
which should be the "standard" value for an event in some cases.

>>>
>>> When `counter_push_event(counter, 1)` is called for example, it will go
>>> down the list for Event 1 and execute the read callbacks for Signal 0,
>>> Signal 0 Extension 0, and Extension 4 -- the data returned for each is
>>> pushed to a kfifo as a `struct counter_event`, which userspace can
>>> retrieve via a standard read operation on the respective character
>>> device node.
>>>
>>> Userspace
>>> ---------
>>> Userspace applications can configure Counter events via ioctl operations
>>> on the Counter character device node. There following ioctl codes are
>>> supported and provided by the `linux/counter.h` userspace header file:
>>>
>>> * COUNTER_CLEAR_WATCHES_IOCTL:
>>>     Clear all Counter watches from all events
>>>
>>> * COUNTER_SET_WATCH_IOCTL:
>>>     Set a Counter watch on the specified event
>>>
>>> To configure events to gather Counter data, users first populate a
>>> `struct counter_watch` with the relevant event id and the information
>>> for the desired Counter component from which to read, and then pass it
>>> via the `COUNTER_SET_WATCH_IOCTL` ioctl command.
>>>
>>> Userspace applications can then execute a `read` operation (optionally
>>> calling `poll` first) on the Counter character device node to retrieve
>>> `struct counter_event` elements with the desired data.
>>>
>>> For example, the following userspace code opens `/dev/counter0`,
>>> configures Event 0 to gather Count 0 and Count 1, and prints out the
>>> data as it becomes available on the character device node:
>>>
>>>       #include <fcntl.h>
>>>       #include <linux/counter.h>
>>>       #include <poll.h>
>>>       #include <stdio.h>
>>>       #include <sys/ioctl.h>
>>>       #include <unistd.h>
>>>
>>>       struct counter_watch watches[2] = {
>>>               {
>>>                       .event = 0,
>>>                       .component.owner_type = COUNTER_OWNER_TYPE_COUNT,
>>>                       .component.owner_id = 0,
>>>                       .component.type = COUNTER_COMPONENT_TYPE_COUNT,
>>>               },
>>>               {
>>>                       .event = 0,
>>>                       .component.owner_type = COUNTER_OWNER_TYPE_COUNT,
>>>                       .component.owner_id = 1,
>>>                       .component.type = COUNTER_COMPONENT_TYPE_COUNT,
>>>               },
>>>       };
>>>
>>>       int main(void)
>>>       {
>>>               struct pollfd pfd = { .events = POLLIN };
>>>               struct counter_event event_data[2];
>>>
>>>               pfd.fd = open("/dev/counter0", O_RDWR);
>>>
>>>               ioctl(pfd.fd, COUNTER_SET_WATCH_IOCTL, watches);
>>>               ioctl(pfd.fd, COUNTER_SET_WATCH_IOCTL, watches + 1);
>>
>> What enables events? If an event is enabled for each of these ioctls,
>> then we have a race condition where events events from the first watch
>> can start to be queued before the second watch is added. So we would
>> have to flush the chardev first before polling, otherwise the assumption
>> that event_data[0] is owner_id=0 and event_data[1] is owner_id=1 is
>> not true.
> 
> That's a good point, we could theoretically have a situation where an
> event is pushed before the configuration of watches is complete. I'm not
> sure if the solution is to implement an enable/disable ioctl to control
> when events are recorded, or a flush ioctl to remove the invalid events
> in the queue.
> 
>> This is also racy if we want to clear watches and set up new watches
>> at runtime. There would be a period of time where there were no watches
>> and we could miss events.
> 
> I'm not sure how typical this use-case is -- would an operator ever want
> to change watch configuration on-the-fly? I assumed watches configured
> once at the start of a production run, and then stay essentially static
> until the production stops.

The use case I am thinking of is measuring motor speed in robotics. At
low speed, we need an event for each count increase. But at high speed,
this would be too many events and we instead need a periodic event based
on the timer timeout. A maneuver may require operating at both high and
low speeds without stopping and so we would want to be able to switch
back and forth without interruption.


> 
> Well regardless, if we want to support this kind of functionality we
> will need to implement a kind of atomic replacement for all watches with
> new ones. This shouldn't be too difficult to achieve: buffer the desired
> watches instead, and then activate them together atomically via a new
> ioctl command.
> 
>> With my suggested changes of having fixed values per event and generic
>> events, we could just have a single ioctl to enable and disable events.
>> This would probably need to take an array of event descriptors as an
>> argument where event descriptors contain the component type/id and the
>> event to enable.
> 
> I agree with having specified data for particular event types, but I
> think we should still be able to support general extension watches as an
> optional functionality. In fact, I don't think we'll need to implement
> enable/disable event ioctl commands.
> 
> The current implementation only records events if the user is watching
> for them (i.e. a watch has been set); if no one is watching for these
> events, they are just silently dropped by the counter_event_push
> function. If we implement an ioctl to atomically set the watches, there
> is no need to explicitly enable/disable events: events will always
> report the specified data for those their respective type -- the watch
> data is extra optional data and will start flowing automatically when
> atomically activated.
> 

This sounds reasonable to me.
