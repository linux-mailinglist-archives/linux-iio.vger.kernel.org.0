Return-Path: <linux-iio+bounces-17655-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77594A7CD6C
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 11:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A4693AC3A9
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 09:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DAD19D88B;
	Sun,  6 Apr 2025 09:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HR08grgp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196F0F9DA;
	Sun,  6 Apr 2025 09:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743930928; cv=none; b=CP+Jxi+VobFjbQzGRryu1ziTS8cmlECtdPhNU1gVLErIorayqds/J4p+rGZI9YZfgLccKwYV1dIM7BZsAfBSN1Muvf391OVjtZFJefJWI1dOSsF/V6cyFovlUyzd12AVxa8/wJOubVPeB2i2zhchjw2Uc53b3mUkPDN0UPIDaL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743930928; c=relaxed/simple;
	bh=uXYh9OW96c8c9e6evTgQ9IzJYewuAGduPqJ1w/Az+5M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=shxYGo1Ts0sdnIN+GcaUUHq0B+myTZ8OzwaxT1qOEmIDo/hIOe+SUJ3gWYAz1fFLXDMJ0mEYOtDVOeYdv/sCMt2eSUItGoIjaR1fhsIbEnL92w5dlyfuNe2+j8RdwVJ9olXsFDTvALldEHFvnuO82xP8kTblYFklO83h45KEruw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HR08grgp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCDB1C4CEE3;
	Sun,  6 Apr 2025 09:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743930927;
	bh=uXYh9OW96c8c9e6evTgQ9IzJYewuAGduPqJ1w/Az+5M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HR08grgpG1Rqx+HHwQaxQFpBu9kGAggNOJjP3iTMraLclh4TudXWXsrwPHLUzi3XC
	 umOjYVRTGkSci2PG8iYHuqWFWsz51F0kCqHkvKIBkxST6QjRTIfUcu9QO+5kzKn6I8
	 DYYTnkN+ItFL7iHEh9sz6FuUJIMIY3YlV3TilIqQfeuH6cqNI+kxNmC93Hx009p7JG
	 twkPoL0VBiWEQh6F/VndijtwxvdGGHmOcE1ADUR5w9EsEiOm1c4pzukqxesNstnv3R
	 lshoPgxOZoCcT8SJa44kfkBsUlercQD9Gt+mnHTr7n92AK28AueStHU+ED99imwiQi
	 k9CKxXm9/BvdQ==
Date: Sun, 6 Apr 2025 10:15:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Jonathan Corbet <corbet@lwn.net>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] iio: backend: add support for data source get
Message-ID: <20250406101519.40c07cfe@jic23-huawei>
In-Reply-To: <20250331-wip-bl-ad3552r-fixes-v2-3-cdedb430497e@baylibre.com>
References: <20250331-wip-bl-ad3552r-fixes-v2-0-cdedb430497e@baylibre.com>
	<20250331-wip-bl-ad3552r-fixes-v2-3-cdedb430497e@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Mar 2025 21:02:46 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Add backend support for getting the data source used.
> 
> The ad3552r HDL implements an internal ramp generator, so adding the
> getter to allow data source get/set by debugfs.
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>

Looking for a Nuno Ack on this one.


> ---
>  drivers/iio/industrialio-backend.c | 28 ++++++++++++++++++++++++++++
>  include/linux/iio/backend.h        |  5 +++++
>  2 files changed, 33 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
> index a43c8d1bb3d0f4dda4277cac94b0ea9232c071e4..c1eb9ef9db08aec8437d0d00cf77914ad6611b72 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -380,6 +380,34 @@ int iio_backend_data_source_set(struct iio_backend *back, unsigned int chan,
>  }
>  EXPORT_SYMBOL_NS_GPL(iio_backend_data_source_set, "IIO_BACKEND");
>  
> +/**
> + * iio_backend_data_source_get - Get current data source
> + * @back: Backend device
> + * @chan: Channel number
> + * @data: Pointer to receive the current source value
> + *
> + * A given backend may have different sources to stream/sync data. This allows
> + * to know what source is in use.
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int iio_backend_data_source_get(struct iio_backend *back, unsigned int chan,
> +				enum iio_backend_data_source *data)
> +{
> +	int ret;
> +
> +	ret = iio_backend_op_call(back, data_source_get, chan, data);
> +	if (ret)
> +		return ret;
> +
> +	if (*data >= IIO_BACKEND_DATA_SOURCE_MAX)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_data_source_get, "IIO_BACKEND");
> +
>  /**
>   * iio_backend_set_sampling_freq - Set channel sampling rate
>   * @back: Backend device
> diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
> index e45b7dfbec35c094942a3034fc6057a7960b9772..e59d909cb65924b4872cadd4b7e5e894c13c189f 100644
> --- a/include/linux/iio/backend.h
> +++ b/include/linux/iio/backend.h
> @@ -84,6 +84,7 @@ enum iio_backend_interface_type {
>   * @chan_disable: Disable one channel.
>   * @data_format_set: Configure the data format for a specific channel.
>   * @data_source_set: Configure the data source for a specific channel.
> + * @data_source_get: Data source getter for a specific channel.
>   * @set_sample_rate: Configure the sampling rate for a specific channel.
>   * @test_pattern_set: Configure a test pattern.
>   * @chan_status: Get the channel status.
> @@ -115,6 +116,8 @@ struct iio_backend_ops {
>  			       const struct iio_backend_data_fmt *data);
>  	int (*data_source_set)(struct iio_backend *back, unsigned int chan,
>  			       enum iio_backend_data_source data);
> +	int (*data_source_get)(struct iio_backend *back, unsigned int chan,
> +			       enum iio_backend_data_source *data);
>  	int (*set_sample_rate)(struct iio_backend *back, unsigned int chan,
>  			       u64 sample_rate_hz);
>  	int (*test_pattern_set)(struct iio_backend *back,
> @@ -176,6 +179,8 @@ int iio_backend_data_format_set(struct iio_backend *back, unsigned int chan,
>  				const struct iio_backend_data_fmt *data);
>  int iio_backend_data_source_set(struct iio_backend *back, unsigned int chan,
>  				enum iio_backend_data_source data);
> +int iio_backend_data_source_get(struct iio_backend *back, unsigned int chan,
> +				enum iio_backend_data_source *data);
>  int iio_backend_set_sampling_freq(struct iio_backend *back, unsigned int chan,
>  				  u64 sample_rate_hz);
>  int iio_backend_test_pattern_set(struct iio_backend *back,
> 


