Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDE0F28044B
	for <lists+linux-iio@lfdr.de>; Thu,  1 Oct 2020 18:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732609AbgJAQwV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Oct 2020 12:52:21 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39124 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732016AbgJAQwV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Oct 2020 12:52:21 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id A8E2029CF83
Subject: Re: [PATCH v2] iio: cros_ec: Use default frequencies when EC returns
 invalid information
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Gwendal Grignou <gwendal@chromium.org>, bleung@chromium.org,
        lars@metafoo.de, linux-iio@vger.kernel.org
References: <20200630153730.3302889-1-gwendal@chromium.org>
 <c1a187a7-1610-65d6-3636-796cd15cba08@collabora.com>
 <20200704174437.11794ac9@archlinux> <20200926162021.46053cfa@archlinux>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <5df1edd8-6ac9-29d0-199a-8ea620fbb329@collabora.com>
Date:   Thu, 1 Oct 2020 18:52:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200926162021.46053cfa@archlinux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

Sorry for the late reply.

On 26/9/20 17:21, Jonathan Cameron wrote:
> On Sat, 4 Jul 2020 17:44:37 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
>> On Tue, 30 Jun 2020 17:50:24 +0200
>> Enric Balletbo i Serra <enric.balletbo@collabora.com> wrote:
>>
>>> Hi Gwendal,
>>>
>>> On 30/6/20 17:37, Gwendal Grignou wrote:  
>>>> Minimal and maximal frequencies supported by a sensor is queried.
>>>> On some older machines, these frequencies are not returned properly and
>>>> the EC returns 0 instead.
>>>> When returned maximal frequency is 0, ignore the information and use
>>>> default frequencies instead.
>>>>
>>>> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>    
>>>
>>> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>  
>>
>> Fix or tidy up? I.e. does this want to go into stable?
> 
> I've still not applied this one due to the above question.
> 
> If I don't hear reasonably soon I'll guess tidy up and queue
> it up.
> 

I think that should be a fix, although it might require some backport effort to
apply the patch cleanly on older stable versions as there were some changes
between the problem was introduced and the fix.

Fixes: ae7b02ad2f32 ("iio: common: cros_ec_sensors: Expose cros_ec_sensors
frequency range via iio sysfs")

Thanks,
 Enric

> Thanks,
> 
> Jonathan
> 
>>
>> Thanks,
>>
>> Jonathan
>>
>>>   
>>>> ---
>>>> Changes since v1:
>>>> - improve visibility by using new 100 character line length limit.
>>>>
>>>>  .../cros_ec_sensors/cros_ec_sensors_core.c       | 16 +++++++++++-----
>>>>  1 file changed, 11 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
>>>> index 36e3f20891f05..b30fd6b56773f 100644
>>>> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
>>>> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
>>>> @@ -289,7 +289,7 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
>>>>  	struct cros_ec_sensorhub *sensor_hub = dev_get_drvdata(dev->parent);
>>>>  	struct cros_ec_dev *ec = sensor_hub->ec;
>>>>  	struct cros_ec_sensor_platform *sensor_platform = dev_get_platdata(dev);
>>>> -	u32 ver_mask;
>>>> +	u32 ver_mask, temp;
>>>>  	int frequencies[ARRAY_SIZE(state->frequencies) / 2] = { 0 };
>>>>  	int ret, i;
>>>>  
>>>> @@ -345,10 +345,16 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
>>>>  						 &frequencies[2],
>>>>  						 &state->fifo_max_event_count);
>>>>  		} else {
>>>> -			frequencies[1] = state->resp->info_3.min_frequency;
>>>> -			frequencies[2] = state->resp->info_3.max_frequency;
>>>> -			state->fifo_max_event_count =
>>>> -			    state->resp->info_3.fifo_max_event_count;
>>>> +			if (state->resp->info_3.max_frequency == 0) {
>>>> +				get_default_min_max_freq(state->resp->info.type,
>>>> +							 &frequencies[1],
>>>> +							 &frequencies[2],
>>>> +							 &temp);
>>>> +			} else {
>>>> +				frequencies[1] = state->resp->info_3.min_frequency;
>>>> +				frequencies[2] = state->resp->info_3.max_frequency;
>>>> +			}
>>>> +			state->fifo_max_event_count = state->resp->info_3.fifo_max_event_count;
>>>>  		}
>>>>  		for (i = 0; i < ARRAY_SIZE(frequencies); i++) {
>>>>  			state->frequencies[2 * i] = frequencies[i] / 1000;
>>>>     
>>
> 
