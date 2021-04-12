Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E93B635BFEB
	for <lists+linux-iio@lfdr.de>; Mon, 12 Apr 2021 11:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239361AbhDLJH0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Apr 2021 05:07:26 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16446 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240335AbhDLJFo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Apr 2021 05:05:44 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FJjSY02ztzqTHF;
        Mon, 12 Apr 2021 17:03:09 +0800 (CST)
Received: from [127.0.0.1] (10.69.38.196) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.498.0; Mon, 12 Apr 2021
 17:05:15 +0800
Subject: Re: [PATCH 4/7] iio: triggered-buffer: simplify
 devm_iio_triggered_buffer_setup_ext
To:     Jonathan Cameron <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <pmeerw@pmeerw.net>,
        <prime.zeng@huawei.com>, <tiantao6@hisilicon.com>
References: <1617881896-3164-1-git-send-email-yangyicong@hisilicon.com>
 <1617881896-3164-5-git-send-email-yangyicong@hisilicon.com>
 <20210411151606.1ec66860@jic23-huawei>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <d8c6eaa8-ab97-c3e4-644e-35bc53b957c1@hisilicon.com>
Date:   Mon, 12 Apr 2021 17:05:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20210411151606.1ec66860@jic23-huawei>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.38.196]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2021/4/11 22:16, Jonathan Cameron wrote:
> On Thu, 8 Apr 2021 19:38:13 +0800
> Yicong Yang <yangyicong@hisilicon.com> wrote:
> 
>> Use devm_add_action_or_reset() instead of devres_alloc() and
>> devres_add(), which works the same. This will simplify the
>> code. There is no functional changes.
>>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> ---
>>  drivers/iio/buffer/industrialio-triggered-buffer.c | 19 +++++--------------
>>  1 file changed, 5 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/iio/buffer/industrialio-triggered-buffer.c b/drivers/iio/buffer/industrialio-triggered-buffer.c
>> index 92b8aea..63b4722 100644
>> --- a/drivers/iio/buffer/industrialio-triggered-buffer.c
>> +++ b/drivers/iio/buffer/industrialio-triggered-buffer.c
>> @@ -92,9 +92,9 @@ void iio_triggered_buffer_cleanup(struct iio_dev *indio_dev)
>>  }
>>  EXPORT_SYMBOL(iio_triggered_buffer_cleanup);
>>  
>> -static void devm_iio_triggered_buffer_clean(struct device *dev, void *res)
>> +static void devm_iio_triggered_buffer_clean(void *indio_dev)
>>  {
>> -	iio_triggered_buffer_cleanup(*(struct iio_dev **)res);
>> +	iio_triggered_buffer_cleanup(indio_dev);
>>  }
>>  
>>  int devm_iio_triggered_buffer_setup_ext(struct device *dev,
>> @@ -104,24 +104,15 @@ int devm_iio_triggered_buffer_setup_ext(struct device *dev,
>>  					const struct iio_buffer_setup_ops *ops,
>>  					const struct attribute **buffer_attrs)
>>  {
>> -	struct iio_dev **ptr;
>>  	int ret;
>>  
>> -	ptr = devres_alloc(devm_iio_triggered_buffer_clean, sizeof(*ptr),
>> -			   GFP_KERNEL);
>> -	if (!ptr)
>> -		return -ENOMEM;
>> -
>> -	*ptr = indio_dev;
>> -
>>  	ret = iio_triggered_buffer_setup_ext(indio_dev, h, thread, ops,
>>  					     buffer_attrs);
>>  	if (!ret)
>> -		devres_add(dev, ptr);
>> -	else
>> -		devres_free(ptr);
>> +		return ret;
> 
> This looks inverted from what it should be.
> 
> 	if (ret)
> 		return ret;
> 
> 	return devm_add_action_or_reset()...
> 

yes. it does. will fix.

thanks

>>  
>> -	return ret;
>> +	return devm_add_action_or_reset(dev, devm_iio_triggered_buffer_clean,
>> +					indio_dev);
>>  }
>>  EXPORT_SYMBOL_GPL(devm_iio_triggered_buffer_setup_ext);
>>  
> 
> 
> .
> 

