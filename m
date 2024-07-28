Return-Path: <linux-iio+bounces-8010-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0D593E8BA
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jul 2024 19:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 082E22817AC
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jul 2024 17:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2A857CBC;
	Sun, 28 Jul 2024 17:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BR/bn9v6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07624F602;
	Sun, 28 Jul 2024 17:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722186228; cv=none; b=m5sPlLiXe9C+nIzBQZoe9/RCfNiPnhq0rxgJ0/vPYFQmOtsRzxI1F57oAAzV2E7VTfzB14VUAKn8YnU2kcvDdpxeRzVBMmbHYMocdRGQ2uG1+S5SVEPyIWYad1d869vJWqc7XzLBhGHWcAc66ZMwFipM9ksFk48XOoXke+I2xnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722186228; c=relaxed/simple;
	bh=nCFOhDOmNWyAYbXckEjXUogTLNIxZJEExMVXVOEhSCg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n/T7uaLa2E0qLuz2DmQOHttm+jUoBvwxy5B4OKgjLSgNA50bAfRSPZ6LihoB3NJ1XoUT9QSMRN3FLjHVSTk8R0NGvJwbD4ZjjHxAYFxCa7X8uaQoD3QWZPXd3KUz/0Fk+MKgUAa04wCg6a1kk/KZLiI/ezAqzsPQLLaqOpB0eik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BR/bn9v6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BB0BC116B1;
	Sun, 28 Jul 2024 17:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722186227;
	bh=nCFOhDOmNWyAYbXckEjXUogTLNIxZJEExMVXVOEhSCg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BR/bn9v6WdSRfpD+7HeZx1mTGD+HOZ6Duo06WFbnzipH1Xh/qy1D8GnxfcMCF2ei9
	 e8PPfcuzFLeqimd/AzzHwKVe/4hTNxGADsNtI8fOOzbcVzh0v9yrkTHVyVCid7eLJn
	 6qWBqr6/abyMZajM9bFQXxhlQbvGkEIcl6nJyP5WkFhtL3rEcuhCwBngGzD3YZZKcC
	 IFv0O4v4boe2XzYdFYaGVRxw9aYw2Niq4/LFnNFRbXGvTbBM4p95trcNtOAC+SCenI
	 +R3yzJQ01aOigDmm8KUjmmfpXp+oKBLMhiWx2GwwyB7ils3NQLWE/0LrBhnM8APzwc
	 CL8bRkjQX2rjg==
Date: Sun, 28 Jul 2024 18:03:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Abhash Jha <abhashkumarjha123@gmail.com>
Cc: linux-iio@vger.kernel.org, anshulusr@gmail.com, lars@metafoo.de,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] iio: light: ltr390: Calculate 'counts_per_uvi'
 dynamically
Message-ID: <20240728180341.7d43808f@jic23-huawei>
In-Reply-To: <20240728151957.310237-3-abhashkumarjha123@gmail.com>
References: <20240727132735.052502ad@jic23-huawei>
	<20240728151957.310237-1-abhashkumarjha123@gmail.com>
	<20240728151957.310237-3-abhashkumarjha123@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Jul 2024 20:49:56 +0530
Abhash Jha <abhashkumarjha123@gmail.com> wrote:

>     counts_per_uvi depends on the current value of gain and
>     resolution. Hence we cannot use the hardcoded value of 96.
>     The `counts_per_uvi` function gives the count based on the
>     current gain and resolution (integration time).
Fix the indent of this description and rewrap to take advantage of up
to 75 chars.

Some unrelated changes in this patch make it look like a lot more than
the relatively small 'real' change.  Make sure those are gone
for v3.  If you feel like adding a patch 4 that makes the white
space cleanup, then that is fine as well.

> 
> Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
> ---
>  drivers/iio/light/ltr390.c | 41 ++++++++++++++++++++++++++++----------
>  1 file changed, 31 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
> index d1a259141..aceb97e3d 100644
> --- a/drivers/iio/light/ltr390.c
> +++ b/drivers/iio/light/ltr390.c
> @@ -45,6 +45,8 @@
>  #define LTR390_UVS_MODE	      BIT(3)
>  #define LTR390_SENSOR_ENABLE  BIT(1)
>  
> +#define LTR390_FRACTIONAL_PRECISION 100
> +
>  /*
>   * At 20-bit resolution (integration time: 400ms) and 18x gain, 2300 counts of
>   * the sensor are equal to 1 UV Index [Datasheet Page#8].
> @@ -122,6 +124,19 @@ static int ltr390_set_mode(struct ltr390_data *data, int mode)
>  	return 0;
>  }
>  
> +static int ltr390_counts_per_uvi(struct ltr390_data *data)
> +{
> +	int orig_gain = 18;
> +	int orig_int_time = 400;
> +	int divisor = orig_gain * orig_int_time;
> +	int gain = data->gain;
> +
> +	int int_time_ms = DIV_ROUND_CLOSEST(data->int_time_us, 1000);
> +	int uvi = DIV_ROUND_CLOSEST(2300 * gain * int_time_ms, divisor);

return DIV_ROUND_CLOSEST()

I assume maths is done like this to avoid overflow? e.g. why not

	return DIV_ROUND_CLOSEST(23 * gain * data->int_time_us, 10 * divisor)

which I think is the same 'maths' as long as 23 * gain * data->int_time_us < 2^31 - 1

If you are avoiding overflow, then add a comment on that so it doesn't get
accidentally broken by a future simplification.



> +
> +	return uvi;
> +}
> +
>  static int ltr390_read_raw(struct iio_dev *iio_device,
>  			   struct iio_chan_spec const *chan, int *val,
>  			   int *val2, long mask)
> @@ -167,8 +182,8 @@ static int ltr390_read_raw(struct iio_dev *iio_device,
>  			if (ret < 0)
>  				return ret;
>  
> -			*val = LTR390_WINDOW_FACTOR;
> -			*val2 = LTR390_COUNTS_PER_UVI;
> +			*val = LTR390_WINDOW_FACTOR * LTR390_FRACTIONAL_PRECISION;
> +			*val2 = ltr390_counts_per_uvi(data);
>  			return IIO_VAL_FRACTIONAL;
>  
>  		case IIO_INTENSITY:
> @@ -202,17 +217,21 @@ static const struct iio_chan_spec ltr390_channels[] = {
>  	{
>  		.type = IIO_UVINDEX,
>  		.scan_index = 0,
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +					BIT(IIO_CHAN_INFO_SCALE),
>  		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
> -		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) | BIT(IIO_CHAN_INFO_SCALE)
> +		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
> +							BIT(IIO_CHAN_INFO_SCALE)
>  	},
>  	/* ALS sensor */
>  	{
>  		.type = IIO_INTENSITY,
>  		.scan_index = 1,
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +					BIT(IIO_CHAN_INFO_SCALE),
>  		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
> -		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) | BIT(IIO_CHAN_INFO_SCALE)
> +		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
> +							BIT(IIO_CHAN_INFO_SCALE)
All unrelated chagnes.

>  	},
>  };
>  
> @@ -261,8 +280,9 @@ static int ltr390_set_int_time(struct ltr390_data *data, int val)
>  	return 0;
>  }
>  
> -static int ltr390_read_avail(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
> -				const int **vals, int *type, int *length, long mask)
> +static int ltr390_read_avail(struct iio_dev *indio_dev,
> +			struct iio_chan_spec const *chan,
> +			const int **vals, int *type, int *length, long mask)
Unrelated change.

>  {
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SCALE:
> @@ -280,8 +300,9 @@ static int ltr390_read_avail(struct iio_dev *indio_dev, struct iio_chan_spec con
>  	}
>  }
>  
> -static int ltr390_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
> -				int val, int val2, long mask)
> +static int ltr390_write_raw(struct iio_dev *indio_dev,
> +			struct iio_chan_spec const *chan,
> +			int val, int val2, long mask)
Unrelted change. Get rid of this for v3.

>  {
>  	struct ltr390_data *data = iio_priv(indio_dev);
>  


