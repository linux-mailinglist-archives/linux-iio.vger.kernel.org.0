Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50CF358641
	for <lists+linux-iio@lfdr.de>; Thu, 27 Jun 2019 17:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbfF0PtC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Jun 2019 11:49:02 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47070 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbfF0PtC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Jun 2019 11:49:02 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 9D6C2285135
Subject: Re: [PATCH 2/2] iio: common: cros_ec_sensors: set default frequencies
To:     Fabien Lahoudere <fabien.lahoudere@collabora.com>
Cc:     kernel@collabora.com, Nick Vaccaro <nvaccaro@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1561642224.git.fabien.lahoudere@collabora.com>
 <7d3972d1200065fe6e98a310e66f53a7ed12e281.1561642224.git.fabien.lahoudere@collabora.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <6ca7ee49-51f9-a65f-5f71-0eac04ee9434@collabora.com>
Date:   Thu, 27 Jun 2019 17:48:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <7d3972d1200065fe6e98a310e66f53a7ed12e281.1561642224.git.fabien.lahoudere@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Fabien,

On 27/6/19 16:04, Fabien Lahoudere wrote:
> Version 3 of the EC protocol provides min and max frequencies for EC sensors.
> Default frequencies are provided for earlier protocol.
> 

This patch should really go together with a respin of your previous patchset to
'Expose cros_ec_sensors frequency range via iio sysfs' [1]

[1] https://www.spinics.net/lists/linux-iio/msg44963.html

> Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
> Signed-off-by: Nick Vaccaro <nvaccaro@chromium.org>
> ---
>  .../cros_ec_sensors/cros_ec_sensors_core.c    | 44 +++++++++++++++++++
>  .../linux/iio/common/cros_ec_sensors_core.h   |  3 ++
>  2 files changed, 47 insertions(+)
> 
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index 2e0f97448e64..72f56d54cccd 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -50,6 +50,37 @@ static int cros_ec_get_host_cmd_version_mask(struct cros_ec_device *ec_dev,
>  	return ret;
>  }
>  
> +static void get_default_min_max_freq(enum motionsensor_type type,
> +				     u32 *min_freq,
> +				     u32 *max_freq)
> +{
> +	switch (type) {
> +	case MOTIONSENSE_TYPE_ACCEL:
> +	case MOTIONSENSE_TYPE_GYRO:
> +		*min_freq = 12500;
> +		*max_freq = 100000;
> +		break;
> +	case MOTIONSENSE_TYPE_MAG:
> +		*min_freq = 5000;
> +		*max_freq = 25000;
> +		break;
> +	case MOTIONSENSE_TYPE_PROX:
> +	case MOTIONSENSE_TYPE_LIGHT:
> +		*min_freq = 100;
> +		*max_freq = 50000;
> +		break;
> +	case MOTIONSENSE_TYPE_BARO:
> +		*min_freq = 250;
> +		*max_freq = 20000;
> +		break;
> +	case MOTIONSENSE_TYPE_ACTIVITY:
> +	default:
> +		*min_freq = 0;
> +		*max_freq = 0;
> +		break;
> +	}
> +}
> +
>  int cros_ec_sensors_core_init(struct platform_device *pdev,
>  			      struct iio_dev *indio_dev,
>  			      bool physical_device)
> @@ -100,6 +131,19 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
>  		}
>  		state->type = state->resp->info.type;
>  		state->loc = state->resp->info.location;
> +
> +		/* Value to stop the device */
> +		state->frequencies[0] = 0;
> +		if (state->msg->version < 3) {
> +			get_default_min_max_freq(state->resp->info.type,
> +						 &state->frequencies[1],
> +						 &state->frequencies[2]);
> +		} else {
> +			state->frequencies[1] =
> +			    state->resp->info_3.min_frequency;
> +			state->frequencies[2] =
> +			    state->resp->info_3.max_frequency;
> +		}
>  	}
>  
>  	return 0;
> diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include/linux/iio/common/cros_ec_sensors_core.h
> index 0c636b9fe8d7..94c87da22c04 100644
> --- a/include/linux/iio/common/cros_ec_sensors_core.h
> +++ b/include/linux/iio/common/cros_ec_sensors_core.h
> @@ -70,6 +70,9 @@ struct cros_ec_sensors_core_state {
>  				    unsigned long scan_mask, s16 *data);
>  
>  	int curr_sampl_freq;
> +
> +	/* Disable, Min and Max Sampling Frequency in mHz */
> +	int frequencies[3];
>  };
>  
>  /**
> 
