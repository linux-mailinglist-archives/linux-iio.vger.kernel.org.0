Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F883ED6ED
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2019 02:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbfKDB31 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 Nov 2019 20:29:27 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:5694 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728290AbfKDB31 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Nov 2019 20:29:27 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6AF5A30D7CA97B35385F;
        Mon,  4 Nov 2019 09:29:25 +0800 (CST)
Received: from [127.0.0.1] (10.133.213.239) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Mon, 4 Nov 2019
 09:29:23 +0800
Subject: Re: [PATCH -next] iio: st_accel: Fix unused variable warning
To:     Ladislav Michl <ladis@linux-mips.org>,
        Jonathan Cameron <jic23@kernel.org>
References: <20191101134741.25108-1-yuehaibing@huawei.com>
 <20191102104125.GA22015@lenoch> <20191102140810.3d756294@archlinux>
 <20191102201535.GA30346@lenoch>
CC:     <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <denis.ciocca@st.com>, <rfontana@redhat.com>, <tglx@linutronix.de>,
        <heiko.stuebner@bq.com>, <rjones@gateworks.com>,
        <drake@endlessm.com>, <colin.king@canonical.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <4a6c8c31-360b-1cf2-7d6c-8426199637f0@huawei.com>
Date:   Mon, 4 Nov 2019 09:29:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20191102201535.GA30346@lenoch>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2019/11/3 4:15, Ladislav Michl wrote:
> On Sat, Nov 02, 2019 at 02:08:10PM +0000, Jonathan Cameron wrote:
>> On Sat, 2 Nov 2019 11:41:25 +0100
>> Ladislav Michl <ladis@linux-mips.org> wrote:
>>
>>> On Fri, Nov 01, 2019 at 09:47:41PM +0800, YueHaibing wrote:
>>>> drivers/iio/accel/st_accel_core.c:1005:44: warning:
>>>>  mount_matrix_ext_info defined but not used [-Wunused-const-variable=]
>>>>
>>>> Move it to ifdef to mute this warning.
>>>>
>>>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>>>> ---
>>>>  drivers/iio/accel/st_accel_core.c | 2 ++
>>>>  1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
>>>> index 2e37f8a..bba0717 100644
>>>> --- a/drivers/iio/accel/st_accel_core.c
>>>> +++ b/drivers/iio/accel/st_accel_core.c
>>>> @@ -1002,10 +1002,12 @@ get_mount_matrix(const struct iio_dev *indio_dev,
>>>>  	return adata->mount_matrix;
>>>>  }
>>>>  
>>>> +#ifdef CONFIG_ACPI
>>>>  static const struct iio_chan_spec_ext_info mount_matrix_ext_info[] = {
>>>>  	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, get_mount_matrix),  
>>>
>>> So now you do not get any warning for unused get_mount_matrix?
>>> (Then it would make more sense to put all that stuff under one ifdef
>>> and provide empty apply_acpi_orientation for non ACPI case)
>>
>> Does the __maybe_unused marking make this go away?
>>
>> I'd assume that the compiler will manage to drop this either way
>> but I guess we should check that.
>>
>> ifdef magic is always harder to read and potentially fragile in the
>> long run.  Here we simply want to indicate that in some build
>> configurations we might not use this.
> 
> This suggestion implies we'll get rid of CONFIG_ACPI completely, which
> seems inapproriate looking at size of apply_acpi_orientation function.
> And having both CONFIG_ACPI and __maybe_unused does not make much
> sense. I had something like that in mind (+COMPILE_TEST perhaps):
> 
> diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
> index 2e37f8a6d8cf..0e7eac62d618 100644
> --- a/drivers/iio/accel/st_accel_core.c
> +++ b/drivers/iio/accel/st_accel_core.c
> @@ -993,6 +993,7 @@ static const struct iio_trigger_ops st_accel_trigger_ops = {
>  #define ST_ACCEL_TRIGGER_OPS NULL
>  #endif
>  
> +#ifdef CONFIG_ACPI
>  static const struct iio_mount_matrix *
>  get_mount_matrix(const struct iio_dev *indio_dev,
>  		 const struct iio_chan_spec *chan)
> @@ -1013,7 +1014,6 @@ static const struct iio_chan_spec_ext_info mount_matrix_ext_info[] = {
>  static int apply_acpi_orientation(struct iio_dev *indio_dev,
>  				  struct iio_chan_spec *channels)
>  {
> -#ifdef CONFIG_ACPI
>  	struct st_sensor_data *adata = iio_priv(indio_dev);
>  	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
>  	struct acpi_device *adev;
> @@ -1141,10 +1141,14 @@ static int apply_acpi_orientation(struct iio_dev *indio_dev,
>  out:
>  	kfree(buffer.pointer);
>  	return ret;
> -#else /* !CONFIG_ACPI */
> +}
> +#else
> +static int apply_acpi_orientation(struct iio_dev *indio_dev,

Does this need inline?

> +				  struct iio_chan_spec *channels)
> +{
>  	return 0;
> -#endif
>  }
> +#endif
>  
>  /*
>   * st_accel_get_settings() - get sensor settings from device name
>> Thanks,
>>
>> Jonathan
>>
>>
>>>
>>>>  	{ },
>>>>  };
>>>> +#endif
>>>>  
>>>>  /* Read ST-specific _ONT orientation data from ACPI and generate an
>>>>   * appropriate mount matrix.
>>>> -- 
>>>> 2.7.4
>>>>   
> 
> .
> 

