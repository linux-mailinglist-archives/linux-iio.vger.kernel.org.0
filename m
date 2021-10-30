Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25B5A440A39
	for <lists+linux-iio@lfdr.de>; Sat, 30 Oct 2021 18:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhJ3QnB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 30 Oct 2021 12:43:01 -0400
Received: from vern.gendns.com ([98.142.107.122]:33430 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229694AbhJ3QnA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 30 Oct 2021 12:43:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uamXSidjKkCn8xY6LAC2GoNAiGwksP7TQlMQJqx20Ms=; b=hPPV1QLCODnMO3kWcCkhMoMR6E
        C4ku2VYCL4nIMKYJZtYkEkgWEwAl71miMYL1U0pVNkA4M0oUTkBXJY/nGnnrha30Bqp+qmW5FrG1/
        fZPQgPxs6RZE2uR6ul9cR0p3OoGSymk6ew0eMptXpay/a7UYO8v7y4HhWAhmlixgdDomYEutmdmcr
        Y9PmBdUXRBwQRSmJlo1pfxrqvLh6RW1KBZc8IRaraVdk2XDq6yu2fTZOrfwG3MIIuHbjJRnLTEnga
        pIFg8BpoRKYymwUOE5xUHLEagm8hh+IatmxSjCjA6U/Q4hioqKDAw73tFdbxtuLjNTmswE01lOcXu
        i9wC570Q==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:42744 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <david@lechnology.com>)
        id 1mgrOv-0005Ok-4Q; Sat, 30 Oct 2021 12:40:28 -0400
Subject: Re: [PATCH 4/8] docs: counter: add unit timer sysfs attributes
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-iio@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20211017013343.3385923-1-david@lechnology.com>
 <20211017013343.3385923-5-david@lechnology.com> <YXj1xc6DdeOrUKjW@shinobu>
 <6e96cdd9-d1f1-6861-59eb-c4e6b9a2ffb9@lechnology.com>
 <YXpYUIUIQe+oxwXK@shinobu>
From:   David Lechner <david@lechnology.com>
Message-ID: <d5d7454b-e0a0-7436-10d7-dcb402885479@lechnology.com>
Date:   Sat, 30 Oct 2021 11:40:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YXpYUIUIQe+oxwXK@shinobu>
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

On 10/28/21 2:59 AM, William Breathitt Gray wrote:
> On Wed, Oct 27, 2021 at 10:30:36AM -0500, David Lechner wrote:
>> On 10/27/21 1:46 AM, William Breathitt Gray wrote:
>>> On Sat, Oct 16, 2021 at 08:33:39PM -0500, David Lechner wrote:
>>>> This documents new unit timer sysfs attributes for the counter
>>>> subsystem.
>>>>
>>>> Signed-off-by: David Lechner <david@lechnology.com>
>>>
>>> Hello David,
>>>
>>> The unit timer is effectively a Count in its own right, so instead of
>>> introducing new sysfs attributes you can just implement it as another
>>> Count in the driver. Count 0 is "QPOSCNT", so set the name of this new
>>> Count 1 as "Unit Timer" (or the datasheet naming if more apt) to
>>> differentiate the Counts. You can then provide the "unit_timer_enable",
>>> "unit_timer_period", and "unit_timer_time" functionalities as respective
>>> Count 1 extensions ("enable" and "period") and Count 1 "count".
> 
> Actually if the counter function here is COUNTER_FUNCTION_DECREASE, then

It is an increasing counter.

> instead of introducing a new "period" extension, define this as a
> "ceiling" extension; that's what ceiling represents in the Counter
> interface: "the upper limit for the respective counter", which is the
> period of a timer counting down to a timeout.

In one of the other patches, you made a comment about the semantics
of ceiling with relation to the overflow event. We can indeed treat
the timer as a counter and the period as the ceiling. However, the
unit timer event occurs when the count is equal to the period (ceiling)
whereas an overflow event occurs when the count exceeds the ceiling.
So what would this event be called in generic counter terms? "timeout"
doesn't seem right.

> 
> William Breathitt Gray
> 
>>>
>>> If you believe it appropriate, you can provide the raw timer ticks via
>>> the Count 1 "count" while a nanoseconds interface is provided via a
>>> Count 1 extension "timeout" (or something similar).
>>>

One area where this concept of treating a timer as a counter potentially
breaks down is the issue of CPU frequency scaling. By treating the unit
timer as a timer, then the kernel could take care of any changes in clock
rate internally by automatically adjusting the prescalar and period on
rate change events. But if we are just treating it as a counter, then we
should probably just have an attribute that provides the clock rate and
if we want to support CPU frequency scaling, add an event that indicates
that the clock rate changed.

