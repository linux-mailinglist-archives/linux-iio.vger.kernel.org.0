Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3AF7A47B3
	for <lists+linux-iio@lfdr.de>; Mon, 18 Sep 2023 12:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjIRK7W (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Sep 2023 06:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjIRK6w (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Sep 2023 06:58:52 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4F88F;
        Mon, 18 Sep 2023 03:58:46 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rq1vL5nvkz6HJnC;
        Mon, 18 Sep 2023 18:56:46 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 18 Sep
 2023 11:58:43 +0100
Date:   Mon, 18 Sep 2023 11:58:42 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Basavaraj Natikar <bnatikar@amd.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        <jikos@kernel.org>, <benjamin.tissoires@redhat.com>,
        <lars@metafoo.de>, <srinivas.pandruvada@linux.intel.com>,
        <linux-input@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 2/8] iio: hid-sensor-als: Add light color temperature
 support
Message-ID: <20230918115842.00003223@Huawei.com>
In-Reply-To: <dbc3d5ed-f824-d428-923e-3f44011c44ad@amd.com>
References: <20230915051703.1689578-1-Basavaraj.Natikar@amd.com>
        <20230915051703.1689578-3-Basavaraj.Natikar@amd.com>
        <20230917120054.04e040e4@jic23-huawei>
        <dbc3d5ed-f824-d428-923e-3f44011c44ad@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 17 Sep 2023 20:13:46 +0530
Basavaraj Natikar <bnatikar@amd.com> wrote:

> On 9/17/2023 4:30 PM, Jonathan Cameron wrote:
> > On Fri, 15 Sep 2023 10:46:57 +0530
> > Basavaraj Natikar <Basavaraj.Natikar@amd.com> wrote:
> >  
> >> In most cases, ambient color sensors also support light color temperature.
> >> As a result, add support of light color temperature.
> >>
> >> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> >> ---
> >>  drivers/iio/light/hid-sensor-als.c | 33 ++++++++++++++++++++++++++++++
> >>  include/linux/hid-sensor-ids.h     |  1 +
> >>  2 files changed, 34 insertions(+)
> >>
> >> diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
> >> index 48879e233aec..220fb93fea6d 100644
> >> --- a/drivers/iio/light/hid-sensor-als.c
> >> +++ b/drivers/iio/light/hid-sensor-als.c
> >> @@ -16,6 +16,7 @@
> >>  enum {
> >>  	CHANNEL_SCAN_INDEX_INTENSITY = 0,
> >>  	CHANNEL_SCAN_INDEX_ILLUM = 1,  
> > Either drop, the = 1 or keep consistency for TEMP. 
> > I don't think the = 1 is useful so I'd drop it.
> >  
> >> +	CHANNEL_SCAN_INDEX_COLOR_TEMP,
> >>  	CHANNEL_SCAN_INDEX_MAX
> >>  };
> >>  
> >> @@ -65,6 +66,18 @@ static const struct iio_chan_spec als_channels[] = {
> >>  		BIT(IIO_CHAN_INFO_HYSTERESIS_RELATIVE),
> >>  		.scan_index = CHANNEL_SCAN_INDEX_ILLUM,
> >>  	},
> >> +	{
> >> +		.type = IIO_TEMP,  
> > Using a temperature channel for color temp is a bit of a stretch,
> > Particularly as it's likely we will see light sensors with actual
> > air temperature sensors in them at somepoint even if we don't have
> > any already.
> >
> > So this needs a new channel type
> > IIO_COLORTEMP or similar.
> >
> > Units for this probably want to be kelvin unlike the mili decrees centigrade
> > used for IIO_TEMP.
> >  
> >> +		.modified = 1,
> >> +		.channel2 = IIO_MOD_TEMP_AMBIENT,  
> > I don't really see the modifier as useful here. That exists for thermocouple
> > type systems where it is necessary to know ambient vs sample temperatures.  
> 
> Sure Jonathan, I will address all comments in this series in v2.
> Also, can i add new channel type IIO_COLORTEMP with following channel index
> for light color temperature ?

Looks good.

Jonathan

>        {
>                 .type = IIO_COLORTEMP,
>                 .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>                 .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
>                         BIT(IIO_CHAN_INFO_SCALE) |
>                         BIT(IIO_CHAN_INFO_SAMP_FREQ) |
>                         BIT(IIO_CHAN_INFO_HYSTERESIS) |
>                         BIT(IIO_CHAN_INFO_HYSTERESIS_RELATIVE),
>                 .scan_index = CHANNEL_SCAN_INDEX_COLOR_TEMP,
>         }
> 
> Thanks,
> --
> Basavaraj
> 
> >
> >  
> >> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> >> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
> >> +			BIT(IIO_CHAN_INFO_SCALE) |
> >> +			BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> >> +			BIT(IIO_CHAN_INFO_HYSTERESIS) |
> >> +			BIT(IIO_CHAN_INFO_HYSTERESIS_RELATIVE),
> >> +		.scan_index = CHANNEL_SCAN_INDEX_COLOR_TEMP,
> >> +	},
> >>  	IIO_CHAN_SOFT_TIMESTAMP(CHANNEL_SCAN_INDEX_TIMESTAMP)
> >>  };
> >>  
> >> @@ -103,6 +116,11 @@ static int als_read_raw(struct iio_dev *indio_dev,
> >>  			min = als_state->als_illum[chan->scan_index].logical_minimum;
> >>  			address = HID_USAGE_SENSOR_LIGHT_ILLUM;
> >>  			break;
> >> +		case  CHANNEL_SCAN_INDEX_COLOR_TEMP:
> >> +			report_id = als_state->als_illum[chan->scan_index].report_id;
> >> +			min = als_state->als_illum[chan->scan_index].logical_minimum;
> >> +			address = HID_USAGE_SENSOR_LIGHT_COLOR_TEMPERATURE;
> >> +			break;
> >>  		default:
> >>  			report_id = -1;
> >>  			break;
> >> @@ -223,6 +241,10 @@ static int als_capture_sample(struct hid_sensor_hub_device *hsdev,
> >>  		als_state->scan.illum[CHANNEL_SCAN_INDEX_ILLUM] = sample_data;
> >>  		ret = 0;
> >>  		break;
> >> +	case HID_USAGE_SENSOR_LIGHT_COLOR_TEMPERATURE:
> >> +		als_state->scan.illum[CHANNEL_SCAN_INDEX_COLOR_TEMP] = sample_data;
> >> +		ret = 0;
> >> +		break;
> >>  	case HID_USAGE_SENSOR_TIME_TIMESTAMP:
> >>  		als_state->timestamp = hid_sensor_convert_timestamp(&als_state->common_attributes,
> >>  								    *(s64 *)raw_data);
> >> @@ -256,6 +278,17 @@ static int als_parse_report(struct platform_device *pdev,
> >>  			st->als_illum[i].report_id);
> >>  	}
> >>  
> >> +	ret = sensor_hub_input_get_attribute_info(hsdev, HID_INPUT_REPORT, usage_id,
> >> +						  HID_USAGE_SENSOR_LIGHT_COLOR_TEMPERATURE,
> >> +						  &st->als_illum[CHANNEL_SCAN_INDEX_COLOR_TEMP]);
> >> +	if (ret < 0)
> >> +		return ret;
> >> +	als_adjust_channel_bit_mask(channels, CHANNEL_SCAN_INDEX_COLOR_TEMP,
> >> +				    st->als_illum[CHANNEL_SCAN_INDEX_COLOR_TEMP].size);
> >> +
> >> +	dev_dbg(&pdev->dev, "als %x:%x\n", st->als_illum[CHANNEL_SCAN_INDEX_COLOR_TEMP].index,
> >> +		st->als_illum[CHANNEL_SCAN_INDEX_COLOR_TEMP].report_id);
> >> +
> >>  	st->scale_precision = hid_sensor_format_scale(usage_id,
> >>  						      &st->als_illum[CHANNEL_SCAN_INDEX_INTENSITY],
> >>  						      &st->scale_pre_decml, &st->scale_post_decml);
> >> diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-sensor-ids.h
> >> index 13b1e65fbdcc..8af4fb3e0254 100644
> >> --- a/include/linux/hid-sensor-ids.h
> >> +++ b/include/linux/hid-sensor-ids.h
> >> @@ -21,6 +21,7 @@
> >>  #define HID_USAGE_SENSOR_ALS					0x200041
> >>  #define HID_USAGE_SENSOR_DATA_LIGHT				0x2004d0
> >>  #define HID_USAGE_SENSOR_LIGHT_ILLUM				0x2004d1
> >> +#define HID_USAGE_SENSOR_LIGHT_COLOR_TEMPERATURE		0x2004d2
> >>  
> >>  /* PROX (200011) */
> >>  #define HID_USAGE_SENSOR_PROX                                   0x200011  
> 

