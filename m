Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1387BCCAC8
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2019 17:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbfJEP1C (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Oct 2019 11:27:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:56688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725826AbfJEP1B (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Oct 2019 11:27:01 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 399C1222C0;
        Sat,  5 Oct 2019 15:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570289220;
        bh=fy3hoNRs9rqjDfg90ZP+rL71oJ1/78+CpX4NTCaMQjU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0oZAFrtpQoFfg6XcWT4dH2f5iz1IaEolPKmqnbgqgEmOKYSbPi01ohd16eZpsiUl5
         /a4ik6PJxe37ZcT3G51aOnQEInQ/dho1aMVk7LesluNJwRtfxQ9KR2GVHbF2A7qv36
         +SDjyO6YJZCVW2ZuX0WO9f25TbtPiRt2R++gGyaA=
Date:   Sat, 5 Oct 2019 16:26:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        lee.jones@linaro.org, bleung@chromium.org,
        enric.balletbo@collabora.com, dianders@chromium.org,
        groeck@chromium.org, fabien.lahoudere@collabora.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 01/13] mfd: cros_ec: Add sensor_count and make
 check_features public
Message-ID: <20191005162655.0b1eb53a@archlinux>
In-Reply-To: <20190922175021.53449-2-gwendal@chromium.org>
References: <20190922175021.53449-1-gwendal@chromium.org>
        <20190922175021.53449-2-gwendal@chromium.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 22 Sep 2019 10:50:09 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> Add a new function to return the number of MEMS sensors available in a
> ChromeOS Embedded Controller.
> It uses MOTIONSENSE_CMD_DUMP if available or a specific memory map ACPI
> registers to find out.
> 
> Also, make check_features public as it can be useful for other drivers
> to know whant the Embedded Controller supports.

what

> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Comments inline,

Thanks,

Jonathan

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

if (!msg) perhaps. I've not checked the driver for which version is commonly
used.

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

Why not flip the logic here and return early if we have the value?
if (sensor_count > 0)
	return sensor_count;

	
> +		ret = ec_dev->cmd_readmem(ec_dev, EC_MEMMAP_ACC_STATUS,
> +				1, &status);
> +		if ((ret >= 0) &&
> +		    (status & EC_MEMMAP_ACC_STATUS_PRESENCE_BIT)) {
> +			/*
> +			 * We have 2 sensors, one in the lid, one in the base.
> +			 */
> +			sensor_count = 2;
> +		}

		If this failed do we not want to return that error?
		Doesn't this also return -EPROTO if there is only one sensor?
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

Seems like we should be consistent and have kernel-doc style comments
for everything if we are going to do them for some functions.

However, docs should be with the code, not in the header where they
tend to rot.

> + * Return the number of MEMS sensors supported.
> + * Return < 0 in case of error.
> + */
> +int cros_ec_get_sensor_count(struct cros_ec_dev *ec);
> +
>  #endif /* __LINUX_MFD_CROS_EC_H */

