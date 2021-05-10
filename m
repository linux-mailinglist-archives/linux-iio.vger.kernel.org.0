Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 160DA377C77
	for <lists+linux-iio@lfdr.de>; Mon, 10 May 2021 08:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbhEJGmL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 May 2021 02:42:11 -0400
Received: from first.geanix.com ([116.203.34.67]:53626 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229863AbhEJGmL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 10 May 2021 02:42:11 -0400
Received: from [192.168.100.10] (unknown [185.233.254.173])
        by first.geanix.com (Postfix) with ESMTPSA id 24CA9468733;
        Mon, 10 May 2021 06:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1620628863; bh=BZsHyvKkcHMBhTQzhatvVIgBZci74t801/6tnFGIu7g=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=OHD2PPCXyRxX3EZ4r2uPtmWH0lDKXTsI8MetGc6vliV/1eGnHsB2W42UEZ9hCtJGp
         N+0ABzPH0WPdtYJG9sv2ryUUQcqxWWKGz+SwsrWscyTS4iNEWT6zUfXbqMS9hASVlp
         fGl1uvFsFEelbuQyaa4jyOaBoNIktIomnSzUuZcYc1CB1fdiMB0EzgbUlZXmDb3tql
         p0qHIjfbDvdaRZeuLIQdUh4cat+ymR29FyGLBmuNa6kfr+SWdKpX0deH0+AUrhLs/v
         bncqJGqMQbuViCBmPeBpkiNoB+Li3OluDEYVmwleeaCYiViA6qEBT6eMgjlt8sprYN
         mSxSPEitT1e0A==
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: do not roundup set samplerate
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     lorenzo.bianconi83@gmail.com, jic23@kernel.org,
        linux-iio@vger.kernel.org
References: <20210507103220.2194009-1-sean@geanix.com>
 <YJUeKhjooi8lAN1Q@lore-desk>
 <d0b62523-dcc9-ff14-aeaf-db24915f7aeb@geanix.com>
 <YJjSfpTfSMqf3w0v@lore-desk>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <303a2899-2aff-410f-3bce-e40a7d7637e9@geanix.com>
Date:   Mon, 10 May 2021 08:41:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YJjSfpTfSMqf3w0v@lore-desk>
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

On 10/05/2021 08.28, Lorenzo Bianconi wrote:
>> On 07/05/2021 13.02, Lorenzo Bianconi wrote:
>>>> The correct way to set the sampling rate to 12.5 Hz before
>>>> commit f8710f0357bc ("iio: imu: st_lsm6dsx: express odr in mHZ")
>>>> was to write 13 Hz to sampling_frequency.
>>>> Before this patch writing 13 to samplerate results in sample rate set
>>>> to 26 Hz.
>>>> Now we return EINVAL if the sampling rate is not in table.
>>>>
>>>> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
>>>
>>> I think this patch is breaking i2c-master support available in st_lsm6dsx, have you tested it?
>>>
>> I have not tested with i2c-master.
>> But it's not nice to round up sample rate from user space without any notice.
> 
> the point is accel odr is used as trigger for i2c-slave sampling. Connected
> i2c slave devices have different sample rates (e.g. LIS2MDL), so we need to
> select the lower accel odr greather than slave device one.
> 
> Regards,
> Lorenzo
> 

We could open up for custom sample rates if i2c-slaves are enabled?
/Sean
