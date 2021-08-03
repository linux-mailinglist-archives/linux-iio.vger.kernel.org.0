Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A4A3DE4A4
	for <lists+linux-iio@lfdr.de>; Tue,  3 Aug 2021 05:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233478AbhHCDSO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Aug 2021 23:18:14 -0400
Received: from regular1.263xmail.com ([211.150.70.205]:41550 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbhHCDSN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Aug 2021 23:18:13 -0400
X-Greylist: delayed 487 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Aug 2021 23:18:12 EDT
Received: from localhost (unknown [192.168.167.70])
        by regular1.263xmail.com (Postfix) with ESMTP id B2FEA947;
        Tue,  3 Aug 2021 11:09:48 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from [172.16.12.8] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P4991T139770963339008S1627960187187438_;
        Tue, 03 Aug 2021 11:09:47 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <65d4135603dfef771ba2a7a9f4dcf93d>
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
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Simon Xue <xxm@rock-chips.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, Johan Jonker <jbx6244@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
References: <20210802090929.37970-1-xxm@rock-chips.com>
 <20210802114222.00004f3d@Huawei.com>
From:   David Wu <david.wu@rock-chips.com>
Message-ID: <36f6284f-6bc9-d5a4-aac8-5db8b1ecaae1@rock-chips.com>
Date:   Tue, 3 Aug 2021 11:09:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210802114222.00004f3d@Huawei.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

ÔÚ 2021/8/2 ÏÂÎç6:42, Jonathan Cameron Ð´µÀ:
> On Mon, 2 Aug 2021 17:09:29 +0800
> Simon Xue <xxm@rock-chips.com> wrote:
> 
>> From: David Wu <david.wu@rock-chips.com>
>>
>> The referenced voltage is not changed after initiation, so just only
>> get referenced voltage once.
> Hi David,
> 
> Isn't this an external reference voltage?  If so how do you know
> it is not changed at runtime?  It might be unlikely and not happen
> on particular platforms, but that's not he same as saying it can never
> happen.  Clearly it's racey anyway if that does happen, but we definitely
> don't expect frequent voltage changes.
> 

The current regulator is not changed and not subject to external 
changes, this can reduce the getting voltage. Assuming that there will 
be changes in the future, we then add the notify of the regulator, so 
that the voltage change can be obtained.

> Jonathan
> 
>>
>> Signed-off-by: Simon Xue <xxm@rock-chips.com>
>> Signed-off-by: David Wu <david.wu@rock-chips.com>
>> ---
>>   drivers/iio/adc/rockchip_saradc.c | 16 +++++++++-------
>>   1 file changed, 9 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
>> index f3eb8d2e50dc..cd33c0b9d3eb 100644
>> --- a/drivers/iio/adc/rockchip_saradc.c
>> +++ b/drivers/iio/adc/rockchip_saradc.c
>> @@ -49,6 +49,7 @@ struct rockchip_saradc {
>>   	struct clk		*clk;
>>   	struct completion	completion;
>>   	struct regulator	*vref;
>> +	int			uv_vref;
>>   	struct reset_control	*reset;
>>   	const struct rockchip_saradc_data *data;
>>   	u16			last_val;
>> @@ -105,13 +106,7 @@ static int rockchip_saradc_read_raw(struct iio_dev *indio_dev,
>>   		mutex_unlock(&indio_dev->mlock);
>>   		return IIO_VAL_INT;
>>   	case IIO_CHAN_INFO_SCALE:
>> -		ret = regulator_get_voltage(info->vref);
>> -		if (ret < 0) {
>> -			dev_err(&indio_dev->dev, "failed to get voltage\n");
>> -			return ret;
>> -		}
>> -
>> -		*val = ret / 1000;
>> +		*val = info->uv_vref / 1000;
>>   		*val2 = chan->scan_type.realbits;
>>   		return IIO_VAL_FRACTIONAL_LOG2;
>>   	default:
>> @@ -410,6 +405,13 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
>>   		return ret;
>>   	}
>>   
>> +	info->uv_vref = regulator_get_voltage(info->vref);
>> +	if (info->uv_vref < 0) {
>> +		dev_err(&pdev->dev, "failed to get voltage\n");
>> +		ret = info->uv_vref;
>> +		return ret;
>> +	}
>> +
>>   	ret = clk_prepare_enable(info->pclk);
>>   	if (ret < 0) {
>>   		dev_err(&pdev->dev, "failed to enable pclk\n");
> 
> 
> 
> 


