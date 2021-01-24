Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88544301C14
	for <lists+linux-iio@lfdr.de>; Sun, 24 Jan 2021 14:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbhAXNPb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 24 Jan 2021 08:15:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:42722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726672AbhAXNP3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 Jan 2021 08:15:29 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E03322795;
        Sun, 24 Jan 2021 13:14:46 +0000 (UTC)
Date:   Sun, 24 Jan 2021 13:14:42 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ye Xiang <xiang.ye@intel.com>
Cc:     jikos@kernel.org, srinivas.pandruvada@linux.intel.com,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] hid-sensor-common: Add relative sensitivity check
Message-ID: <20210124131442.0fc2577e@archlinux>
In-Reply-To: <20210120074706.23199-3-xiang.ye@intel.com>
References: <20210120074706.23199-1-xiang.ye@intel.com>
        <20210120074706.23199-3-xiang.ye@intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 20 Jan 2021 15:47:05 +0800
Ye Xiang <xiang.ye@intel.com> wrote:

> Some hid sensors may use relative sensitivity such as als sensor.
> This patch add relative sensitivity check for all hid-sensors.
> 
> Signed-off-by: Ye Xiang <xiang.ye@intel.com>
> ---
>  .../iio/common/hid-sensors/hid-sensor-attributes.c    | 11 ++++++++++-
>  include/linux/hid-sensor-ids.h                        |  1 +
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> index d349ace2e33f..b685c292a179 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> @@ -480,7 +480,7 @@ int hid_sensor_parse_common_attributes(struct hid_sensor_hub_device *hsdev,
>  
>  	/*
>  	 * Set Sensitivity field ids, when there is no individual modifier, will
> -	 * check absolute sensitivity of data field
> +	 * check absolute sensitivity and relative sensitivity of data field
>  	 */
>  	for (i = 0; i < sensitivity_addresses_len && st->sensitivity.index < 0; i++) {
>  		sensor_hub_input_get_attribute_info(hsdev,
> @@ -488,6 +488,15 @@ int hid_sensor_parse_common_attributes(struct hid_sensor_hub_device *hsdev,
>  				HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS |
>  					sensitivity_addresses[i],
>  				&st->sensitivity);
> +
> +		if (st->sensitivity.index >= 0)
> +			break;
> +
> +		sensor_hub_input_get_attribute_info(hsdev,
> +				HID_FEATURE_REPORT, usage_id,
> +				HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_REL_PCT |
> +					sensitivity_addresses[i],
> +				&st->sensitivity);

We can't provide the value to userspace without reflecting the difference between
the two ways of expressing it.

It seems there are 3 ways sensitivity is expressed.
1. Raw value in same units as the measurement (easy one and what is currently reported)
2. Percentage of range - also relatively easy to transform into the same as 1.
3. Percentage of prior reading..  This one doesn't fit in any existing ABI, so
   unfortunately we'll have to invent something new along the lines of
   *_hysteresis_relative 

Jonathan



>  	}
>  
>  	st->raw_hystersis = -1;
> diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-sensor-ids.h
> index 3bbdbccc5805..ac631159403a 100644
> --- a/include/linux/hid-sensor-ids.h
> +++ b/include/linux/hid-sensor-ids.h
> @@ -149,6 +149,7 @@
>  /* Per data field properties */
>  #define HID_USAGE_SENSOR_DATA_MOD_NONE					0x00
>  #define HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS		0x1000
> +#define HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_REL_PCT            0xE000
>  
>  /* Power state enumerations */
>  #define HID_USAGE_SENSOR_PROP_POWER_STATE_UNDEFINED_ENUM	0x200850

