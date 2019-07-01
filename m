Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7AB5BA4E
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jul 2019 13:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbfGALGa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 1 Jul 2019 07:06:30 -0400
Received: from first.geanix.com ([116.203.34.67]:50192 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728213AbfGALGa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 1 Jul 2019 07:06:30 -0400
Received: from [192.168.100.94] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id C706F1697;
        Mon,  1 Jul 2019 11:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1561979133; bh=v4LHxOwn9+/VM2loVjnq0LB4IqNtrmoRjYxa9zumqdU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=O7/xWHXOk/TLkM4uagNM44WSOkUR3K+qI/JHSj+96KIiPNfkYsfnTJg0GntQQiT7G
         EX6SKxr0DbMLcX1n7+mf0mQKMfp6z7AJcOmXICQ135AKlXFcfwG7FBjs9lc71kn3zc
         /iTaug0E5CSSzxfz4917DqjBse38nH2Fg3rSq+8d4md7yBrQJeci/6SgjWLE4OkaRS
         ntvLfPlrpviIt82+7oa2oGt35VAtHmNfwUpgMmcgfEaTgm3m3c0s/be8g/XI+FVs9e
         5dpxUc5TrVcDobZCvMrHsbSKCfckKfJGvmQlyf1pQWmFr0BkP2ObHQlFuQQjgRN9qE
         kLlZS/JHGk40A==
Subject: Re: [PATCH 3/5] iio: imu: st_lsm6dsx: add wakeup-source option
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com, martin@geanix.com
References: <20190618125939.105903-1-sean@geanix.com>
 <20190618125939.105903-4-sean@geanix.com>
 <20190618155122.GC20044@localhost.localdomain>
 <d7bcc9a5-37ae-d65a-7841-4468d49bb8bd@geanix.com>
 <20190618202745.GC930@localhost.localdomain>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <771dad97-a46e-4d3a-467b-d20bc7a70679@geanix.com>
Date:   Mon, 1 Jul 2019 13:06:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190618202745.GC930@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on 884f5ce5917a
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 18/06/2019 22.27, Lorenzo Bianconi wrote:
> On Jun 18, Sean Nyekjaer wrote:
>>
>>
>> On 18/06/2019 17.51, Lorenzo Bianconi wrote:
>>>> this add ways for the SoC to wake from accelerometer wake events.
>>>>
>>>> In the suspend function we skip disabling the sensor if wakeup-source
>>>> and events are activated.
>>>>
>>>> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
>>>> ---
>>>>    drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 15 +++++++++++++++
>>>>    1 file changed, 15 insertions(+)
>>>>
>>>> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
>>>> index 351c46f01662..59a34894e495 100644
>>>> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
>>>> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
>>>> @@ -1076,6 +1076,10 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id, const char *name,
>>>>    			return err;
>>>>    	}
>>>> +	if (dev->of_node)
>>>> +		if (of_property_read_bool(dev->of_node, "wakeup-source"))
>>>> +			device_init_wakeup(dev, true);
>>>> +
>>>>    	return 0;
>>>>    }
>>>>    EXPORT_SYMBOL(st_lsm6dsx_probe);
>>>> @@ -1088,6 +1092,12 @@ static int __maybe_unused st_lsm6dsx_suspend(struct device *dev)
>>>>    	int i, err = 0;
>>>>    	for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
>>>> +		if (device_may_wakeup(dev) && (i == ST_LSM6DSX_ID_ACC)) {
>>>> +			/* Enable wake from IRQ */
>>>> +			enable_irq_wake(hw->irq);
>>>> +			continue;
>>>
>>> This is breaking buffering mode
>>
>> Hmm, what is missing? :-)
>> We need the accelerometer to continue to run in suspend, but skip writing to
>> the internal fifo.
> 
> I think we should keep the accel enabled, but we need to put the FIFO in bypas
> mode
> 

I think it's exactly whats happening here, we keep the accel enabled and 
set the FIFO in bypass mode after.
st_lsm6dsx_flush_fifo (which sets the bypass mode) is called after the 
for loop.

/Sean
