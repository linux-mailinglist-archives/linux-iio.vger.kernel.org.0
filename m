Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 134DB18A0C8
	for <lists+linux-iio@lfdr.de>; Wed, 18 Mar 2020 17:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgCRQoa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Mar 2020 12:44:30 -0400
Received: from www381.your-server.de ([78.46.137.84]:52246 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbgCRQoa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Mar 2020 12:44:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=J8oaMn2D6R8qhHn5/7llhq+Rt7dLLihFYSkeYHC/Pac=; b=NKCWIJQS4Ce0dd4pxbsc7fpI35
        nROzI0wk3K0sjbqnOqIiNloJ0YHqjeFkk3YW2NUlhHx+nzhtrAFIiNAPbnw28xBQcPLLVkj/YH/OW
        X/47cvnmofFeK5Dib65+1hUZZsqSofBb3nent5+o3r6HxfsNHDSGrT+vGR/ZhAMqzttbtxo3LKG/u
        imPgztZLN5hSjZYgL81ah/xUZkefXqXIBoC6ArmPmnZMVTdQVoYEjAtS8L9IM7/qPC3UHHsEDidtw
        7JvIgqJJ7d7Pwl7hYHfg6+u20ntfadpQF2Mzc4SEKdG+ZBvCCNmfSB4PLI5b7pp42tRus1ad+Iqki
        4fnxSv6Q==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jEbnn-0001Nm-9b; Wed, 18 Mar 2020 17:44:19 +0100
Received: from [93.104.115.49] (helo=[192.168.178.20])
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jEbnm-000HWC-U8; Wed, 18 Mar 2020 17:44:19 +0100
Subject: Re: [Outreachy kernel] [PATCH 1/2] staging: iio: adc: ad7192:
 Reformat lines crossing 80 columns
To:     DEEPAK VARMA <mh12gx2825@gmail.com>,
        Rohit Sarkar <rohitsarkar5398@gmail.com>
Cc:     Stefano Brivio <sbrivio@redhat.com>,
        outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        daniel.baluta@gmail.com, kieran.bingham@ideasonboard.com,
        Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org
References: <cover.1584505215.git.mh12gx2825@gmail.com>
 <50419988d636c90511a07da256c91aa3b3e33bff.1584505215.git.mh12gx2825@gmail.com>
 <20200318093158.192a27ce@elisabeth> <20200318160649.GA23154@deeUbuntu>
 <5e724ad5.1c69fb81.7d54e.9f63@mx.google.com>
 <20200318164306.GA23434@deeUbuntu>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <1fe9df37-4d83-82e6-bd57-ecb4195447a5@metafoo.de>
Date:   Wed, 18 Mar 2020 17:44:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200318164306.GA23434@deeUbuntu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25755/Wed Mar 18 14:14:00 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/18/20 5:43 PM, DEEPAK VARMA wrote:
> On Wed, Mar 18, 2020 at 09:52:41PM +0530, Rohit Sarkar wrote:
>> On Wed, Mar 18, 2020 at 09:36:50PM +0530, DEEPAK VARMA wrote:
>>> On Wed, Mar 18, 2020 at 09:31:58AM +0100, Stefano Brivio wrote:
>>>> On Wed, 18 Mar 2020 09:56:59 +0530
>>>> Deepak R Varma <mh12gx2825@gmail.com> wrote:
>>>>
>>>>> Macro arguments are computed at the time of macro invocation. This makes
>>>>> the lines cross 80 column width. Add variables to perform the
>>>>> calculations before hand and use these new variable in the macro calls
>>>>> instead.
>>>>>
>>>>> Also re-indent enum members to address checkpatch warning / check messages.
>>>>>
>>>>> Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
>>>>> ---
>>>>>   drivers/staging/iio/adc/ad7192.c | 15 ++++++++-------
>>>>>   1 file changed, 8 insertions(+), 7 deletions(-)
>>>>>
>>>>> diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
>>>>> index bf3e2a9cc07f..0265f6607d75 100644
>>>>> --- a/drivers/staging/iio/adc/ad7192.c
>>>>> +++ b/drivers/staging/iio/adc/ad7192.c
>>>>> @@ -156,8 +156,8 @@
>>>>>    */
>>>>>   
>>>>>   enum {
>>>>> -   AD7192_SYSCALIB_ZERO_SCALE,
>>>>> -   AD7192_SYSCALIB_FULL_SCALE,
>>>>> +	AD7192_SYSCALIB_ZERO_SCALE,
>>>>> +	AD7192_SYSCALIB_FULL_SCALE,
>>>>>   };
>>>>>   
>>>>>   struct ad7192_state {
>>>>> @@ -477,17 +477,18 @@ static ssize_t ad7192_set(struct device *dev,
>>>>>   }
>>>>>   
>>>>>   static void ad7192_get_available_filter_freq(struct ad7192_state *st,
>>>>> -						    int *freq)
>>>>> +					     int *freq)
>>>>>   {
>>>>>   	unsigned int fadc;
>>>>> +	unsigned int sync3_filter, sync4_filter;
>>>>>   
>>>>>   	/* Formulas for filter at page 25 of the datasheet */
>>>>> -	fadc = DIV_ROUND_CLOSEST(st->fclk,
>>>>> -				 AD7192_SYNC4_FILTER * AD7192_MODE_RATE(st->mode));
>>>>> +	sync4_filter = AD7192_SYNC4_FILTER * AD7192_MODE_RATE(st->mode);
>>>>
>>>> Have you read page 25 of the datasheet? Why is this called
>>>> sync4_filter, with a 'y'?
>>>>
>>>
>>> Sorry, I am not sure what you are referring to. Can you please elaborate
>>> or point me to where the data sheet is located?
>>>
>>> Deepak.
>>
>> Hey Deepak,
>> You can find the datasheet for ad7192 here https://pdf1.alldatasheet.com/datasheet-pdf/view/988287/AD/AD7192.html
>>
> 
> Thank you Rohit. I got it. I understand Stefano's comments now. I named
> the variables with a 'y' to keep it similar to the macro
> AD7192_SYNCn_FILTER. Let me know if the variable name looks odd and I
> should rename it to sinc4_filter instead.

Hi,

Please send a patch to rename the macro to SINC as well. This is a typo 
in the macro.

Thanks,
- Lars
