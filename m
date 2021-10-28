Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0726843E270
	for <lists+linux-iio@lfdr.de>; Thu, 28 Oct 2021 15:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbhJ1NpU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Oct 2021 09:45:20 -0400
Received: from vern.gendns.com ([98.142.107.122]:58772 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229887AbhJ1NpT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 28 Oct 2021 09:45:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=SVlgNf+ucxEPseJvy+L/+bBmOwRajcw4V+PyOl9QXbA=; b=Al5M4BbYU+HjwYm6e9i0JgWcH0
        cxzOwIHAF0fEp1eLeTCENiW1kD+SZzd4yODLESrUw0E6VzKkTk7lk9Fq/srfxd6Ue4ksLyylVB968
        m9yF4fNokuhAENlbDJsbHZZrfixIhdxWrVifhLNudShT3OZolwaTPx5FyMBttWMXtcR8O6Bei2dgD
        ixyag8870IuuX8myLCo8AjieTOJslZBxy6sEawQxcF+K4ASUUL23/G4cyyHYCUCEcp8FPk87np7Wz
        bfv17pVsxmB5IKmKbW3vjV6I+7MTa767PKZWrNVAJacUAdoe5YhHfPmHFJLKlc+MhEOLVtXc63Nzy
        NQu/nviw==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:47982 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <david@lechnology.com>)
        id 1mg5g0-00013p-Ck; Thu, 28 Oct 2021 09:42:50 -0400
Subject: Re: [PATCH 3/8] counter/ti-eqep: add support for unit timer
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-iio@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20211017013343.3385923-1-david@lechnology.com>
 <20211017013343.3385923-4-david@lechnology.com> <YXZvQSU6bRRaWD89@shinobu>
 <253916e2-a808-8786-ac72-60a1a62b1531@lechnology.com>
 <YXpVyjnrrmRbpHJU@shinobu>
From:   David Lechner <david@lechnology.com>
Message-ID: <f5e40a22-3c7f-4d4d-d160-fe5b5a7dd72e@lechnology.com>
Date:   Thu, 28 Oct 2021 08:42:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YXpVyjnrrmRbpHJU@shinobu>
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

On 10/28/21 2:48 AM, William Breathitt Gray wrote:
> On Wed, Oct 27, 2021 at 10:28:59AM -0500, David Lechner wrote:
>> On 10/25/21 3:48 AM, William Breathitt Gray wrote:
>>> On Sat, Oct 16, 2021 at 08:33:38PM -0500, David Lechner wrote:
>>>> This adds support to the TI eQEP counter driver for the Unit Timer.
>>>> The Unit Timer is a device-level extension that provides a timer to be
>>>> used for speed calculations. The sysfs interface for the Unit Timer is
>>>> new and will be documented in a later commit. It contains a R/W time
>>>> attribute for the current time, a R/W period attribute for the timeout
>>>> period and a R/W enable attribute to start/stop the timer. It also
>>>> implements a timeout event on the chrdev interface that is triggered
>>>> each time the period timeout is reached.
>>>>
>>>> Signed-off-by: David Lechner <david@lechnology.com>
>>>
>>> I'll comment on the sysfs interface in the respective docs patch. Some
>>> comments regarding this patch below.
>>>
>>
>> ...
>>
>>>> +static int ti_eqep_unit_timer_period_write(struct counter_device *counter,
>>>> +					   u64 value)
>>>> +{
>>>> +	struct ti_eqep_cnt *priv = counter->priv;
>>>> +	u32 quprd;
>>>> +
>>>> +	/* convert nanoseconds to timer ticks */
>>>> +	quprd = value = mul_u64_u32_div(value, priv->sysclkout_rate, NSEC_PER_SEC);
>>>> +	if (quprd != value)
>>>> +		return -ERANGE;
>>>> +
>>>> +	/* protect against infinite unit timeout interrupts */
>>>> +	if (quprd == 0)
>>>> +		return -EINVAL;
>>>
>>> I doubt there's any practical reason for a user to set the timer period
>>> to 0, but perhaps we should not try to protect users from themselves
>>> here. It's very obvious and expected that setting the timer period to 0
>>> results in timeouts as quickly as possible, so really the user should be
>>> left to reap the fruits of their decision regardless of how asinine that
>>> decision is.
>>
>> Even if the operating system ceases operation because the interrupt
>> handler keeps running because clearing the interrupt has no effect
>> in this condition?
> 
> I don't disagree with you that configuring the device to repeatedly
> timeout without pause would be a waste of system resources. However, it
> is more appropriate for this protection to be located in a userspace
> application rather than the driver code here.
> 
> The purpose of a driver is to expose the functionality of a device in an
> understandable and consistent manner. Drivers should not dictate what a
> user does with their device, but rather should help facilitate the
> user's control so that the device behaves as would be expected given
> such an interface.
> 
> For this particular case, the device is capable of sending an interrupt
> when a timeout events occurs, and the timeout period can be adjusted;
> setting the timeout period lower and lower results in less and less time
> between timeout events. The behavior and result of setting the timeout
> period lower is well-defined and predictable; it is intuitive that
> configuring the timeout period to 0, the lowest value possible, results
> in the shortest time possible between timeouts: no pause at all.
> 
> As long as the functionality of this device is exposed in such an
> understandable and consistent manner, the driver succeeds in serving its
> purpose. So I believe a timeout period of 0 is a valid configuration
> for this driver to allow, albeit a seemingly pointless one for users to
> actually choose. To that end, simply set the default value of QUPRD to
> non-zero on probe() as you do already in this patch and let the user be
> free to adjust if they so decide.
> 
> William Breathitt Gray
> 

I disagree. I consider this a crash. The system becomes completely
unusable and you have to pull power to turn it off, potentially
leading to data loss and disk corruption.

