Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 597E1C219A
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2019 15:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730637AbfI3NPU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Sep 2019 09:15:20 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55538 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfI3NPU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Sep 2019 09:15:20 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 524B428D5B5
Subject: Re: [PATCH 01/13] mfd: cros_ec: Add sensor_count and make
 check_features public
To:     Gwendal Grignou <gwendal@chromium.org>, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        lee.jones@linaro.org, bleung@chromium.org, dianders@chromium.org,
        groeck@chromium.org, fabien.lahoudere@collabora.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <20190922175021.53449-1-gwendal@chromium.org>
 <20190922175021.53449-2-gwendal@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <411716b0-818b-9060-7055-8ff9523c0c45@collabora.com>
Date:   Mon, 30 Sep 2019 15:15:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190922175021.53449-2-gwendal@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Gwendal,

Many thanks for the patches.

On 22/9/19 19:50, Gwendal Grignou wrote:
> Add a new function to return the number of MEMS sensors available in a
> ChromeOS Embedded Controller.
> It uses MOTIONSENSE_CMD_DUMP if available or a specific memory map ACPI
> registers to find out.
> 
> Also, make check_features public as it can be useful for other drivers
> to know whant the Embedded Controller supports.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
>  drivers/mfd/cros_ec_dev.c   | 61 ++++++++++++++++++++++++++++++++++++-
>  include/linux/mfd/cros_ec.h | 17 +++++++++++
>  2 files changed, 77 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index 6e6dfd6c1871..3be80183ccaa 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -112,7 +112,7 @@ static const struct mfd_cell cros_ec_vbc_cells[] = {
>  	{ .name = "cros-ec-vbc", }
>  };
>  
> -static int cros_ec_check_features(struct cros_ec_dev *ec, int feature)
> +int cros_ec_check_features(struct cros_ec_dev *ec, int feature)
>  {
>  	struct cros_ec_command *msg;
>  	int ret;
> @@ -143,12 +143,71 @@ static int cros_ec_check_features(struct cros_ec_dev *ec, int feature)
>  
>  	return ec->features[feature / 32] & EC_FEATURE_MASK_0(feature);
>  }
> +EXPORT_SYMBOL_GPL(cros_ec_check_features);
>  
>  static void cros_ec_class_release(struct device *dev)
>  {
>  	kfree(to_cros_ec_dev(dev));
>  }
>  
> +int cros_ec_get_sensor_count(struct cros_ec_dev *ec)
> +{
> +	/*
> +	 * Issue a command to get the number of sensor reported.
> +	 * If not supported, check for legacy mode.
> +	 */
> +	int ret, sensor_count;
> +	struct ec_params_motion_sense *params;
> +	struct ec_response_motion_sense *resp;
> +	struct cros_ec_command *msg;
> +	struct cros_ec_device *ec_dev = ec->ec_dev;
> +	u8 status;
> +
> +	msg = kzalloc(sizeof(struct cros_ec_command) +
> +			max(sizeof(*params), sizeof(*resp)), GFP_KERNEL);
> +	if (msg == NULL)
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
> +		    (status & EC_MEMMAP_ACC_STATUS_PRESENCE_BIT)) {
> +			/*
> +			 * We have 2 sensors, one in the lid, one in the base.
> +			 */
> +			sensor_count = 2;
> +		}
> +	}
> +	return sensor_count;
> +}
> +EXPORT_SYMBOL_GPL(cros_ec_get_sensor_count);
> +
>  static void cros_ec_sensors_register(struct cros_ec_dev *ec)
>  {
>  	/*
> diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
> index 61c2875c2a40..578e0bbcafdc 100644
> --- a/include/linux/mfd/cros_ec.h
> +++ b/include/linux/mfd/cros_ec.h
> @@ -32,4 +32,21 @@ struct cros_ec_dev {
>  
>  #define to_cros_ec_dev(dev)  container_of(dev, struct cros_ec_dev, class_dev)
>  
> +/**
> + * cros_ec_check_features - Test for the presence of EC features
> + *
> + * Call this function to test whether the ChromeOS EC supports a feature.
> + *
> + * @ec_dev: EC device
> + * @msg: One of ec_feature_code values
> + * @return: 1 if supported, 0 if not
> + */
> +int cros_ec_check_features(struct cros_ec_dev *ec, int feature);
> +
> +/*
> + * Return the number of MEMS sensors supported.
> + * Return < 0 in case of error.
> + */
> +int cros_ec_get_sensor_count(struct cros_ec_dev *ec);
> +

I am wondering if we should take this opportunity to move these two functions
from drivers/mfd/cros_ec_dev to drivers/platform/chrome/cros_ec_proto.c and
include/linux/platform_data/cros_ec_proto.h

I think this part is more suitable for core part that actually resides in
platform/chrome than the mfd device itself. What do you think? Do you see any
problem on doing this?

Thanks,
 Enric

>  #endif /* __LINUX_MFD_CROS_EC_H */
> 
