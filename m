Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 448FE2DBFC8
	for <lists+linux-iio@lfdr.de>; Wed, 16 Dec 2020 12:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725896AbgLPLvH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Dec 2020 06:51:07 -0500
Received: from www381.your-server.de ([78.46.137.84]:43276 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgLPLvG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Dec 2020 06:51:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=d0jYfhzBVBVSfYFV1JAg0liM2g6a4nUIRuqD7iaTqRE=; b=Jmn3bVx64Wnx9XaccZluKWdLUe
        XaiRqRAn7N0OVGQei6H6p+HLTyFlviSroSMie3iIhI2QjekNvII3doo3W6KLNssGDpbrs1Kup/J/p
        3ArAht0nDSyGKbQ8ZAtGzDYv9Pn08yCZ7kdVXL8d6IAylp+DGEwvLhScLS/g2OFcvH2Cz0FThApJu
        6tc2Fz73m+C/aV2P9vK/6lm0y8orLVqC3d6n9JNXTSBCtVQWE+PtaejtvAw3tEVkaGdX6dAyyMAOA
        sc8M/2EYWNUci6aZ5DYztdMG2SryjDHu6RbyvEZDekYIZVBWQccy17J3RjzFQ89Mguvkz3H4B5kOp
        xuT6BwGw==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1kpVJu-000GVk-43; Wed, 16 Dec 2020 12:50:14 +0100
Received: from [62.216.202.54] (helo=[192.168.178.20])
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1kpVJt-000I2V-VG; Wed, 16 Dec 2020 12:50:13 +0100
Subject: Re: [PATCH 2/2] iio: xilinx-xadc: Add basic support for Ultrascale
 System Monitor
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Anand Ashok Dumbre <ANANDASH@xilinx.com>,
        Michal Simek <michals@xilinx.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <20200922134624.13191-1-lars@metafoo.de>
 <20200922134624.13191-2-lars@metafoo.de> <20200923214728.6e0c07b0@archlinux>
 <fb8db604-0ae3-1736-67bf-20a1dc8bc008@xilinx.com>
 <20201129131441.3e9d83f8@archlinux>
 <BY5PR02MB6916F923D93341D41BA08E8AA9CA0@BY5PR02MB6916.namprd02.prod.outlook.com>
 <20201213115711.58733caa@archlinux>
 <d88226b8-74c6-0535-fc72-936f87463fb6@metafoo.de>
 <20201215182847.00001627@Huawei.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <88a76a94-e2ff-7b90-3c03-1a19790d8212@metafoo.de>
Date:   Wed, 16 Dec 2020 12:50:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201215182847.00001627@Huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26018/Tue Dec 15 15:37:09 2020)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 12/15/20 7:28 PM, Jonathan Cameron wrote:
> On Tue, 15 Dec 2020 16:49:19 +0100
> Lars-Peter Clausen <lars@metafoo.de> wrote:
>
>> On 12/13/20 12:57 PM, Jonathan Cameron wrote:
>>> On Fri, 11 Dec 2020 09:57:30 +0000
>>> Anand Ashok Dumbre <ANANDASH@xilinx.com> wrote:
>>>   
>>>>> -----Original Message-----
>>>>> From: Jonathan Cameron <jic23@kernel.org>
>>>>> Sent: Sunday 29 November 2020 1:15 PM
>>>>> To: Michal Simek <michals@xilinx.com>
>>>>> Cc: Lars-Peter Clausen <lars@metafoo.de>; Peter Meerwald-Stadler
>>>>> <pmeerw@pmeerw.net>; linux-iio@vger.kernel.org; Anand Ashok Dumbre
>>>>> <ANANDASH@xilinx.com>
>>>>> Subject: Re: [PATCH 2/2] iio: xilinx-xadc: Add basic support for Ultrascale
>>>>> System Monitor
>>>>>
>>>>> On Thu, 24 Sep 2020 08:08:31 +0200
>>>>> Michal Simek <michal.simek@xilinx.com> wrote:
>>>>>       
>>>>>> Hi, +Anand,
>>>>>>
>>>>>> On 23. 09. 20 22:47, Jonathan Cameron wrote:
>>>>>>> On Tue, 22 Sep 2020 15:46:24 +0200
>>>>>>> Lars-Peter Clausen <lars@metafoo.de> wrote:
>>>>>>>      
>>>>>>>> The xilinx-xadc IIO driver currently has support for the XADC in
>>>>>>>> the Xilinx
>>>>>>>> 7 series FPGAs. The system-monitor is the equivalent to the XADC in
>>>>>>>> the Xilinx UltraScale and UltraScale+ FPGAs.
>>>>>>>>
>>>>>>>> The IP designers did a good job at maintaining backwards
>>>>>>>> compatibility and only minor changes are required to add basic
>>>>>>>> support for the system-monitor core.
>>>>>>>>
>>>>>>>> The non backwards compatible changes are:
>>>>>>>>     * Register map offset was moved from 0x200 to 0x400
>>>>>>>>     * Only one ADC compared to two in the XADC
>>>>>>>>     * 10 bit ADC instead of 12 bit ADC
>>>>>>>>     * Two of the channels monitor different supplies
>>>>>>>>
>>>>>>>> Add the necessary logic to accommodate these changes to support the
>>>>>>>> system-monitor in the XADC driver.
>>>>>>>>
>>>>>>>> Note that this patch does not include support for some new features
>>>>>>>> found in the system-monitor like additional alarms, user supply
>>>>>>>> monitoring and secondary system-monitor access. This might be added
>>>>> at a later time.
>>>>>>>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>>>>>>> Very nice.  Will let this sit on the mailing list a bit longer but
>>>>>>> looks good to me.
>>>>>> FYI: I have asked Anand to take a look at it and retest.
>>>>>>
>>>>>> Thanks,
>>>>>> Michal
>>>>>>      
>>>>> Hi Michal / Anand,
>>>>>
>>>>> Any feedback on this one?
>>>>>
>>>>> Thanks
>>>>>
>>>>> Jonathan
>>>>>
>>>>> p.s. I'm just ploughing through my older emails and had this one marked as
>>>>> waiting for a reply.
>>>>>       
>>>> Hi Jonathan,
>>>>
>>>> Thanks for waiting.
>>>> The patch looks good.
>>>>
>>>> Reviewed-by: Anand Ashok Dumbre <anandash@xilinx.com>
>>>> Tested-by: Anand Ashok Dumbre <anandash@xilinx.com>
>>> Thanks. I've applied this but there was a bit of complexity around
>>> devm changes that went in whilst this was under review.
>>>
>>> I think I fixed it up correctly, but great if you can take
>>> a quick look to make sure I didn't mess it up.
>>> I'll try and put the other outstanding series in as well which
>>> will probably result in more fiddly corners during the merge.
>>>
>>> Applied to the togreg branch of iio.git and pushed out as testing
>>> or the autobuilders to see what we missed.
>>>   
>> Thanks Johnathan.
>>
>> I'm not seeing the patches in your public repository yet :)
> Doh. I may well have forgotten to push.  Will do so later today if so.

Looks good.

I did the conflict resolution myself and ended up with the same result, 
except slightly different (better ;)) indentation.

