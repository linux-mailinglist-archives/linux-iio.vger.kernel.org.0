Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5525B20F8D0
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jun 2020 17:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389599AbgF3Pta (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 30 Jun 2020 11:49:30 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35184 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389703AbgF3Pt3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 30 Jun 2020 11:49:29 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 0E0F02A4F06
Subject: Re: [PATCH] iio: cros_ec: Use default frequencies when EC returns
 invalid information
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>
References: <20200630075933.3056990-1-gwendal@chromium.org>
 <6ef3d7ea-31f3-09fb-f0c0-61e9999e5761@collabora.com>
 <CAPUE2utjuPH3pkW3jTD272-BMZXN+rw+x+3ZvJ343zfEmUqc+w@mail.gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <3ede746e-7cd7-30e3-bf8c-e7dd954be74f@collabora.com>
Date:   Tue, 30 Jun 2020 17:49:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAPUE2utjuPH3pkW3jTD272-BMZXN+rw+x+3ZvJ343zfEmUqc+w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Gwendal,

On 30/6/20 17:31, Gwendal Grignou wrote:
> On Tue, Jun 30, 2020 at 8:12 AM Enric Balletbo i Serra
> <enric.balletbo@collabora.com> wrote:
>>
>> Hi Gwendal,
>>
>> Thank you for the patch.
>>
>> On 30/6/20 9:59, Gwendal Grignou wrote:
>>> Minimal and maximal frequencies supported by a sensor is queried.
>>> On some older machines, these frequencies are not returned properly and
>>> the EC returns 0 instead.
>>> When returned maximal frequency is 0, ignore the information and use
>>> default frequencies instead.
>>>
>>> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
>>> ---
>>>  .../common/cros_ec_sensors/cros_ec_sensors_core.c | 15 ++++++++++++---
>>>  1 file changed, 12 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
>>> index 36e3f20891f05..8437ff659260b 100644
>>> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
>>> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
>>> @@ -289,7 +289,7 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
>>>       struct cros_ec_sensorhub *sensor_hub = dev_get_drvdata(dev->parent);
>>>       struct cros_ec_dev *ec = sensor_hub->ec;
>>>       struct cros_ec_sensor_platform *sensor_platform = dev_get_platdata(dev);
>>> -     u32 ver_mask;
>>> +     u32 ver_mask, temp;
>>>       int frequencies[ARRAY_SIZE(state->frequencies) / 2] = { 0 };
>>>       int ret, i;
>>>
>>> @@ -345,8 +345,17 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
>>>                                                &frequencies[2],
>>>                                                &state->fifo_max_event_count);
>>>               } else {
>>> -                     frequencies[1] = state->resp->info_3.min_frequency;
>>> -                     frequencies[2] = state->resp->info_3.max_frequency;
>>> +                     if (state->resp->info_3.max_frequency == 0) {
>>
>> I might miss some use cases but I am wondering if this can be OR'ed with the
>> above if, so there is only one call to get_default_min_max_freq
>>
>>> +                             get_default_min_max_freq(state->resp->info.type,
>>> +                                                      &frequencies[1],
>>> +                                                      &frequencies[2],
>>> +                                                      &temp);
>>
>> and use &state->fifo_max_event_count instead of temp, so you don't need to
>> create a new variable that is not used anymore. Or is in purpose?
> It is on purpose: on some machines, min_frequency and max_frequency
> are both 0, but fifo_max_event_count is correct and should be used.

Thanks for the explanation, good to know :-)

>>
>>> +                     } else {
>>> +                             frequencies[1] =
>>> +                                     state->resp->info_3.min_frequency;
>>
>> nit: I think that you can take advantage of the new 100 character line length
>> limit, here.
> Fixed in the next patch.
>>
>>> +                             frequencies[2] =
>>> +                                     state->resp->info_3.max_frequency;
>>
>> nit: ditto
>>
>>> +                     }
>>>                       state->fifo_max_event_count =
>>>                           state->resp->info_3.fifo_max_event_count;
>>>               }
>>>
