Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99FD4B3A04
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2019 14:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfIPMJt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Sep 2019 08:09:49 -0400
Received: from first.geanix.com ([116.203.34.67]:57086 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726875AbfIPMJt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 16 Sep 2019 08:09:49 -0400
Received: from [192.168.100.95] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id 6D1E465209;
        Mon, 16 Sep 2019 12:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1568635727; bh=vV+dNPbyKM0M7C7Cgb62j35UoJ1/H6NAZMyY7vurl5I=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=XSgL0zammiFk0gSXRLtbBT5sbJ9c9gXgoKWPMWRIgI9RFGfqg9M2X+czgtXMbBqRs
         KP/QG84o3n9vtNhKIGLEZF7gKPmJVunjcsCqLisrKj7EhDIgeIKcadx4SMdStUpz+R
         iu9vuAGxUd0xhNPMOJoYWh84IeMdmhIG4tQf37OE38lF+CVS6Gb7gaRQY5NAHa7YP7
         FjaJ1sDqkn/atOfvTixS6aLwiiSHrt1QIMycqyOiM1UpzeoiHWc4ZmCY3EglyofBAR
         E0fhuPCDum2siUfGAqVX/t/5hgACAUpMSBRjv+llOi8o1FuV661RqQkn8zBXIBj0Yd
         F9ThkdlNsVMRQ==
Subject: Re: [RFC PATCH] iio: imu: st_lsm6dsx: filter motion events in driver
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
References: <20190915143548.25383eb4@archlinux>
 <20190916090222.597444-1-sean@geanix.com>
 <20190916091649.GA16063@localhost.localdomain>
 <07c96bca-f952-71c0-4608-30746fbbc055@geanix.com>
 <20190916115538.GC16063@localhost.localdomain>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <88815877-abde-8e2a-cb3d-fabb556ad7e5@geanix.com>
Date:   Mon, 16 Sep 2019 14:09:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190916115538.GC16063@localhost.localdomain>
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



On 16/09/2019 13.55, Lorenzo Bianconi wrote:
>>
>>
>> On 16/09/2019 11.16, Lorenzo Bianconi wrote:
>>>> +	if (hw->event_en_mask & BIT(chan->channel2))
>>>> +		goto out;
>>> Why do we need this?
>>>
>>
>> Guess we need to check if 0 < hw->enable_event before disabling the
>> sensor...
>>>> +
>>>>    	/* do not enable events if they are already enabled */
>>>>    	if (state && hw->enable_event)
>>>> -		return 0;
>>>> +		goto out;
>>
>> static int st_lsm6dsx_write_event_config(struct iio_dev *iio_dev,
>>                                             const struct iio_chan_spec *chan,
>>                                             enum iio_event_type type,
>>                                             enum iio_event_direction dir,
>>                                             int state)
>> {
>>          struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
>>          struct st_lsm6dsx_hw *hw = sensor->hw;
>>          u8 _enable_event;
> 
> please use enable_event instead of _enable_event
> 
>>          int err = 0;
>>
>>          if (type != IIO_EV_TYPE_THRESH)
>>                  return -EINVAL;
>>
>>          if (state) {
>>                  _enable_event = hw->enable_event | BIT(chan->channel2);
>>
>>                  /* do not enable events if they are already enabled */
>>                  if (0 < hw->enable_event)
>>                          goto out;
> 
> we do not need this since there is the check:
> if (hw->enable_event == enable_event)
> 	return 0;

I actually think this is needed as if a channel is enabled and another 
channel is enabled, then 'state' will be 1 and '0 < hw->enable_event' is 
true. Then we don't want to do the event_setup again.

> 
>>          } else {
>>                  _enable_event = hw->enable_event & ~BIT(chan->channel2);
>>
>>                  /* only turn off sensor if no events is enabled */
>>
>>
>>
>>
>>                  if (0 != _enable_event)
>>                          goto out;
> 
> we do not need this as well
Like wise here, if we don't have this and to channels is enabled, if you 
deactivate one of the channels then enable_event indicates that a 
channel is active but the sensor is disabled.
Guess that is not what we want :-)

> 
>>          }
>>
>>          /* stop here if no changes have been made */
>>          if (hw->enable_event == _enable_event)
>>                  return 0;
>>
>>          err = st_lsm6dsx_event_setup(hw, state);
>>          if (err < 0)
>>                  return err;
>>

