Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF0451994BB
	for <lists+linux-iio@lfdr.de>; Tue, 31 Mar 2020 13:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730418AbgCaLIK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Mar 2020 07:08:10 -0400
Received: from www381.your-server.de ([78.46.137.84]:60258 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730377AbgCaLIK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Mar 2020 07:08:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dO+HmymDbjQQciYegqXjO3hF6Swgv/jmvaAxnl+cdp0=; b=LjgXcRCT0WS9V0AIUNR9YYxjkX
        ULBbNCUOSshQS9sZ9bd9NTlaXNzpHiuX+NqOgKBcXTVxh4PouWS7VRx7/J+SCZwhW/B2Wp2oYy6Z9
        Ce9UQlll1XUtETgtwhZ7yDaGnDUTMZmpVbBJzeiTGdPZTuC54sYKzwMylNHsh7q0MnUWqUQtgrzq7
        KpJLwnkSrCD2U4jD/QKk/du6wGEj5AjdUd2zX+1GtkgkIxoPUwySCpkrKTwmZgIirZZXarTpava/k
        Ar/jVU0tZHB3ZMYc/JHkx3azzc1foeO5LiMadvNX+NrDYBv02i8iI5d8l5mZP2bloobbQLMkJP9WW
        fXP3BjTA==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jJEkU-0004xI-0l; Tue, 31 Mar 2020 13:08:02 +0200
Received: from [82.135.70.63] (helo=[192.168.178.20])
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jJEkT-000R1n-JG; Tue, 31 Mar 2020 13:08:01 +0200
Subject: Re: [PATCH 0/2] use DEFINE_DEBUGFS_ATTRIBUTE instead of
 DEFINE_SIMPLE_ATTRIBUTE
To:     "Sa, Nuno" <Nuno.Sa@analog.com>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "rohitsarkar5398@gmail.com" <rohitsarkar5398@gmail.com>
Cc:     "stefan.popa@analog.com" <stefan.popa@analog.com>,
        "zhongjiang@huawei.com" <zhongjiang@huawei.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200328063456.24012-1-rohitsarkar5398@gmail.com>
 <20200329103818.2fce9529@archlinux>
 <aee10d6bfc5f2fef85d90245304f3e0f368f94ec.camel@analog.com>
 <BN6PR03MB33472A88BA78392686737F9099C80@BN6PR03MB3347.namprd03.prod.outlook.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <74033597-c348-03df-d52f-748bf52c1a12@metafoo.de>
Date:   Tue, 31 Mar 2020 13:08:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <BN6PR03MB33472A88BA78392686737F9099C80@BN6PR03MB3347.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25767/Mon Mar 30 15:08:30 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/31/20 12:58 PM, Sa, Nuno wrote:
> Hi Rohit,
>
>> From: linux-iio-owner@vger.kernel.org <linux-iio-owner@vger.kernel.org> On
>> Behalf Of Ardelean, Alexandru
>> Sent: Montag, 30. März 2020 11:20
>> To: jic23@kernel.org; rohitsarkar5398@gmail.com
>> Cc: stefan.popa@analog.com; zhongjiang@huawei.com; linux-
>> iio@vger.kernel.org; Bogdan, Dragos <Dragos.Bogdan@analog.com>;
>> pmeerw@pmeerw.net; knaack.h@gmx.de; Hennerich, Michael
>> <Michael.Hennerich@analog.com>; linux-kernel@vger.kernel.org;
>> lars@metafoo.de
>> Subject: Re: [PATCH 0/2] use DEFINE_DEBUGFS_ATTRIBUTE instead of
>> DEFINE_SIMPLE_ATTRIBUTE
>>
>> On Sun, 2020-03-29 at 10:38 +0100, Jonathan Cameron wrote:
>>> On Sat, 28 Mar 2020 12:04:53 +0530
>>> Rohit Sarkar <rohitsarkar5398@gmail.com> wrote:
>>>
>>>> The debugfs_create_file_unsafe method does not protect the fops given to
>>>> it from file removal. It must be used with DEFINE_DEBUGFS_ATTRIBUTE
>>>> which makes the fops aware of the file lifetime.
>>>>
>>>> Further using DEFINE_DEBUGFS_ATTRIBUTE along with
>>>> debugfs_create_file_unsafe significantly reduces the overhead introduced
>> by
>>>> debugfs_create_file which creates a lifetime managing proxy around each
>>>> fops handed in. Refer [1] for more on this.
>>>>
>>>> Fixes the following warnings reported by coccinelle:
>>>> drivers/iio/imu//adis16460.c:126:0-23: WARNING:
>> adis16460_flash_count_fops
>>>> should be defined with DEFINE_DEBUGFS_ATTRIBUTE
>>>> drivers/iio/imu//adis16460.c:108:0-23: WARNING:
>> adis16460_product_id_fops
>>>> should be defined with DEFINE_DEBUGFS_ATTRIBUTE
>>>> drivers/iio/imu//adis16460.c:90:0-23: WARNING:
>> adis16460_serial_number_fops
>>>> should be defined with DEFINE_DEBUGFS_ATTRIBUTE
>>>> drivers/iio/imu//adis16400.c:278:0-23: WARNING:
>> adis16400_flash_count_fops
>>>> should be defined with DEFINE_DEBUGFS_ATTRIBUTE
>>>> drivers/iio/imu//adis16400.c:261:0-23: WARNING:
>> adis16400_product_id_fops
>>>> should be defined with DEFINE_DEBUGFS_ATTRIBUTE
>>>>
>>>> [1]: https://lists.gt.net/linux/kernel/2369498
>>>>
>>>> Rohit Sarkar (2):
>>>>    iio: imu: adis16400: use DEFINE_DEBUGFS_ATTRIBUTE instead of
>>>>      DEFINE_SIMPLE_ATTRIBUTE
>>>>    iio: imu: adis16460: use DEFINE_DEBUGFS_ATTRIBUTE instead of
>>>>      DEFINE_SIMPLE_ATTRIBUTE
>>>>
>>>>   drivers/iio/imu/adis16400.c | 4 ++--
>>>>   drivers/iio/imu/adis16460.c | 6 +++---
>>>>   2 files changed, 5 insertions(+), 5 deletions(-)
>>>>
>>> Hi Rohit,
>>>
>>> You've opened a can of worms with this one.  There as a previous series
>>> posted doing exactly this change back in 2019 by Zhong Jiang (cc'd)
>>>
>>> At the time I did a bit of looking into why this had been universally taken
>>> up cross tree and turned out there are some potential issues.
>>>
>>> Alexandru added it to the list of things to test, but I guess it got
>>> buried under other work and is still outstanding.
>>>
>> yep
>> my bad;
>> will try to make room these days for that old one
>>
>>
> I don't have the exact parts that this patch is touching but I have other parts where this patch
> applies and should be same. So, the idea to test this is to read the files in debugfs? Maybe also
> some unbind + binding?
>
> I will try to test this still today...

The stress test is to open the debugfs file, then unbind the device and 
then read from the still open debugfs file.

- Lars
