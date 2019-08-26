Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD0359C761
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2019 04:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbfHZCtL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 25 Aug 2019 22:49:11 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5656 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726215AbfHZCtL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 25 Aug 2019 22:49:11 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 45245C848C1EB97499E1;
        Mon, 26 Aug 2019 10:49:08 +0800 (CST)
Received: from [127.0.0.1] (10.133.213.239) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Mon, 26 Aug 2019
 10:49:00 +0800
Subject: Re: [PATCH -next] iio: st_sensors: Fix build error
To:     Jonathan Cameron <jic23@kernel.org>
References: <20190823121852.75108-1-yuehaibing@huawei.com>
 <20190825185936.0b31cde6@archlinux>
CC:     <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <tglx@linutronix.de>,
        <denis.ciocca@st.com>, <Jonathan.Cameron@huawei.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <0ce7f63c-2c62-aec4-d952-02bf696fd6b6@huawei.com>
Date:   Mon, 26 Aug 2019 10:48:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190825185936.0b31cde6@archlinux>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2019/8/26 1:59, Jonathan Cameron wrote:
> On Fri, 23 Aug 2019 20:18:52 +0800
> YueHaibing <yuehaibing@huawei.com> wrote:
> 
>> IIO_ST_SENSORS_CORE select IIO_ST_SENSORS_I2C
>> unconditionally, if REGMAP_I2C is not set, build fails
>>
>> drivers/iio/common/st_sensors/st_sensors_i2c.o: In function `st_sensors_i2c_configure':
>> st_sensors_i2c.c:(.text+0x58): undefined reference to `__devm_regmap_init_i2c'
>>
>> This patch selects REGMAP_I2C to fix it.
>> IIO_ST_SENSORS_SPI is similar to SPI issue.
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Fixes: 062809ef7733 ("iio: make st_sensors drivers use regmap")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> 
> Hi,
> 
> Thanks,  I've fixed up the inconsistent ordering below.

Oh, thanks!

> 
> Applied to the togreg branch of iio.git and pushed out as
> testing for the autobuilders to play with it.
> 
> Thanks,
> 
> Jonathan
> 
>> ---
>>  drivers/iio/common/st_sensors/Kconfig | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/iio/common/st_sensors/Kconfig b/drivers/iio/common/st_sensors/Kconfig
>> index 91b98e1..16d973f 100644
>> --- a/drivers/iio/common/st_sensors/Kconfig
>> +++ b/drivers/iio/common/st_sensors/Kconfig
>> @@ -5,8 +5,10 @@
>>  
>>  config IIO_ST_SENSORS_I2C
>>  	tristate
>> +	select REGMAP_I2C
>>  
>>  config IIO_ST_SENSORS_SPI
>> +	select REGMAP_SPI
> 
> Inconsistent with the previous.
> 
>>  	tristate
>>  
>>  config IIO_ST_SENSORS_CORE
> 
> 
> .
> 

