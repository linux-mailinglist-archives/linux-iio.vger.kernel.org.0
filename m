Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C537D3DD4EC
	for <lists+linux-iio@lfdr.de>; Mon,  2 Aug 2021 13:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233382AbhHBLum (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Aug 2021 07:50:42 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:53733 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbhHBLum (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Aug 2021 07:50:42 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.1]) by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee46107dbfb815-e82da; Mon, 02 Aug 2021 19:50:19 +0800 (CST)
X-RM-TRANSID: 2ee46107dbfb815-e82da
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [192.168.26.114] (unknown[10.42.68.12])
        by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee16107dbfa6a5-cb19a;
        Mon, 02 Aug 2021 19:50:19 +0800 (CST)
X-RM-TRANSID: 2ee16107dbfa6a5-cb19a
Subject: Re: [PATCH] iio: adc: fsl-imx25-gcq: fix the right check andsimplify
 code
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, knaack.h@gmx.de,
        lars@metafoo.de, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210727125209.28248-1-tangbin@cmss.chinamobile.com>
 <20210731174551.188aee79@jic23-huawei>
 <b84ea3e4-5650-d6ac-36f6-98067b286b45@cmss.chinamobile.com>
 <20210802111647.000012ee@Huawei.com>
From:   tangbin <tangbin@cmss.chinamobile.com>
Message-ID: <d1e08b62-37dd-b1e2-2cf5-baa03ccb16f2@cmss.chinamobile.com>
Date:   Mon, 2 Aug 2021 19:50:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20210802111647.000012ee@Huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan:

On 2021/8/2 18:16, Jonathan Cameron wrote:
> On Mon, 2 Aug 2021 10:31:58 +0800
> tangbin <tangbin@cmss.chinamobile.com> wrote:
>
>> Hi Jonathan:
>>
>> On 2021/8/1 0:45, Jonathan Cameron wrote:
>>> On Tue, 27 Jul 2021 20:52:09 +0800
>>> Tang Bin <tangbin@cmss.chinamobile.com> wrote:
>>>   
>>>> For the function of platform_get_irq(), the example in platform.c is
>>>> *		int irq = platform_get_irq(pdev, 0);
>>>> *		if (irq < 0)
>>>> *			return irq;
>>>> So the return value of zero is unnecessary to check. And move it
>>>> up to a little bit can simplify the code jump.
>>>>
>>>> Co-developed-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
>>>> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
>>>> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
>>> Hi,
>>>
>>> Logically it is better to keep the irq handling all together, so
>>> I would prefer we didn't move it.
>> Got it in this place.
>>> Also, platform_get_irq() is documented as never returning 0, so the current
>>> code is not incorrect.  As such, this looks like noise unless there is
>>> some plan to make use of the 0 return value?  What benefit do we get from
>>> this change?
>> Thanks for your reply, I think the benefit of this change maybe just
>> simplify the code.
>>
>> Because the return value is never equal to 0, so the check in here is
>> redundant.
>>
>> We can make the patch like this:
>>
>>>> ---
>>>>    drivers/iio/adc/fsl-imx25-gcq.c | 12 ++++--------
>>>>    1 file changed, 4 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/drivers/iio/adc/fsl-imx25-gcq.c b/drivers/iio/adc/fsl-imx25-gcq.c
>>>> index 8cb51cf7a..d28976f21 100644
>>>> --- a/drivers/iio/adc/fsl-imx25-gcq.c
>>>> +++ b/drivers/iio/adc/fsl-imx25-gcq.c
>>>> @@ -320,6 +320,10 @@ static int mx25_gcq_probe(struct platform_device *pdev)
>>>>    	if (ret)
>>>>    		return ret;
>>>>    
>>>> +	priv->irq = platform_get_irq(pdev, 0);
>>>> +	if (priv->irq < 0)
>>>> +		return priv->irq;
>>>> +
>>>>    	for (i = 0; i != 4; ++i) {
>>>>    		if (!priv->vref[i])
>>>>    			continue;
>>>> @@ -336,14 +340,6 @@ static int mx25_gcq_probe(struct platform_device *pdev)
>>>>    		goto err_vref_disable;
>>>>    	}
>>>>    
>>>> -	priv->irq = platform_get_irq(pdev, 0);
>>>> -	if (priv->irq <= 0) {
>>>> -		ret = priv->irq;
>>>> -		if (!ret)
>>>> -			ret = -ENXIO;
>>>> -		goto err_clk_unprepare;
>>>> -	}
>>>> -
>> 	priv->irq = platform_get_irq(pdev, 0);
>> 	if (priv->irq < 0) {
>> 		ret = priv->irq;
>> 		goto err_clk_unprepare;
>> 	}
>>
>>       If you think this is ok, I will send V2 for you. If you think these
>> change is meaningless,
> OK, it's a minor tidy up, so lets go with that, or perhaps this is even tidier?
> Assuming types of ret and irq are appropriate (I've not checked!)
>
>
> 	ret = platform_get_irq(pdev, 0);
> 	if (ret)
> 		goto err_clk_unprepare;
>
> 	priv->irq = ret;
>
Thanks for your reply, ret or irq or priv->irq are all appropriate, and 
the changes of mine maybe traditional.

I will send v2 for you like your changes.

Thank you very much.

Tang Bin


>> just dropped this.
>>
>> Thanks
>>
>> Tang Bin
>>
>>
>>
>>


