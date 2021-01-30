Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 957AA3097DB
	for <lists+linux-iio@lfdr.de>; Sat, 30 Jan 2021 20:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbhA3TPO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 30 Jan 2021 14:15:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:37360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229990AbhA3TPO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 30 Jan 2021 14:15:14 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7CBF64E11;
        Sat, 30 Jan 2021 19:14:32 +0000 (UTC)
Date:   Sat, 30 Jan 2021 19:14:29 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ye Xiang <xiang.ye@intel.com>
Cc:     jikos@kernel.org, srinivas.pandruvada@linux.intel.com,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: hid-sensor-prox: Fix scale not correct issue
Message-ID: <20210130191429.2c485212@archlinux>
In-Reply-To: <20210130102530.31064-1-xiang.ye@intel.com>
References: <20210130102530.31064-1-xiang.ye@intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 30 Jan 2021 18:25:30 +0800
Ye Xiang <xiang.ye@intel.com> wrote:

> Currently, the proxy sensor scale is zero because it just return the
> exponent directly. To fix this issue, this patch use
> hid_sensor_format_scale to process the scale first then return the
> output.
> 
> Fixes: 39a3a0138f61 ("iio: hid-sensors: Added Proximity Sensor Driver")
> Signed-off-by: Ye Xiang <xiang.ye@intel.com>

Hi Ye Xiang,

There was a bit of fuzz on this so please take a look at
my fixes-togreg branch and check it went in cleanly.


> ---
> v2:
>   - Add Fixes tag
> 
> ---
>  drivers/iio/light/hid-sensor-prox.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
> index 4ab285a418d5..4abcfe48f1d4 100644
> --- a/drivers/iio/light/hid-sensor-prox.c
> +++ b/drivers/iio/light/hid-sensor-prox.c
> @@ -23,6 +23,9 @@ struct prox_state {
>  	struct hid_sensor_common common_attributes;
>  	struct hid_sensor_hub_attribute_info prox_attr;
>  	u32 human_presence;
> +	int scale_pre_decml;
> +	int scale_post_decml;
> +	int scale_precision;
>  };
>  
>  static const u32 prox_sensitivity_addresses[] = {
> @@ -98,8 +101,9 @@ static int prox_read_raw(struct iio_dev *indio_dev,
>  		ret_type = IIO_VAL_INT;
>  		break;
>  	case IIO_CHAN_INFO_SCALE:
> -		*val = prox_state->prox_attr.units;
> -		ret_type = IIO_VAL_INT;
> +		*val = prox_state->scale_pre_decml;
> +		*val2 = prox_state->scale_post_decml;
> +		ret_type = prox_state->scale_precision;
>  		break;
>  	case IIO_CHAN_INFO_OFFSET:
>  		*val = hid_sensor_convert_exponent(
> @@ -221,6 +225,11 @@ static int prox_parse_report(struct platform_device *pdev,
>  	dev_dbg(&pdev->dev, "prox %x:%x\n", st->prox_attr.index,
>  			st->prox_attr.report_id);
>  
> +	st->scale_precision = hid_sensor_format_scale(
> +				hsdev->usage,
> +				&st->prox_attr,
> +				&st->scale_pre_decml, &st->scale_post_decml);
> +
>  	return ret;
>  }
>  

