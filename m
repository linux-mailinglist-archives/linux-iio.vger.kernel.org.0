Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D85EDF0F7
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2019 17:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfJUPMu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Oct 2019 11:12:50 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36752 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbfJUPMu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Oct 2019 11:12:50 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 1B6BA28B012
Subject: Re: [PATCH v2 02/18] mfd: cros_ec: Add sensor_count and make
 check_features public
To:     Gwendal Grignou <gwendal@chromium.org>, briannorris@chromium.org,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, lee.jones@linaro.org, bleung@chromium.org,
        dianders@chromium.org, groeck@chromium.org,
        fabien.lahoudere@collabora.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <20191021055403.67849-1-gwendal@chromium.org>
 <20191021055403.67849-3-gwendal@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <fe819ee5-d3ec-ef0e-521e-c2f2fb48b980@collabora.com>
Date:   Mon, 21 Oct 2019 17:12:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191021055403.67849-3-gwendal@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Gwendal,

Many thanks for the patches, some few comments below.

On 21/10/19 7:53, Gwendal Grignou wrote:
> Add a new function to return the number of MEMS sensors available in a
> ChromeOS Embedded Controller.
> It uses MOTIONSENSE_CMD_DUMP if available or a specific memory map ACPI
> registers to find out.
> 
> Also, make check_features public as it can be useful for other drivers
> to know what the Embedded Controller supports.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
> Changes in v2:
>   Fix spelling in commit message.
>   Cleanup the case where DUMP command is not supported.
>   Move code from mfd to platform/chrome/
> 
>  drivers/mfd/cros_ec_dev.c                   |  32 ------
>  drivers/platform/chrome/cros_ec_proto.c     | 116 ++++++++++++++++++++
>  include/linux/platform_data/cros_ec_proto.h |   5 +
>  3 files changed, 121 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index 6e6dfd6c18711..a35104e35cb4e 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -112,38 +112,6 @@ static const struct mfd_cell cros_ec_vbc_cells[] = {
>  	{ .name = "cros-ec-vbc", }
>  };
>  
> -static int cros_ec_check_features(struct cros_ec_dev *ec, int feature)
> -{
> -	struct cros_ec_command *msg;
> -	int ret;
> -
> -	if (ec->features[0] == -1U && ec->features[1] == -1U) {
> -		/* features bitmap not read yet */
> -		msg = kzalloc(sizeof(*msg) + sizeof(ec->features), GFP_KERNEL);
> -		if (!msg)
> -			return -ENOMEM;
> -
> -		msg->command = EC_CMD_GET_FEATURES + ec->cmd_offset;
> -		msg->insize = sizeof(ec->features);
> -
> -		ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
> -		if (ret < 0) {
> -			dev_warn(ec->dev, "cannot get EC features: %d/%d\n",
> -				 ret, msg->result);
> -			memset(ec->features, 0, sizeof(ec->features));
> -		} else {
> -			memcpy(ec->features, msg->data, sizeof(ec->features));
> -		}
> -
> -		dev_dbg(ec->dev, "EC features %08x %08x\n",
> -			ec->features[0], ec->features[1]);
> -
> -		kfree(msg);
> -	}
> -
> -	return ec->features[feature / 32] & EC_FEATURE_MASK_0(feature);
> -}
> -
>  static void cros_ec_class_release(struct device *dev)
>  {
>  	kfree(to_cros_ec_dev(dev));
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index 7db58771ec77c..2357c717399ad 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -717,3 +717,119 @@ u32 cros_ec_get_host_event(struct cros_ec_device *ec_dev)
>  	return host_event;
>  }
>  EXPORT_SYMBOL(cros_ec_get_host_event);
> +
> +/**
> + * cros_ec_check_features - Test for the presence of EC features
> + *
> + * Call this function to test whether the ChromeOS EC supports a feature.
> + *
> + * @ec_dev: EC device: does not have to be connected directly to the AP,
> + *          can be daisy chained through another device.
> + * @feature: One of ec_feature_code bit.
> + * @return: 1 if supported, 0 if not

This is not kernel-doc compliant, check with kernel-doc script.

> + */
> +int cros_ec_check_features(struct cros_ec_dev *ec, int feature)
> +{
> +	struct cros_ec_command *msg;
> +	int ret;
> +
> +	if (ec->features[0] == -1U && ec->features[1] == -1U) {
> +		/* features bitmap not read yet */
> +		msg = kzalloc(sizeof(*msg) + sizeof(ec->features), GFP_KERNEL);
> +		if (!msg)
> +			return -ENOMEM;
> +
> +		msg->command = EC_CMD_GET_FEATURES + ec->cmd_offset;
> +		msg->insize = sizeof(ec->features);
> +
> +		ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
> +		if (ret < 0) {
> +			dev_warn(ec->dev, "cannot get EC features: %d/%d\n",
> +				 ret, msg->result);
> +			memset(ec->features, 0, sizeof(ec->features));
> +		} else {
> +			memcpy(ec->features, msg->data, sizeof(ec->features));
> +		}
> +
> +		dev_dbg(ec->dev, "EC features %08x %08x\n",
> +			ec->features[0], ec->features[1]);
> +
> +		kfree(msg);
> +	}
> +
> +	return ec->features[feature / 32] & EC_FEATURE_MASK_0(feature);
> +}
> +EXPORT_SYMBOL_GPL(cros_ec_check_features);
> +
> +/**
> + * Return the number of MEMS sensors supported.
> + *
> + * @ec_dev: EC device: does not have to be connected directly to the AP,
> + *          can be daisy chained through another device.
> + * Return < 0 in case of error.

Same, this is not kernel-doc compliant, check with kernel-doc script.

> + */
> +int cros_ec_get_sensor_count(struct cros_ec_dev *ec)
> +{
> +	/*
> +	 * Issue a command to get the number of sensor reported.
> +	 * If not supported, check for legacy mode.
> +	 */

I'd prefer have this in the function documentation.

> +	int ret, sensor_count;
> +	struct ec_params_motion_sense *params;
> +	struct ec_response_motion_sense *resp;
> +	struct cros_ec_command *msg;
> +	struct cros_ec_device *ec_dev = ec->ec_dev;
> +	u8 status;
> +

nit: Reverse Christmas tree local variable ordering here please.

> +	msg = kzalloc(sizeof(struct cros_ec_command) +

Better sizeof(*msg)?

> +			max(sizeof(*params), sizeof(*resp)), GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;
> +
> +	msg->version = 1;
> +	msg->command = EC_CMD_MOTION_SENSE_CMD + ec->cmd_offset;
> +	msg->outsize = sizeof(*params);
> +	msg->insize = sizeof(*resp);
> +
> +	params = (struct ec_params_motion_sense *)msg->data;
> +	params->cmd = MOTIONSENSE_CMD_DUMP;
> +


> +	ret = cros_ec_cmd_xfer(ec->ec_dev, msg);
> +	if (ret < 0) {
> +		sensor_count = ret;
> +	} else if (msg->result != EC_RES_SUCCESS) {
> +		sensor_count = -EPROTO;
> +	} else {
> +		resp = (struct ec_response_motion_sense *)msg->data;
> +		sensor_count = resp->dump.sensor_count;
> +	}

Can this be rewritten to?

        sensor_count = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
        if (sensor_count >= 0) {
		resp = (struct ec_response_motion_sense *)msg->data;
		sensor_count = resp->dump.sensor_count;
        }

> +	kfree(msg);
> +
> +	/*
> +	 * Check legacy mode: Let's find out if sensors are accessible
> +	 * via LPC interface.
> +	 */
> +	if (sensor_count == -EPROTO &&
> +	    ec->cmd_offset == 0 &&
> +	    ec_dev->cmd_readmem) {
> +		ret = ec_dev->cmd_readmem(ec_dev, EC_MEMMAP_ACC_STATUS,
> +				1, &status);
> +		if ((ret >= 0) &&

Unnecessary parentheses around 'ret >= 0'

> +		    (status & EC_MEMMAP_ACC_STATUS_PRESENCE_BIT)) {

Unnecessary brackets

> +			/*
> +			 * We have 2 sensors, one in the lid, one in the base.
> +			 */
> +			sensor_count = 2;
> +		} else {
> +			/*
> +			 * EC uses LPC interface and no sensors are presented.
> +			 */
> +			sensor_count = 0;
> +		}
> +	} else if (sensor_count == -EPROTO) {
> +		/* EC responded, but does not understand DUMP command. */
> +		sensor_count = 0;
> +	}
> +	return sensor_count;
> +}
> +EXPORT_SYMBOL_GPL(cros_ec_get_sensor_count);
> diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
> index 0d4e4aaed37af..f3de0662135d5 100644
> --- a/include/linux/platform_data/cros_ec_proto.h
> +++ b/include/linux/platform_data/cros_ec_proto.h
> @@ -12,6 +12,7 @@
>  #include <linux/mutex.h>
>  #include <linux/notifier.h>
>  
> +#include <linux/mfd/cros_ec.h>

I am wondering if makes sense move 'struct cros_ec_dev' to cros_ec_proto.h and
remove definitely include/mfd/cros_ec.h. However this could be a follow up patch.

>  #include <linux/platform_data/cros_ec_commands.h>
>  
>  #define CROS_EC_DEV_NAME	"cros_ec"
> @@ -213,4 +214,8 @@ int cros_ec_get_next_event(struct cros_ec_device *ec_dev, bool *wake_event);
>  
>  u32 cros_ec_get_host_event(struct cros_ec_device *ec_dev);
>  
> +int cros_ec_check_features(struct cros_ec_dev *ec, int feature);
> +
> +int cros_ec_get_sensor_count(struct cros_ec_dev *ec);
> +
>  #endif /* __LINUX_CROS_EC_PROTO_H */
> 

Thanks,
 Enric
