Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE4F13BAE0C
	for <lists+linux-iio@lfdr.de>; Sun,  4 Jul 2021 19:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbhGDRaU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 4 Jul 2021 13:30:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:50146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229575AbhGDRaU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 4 Jul 2021 13:30:20 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACFD0613B1;
        Sun,  4 Jul 2021 17:27:42 +0000 (UTC)
Date:   Sun, 4 Jul 2021 18:30:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ivan Mikhaylov <i.mikhaylov@yadro.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] iio: proximity: vcnl3020: add threshold options
Message-ID: <20210704183007.67e27890@jic23-huawei>
In-Reply-To: <20210621143051.200800-3-i.mikhaylov@yadro.com>
References: <20210621143051.200800-1-i.mikhaylov@yadro.com>
        <20210621143051.200800-3-i.mikhaylov@yadro.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 21 Jun 2021 17:30:51 +0300
Ivan Mikhaylov <i.mikhaylov@yadro.com> wrote:

> Add the low/high threshold options.
> 
> Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>
Hi,
A few comments inline.

Thanks,

Jonathan

> ---
>  drivers/iio/proximity/vcnl3020.c | 95 ++++++++++++++++++++++++++++++++
>  1 file changed, 95 insertions(+)
> 
> diff --git a/drivers/iio/proximity/vcnl3020.c b/drivers/iio/proximity/vcnl3020.c
> index 2e65127d5359..f3320de014e4 100644
> --- a/drivers/iio/proximity/vcnl3020.c
> +++ b/drivers/iio/proximity/vcnl3020.c
> @@ -255,6 +255,91 @@ static bool vcnl3020_is_thr_enabled(struct vcnl3020_data *data)
>  	return !!(icr & VCNL_ICR_THRES_EN);
>  }
>  
> +static int vcnl3020_read_event(struct iio_dev *indio_dev,
> +			       const struct iio_chan_spec *chan,
> +			       enum iio_event_type type,
> +			       enum iio_event_direction dir,
> +			       enum iio_event_info info,
> +			       int *val, int *val2)
> +{
> +	int rc;
> +	struct vcnl3020_data *data = iio_priv(indio_dev);
> +	__be16 res;
> +
> +	switch (info) {
> +	case IIO_EV_INFO_VALUE:
> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:
> +			rc = regmap_bulk_read(data->regmap, VCNL_PS_HI_THR_HI,
> +					      &res, sizeof(res));
> +			if (rc < 0)
> +				return rc;
> +			*val = be16_to_cpu(res);
> +			return IIO_VAL_INT;
> +		case IIO_EV_DIR_FALLING:
> +			rc = regmap_bulk_read(data->regmap, VCNL_PS_LO_THR_HI,
> +					      &res, sizeof(res));
> +			if (rc < 0)
> +				return rc;
> +			*val = be16_to_cpu(res);
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int vcnl3020_write_event(struct iio_dev *indio_dev,
> +				const struct iio_chan_spec *chan,
> +				enum iio_event_type type,
> +				enum iio_event_direction dir,
> +				enum iio_event_info info,
> +				int val, int val2)
> +{
> +	int rc;
> +	__be16 buf;
> +	struct vcnl3020_data *data = iio_priv(indio_dev);
> +
> +	rc = iio_device_claim_direct_mode(indio_dev);
Why? 

The intent of that function is to protect against mode transitions, so we
can't move from sysfs type captures to interrupt driven ones whilst
a sysfs read is in progress.   That's not the case here (or in the existing
driver where this is used).   So I think what you really want is a locally
defined lock that allows you to ensure device state is consistent if
you have any read / modify / write cycles.

For these particular registers I'm not even seeing that. Regmap has it's
own locking to avoid concurrency issues inside it's functions, so I'm not
sure you need a lock at all.

> +	if (rc)
> +		return rc;
> +
> +	switch (info) {
> +	case IIO_EV_INFO_VALUE:
> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:
> +			/* 16 bit word/ low * high */
> +			buf = cpu_to_be16(val);
> +			rc = regmap_bulk_write(data->regmap, VCNL_PS_HI_THR_HI,
> +					       &buf, sizeof(buf));
> +			if (rc < 0)
> +				goto out_release_direct_mode;
> +			rc = IIO_VAL_INT;
> +			goto out_release_direct_mode;
> +		case IIO_EV_DIR_FALLING:
> +			buf = cpu_to_be16(val);
> +			rc = regmap_bulk_write(data->regmap, VCNL_PS_LO_THR_HI,
> +					       &buf, sizeof(buf));
> +			if (rc < 0)
> +				goto out_release_direct_mode;
> +			rc = IIO_VAL_INT;
> +			goto out_release_direct_mode;
> +		default:
> +			rc = -EINVAL;
> +			goto out_release_direct_mode;
> +		}
> +	default:
> +		rc = -EINVAL;
> +		goto out_release_direct_mode;
> +	}
> +out_release_direct_mode:
> +	iio_device_release_direct_mode(indio_dev);
> +
> +	return rc;
> +}
> +
>  static int vcnl3020_enable_periodic(struct iio_dev *indio_dev,
>  				    struct vcnl3020_data *data)
>  {
> @@ -356,6 +441,14 @@ static int vcnl3020_read_event_config(struct iio_dev *indio_dev,
>  
>  static const struct iio_event_spec vcnl3020_event_spec[] = {
>  	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_RISING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE),
> +	}, {
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_FALLING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE),
> +	}, {
>  		.type = IIO_EV_TYPE_THRESH,
>  		.dir = IIO_EV_DIR_EITHER,
>  		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
> @@ -445,6 +538,8 @@ static const struct iio_info vcnl3020_info = {
>  	.read_raw = vcnl3020_read_raw,
>  	.write_raw = vcnl3020_write_raw,
>  	.read_avail = vcnl3020_read_avail,
> +	.read_event_value = vcnl3020_read_event,
> +	.write_event_value = vcnl3020_write_event,
>  	.read_event_config = vcnl3020_read_event_config,
>  	.write_event_config = vcnl3020_write_event_config,
>  };

