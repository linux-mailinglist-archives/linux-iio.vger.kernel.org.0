Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D9C7A3548
	for <lists+linux-iio@lfdr.de>; Sun, 17 Sep 2023 13:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbjIQLBh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 Sep 2023 07:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232919AbjIQLBH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 17 Sep 2023 07:01:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A03A3;
        Sun, 17 Sep 2023 04:01:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD8F2C433C8;
        Sun, 17 Sep 2023 11:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694948461;
        bh=w/3DQH9yMV7ETtq3/yyqVuwejIDiXYcN2tKvl489aSc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=V3qDIbmxRyL/0cY/L/R7bV38pAXMZQe7S81I6XYhJ7H3qm8463xPzigYgLLiOribN
         niP/MlSMQ5y/Z6g55d24cx4bQesv7RIPXOg5FVK739DiemD6GfEHmlNRzYe2Ta/2oD
         LyVA5iFW9ITrFoP/0rGbtQeNVXyte5pzdFQfmjr0hIk4PmQ0qGrd39YGrps3KvHmQO
         8RhQc1vXjr5qENMGmENuglOZDUFqrE/3hRnUdTfZAft8AJFnaCQgUQYM7+I0YHWyDH
         d5TnTBU9Mu2sWk2p3/JET4XA9QkI/bcXIPja8JHPFtJNK2rH/xNGSbETfOqTrf6euY
         /3yr39BZ87YXA==
Date:   Sun, 17 Sep 2023 12:00:54 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Cc:     <jikos@kernel.org>, <benjamin.tissoires@redhat.com>,
        <lars@metafoo.de>, <srinivas.pandruvada@linux.intel.com>,
        <linux-input@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 2/8] iio: hid-sensor-als: Add light color temperature
 support
Message-ID: <20230917120054.04e040e4@jic23-huawei>
In-Reply-To: <20230915051703.1689578-3-Basavaraj.Natikar@amd.com>
References: <20230915051703.1689578-1-Basavaraj.Natikar@amd.com>
        <20230915051703.1689578-3-Basavaraj.Natikar@amd.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 15 Sep 2023 10:46:57 +0530
Basavaraj Natikar <Basavaraj.Natikar@amd.com> wrote:

> In most cases, ambient color sensors also support light color temperature.
> As a result, add support of light color temperature.
> 
> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> ---
>  drivers/iio/light/hid-sensor-als.c | 33 ++++++++++++++++++++++++++++++
>  include/linux/hid-sensor-ids.h     |  1 +
>  2 files changed, 34 insertions(+)
> 
> diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
> index 48879e233aec..220fb93fea6d 100644
> --- a/drivers/iio/light/hid-sensor-als.c
> +++ b/drivers/iio/light/hid-sensor-als.c
> @@ -16,6 +16,7 @@
>  enum {
>  	CHANNEL_SCAN_INDEX_INTENSITY = 0,
>  	CHANNEL_SCAN_INDEX_ILLUM = 1,

Either drop, the = 1 or keep consistency for TEMP. 
I don't think the = 1 is useful so I'd drop it.

> +	CHANNEL_SCAN_INDEX_COLOR_TEMP,
>  	CHANNEL_SCAN_INDEX_MAX
>  };
>  
> @@ -65,6 +66,18 @@ static const struct iio_chan_spec als_channels[] = {
>  		BIT(IIO_CHAN_INFO_HYSTERESIS_RELATIVE),
>  		.scan_index = CHANNEL_SCAN_INDEX_ILLUM,
>  	},
> +	{
> +		.type = IIO_TEMP,

Using a temperature channel for color temp is a bit of a stretch,
Particularly as it's likely we will see light sensors with actual
air temperature sensors in them at somepoint even if we don't have
any already.

So this needs a new channel type
IIO_COLORTEMP or similar.

Units for this probably want to be kelvin unlike the mili decrees centigrade
used for IIO_TEMP.

> +		.modified = 1,
> +		.channel2 = IIO_MOD_TEMP_AMBIENT,

I don't really see the modifier as useful here. That exists for thermocouple
type systems where it is necessary to know ambient vs sample temperatures.


> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
> +			BIT(IIO_CHAN_INFO_SCALE) |
> +			BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> +			BIT(IIO_CHAN_INFO_HYSTERESIS) |
> +			BIT(IIO_CHAN_INFO_HYSTERESIS_RELATIVE),
> +		.scan_index = CHANNEL_SCAN_INDEX_COLOR_TEMP,
> +	},
>  	IIO_CHAN_SOFT_TIMESTAMP(CHANNEL_SCAN_INDEX_TIMESTAMP)
>  };
>  
> @@ -103,6 +116,11 @@ static int als_read_raw(struct iio_dev *indio_dev,
>  			min = als_state->als_illum[chan->scan_index].logical_minimum;
>  			address = HID_USAGE_SENSOR_LIGHT_ILLUM;
>  			break;
> +		case  CHANNEL_SCAN_INDEX_COLOR_TEMP:
> +			report_id = als_state->als_illum[chan->scan_index].report_id;
> +			min = als_state->als_illum[chan->scan_index].logical_minimum;
> +			address = HID_USAGE_SENSOR_LIGHT_COLOR_TEMPERATURE;
> +			break;
>  		default:
>  			report_id = -1;
>  			break;
> @@ -223,6 +241,10 @@ static int als_capture_sample(struct hid_sensor_hub_device *hsdev,
>  		als_state->scan.illum[CHANNEL_SCAN_INDEX_ILLUM] = sample_data;
>  		ret = 0;
>  		break;
> +	case HID_USAGE_SENSOR_LIGHT_COLOR_TEMPERATURE:
> +		als_state->scan.illum[CHANNEL_SCAN_INDEX_COLOR_TEMP] = sample_data;
> +		ret = 0;
> +		break;
>  	case HID_USAGE_SENSOR_TIME_TIMESTAMP:
>  		als_state->timestamp = hid_sensor_convert_timestamp(&als_state->common_attributes,
>  								    *(s64 *)raw_data);
> @@ -256,6 +278,17 @@ static int als_parse_report(struct platform_device *pdev,
>  			st->als_illum[i].report_id);
>  	}
>  
> +	ret = sensor_hub_input_get_attribute_info(hsdev, HID_INPUT_REPORT, usage_id,
> +						  HID_USAGE_SENSOR_LIGHT_COLOR_TEMPERATURE,
> +						  &st->als_illum[CHANNEL_SCAN_INDEX_COLOR_TEMP]);
> +	if (ret < 0)
> +		return ret;
> +	als_adjust_channel_bit_mask(channels, CHANNEL_SCAN_INDEX_COLOR_TEMP,
> +				    st->als_illum[CHANNEL_SCAN_INDEX_COLOR_TEMP].size);
> +
> +	dev_dbg(&pdev->dev, "als %x:%x\n", st->als_illum[CHANNEL_SCAN_INDEX_COLOR_TEMP].index,
> +		st->als_illum[CHANNEL_SCAN_INDEX_COLOR_TEMP].report_id);
> +
>  	st->scale_precision = hid_sensor_format_scale(usage_id,
>  						      &st->als_illum[CHANNEL_SCAN_INDEX_INTENSITY],
>  						      &st->scale_pre_decml, &st->scale_post_decml);
> diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-sensor-ids.h
> index 13b1e65fbdcc..8af4fb3e0254 100644
> --- a/include/linux/hid-sensor-ids.h
> +++ b/include/linux/hid-sensor-ids.h
> @@ -21,6 +21,7 @@
>  #define HID_USAGE_SENSOR_ALS					0x200041
>  #define HID_USAGE_SENSOR_DATA_LIGHT				0x2004d0
>  #define HID_USAGE_SENSOR_LIGHT_ILLUM				0x2004d1
> +#define HID_USAGE_SENSOR_LIGHT_COLOR_TEMPERATURE		0x2004d2
>  
>  /* PROX (200011) */
>  #define HID_USAGE_SENSOR_PROX                                   0x200011

