Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 456D043CFAC
	for <lists+linux-iio@lfdr.de>; Wed, 27 Oct 2021 19:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbhJ0RbR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 27 Oct 2021 13:31:17 -0400
Received: from vern.gendns.com ([98.142.107.122]:58190 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243248AbhJ0RbR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 27 Oct 2021 13:31:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=V6YBYmqWPDZRGNpxkzTVUo3BWCaC29ab9Uud4jWzHqM=; b=PEc48O5plZ6Po9zcDCKmskBM+p
        J4wlJByW6REhCurhGpEOed+4Lq0zvK5QLRLvhVwnTi2YNR3JDZZNwbiJuto+fmeT2q2UuCbzfIXFb
        KBnYLrTxKOMaBT5/X+99UHBL8KJNBYoh2k47lwM1WaG2YYZfl2haBg3H7Srb+bdXC4Ak+AwUt8vkK
        IHIR+la2a9Y5P5H4W6ZzIbVTn2xFHDI58t+eGzVTI+cL7grFf7po8hI5Be+quTDlayBPKzk1sn5I2
        F/f//kOrL2y8xyFJqAnSlbhPttaSDenzjY9UWx8wf82kHmZqk/sbmMv/w3fOc9Ud7VHMTh3BqaAkL
        0yF2VYYQ==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:45486 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <david@lechnology.com>)
        id 1mfmj9-0004To-Td; Wed, 27 Oct 2021 13:28:47 -0400
Subject: Re: [PATCH 7/8] counter/ti-eqep: add support for edge capture unit
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-iio@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20211017013343.3385923-1-david@lechnology.com>
 <20211017013343.3385923-8-david@lechnology.com> <YXkMheVhVp9psPDD@shinobu>
From:   David Lechner <david@lechnology.com>
Message-ID: <c0464d2a-2e65-ac43-1724-80f45d857753@lechnology.com>
Date:   Wed, 27 Oct 2021 12:28:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YXkMheVhVp9psPDD@shinobu>
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

On 10/27/21 3:23 AM, William Breathitt Gray wrote:
> On Sat, Oct 16, 2021 at 08:33:42PM -0500, David Lechner wrote:
>> This adds support for the Edge Capture Unit to the TI eQEP counter
>> driver. This just adds the minimum required features to measure speed
>> using the Unit Timer and the Edge Capture unit. Additional features can
>> be added in the future if needed.
>>
>> This adds 4 new device-level attributes:
>> - edge_capture_unit_prescaler: selects a prescalar for the Counter count
>> 	coming into the Edge Capture Unit
>> - edge_capture_unit_max_period: selects the max time period that can be
>> 	measured by the Edge Capture Unit
> 
> What happens if a trigger occurs after the max period has elapsed; is
> the latched period value invalid in that scenario?


This period is essentially selecting prescalars, so if we get rid of
the time aspect and treat everything as counts this will change a bit.

But the question is still valid. I don't recall off-hand what happens
so I will have to test it the next time I am working on this. It seems
though that I was able to somehow detect when this was the case.

> 
>> - edge_capture_unit_latched_period: gets the period that was measured
>> 	when the event selected by the latch_mode attribute is triggered
> 
> Is this period value essentially the current latch count minus the
> previous latch count?
> 

No, the period is the amount of time that elapsed between counts.

>>   static struct counter_comp ti_eqep_device_ext[] = {
>> +	COUNTER_COMP_DEVICE_BOOL("edge_capture_unit_enable",
>> +				 ti_eqep_edge_capture_unit_enable_read,
>> +				 ti_eqep_edge_capture_unit_enable_write),
>> +	COUNTER_COMP_DEVICE_U64("edge_capture_unit_latched_period",
>> +				ti_eqep_edge_capture_unit_latched_period_read,
>> +				NULL),
>> +	COUNTER_COMP_DEVICE_U64("edge_capture_unit_max_period",
>> +				ti_eqep_edge_capture_unit_max_period_read,
>> +				ti_eqep_edge_capture_unit_max_period_write),
>> +	COUNTER_COMP_DEVICE_ENUM("edge_capture_unit_prescaler",
>> +				 ti_eqep_edge_capture_unit_prescaler_read,
>> +				 ti_eqep_edge_capture_unit_prescaler_write,
>> +				 ti_eqep_edge_capture_unit_prescaler_available),
> 
> Would it make sense for these to be Count 0 extensions so that they're
> alongside the "latched_count" extension; or do these extensions also
> represent values related to "latched_time" for the unit timer?
> 

They are related to both.
