Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFFE33940A
	for <lists+linux-iio@lfdr.de>; Fri, 12 Mar 2021 17:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbhCLQ5o (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Mar 2021 11:57:44 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:4728 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232769AbhCLQ5S (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Mar 2021 11:57:18 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12CGlE2h006603;
        Fri, 12 Mar 2021 17:56:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=n86YEqyoLsGTQzzOCMBn6w4NSe0qajLc2LvJlnYylfY=;
 b=zG18xpxDo+vcgrSawd/IszESUCZE2jFhxEfJdaZY4/jrG2ItITfhE6Wa0U+YEHXlS1EC
 YPvOqHbk2W1BqyUGjFyq28fgu4K07Jk/cd/+9IpIGeWPOHuQlw+tts3qZvc0v9sTW/ZP
 y4EmYgV54g11iwbVVy26zU7c1gnmOVyVB4c2+JOBbOUjbA26sB/lRsLMuDDLwD5VWcFv
 cgqOu/EWN2ngasrMUJmk/49C8wMXgFlIwWAjPHRAvEfGW3WYBfimHbeW62tXSYdGcc8y
 VBIQFN70aLs/dxyL9s2jGYvT89BwAZ6cwf/uCovNwHTRIqJ8ZBvGMZtQSg95ozLhxLRF oQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 374037ebr2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Mar 2021 17:56:53 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5005D10002A;
        Fri, 12 Mar 2021 17:56:52 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4265025B8B3;
        Fri, 12 Mar 2021 17:56:52 +0100 (CET)
Received: from [10.211.3.93] (10.75.127.47) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 12 Mar
 2021 17:56:51 +0100
Subject: Re: [RFC PATCH 2/7] iio:ABI docs: Avoid repitition of
 triggerX/sampling_frequency
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     <linux-iio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
References: <20210117153816.696693-1-jic23@kernel.org>
 <20210117153816.696693-3-jic23@kernel.org>
 <c6fb25c0-1292-f5fa-c5c9-8e47d1061874@metafoo.de>
 <20210307120451.79e538fc@archlinux>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Message-ID: <079601f7-2d9e-6a01-13a0-4cb7014b2a6a@foss.st.com>
Date:   Fri, 12 Mar 2021 17:56:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210307120451.79e538fc@archlinux>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-12_06:2021-03-12,2021-03-12 signatures=0
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/7/21 1:04 PM, Jonathan Cameron wrote:
> On Sun, 7 Mar 2021 10:40:18 +0100
> Lars-Peter Clausen <lars@metafoo.de> wrote:
> 
>> On 1/17/21 4:38 PM, Jonathan Cameron wrote:
>>> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>
>>> The timer-stm32 provided a little more specific information than the main
>>> docs about the value of 0 corresponding to stopping sampling.  Given that
>>> this makes sense in general, move that statement over to the main docs
>>> and drop the version in sysfs-bus-iio-timer-stm32
>>>
>>> Fixes
>>> $ scripts/get_abi.pl validate
>>> /sys/bus/iio/devices/triggerX/sampling_frequency is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-timer-stm32:92  ./Documentation/ABI/testing/sysfs-bus-iio:45
>>>
>>> Cc: Fabrice Gasnier <fabrice.gasnier@st.com>
>>> Reported-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>> ---
>>>   Documentation/ABI/testing/sysfs-bus-iio             | 2 ++
>>>   Documentation/ABI/testing/sysfs-bus-iio-timer-stm32 | 8 --------
>>>   2 files changed, 2 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
>>> index d2dd9cc280f9..9b5ceb22363d 100644
>>> --- a/Documentation/ABI/testing/sysfs-bus-iio
>>> +++ b/Documentation/ABI/testing/sysfs-bus-iio
>>> @@ -55,6 +55,8 @@ Description:
>>>   		direct access interfaces, it may be found in any of the
>>>   		relevant directories.  If it affects all of the above
>>>   		then it is to be found in the base device directory.
>>> +		Note a value 0 where supported, will correspond to sampling
>>> +		stopping.  
>>
>> Hm, I don't like this. 0 should be an invalid value for the standard 
>> ABI. Enabling/disabling of the trigger should be controlled by whether 
>> there are any active trigger consumers.
>>
>> The stm32-timer-trigger implements a non-standard ABI and I think we 
>> need to document this explicitly. The driver does not have a set_state 
>> callback. So the frequency property is used to enable/disable the 
>> trigger, but as said above, for standard compliant triggers that should 
>> not be the case.
>>
> Good point.  Ideally we'd also fix the stm32-timer-trigger to have
> an explicit enable / disable (even if that works by setting the frequency
> to 0 under the hook)

Hi Jonathan,

I'd like to come up with something here...
The trivial use case is: the stm32-timer triggers the stm32-adc (by HW).
In this case, "set_trigger_state" perfectly fits the needs (looks like).

But such change doesn't seems trivial when considering one timer can
trig another timer in hardware here. The "set_trigger_state" isn't
called in such a case.
So, I'm not sure what could be suitable to implement explicit
enable/disable of the timer trigger ?

Just to share some thoughts here: For sure the stm32-timer-trigger would
need additional changes (I haven't forget other mail thread on the
preset attribute). I believe also some functionalities should be moved
to the counter framework. But, even provided this, I think there will
still be a need for an enable or disable attribute, for the trigger part.

Perhaps adding an enable/disable attribute could be a way here ?
If yes, would you have some suggestion on the naming ?

Please advice,
Thanks in advance,
Fabrice

> 
> For now I've dropped the patch until this is resolved.
> 
> Thanks,
> 
> Jonathan
> 
> 
