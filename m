Return-Path: <linux-iio+bounces-680-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59693807704
	for <lists+linux-iio@lfdr.de>; Wed,  6 Dec 2023 18:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 406D3281D73
	for <lists+linux-iio@lfdr.de>; Wed,  6 Dec 2023 17:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248FC6DCF0;
	Wed,  6 Dec 2023 17:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tiji+3Z5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FEC364B2;
	Wed,  6 Dec 2023 17:52:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 149A4C433C8;
	Wed,  6 Dec 2023 17:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701885174;
	bh=eQj8MdTVfam+v/WP6NntKwGS4bt+2MoHIiUP3tMRNi0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Tiji+3Z51wqG8estcOqphd6/JBkbTZPJWQxOJEzazaWuSVe13G1RbSCkb7JSG11w4
	 Es8CDs8cMM68uEOm20rl6EfvDqVWXRMZkLiUX48/iZYRS3qljnuOGkEoVwdn3URKkp
	 sg5jNCcBuLSdIVP1HPVopouI1qitGMxh2x37eod52MFKRx3P5GogvqPZlkc3naUGiQ
	 EFR3WzxGwyh8yjWEmCV0lH6qC3QoXxgItfyuvDcEnB5GYxYft9e2cDZiVmSBiQ/+GA
	 cYd+WLRV1s3PIFQcW2BDtMtSjc06MgufJG+9NqmZ1iD82dJo6GeNmW1aPVMIH4EZnn
	 vZJIVUtm5ZIbg==
Date: Wed, 6 Dec 2023 17:52:45 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Li peiyu <579lpy@gmail.com>
Cc: javier.carrasco.cruz@gmail.com, lars@metafoo.de, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] iio: core: introduce trough modifier for minimum
  values
Message-ID: <20231206175245.73b91fe0@jic23-huawei>
In-Reply-To: <20231206134819.559496-1-579lpy@gmail.com>
References: <20231206134655.559474-1-579lpy@gmail.com>
	<20231206134819.559496-1-579lpy@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  6 Dec 2023 21:48:19 +0800
Li peiyu <579lpy@gmail.com> wrote:

> From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> 
> The IIO_CHAN_INFO_PEAK modifier is used for maximum values and currently
> there is no equivalent for minimum values. Instead of overloading the
> existing peak modifier, a new modifier can be added.
> 
> In principle there is no need to add a _TROUGH_SCALE modifier as the
> scale will be the same as the one required for the INFO_PEAK modifier,
> which in turn is sometimes omitted if a single scale for peaks and raw
> values is required.
> 

Terminology is a bit mixed up in here. Modifiers in IIO are things
like the axis or a color for light sensors.  This is an 
info element that applies to a channel (modified or not).

Other than that looks good to me.

> Add an IIO_CHAN_INFO_TROUGH modifier for minimum values.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  drivers/iio/industrialio-core.c | 1 +
>  include/linux/iio/types.h       | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index c77745b594bd..351c64c2f4da 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -182,6 +182,7 @@ static const char * const iio_chan_info_postfix[] = {
>  	[IIO_CHAN_INFO_THERMOCOUPLE_TYPE] = "thermocouple_type",
>  	[IIO_CHAN_INFO_CALIBAMBIENT] = "calibambient",
>  	[IIO_CHAN_INFO_ZEROPOINT] = "zeropoint",
> +	[IIO_CHAN_INFO_TROUGH] = "trough_raw",
>  };
>  /**
>   * iio_device_id() - query the unique ID for the device
> diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
> index 117bde7d6ad7..d89982c98368 100644
> --- a/include/linux/iio/types.h
> +++ b/include/linux/iio/types.h
> @@ -68,6 +68,7 @@ enum iio_chan_info_enum {
>  	IIO_CHAN_INFO_THERMOCOUPLE_TYPE,
>  	IIO_CHAN_INFO_CALIBAMBIENT,
>  	IIO_CHAN_INFO_ZEROPOINT,
> +	IIO_CHAN_INFO_TROUGH,
>  };
>  
>  #endif /* _IIO_TYPES_H_ */


