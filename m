Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49612241366
	for <lists+linux-iio@lfdr.de>; Tue, 11 Aug 2020 00:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgHJWsR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 Aug 2020 18:48:17 -0400
Received: from vern.gendns.com ([98.142.107.122]:32830 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726775AbgHJWsR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 10 Aug 2020 18:48:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7BO2BV5ZL9NqupaOp8jHyF9nO1ZoO1djC1LGcXRvUvY=; b=RaEpa7qTSAHr/gGt2RlO6GMzlB
        I1P3WYliTKVqcaszmXdUAvTHxtBtLkg6jp5eKrRdsEKwDPrjL0lAeLNLxadiGlaT6J/7fFxaUz2v9
        imMr7dGIoiEOPRoGUTDUcciqR6RknkQsq2m7+NxNoPhozDIJmRRlO8Jx5Q/e7Y0+S8JIyrI38z2Kc
        hKwM3rsrXL+UB5UtCmtCL82UAPgGIk7LddfLH1vH35tXPmhPQOeLDCL8H3NBgoMBIJpcIjtoOQHME
        HB4mIErsOu2khipwarZw7AP9ShLXPFPm4VCBJijtntN02ZU3z+HGTb74TK25mhke9x2xN+4rO8Clc
        XnC39Oog==;
Received: from [2600:1700:4830:165f::19e] (port=45330)
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <david@lechnology.com>)
        id 1k5GaQ-0002v9-CL; Mon, 10 Aug 2020 18:48:10 -0400
Subject: Re: [PATCH v4 1/5] counter: Internalize sysfs interface code
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     jic23@kernel.org, kamel.bouhara@bootlin.com, gwendal@chromium.org,
        alexandre.belloni@bootlin.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        David.Laight@ACULAB.COM
References: <cover.1595358237.git.vilhelm.gray@gmail.com>
 <e13d43849f68af8227c6aaa0ef672b459d47e9ab.1595358237.git.vilhelm.gray@gmail.com>
 <7209ac3d-d1ca-1b4c-b22c-8d98b13742e2@lechnology.com>
 <20200802210415.GA606173@shinobu>
 <4061c9e4-775e-b7a6-14fa-446de4fae537@lechnology.com>
 <20200809191500.GC6542@shinobu>
From:   David Lechner <david@lechnology.com>
Message-ID: <ca6337f5-b28b-a19e-735c-3cd124570c27@lechnology.com>
Date:   Mon, 10 Aug 2020 17:48:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200809191500.GC6542@shinobu>
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


>>>>>     
>>>>>     CPMAC ETHERNET DRIVER
>>>>>     M:	Florian Fainelli <f.fainelli@gmail.com>
>>>>> diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
>>>>> index 78766b6ec271..0f20920073d6 100644
>>>>> --- a/drivers/counter/104-quad-8.c
>>>>> +++ b/drivers/counter/104-quad-8.c
>>>>> @@ -621,7 +621,7 @@ static const struct iio_chan_spec quad8_channels[] = {
>>>>>     };
>>>>>     
>>>>>     static int quad8_signal_read(struct counter_device *counter,
>>>>> -	struct counter_signal *signal, enum counter_signal_value *val)
>>>>> +			     struct counter_signal *signal, u8 *val)
>>>>
>>>> I'm not a fan of replacing enum types with u8 everywhere in this patch.
>>>> But if we have to for technical reasons (e.g. causes compiler error if
>>>> we don't) then it would be helpful to add comments giving the enum type
>>>> everywhere like this instance where u8 is actually an enum value.
>>>>
>>>> If we use u32 as the generic type for enums instead of u8, I think the
>>>> compiler will happlily let us use enum type and u32 interchangeably and
>>>> not complain.
>>>
>>> I switched to fixed-width types after the suggestion by David Laight:
>>> https://lkml.org/lkml/2020/5/3/159. I'll CC David Laight just in case he
>>> wants to chime in again.
>>>
>>> Enum types would be nice for making the valid values explicit, but there
>>> is one benefit I have appreciated from the move to fixed-width types:
>>> there has been a significant reduction of duplicate code; before, we had
>>> a different read function for each different enum type, but now we use a
>>> single function to handle them all.
>>
>> Yes, what I was trying to explain is that by using u32 instead of u8, I
>> think we can actually do both.
>>
>> The function pointers in struct counter_device *counter would use u32 as a
>> generic enum value in the declaration, but then the actual implementations
>> could still use the proper enum type.
> 
> Oh, I see what you mean now. So for example:
> 
>      int (*signal_read)(struct counter_device *counter,
>                         struct counter_signal *signal, u8 *val)
> 
> This will become instead:
> 
>      int (*signal_read)(struct counter_device *counter,
>                         struct counter_signal *signal, u32 *val)
> 
> Then in the driver callback implementation we use the enum type we need:
> 
>      enum counter_signal_level signal_level = COUNTER_SIGNAL_HIGH;
>      ...
>      *val = signal_level;
> 
> Is that what you have in mind?
> 

Yes.

Additionally, if we have...


       int (*x_write)(struct counter_device *counter,
                      ..., u32 val)
  
We should be able to define the implementation as:

static int my_driver_x_write(struct counter_device *counter,
                              ..., enum some_type val)
{
	...
}

Not sure if it works if val is a pointer though. Little-
endian systems would probably be fine, but maybe not big-
endian combined with -fshort-enums compiler flag.


       int (*x_read)(struct counter_device *counter,
                     ..., u32 *val)
  

static int my_driver_x_read(struct counter_device *counter,
                             ..., enum some_type *val)
{
	...
}

