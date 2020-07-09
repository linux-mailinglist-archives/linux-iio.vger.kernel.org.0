Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89105219AFC
	for <lists+linux-iio@lfdr.de>; Thu,  9 Jul 2020 10:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgGIIik (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 Jul 2020 04:38:40 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55842 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgGIIik (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 Jul 2020 04:38:40 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 7B4A526040C
Subject: Re: [PATCH v2] iio: cros_ec_accel_legacy: Add Read Only frequency
 entries
To:     Gwendal Grignou <gwendal@chromium.org>, jic23@kernel.org,
        bleung@chromium.org
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org
References: <20200709020544.1938754-1-gwendal@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <5f936f45-0110-98ad-2b0f-807379f850e2@collabora.com>
Date:   Thu, 9 Jul 2020 10:38:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200709020544.1938754-1-gwendal@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Gwendal,

On 9/7/20 4:05, Gwendal Grignou wrote:
> Report to user space that 10Hz is the sampling frequency of
> the accelerometers in legacy mode, and it can not be changed.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> ---
>  drivers/iio/accel/cros_ec_accel_legacy.c | 48 +++++++++++++++++++++++-
>  1 file changed, 47 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel/cros_ec_accel_legacy.c
> index 2532b9ad33842..30c694c18726e 100644
> --- a/drivers/iio/accel/cros_ec_accel_legacy.c
> +++ b/drivers/iio/accel/cros_ec_accel_legacy.c
> @@ -33,6 +33,11 @@
>   */
>  #define ACCEL_LEGACY_NSCALE 9586168
>  
> +/*
> + * Sensor frequency is hard-coded to 10Hz.
> + */
> +static const int cros_ec_legacy_sample_freq[] = { 10, 0 };
> +
>  static int cros_ec_accel_legacy_read_cmd(struct iio_dev *indio_dev,
>  				  unsigned long scan_mask, s16 *data)
>  {
> @@ -96,6 +101,11 @@ static int cros_ec_accel_legacy_read(struct iio_dev *indio_dev,
>  		*val = 0;
>  		ret = IIO_VAL_INT;
>  		break;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val = cros_ec_legacy_sample_freq[0];
> +		*val2 = cros_ec_legacy_sample_freq[1];
> +		ret = IIO_VAL_INT_PLUS_MICRO;
> +		break;
>  	default:
>  		ret = cros_ec_sensors_core_read(st, chan, val, val2,
>  				mask);
> @@ -120,9 +130,41 @@ static int cros_ec_accel_legacy_write(struct iio_dev *indio_dev,
>  	return -EINVAL;
>  }
>  
> +/**
> + * cros_ec_accel_legacy_read_avail() - get available values
> + * @indio_dev:		pointer to state information for device
> + * @chan:	channel specification structure table
> + * @vals:	list of available values
> + * @type:	type of data returned
> + * @length:	number of data returned in the array
> + * @mask:	specifies which values to be requested
> + *
> + * Return:	an error code or IIO_AVAIL_LIST
> + */
> +static int cros_ec_accel_legacy_read_avail(struct iio_dev *indio_dev,
> +					   struct iio_chan_spec const *chan,
> +					   const int **vals,
> +					   int *type,
> +					   int *length,
> +					   long mask)
> +{
> +	struct cros_ec_sensors_core_state *state = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*length = ARRAY_SIZE(cros_ec_legacy_sample_freq);
> +		*vals = cros_ec_legacy_sample_freq;
> +		*type = IIO_VAL_INT_PLUS_MICRO;
> +		return IIO_AVAIL_LIST;
> +	}
> +
> +	return -EINVAL;
> +}
> +
>  static const struct iio_info cros_ec_accel_legacy_info = {
>  	.read_raw = &cros_ec_accel_legacy_read,
>  	.write_raw = &cros_ec_accel_legacy_write,
> +	.read_avail = &cros_ec_accel_legacy_read_avail,
>  };
>  
>  /*
> @@ -142,7 +184,11 @@ static const struct iio_info cros_ec_accel_legacy_info = {
>  		.info_mask_separate =					\
>  			BIT(IIO_CHAN_INFO_RAW) |			\
>  			BIT(IIO_CHAN_INFO_CALIBBIAS),			\
> -		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SCALE),	\
> +		.info_mask_shared_by_all =				\
> +			BIT(IIO_CHAN_INFO_SCALE) |			\
> +			BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
> +		.info_mask_shared_by_all_available =			\
> +			BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
>  		.ext_info = cros_ec_sensors_ext_info,			\
>  		.scan_type = {						\
>  			.sign = 's',					\
> 
