Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3C978937E
	for <lists+linux-iio@lfdr.de>; Sat, 26 Aug 2023 04:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbjHZCiQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Aug 2023 22:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbjHZCho (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 25 Aug 2023 22:37:44 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C47E58
        for <linux-iio@vger.kernel.org>; Fri, 25 Aug 2023 19:37:42 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RXgsM6NjTzVk3H;
        Sat, 26 Aug 2023 10:35:19 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 26 Aug 2023 10:37:39 +0800
Message-ID: <85a940c1-c43a-6a2d-a992-7341fffa74c8@huawei.com>
Date:   Sat, 26 Aug 2023 10:37:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next 2/4] iio: adc: mt6577_auxadc: Use
 devm_clk_get_enabled() helper function
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
CC:     <lars@metafoo.de>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
        <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>,
        <Michael.Hennerich@analog.com>, <heiko@sntech.de>,
        <yangyingliang@huawei.com>, <robh@kernel.org>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
References: <20230825105746.2999548-1-ruanjinjie@huawei.com>
 <20230825105746.2999548-3-ruanjinjie@huawei.com>
 <20230825135402.5eef68f6@jic23-huawei>
From:   Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <20230825135402.5eef68f6@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 2023/8/25 20:54, Jonathan Cameron wrote:
> On Fri, 25 Aug 2023 18:57:44 +0800
> Jinjie Ruan <ruanjinjie@huawei.com> wrote:
> 
>> The devm_clk_get_enabled() helper:
>>     - calls devm_clk_get()
>>     - calls clk_prepare_enable() and registers what is needed in order to
>>       call clk_disable_unprepare() when needed, as a managed resource.
>>
>> This simplifies the code.
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> 
> Applied.  This is another case that would benefit from use of dev_err_probe()
> for all error messages in the probe routine.  Should also be easy to convert
> to fully devm managed with one devm_add_action_or_reset() and appropriate
> callback.

Right! Use dev_err_probe() to simplify it is a good idea.

> 
> Jonathan
> 
>> ---
>>  drivers/iio/adc/mt6577_auxadc.c | 17 +++--------------
>>  1 file changed, 3 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/iio/adc/mt6577_auxadc.c b/drivers/iio/adc/mt6577_auxadc.c
>> index 0e134777bdd2..ea42fd7a8c99 100644
>> --- a/drivers/iio/adc/mt6577_auxadc.c
>> +++ b/drivers/iio/adc/mt6577_auxadc.c
>> @@ -270,23 +270,16 @@ static int mt6577_auxadc_probe(struct platform_device *pdev)
>>  		return PTR_ERR(adc_dev->reg_base);
>>  	}
>>  
>> -	adc_dev->adc_clk = devm_clk_get(&pdev->dev, "main");
>> +	adc_dev->adc_clk = devm_clk_get_enabled(&pdev->dev, "main");
>>  	if (IS_ERR(adc_dev->adc_clk)) {
>> -		dev_err(&pdev->dev, "failed to get auxadc clock\n");
>> -		return PTR_ERR(adc_dev->adc_clk);
>> -	}
>> -
>> -	ret = clk_prepare_enable(adc_dev->adc_clk);
>> -	if (ret) {
>>  		dev_err(&pdev->dev, "failed to enable auxadc clock\n");
>> -		return ret;
>> +		return PTR_ERR(adc_dev->adc_clk);
>>  	}
>>  
>>  	adc_clk_rate = clk_get_rate(adc_dev->adc_clk);
>>  	if (!adc_clk_rate) {
>> -		ret = -EINVAL;
>>  		dev_err(&pdev->dev, "null clock rate\n");
>> -		goto err_disable_clk;
>> +		return -EINVAL;
>>  	}
>>  
>>  	adc_dev->dev_comp = device_get_match_data(&pdev->dev);
>> @@ -310,8 +303,6 @@ static int mt6577_auxadc_probe(struct platform_device *pdev)
>>  err_power_off:
>>  	mt6577_auxadc_mod_reg(adc_dev->reg_base + MT6577_AUXADC_MISC,
>>  			      0, MT6577_AUXADC_PDN_EN);
>> -err_disable_clk:
>> -	clk_disable_unprepare(adc_dev->adc_clk);
>>  	return ret;
>>  }
>>  
>> @@ -325,8 +316,6 @@ static int mt6577_auxadc_remove(struct platform_device *pdev)
>>  	mt6577_auxadc_mod_reg(adc_dev->reg_base + MT6577_AUXADC_MISC,
>>  			      0, MT6577_AUXADC_PDN_EN);
>>  
>> -	clk_disable_unprepare(adc_dev->adc_clk);
>> -
>>  	return 0;
>>  }
>>  
> 
