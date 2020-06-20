Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBA52202608
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jun 2020 20:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbgFTSvF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 20 Jun 2020 14:51:05 -0400
Received: from vern.gendns.com ([98.142.107.122]:48028 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728419AbgFTSvF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 20 Jun 2020 14:51:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7AxhbJwIMNaIwTRNcQ12Omehe8rlvXqphyVqkGht4CM=; b=E0rs6IUd9KrqG6rRqxg4EJFrwQ
        tXFRLg/PEtMOHOcgpxods6HB9KNRHQFvDFtDcxy81EMd/oYja/HwjEnivHs5ntdf0oPd0Vkz9Bulf
        f3bfR5Uh6v3v7cYZxuEsXi18AkMj3N5pe0Q+Ug5jQ8GtsOtwuOQdTHDFB1vyIDNEfzd8af2sKasrW
        MTXwxXquOewdCa5QJ15QbSWO2WcyomPaGzVhJ7VGMT2fQLo+BSxFfp8gLday5kwi5Z56u3xlitfAR
        doOHo86N+Ek5uQltonuGWgoA8VtZwhZ5tCxRai5o9vsXiY3EDuDYaXfEAzL98oVohyifRM7pJkgnt
        0MHXpPqA==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:36530 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <david@lechnology.com>)
        id 1jmiZw-0001IT-SU; Sat, 20 Jun 2020 14:51:00 -0400
Subject: Re: [PATCH v3 3/4] counter: Add character device interface
To:     William Breathitt Gray <vilhelm.gray@gmail.com>, jic23@kernel.org
Cc:     kamel.bouhara@bootlin.com, gwendal@chromium.org,
        alexandre.belloni@bootlin.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
References: <cover.1592341702.git.vilhelm.gray@gmail.com>
 <afe40ef2e24ecaca44fc229f7983cf4cde3374a8.1592341702.git.vilhelm.gray@gmail.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <8fae0659-56df-c0b5-7c0d-220feefed2b4@lechnology.com>
Date:   Sat, 20 Jun 2020 13:50:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <afe40ef2e24ecaca44fc229f7983cf4cde3374a8.1592341702.git.vilhelm.gray@gmail.com>
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

On 6/16/20 8:40 PM, William Breathitt Gray wrote:
> This patch introduces a character device interface for the Counter
> subsystem. Device control is exposed through standard character device
> read and write operations.
> 
> A /sys/bus/counter/devices/counterX/chrdev_format sysfs attribute is
> introduced to expose the character device data format:
> 
> * Users may write to this sysfs attribute to select the components they
>    want to interface -- the layout can be determined as well from the
>    order. For example:
> 
>    # echo "C0 C3 C2" > /sys/bus/counter/devices/counter0/chrdev_format
> 
>    This would select Counts 0, 3, and 2 (in that order) to be available
>    in the /dev/counter0 node as a contiguous memory region.
> 
>    You can select extensions in a similar fashion:
> 
>    # echo "C4E2 S1E0" > /sys/bus/counter/devices/counter0/chrdev_format
> 
>    This would select extension 2 from Count 4, and extension 0 from
>    Signal 1.
> 
> * Users may read from this chrdev_format sysfs attribute in order to see
>    the currently configured format of the character device.
> 
> * Users may perform read/write operations on the /dev/counterX node
>    directly; the layout of the data is what they user has configured via
>    the chrdev_format sysfs attribute. For example:
> 
>    # echo "C0 C1 S0 S1" > /sys/bus/counter/devices/counter0/chrdev_format
> 
>    Yields the following /dev/counter0 memory layout:
> 
>    +-----------------+------------------+----------+----------+
>    | Byte 0 - Byte 7 | Byte 8 - Byte 15 | Byte 16  | Byte 17  |
>    +-----------------+------------------+----------+----------+
>    | Count 0         | Count 1          | Signal 0 | Signal 2 |
>    +-----------------+------------------+----------+----------+
> 
>    The number of bytes allotted for each component or extension is
>    determined by its respective data type: u8 will have 1 byte allotted,
>    u64 will have 8 bytes allotted, etc.
> 

Instead of the proposed character device, I would really rather have one
that gives past events instead of the current state.

I have thought about some of the suggestions from previous version of
this patch series and I'm starting to think something similar to the
input and gpio subsystems would work fairly well.


There would have to be a fixed size event data structure:

struct counter_event {
	/** Best approximation of when event occurred in nanoseconds. */
	__u64 timestamp;
	/**
	 * Description of the synapse that triggered the event and the
	 * signal/counter that the value represents.
	 */
	__u64 descriptor;
	/** The signal/counter value recorded when the synapse fired. */
	__u64 value;
};

The descriptor field would actually probably be a union of __u64 and a
struct with its own fields to describe the synapse and signal or count.

If a synapse involves more than one signal or count, then there would
be multiple events with identical timestamps.

Userspace programs should be able to enable only the events/synapses they
are interested in and then the poll() the character device to wait for
events in an efficient way instead of having to constantly read - which
could still miss events.

---

Real world use case - measuring the speed of a motor:

At low speeds it is more accurate to measure the time difference between
count events. In this case we would want events from two synapses. One
triggered by the rising and falling edges of signal A and one triggered
by the direction signal. The magnitude of the speed is calculated by
taking the difference in timestamps between signal A events and the +/-
sign is determined by the direction signal.

At high speeds a different configuration is needed. Assuming the counter
has a timer clock signal a synapse would be configured to fire every 10
or 20 milliseconds. This would trigger an event that contains the count.
The speed is calculated as the difference in counts divided by the fixed
time interval.

Some applications may need to do both and be able to change the
configuration at runtime. It may start out in the low speed configuration,
but as the speed increases, events triggered by the change in count will
need to be disabled to prevent being overwhelmed with too many count
events. But if the speed drops low again, the count events will need to
be turned back on.

---

Regarding the implementation, the character device can be backed by a
kfifo. Interrupts from the counter hardware push events to the kfifo
and reading from the character device drains the kfifo.

drivers/gpio/gpiolib.c could be a good example to follow.

If we only want to allow one consumer to open the chardev at a time,
then enabling/disabling events via sysfs would probably be fine since
we are already sort of doing that anyway to enable/disable counters.
But if we need to allow multiple consumers per chardev that would each
want different events, then configuring via ioctl would be required so
that per-file descriptor configuration could be done (each call to open()
would create a new kfifo and ioctl would configure what gets pushed to
that kfifo).


