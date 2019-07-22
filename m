Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42655702B3
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2019 16:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbfGVOxq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Jul 2019 10:53:46 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37306 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfGVOxq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Jul 2019 10:53:46 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id BDD5428A146
Subject: Re: [PATCH v4 1/4] iio: cros_ec: Add sign vector in core for backward
 compatibility
To:     Jonathan Cameron <jic23@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>
Cc:     bleung@chromium.org, groeck@chromium.org,
        fabien.lahoudere@collabora.com, dianders@chromium.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190628191711.23584-1-gwendal@chromium.org>
 <20190628191711.23584-2-gwendal@chromium.org>
 <20190714173203.0b50d5c7@archlinux>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <3729385a-6628-22e1-da50-e22233737a4b@collabora.com>
Date:   Mon, 22 Jul 2019 16:53:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190714173203.0b50d5c7@archlinux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

On 14/7/19 18:32, Jonathan Cameron wrote:
> On Fri, 28 Jun 2019 12:17:08 -0700
> Gwendal Grignou <gwendal@chromium.org> wrote:
> 
>> To allow cros_ec iio core library to be used with legacy device, add a
>> vector to rotate sensor data if necessary: legacy devices are not
>> reporting data in HTML5/Android sensor referential.
>>
>> Check the data is not rotated on recent chromebooks that use the HTML5
>> standard to present sensor data.
>>
>> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
>> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> As I mentioned in one of the other series.  I've lost track of whether
> anyone wants me to apply any of these through IIO, so will just ack
> them as appropriate and assume someone will shout if they do want
> me to pick them up ;)
> 

To try to give you a bit of light on this, all the required changes in
chrome-platform are now in upstream so all the patches can go safely through
your tree. The order to pick the patches is as follow:


1096491 [v4,1/1] iio: common: cros_ec_sensors: determine protocol version

1100922 [v6,1/4] iio: cros_ec: Add sign vector in core for backward
                 compatibility
1100924 [v6,3/4] iio: cros_ec_accel_legacy: Use cros_ec_sensors_core
1100923 [v6,4/4] iio: cros_ec_accel_legacy: Add support for veyron-minnie

1100982 [v5,1/1] iio: common: cros_ec_sensors: Expose cros_ec_sensors frequency
                 range via iio sysfs

But if you try to apply latest versions from patchwork you'll get some trivial
conflicts. So, I fixed the problems, rebased on top of your testing branch,
added my Rb tag to all the patches and put together in this branch [1]

All the patches have your Ack, so should be fine if you apply all of them just
replacing your Ack for your Signed-off

I can also send a new patch series with those if you prefer this option.

Hopefully is more clear now and sorry for that mess.
~ Enric

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git/log/?h=for-iio-next


> Thanks,
> 
> Jonathan
> 
>> ---
>>  drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 4 ++++
>>  include/linux/iio/common/cros_ec_sensors_core.h           | 1 +
>>  2 files changed, 5 insertions(+)
>>
>> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
>> index 719a0df5aeeb..e8a4d78659c8 100644
>> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
>> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
>> @@ -66,6 +66,9 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
>>  		}
>>  		state->type = state->resp->info.type;
>>  		state->loc = state->resp->info.location;
>> +
>> +		/* Set sign vector, only used for backward compatibility. */
>> +		memset(state->sign, 1, CROS_EC_SENSOR_MAX_AXIS);
>>  	}
>>  
>>  	return 0;
>> @@ -254,6 +257,7 @@ static int cros_ec_sensors_read_data_unsafe(struct iio_dev *indio_dev,
>>  		if (ret < 0)
>>  			return ret;
>>  
>> +		*data *= st->sign[i];
>>  		data++;
>>  	}
>>  
>> diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include/linux/iio/common/cros_ec_sensors_core.h
>> index ce16445411ac..a1c85ad4df91 100644
>> --- a/include/linux/iio/common/cros_ec_sensors_core.h
>> +++ b/include/linux/iio/common/cros_ec_sensors_core.h
>> @@ -71,6 +71,7 @@ struct cros_ec_sensors_core_state {
>>  	enum motionsensor_location loc;
>>  
>>  	s16 calib[CROS_EC_SENSOR_MAX_AXIS];
>> +	s8 sign[CROS_EC_SENSOR_MAX_AXIS];
>>  
>>  	u8 samples[CROS_EC_SAMPLE_SIZE];
>>  
> 
