Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7783DF207
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2019 17:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbfJUPt7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Oct 2019 11:49:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:55772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727607AbfJUPt7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 21 Oct 2019 11:49:59 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDF2C20873;
        Mon, 21 Oct 2019 15:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571672997;
        bh=ZdbTJMpphz2DyRdVeSaDcLbx4qWNr119tOqnk+bZl0E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WdnPJiHLB69q+zppMU3QoyxfUvnxsinUH4fT2socqL3lRo+uLTklVMr2BQXGew/df
         ODQzdCFhmiHCYadmmoUnO060nWXaMP9+t+4GNMVRVXNSrF/XnZmlvHsdkV4WzIlwj0
         N5ua87fXnyCghwVU9NfA/uq2nf1+WbLkA9aRaR/M=
Date:   Mon, 21 Oct 2019 16:49:51 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     briannorris@chromium.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, lee.jones@linaro.org, bleung@chromium.org,
        enric.balletbo@collabora.com, dianders@chromium.org,
        groeck@chromium.org, fabien.lahoudere@collabora.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 02/18] mfd: cros_ec: Add sensor_count and make
 check_features public
Message-ID: <20191021164951.0abfaa85@archlinux>
In-Reply-To: <20191021055403.67849-3-gwendal@chromium.org>
References: <20191021055403.67849-1-gwendal@chromium.org>
        <20191021055403.67849-3-gwendal@chromium.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 20 Oct 2019 22:53:47 -0700
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
One refactoring suggestion, though up to you whether you bother.
+ one kernel-doc formatting issue.

Otherwise seems sane to me, but I don't know the hardware well enough
to give detailed comments.

Thanks,

Jonathan

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

I'm fairly sure that's not correct kernel-doc.  Longer description should come
after the parameters.

> + *
> + * @ec_dev: EC device: does not have to be connected directly to the AP,
> + *          can be daisy chained through another device.
> + * @feature: One of ec_feature_code bit.
> + * @return: 1 if supported, 0 if not
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

Can we simplify the following flow?  I think the following is the same and
breaks the individual paths out more clearly to my eyes.

I'm not totally sure this helps unwinding the fairly complex flow here,
so up to you.


	/* could break this up into the good path, and the bad but not EPROTO path... */
	if (sensor_count != -EPROTO)
		return sensor_count;

	if (ec->cmd_offset != 0 || ec_dev->cmd_readmem == NULL) {
		/* EC responded, but does not understand DUMP command. */
		return 0;

	ret = ec_dev->cmd_readmem(ec_dev, EC_MEMMAP_ACC_STATUS,
				1, &status);
	if (ret < 0)
		return 0;

	if (status & EC_MEMMAP_ACC_STATUS_PRESENCE_BIT)
		/* 2 sensors, one in the lid, one in the base. */
		return 2;

	else
		/* EC uses LPC interface and no sensors are presented. */
		return 0;
}

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

