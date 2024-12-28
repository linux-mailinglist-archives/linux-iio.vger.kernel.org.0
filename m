Return-Path: <linux-iio+bounces-13831-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 675D49FDAC3
	for <lists+linux-iio@lfdr.de>; Sat, 28 Dec 2024 14:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 041C81620B0
	for <lists+linux-iio@lfdr.de>; Sat, 28 Dec 2024 13:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E57B14AD3D;
	Sat, 28 Dec 2024 13:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qxBKK3ta"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB714382;
	Sat, 28 Dec 2024 13:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735393784; cv=none; b=tCrWo/MEg4jSRinVTuLOROZdt0h2H5WbdGL+7ImCB3D2qxmC7MgJ3Xk7+fv8wOKCSVwCA1N56NmnXD6aRwVBoqOepX3y0kiUxc6fZHQ/Je1YyMKJjHzD2GjeWzROOmfjHJiYqCMa7FFaKhdWg24KBb5zfxLNtqKokY3OKJoUDjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735393784; c=relaxed/simple;
	bh=Uf3FwWFN6qMD3hjszLA60RJPph/BOqa10OWUnHSftvM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i6Fxf8I3SqLuTLSJ6HjFni+vnGq5Fgjor/w99cXtbH3dq+hqvvqQ9IENiuuqk4RkVANER+W0J2gJcPurWOeqkvrlFPDECC+rcJ6+/Ehzym6ObQz+UDZSs6zknlkL4oc1zNYpAKw12g0Vi8bnoFU+dYKoHk0v1fYBzWYDntToNOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qxBKK3ta; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DBE0C4CECD;
	Sat, 28 Dec 2024 13:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735393784;
	bh=Uf3FwWFN6qMD3hjszLA60RJPph/BOqa10OWUnHSftvM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qxBKK3ta0r7akYcwAGAXw8DgHzUfxzHpXWvfY1yQa0ILk+24qqx50/aTgsMC68wuK
	 +m0m9jztvPLXKhWDGLf9WKUtZ8UUyAwZEcicYFxKGHb0B9uX4c6T2Mm/eaIKbpXt91
	 951bDVEDAEx9GkYem1Cz+jhHAnr7FQagUbr4Mi3ndutRJva9i9K9C6UtQ1oyTdokQV
	 1GtAn/smuK5l1yW+8wgoIy7A4tJa1V1y8m+/E2Hlm/0PBAFEUsZbCkHMg5iW78gJam
	 7VHzRcvukFTB4ujA8/1Irzm5W8kSbMmSs0KpT71S38guyiyEjzLRVvatLFMdpze4Jz
	 YQakj6DEyMmhQ==
Date: Sat, 28 Dec 2024 13:49:34 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Julien Stephan <jstephan@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC v2 1/4] iio: adc: ad7380: do not use
 iio_device_claim_direct_scoped anymore
Message-ID: <20241228134934.38e69020@jic23-huawei>
In-Reply-To: <20241224-ad7380-add-alert-support-v2-1-7c89b2bf7cb3@baylibre.com>
References: <20241224-ad7380-add-alert-support-v2-0-7c89b2bf7cb3@baylibre.com>
	<20241224-ad7380-add-alert-support-v2-1-7c89b2bf7cb3@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Dec 2024 10:34:30 +0100
Julien Stephan <jstephan@baylibre.com> wrote:

> Rollback and remove the scoped version of iio_dvice_claim_direct_mode.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  drivers/iio/adc/ad7380.c | 89 ++++++++++++++++++++++++++++--------------------
>  1 file changed, 53 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
> index 4f32cb22f140442b831dc9a4f275e88e4ab2388e..4e26e0e7ac1d5a1c4c67118dbc34f2921fc171a4 100644
> --- a/drivers/iio/adc/ad7380.c
> +++ b/drivers/iio/adc/ad7380.c
> @@ -675,15 +675,21 @@ static const struct regmap_config ad7380_regmap_config = {
>  static int ad7380_debugfs_reg_access(struct iio_dev *indio_dev, u32 reg,
>  				     u32 writeval, u32 *readval)
>  {
> -	iio_device_claim_direct_scoped(return  -EBUSY, indio_dev) {
> -		struct ad7380_state *st = iio_priv(indio_dev);
> +	struct ad7380_state *st = iio_priv(indio_dev);
> +	int ret;
>  
> -		if (readval)
> -			return regmap_read(st->regmap, reg, readval);
> -		else
> -			return regmap_write(st->regmap, reg, writeval);
> -	}
> -	unreachable();
> +	ret = iio_device_claim_direct_mode(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	if (readval)
> +		ret = regmap_read(st->regmap, reg, readval);
> +	else
> +		ret = regmap_write(st->regmap, reg, writeval);
> +
> +	iio_device_release_direct_mode(indio_dev);
> +
> +	return ret;
>  }
>  
>  /*
> @@ -920,6 +926,7 @@ static int ad7380_read_raw(struct iio_dev *indio_dev,
>  {
>  	struct ad7380_state *st = iio_priv(indio_dev);
>  	const struct iio_scan_type *scan_type;
> +	int ret;
>  
>  	scan_type = iio_get_current_scan_type(indio_dev, chan);
>  
> @@ -928,11 +935,16 @@ static int ad7380_read_raw(struct iio_dev *indio_dev,
>  
>  	switch (info) {
>  	case IIO_CHAN_INFO_RAW:
> -		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> -			return ad7380_read_direct(st, chan->scan_index,
> -						  scan_type, val);
> -		}
> -		unreachable();
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			return ret;
> +
> +		ret = ad7380_read_direct(st, chan->scan_index,
> +					 scan_type, val);
> +
> +		iio_device_release_direct_mode(indio_dev);
> +
> +		return ret;
>  	case IIO_CHAN_INFO_SCALE:
>  		/*
>  		 * According to the datasheet, the LSB size is:
> @@ -1024,31 +1036,36 @@ static int ad7380_write_raw(struct iio_dev *indio_dev,
>  		/* always enable resolution boost when oversampling is enabled */
>  		boost = osr > 0 ? 1 : 0;
>  
> -		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> -			ret = regmap_update_bits(st->regmap,
> -					AD7380_REG_ADDR_CONFIG1,
> -					AD7380_CONFIG1_OSR | AD7380_CONFIG1_RES,
> -					FIELD_PREP(AD7380_CONFIG1_OSR, osr) |
> -					FIELD_PREP(AD7380_CONFIG1_RES, boost));
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			return ret;
>  
> -			if (ret)
> -				return ret;
> +		ret = regmap_update_bits(st->regmap,
> +					 AD7380_REG_ADDR_CONFIG1,
> +					 AD7380_CONFIG1_OSR | AD7380_CONFIG1_RES,
> +					 FIELD_PREP(AD7380_CONFIG1_OSR, osr) |
> +					 FIELD_PREP(AD7380_CONFIG1_RES, boost));
>  
> -			st->oversampling_ratio = val;
> -			st->resolution_boost_enabled = boost;
> -
> -			/*
> -			 * Perform a soft reset. This will flush the oversampling
> -			 * block and FIFO but will maintain the content of the
> -			 * configurable registers.
> -			 */
> -			return regmap_update_bits(st->regmap,
> -					AD7380_REG_ADDR_CONFIG2,
> -					AD7380_CONFIG2_RESET,
> -					FIELD_PREP(AD7380_CONFIG2_RESET,
> -						   AD7380_CONFIG2_RESET_SOFT));
> -		}
> -		unreachable();
> +		if (ret)
> +			goto err;
> +
> +		st->oversampling_ratio = val;
> +		st->resolution_boost_enabled = boost;
> +
> +		/*
> +		 * Perform a soft reset. This will flush the oversampling
> +		 * block and FIFO but will maintain the content of the
> +		 * configurable registers.
> +		 */
> +		ret = regmap_update_bits(st->regmap,
> +					 AD7380_REG_ADDR_CONFIG2,
> +					 AD7380_CONFIG2_RESET,
> +					 FIELD_PREP(AD7380_CONFIG2_RESET,
> +						    AD7380_CONFIG2_RESET_SOFT));
> +err:
Labels within switch statements can become hard to maintainer / read.

Id' suggest factoring out the bits between claim and release as a single
__ad7380_write_oversample() or something along those lines.

Otherwise looks good to me and thanks for doing this.

Jonathan


> +		iio_device_release_direct_mode(indio_dev);
> +
> +		return ret;
>  	default:
>  		return -EINVAL;
>  	}
> 


