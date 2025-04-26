Return-Path: <linux-iio+bounces-18688-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56656A9DAFC
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 15:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2FF41BA72D4
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 13:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2413D1494CF;
	Sat, 26 Apr 2025 13:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1FRYKoK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8EF13777E;
	Sat, 26 Apr 2025 13:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745673302; cv=none; b=qF7Hwg/uh1SMfJiX/uth3GJuzsjcDeqP8MtQ109SAv8YD3kLr7W8Iis1J+iM0ijd4ti/S/UecXyE9N2HSZ9ToAvdKZsAXmKRqehT+i1qveOJUbsMpwXs1zMxHbggvrPeeyKzj9zJtu4pPHjIIGeFYYlEvvFzag1uSTxXJNcCd9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745673302; c=relaxed/simple;
	bh=AFi3KdsvjqYyfX8dyI4Wdz5V6ie382V5cdvIOs3lmFg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QsDCeU2jtZ5LtITqPSvQ8/DSFlUM3smGbflEGCbB5M285UJWWxTtVyB8q/6l/waQxVmTTRHAzvDgIj04j3SWZaYRkqRZzSrcZp5r7ZDDPuj+p+g+sekSu8g4peEQdP1NnyxyRzdYbla6bE8NfbGMjW2Sm3bwbt5sPAQlp2TlS+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1FRYKoK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F7C9C4CEE2;
	Sat, 26 Apr 2025 13:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745673302;
	bh=AFi3KdsvjqYyfX8dyI4Wdz5V6ie382V5cdvIOs3lmFg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k1FRYKoK0R6a8PVWK5/nJj6fiIoiBoqU71CbVYibHEoVPGXUHk5PE/65cWjYPs7+N
	 KlksrkNIm/mm+hvV3Ygp+UsI4rwk2EAA32rV1dE3mDPybIIUxvBb+GD3/oVwLgj47m
	 Gqgfd2V/jA2QWkv4ydPUsFqMjGsbQukVryak1qLtMYEnbPhENw+/WRqikuPBVOaY/Y
	 tMAv8LeRDF4Pqda0LiFFkneo6omJxNs1Y2/JOyj5FSdligksQaGCZtwWxIF798kRQ8
	 XIkMQu+kvS+zq16mNZl3v9GtUfSMkwOl4puPZeULSSAVV7qBiKHkuKAQwNCivHqG39
	 hiSz/SRLFFfag==
Date: Sat, 26 Apr 2025 14:14:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Nuno Sa 
 <nuno.sa@analog.com>
Subject: Re: [PATCH v3 01/11] iio: backend: add support for filter config
Message-ID: <20250426141455.05487816@jic23-huawei>
In-Reply-To: <20250425112538.59792-2-antoniu.miclaus@analog.com>
References: <20250425112538.59792-1-antoniu.miclaus@analog.com>
	<20250425112538.59792-2-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Apr 2025 14:25:28 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add backend support for digital filter type selection.
> 
> This setting can be adjusted within the IP cores interfacing devices.
> 
> The IP core can be configured based on the state of the actual
> digital filter configuration of the part.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
All these backend things look fine to me. However, as for all backend
stuff I'm not the expert so will be looking for other reviews on these.

+CC Nuno

> ---
> changes in v3:
>  - update function to set the actual filter type instead of just enable/disable.
>  drivers/iio/industrialio-backend.c | 15 +++++++++++++++
>  include/linux/iio/backend.h        | 13 +++++++++++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
> index d4ad36f54090..2d28eabb1607 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -778,6 +778,21 @@ static int __devm_iio_backend_get(struct device *dev, struct iio_backend *back)
>  	return 0;
>  }
>  
> +/**
> + * iio_backend_filter_type_set - Set filter type
> + * @back: Backend device
> + * @type: Filter type.
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int iio_backend_filter_type_set(struct iio_backend *back,
> +				enum iio_backend_filter_type type)
> +{
> +	return iio_backend_op_call(back, filter_type_set, type);
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_filter_type_set, "IIO_BACKEND");
> +
>  /**
>   * iio_backend_ddr_enable - Enable interface DDR (Double Data Rate) mode
>   * @back: Backend device
> diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
> index e45b7dfbec35..5526800f5d4a 100644
> --- a/include/linux/iio/backend.h
> +++ b/include/linux/iio/backend.h
> @@ -76,6 +76,14 @@ enum iio_backend_interface_type {
>  	IIO_BACKEND_INTERFACE_MAX
>  };
>  
> +enum iio_backend_filter_type {
> +	IIO_BACKEND_FILTER_TYPE_DISABLED,
> +	IIO_BACKEND_FILTER_TYPE_SINC1,
> +	IIO_BACKEND_FILTER_TYPE_SINC5,
> +	IIO_BACKEND_FILTER_TYPE_SINC5_PLUS_COMP,
> +	IIO_BACKEND_FILTER_TYPE_MAX
> +};
> +
>  /**
>   * struct iio_backend_ops - operations structure for an iio_backend
>   * @enable: Enable backend.
> @@ -100,6 +108,7 @@ enum iio_backend_interface_type {
>   * @read_raw: Read a channel attribute from a backend device
>   * @debugfs_print_chan_status: Print channel status into a buffer.
>   * @debugfs_reg_access: Read or write register value of backend.
> + * @filter_type_set: Set filter type.
>   * @ddr_enable: Enable interface DDR (Double Data Rate) mode.
>   * @ddr_disable: Disable interface DDR (Double Data Rate) mode.
>   * @data_stream_enable: Enable data stream.
> @@ -150,6 +159,8 @@ struct iio_backend_ops {
>  					 size_t len);
>  	int (*debugfs_reg_access)(struct iio_backend *back, unsigned int reg,
>  				  unsigned int writeval, unsigned int *readval);
> +	int (*filter_type_set)(struct iio_backend *back,
> +			       enum iio_backend_filter_type type);
>  	int (*ddr_enable)(struct iio_backend *back);
>  	int (*ddr_disable)(struct iio_backend *back);
>  	int (*data_stream_enable)(struct iio_backend *back);
> @@ -190,6 +201,8 @@ int iio_backend_data_sample_trigger(struct iio_backend *back,
>  int devm_iio_backend_request_buffer(struct device *dev,
>  				    struct iio_backend *back,
>  				    struct iio_dev *indio_dev);
> +int iio_backend_filter_type_set(struct iio_backend *back,
> +				enum iio_backend_filter_type type);
>  int iio_backend_ddr_enable(struct iio_backend *back);
>  int iio_backend_ddr_disable(struct iio_backend *back);
>  int iio_backend_data_stream_enable(struct iio_backend *back);


