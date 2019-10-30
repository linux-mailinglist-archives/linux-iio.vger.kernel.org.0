Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 775D2E9932
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2019 10:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbfJ3JdX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Oct 2019 05:33:23 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49820 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726028AbfJ3JdW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 30 Oct 2019 05:33:22 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A67A73E0A51CECA0DC52;
        Wed, 30 Oct 2019 17:33:20 +0800 (CST)
Received: from [127.0.0.1] (10.133.219.218) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Wed, 30 Oct 2019
 17:33:14 +0800
Message-ID: <5DB958DA.7080305@huawei.com>
Date:   Wed, 30 Oct 2019 17:33:14 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/2] iio: imu: adis16460: use DEFINE_DEBUGFS_ATTRIBUTE
 to define debugfs fops
References: <1572423581-59762-1-git-send-email-zhongjiang@huawei.com>         <1572423581-59762-2-git-send-email-zhongjiang@huawei.com> <fb8722ad2c1ef51944dc814a7b24433f4348721e.camel@analog.com>
In-Reply-To: <fb8722ad2c1ef51944dc814a7b24433f4348721e.camel@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.219.218]
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2019/10/30 17:13, Ardelean, Alexandru wrote:
> On Wed, 2019-10-30 at 16:19 +0800, zhong jiang wrote:
>> [External]
>>
>> It is more clear to use DEFINE_DEBUGFS_ATTRIBUTE to define debugfs file
>> operation rather than DEFINE_SIMPLE_ATTRIBUTE.
> Not sure if "more clear" is the word.
Should be more clearly. :-)
> But it is more correct to use DEFINE_DEBUGFS_ATTRIBUTE(), since they are
> debugfs attrs.
>
> In any case, this is no big deal.
> So:
>
> Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
>
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>> ---
>>  drivers/iio/imu/adis16460.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iio/imu/adis16460.c b/drivers/iio/imu/adis16460.c
>> index 6aed9e8..2e7a582 100644
>> --- a/drivers/iio/imu/adis16460.c
>> +++ b/drivers/iio/imu/adis16460.c
>> @@ -87,7 +87,7 @@ static int adis16460_show_serial_number(void *arg, u64
>> *val)
>>  
>>  	return 0;
>>  }
>> -DEFINE_SIMPLE_ATTRIBUTE(adis16460_serial_number_fops,
>> +DEFINE_DEBUGFS_ATTRIBUTE(adis16460_serial_number_fops,
>>  	adis16460_show_serial_number, NULL, "0x%.4llx\n");
>>  
>>  static int adis16460_show_product_id(void *arg, u64 *val)
>> @@ -105,7 +105,7 @@ static int adis16460_show_product_id(void *arg, u64
>> *val)
>>  
>>  	return 0;
>>  }
>> -DEFINE_SIMPLE_ATTRIBUTE(adis16460_product_id_fops,
>> +DEFINE_DEBUGFS_ATTRIBUTE(adis16460_product_id_fops,
>>  	adis16460_show_product_id, NULL, "%llu\n");
>>  
>>  static int adis16460_show_flash_count(void *arg, u64 *val)
>> @@ -123,7 +123,7 @@ static int adis16460_show_flash_count(void *arg, u64
>> *val)
>>  
>>  	return 0;
>>  }
>> -DEFINE_SIMPLE_ATTRIBUTE(adis16460_flash_count_fops,
>> +DEFINE_DEBUGFS_ATTRIBUTE(adis16460_flash_count_fops,
>>  	adis16460_show_flash_count, NULL, "%lld\n");
>>  
>>  static int adis16460_debugfs_init(struct iio_dev *indio_dev)


