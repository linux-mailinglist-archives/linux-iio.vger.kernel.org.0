Return-Path: <linux-iio+bounces-8908-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF3096713B
	for <lists+linux-iio@lfdr.de>; Sat, 31 Aug 2024 13:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA2031F229B3
	for <lists+linux-iio@lfdr.de>; Sat, 31 Aug 2024 11:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5054017CA04;
	Sat, 31 Aug 2024 11:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="We9eHYXq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02034175D3F;
	Sat, 31 Aug 2024 11:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725103402; cv=none; b=EE9jSrAYSAge9BXJksKkXDsxD2WlOJUKWSBE9srhy0UHjKabTdqSe58fkCbW82T/HYnLxsjBblEszGk1U7Ysky0uAaI73/NoNAWVVYYnEFIT4C5VRZKM0RxrksjEiVC//IaQS5F0anV1J76aQGvfY4BPNOU9SzOiNAmd4yZIi+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725103402; c=relaxed/simple;
	bh=c+VcWDZLGhgR9mvpYh5YRRBY5NsxRHNbM2e3zC1iiow=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gz2/F0e43lKJx/JUr8rPnHWfjDqTejKiNN/DeWnmU1gFwds+Q++oNLHRdEz5e42I+nLiUnqqrHXY1ybdV3APloDoFz3B3QdWzcK6v3kfVXRg4rUEKmMOCFrkKjE8MdBEG/vI5mnCxJ/v4FEPbZpYSuaWGDW5yLwEm8wjgcrqIps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=We9eHYXq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1846EC4CEC0;
	Sat, 31 Aug 2024 11:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725103401;
	bh=c+VcWDZLGhgR9mvpYh5YRRBY5NsxRHNbM2e3zC1iiow=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=We9eHYXqnb83KBmrsEeIc7i6cz1eNws8zKJNKN8f1Z3pcN5Ow4Zek/Z/FPObkAltz
	 Ne6fCl1V8UvLZz+0Ws+d0XwIlrNHW0z25/Stdptki6jMCRaAWZKf4Bj1/6a67QGIbp
	 wVTVBdjtSXXIvQWf4izPRQmmcNdXmd4KbWOm5ztnpudEOPNDBRX2dd+AsAFBfFNlZY
	 TUVhuPFuk8UrlIPMOYbeJmNw+j1PnDc8P0GVQT33cDFszsQ89blZ+60+ZDhYnRb9ab
	 DYc5tMRYu8AhhZ9htCtkFCOSnM61oFJLeB/lJAriDUoT6CKMaHsjhLtZHKxk7sbPRg
	 gTwLis+d2QJUA==
Date: Sat, 31 Aug 2024 12:23:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dlechner@baylibre.com
Subject: Re: [PATCH RFC 2/8] iio: backend: extend features
Message-ID: <20240831122313.4d993260@jic23-huawei>
In-Reply-To: <20240829-wip-bl-ad3552r-axi-v0-v1-2-b6da6015327a@baylibre.com>
References: <20240829-wip-bl-ad3552r-axi-v0-v1-0-b6da6015327a@baylibre.com>
	<20240829-wip-bl-ad3552r-axi-v0-v1-2-b6da6015327a@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Aug 2024 14:32:00 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Extend backend features with new calls needed later on this
> patchset from axi version of ad3552r.
> 
> A bus type property has been added to the devicetree to
> inform the backend about the type of bus (interface) in use
> bu the IP.
> 
> The follwoing calls are added:
> 
> iio_backend_ext_sync_enable
> 	enable synchronize channels on external trigger
> iio_backend_ext_sync_disable
> 	disable synchronize channels on external trigger
> iio_backend_ddr_enable
> 	enable ddr bus transfer
> iio_backend_ddr_disable
> 	disable ddr bus transfer
> iio_backend_set_bus_mode
> 	select the type of bus, so that specific read / write
> 	operations are performed accordingly
> iio_backend_buffer_enable
> 	enable buffer
> iio_backend_buffer_disable
> 	disable buffer
> iio_backend_data_transfer_addr
> 	define the target register address where the DAC sample
> 	will be written.
> iio_backend_bus_reg_read
> 	generic bus read, bus-type dependent
> iio_backend_bus_read_write
> 	generic bus write, bus-type dependent
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
>  drivers/iio/industrialio-backend.c | 151 +++++++++++++++++++++++++++++++++++++
>  include/linux/iio/backend.h        |  24 ++++++
>  2 files changed, 175 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
> index a52a6b61c8b5..1f60c8626be7 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -718,6 +718,157 @@ static int __devm_iio_backend_get(struct device *dev, struct iio_backend *back)
>  	return 0;
>  }


> +
> +/**
> + * iio_backend_buffer_enable - Enable data buffering

Data buffering is a very vague term.  Perhaps some more detail on what
this means?

> + * @back: Backend device
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int iio_backend_buffer_enable(struct iio_backend *back)
> +{
> +	return iio_backend_op_call(back, buffer_enable);
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_buffer_enable, IIO_BACKEND);
> +
> +/**
> + * iio_backend_set_buffer_disable - Disable data buffering
> + * @back: Backend device
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int iio_backend_buffer_disable(struct iio_backend *back)
> +{
> +	return iio_backend_op_call(back, buffer_disable);
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_buffer_disable, IIO_BACKEND);
> +
> +/**
> + * iio_backend_buffer_transfer_addr - Set data address.
> + * @back: Backend device
> + * @chan_address: Channel register address
Run scripts/kernel-doc on this and fix the errors (parameter name is 
wrong).  W=1 builds might also point the simpler ones out.
> + *
> + * Some devices may need to inform the backend about an address/location
> + * where to read or write the data.
I'd drop the 'location' part unless this gets used later because you
are referring register address above.
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int iio_backend_data_transfer_addr(struct iio_backend *back, u32 address)
> +{
> +	return iio_backend_op_call(back, data_transfer_addr, address);
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_data_transfer_addr, IIO_BACKEND);
> +
> +/**
> + * iio_backend_bus_reg_read - Read from the interface bus
> + * @back: Backend device
> + * @reg: Register valule
> + * @val: Pointer to register value
> + * @size: Size, in bytes
> + *
> + * A backend may operate on a specific interface with a related bus.
> + * Read from the interface bus.

So this is effectively routing control plane data through the offloaded
bus?  That sounds a lot more like a conventional bus than IIO backend.
Perhaps it should be presented as that with the IIO device attached
to that bus? I don't fully understand what is wired up here.

> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int iio_backend_bus_reg_read(struct iio_backend *back,
> +			     u32 reg, void *val, size_t size)
> +{
> +	if (!size)
> +		return -EINVAL;
> +
> +	return iio_backend_op_call(back, bus_reg_read, reg, val, size);
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_bus_reg_read, IIO_BACKEND);
> +


