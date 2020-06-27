Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89C9220C3B1
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jun 2020 21:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbgF0TVD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Jun 2020 15:21:03 -0400
Received: from vern.gendns.com ([98.142.107.122]:35408 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbgF0TVD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 27 Jun 2020 15:21:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=oFxURIxj9myDfJcM8l9lS1bZv4B4c/d/WWg4QVvvxCg=; b=K5yW/T7aiN3k8SM7hUdIzsp2Ex
        vpB+NQsAapYuDACPwbG06es4XZ/yGb3quQ96XDPO+Z08ch2uFEaLN9DWfRDrXunOpHRs7lN18k7fp
        Xk7E4DJy+XK0GrlhioDBZno3Vvcw1gKP6poO5PEqDuu/0OCUGgtTRlUxCNEoahyfT2bTQjGUuB5aP
        Ov/uHspQt3ij42IEvPf8PeVCB6OIAqjEih+igZTiC2mjhTMs3cbrqeWPZnwAlhQp4Rrngah+huLiL
        kfGGjQ3mfM8t7XUfmq8d8Ps4ztnEQhZicAwply/QXg9VRPq5Eo878dYd125RGO+m6ANLCbDYt5CAZ
        Uunzhtsg==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:48498 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <david@lechnology.com>)
        id 1jpGNj-0005ES-0L; Sat, 27 Jun 2020 15:20:55 -0400
Subject: Re: [PATCH v3 3/4] counter: Add character device interface
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     jic23@kernel.org, kamel.bouhara@bootlin.com, gwendal@chromium.org,
        alexandre.belloni@bootlin.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
References: <cover.1592341702.git.vilhelm.gray@gmail.com>
 <afe40ef2e24ecaca44fc229f7983cf4cde3374a8.1592341702.git.vilhelm.gray@gmail.com>
 <8fae0659-56df-c0b5-7c0d-220feefed2b4@lechnology.com>
 <20200621195347.GA59797@shinobu>
 <47ad15e7-05ce-d463-b6af-406365b3c3b4@lechnology.com>
 <20200627181748.GA8254@shinobu>
From:   David Lechner <david@lechnology.com>
Message-ID: <cc1c347a-3363-c563-de81-06dbb464a29d@lechnology.com>
Date:   Sat, 27 Jun 2020 14:20:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200627181748.GA8254@shinobu>
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

On 6/27/20 1:17 PM, William Breathitt Gray wrote:
> On Mon, Jun 22, 2020 at 09:08:48AM -0500, David Lechner wrote:
>> On 6/21/20 2:53 PM, William Breathitt Gray wrote:
>>> For example, in the dual-axes positioning table scenario, a user
>>> application would likely want to know the exact X and Y position at the
>>> time of a given event -- that means an event should provide two Count
>>> values (and possibly associated device flags) when it occurs. I'm not
>>> sure yet how the struct counter_event should be defined in order to
>>> support this; we will need to indicate the format of data as well as
>>> provide the data itself. Perhaps, we can handle this by providing an
>>> unique id field so that only a single datum (e.g. a single count value)
>>> is provided via the value field, but subsequent struct counter_event
>>> items share the same id so that the user knows that a particular datum
>>> is part of a larger group of data for a specific event.
>>
>> The timestamp could act as the "id" to correlate multiple values of a
>> single event.
> 
> Okay, I see how that can work. So the /dev/counterX character nodes
> would return a stream of data structures that look something like this:
> 
> struct counter_event {
> 	/**
> 	 * Best approximation of when event occurred in nanoseconds.
> 	 * Same timestamp value indicates data is part of same event.
> 	 */
> 	struct timeval time;
> 	/**
> 	 * Type of event that triggered. This would correlate with the
> 	 * IRQ set up for the device.
> 	 */
> 	__u16 type;
> 	/**
> 	 * Type of data represented by the value member. This enables
> 	 * the user to extract the right datatype from the value field.
> 	 */
> 	__u16 code;
> 	/** The value recorded when the event fired. */
> 	__u64 value;
> };
> 
> In fact, this data structure looks a lot like struct input_event; would
> it make sense to use that for this? I suppose we can't because we need
> to support 64-bit value for our use cases.

Yes, since counter is its own subsystem, it makes sense to have its own
data types.

> 
> Userspace also requires a way to enable the events and configure them to
> report the data it wants. So perhaps the following sysfs attributes
> would accomplish such:
> 
> * /sys/bus/devices/counterX/eventY_enable:
>    Users can enable/disable event Y.
> * /sys/bus/devices/counterX/eventY_config:
>    Data to get when event Y is triggered (e.g. Counts, extensions, etc.).

This is one of the questions I had too that I don't have a good answer to.

If we want to allow the use case of multiple "consumers" for a single
chardev where each consumer wants different events (e.g program X opens
/dev/counter0 and wants only events A and B while program Y opens the
same /dev/counter0 and wants only events A and C) then it would make
sense to use an ioctl for configuration of events so that each open
file descriptor could be configured differently.

But if we only want to allow one user of a counter, then configuring
via sysfs as you have suggested is probably fine.

I think I might make sense to us an ioctl in any case though if we are
going to use the same code values to configure the event.

> 
> Here's another concern for latency-sensitive applications: should we
> handle writing data to the devices? While we have real-life examples of
> latency-sensitive read operations, I'm not sure if a user will ever need
> to write to a counter device within some realtime critical deadline --
> I think write operations are primarily done for the purpose of
> configuring the device for operation rather than during it. So perhaps
> we don't need to worry about this use case because users can write data
> via the existing sysfs interface.

Agreed.
