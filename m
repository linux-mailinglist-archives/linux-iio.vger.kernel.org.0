Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 190C83E23BA
	for <lists+linux-iio@lfdr.de>; Fri,  6 Aug 2021 09:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243465AbhHFHJu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 6 Aug 2021 03:09:50 -0400
Received: from regular1.263xmail.com ([211.150.70.195]:36814 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242908AbhHFHJt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 6 Aug 2021 03:09:49 -0400
Received: from localhost (unknown [192.168.167.13])
        by regular1.263xmail.com (Postfix) with ESMTP id 202D91CDF;
        Fri,  6 Aug 2021 15:09:26 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from [172.16.12.8] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P22194T140002758489856S1628233765777467_;
        Fri, 06 Aug 2021 15:09:26 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <ee26124f85b846229d6d28b4186f93ec>
X-RL-SENDER: david.wu@rock-chips.com
X-SENDER: wdc@rock-chips.com
X-LOGIN-NAME: david.wu@rock-chips.com
X-FST-TO: linux-iio@vger.kernel.org
X-RCPT-COUNT: 11
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
Subject: Re: [PATCH] iio: adc: rockchip_saradc: just get referenced voltage
 once at probe
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Simon Xue <xxm@rock-chips.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, Johan Jonker <jbx6244@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
References: <20210802090929.37970-1-xxm@rock-chips.com>
 <20210803135124.000072fe@Huawei.com>
 <8f5385a1-701c-4446-d238-90bee1c03675@rock-chips.com>
 <8912224.VV5PYv0bhD@diego>
From:   David Wu <david.wu@rock-chips.com>
Message-ID: <51525056-ee43-1880-5a5b-547decd904f4@rock-chips.com>
Date:   Fri, 6 Aug 2021 15:09:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <8912224.VV5PYv0bhD@diego>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Heiko, Jonathan

we are adding the notifier for this patch, indeed for future consideration.

Thanks.

在 2021/8/5 下午8:07, Heiko Stübner 写道:
> Hi David,
> 
> Am Donnerstag, 5. August 2021, 13:56:18 CEST schrieb David Wu:
>> Hi Jonathan,
>>
>> 在 2021/8/3 下午8:51, Jonathan Cameron 写道:
>>> On Tue, 3 Aug 2021 11:09:47 +0800
>>> David Wu <david.wu@rock-chips.com> wrote:
>>>
>>>> Hi Jonathan,
>>>>
>>>> 在 2021/8/2 下午6:42, Jonathan Cameron 写道:
>>>>> On Mon, 2 Aug 2021 17:09:29 +0800
>>>>> Simon Xue <xxm@rock-chips.com> wrote:
>>>>>     
>>>>>> From: David Wu <david.wu@rock-chips.com>
>>>>>>
>>>>>> The referenced voltage is not changed after initiation, so just only
>>>>>> get referenced voltage once.
>>>>> Hi David,
>>>>>
>>>>> Isn't this an external reference voltage?  If so how do you know
>>>>> it is not changed at runtime?  It might be unlikely and not happen
>>>>> on particular platforms, but that's not he same as saying it can never
>>>>> happen.  Clearly it's racey anyway if that does happen, but we definitely
>>>>> don't expect frequent voltage changes.
>>>>>     
>>>>
>>>> The current regulator is not changed and not subject to external
>>>> changes, this can reduce the getting voltage. Assuming that there will
>>>> be changes in the future, we then add the notify of the regulator, so
>>>> that the voltage change can be obtained.
>>>
>>> If this patch added the notifier that would be a nice solution, but
>>> right now it potentially introduced a regression. You have made me a little curious...
>>> Are you seeing a significant cost to querying that regulator voltage?
>>> If so, I'd imagine it's a lack of caching in the regulator driver or similar.
>>> Scale readback via sysfs shouldn't be in a fast path anyway.
>>>
>>> You can't depend on what boards today do, because someone with a board
>>> built tomorrow may well use an old kernel which supports the voltage
>>> changing, and then see a regression when they upgrade to the kernel
>>> containing this patch.
>>>
>>
>> For all current chips, the expected voltage is a fixed voltage, and
>> don't want to change it in any process.:-)
>>
>> So, if the voltage here does not change, then it can be obtained once in
>> probe(), which can save the time of each acquisition. For example, the
>> voltage of this regulator is obtained through i2c, which will increase
>> some consumption every time.
> 
> Jonathans request was to not think about "all current chips" but the
> general case, and as Jonathan said, adding that regulator notifier you
> already mentioned would be the nicest solution.
> 
> So I think the easiest way is to just add the voltage notifier to your patch
> to make everyone happy ;-) .
> 
> 
> Heiko
> 
>>
>>> Jonathan
>>>
>>>>
>>>>> Jonathan
>>>>>     
>>>>>>
>>>>>> Signed-off-by: Simon Xue <xxm@rock-chips.com>
>>>>>> Signed-off-by: David Wu <david.wu@rock-chips.com>
>>>>>> ---
>>>>>>     drivers/iio/adc/rockchip_saradc.c | 16 +++++++++-------
>>>>>>     1 file changed, 9 insertions(+), 7 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
>>>>>> index f3eb8d2e50dc..cd33c0b9d3eb 100644
>>>>>> --- a/drivers/iio/adc/rockchip_saradc.c
>>>>>> +++ b/drivers/iio/adc/rockchip_saradc.c
>>>>>> @@ -49,6 +49,7 @@ struct rockchip_saradc {
>>>>>>     	struct clk		*clk;
>>>>>>     	struct completion	completion;
>>>>>>     	struct regulator	*vref;
>>>>>> +	int			uv_vref;
>>>>>>     	struct reset_control	*reset;
>>>>>>     	const struct rockchip_saradc_data *data;
>>>>>>     	u16			last_val;
>>>>>> @@ -105,13 +106,7 @@ static int rockchip_saradc_read_raw(struct iio_dev *indio_dev,
>>>>>>     		mutex_unlock(&indio_dev->mlock);
>>>>>>     		return IIO_VAL_INT;
>>>>>>     	case IIO_CHAN_INFO_SCALE:
>>>>>> -		ret = regulator_get_voltage(info->vref);
>>>>>> -		if (ret < 0) {
>>>>>> -			dev_err(&indio_dev->dev, "failed to get voltage\n");
>>>>>> -			return ret;
>>>>>> -		}
>>>>>> -
>>>>>> -		*val = ret / 1000;
>>>>>> +		*val = info->uv_vref / 1000;
>>>>>>     		*val2 = chan->scan_type.realbits;
>>>>>>     		return IIO_VAL_FRACTIONAL_LOG2;
>>>>>>     	default:
>>>>>> @@ -410,6 +405,13 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
>>>>>>     		return ret;
>>>>>>     	}
>>>>>>     
>>>>>> +	info->uv_vref = regulator_get_voltage(info->vref);
>>>>>> +	if (info->uv_vref < 0) {
>>>>>> +		dev_err(&pdev->dev, "failed to get voltage\n");
>>>>>> +		ret = info->uv_vref;
>>>>>> +		return ret;
>>>>>> +	}
>>>>>> +
>>>>>>     	ret = clk_prepare_enable(info->pclk);
>>>>>>     	if (ret < 0) {
>>>>>>     		dev_err(&pdev->dev, "failed to enable pclk\n");
>>>>>
>>>>>
>>>>>
>>>>>     
>>>>
>>>>
>>>
>>>
>>>
>>>
>>
>>
>>
> 
> 
> 
> 
> 
> 
> 


