Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16651ED35C
	for <lists+linux-iio@lfdr.de>; Sun,  3 Nov 2019 13:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfKCMhm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 Nov 2019 07:37:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:51518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727377AbfKCMhm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Nov 2019 07:37:42 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0215F2080F;
        Sun,  3 Nov 2019 12:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572784660;
        bh=FpEd4P1rK+FmEKUtkOe9tb688DrGh7BwSAAv8ZekNzk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RZ/2FteWTccZlfRZRJKK1HN4TEoe2iVQ3fbrQaouqJ7RZj+iJES1dznoX95K8dRZF
         uQBWcz4T6NeYiKH+D8mOBjD7/GTJeE6CpxVzpsoRCnIMikwl3k0hZAYNZQ+1YTIaNn
         ExVTJH2A0v78o8hebPfH+lKpFyz4wJ2QLQIGnzXo=
Date:   Sun, 3 Nov 2019 12:37:34 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     briannorris@chromium.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, lee.jones@linaro.org, bleung@chromium.org,
        enric.balletbo@collabora.com, dianders@chromium.org,
        groeck@chromium.org, fabien.lahoudere@collabora.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 02/18] mfd: cros_ec: Add sensor_count and make
 check_features public
Message-ID: <20191103123734.7ce80e48@archlinux>
In-Reply-To: <20191027230921.205251-3-gwendal@chromium.org>
References: <20191027230921.205251-1-gwendal@chromium.org>
        <20191027230921.205251-3-gwendal@chromium.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 27 Oct 2019 16:09:05 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> Add a new function to return the number of MEMS sensors available in a
> ChromeOS Embedded Controller.
> It uses MOTIONSENSE_CMD_DUMP if available or a specific memory map ACPI
> registers to find out.
> 
> Also, make check_features public as it can be useful for other drivers
> to know what the Embedded Controller supports.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>

Lee acked this one so you should have picked that up.

Also Enric had some comments that are not addressed in here
and I can't see a reply to his review.


> ---
> Changes in v3:
>   Fix doxygen comments.

kernel-doc.

> Changes in v2:
>   Fix spelling in commit message.
>   Cleanup the case where DUMP command is not supported.
>   Move code from mfd to platform/chrome/
> 
>  drivers/mfd/cros_ec_dev.c                   |  32 ------
>  drivers/platform/chrome/cros_ec_proto.c     | 117 ++++++++++++++++++++
>  include/linux/platform_data/cros_ec_proto.h |   5 +
>  3 files changed, 122 insertions(+), 32 deletions(-)
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
> index 7db58771ec77c..91a4977f3a622 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -717,3 +717,120 @@ u32 cros_ec_get_host_event(struct cros_ec_device *ec_dev)
>  	return host_event;
>  }
>  EXPORT_SYMBOL(cros_ec_get_host_event);
> +
> +/**
> + * cros_ec_check_features - Test for the presence of EC features
> + *
> + * @ec: EC device, does not have to be connected directly to the AP,
> + *      can be daisy chained through another device.
> + * @feature: One of ec_feature_code bit.
> + *
> + * Call this function to test whether the ChromeOS EC supports a feature.
> + *
> + * Return: 1 if supported, 0 if not
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
> + * cros_ec_get_sensor_count - Return the number of MEMS sensors supported.
> + *
> + * @ec: EC device, does not have to be connected directly to the AP,
> + *      can be daisy chained through another device.
> + * Return: < 0 in case of error.
> + */
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

