Return-Path: <linux-iio+bounces-18266-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D84A0A93A16
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 17:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E6D71B6674A
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 15:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871B2214201;
	Fri, 18 Apr 2025 15:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ujkTY7sM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC62433C4;
	Fri, 18 Apr 2025 15:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744991420; cv=none; b=kzh7Cmt+pkoxuVwHwCqAz2mBs4/fbTlE4U+sMWNPCcBFis2/dHPw1dMqxxKp1qVCZHILyMW7RYSgCpK6bievNp5YeT8/RSpOE77FqKEdBzMLnNQLB8jUzUzr4DBKvC8cY2vg7oRvTzunmHbJlGFcq08QDaw01AIItPNKNSbNhZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744991420; c=relaxed/simple;
	bh=lj4gGmxWHJ2C0K+iLE+xhlpcwP1XXgB3fNy5ud5B7Uk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ubhEIFkTTcVKYrMmDBJkDLlYyAymXdtSeQoXBvLKkCNRrc9SlGo4yBViKNg8QhtG1fgbsraz1f2uNxCxkpO0LVfn71lQAc3uR9AAiXXwvshSGgA5fN8ZoZznaIvIog4xHBNUbxB7iMF7nhqSBD8zhjCSdUz30ljomPUCqlZzlnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ujkTY7sM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB6D2C4CEE2;
	Fri, 18 Apr 2025 15:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744991419;
	bh=lj4gGmxWHJ2C0K+iLE+xhlpcwP1XXgB3fNy5ud5B7Uk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ujkTY7sMbk7kGWCzRtCYZGOh96kao3RWiGAeVDhXwWp0DAQsi2iyZ8NvEVp/Pl3qd
	 f4ynJWRXs8BbPqwVUkmmYopktuC40XlXsKXrMfRgoKJg8vHV1ir75uZ0fmPf0Am0Ag
	 Pa6DpB/luZCNNoU9MO2yPdjM2QG9QajUCjLn0sKz+dBGUh7A/+kxQqEpZzYz8vjjp4
	 iYeFkjROP1kjm9VWnPlI02A6zODd4MVIvQNdHMfYsAaK9zx+clHReOtaf1qyFGlOfI
	 g564Fl2G1+qPpvU4lFYRIaUUBBO4UrV0eGVCDEurGY78dD1zTxHF0biaAGwxWGgLqM
	 J41/L5aMWy5WA==
Date: Fri, 18 Apr 2025 16:50:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Cc: gregkh@linuxfoundation.org, lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
 Michael.Hennerich@analog.com, skhan@linuxfoundation.org,
 kernelmentees@lists.linuxfoundation.org
Subject: Re: [PATCH] iio: accel: adis16203: Fix single-axis representation
 and CALIBBIAS handling
Message-ID: <20250418165012.53c9bb85@jic23-huawei>
In-Reply-To: <20250415222652.545026-1-gshahrouzi@gmail.com>
References: <20250415222652.545026-1-gshahrouzi@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Apr 2025 18:26:52 -0400
Gabriel Shahrouzi <gshahrouzi@gmail.com> wrote:

> The ADIS16203 is a single-axis 360 degree inclinometer. The previous
> driver code incorrectly represented this by defining separate X and Y
> inclination channels based on the two different output format registers
> (0x0C for 0-360 deg, 0x0E for +/-180 deg). This violated IIO conventions
> and misrepresented the hardware's single angle output. The 'Fixme'
> comment on the original Y channel definition indicated this known issue.
> 
> Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
> ---
> Not sure to put a fixes tag here or not because the driver used to be
> spread out across multiple files until it was whittled down to one file
> using a common interface for similar devices.

No fixes tag for this one is the right choice. It is a complex bit of
ABI abuse.

> ---
>  drivers/staging/iio/accel/adis16203.c | 52 ++++++++++++++++-----------
>  1 file changed, 31 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16203.c b/drivers/staging/iio/accel/adis16203.c
> index c1c73308800c5..73288121bf0bd 100644
> --- a/drivers/staging/iio/accel/adis16203.c
> +++ b/drivers/staging/iio/accel/adis16203.c
> @@ -28,11 +28,11 @@
>  /* Output, temperature */
>  #define ADIS16203_TEMP_OUT       0x0A
>  
> -/* Output, x-axis inclination */
> -#define ADIS16203_XINCL_OUT      0x0C
> +/* Output, 360 deg format */
> +#define ADIS16203_INCL_OUT       0x0C
>  
> -/* Output, y-axis inclination */
> -#define ADIS16203_YINCL_OUT      0x0E
> +/* Output, +/-180 deg format */
> +#define ADIS16203_INCL_180_OUT   0x0E
>  
>  /* Incline null calibration */
>  #define ADIS16203_INCL_NULL      0x18
> @@ -128,8 +128,7 @@
>  #define ADIS16203_ERROR_ACTIVE          BIT(14)
>  
>  enum adis16203_scan {
> -	 ADIS16203_SCAN_INCLI_X,
> -	 ADIS16203_SCAN_INCLI_Y,
> +	 ADIS16203_SCAN_INCLI,
>  	 ADIS16203_SCAN_SUPPLY,
>  	 ADIS16203_SCAN_AUX_ADC,
>  	 ADIS16203_SCAN_TEMP,
> @@ -137,10 +136,6 @@ enum adis16203_scan {
>  
>  #define DRIVER_NAME		"adis16203"
>  
> -static const u8 adis16203_addresses[] = {
> -	[ADIS16203_SCAN_INCLI_X] = ADIS16203_INCL_NULL,
> -};
> -
>  static int adis16203_write_raw(struct iio_dev *indio_dev,
>  			       struct iio_chan_spec const *chan,
>  			       int val,
> @@ -148,10 +143,15 @@ static int adis16203_write_raw(struct iio_dev *indio_dev,
>  			       long mask)
>  {
>  	struct adis *st = iio_priv(indio_dev);
> -	/* currently only one writable parameter which keeps this simple */
> -	u8 addr = adis16203_addresses[chan->scan_index];
>  
> -	return adis_write_reg_16(st, addr, val & 0x3FFF);
> +	switch (mask) {
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		if (chan->scan_index != ADIS16203_SCAN_INCLI)
> +			return -EINVAL;
> +		return adis_write_reg_16(st, ADIS16203_INCL_NULL, val & 0x3FFF);

I would check for out of range before you get here rather than masking.
Clearly the old code just masked, but we can do better given you are refactoring
it.  If an invalid setting is requested best thing is normally to just return
an error so userspace can see it was ignored.


> +	default:
> +		return -EINVAL;
> +	}
>  }
>  
>  static int adis16203_read_raw(struct iio_dev *indio_dev,
> @@ -161,7 +161,6 @@ static int adis16203_read_raw(struct iio_dev *indio_dev,
>  {
>  	struct adis *st = iio_priv(indio_dev);
>  	int ret;
> -	u8 addr;
>  	s16 val16;
>  
>  	switch (mask) {
> @@ -194,8 +193,9 @@ static int adis16203_read_raw(struct iio_dev *indio_dev,
>  		*val = 25000 / -470 - 1278; /* 25 C = 1278 */
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_CALIBBIAS:
> -		addr = adis16203_addresses[chan->scan_index];
> -		ret = adis_read_reg_16(st, addr, &val16);
> +		if (chan->scan_index != ADIS16203_SCAN_INCLI)
> +			return -EINVAL;
> +		ret = adis_read_reg_16(st, ADIS16203_INCL_NULL, &val16);
>  		if (ret)
>  			return ret;
>  		*val = sign_extend32(val16, 13);
> @@ -206,13 +206,23 @@ static int adis16203_read_raw(struct iio_dev *indio_dev,
>  }
>  
>  static const struct iio_chan_spec adis16203_channels[] = {
> +	{
> +		.type = IIO_INCLI,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +					BIT(IIO_CHAN_INFO_SCALE) |
> +					BIT(IIO_CHAN_INFO_CALIBBIAS),
> +		.address = ADIS16203_INCL_180_OUT,
> +		.scan_index = ADIS16203_SCAN_INCLI,
> +		.scan_type = {
> +			.sign = 's',
> +			.realbits = 14,
> +			.storagebits = 16,
> +			.shift = 0,

No need for setting shift to 0 explicitly.  It will happen anyway and
a shift of 0 is a fairly natural default.

> +			.endianness = IIO_CPU,
> +		},
> +	},
>  	ADIS_SUPPLY_CHAN(ADIS16203_SUPPLY_OUT, ADIS16203_SCAN_SUPPLY, 0, 12),
>  	ADIS_AUX_ADC_CHAN(ADIS16203_AUX_ADC, ADIS16203_SCAN_AUX_ADC, 0, 12),
> -	ADIS_INCLI_CHAN(X, ADIS16203_XINCL_OUT, ADIS16203_SCAN_INCLI_X,
> -			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
> -	/* Fixme: Not what it appears to be - see data sheet */
> -	ADIS_INCLI_CHAN(Y, ADIS16203_YINCL_OUT, ADIS16203_SCAN_INCLI_Y,
> -			0, 0, 14),
Why the ordering change?  I don't think it matters in practice, but easier to
review of we keep that ordering the same as then no need to think about it at
all!

Jonathan

>  	ADIS_TEMP_CHAN(ADIS16203_TEMP_OUT, ADIS16203_SCAN_TEMP, 0, 12),
>  	IIO_CHAN_SOFT_TIMESTAMP(5),
>  };


