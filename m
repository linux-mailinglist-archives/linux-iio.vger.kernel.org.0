Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06CB5CDFAF
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2019 12:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbfJGKwa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Oct 2019 06:52:30 -0400
Received: from first.geanix.com ([116.203.34.67]:55614 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727345AbfJGKwa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 7 Oct 2019 06:52:30 -0400
Received: from [192.168.100.95] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id D3F8A5089E;
        Mon,  7 Oct 2019 10:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1570445466; bh=IY+4RgioQxMyOvxxhDA8uq7gTwXBqdT684jdXdeS/10=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Trdxbg/NIYhujVu8Qst7xYMzRim4RISJI530zUbhgM2UEwcQTF4wm5DpNrSO++oPk
         ClWSjGTsClx7Z2rNGokPU0LOamEDyaS3LPIXwRUEe6ULIndGTka3DGhkhJ6gxVvTtX
         TTyzWzTd05ygHafsGID8c0CERyyWjXDJPYE0sPFQEyjdEy0v9NPZHupMsJVhbCi4HF
         qqbsqPR06Oh23VsVXaR9rdXK6IKWll8jfquezT1ZmyFSLDDSGLYZnnJuBiFocHyDw5
         uQOeAvVYl62Qf+Hqb6UEXgdejI3q5Gqs7QAaTLReKcX/Ss67+agMMM1qMZ9S1bIW88
         zzTKM99FGqndA==
Subject: Re: [BUG] iio: imu: st_lsm6dsx: read error when resuming from suspend
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>
References: <128e9528-593f-271b-708f-ef197c08f3bb@geanix.com>
 <20191007103409.GB3192@localhost.localdomain>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <6c48cab2-f674-7565-ad2d-5467d68ac84b@geanix.com>
Date:   Mon, 7 Oct 2019 12:51:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191007103409.GB3192@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF autolearn=disabled
        version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on b8b5098bc1bc
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 07/10/2019 12.34, Lorenzo Bianconi wrote:
>> Hi Lorenzo,
>>
> 
> Hi Sean,
> 
>> I'm seeing this error sometimes when resuming:
>> st_lsm6dsx_i2c 1-006a: failed to read fifo status (err=-13)
> 
> it seems the error is directly reported by regmap/i2c driver you are running,
> it is not related to the last series I sent.
> 
No not related :) The same error with or without the series ;)
>>
>> I doesn't matter if it's the ism330 or another wake source.
>> I have not enabled fifo readings.
>>
>> I have tried the "[PATCH 00/13] various st_lsm6dsx fixes and missing bits​"
>> same results.
>>
>> The regmap_read in st_lsm6dsx_handler_thread for the event seems to be
>> reading something as the event is reported correctly.
>>
>> Later events are reported correctly...
> 
> So IIUC the system just reports a sporadic error sometimes during resume but it
> is able to recover, right?
> Yes, it's sporadic and suspend/resume sometimes does this... and we are 
able to recover.
I just find it weird that regmap_read goes well and the next call to 
regmap_bulk_read (st_lsm6dsx_read_locked) gets "permission denied".

So all in all, just a heads up. Maybe we can ignore it for now :)

/Sean
