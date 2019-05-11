Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44BF01A7E6
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2019 14:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbfEKMyU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 May 2019 08:54:20 -0400
Received: from first.geanix.com ([116.203.34.67]:42918 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbfEKMyU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 11 May 2019 08:54:20 -0400
Received: from [192.168.100.11] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id 440EA9D3;
        Sat, 11 May 2019 12:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1557579199; bh=enGKPxETzVyn34Ek8mwvP6+AZ9zHMbxWaDdloWcqYo0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Og37ykH91An6aKfPtllGQbJ4b7vnuqe9BSiPt8tX1b1sjxq+FggCq+fvebS06Kqz8
         pc9GLSWeCZjUkQ58IKoQg7wdBDfqMLcLfjJG7p10iRJZspjyhkmD6hHCZOVkuaPLHq
         UP34ac4lPBGz/QfIRwyeaWBUF5MSpJIDUG83mEJ9Tr1lLP4BkGAhfeGH14WN4ococE
         6eLnpEoSbtthlCJAf1vCXu/Hz3C78HWqvEcEQdS8legLjljcaNZiADLsnlhDZDfs+W
         x4FGqUrRwxAA5/VXlAnbDoFuU1+VJgfIU1DMpZ4YsBMoBwvqbIC7f918nq0Ci5lnvE
         wOi3c4VDelBrw==
Subject: Re: [PATCH 2/2] iio: imu: st_lsm6dsx: add iio trigger and buffer
 support
To:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, martin@geanix.com,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Denis CIOCCA <denis.ciocca@st.com>
References: <20190507080225.108000-1-sean@geanix.com>
 <20190507080225.108000-2-sean@geanix.com> <20190511123755.2d220233@archlinux>
 <20190511123054.GA14837@localhost.localdomain>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <a8dc4bcc-b004-b287-2126-7c3b082dd3ba@geanix.com>
Date:   Sat, 11 May 2019 14:54:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190511123054.GA14837@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on 9cf0eadf640b
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 11/05/2019 14.30, Lorenzo Bianconi wrote:
>> On Tue,  7 May 2019 10:02:25 +0200
>> Sean Nyekjaer <sean@geanix.com> wrote:
>>
>>> This adds support for using iio triggers, this is needed because
>>> our hardware guys forgot to connect the irq pins from imu device
>>> to the SoC.
>>>
>>> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
>> Hi Sean
>>
>> A small question on the size of the buffer needed inline.  Otherwise looks
>> good to me.
> 
> Hi Sean,
> 
> this patch does not make sense to me since running st_lsm6dsx_read_oneshot
> you need to wait to power up the device (and you will power it down at the
> end). I guess you will not be able to read at a given ODR (e.g. 416Hz).
> Moreover you can't read from the hw fifo without the irq line since
> you need to read a full pattern from it in order to maintain the alignment.
We are not using the hw fifo if the hw irq isn't present...
So if I understand correctly we could speed things up a bit, with 
leaving the sensor powered by implementing a new reading function and
calling st_lsm6dsx_sensor_set_enable when we enable the trigger?

>  From my point of view you have 2 possibility:
> - poll the output registers from userspace (this is what you are actually
>    doing from inside the kernel, what is the advantage of doing so?)
Yes this is exactly what I'm trying to accomplish here.
It would be nice for us to have the same hrtimer/trigger to sample this 
and our adc.

> - fix the hw bug
Not possible on +20K devices. ;-)

> 
> Moreover if I read the patch correctly it has a NULL pointer dereference bug
> since hw->iio_devs[i] can be NULL (e.g. if sensor hub is disabled)
Right above, there is:
if (!hw->iio_devs[i])
	return -ENOMEM;

Should be enough...
> 
> Regards,
> Lorenzo
> 

BR
/Sean
