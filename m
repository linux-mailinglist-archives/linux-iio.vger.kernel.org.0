Return-Path: <linux-iio+bounces-15969-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A274DA40A44
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 17:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F322E188141F
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 16:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E201FF1BF;
	Sat, 22 Feb 2025 16:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+LNQ+Rt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0807378F30;
	Sat, 22 Feb 2025 16:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740242887; cv=none; b=d/xCCg7/kW83QGf+vdTNdRlKC1G3fjYSb1dSU070aafSZV/G5pzPxGfsMtFTiltPWVy23S5FnmblJib8qcnWvPDV/E+Pl21Ppljyr+aKHpgcg4rDGb3rLq99nYaE3b93psasfiFj42Sag40KwK1VnkBJznfXO6zE3DCisBlVs5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740242887; c=relaxed/simple;
	bh=MNqeln3VUkNUMvXFamT92OsGm8gYf6TpxgYBqet6w3I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UKSuaOqFyTaR1llZCksUAAxv5+R/9bG1eQyV9qnfESF0CEXOlWtJVuSpA9X7KkxOLeNkhaRRJIzFn29LV3EMnA+4azKyLDYGT+kqgBT/RZPoTrALkhYxs2vv80ZCiSS1EJVFWi5Hm2X48tINAbtWwHut7V0b+lQybYjzCexy0xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+LNQ+Rt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE30C4CED1;
	Sat, 22 Feb 2025 16:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740242886;
	bh=MNqeln3VUkNUMvXFamT92OsGm8gYf6TpxgYBqet6w3I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g+LNQ+Rt6GNGW/rZCLD4s7ivITJorUX2uUsQcWHYOVgHODkVvz8WRgpnSczHu2A6H
	 X7cUx7U2gzvOI4jlqiC8lCOUGBm2/ILcjBZQGTNw8XfqypYCoxGZgj/jOPl97+uNf3
	 hydT8nMNbtqLx0y63rjJH7AA1lo6zloGej59zU3pMHTTdnfD9UBAa45fphLPnRYv8C
	 s+8CKb6rqrkAAmxvjFliZq6Ecm8LoZ7Ie7guQR8hRzkdk5yAcTPtcLNiP5gX7YDgnW
	 Ia5tQ9gVcR7z9T0VlAxKcsx+abUCbb5FenevUiqQ2rcBZcWT9AJemvmGhjHX0Sun/F
	 agze0wqy+kzXA==
Date: Sat, 22 Feb 2025 16:47:59 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/14] iio: backend: add support for filter config
Message-ID: <20250222164759.5e98cefd@jic23-huawei>
In-Reply-To: <20250220135429.8615-2-antoniu.miclaus@analog.com>
References: <20250220135429.8615-1-antoniu.miclaus@analog.com>
	<20250220135429.8615-2-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Feb 2025 15:54:11 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add backend support for filter enable/disable.
> This setting can be adjusted within the IP cores interfacing devices.

Hi Antoniu,

Please add some details on what this filtering actually is.
There are lots of possibilities. I'm not sure why you'd have
just an enable on the backend rather than a richer set of controls?

Thanks,

Jonathan


> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  drivers/iio/industrialio-backend.c | 26 ++++++++++++++++++++++++++
>  include/linux/iio/backend.h        |  6 ++++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
> index d4ad36f54090..ffafe7c73508 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -778,6 +778,32 @@ static int __devm_iio_backend_get(struct device *dev, struct iio_backend *back)
>  	return 0;
>  }
>  
> +/**
> + * iio_backend_filter_enable - Enable filter
> + * @back: Backend device
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int iio_backend_filter_enable(struct iio_backend *back)
> +{
> +	return iio_backend_op_call(back, filter_enable);
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_filter_enable, "IIO_BACKEND");
> +
> +/**
> + * iio_backend_filter_disable - Disable filter
> + * @back: Backend device
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int iio_backend_filter_disable(struct iio_backend *back)
> +{
> +	return iio_backend_op_call(back, filter_disable);
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_filter_disable, "IIO_BACKEND");
> +
>  /**
>   * iio_backend_ddr_enable - Enable interface DDR (Double Data Rate) mode
>   * @back: Backend device
> diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
> index e45b7dfbec35..7987d9f1cdb3 100644
> --- a/include/linux/iio/backend.h
> +++ b/include/linux/iio/backend.h
> @@ -100,6 +100,8 @@ enum iio_backend_interface_type {
>   * @read_raw: Read a channel attribute from a backend device
>   * @debugfs_print_chan_status: Print channel status into a buffer.
>   * @debugfs_reg_access: Read or write register value of backend.
> + * @filter_enable: Enable filter.
> + * @filter_disable: Disable filter.
>   * @ddr_enable: Enable interface DDR (Double Data Rate) mode.
>   * @ddr_disable: Disable interface DDR (Double Data Rate) mode.
>   * @data_stream_enable: Enable data stream.
> @@ -150,6 +152,8 @@ struct iio_backend_ops {
>  					 size_t len);
>  	int (*debugfs_reg_access)(struct iio_backend *back, unsigned int reg,
>  				  unsigned int writeval, unsigned int *readval);
> +	int (*filter_enable)(struct iio_backend *back);
> +	int (*filter_disable)(struct iio_backend *back);
>  	int (*ddr_enable)(struct iio_backend *back);
>  	int (*ddr_disable)(struct iio_backend *back);
>  	int (*data_stream_enable)(struct iio_backend *back);
> @@ -190,6 +194,8 @@ int iio_backend_data_sample_trigger(struct iio_backend *back,
>  int devm_iio_backend_request_buffer(struct device *dev,
>  				    struct iio_backend *back,
>  				    struct iio_dev *indio_dev);
> +int iio_backend_filter_enable(struct iio_backend *back);
> +int iio_backend_filter_disable(struct iio_backend *back);
>  int iio_backend_ddr_enable(struct iio_backend *back);
>  int iio_backend_ddr_disable(struct iio_backend *back);
>  int iio_backend_data_stream_enable(struct iio_backend *back);


