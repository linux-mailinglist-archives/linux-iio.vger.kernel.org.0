Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB5B42CFFD
	for <lists+linux-iio@lfdr.de>; Thu, 14 Oct 2021 03:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbhJNBmu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 13 Oct 2021 21:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbhJNBmu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 13 Oct 2021 21:42:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75E7C061570;
        Wed, 13 Oct 2021 18:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=q+0dnEobalAAFZMHVHV+dBuOgl058N3oGikzx2RCv0c=; b=c95eMPYgrEVq6KLagJXXBAKg+J
        fM9xtdx0+ISxPdKEuN5T5SKmXoULzm8ujKVE+3OAaNInFGlJKMnoT/qMPjdvsk8t6ckbDOo2Ppmqf
        jiB8mDAC2rpagql68moyw6FBl+SFQbwFujTv2QArHjcfzULVkWx+yuJVPUbd+wdat58BcXLluG13i
        E5KVbRFpxD9QmEDAijhd5LQrQo0EFqrZ9NgbSUevaJ1/L1P6tgNd/iJdNGIm3QkdbQJvjDU9Ov2mu
        JMzKMzVJ3ABNplUUX9UkBLGeAatoGzx/3qHRo/VE4heuRKwcwZpMBNgUT+gwcdh71aL3VduMFmVbo
        gEOBbcXw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mapjf-001Cwc-If; Thu, 14 Oct 2021 01:40:43 +0000
Subject: Re: [PATCH] iio: imx8qxp-adc: mark PM functions as __maybe_unused
To:     Cai Huoqing <caihuoqing@baidu.com>, Arnd Bergmann <arnd@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20211013144338.2261316-1-arnd@kernel.org>
 <20211014012936.GA2999@LAPTOP-UKSR4ENP.internal.baidu.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <50f71530-bab0-58f4-cf90-a7c1b60b9716@infradead.org>
Date:   Wed, 13 Oct 2021 18:40:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211014012936.GA2999@LAPTOP-UKSR4ENP.internal.baidu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 10/13/21 6:29 PM, Cai Huoqing wrote:
> On 13 10月 21 16:43:26, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> Without CONFIG_PM_SLEEP, the runtime suspend/resume functions
>> are unused, producing a warning:
>>
>> drivers/iio/adc/imx8qxp-adc.c:433:12: error: 'imx8qxp_adc_runtime_resume' defined but not used [-Werror=unused-function]
>>    433 | static int imx8qxp_adc_runtime_resume(struct device *dev)
>>        |            ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/iio/adc/imx8qxp-adc.c:419:12: error: 'imx8qxp_adc_runtime_suspend' defined but not used [-Werror=unused-function]
>>    419 | static int imx8qxp_adc_runtime_suspend(struct device *dev)
>>        |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> Mark them as __maybe_unused to shut up the compiler.
>>
>> Fixes: 7bce634d02e6 ("iio: imx8qxp-adc: Add driver support for NXP IMX8QXP ADC")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Reviewed-by: Cai Huoqing <caihuoqing@baidu.com>

Looks the same as
https://lore.kernel.org/all/20211013014658.2798-1-caihuoqing@baidu.com/

but that one is mixing the Fixes: tag.

>> ---
>>   drivers/iio/adc/imx8qxp-adc.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iio/adc/imx8qxp-adc.c b/drivers/iio/adc/imx8qxp-adc.c
>> index 5030e0d8318d..901dd8e1b32f 100644
>> --- a/drivers/iio/adc/imx8qxp-adc.c
>> +++ b/drivers/iio/adc/imx8qxp-adc.c
>> @@ -416,7 +416,7 @@ static int imx8qxp_adc_remove(struct platform_device *pdev)
>>   	return 0;
>>   }
>>   
>> -static int imx8qxp_adc_runtime_suspend(struct device *dev)
>> +static __maybe_unused int imx8qxp_adc_runtime_suspend(struct device *dev)
>>   {
>>   	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>>   	struct imx8qxp_adc *adc = iio_priv(indio_dev);
>> @@ -430,7 +430,7 @@ static int imx8qxp_adc_runtime_suspend(struct device *dev)
>>   	return 0;
>>   }
>>   
>> -static int imx8qxp_adc_runtime_resume(struct device *dev)
>> +static __maybe_unused int imx8qxp_adc_runtime_resume(struct device *dev)
>>   {
>>   	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>>   	struct imx8qxp_adc *adc = iio_priv(indio_dev);
>> -- 




-- 
~Randy
