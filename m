Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10450196DBD
	for <lists+linux-iio@lfdr.de>; Sun, 29 Mar 2020 15:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgC2NqY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Mar 2020 09:46:24 -0400
Received: from www381.your-server.de ([78.46.137.84]:60640 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727903AbgC2NqX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 29 Mar 2020 09:46:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KnCgqqdWyNK62dUdcWZxkpPXuIoCWmgb+CFyMmoZanM=; b=KPclBmXcudrmQ8TN6TD61WVVkC
        yVD9ejfhiE/AWKXSFZRXUMwtf+CMCycy7ppYJ+hzcvKahpLT3qExBev/ASrRZdyoCJkVbYZj46U/5
        gDANJWNErFRwmsT5EgpVw0Kd3wgQpUezyZfT7N0BWtdmfEdVlDVYopMjYCbbbpyDjILdnbU0Iwjl4
        fKlgpVolErNwfrSDRc9tNvPGFm6ChDraLGqL08vd9QgZKY6rJED5hMBke1wCDDRk8fFjvutoSDBJi
        EHqNQygebjSmyVUqrDmUtaVOMk7Vj30JeB//iDT3GmeeoeBQ1OYq41os+saaPa7seMzS4gjU0VZSP
        LpGa5QOQ==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jIYGY-0002vF-Gv; Sun, 29 Mar 2020 15:46:19 +0200
Received: from [82.135.74.134] (helo=[192.168.178.20])
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jIYGY-000RHr-5p; Sun, 29 Mar 2020 15:46:18 +0200
Subject: Re: [PATCH 0/2] use DEFINE_DEBUGFS_ATTRIBUTE instead of
 DEFINE_SIMPLE_ATTRIBUTE
To:     Rohit Sarkar <rohitsarkar5398@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, dragos.bogdan@analog.com,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        zhong jiang <zhongjiang@huawei.com>
References: <20200328063456.24012-1-rohitsarkar5398@gmail.com>
 <20200329103818.2fce9529@archlinux>
 <5e8087e3.1c69fb81.13d97.448d@mx.google.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <8d861c54-75be-589a-9e71-cd30cbde84d3@metafoo.de>
Date:   Sun, 29 Mar 2020 15:46:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <5e8087e3.1c69fb81.13d97.448d@mx.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25765/Sat Mar 28 14:16:42 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/29/20 1:34 PM, Rohit Sarkar wrote:
> On Sun, Mar 29, 2020 at 10:38:18AM +0100, Jonathan Cameron wrote:
>> On Sat, 28 Mar 2020 12:04:53 +0530
>> Rohit Sarkar <rohitsarkar5398@gmail.com> wrote:
>>
>>> The debugfs_create_file_unsafe method does not protect the fops given to
>>> it from file removal. It must be used with DEFINE_DEBUGFS_ATTRIBUTE
>>> which makes the fops aware of the file lifetime.
>>>
>>> Further using DEFINE_DEBUGFS_ATTRIBUTE along with
>>> debugfs_create_file_unsafe significantly reduces the overhead introduced by
>>> debugfs_create_file which creates a lifetime managing proxy around each
>>> fops handed in. Refer [1] for more on this.
>>>
>>> Fixes the following warnings reported by coccinelle:
>>> drivers/iio/imu//adis16460.c:126:0-23: WARNING: adis16460_flash_count_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
>>> drivers/iio/imu//adis16460.c:108:0-23: WARNING: adis16460_product_id_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
>>> drivers/iio/imu//adis16460.c:90:0-23: WARNING: adis16460_serial_number_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
>>> drivers/iio/imu//adis16400.c:278:0-23: WARNING: adis16400_flash_count_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
>>> drivers/iio/imu//adis16400.c:261:0-23: WARNING: adis16400_product_id_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
>>>
>>> [1]: https://lists.gt.net/linux/kernel/2369498
>>>
>>> Rohit Sarkar (2):
>>>    iio: imu: adis16400: use DEFINE_DEBUGFS_ATTRIBUTE instead of
>>>      DEFINE_SIMPLE_ATTRIBUTE
>>>    iio: imu: adis16460: use DEFINE_DEBUGFS_ATTRIBUTE instead of
>>>      DEFINE_SIMPLE_ATTRIBUTE
>>>
>>>   drivers/iio/imu/adis16400.c | 4 ++--
>>>   drivers/iio/imu/adis16460.c | 6 +++---
>>>   2 files changed, 5 insertions(+), 5 deletions(-)
>>>
>> Hi Rohit,
> Hey,
>> You've opened a can of worms with this one.  There as a previous series
>> posted doing exactly this change back in 2019 by Zhong Jiang (cc'd)
>>
>> At the time I did a bit of looking into why this had been universally taken
>> up cross tree and turned out there are some potential issues.
>>
>> Alexandru added it to the list of things to test, but I guess it got
>> buried under other work and is still outstanding.
>>
>> https://lkml.org/lkml/2019/10/30/144
> Acc. to the patch by Zhong this change kind of comes off as a cosmetic
> change as in the commit message he mentions "it is more clear".
>
> But there is certainly more to it than that:
> In the current scenario since we are using debugfs_create_file_unsafe
> the file has no protection whatsoever against removal.

The drivers you are patching all use debugfs_create_file() as far as I 
can see.

The way I understand it using DEFINE_DEBUGFS_ATTRIBUTE without switching 
to debugfs_create_file_unsafe() will not make a difference. There will 
only be more overhead since the files are protected twice.

- Lars


