Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50302A9A15
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2019 07:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731140AbfIEFaK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 5 Sep 2019 01:30:10 -0400
Received: from first.geanix.com ([116.203.34.67]:35488 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731070AbfIEFaJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 5 Sep 2019 01:30:09 -0400
Received: from [192.168.100.95] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id 18F0B63355;
        Thu,  5 Sep 2019 05:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1567661398; bh=z4KAw3upBKjYBdpWRtVdqj7FD7t2rjeDmL/gvJoAb/w=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=AUQ+eqjNTkiTtOKI5A9VifzHTV1OM/EyqCpm/qrUVtI/4nMwslJfNrnUpccDtICB8
         mxH1S8BHMRmtrrkA4GzDQRnb3l+IkdB2pkjBm19ZooOImUuSCO7cJcOBoJ1XiXtrg8
         T3w/KQkS4vWx/Hsdu2GknHHNW0KqGpXeGGFek+6eApHsWrefdoQRZGhZdFgWzq1WDj
         eEJyGcgvcZOP9bXsnG1cmGwe0mSSWyc3l20WjDVE25/8ZG5+lCj6HtIIoEmEHs2Wjv
         ZzP7eJRzkAhnF1ScYMUaZJX4Y/I3NML7KxUQzpJ/EXwC1wQq4DSxp5KS2laDFzJKw1
         NtvkPlqTR2bPg==
Subject: Re: [PATCH v3 2/6] iio: imu: st_lsm6dsx: add motion events
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
References: <20190904091732.112281-1-sean@geanix.com>
 <20190904091732.112281-2-sean@geanix.com>
 <20190904172400.GC2058@localhost.localdomain>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <d838c0a5-5396-de79-5ad3-45e421dda109@geanix.com>
Date:   Thu, 5 Sep 2019 07:29:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904172400.GC2058@localhost.localdomain>
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



On 04/09/2019 19.24, Lorenzo Bianconi wrote:

[..]

>> +	.scan_index = scan_idx,						\
>> +	.scan_type = {							\
>> +		.sign = 's',						\
>> +		.realbits = 16,						\
>> +		.storagebits = 16,					\
>> +		.endianness = IIO_LE,					\
>> +	},								\
>> +	.event_spec = &st_lsm6dsx_event,				\
>> +	.num_event_specs = 1,						\
>> +}
>> +
>>   #define ST_LSM6DSX_CHANNEL(chan_type, addr, mod, scan_idx)		\
> 
> I guess you can rename ST_LSM6DSX_CHANNEL in ST_LSM6DSX_CHANNEL_GYRO now
> 

We still have the channels for the magnetometer, which are similar to 
the gyro channels :-)

>>   {									\
>>   	.type = chan_type,						\
>> @@ -162,6 +183,13 @@ struct st_lsm6dsx_shub_settings {
>>   	u8 batch_en;
>>   };
>>   

/Sean
