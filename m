Return-Path: <linux-iio+bounces-16339-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 402C6A4DF65
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 14:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61A42176C35
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 13:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679CD2040BE;
	Tue,  4 Mar 2025 13:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a39L2NS2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D0B202F88;
	Tue,  4 Mar 2025 13:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741095400; cv=none; b=Tuj/blbESWhehsUW9JAywRDDUAcfCFD7MxFv9OsdbBjoikhLQEeE6ka8hE6NLMlONOOL1trv3CUKeSIu4G+C3Kb9YQUC0N0tf7GBcQYbiCiDTTC2u50JT+tlpr5/FI1m3w/H3nJmY/uOHGFuMLQj7cRp+xRuY+iDIGdGUTD/f7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741095400; c=relaxed/simple;
	bh=dIc7ZWMjUrT6oNcZ8E4/2SkmGDQ9C98PWVBuCcWoeOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TNyTw92z4lJDTq+9Oc/+GjfBu5Z5q7yz/zhlgOM5NsD8rZEOIInt1xRZUXzWzTq+BZelGeM4EHt99BIqneb0BCdBIyI00R9dCVjfCg037Ay8K+iMI6cVDIJxszKF/paqBlW8QZIfCN4HLQcmkKE5grzIZ4S1QawGYVzmWjV0Qoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a39L2NS2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A49A6C4CEE5;
	Tue,  4 Mar 2025 13:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741095399;
	bh=dIc7ZWMjUrT6oNcZ8E4/2SkmGDQ9C98PWVBuCcWoeOQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a39L2NS2Vf9hG3dvrvXrDSiUoCS9LHIMEY75cvGzTaBZWQISA416ttcmLhP+vAWGf
	 Pce5s5titmzDkySVIlx4FAHBJ+RQQZ5dRCd//L9Gy8Pvv5Ofn31lj1TJ39P4d8fBGW
	 qyJIdW5M2Z2TjJ8GEP/SD2XPbw7m9hhpLU7yVJ6TdwkVYomSk/oO8e1l6WRvc7tij7
	 BEY7uOjh4/ym1k0fAk+ATy7aFiOjM+IhG1biCFNekTRe5SfkIFUFLKE9MW93xCWn9S
	 OE+ezK/LBDA+5rAbyG4iTccw5SiIAmV+30butbmPmo1SrFiusEs8+eaoJieiC/eODc
	 GI3custQieJ6A==
Date: Tue, 4 Mar 2025 13:36:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v3 10/15] iio: accel: adxl345: extend sample frequency
 adjustments
Message-ID: <20250304133626.709221c1@jic23-huawei>
In-Reply-To: <20250220104234.40958-11-l.rubusch@gmail.com>
References: <20250220104234.40958-1-l.rubusch@gmail.com>
	<20250220104234.40958-11-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Feb 2025 10:42:29 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Introduce enums and functions to work with the sample frequency
> adjustments. Let the sample frequency adjust via IIO and configure
> a reasonable default.
> 
> Replace the old static sample frequency handling. The patch is in
> preparation for activity/inactivity handling. During adjustment of
> bw registers, measuring is disabled and afterwards enabled again.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Hi Lothar, a few minor things inline.


> +static int adxl345_find_odr(struct adxl345_state *st, int val,
> +			    int val2, enum adxl345_odr *odr)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(adxl345_odr_tbl); i++)
> +		if (val == adxl345_odr_tbl[i][0] &&
> +		    val2 == adxl345_odr_tbl[i][1])
> +			break;
> +
> +	if (i == ARRAY_SIZE(adxl345_odr_tbl))
> +		return -EINVAL;
> +
> +	*odr = i;
> +
> +	return 0;
Unless there will be more to do here later it would be fine to
move this setting *odr = i and return into the loop condition.
Then you can return -EINVAL directly if the loop finishes.
i.e.
	for (i = 0; i < ARRAY_SIZE(adxl345_odr_tbl); i++) {
		if (val == adxl345_odr_tbl[i][0] &&
		    val2 == adxl345_odr_tbl[i][1]) {
			*odr = i;
			return 0;
		}
	}
	return -EINVAL;

This is a very common pattern when there isn't much
to do on a match.

> +}
> +
> +static int adxl345_set_odr(struct adxl345_state *st, enum adxl345_odr odr)
> +{
> +	int ret;
> +
> +	ret = regmap_update_bits(st->regmap, ADXL345_REG_BW_RATE,
> +				 ADXL345_BW_RATE_MSK,
> +				 FIELD_PREP(ADXL345_BW_RATE_MSK, odr));
> +	if (ret)
> +		return ret;
I guess this makes sense in later patches, but if it doesn't get more
complex
	return regmap()

> +
> +	return 0;
> +}
> +
> +static int adxl345_read_avail(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      const int **vals, int *type,
> +			      int *length, long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*vals = (int *)adxl345_odr_tbl;
> +		*type = IIO_VAL_INT_PLUS_MICRO;
> +		*length = ARRAY_SIZE(adxl345_odr_tbl) * 2;
> +		return IIO_AVAIL_LIST;
> +	}
> +
> +	return -EINVAL;
> +}
> +
>  static int adxl345_read_raw(struct iio_dev *indio_dev,
>  			    struct iio_chan_spec const *chan,
>  			    int *val, int *val2, long mask)
>  {
>  	struct adxl345_state *st = iio_priv(indio_dev);
>  	__le16 accel;
> -	long long samp_freq_nhz;
>  	unsigned int regval;
> +	enum adxl345_odr odr;
>  	int ret;
>  
>  	switch (mask) {
> @@ -455,14 +542,12 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		ret = regmap_read(st->regmap, ADXL345_REG_BW_RATE, &regval);
> -		if (ret < 0)
> +		if (ret)
>  			return ret;

Change is reasonable but unrelated to this patch that I can see. Should
really be a separate patch cleaning these up for all regmap calls.
I have no idea if there are others.

> -
> -		samp_freq_nhz = ADXL345_BASE_RATE_NANO_HZ <<
> -				(regval & ADXL345_BW_RATE);
> -		*val = div_s64_rem(samp_freq_nhz, NANOHZ_PER_HZ, val2);
> -
> -		return IIO_VAL_INT_PLUS_NANO;
> +		odr = FIELD_GET(ADXL345_BW_RATE_MSK, regval);
> +		*val = adxl345_odr_tbl[odr][0];
> +		*val2 = adxl345_odr_tbl[odr][1];
> +		return IIO_VAL_INT_PLUS_MICRO;
>  	}
>  
>  	return -EINVAL;
> @@ -473,7 +558,12 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
>  			     int val, int val2, long mask)
>  {
>  	struct adxl345_state *st = iio_priv(indio_dev);
> -	s64 n;
> +	enum adxl345_odr odr;
> +	int ret;
> +
> +	ret = adxl345_set_measure_en(st, false);
> +	if (ret)
> +		return ret;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_CALIBBIAS:
> @@ -481,20 +571,24 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
>  		 * 8-bit resolution at +/- 2g, that is 4x accel data scale
>  		 * factor
>  		 */
> -		return regmap_write(st->regmap,
> -				    ADXL345_REG_OFS_AXIS(chan->address),
> -				    val / 4);
> +		ret = regmap_write(st->regmap,
> +				   ADXL345_REG_OFS_AXIS(chan->address),
> +				   val / 4);
I'd do local error handling here...
> +		break;
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> -		n = div_s64(val * NANOHZ_PER_HZ + val2,
> -			    ADXL345_BASE_RATE_NANO_HZ);
> -
> -		return regmap_update_bits(st->regmap, ADXL345_REG_BW_RATE,
> -					  ADXL345_BW_RATE,
> -					  clamp_val(ilog2(n), 0,
> -						    ADXL345_BW_RATE));
> +		ret = adxl345_find_odr(st, val, val2, &odr);
> +		if (ret)
> +			return ret;
> +		ret = adxl345_set_odr(st, odr);
and here just to be consistent with the case above here
		if (ret)
			return ret;
> +		break;
> +	default:
> +		return -EINVAL;
>  	}
>  
> -	return -EINVAL;
> +	if (ret)
This this one is never hit.

> +		return ret;
> +
> +	return adxl345_set_measure_en(st, true);
>  }
>  
>  static int adxl345_read_event_config(struct iio_dev *indio_dev,
> @@ -747,7 +841,7 @@ static int adxl345_write_raw_get_fmt(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_CALIBBIAS:
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> -		return IIO_VAL_INT_PLUS_NANO;
> +		return IIO_VAL_INT_PLUS_MICRO;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -760,19 +854,6 @@ static void adxl345_powerdown(void *ptr)
>  	adxl345_set_measure_en(st, false);
>  }
>  
> -static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(
> -"0.09765625 0.1953125 0.390625 0.78125 1.5625 3.125 6.25 12.5 25 50 100 200 400 800 1600 3200"
> -);


