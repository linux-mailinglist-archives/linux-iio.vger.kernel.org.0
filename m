Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D165379499
	for <lists+linux-iio@lfdr.de>; Mon, 10 May 2021 18:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhEJQyC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 May 2021 12:54:02 -0400
Received: from first.geanix.com ([116.203.34.67]:57878 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231984AbhEJQx6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 10 May 2021 12:53:58 -0400
Received: from [192.168.100.11] (unknown [185.233.254.173])
        by first.geanix.com (Postfix) with ESMTPSA id 050FD468AE9;
        Mon, 10 May 2021 16:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1620665571; bh=Y0DUdfBRrpWLCGuinz0ADO3W/thjnRF4UJFQP0wvpd8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=NHnvaTU+atXjwEcnS5GNp3jSlHQcoqMFi6RMYwL/M/4eXfxnxfHncOHEZWFPNgle4
         r+lHbLHGm/6nQj9i42MJtTtEawL34LGqzUeK6xFHg94M9pRrysQLvpr5j7HNcNNTXH
         aRrTclKUiozMCV2C9MIbThi65SBak4fO1PvhYjPndqEqVUyzVR31AWQ36lxlZxApex
         3tFkTWi84vMa9ZAukt9P/4F80OsUJFYA/4y+WfdhFQmRSkFI/KLM4XV+SPNv2efcAn
         wO4Wu+5Qyp/KXbt5k8DPZyz+C54SEAO7650W52jJmGYSFJSnDAY7ZrtTPGVNhdekKI
         MqQUTRqa2qhzw==
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: do not roundup set samplerate
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     lorenzo.bianconi83@gmail.com, jic23@kernel.org,
        linux-iio@vger.kernel.org
References: <20210507103220.2194009-1-sean@geanix.com>
 <YJUeKhjooi8lAN1Q@lore-desk>
 <d0b62523-dcc9-ff14-aeaf-db24915f7aeb@geanix.com>
 <YJjSfpTfSMqf3w0v@lore-desk>
 <303a2899-2aff-410f-3bce-e40a7d7637e9@geanix.com>
 <YJkh6c297Msx0Xwn@lore-desk>
 <e0d50da5-7aac-1ba3-e60c-f6cd85037d30@geanix.com>
 <YJlHjMtosViHbzAV@lore-desk>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <431ddd82-8873-15a5-6f11-9556e0d37ef3@geanix.com>
Date:   Mon, 10 May 2021 18:52:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YJlHjMtosViHbzAV@lore-desk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        URIBL_BLOCKED autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on 93bd6fdb21b5
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 10/05/2021 16.47, Lorenzo Bianconi wrote:
>> On 10/05/2021 14.07, Lorenzo Bianconi wrote:
>>>> On 10/05/2021 08.28, Lorenzo Bianconi wrote:
>>>>>> On 07/05/2021 13.02, Lorenzo Bianconi wrote:
>>>>>>>> The correct way to set the sampling rate to 12.5 Hz before
>>>>>>>> commit f8710f0357bc ("iio: imu: st_lsm6dsx: express odr in mHZ")
>>>>>>>> was to write 13 Hz to sampling_frequency.
>>>>>>>> Before this patch writing 13 to samplerate results in sample rate set
>>>>>>>> to 26 Hz.
>>>>>>>> Now we return EINVAL if the sampling rate is not in table.
>>>>>>>>
>>>>>>>> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
>>>>>>>
>>>>>>> I think this patch is breaking i2c-master support available in st_lsm6dsx, have you tested it?
>>>>>>>
>>>>>> I have not tested with i2c-master.
>>>>>> But it's not nice to round up sample rate from user space without any notice.
>>>>>
>>>>> the point is accel odr is used as trigger for i2c-slave sampling. Connected
>>>>> i2c slave devices have different sample rates (e.g. LIS2MDL), so we need to
>>>>> select the lower accel odr greather than slave device one.
>>>>>
>>>>> Regards,
>>>>> Lorenzo
>>>>>
>>>>
>>>> We could open up for custom sample rates if i2c-slaves are enabled?
>>>
>>> can you please explain what you mean?
>>>
>> If i2c-slaves are enabled, it's allowed to set off table sample rates.(We roundup samplerate like now)
>> If i2c-slaves are disabled, we return -EINVAL if we can't find the chosen samplerate in the samplerate table?
> 
> IMO this is not a big deal because if you set the proper ODR (e.g. 26Hz) with the
> i2c-master disabled, the sample rate will not be rounded-up. If you set 20Hz,
> the accel ODR will be set to 26Hz. I think it does not worth to make the code
> uglier and more complex to maintain.
> 
> Regards,
> Lorenzo
> 

Sure, but we had some existing code that was setting the samplerate to 13Hz as that was the way to set 12.5Hz samplerate in the past.
Suddenly without any notice 13Hz(of cause the kernel was updated) resulted in a samplerate of 26Hz. :/

/Sean
