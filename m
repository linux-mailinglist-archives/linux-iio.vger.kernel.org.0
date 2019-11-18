Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16623FFCE0
	for <lists+linux-iio@lfdr.de>; Mon, 18 Nov 2019 02:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbfKRBls (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 Nov 2019 20:41:48 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6686 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725905AbfKRBls (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 17 Nov 2019 20:41:48 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8BC3D6CF6D2961F95314;
        Mon, 18 Nov 2019 09:41:40 +0800 (CST)
Received: from [127.0.0.1] (10.133.213.239) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Mon, 18 Nov 2019
 09:41:38 +0800
Subject: Re: [PATCH v2 -next] iio: st_accel: Fix unused variable warning
To:     Jonathan Cameron <jic23@kernel.org>
References: <20191101134741.25108-1-yuehaibing@huawei.com>
 <20191111032115.3008-1-yuehaibing@huawei.com>
 <20191116145821.1ac46310@archlinux>
CC:     <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <denis.ciocca@st.com>, <tglx@linutronix.de>,
        <alexios.zavras@intel.com>, <allison@lohutok.net>,
        <linus.walleij@linaro.org>, <ladis@linux-mips.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <782ac6a6-9ee6-38fa-c599-72da7f70ffa5@huawei.com>
Date:   Mon, 18 Nov 2019 09:41:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20191116145821.1ac46310@archlinux>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2019/11/16 22:58, Jonathan Cameron wrote:
> On Mon, 11 Nov 2019 11:21:15 +0800
> YueHaibing <yuehaibing@huawei.com> wrote:
> 
>> drivers/iio/accel/st_accel_core.c:1005:44: warning:
>>  mount_matrix_ext_info defined but not used [-Wunused-const-variable=]
>>
>> Using stub helper while CONFIG_ACPI is disabled to fix it.
>>
>> Suggested-by: Ladislav Michl <ladis@linux-mips.org>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> Applied to the fixes-togreg branch of iio.git as I've now closed for new
> things for the coming merge window.  This will go upstream after the merge
> window closes and probably hit around rc2.  Thanks for cleaning this up.

Thanks!

> 
> Jonathan
> 
>> ---
>>  drivers/iio/accel/st_accel_core.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
>> index 7b83764..7320275 100644
>> --- a/drivers/iio/accel/st_accel_core.c
>> +++ b/drivers/iio/accel/st_accel_core.c
>> @@ -992,6 +992,7 @@ static const struct iio_trigger_ops st_accel_trigger_ops = {
>>  #define ST_ACCEL_TRIGGER_OPS NULL
>>  #endif
>>  
>> +#ifdef CONFIG_ACPI
>>  static const struct iio_mount_matrix *
>>  get_mount_matrix(const struct iio_dev *indio_dev,
>>  		 const struct iio_chan_spec *chan)
>> @@ -1012,7 +1013,6 @@ static const struct iio_chan_spec_ext_info mount_matrix_ext_info[] = {
>>  static int apply_acpi_orientation(struct iio_dev *indio_dev,
>>  				  struct iio_chan_spec *channels)
>>  {
>> -#ifdef CONFIG_ACPI
>>  	struct st_sensor_data *adata = iio_priv(indio_dev);
>>  	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
>>  	struct acpi_device *adev;
>> @@ -1140,10 +1140,14 @@ static int apply_acpi_orientation(struct iio_dev *indio_dev,
>>  out:
>>  	kfree(buffer.pointer);
>>  	return ret;
>> +}
>>  #else /* !CONFIG_ACPI */
>> +static int apply_acpi_orientation(struct iio_dev *indio_dev,
>> +				  struct iio_chan_spec *channels)
>> +{
>>  	return 0;
>> -#endif
>>  }
>> +#endif
>>  
>>  /*
>>   * st_accel_get_settings() - get sensor settings from device name
> 
> 
> .
> 

