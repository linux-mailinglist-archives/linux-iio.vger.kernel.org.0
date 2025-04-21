Return-Path: <linux-iio+bounces-18422-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F300A9507B
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 13:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46D2A188DBDC
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 11:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926602641E2;
	Mon, 21 Apr 2025 11:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TuY4cpPl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EA62580C4;
	Mon, 21 Apr 2025 11:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745236445; cv=none; b=GNwB/Bjwrq5staj8iPkC3uCGJeZHUjqkOwYUHcfbDOwlBYMhn6su27ywGWuH2qysiBKk3H8mfRMc+XLcEIzVu/o4s9cT2V3HqF+5C6by5RwU9RpyS+o7WahccJV1BXOnQHwPQsjoJrHYrcRUrPkdjz1rwil2a3MgV3USRaKAlho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745236445; c=relaxed/simple;
	bh=i0vpEwAFyN6bqWLL2Ie++Df4in13XY7IEiHkXqSQIr4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OK8Q0RchaBsg+SDIT9+ZtQne14sC9V7ECx9rC1aTHOhr5ARskxZm+u9aKMcN4bKDtX5c4sHL+NWpwRzJx139i1+Sfz539/WxE2BXw/Jb5YKzFiADBaNjw8eQDmtx/g9L6eB2sNU7yUM82viaiOfOTwri+XsrjHPkuJx/nsGAR08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TuY4cpPl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C46A9C4CEE4;
	Mon, 21 Apr 2025 11:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745236444;
	bh=i0vpEwAFyN6bqWLL2Ie++Df4in13XY7IEiHkXqSQIr4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TuY4cpPl4vhyDTXO47vxoNTH1zI7YuAdlFUfxkNZAQsZ2712nzB5h58/WGq0NDvxV
	 rVF6RQ/ULgQfgzHZKI/+/LaE7R1NkMjsOgdMjBk5P8c3WIvXyg94WNB8+3+Scuw+xj
	 p6WWRMIJ0tN4tfnq6o1EDL42aIPclvy9xoMiWaZsMaOK5iyYo5W/5UP0TeZ0hmafi5
	 JXF+r4pZZhKpc5WSX1JoRZDjSrfXYybYT7dI8GROQKoVHe70g6kwBQc6z1qNZKW347
	 mc80LRMzo8+Mhjt9QjzEJG8lgv5WjIJNpudLyEQMsZOt+wq0djWGOSM5YhCA8cwCSY
	 tZDzP+HTw3OjA==
Date: Mon, 21 Apr 2025 12:53:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Cc: gregkh@linuxfoundation.org, lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
 Michael.Hennerich@analog.com, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v2] staging: iio: accel: adis16203: Fix single-axis
 representation
Message-ID: <20250421125357.571c429e@jic23-huawei>
In-Reply-To: <20250418173313.629606-1-gshahrouzi@gmail.com>
References: <20250418173313.629606-1-gshahrouzi@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Apr 2025 13:33:12 -0400
Gabriel Shahrouzi <gshahrouzi@gmail.com> wrote:

> The ADIS16203 is a single-axis 360 degree inclinometer. The previous
> driver code incorrectly represented this by defining separate X and Y
> inclination channels based on the two different output format registers
> (0x0C for 0-360 deg, 0x0E for +/-180 deg). This violated IIO conventions
> and misrepresented the hardware's single angle output. The 'Fixme'
> comment on the original Y channel definition indicated this known issue.
> 
> Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>

Hi. A few comments inline.
Mostly that this is doing several unrelated things now.
I missed that in v1 I guess. Sorry about that!

Jonathan


> ---
> Changes in v2:
> 	- Check write value range in adis16203_write_raw.
> 	- Remove 0x3FFF mask in adis16203_write_raw.
> 	- Remove explicit shift = 0 in channel definition.
> 	- Keep original channel ordering.
> 	- Add staging prefix to subject line.
> ---
>  drivers/staging/iio/accel/adis16203.c | 53 ++++++++++++++++-----------
>  1 file changed, 32 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16203.c b/drivers/staging/iio/accel/adis16203.c
> index c1c73308800c5..620e0b96d3b22 100644
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
> @@ -148,10 +143,17 @@ static int adis16203_write_raw(struct iio_dev *indio_dev,
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

Why is this change related to dropping of channels?

> +			return -EINVAL;
> +		if (val < -BIT(13) || val >= BIT(13))
Or this one?

Seems to me these should be in a separate patch.

> +			return -EINVAL;
> +		return adis_write_reg_16(st, ADIS16203_INCL_NULL, val);
> +	default:
> +		return -EINVAL;
> +	}
>  }
>  
>  static int adis16203_read_raw(struct iio_dev *indio_dev,
> @@ -161,7 +163,6 @@ static int adis16203_read_raw(struct iio_dev *indio_dev,
>  {
>  	struct adis *st = iio_priv(indio_dev);
>  	int ret;
> -	u8 addr;
>  	s16 val16;
>  
>  	switch (mask) {
> @@ -194,8 +195,9 @@ static int adis16203_read_raw(struct iio_dev *indio_dev,
>  		*val = 25000 / -470 - 1278; /* 25 C = 1278 */
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_CALIBBIAS:
> -		addr = adis16203_addresses[chan->scan_index];
> -		ret = adis_read_reg_16(st, addr, &val16);
> +		if (chan->scan_index != ADIS16203_SCAN_INCLI)
> +			return -EINVAL;
This looks to be defensive coding.  Is calibbias registered for any other
channels?  If not this can't get called anyway.

I don't mind this sort of defensive check if it adds some level
of readability to the code by making it clear what it is for, but the
fact it uses the INCL_NULL kind of makes that obvious anyway.

> +		ret = adis_read_reg_16(st, ADIS16203_INCL_NULL, &val16);
>  		if (ret)
>  			return ret;
>  		*val = sign_extend32(val16, 13);
> @@ -208,11 +210,20 @@ static int adis16203_read_raw(struct iio_dev *indio_dev,
>  static const struct iio_chan_spec adis16203_channels[] = {
>  	ADIS_SUPPLY_CHAN(ADIS16203_SUPPLY_OUT, ADIS16203_SCAN_SUPPLY, 0, 12),
>  	ADIS_AUX_ADC_CHAN(ADIS16203_AUX_ADC, ADIS16203_SCAN_AUX_ADC, 0, 12),
> -	ADIS_INCLI_CHAN(X, ADIS16203_XINCL_OUT, ADIS16203_SCAN_INCLI_X,
> -			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
> -	/* Fixme: Not what it appears to be - see data sheet */
> -	ADIS_INCLI_CHAN(Y, ADIS16203_YINCL_OUT, ADIS16203_SCAN_INCLI_Y,
> -			0, 0, 14),
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
> +			.endianness = IIO_CPU,
> +		},
> +	},
>  	ADIS_TEMP_CHAN(ADIS16203_TEMP_OUT, ADIS16203_SCAN_TEMP, 0, 12),
>  	IIO_CHAN_SOFT_TIMESTAMP(5),
>  };


