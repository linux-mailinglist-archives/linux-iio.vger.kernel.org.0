Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9375378E47
	for <lists+linux-iio@lfdr.de>; Mon, 10 May 2021 15:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233478AbhEJNHw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 May 2021 09:07:52 -0400
Received: from first.geanix.com ([116.203.34.67]:47886 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344257AbhEJMPa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 10 May 2021 08:15:30 -0400
Received: from [192.168.100.10] (unknown [185.233.254.173])
        by first.geanix.com (Postfix) with ESMTPSA id 0C0EF466BCE;
        Mon, 10 May 2021 12:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1620648863; bh=dCjihH62aa3VL5t4jdIUppDG3Jid7/iUxZxY9N2K0MI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=RzmMvrpPzQbxLBLsYpVtRWWTlYwg98MfyDB0NCMtBrGcrAou9on9JSry/2GGAyQzy
         IXhNqI+pBqvttE3CxhYt1SKzRzCpWLBthfoMLQG0O3Ji77t5YRC8ZiVl+cce6qbuwI
         CWg/wUrGrW46sB96UC4YJCU2nuWN85lMPf7K2nEYRg874BAAEgZMnh8I/sT0qG42o1
         UOqcT9p4qvzRipdTfugFc2iXZP7AldNOXsZDFw3X0B14ltaC4prUGzvEtBZNiR6vX2
         RvjI3hOYAMarISdqu5z6qEkRtSrsaDenJ86hy5a0eZfjOxcTev3bL44gTMu1bhBGiK
         Jsw5wrogS+kEw==
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
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <e0d50da5-7aac-1ba3-e60c-f6cd85037d30@geanix.com>
Date:   Mon, 10 May 2021 14:14:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YJkh6c297Msx0Xwn@lore-desk>
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

On 10/05/2021 14.07, Lorenzo Bianconi wrote:
>> On 10/05/2021 08.28, Lorenzo Bianconi wrote:
>>>> On 07/05/2021 13.02, Lorenzo Bianconi wrote:
>>>>>> The correct way to set the sampling rate to 12.5 Hz before
>>>>>> commit f8710f0357bc ("iio: imu: st_lsm6dsx: express odr in mHZ")
>>>>>> was to write 13 Hz to sampling_frequency.
>>>>>> Before this patch writing 13 to samplerate results in sample rate set
>>>>>> to 26 Hz.
>>>>>> Now we return EINVAL if the sampling rate is not in table.
>>>>>>
>>>>>> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
>>>>>
>>>>> I think this patch is breaking i2c-master support available in st_lsm6dsx, have you tested it?
>>>>>
>>>> I have not tested with i2c-master.
>>>> But it's not nice to round up sample rate from user space without any notice.
>>>
>>> the point is accel odr is used as trigger for i2c-slave sampling. Connected
>>> i2c slave devices have different sample rates (e.g. LIS2MDL), so we need to
>>> select the lower accel odr greather than slave device one.
>>>
>>> Regards,
>>> Lorenzo
>>>
>>
>> We could open up for custom sample rates if i2c-slaves are enabled?
> 
> can you please explain what you mean?
> 
If i2c-slaves are enabled, it's allowed to set off table sample rates.(We roundup samplerate like now)
If i2c-slaves are disabled, we return -EINVAL if we can't find the chosen samplerate in the samplerate table?

/Sean
