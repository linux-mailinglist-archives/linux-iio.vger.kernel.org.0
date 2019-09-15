Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A070BB2FD6
	for <lists+linux-iio@lfdr.de>; Sun, 15 Sep 2019 14:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730435AbfIOMZZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Sep 2019 08:25:25 -0400
Received: from first.geanix.com ([116.203.34.67]:44802 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730163AbfIOMZY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Sep 2019 08:25:24 -0400
Received: from [192.168.100.95] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id CD3C96564B;
        Sun, 15 Sep 2019 12:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1568550268; bh=iYyauV8bSoS2bU1s+MJsHZK0wCDmmigNY7LT7v6Fes4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=cWcM0W0nqtFq2Cp4RUJVzsyJxMRdyKGaxewPqOVkToV8cdzRhjAnDFoKzcv+HrHWY
         qkXlDBBL4VvPz8OIqo/VMP/S0ZFTQgghzQzatuIktlb5HDT21eJCJzPJICAvpMub5E
         vDyoqymjeoKZSEc4/jtK64CpbsKZuZaaDoxnmpIuJjs8LEd7SOP3pyLI7xHP7fyAwk
         ohsBEgLlN4jRiS0O6l7o6f0QpzOdEOUdHqB7r0C/h6jeP14wVV1smO6S9YW23KIH7R
         zXRrHvpzuoGnClkjiiNAVBcgCEVbfBx6aCRyg/w1NZ0QwkwFz01LBBB7Sfp1mK19bP
         aKXo0qpwwFdAg==
Subject: Re: [PATCH v6 5/6] iio: imu: st_lsm6dsx: add motion report function
 and call from interrupt
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, lorenzo.bianconi83@gmail.com,
        denis.ciocca@st.com, mario.tesi@st.com, armando.visconti@st.com,
        martin@geanix.com
References: <20190909112846.55280-1-sean@geanix.com>
 <20190909112846.55280-5-sean@geanix.com>
 <4167d81f-6136-f9f9-cb6b-02b423799762@geanix.com>
 <20190915132038.0ed74957@archlinux>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <c912fbff-8277-cd99-515e-dd4239f8e220@geanix.com>
Date:   Sun, 15 Sep 2019 14:24:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190915132038.0ed74957@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
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



On 15/09/2019 14.20, Jonathan Cameron wrote:
> On Mon, 9 Sep 2019 13:51:13 +0200
> Sean Nyekjaer <sean@geanix.com> wrote:
> 
>> On 09/09/2019 13.28, Sean Nyekjaer wrote:
>>> Report iio motion events to iio subsystem
>>>
>>> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
>>> ---
>>> Changes since v4:
>>>    * Updated bitmask as pr Jonathans comments
>>>
>>> Changes since v5:
>>>    * None
>>>
>>>    drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  5 ++
>>>    drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 70 ++++++++++++++++++++
>>>    2 files changed, 75 insertions(+)
>>>    
>> [...]
>>>    
>>> +void st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw *hw, int data)
>>> +{
>>> +	s64 timestamp = iio_get_time_ns(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
>>> +
>>> +	if (data & hw->settings->event_settings.wakeup_src_z_mask)
>>> +		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
>>> +			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
>>> +						  0,
>>> +						  IIO_MOD_Z,
>>> +						  IIO_EV_TYPE_THRESH,
>>> +						  IIO_EV_DIR_EITHER),
>>> +						  timestamp);
>>> +
>>> +	if (data & hw->settings->event_settings.wakeup_src_x_mask)
>>> +		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
>>> +			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
>>> +						  0,
>>> +						  IIO_MOD_Y,
>>> +						  IIO_EV_TYPE_THRESH,
>>> +						  IIO_EV_DIR_EITHER),
>>> +						  timestamp);
>>> +
>>> +	if (data & hw->settings->event_settings.wakeup_src_x_mask)
>>> +		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
>>> +			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
>>> +						  0,
>>> +						  IIO_MOD_X,
>>> +						  IIO_EV_TYPE_THRESH,
>>> +						  IIO_EV_DIR_EITHER),
>>> +						  timestamp);
>>> +}
>>> +
>>
>> I was looking at this again, and if the user enables events for channel
>> x, we continue to report events for y, z.
>> Is it okay or is it better to filter them out?
> Better to filter them out.  It'll be a bit of a surprise for userspace
> otherwise.
> 
> Thanks,
> 
> Jonathan
> 
Okay, but keep in mind that we can't distinguish which channel we're 
waking up to. So even if some channel is disabled, we still wake up on 
it ...

/Sean
