Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C86E43CDCD
	for <lists+linux-iio@lfdr.de>; Wed, 27 Oct 2021 17:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242806AbhJ0Pmn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 27 Oct 2021 11:42:43 -0400
Received: from vern.gendns.com ([98.142.107.122]:40748 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238707AbhJ0Pmm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 27 Oct 2021 11:42:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fxDnVc4gAt+9+uWiUZqWwzs3b/BVdApkBM/ct2KEF9I=; b=BvPOIjsrVceUE4uSmQMjjVuoBe
        HiCdfq/1TXc6REmzNy9r20ww4vgGF8QfI6RsmGem0x66bU6IOqhHQkGBD2RfreJwnjrDZydT+9y8w
        vv9OLSUFi8o7T0E2G7nSAjrIEu+Yewmbu9WP+QvpTY8uo6qVzGKI0td2Xuwn6NQRZvGDZPKpV2OJF
        Rk63Xxr/Ziiut+Zo4Wmpd+MECoqNcku8Gwa49u3bzVsJY2UMtuKKpTBrNfQWuAZdhMFb7d4jVHzDK
        sNRk7sONo1I2G3UAY2bPOC3qqZeSscMdEX/V2KMKh3Ieqryo2DWW2mimFkyPVCKXM+WUN61JbT9ys
        p6qiEx5A==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:43088 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <david@lechnology.com>)
        id 1mfl28-0003zQ-1a; Wed, 27 Oct 2021 11:40:16 -0400
Subject: Re: [PATCH 5/8] counter/ti-eqep: add support for latched position
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-iio@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20211017013343.3385923-1-david@lechnology.com>
 <20211017013343.3385923-6-david@lechnology.com> <YXkDT2gaFfdIsgTQ@shinobu>
From:   David Lechner <david@lechnology.com>
Message-ID: <444960b4-1120-26fa-bd00-dfbe3c13cf23@lechnology.com>
Date:   Wed, 27 Oct 2021 10:40:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YXkDT2gaFfdIsgTQ@shinobu>
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

On 10/27/21 2:44 AM, William Breathitt Gray wrote:
> On Sat, Oct 16, 2021 at 08:33:40PM -0500, David Lechner wrote:
>> This adds support to the TI eQEP counter driver for a latched position.
>> This is a new extension that gets the counter count that was recorded
>> when an event was triggered. A new device-level latch_mode attribute is
>> added to select the trigger. Edge capture unit support will be needed
>> to make full use of this, but "Unit timeout" mode can already be used
>> to calculate high speeds.
>>
>> The unit timer could also have attributes for latched_time and
>> latched_period that use the same trigger. However this is not a use
>> case at this time, so they can be added later if needed.
> 
> I see that "latched_count" holds the captured counter count; would this
> "latched_time" hold the captured unit timer time? If so, does that mean
> setting the latch mode to "Unit timeout" always results in a
> "latched_time" equal to 0 (assuming that's when the timeout event
> triggers)?
> 

Some `latched_*` attributes will only be useful for one `latched_mode`
selection but not the other.

These latched registers are used to measure speed. There are two ways
to do this. A) measuring the change in position over a fixed time and
B) measuring the change in time for a fixed change in position. So for
A) latched_mode would be set to trigger on timeout and we would use
the latched_position for the measurement. For B) we would set the
latched_mode to trigger on reading the count register and use the
latched_time as the measurement.

...

>>   static struct counter_comp ti_eqep_device_ext[] = {
>> +	COUNTER_COMP_DEVICE_ENUM("latch_mode", ti_eqep_latch_mode_read,
>> +				ti_eqep_latch_mode_write, ti_eqep_latch_modes),
> 
> It seems more appropriate to move this alongside "latched_count" as
> Count extension because this is setting the trigger mode to latch the
> respective Count's count. Or does this particular extension also affect
> the "latched_time" capture for the unit timer?
> 

In hardware, there are at least 3 registers that get latched that I
recall. They are in different subsystems (main count, unit timer,
edge capture). So as you have guessed, that is the reason for having
the trigger selection at the device level.
