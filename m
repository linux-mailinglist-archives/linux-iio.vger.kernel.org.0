Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C540A311EE7
	for <lists+linux-iio@lfdr.de>; Sat,  6 Feb 2021 17:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbhBFQzB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 Feb 2021 11:55:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:56136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230473AbhBFQxT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 6 Feb 2021 11:53:19 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15D7264ECA;
        Sat,  6 Feb 2021 16:52:37 +0000 (UTC)
Date:   Sat, 6 Feb 2021 16:52:34 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ye Xiang <xiang.ye@intel.com>
Cc:     jikos@kernel.org, srinivas.pandruvada@linux.intel.com,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: hid-sensor-als: Add relative hysteresis
 support
Message-ID: <20210206165234.26bf0421@archlinux>
In-Reply-To: <20210201074358.18435-3-xiang.ye@intel.com>
References: <20210201074358.18435-1-xiang.ye@intel.com>
        <20210201074358.18435-3-xiang.ye@intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  1 Feb 2021 15:43:57 +0800
Ye Xiang <xiang.ye@intel.com> wrote:

> Hid sensor als uses relative hysteresis, this patch adds the support.
> 
> Signed-off-by: Ye Xiang <xiang.ye@intel.com>

Looks good to me.

Jonathan

> ---
>  drivers/iio/light/hid-sensor-als.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
> index afcdb424bfb8..85c8a05b73cb 100644
> --- a/drivers/iio/light/hid-sensor-als.c
> +++ b/drivers/iio/light/hid-sensor-als.c
> @@ -54,7 +54,8 @@ static const struct iio_chan_spec als_channels[] = {
>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
>  		BIT(IIO_CHAN_INFO_SCALE) |
>  		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> -		BIT(IIO_CHAN_INFO_HYSTERESIS),
> +		BIT(IIO_CHAN_INFO_HYSTERESIS) |
> +		BIT(IIO_CHAN_INFO_HYSTERESIS_RELATIVE),
>  		.scan_index = CHANNEL_SCAN_INDEX_INTENSITY,
>  	},
>  	{
> @@ -63,7 +64,8 @@ static const struct iio_chan_spec als_channels[] = {
>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
>  		BIT(IIO_CHAN_INFO_SCALE) |
>  		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> -		BIT(IIO_CHAN_INFO_HYSTERESIS),
> +		BIT(IIO_CHAN_INFO_HYSTERESIS) |
> +		BIT(IIO_CHAN_INFO_HYSTERESIS_RELATIVE),
>  		.scan_index = CHANNEL_SCAN_INDEX_ILLUM,
>  	},
>  	IIO_CHAN_SOFT_TIMESTAMP(CHANNEL_SCAN_INDEX_TIMESTAMP)
> @@ -141,6 +143,10 @@ static int als_read_raw(struct iio_dev *indio_dev,
>  		ret_type = hid_sensor_read_raw_hyst_value(
>  				&als_state->common_attributes, val, val2);
>  		break;
> +	case IIO_CHAN_INFO_HYSTERESIS_RELATIVE:
> +		ret_type = hid_sensor_read_raw_hyst_rel_value(
> +				&als_state->common_attributes, val, val2);
> +		break;
>  	default:
>  		ret_type = -EINVAL;
>  		break;
> @@ -168,6 +174,10 @@ static int als_write_raw(struct iio_dev *indio_dev,
>  		ret = hid_sensor_write_raw_hyst_value(
>  				&als_state->common_attributes, val, val2);
>  		break;
> +	case IIO_CHAN_INFO_HYSTERESIS_RELATIVE:
> +		ret = hid_sensor_write_raw_hyst_rel_value(
> +				&als_state->common_attributes, val, val2);
> +		break;
>  	default:
>  		ret = -EINVAL;
>  	}

