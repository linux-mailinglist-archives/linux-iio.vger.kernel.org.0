Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 333A22316B0
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jul 2020 02:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730139AbgG2AUO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jul 2020 20:20:14 -0400
Received: from vern.gendns.com ([98.142.107.122]:60212 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730011AbgG2AUN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 28 Jul 2020 20:20:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lGZzSi+swXyoU/xq8RPtcZDENd+lrNhrISQyVJ5Lq0U=; b=H8MVtmk/wbeIhPOvcXKWmWaVeM
        wQxT4jPQR3Hl12ZKnr+DYnRpNJ6sJ0z1AmsrLPaxhZk/wvNegV2xfkeJSeCcMEmZ8uT/iM28zZT3u
        Yb576+p1fxlRnQEm0pWNPTopVMULe12nKpHFJzxXLlaLhFQDAjUt9zuZraef4C9H665yEWvwgMsoa
        cKznHz6Ni7Es61b9PEW9HD0Gbko4XdEGGmvNLjvWxmM3utQbEPGvmHohrgv1NeXy5UEA0ew1N+CYX
        S7cutsTod0cIrVE7fVAmbGncLHtGxy56JcSsuG/p1UXxkv4wocxpUW8QKri0y/Lyn5Xg2U3QXR8bx
        fLfE0apg==;
Received: from [2600:1700:4830:165f::19e] (port=56576)
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <david@lechnology.com>)
        id 1k0ZpG-0005DN-7q; Tue, 28 Jul 2020 20:20:07 -0400
Subject: Re: [PATCH v4 3/5] counter: Add character device interface
To:     William Breathitt Gray <vilhelm.gray@gmail.com>, jic23@kernel.org
Cc:     kamel.bouhara@bootlin.com, gwendal@chromium.org,
        alexandre.belloni@bootlin.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
References: <cover.1595358237.git.vilhelm.gray@gmail.com>
 <08b3ac7349a59ba7fa5cd438bbe78360842ccd11.1595358237.git.vilhelm.gray@gmail.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <415ee9ad-255e-cee7-22a6-ffa977999691@lechnology.com>
Date:   Tue, 28 Jul 2020 19:20:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <08b3ac7349a59ba7fa5cd438bbe78360842ccd11.1595358237.git.vilhelm.gray@gmail.com>
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

On 7/21/20 2:35 PM, William Breathitt Gray wrote:
> This patch introduces a character device interface for the Counter
> subsystem. Device data is exposed through standard character device read
> operations. Device data is gathered when a Counter event is pushed by
> the respective Counter device driver. Configuration is handled via ioctl
> operations on the respective Counter character device node.

This sounds similar to triggers and buffers in the iio subsystem. And
I can see how it might be useful in some cases. But I think it would not
give the desired results when performance is important.

Thinking through a few cases here...

Suppose there was a new counter device that used the I2C bus. This would
either have to be periodically polled for events or it might have a
separate GPIO line to notify the MCU. In any case, with the proposed
implementation, there would be a separate I2C transaction for each data
point for that event. So none of the data for that event would actually
be from the same point in time. And with I2C, this time difference could
be significant.

With the TI eQEP I have been working with, there are special latched
registers for some events. To make use of these with events, we would have
add extensions for each one we want to use (and expose it in sysfs). But
really, the fact that we are using a latched register should be an
implementation detail in the driver and not something userspace should have
to know about.

So, I'm wondering if it would make sense to keep things simpler and have
events like the input subsystem where the event value is directly tied
to the event. It would probably be rare for an event to have more than
one or two values. And error events probably would not have a value at
all.

For example, with the TI eQEP, there is a unit timer time out event.
This latches the position count, the timer count and the timer period.
To translate this to an event data structure, the latched time would
be the event timestamp and the position count would be the event value.
The timer period should already be known since we would have configured
the timer ourselves. There is also a count event that works similarly.
In this case, the latched time would be the event timestamp and the
latched timer period would be the event value. We would know the count
already since we get an event for each count (and a separate direction
change event if the direction changes).


> 
> A high-level view of how a count value is passed down from a counter
> driver is exemplified by the following:
> 
>                   ----------------------
>                  / Counter device       \
>                  +----------------------+
>                  | Count register: 0x28 |
>                  +----------------------+
>                          |
>                   -----------------
>                  / raw count data /
>                  -----------------
>                          |
>                          V
>                  +----------------------------+
>                  | Counter device driver      |----------+
>                  +----------------------------+          |
>                  | Processes data from device |   -------------------
>                  |----------------------------|  / driver callbacks /
>                  | Type: u64                  |  -------------------
>                  | Value: 42                  |          |
>                  +----------------------------+          |
>                          |                               |
>                   ----------                             |
>                  / u64     /                             |
>                  ----------                              |
>                          |                               |
>                          |                               V
>                          |               +----------------------+
>                          |               | Counter core         |
>                          |               +----------------------+
>                          |               | Routes device driver |
>                          |               | callbacks to the     |
>                          |               | userspace interfaces |
>                          |               +----------------------+
>                          |                       |
>                          |                -------------------
>                          |               / driver callbacks /
>                          |               -------------------
>                          |                       |
>                  +-------+---------------+       |
>                  |                       |       |
>                  |               +-------|-------+
>                  |               |       |
>                  V               |       V
>          +--------------------+  |  +---------------------+
>          | Counter sysfs      |<-+->| Counter chrdev      |
>          +--------------------+     +---------------------+
>          | Translates to the  |     | Translates to the   |
>          | standard Counter   |     | standard Counter    |
>          | sysfs output       |     | character device    |
>          |--------------------|     |---------------------+
>          | Type: const char * |     | Type: u64           |
>          | Value: "42"        |     | Value: 42           |
>          +--------------------+     +---------------------+
>                  |                               |
>           ---------------                 -----------------------
>          / const char * /                / struct counter_event /
>          ---------------                 -----------------------
>                  |                               |
>                  |                               V
>                  |                       +-----------+
>                  |                       | read      |
>                  |                       +-----------+
>                  |                       \ Count: 42 /
>                  |                        -----------
>                  |
>                  V
>          +--------------------------------------------------+
>          | `/sys/bus/counter/devices/counterX/countY/count` |
>          +--------------------------------------------------+
>          \ Count: "42"                                      /
>           --------------------------------------------------
> 
> Counter character device nodes are created under the `/dev` directory as
> `counterX`, where `X` is the respective counter device id. Defines for
> the standard Counter data types are exposed via the userspace
> `include/uapi/linux/counter.h` file.
> 
> Counter events
> --------------
> Counter device drivers can support Counter events by utilizing the
> `counter_push_event` function:
> 
>      int counter_push_event(struct counter_device *const counter,
>                             const u8 event);
> 
> The event id is specified by the `event` parameter. When this function
> is called, the Counter data associated with the respective event is
> gathered, and a `struct counter_event` is generated for each datum and
> pushed to userspace.
> 
> Counter events can be configured by users to report various Counter
> data of interest. This can be conceptualized as a list of Counter
> component read calls to perform. For example:
> 
>      +------------------------+------------------------+
>      | Event 0                | Event 1                |
>      +------------------------+------------------------+
>      | * Count 0              | * Signal 0             |
>      | * Count 1              | * Signal 0 Extension 0 |
>      | * Signal 3             | * Extension 4          |
>      | * Count 4 Extension 2  |                        |
>      | * Signal 5 Extension 0 |                        |
>      +------------------------+------------------------+

In the current implementation, I can't tell if the event number corresponds
to the individual counter or some device-specific interrupt bits. In either
case, it seems like it would be better to have a generic enum of possible
counter events like overflow, underflow, direction change, etc.

> 
> When `counter_push_event(counter, 1)` is called for example, it will go
> down the list for Event 1 and execute the read callbacks for Signal 0,
> Signal 0 Extension 0, and Extension 4 -- the data returned for each is
> pushed to a kfifo as a `struct counter_event`, which userspace can
> retrieve via a standard read operation on the respective character
> device node.
> 
> Userspace
> ---------
> Userspace applications can configure Counter events via ioctl operations
> on the Counter character device node. There following ioctl codes are
> supported and provided by the `linux/counter.h` userspace header file:
> 
> * COUNTER_CLEAR_WATCHES_IOCTL:
>    Clear all Counter watches from all events
> 
> * COUNTER_SET_WATCH_IOCTL:
>    Set a Counter watch on the specified event
> 
> To configure events to gather Counter data, users first populate a
> `struct counter_watch` with the relevant event id and the information
> for the desired Counter component from which to read, and then pass it
> via the `COUNTER_SET_WATCH_IOCTL` ioctl command.
> 
> Userspace applications can then execute a `read` operation (optionally
> calling `poll` first) on the Counter character device node to retrieve
> `struct counter_event` elements with the desired data.
> 
> For example, the following userspace code opens `/dev/counter0`,
> configures Event 0 to gather Count 0 and Count 1, and prints out the
> data as it becomes available on the character device node:
> 
>      #include <fcntl.h>
>      #include <linux/counter.h>
>      #include <poll.h>
>      #include <stdio.h>
>      #include <sys/ioctl.h>
>      #include <unistd.h>
> 
>      struct counter_watch watches[2] = {
>              {
>                      .event = 0,
>                      .component.owner_type = COUNTER_OWNER_TYPE_COUNT,
>                      .component.owner_id = 0,
>                      .component.type = COUNTER_COMPONENT_TYPE_COUNT,
>              },
>              {
>                      .event = 0,
>                      .component.owner_type = COUNTER_OWNER_TYPE_COUNT,
>                      .component.owner_id = 1,
>                      .component.type = COUNTER_COMPONENT_TYPE_COUNT,
>              },
>      };
> 
>      int main(void)
>      {
>              struct pollfd pfd = { .events = POLLIN };
>              struct counter_event event_data[2];
> 
>              pfd.fd = open("/dev/counter0", O_RDWR);
> 
>              ioctl(pfd.fd, COUNTER_SET_WATCH_IOCTL, watches);
>              ioctl(pfd.fd, COUNTER_SET_WATCH_IOCTL, watches + 1);

What enables events? If an event is enabled for each of these ioctls,
then we have a race condition where events events from the first watch
can start to be queued before the second watch is added. So we would
have to flush the chardev first before polling, otherwise the assumption
that event_data[0] is owner_id=0 and event_data[1] is owner_id=1 is
not true.

This is also racy if we want to clear watches and set up new watches
at runtime. There would be a period of time where there were no watches
and we could miss events.

With my suggested changes of having fixed values per event and generic
events, we could just have a single ioctl to enable and disable events.
This would probably need to take an array of event descriptors as an
argument where event descriptors contain the component type/id and the
event to enable.

> 
>              for (;;) {
>                      poll(&pfd, 1, -1);
> 
>                      read(pfd.fd, event_data, sizeof(event_data));
> 
>                      printf("Timestamp 0: %llu\nCount 0: %llu\n"
>                             "Timestamp 1: %llu\nCount 1: %llu\n",
>                             (unsigned long long)event_data[0].timestamp,
>                             (unsigned long long)event_data[0].value_u64,
>                             (unsigned long long)event_data[1].timestamp,
>                             (unsigned long long)event_data[1].value_u64);
>              }
> 
>              return 0;
>      }
> 
> Cc: David Lechner <david@lechnology.com>
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---

