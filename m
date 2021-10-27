Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E05AD43CF45
	for <lists+linux-iio@lfdr.de>; Wed, 27 Oct 2021 19:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbhJ0RCx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 27 Oct 2021 13:02:53 -0400
Received: from vern.gendns.com ([98.142.107.122]:55306 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229508AbhJ0RCw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 27 Oct 2021 13:02:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=L95rUlDD4cOcJhh6QKg864IhS017khXESLCjEv59VkA=; b=te5um+8iPVTtdq9AiXzt9VFU6T
        opnaktzIxQjS/I2m+uUfj2wVxqgKXbOrZZ8xpFLd2yM0Wfy2dkwE8J646dpfqgVkqtStGQpI/zdj2
        ZT870VBPYJwmXKpiTGAZKZ6YDM4CQJcz9YjetORQKbbG3XtMMoV6K0kLRtXLNha7IukVah/zo/vbk
        1oy8EsoKnTR9trx9kbadeaJd54wDLjTxHfB2wUh7WD2/BEI4QcgfGJWXliwNvVGgCcYB3RFqzLftE
        u4r6zyUKaeIi+Zh3apbXpiyc7DnK6MVhZMDDbt0JBz6tWOaSpmAsMOP5PP0A3yo3o6AbISfE33Da6
        CAux/H6A==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:44842 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <david@lechnology.com>)
        id 1mfmHh-0007hN-98; Wed, 27 Oct 2021 13:00:24 -0400
Subject: Re: [PATCH 6/8] docs: counter: add latch_mode and latched_count sysfs
 attributes
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-iio@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20211017013343.3385923-1-david@lechnology.com>
 <20211017013343.3385923-7-david@lechnology.com> <YXkFzK0TA5zswSrQ@shinobu>
From:   David Lechner <david@lechnology.com>
Message-ID: <e660e9c5-a116-5450-8afb-1053a1504ab6@lechnology.com>
Date:   Wed, 27 Oct 2021 12:00:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YXkFzK0TA5zswSrQ@shinobu>
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
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 10/27/21 2:54 AM, William Breathitt Gray wrote:
> On Sat, Oct 16, 2021 at 08:33:41PM -0500, David Lechner wrote:
>> This documents new counterX/latch_mode* and
>> counterX/countY/latched_count* attributes.
>>
>> The counterX/signalY/*_available are moved to the
>> counterX/countY/*_available section similar to the way we already have
>> The counterX/*_component_id and The counterX/signalY/*_component_id
>> grouped together so that we don't have to start a 3rd redundant section
>> for device-level *_available section.
>>



>> @@ -147,6 +150,14 @@ Description:
>>   			updates	the respective count. Quadrature encoding
>>   			determines the direction.
>>   
>> +What:		/sys/bus/counter/devices/counterX/countY/latched_count
>> +KernelVersion:	5.16
>> +Contact:	linux-iio@vger.kernel.org
>> +Description:
>> +		Latched count data of Count Y represented as a string. The value
>> +		is latched in based on the trigger selected by the
>> +		counterX/latch_mode attribute.
>> +
> 
> Latches are pretty common components of devices, and not simply limited
> to latching the count data. I wonder if it would be better to omit the
> "_count" suffix in order to make this more general. Well, the name
> "latched_count" is suitable for counters so you probably don't need to
> change it, but it's something to think about in the future.
> 

I chose the name counterX/countY/latched_count since we already have
counterX/countY/count to read the same (not latched) count. This
indicates that they are the same quantity, just from a different
point in time.

Also for consideration, this particular hardware actually has 3
independent latched counts. One is triggered by the selected
latched_mode. One is triggered by the index signal and one is
triggered by the strobe signal.

The latter two are not implemented in this series, but if there were a
use for those, I would probably submit attributes index_latched_count
and strobe_latched_count. These are unaffected by the latch_mode.

Similarly, the unit timer has a timer latch and a period latch. If we
change the unit timer to be a Count as suggested, then the latched
timer would basically be the same as latched_count. Both of these
are triggered by the selected latch_mode.

So, I supposed if we wanted to keep things really generic, we would
want to introduce some sort of "latch trigger" component (synapse?).
There could theoretically be multiple configurable triggers, so
the proposed latch_mode might need to be made indexed or part of
an index component/extension.



>>   What:		/sys/bus/counter/devices/counterX/countY/name
>>   KernelVersion:	5.2
>>   Contact:	linux-iio@vger.kernel.org
>> @@ -209,6 +220,7 @@ What:		/sys/bus/counter/devices/counterX/countY/count_mode_component_id
>>   What:		/sys/bus/counter/devices/counterX/countY/direction_component_id
>>   What:		/sys/bus/counter/devices/counterX/countY/enable_component_id
>>   What:		/sys/bus/counter/devices/counterX/countY/error_noise_component_id
>> +What:		/sys/bus/counter/devices/counterX/countY/latched_count_component_id
>>   What:		/sys/bus/counter/devices/counterX/countY/prescaler_component_id
>>   What:		/sys/bus/counter/devices/counterX/countY/preset_component_id
>>   What:		/sys/bus/counter/devices/counterX/countY/preset_enable_component_id
>> @@ -218,6 +230,7 @@ What:		/sys/bus/counter/devices/counterX/signalY/cable_fault_enable_component_id
>>   What:		/sys/bus/counter/devices/counterX/signalY/filter_clock_prescaler_component_id
>>   What:		/sys/bus/counter/devices/counterX/signalY/index_polarity_component_id
>>   What:		/sys/bus/counter/devices/counterX/signalY/synchronous_mode_component_id
>> +What:		/sys/bus/counter/devices/latch_mode_component_id
>>   What:		/sys/bus/counter/devices/unit_timer_enable_component_id
>>   What:		/sys/bus/counter/devices/unit_timer_period_component_id
>>   What:		/sys/bus/counter/devices/unit_timer_time_component_id

Just noticing here, I missed the counterX in the device-level components.

>> @@ -244,6 +257,22 @@ Description:
>>   		counter_event data structures. The number of elements will be
>>   		rounded-up to a power of 2.
>>   
>> +What:		/sys/bus/counter/devices/counterX/latch_mode
>> +KernelVersion:	5.16
>> +Contact:	linux-iio@vger.kernel.org
>> +Description:
>> +		Read/write attribute that selects the trigger for latching
>> +		values. Valid values are device-specific (given by
>> +		latch_mode_available attribute) and may include:
>> +
>> +		"Read count":
>> +			Reading the countY/count attribute latches values.
>> +
>> +		"Unit timeout":
>> +			Unit timer timeout event latches values.
>> +
>> +		The latched values can be read from latched_* attributes.
>> +
> 
> To make these modes more generic for use in future drivers, I suggest
> removing the "Unit " prefix and just leaving that mode as "Timeout". In
> a similar vein, rewording "Read count" to "Count read" would make this
> mode easier to understand in case a future driver introduces a mode
> called "Signal read" or similar.
> 

Continuing my thoughts from above and taking this suggestion into
consideration...

Maybe we need a /sys/bus/counter/devices/counterX/latchY component.
This would represent the trigger for a latch. For the TI eQEP in this
series, there are potentially 3 of these (only one implemented for
now).

latchY would have a required `trigger` attribute that would describe
what triggers the latch. If the trigger is selectable, there would be
a `triggers_available` attribute that would list the possible triggers,
otherwise the `trigger` attribute would just be read-only. Available
triggers could could be "X read" where X is a fully qualified component
name, e.g. "Count0 count read" or a fully qualified event, e.g.
"Count1 overflow event" (this is unit timer timeout in generic counter
terms). But, there may be potential triggers that don't fit either
of these patterns.

Although not currently needed, the triggers for the index and strobe
latches on the eQEP get more interesting. The `triggers_available` for
the index latch are "index rising edge", "index falling edge" and
"software" (this would require a `software_trigger` attribute that
would be written to trigger the latch). The `triggers_available` for
the strobe latch are "strobe rising edge" and "strobe rising edge if
direction is clockwise and strobe falling edge if direction is
counterclockwise".

Circling back to the beginning, to read latched registers, there
would be attributes like counterX/countY/latchY_count instead of
the proposed counterX/countY/latched_count. So for the eQEP there
would be counter0/count0/latch0_count (triggered by reading
counter0/count0/count or counter0/count1 overflow event),
counter0/count0/latch1_count (triggered by index signal),
counter0/count0/latch2_count (triggered by strobe signal),
counter0/count1/latch0_count (unit timer latched timer trigger
by same trigger as counter0/count0/latch0_count) and
counter0/count0/latch0_ceiling (unit timer latched period
triggered by same trigger as counter0/count0/latch0_count).
