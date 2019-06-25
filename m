Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72ED855568
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2019 19:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbfFYREp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 25 Jun 2019 13:04:45 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58492 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727215AbfFYREp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Jun 2019 13:04:45 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id B33BB2604D6
Subject: Re: [PATCH v3 6/8] iio: common: cros_ec_sensors: support protocol v3
 message
To:     Jonathan Cameron <jic23@kernel.org>,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>
Cc:     kernel@collabora.com, Nick Vaccaro <nvaccaro@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>,
        Enrico Granata <egranata@chromium.org>
References: <cover.1560848479.git.fabien.lahoudere@collabora.com>
 <ac3cdc104e59565d178dfa86f2727045224dc4da.1560848479.git.fabien.lahoudere@collabora.com>
 <20190622111509.314d25bf@archlinux>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <373ba164-d174-9a2e-f9eb-ed0d6b7b4bb8@collabora.com>
Date:   Tue, 25 Jun 2019 19:04:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190622111509.314d25bf@archlinux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Fabien, Jonathan,

cc'ing Gwendal and Enrico who might be interested on this patch.

It'd be nice if we can land this patch before [1], otherwise the legacy support
for cros-ec sensors on veyron minnie won't work and we will mess the kernel log
with a couple of errors.

I just have a few comments that I think should be quick to respin.

[1] https://lkml.org/lkml/2019/6/24/1464

On 22/6/19 12:15, Jonathan Cameron wrote:
> On Tue, 18 Jun 2019 11:06:37 +0200
> Fabien Lahoudere <fabien.lahoudere@collabora.com> wrote:
> 
>> Version 3 of the EC protocol provides min and max frequencies for EC sensors.
>>

I think we are mixing two things. One is determine what version of the
MOTIONSENSE command the EC has, and another one is add some default values
supported by the third version. I'd split this in two separate patches, and fix
the subject and the commit description.


>> Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
>> Signed-off-by: Nick Vaccaro <nvaccaro@chromium.org>
> Looks good to me. I'll pick up next time if no one else raises any
> issues on this one.
> 
> Thanks,
> 
> Jonathan
> 
>> ---
>>  .../cros_ec_sensors/cros_ec_sensors_core.c    | 85 ++++++++++++++++++-
>>  .../linux/iio/common/cros_ec_sensors_core.h   |  3 +
>>  2 files changed, 87 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
>> index 57034e212fe1..2ce077b576a4 100644
>> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
>> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
>> @@ -26,6 +26,66 @@ static char *cros_ec_loc[] = {
>>  	[MOTIONSENSE_LOC_MAX] = "unknown",
>>  };
>>  
>> +static void get_default_min_max_freq(enum motionsensor_type type,
>> +				     u32 *min_freq,
>> +				     u32 *max_freq)
>> +{
>> +	switch (type) {
>> +	case MOTIONSENSE_TYPE_ACCEL:
>> +	case MOTIONSENSE_TYPE_GYRO:
>> +		*min_freq = 12500;
>> +		*max_freq = 100000;
>> +		break;
>> +	case MOTIONSENSE_TYPE_MAG:
>> +		*min_freq = 5000;
>> +		*max_freq = 25000;
>> +		break;
>> +	case MOTIONSENSE_TYPE_PROX:
>> +	case MOTIONSENSE_TYPE_LIGHT:
>> +		*min_freq = 100;
>> +		*max_freq = 50000;
>> +		break;
>> +	case MOTIONSENSE_TYPE_BARO:
>> +		*min_freq = 250;
>> +		*max_freq = 20000;
>> +		break;
>> +	case MOTIONSENSE_TYPE_ACTIVITY:
>> +	default:
>> +		*min_freq = 0;
>> +		*max_freq = 0;
>> +		break;
>> +	}
>> +}

This is the second part. It adds default values for version 3. I'd send this
part on the patch that adds support min/max freq.

>> +
>> +static int cros_ec_get_host_cmd_version_mask(struct cros_ec_device *ec_dev,
>> +					     u16 cmd_offset, u16 cmd, u32 *mask)
>> +{
>> +	int ret;
>> +	struct {
>> +		struct cros_ec_command msg;
>> +		union {
>> +			struct ec_params_get_cmd_versions params;
>> +			struct ec_response_get_cmd_versions resp;
>> +		};
>> +	} __packed buf = {
>> +		.msg = {
>> +			.command = EC_CMD_GET_CMD_VERSIONS + cmd_offset,
>> +			.insize = sizeof(struct ec_response_get_cmd_versions),
>> +			.outsize = sizeof(struct ec_params_get_cmd_versions)
>> +			},
>> +		.params = {.cmd = cmd}
>> +	};
>> +

nit: Actually when someone is sending a command to the EC there is a bit of mess
how to do it, some use dynamic allocations, other static. IMO is more readable
have something that explicitly initializes the struct and then assigns the
different fields. Something like this:


        struct {
                struct cros_ec_command cmd;
                union {
                        struct ec_params_get_cmd_versions params;
                        struct ec_response_get_cmd_versions resp;
                };
        } __packed msg = {};
        int ret;

        msg.cmd.command = EC_CMD_GET_CMD_VERSIONS + cmd_offset;
        msg.cmd.insize = sizeof(msg.resp);
        msg.cmd.outsize = sizeof(msg.params);
        msg.params.cmd = cmd;


>> +	ret = cros_ec_cmd_xfer_status(ec_dev, &buf.msg);
>> +	if (ret >= 0) {
>> +		if (buf.msg.result == EC_RES_SUCCESS)

Note that cros_ec_cmd_xfer_status returns a <0 on error and 0 or positive number
when EC_RES_SUCCESS. So no need to double check the result.

>> +			*mask = buf.resp.version_mask;
>> +		else
>> +			*mask = 0;
>> +	}
>> +	return ret;

So, I think that all this can be reworked as

        ret = cros_ec_cmd_xfer_status(ec_dev, &buf.msg);
        if (ret < 0)
                return ret;

        *mask = msg.resp.version_mask;

        return 0;


>> +}
>> +
>>  int cros_ec_sensors_core_init(struct platform_device *pdev,
>>  			      int num_channels,
>>  			      bool physical_device)
>> @@ -35,6 +95,8 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
>>  	struct cros_ec_dev *ec = dev_get_drvdata(pdev->dev.parent);
>>  	struct cros_ec_sensor_platform *sensor_platform = dev_get_platdata(dev);
>>  	struct iio_dev *indio_dev;
>> +	u32 ver_mask;
>> +	int ret;
>>  
>>  	if (num_channels > CROS_EC_SENSORS_CORE_MAX_CHANNELS)
>>  		return -EINVAL;
>> @@ -57,8 +119,16 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
>>  
>>  	mutex_init(&state->cmd_lock);
>>  
>> +	/* determine what version of MOTIONSENSE CMD EC has */

nit: Capitalize

>> +	ret = cros_ec_get_host_cmd_version_mask(state->ec,
>> +						ec->cmd_offset,
>> +						EC_CMD_MOTION_SENSE_CMD,
>> +						&ver_mask);

It will return <0 on error

>> +	if (ret < 0 || ver_mask == 0)
>> +		return -ENODEV;
>> +

so no need to check ver_mask

        if (ret < 0)
		return ret;


>>  	/* Set up the host command structure. */
>> -	state->msg->version = 2;
>> +	state->msg->version = fls(ver_mask) - 1;
>>  	state->msg->command = EC_CMD_MOTION_SENSE_CMD + ec->cmd_offset;
>>  	state->msg->outsize = sizeof(struct ec_params_motion_sense);
>>  
>> @@ -76,6 +146,19 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
>>  		}
>>  		state->type = state->resp->info.type;
>>  		state->loc = state->resp->info.location;
>> +
>> +		/* Value to stop the device */
>> +		state->frequency_range[0] = 0;
>> +		if (state->msg->version < 3) {
>> +			get_default_min_max_freq(state->resp->info.type,
>> +						 &state->frequency_range[1],
>> +						 &state->frequency_range[2]);
>> +		} else {
>> +			state->frequency_range[1] =
>> +			    state->resp->info_3.min_frequency;
>> +			state->frequency_range[2] =
>> +			    state->resp->info_3.max_frequency;
>> +		}

This is part of the second patch.

>>  	}
>>  
>>  	indio_dev->info = &state->info;
>> diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include/linux/iio/common/cros_ec_sensors_core.h
>> index 3e6de427076e..89937ad242ef 100644
>> --- a/include/linux/iio/common/cros_ec_sensors_core.h
>> +++ b/include/linux/iio/common/cros_ec_sensors_core.h
>> @@ -74,6 +74,9 @@ struct cros_ec_sensors_core_state {
>>  	int curr_sampl_freq;
>>  	struct iio_info info;
>>  	struct iio_chan_spec channels[CROS_EC_SENSORS_CORE_MAX_CHANNELS];
>> +
>> +	/* Disable, Min and Max Sampling Frequency in mHz */
>> +	int frequency_range[3];
>>  };
>>  
>>  /**
> 
> 

As I said I'd send a first patch with the EC protocol bits separated of this
patchset and create a second patch into this patchset with the min/max frequency
bits.

Thanks,
~ Enric
