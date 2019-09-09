Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0D0EAD85F
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2019 13:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404453AbfIIL7d (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Sep 2019 07:59:33 -0400
Received: from first.geanix.com ([116.203.34.67]:55612 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404391AbfIIL7c (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 9 Sep 2019 07:59:32 -0400
Received: from [192.168.100.95] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id AB13B641E1;
        Mon,  9 Sep 2019 11:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1568030343; bh=l/yV2MbgYx5ARbOylu9myyzlKH+sBN6fc6NauwGsvac=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=i06fyX7E1a0j/H9VP2WNw31esjQARa+UPI45Nuuh3Ei3muioNuYwXuttTmkL97DPn
         yuBO/9MYTylBfYLUeme/uagJMOLz2RdUFmAiYRe119mrYpxrRJR1PSVJmniVAlvAsp
         ELol9554pjcOzvFgRcJBtzQ1oR5iqC4ABhXSg7K3TAXf2iHKopJnOvKhs7IrRv4Elx
         4O1sDBFqeUhONHKDMSGVLoZEmu+VDQ7g5uXGhGzLt9GLYBiMfOvrrgylbe9SboQCvJ
         ygkuKChtGE1PEyLwM8bEoKKsZ/3YWNk6XIFpHgBWZoQVs4HiS0quFfOJyIJuJgxAkG
         E5tMWwQjGp1Kw==
Subject: Re: [PATCH v6 6/6] iio: imu: st_lsm6dsx: prohibit the use of events
 and buffered reads simultaneously
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
References: <20190909112846.55280-1-sean@geanix.com>
 <20190909112846.55280-6-sean@geanix.com>
 <20190909115535.GD2990@localhost.localdomain>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <400fa605-ce9d-bd57-b757-d8875ec1d66b@geanix.com>
Date:   Mon, 9 Sep 2019 13:59:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190909115535.GD2990@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on 77834cc0481d
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 09/09/2019 13.55, Lorenzo Bianconi wrote:
>> When events and buffered reads is enabled simultaneously, and the first
>> event accours the interrupt pin stays high.
>>
>> This can be reverted when we find a solution to allow events and
>> buffered reads simultaneously.
>>
>> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
>> ---
>> Changes since v4:
>>   * Use fifo configuration mutex to prevent a race in hw->enable_event check.
>>
>> Changes since v5:
>>   * Updated do not return without unlocking mutexes
>>   * Lock mutex before unlock
>>   * Runtime tested ;-)
>>
> 
> [...]
> 
>> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
>> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
>> @@ -1340,8 +1340,12 @@ static int st_lsm6dsx_write_event_config(struct iio_dev *iio_dev,
>>   	if (type != IIO_EV_TYPE_THRESH)
>>   		return -EINVAL;
>>   
>> -	if (hw->fifo_mode != ST_LSM6DSX_FIFO_BYPASS)
>> -		return -EBUSY;
>> +	mutex_lock(&hw->conf_lock);
>> +
>> +	if (hw->fifo_mode != ST_LSM6DSX_FIFO_BYPASS) {
>> +		err = -EBUSY;
>> +		goto out;
>> +	}
> 
> This patch is still broken!!! Returning in case of error you need to relase the
> lock.
> 

Hmm,

please read below this:

-	return 0;
+out:
+	mutex_unlock(&hw->conf_lock);
+
+	return err;


>>   
>>   	/* do not enable events if they are already enabled */
>>   	if (state && hw->enable_event)
>> @@ -1357,7 +1361,10 @@ static int st_lsm6dsx_write_event_config(struct iio_dev *iio_dev,
>>   
>>   	hw->enable_event = state;
>>   
>> -	return 0;
>> +out:
>> +	mutex_unlock(&hw->conf_lock);
>> +
>> +	return err;
>>   }
>>   
>>   int st_lsm6dsx_set_watermark(struct iio_dev *iio_dev, unsigned int val)
>> -- 
>> 2.23.0
>>
