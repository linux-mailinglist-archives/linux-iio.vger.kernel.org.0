Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A17433C3D37
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jul 2021 16:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbhGKOLW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Jul 2021 10:11:22 -0400
Received: from vern.gendns.com ([98.142.107.122]:37378 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232544AbhGKOLV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Jul 2021 10:11:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=SjKdPzzJwOkoEQ37ddBWCEPWtTZUjYn/71x1w88WbP0=; b=sXIu2lJx7Nb5MopNnoomv0l8qo
        sSvv1bb7Wn8Uco3YNySuWhGH/eroDYKrWxiWxQrVeSysdmbf/R/mvhjWwnArocnZPR2i1ADXmIm8x
        EFYGpgM7VVGhV9MCkmknXy+J5RaXglWmR0vJaSQzFX7plGTz+JzQ02B5z4gsGglyqJsO5Wg833sCu
        XEYhAitYQDQTqZBY7n3JGSocSqHAt0gDkudEuyRHLHC/eDYvHxbpVSqjecbht4hn9SM4hNkRlZX9C
        zGf2gjYEZCDJXUQxtHP6kZ725zTtXAv1ZaqEz/YzdMzOGb1Tf2y+7QxDBSDONT9wrozy1iTXnqVqf
        aP+eOAag==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:51996 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <david@lechnology.com>)
        id 1m2a8F-003idm-GK; Sun, 11 Jul 2021 10:08:32 -0400
Subject: Re: [PATCH v12 14/17] counter: Implement *_component_id sysfs
 attributes
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com, kernel@pengutronix.de,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        o.rempel@pengutronix.de, jarkko.nikula@linux.intel.com,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <cover.1625471640.git.vilhelm.gray@gmail.com>
 <0e04a9e6455faf171e5dd7885676e55b5321b1ea.1625471640.git.vilhelm.gray@gmail.com>
 <bd0313ce-22fa-0516-93a1-ff3a5cb1fdd1@lechnology.com>
 <20210711142800.60e94cc7@jic23-huawei>
From:   David Lechner <david@lechnology.com>
Message-ID: <72d6513c-c7fc-c53d-b750-ebd2e8f3b848@lechnology.com>
Date:   Sun, 11 Jul 2021 09:08:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210711142800.60e94cc7@jic23-huawei>
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

On 7/11/21 8:28 AM, Jonathan Cameron wrote:
> On Sat, 10 Jul 2021 12:06:53 -0500
> David Lechner <david@lechnology.com> wrote:
> 
>> On 7/5/21 3:19 AM, William Breathitt Gray wrote:
>>> The Generic Counter chrdev interface expects users to supply component
>>> IDs in order to select extensions for requests. In order for users to
>>> know what component ID belongs to which extension this information must
>>> be exposed. The *_component_id attribute provides a way for users to
>>> discover what component ID belongs to which respective extension.
>>>
>>> Cc: David Lechner <david@lechnology.com>
>>> Cc: Gwendal Grignou <gwendal@chromium.org>
>>> Cc: Dan Carpenter <dan.carpenter@oracle.com>
>>> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
>>> ---
>>>    Documentation/ABI/testing/sysfs-bus-counter | 16 ++++++++++-
>>>    drivers/counter/counter-sysfs.c             | 30 ++++++++++++++++-----
>>>    2 files changed, 39 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/ABI/testing/sysfs-bus-counter
>>> index 9809d8a47431..e0e99adb0ecc 100644
>>> --- a/Documentation/ABI/testing/sysfs-bus-counter
>>> +++ b/Documentation/ABI/testing/sysfs-bus-counter
>>> @@ -203,12 +203,26 @@ Description:
>>>    		both edges:
>>>    			Any state transition.
>>>    
>>> +What:		/sys/bus/counter/devices/counterX/countY/ceiling_component_id
>>> +What:		/sys/bus/counter/devices/counterX/countY/floor_component_id
>>> +What:		/sys/bus/counter/devices/counterX/countY/count_mode_component_id
>>> +What:		/sys/bus/counter/devices/counterX/countY/direction_component_id
>>> +What:		/sys/bus/counter/devices/counterX/countY/enable_component_id
>>> +What:		/sys/bus/counter/devices/counterX/countY/error_noise_component_id
>>> +What:		/sys/bus/counter/devices/counterX/countY/prescaler_component_id
>>> +What:		/sys/bus/counter/devices/counterX/countY/preset_component_id
>>> +What:		/sys/bus/counter/devices/counterX/countY/preset_enable_component_id
>>>    What:		/sys/bus/counter/devices/counterX/countY/signalZ_action_component_id
>>> +What:		/sys/bus/counter/devices/counterX/signalY/cable_fault_component_id
>>> +What:		/sys/bus/counter/devices/counterX/signalY/cable_fault_enable_component_id
>>> +What:		/sys/bus/counter/devices/counterX/signalY/filter_clock_prescaler_component_id
>>> +What:		/sys/bus/counter/devices/counterX/signalY/index_polarity_component_id
>>> +What:		/sys/bus/counter/devices/counterX/signalY/synchronous_mode_component_id
>>
>> Could we just write a single line?
>>
>> What:		/sys/bus/counter/devices/counterX/signalY/<component>_component_id
> 
> Not nice for grepping so I think it's better to call them out explicitly.
> 
> There has been a proposal to check this ABI doc against running kernels, and if we have
> too many wild cards that becomes very difficult to do.
> 
> Jonathan
> 
>>
>>>    KernelVersion:	5.15

Makes sense. Do we start a new group of similar names with the same
description for each kernel release that includes new attributes then?

>>>    Contact:	linux-iio@vger.kernel.org
>>>    Description:
>>>    		Read-only attribute that indicates the component ID of the
>>> -		respective Synapse of Count Y for Signal Z.
>>> +		respective extension or Synapse.
>>>    
