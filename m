Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 924AE1E7873
	for <lists+linux-iio@lfdr.de>; Fri, 29 May 2020 10:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgE2IdQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 May 2020 04:33:16 -0400
Received: from first.geanix.com ([116.203.34.67]:55904 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbgE2IdQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 29 May 2020 04:33:16 -0400
Received: from [192.168.100.99] (xb90f4a16.cust.hiper.dk [185.15.74.22])
        by first.geanix.com (Postfix) with ESMTPSA id BA0312023E36;
        Fri, 29 May 2020 08:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1590741191; bh=7YT49D/TpI4BP08TG9bMlkRwYIFG3XgVsRetrk3KZqI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=N5ej/84V4uR/JNAsVGXoVWNbAdEi9kJ7qu+RekgD2H078aj5vtvdIwy1vUZL6yFSz
         vFrl8Awfd1DDeiTtdGLJ1nhmOEfdVWy1iYDZ4N82xSXe1nppq3INaHo7uZkzzssF9Y
         JsFVFotlUecREqjGTX5GJfbTzJa5D3xviOqsAxDNerigK0IH0pMNT3wcnisLWvHqfX
         IOJJmSUAc7sjAXqOn2BrUaLwsEalXDFjPJTPYk4fIIcle7igBI28GrtMZ9+4qGPTRu
         nFWbFnaB6l5a0LGZKcPVs5yBQ5cYbDQwOVpOVxU7HKYuPgt9zWCyHrC9NtMoaAVyGj
         Uz2PvuD5e62fA==
Subject: Re: IIO timestamp get skewed when suspending (st_lsm6dsx)
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <54cb146d-e54e-acae-e89c-075521b8e7dc@geanix.com>
 <20200528210711.GD5419@localhost.localdomain>
 <3c629741-43f1-3d3a-2b40-40ddfd773e86@geanix.com>
 <20200529074443.GA3198@localhost.localdomain>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <5bb0fca9-97a4-4bad-1314-1f275ab632ff@geanix.com>
Date:   Fri, 29 May 2020 10:33:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200529074443.GA3198@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=4.0 tests=ALL_TRUSTED,BAYES_05,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on fdf6823a942a
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 29/05/2020 09.44, Lorenzo Bianconi wrote:
> On May 29, Sean Nyekjaer wrote:
>>
>>>>
>>>> Could a solution, be to call st_lsm6dsx_reset_hw_ts() in st_lsm6dsx_resume()
>>>> ?
>>>
>>> yes, I think so. Could you please try to patch below? Thanks.
>>>
>>
>> Hi Lorenzo,
>>
>> I have tried your patch, and the timestamp seems to behave like before.
>>
>> https://gist.github.com/sknsean/959d3421f66cb49144e7841a8a08a2be
>> Sorry NTP have been connected for a while :)
>>
>> I will enable some more debug to trace what is happening.
>>
>> /Sean
> 
> Hi Sean,
> 
> thx for testing. Is the FIFO enabled before the suspend (in other words, is
> st_lsm6dsx_resume_fifo running in st_lsm6dsx_resume?) what is the value of
> sensor->ts_ref after the resume?

I have applied this patch:
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c 
b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c

index 7de10bd636ea..915829f89d31 100644

--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c

+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c

@@ -304,12 +304,28 @@ static int st_lsm6dsx_reset_hw_ts(struct 
st_lsm6dsx_hw *hw)



  int st_lsm6dsx_resume_fifo(struct st_lsm6dsx_hw *hw)

  {

-       int err;

+       int err, i;

+       struct st_lsm6dsx_sensor *sensor;



+       printk("st_lsm6dsx_resume_fifo\n");

+       for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {

+               if (!hw->iio_devs[i])

+                       continue;

+

+               sensor = iio_priv(hw->iio_devs[i]);

+               printk("Before[%d]: %lld\n", i, sensor->ts_ref);

+       }

         /* reset hw ts counter */

         err = st_lsm6dsx_reset_hw_ts(hw);

         if (err < 0)

                 return err;

+       for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {

+               if (!hw->iio_devs[i])

+                       continue;

+

+               sensor = iio_priv(hw->iio_devs[i]);

+               printk("After[%d]: %lld\n", i, sensor->ts_ref);

+       }



         return st_lsm6dsx_set_fifo_mode(hw, ST_LSM6DSX_FIFO_CONT);

  }

And dmesg:
[  949.295585] st_lsm6dsx_resume_fifo

[  949.295617] Before[0]: 0

[  949.295636] Before[1]: 0

[  949.296456] After[0]: 1590740890980204361

[  949.296476] After[1]: 1590740890980207987

[  953.380200] PM: suspend entry (deep)

[  953.790084] Filesystems sync: 0.409 seconds

[  953.795329] Freezing user space processes ... (elapsed 0.002 seconds) 
done.

[  953.798124] OOM killer disabled.

[  953.798140] Freezing remaining freezable tasks ... (elapsed 0.001 
seconds) done.

[  953.800016] printk: Suspending console(s) (use no_console_suspend to 
debug)

[  953.869535] PM: suspend devices took 0.070 seconds

[  953.883280] Disabling non-boot CPUs ...

[  953.897700] st_lsm6dsx_resume_fifo

[  953.897732] Before[0]: 1590740890980204361

[  953.897752] Before[1]: 1590740890980207987

[  953.898572] After[0]: 1590740895583500924

[  953.898594] After[1]: 1590740895583504049

[  953.914484] PM: resume devices took 0.020 seconds

[  953.914533] OOM killer enabled.

[  953.914552] Restarting tasks ... done.

[  953.947170] PM: suspend exit

/Sean
