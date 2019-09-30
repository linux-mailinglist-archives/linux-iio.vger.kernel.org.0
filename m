Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 398D3C1AE0
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2019 07:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725809AbfI3FWn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Sep 2019 01:22:43 -0400
Received: from mga06.intel.com ([134.134.136.31]:62157 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbfI3FWn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Sep 2019 01:22:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Sep 2019 22:22:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,565,1559545200"; 
   d="scan'208";a="202774589"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by orsmga002.jf.intel.com with ESMTP; 29 Sep 2019 22:22:40 -0700
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-iio@vger.kernel.org, jic23@jic23.retrosnub.co.uk,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>
Subject: Re: [RFC/PATCHv2 2/2] counter: introduce support for Intel QEP Encoder
In-Reply-To: <20190928213348.GA4693@icarus>
References: <20190917114403.GA8368@icarus> <20190919080305.960198-1-felipe.balbi@linux.intel.com> <20190919080305.960198-2-felipe.balbi@linux.intel.com> <20190922233538.GA3119@icarus> <e24965be-3b0b-7f5e-bc5b-e2fb09ce6d19@lechnology.com> <20190928213348.GA4693@icarus>
Date:   Mon, 30 Sep 2019 08:22:39 +0300
Message-ID: <87muemwe74.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


Hi,

William Breathitt Gray <vilhelm.gray@gmail.com> writes:
> On Tue, Sep 24, 2019 at 04:46:57PM -0500, David Lechner wrote:
>> On 9/22/19 6:35 PM, William Breathitt Gray wrote:
>> > On Thu, Sep 19, 2019 at 11:03:05AM +0300, Felipe Balbi wrote:
>> >> Add support for Intel PSE Quadrature Encoder
>> >>
>> >> Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
>> >> ---
>> >>
>> >> Changes since v1:
>> >> 	- Many more private sysfs files converted over to counter interface
>> >>
>> >>
>> >> How do you want me to model this device's Capture Compare Mode (see
>> >> below)?
>> > 
>> > Hi Felipe,
>> > 
>> > I'm CCing Fabien and David as they may be interested in the timestamps
>> > discussion. See below for some ideas I have on implementing this.
>> > 
>> 
>> Could be an interesting read (thread from my first counter driver):
>> 
>> https://lore.kernel.org/linux-iio/1b913919-beb9-34e7-d915-6bcc40eeee1d@lechnology.com/
>> 
>> What would be useful to me is something like the buffer feature in iio
>> where a timestamp is associated with a count and stored in a buffer so that
>> we can look at a window of all values recorded in the last 20ms. Being able
>> to access this via mmap would be very helpful for performance (running on
>> 300MHz ARM). Anything to do with timestamps in sysfs is probably not useful
>> unless it is a rare event, like a watchdog timeout.
>
> I'm CCing Jonathan Cameron since I'm not familiar with how IIO handles
> timestamps and buffers. I don't want to reinvent something that is
> working well, so hopefully we can reuse the IIO timestamp design for the
> Counter subsystem.
>
> I would argue that a human-readable timestamps printout is useful for
> certain applications (e.g. a tally counter attached to a fault line: a
> human administrator will be able to review previous fault times).
> However as you point out, a low latency operation is necessary for
> performance critical applications.
>
> Although you are correct that mmap is a good low latency operation to
> get access to a timestamp buffer, I'm afraid giving direct access to
> memory like that will lead to many incompatible representations of
> timestamp data (e.g. variations in endianness, signedness, data size,
> etc.). I would like a standardized representation for this data that
> userspace applications can expect to receive and interpret, especially
> when time is widely represented as an unsigned integer.
>
> Felipe suggested the creation of a counter_event structure so that users
> can poll on an attribute. This kind of behavior is useful for notifying
> users of interrupts and other events, but I think we should restrict the
> use of the read call on these sysfs attributes to just human-readable
> data. Instead, perhaps ioctl calls can be used to facilitate binary data
> transfers.
>
> For example, we can define a COUNTER_GET_TIMESTAMPS_IOCTL ioctl request
> that returns a counter_timestamps structure with a timestamps array
> populated:
>
>         struct counter_timestamps{
>                 size_t num_timestamps;
>         	unsigned int *timestamps;
>         }
>
> That would allow quick access to the timestamps data, while also
> restricting it to a standard representation that all userspace
> applications can follow and interpret. In addition, this won't interfer
> with polling, so users can still wait for an interrupt and then decide
> whether they want to use the slower human-readable printout (via read)
> or the faster binary data access (via ioctl).

Seems like we're starting to build the need for a /dev/counter[0123...]
representation of the subsystem. If that's the case, then it may very
well be that sysfs becomes somewhat optional.

I think is makes sense to rely more on character devices specially since
I know of devices running linux with so little memory that sysfs (and a
bunch of other features) are removed from the kernel. Having a character
device representation would allow counter subsystem to be used on such
devices.

cheers

-- 
balbi
