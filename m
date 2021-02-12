Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 686CC31A48D
	for <lists+linux-iio@lfdr.de>; Fri, 12 Feb 2021 19:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbhBLS2x (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Feb 2021 13:28:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:54082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229782AbhBLS2t (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 12 Feb 2021 13:28:49 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CFA064DEA;
        Fri, 12 Feb 2021 18:28:08 +0000 (UTC)
Date:   Fri, 12 Feb 2021 18:28:09 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ye Xiang <xiang.ye@intel.com>
Cc:     jikos@kernel.org, srinivas.pandruvada@linux.intel.com,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] iio: Add relative sensitivity support
Message-ID: <20210212182809.2cc90cfd@archlinux>
In-Reply-To: <20210207070048.23935-2-xiang.ye@intel.com>
References: <20210207070048.23935-1-xiang.ye@intel.com>
        <20210207070048.23935-2-xiang.ye@intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun,  7 Feb 2021 15:00:46 +0800
Ye Xiang <xiang.ye@intel.com> wrote:

> Some hid sensors may use relative sensitivity such as als sensor.
> This patch adds relative sensitivity checking for all hid sensors.
> 
> Signed-off-by: Ye Xiang <xiang.ye@intel.com>
Hi,

One totally trivial extra line below.  I'll fix that whilst applying
unless you need to respin for some reason.

I'm fine with the series, but looking for an Ack from Jiri
for the HID header changes.

Unless we get a surprise on Sunday there is no chance I'll sneak
this in for the coming merge window (or any of the things I've
already gotten queued up in iio.git).  Good to get it lined up soon
for next time so we can all forget about it :)

Jonathan


> ---
>  .../hid-sensors/hid-sensor-attributes.c       | 74 ++++++++++++++++++-
>  drivers/iio/industrialio-core.c               |  1 +
>  include/linux/hid-sensor-hub.h                |  5 ++
>  include/linux/hid-sensor-ids.h                |  1 +
>  include/linux/iio/types.h                     |  1 +
>  5 files changed, 78 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> index d349ace2e33f..cb52b4fd6bf7 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> @@ -263,6 +263,29 @@ int hid_sensor_read_raw_hyst_value(struct hid_sensor_common *st,
>  }
>  EXPORT_SYMBOL(hid_sensor_read_raw_hyst_value);
>  
> +int hid_sensor_read_raw_hyst_rel_value(struct hid_sensor_common *st, int *val1,
> +				       int *val2)
> +{
> +	s32 value;
> +	int ret;
> +
> +	ret = sensor_hub_get_feature(st->hsdev,
> +				     st->sensitivity_rel.report_id,
> +				     st->sensitivity_rel.index, sizeof(value),
> +				     &value);
> +	if (ret < 0 || value < 0) {
> +		*val1 = *val2 = 0;
> +		return -EINVAL;
> +	}
> +
> +	convert_from_vtf_format(value, st->sensitivity_rel.size,
> +				st->sensitivity_rel.unit_expo, val1, val2);
> +
> +	return IIO_VAL_INT_PLUS_MICRO;
> +}
> +EXPORT_SYMBOL(hid_sensor_read_raw_hyst_rel_value);
> +
> +

One line only.


>  int hid_sensor_write_raw_hyst_value(struct hid_sensor_common *st,
>  					int val1, int val2)
>  {
> @@ -294,6 +317,37 @@ int hid_sensor_write_raw_hyst_value(struct hid_sensor_common *st,
>  }
>  EXPORT_SYMBOL(hid_sensor_write_raw_hyst_value);
>  
> +int hid_sensor_write_raw_hyst_rel_value(struct hid_sensor_common *st,
> +					int val1, int val2)
> +{
> +	s32 value;
> +	int ret;
> +
> +	if (val1 < 0 || val2 < 0)
> +		return -EINVAL;
> +
> +	value = convert_to_vtf_format(st->sensitivity_rel.size,
> +				st->sensitivity_rel.unit_expo,
> +				val1, val2);
> +	ret = sensor_hub_set_feature(st->hsdev, st->sensitivity_rel.report_id,
> +				     st->sensitivity_rel.index, sizeof(value),
> +				     &value);
> +	if (ret < 0 || value < 0)
> +		return -EINVAL;
> +
> +	ret = sensor_hub_get_feature(st->hsdev,
> +				     st->sensitivity_rel.report_id,
> +				     st->sensitivity_rel.index, sizeof(value),
> +				     &value);
> +	if (ret < 0 || value < 0)
> +		return -EINVAL;
> +
> +	st->raw_hystersis = value;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(hid_sensor_write_raw_hyst_rel_value);
> +
>  /*
>   * This fuction applies the unit exponent to the scale.
>   * For example:
> @@ -478,16 +532,28 @@ int hid_sensor_parse_common_attributes(struct hid_sensor_hub_device *hsdev,
>  			HID_USAGE_SENSOR_PROP_SENSITIVITY_ABS,
>  			 &st->sensitivity);
>  
> +	sensor_hub_input_get_attribute_info(hsdev,
> +			HID_FEATURE_REPORT, usage_id,
> +			HID_USAGE_SENSOR_PROP_SENSITIVITY_REL_PCT,
> +			&st->sensitivity_rel);
>  	/*
>  	 * Set Sensitivity field ids, when there is no individual modifier, will
> -	 * check absolute sensitivity of data field
> +	 * check absolute sensitivity and relative sensitivity of data field
>  	 */
> -	for (i = 0; i < sensitivity_addresses_len && st->sensitivity.index < 0; i++) {
> -		sensor_hub_input_get_attribute_info(hsdev,
> -				HID_FEATURE_REPORT, usage_id,
> +	for (i = 0; i < sensitivity_addresses_len; i++) {
> +		if (st->sensitivity.index < 0)
> +			sensor_hub_input_get_attribute_info(
> +				hsdev, HID_FEATURE_REPORT, usage_id,
>  				HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS |
>  					sensitivity_addresses[i],
>  				&st->sensitivity);
> +
> +		if (st->sensitivity_rel.index < 0)
> +			sensor_hub_input_get_attribute_info(
> +				hsdev, HID_FEATURE_REPORT, usage_id,
> +				HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_REL_PCT |
> +					sensitivity_addresses[i],
> +				&st->sensitivity_rel);
>  	}
>  
>  	st->raw_hystersis = -1;
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 7db761afa578..3da8fcec3c16 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -157,6 +157,7 @@ static const char * const iio_chan_info_postfix[] = {
>  	[IIO_CHAN_INFO_PHASE] = "phase",
>  	[IIO_CHAN_INFO_HARDWAREGAIN] = "hardwaregain",
>  	[IIO_CHAN_INFO_HYSTERESIS] = "hysteresis",
> +	[IIO_CHAN_INFO_HYSTERESIS_RELATIVE] = "hysteresis_relative",
>  	[IIO_CHAN_INFO_INT_TIME] = "integration_time",
>  	[IIO_CHAN_INFO_ENABLE] = "en",
>  	[IIO_CHAN_INFO_CALIBHEIGHT] = "calibheight",
> diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-sensor-hub.h
> index 8b2599348554..5e7bc309172e 100644
> --- a/include/linux/hid-sensor-hub.h
> +++ b/include/linux/hid-sensor-hub.h
> @@ -230,6 +230,7 @@ struct hid_sensor_common {
>  	struct hid_sensor_hub_attribute_info report_state;
>  	struct hid_sensor_hub_attribute_info power_state;
>  	struct hid_sensor_hub_attribute_info sensitivity;
> +	struct hid_sensor_hub_attribute_info sensitivity_rel;
>  	struct hid_sensor_hub_attribute_info report_latency;
>  	struct work_struct work;
>  };
> @@ -252,8 +253,12 @@ int hid_sensor_parse_common_attributes(struct hid_sensor_hub_device *hsdev,
>  					u32 sensitivity_addresses_len);
>  int hid_sensor_write_raw_hyst_value(struct hid_sensor_common *st,
>  					int val1, int val2);
> +int hid_sensor_write_raw_hyst_rel_value(struct hid_sensor_common *st, int val1,
> +					int val2);
>  int hid_sensor_read_raw_hyst_value(struct hid_sensor_common *st,
>  					int *val1, int *val2);
> +int hid_sensor_read_raw_hyst_rel_value(struct hid_sensor_common *st,
> +				       int *val1, int *val2);
>  int hid_sensor_write_samp_freq_value(struct hid_sensor_common *st,
>  					int val1, int val2);
>  int hid_sensor_read_samp_freq_value(struct hid_sensor_common *st,
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
> diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
> index 1e3ed6f55bca..5aa7f66d4345 100644
> --- a/include/linux/iio/types.h
> +++ b/include/linux/iio/types.h
> @@ -50,6 +50,7 @@ enum iio_chan_info_enum {
>  	IIO_CHAN_INFO_PHASE,
>  	IIO_CHAN_INFO_HARDWAREGAIN,
>  	IIO_CHAN_INFO_HYSTERESIS,
> +	IIO_CHAN_INFO_HYSTERESIS_RELATIVE,
>  	IIO_CHAN_INFO_INT_TIME,
>  	IIO_CHAN_INFO_ENABLE,
>  	IIO_CHAN_INFO_CALIBHEIGHT,

