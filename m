Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFAB72B172E
	for <lists+linux-iio@lfdr.de>; Fri, 13 Nov 2020 09:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgKMI1Y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Nov 2020 03:27:24 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:43216 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725866AbgKMI1Y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Nov 2020 03:27:24 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AD8RCT7028783;
        Fri, 13 Nov 2020 09:27:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=ofrXjoO1UDhDTqrPQH8FB+yGKCEcamxbT6TXyX1/+70=;
 b=DR76wqlWXhLbdLq2CtcFaDAMzJD/eNZFyZyO5rUT876cgeCZ+Tq2G/iONC9yxQXQTYZX
 fiHYEFPNbuztxPTyYbZkzDCzn8YOSrCaHwEOY0iGKadei9mUm7QDxukhoWaNPHRJ19Ss
 60CAdl0hdceVRb+pVLTVDegHCm+ZDbu332fW25sWdD63bQCDKU4Z2NWy/+bbYOwGv4Sd
 y3jEPEPYMxs/xI37qfZnjjcmV2MPGKxF9Bhm+FKcQanK4jasXEDqAO4MPcpEeNnzd/G1
 G1FEwz8z5g09GQn+ydgOBKkA1ibtNxXJlajS+5NkMo6v4V+YBjeTLfKfEERGruIqBL48 LA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34nkbnjc2b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Nov 2020 09:27:12 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C4314100034;
        Fri, 13 Nov 2020 09:27:06 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag1node3.st.com [10.75.127.3])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AB66A22A4C0;
        Fri, 13 Nov 2020 09:27:06 +0100 (CET)
Received: from [10.211.4.198] (10.75.127.47) by SFHDAG1NODE3.st.com
 (10.75.127.3) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 13 Nov
 2020 09:27:05 +0100
Subject: Re: [PATCH] iio: adc: stm32-adc: adapt clock duty cycle for proper
 operation
To:     Jonathan Cameron <jic23@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <alexandre.torgue@st.com>,
        <olivier.moysan@st.com>, <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <1604681846-31234-1-git-send-email-fabrice.gasnier@st.com>
 <20201108151835.5d78ebca@archlinux>
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <0d7c4b81-3f4e-e952-892f-35296c87f987@st.com>
Date:   Fri, 13 Nov 2020 09:27:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201108151835.5d78ebca@archlinux>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG1NODE3.st.com
 (10.75.127.3)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-13_05:2020-11-12,2020-11-13 signatures=0
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 11/8/20 4:18 PM, Jonathan Cameron wrote:
> On Fri, 6 Nov 2020 17:57:26 +0100
> Fabrice Gasnier <fabrice.gasnier@st.com> wrote:
> 
>> For proper operation, STM32 ADC should be used with a clock duty cycle
>> of 50%, in the range of 49% to 51%. Depending on the clock tree, divider
>> can be used in case clock duty cycle is out of this range.
>> In case clk_get_scaled_duty_cycle() returns an error, kindly apply a
>> divider by default (don't make the probe fail).
>>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> Hi Fabrice,
> 
> This sounds like it's a fix for a situation in which the device is not
> currently working?  If so, please let me know a fixes tag.

Hi Jonathan,

That's a good point. I also thought about adding a fixes tag. Currently
I think this can't be hit upstream, as clock tree is tuned to fit duty
cycle constraints. So far, nobody seems to complain about it. So this
can probably go through the normal tree.

Thanks,
Fabrice

> 
> Thanks,
> 
> Jonathan
> 
>> ---
>>  drivers/iio/adc/stm32-adc-core.c | 21 ++++++++++++++++++++-
>>  1 file changed, 20 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
>> index cd870c0..d64a9e8 100644
>> --- a/drivers/iio/adc/stm32-adc-core.c
>> +++ b/drivers/iio/adc/stm32-adc-core.c
>> @@ -202,7 +202,7 @@ static int stm32h7_adc_clk_sel(struct platform_device *pdev,
>>  {
>>  	u32 ckmode, presc, val;
>>  	unsigned long rate;
>> -	int i, div;
>> +	int i, div, duty;
>>  
>>  	/* stm32h7 bus clock is common for all ADC instances (mandatory) */
>>  	if (!priv->bclk) {
>> @@ -226,6 +226,11 @@ static int stm32h7_adc_clk_sel(struct platform_device *pdev,
>>  			return -EINVAL;
>>  		}
>>  
>> +		/* If duty is an error, kindly use at least /2 divider */
>> +		duty = clk_get_scaled_duty_cycle(priv->aclk, 100);
>> +		if (duty < 0)
>> +			dev_warn(&pdev->dev, "adc clock duty: %d\n", duty);
>> +
>>  		for (i = 0; i < ARRAY_SIZE(stm32h7_adc_ckmodes_spec); i++) {
>>  			ckmode = stm32h7_adc_ckmodes_spec[i].ckmode;
>>  			presc = stm32h7_adc_ckmodes_spec[i].presc;
>> @@ -234,6 +239,13 @@ static int stm32h7_adc_clk_sel(struct platform_device *pdev,
>>  			if (ckmode)
>>  				continue;
>>  
>> +			/*
>> +			 * For proper operation, clock duty cycle range is 49%
>> +			 * to 51%. Apply at least /2 prescaler otherwise.
>> +			 */
>> +			if (div == 1 && (duty < 49 || duty > 51))
>> +				continue;
>> +
>>  			if ((rate / div) <= priv->max_clk_rate)
>>  				goto out;
>>  		}
>> @@ -246,6 +258,10 @@ static int stm32h7_adc_clk_sel(struct platform_device *pdev,
>>  		return -EINVAL;
>>  	}
>>  
>> +	duty = clk_get_scaled_duty_cycle(priv->bclk, 100);
>> +	if (duty < 0)
>> +		dev_warn(&pdev->dev, "bus clock duty: %d\n", duty);
>> +
>>  	for (i = 0; i < ARRAY_SIZE(stm32h7_adc_ckmodes_spec); i++) {
>>  		ckmode = stm32h7_adc_ckmodes_spec[i].ckmode;
>>  		presc = stm32h7_adc_ckmodes_spec[i].presc;
>> @@ -254,6 +270,9 @@ static int stm32h7_adc_clk_sel(struct platform_device *pdev,
>>  		if (!ckmode)
>>  			continue;
>>  
>> +		if (div == 1 && (duty < 49 || duty > 51))
>> +			continue;
>> +
>>  		if ((rate / div) <= priv->max_clk_rate)
>>  			goto out;
>>  	}
> 
