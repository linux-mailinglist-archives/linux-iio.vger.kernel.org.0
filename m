Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF76158CF9
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2020 11:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgBKKyc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 Feb 2020 05:54:32 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:59962 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727805AbgBKKyc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 Feb 2020 05:54:32 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01BAsJ9H020617;
        Tue, 11 Feb 2020 11:54:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=3tZrMwq3KMFaha6QMKj6OAVuMaZdKt4Qxfei8VIdqCw=;
 b=lnQN5ykes8V1oOQcykxeRxvSyDAMBqI2jw5meWEigZ1367afXhoyp6Rpdmttuw0KS7DA
 ZHu9sPGcyysN9k5TyygkHknSvIvz/LD4mVYjFgrU3D/7aKnzOkxxqmSn/DHV7+vQPVsY
 C5K+rI1ye4ffeIzir/lsc17Urrx9EaB58wqGJ8iLpI5A8DL1vsAkGyARNBAgUhQ+82fc
 c0bZ7sv9T1Cfc9L+mOg1DCFcPJl4BSYSs7ZRkNidaHC4Kmz0ZlOCvQppQ+N8OgbcBnu+
 kZSUpuM0IsVosV1xqkshqlU1r6+UpBnIU/mM08uuXK6i0q/zmsL63SAymGsyJjeBmWN5 eQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2y1ufh3epf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Feb 2020 11:54:20 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 81911100050;
        Tue, 11 Feb 2020 11:54:18 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 72A2F2AEAAB;
        Tue, 11 Feb 2020 11:54:18 +0100 (CET)
Received: from [10.48.0.71] (10.75.127.44) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 11 Feb
 2020 11:54:17 +0100
Subject: Re: [PATCH v2] counter: stm32-timer-cnt: add power management support
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
CC:     <jic23@kernel.org>, <alexandre.torgue@st.com>,
        <mcoquelin.stm32@gmail.com>, <benjamin.gaignard@st.com>,
        <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1581355198-30428-1-git-send-email-fabrice.gasnier@st.com>
 <20200210174550.GA4626@icarus>
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <b1e2930a-eeaf-dcfe-3e2c-b666908262bf@st.com>
Date:   Tue, 11 Feb 2020 11:54:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200210174550.GA4626@icarus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-11_03:2020-02-10,2020-02-11 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2/10/20 6:45 PM, William Breathitt Gray wrote:
> On Mon, Feb 10, 2020 at 06:19:58PM +0100, Fabrice Gasnier wrote:
>> Add suspend/resume PM sleep ops. When going to low power, enforce the
>> counter isn't active. Gracefully restore its state upon resume in case
>> it's been left enabled prior to suspend.
>>
>> Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>> ---
>> Changes in v2:
>> - Don't refuse to suspend in case the counter has been left enabled.
>>   Gracefully disable it and restore its state upon resume.
>> ---
>>  drivers/counter/stm32-timer-cnt.c | 63 +++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 63 insertions(+)
>>
>> diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
>> index 3eafcce..50496f4 100644
>> --- a/drivers/counter/stm32-timer-cnt.c
>> +++ b/drivers/counter/stm32-timer-cnt.c
>> @@ -12,6 +12,7 @@
>>  #include <linux/iio/types.h>
> 
> Unrelated to your patch but it caught my eye: are iio headers necessary
> for this file? I suspect they are not needed since this driver does not
> make use of the IIO interface.

Hi William,

Yes, you're right. Thanks for pointing this!
I'll push a patch on top of this one to fix it. BTW, I'm not sure if
this needs to be a marked as a fix, as this seems a quite minor issue?

Best Regards,
Fabrice

> 
> William Breathitt Gray
> 
>>  #include <linux/mfd/stm32-timers.h>
>>  #include <linux/module.h>
>> +#include <linux/pinctrl/consumer.h>
>>  #include <linux/platform_device.h>
>>  
>>  #define TIM_CCMR_CCXS	(BIT(8) | BIT(0))
>> @@ -20,11 +21,20 @@
>>  #define TIM_CCER_MASK	(TIM_CCER_CC1P | TIM_CCER_CC1NP | \
>>  			 TIM_CCER_CC2P | TIM_CCER_CC2NP)
>>  
>> +struct stm32_timer_regs {
>> +	u32 cr1;
>> +	u32 cnt;
>> +	u32 smcr;
>> +	u32 arr;
>> +};
>> +
>>  struct stm32_timer_cnt {
>>  	struct counter_device counter;
>>  	struct regmap *regmap;
>>  	struct clk *clk;
>>  	u32 ceiling;
>> +	bool enabled;
>> +	struct stm32_timer_regs bak;
>>  };
>>  
>>  /**
>> @@ -224,6 +234,9 @@ static ssize_t stm32_count_enable_write(struct counter_device *counter,
>>  			clk_disable(priv->clk);
>>  	}
>>  
>> +	/* Keep enabled state to properly handle low power states */
>> +	priv->enabled = enable;
>> +
>>  	return len;
>>  }
>>  
>> @@ -358,10 +371,59 @@ static int stm32_timer_cnt_probe(struct platform_device *pdev)
>>  	priv->counter.num_signals = ARRAY_SIZE(stm32_signals);
>>  	priv->counter.priv = priv;
>>  
>> +	platform_set_drvdata(pdev, priv);
>> +
>>  	/* Register Counter device */
>>  	return devm_counter_register(dev, &priv->counter);
>>  }
>>  
>> +static int __maybe_unused stm32_timer_cnt_suspend(struct device *dev)
>> +{
>> +	struct stm32_timer_cnt *priv = dev_get_drvdata(dev);
>> +
>> +	/* Only take care of enabled counter: don't disturb other MFD child */
>> +	if (priv->enabled) {
>> +		/* Backup registers that may get lost in low power mode */
>> +		regmap_read(priv->regmap, TIM_SMCR, &priv->bak.smcr);
>> +		regmap_read(priv->regmap, TIM_ARR, &priv->bak.arr);
>> +		regmap_read(priv->regmap, TIM_CNT, &priv->bak.cnt);
>> +		regmap_read(priv->regmap, TIM_CR1, &priv->bak.cr1);
>> +
>> +		/* Disable the counter */
>> +		regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN, 0);
>> +		clk_disable(priv->clk);
>> +	}
>> +
>> +	return pinctrl_pm_select_sleep_state(dev);
>> +}
>> +
>> +static int __maybe_unused stm32_timer_cnt_resume(struct device *dev)
>> +{
>> +	struct stm32_timer_cnt *priv = dev_get_drvdata(dev);
>> +	int ret;
>> +
>> +	ret = pinctrl_pm_select_default_state(dev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (priv->enabled) {
>> +		clk_enable(priv->clk);
>> +
>> +		/* Restore registers that may have been lost */
>> +		regmap_write(priv->regmap, TIM_SMCR, priv->bak.smcr);
>> +		regmap_write(priv->regmap, TIM_ARR, priv->bak.arr);
>> +		regmap_write(priv->regmap, TIM_CNT, priv->bak.cnt);
>> +
>> +		/* Also re-enables the counter */
>> +		regmap_write(priv->regmap, TIM_CR1, priv->bak.cr1);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static SIMPLE_DEV_PM_OPS(stm32_timer_cnt_pm_ops, stm32_timer_cnt_suspend,
>> +			 stm32_timer_cnt_resume);
>> +
>>  static const struct of_device_id stm32_timer_cnt_of_match[] = {
>>  	{ .compatible = "st,stm32-timer-counter", },
>>  	{},
>> @@ -373,6 +435,7 @@ static struct platform_driver stm32_timer_cnt_driver = {
>>  	.driver = {
>>  		.name = "stm32-timer-counter",
>>  		.of_match_table = stm32_timer_cnt_of_match,
>> +		.pm = &stm32_timer_cnt_pm_ops,
>>  	},
>>  };
>>  module_platform_driver(stm32_timer_cnt_driver);
>> -- 
>> 2.7.4
>>
