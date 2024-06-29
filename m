Return-Path: <linux-iio+bounces-7057-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F15A91CE9E
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jun 2024 20:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BE811F21C5C
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jun 2024 18:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0E5132118;
	Sat, 29 Jun 2024 18:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nIkJfIxm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D4B4B5A6;
	Sat, 29 Jun 2024 18:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719687258; cv=none; b=ZhCU/7sgJxOSYR9JjtnAyFZtdKxt/X5cegG9EViZ/vI7Zk/q0m1ZecevQHcxXPS/r0IlP+XNAYlLG9XNa00+vMo9j3aBQ7EJevw7tSIsaEzkFRMxhG2+igotXxIvSD2cWERUpvW9Elm7tFPuyJtgNCprH+zNqeUBMVIwDs+vajg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719687258; c=relaxed/simple;
	bh=h3pcQDAvvq6HFxa7uRxPPUPp9rBdRJXWaZhpH2XU/S4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ukLu91h9NAe/N5N4dS+mIUzQ7GqdSR8m+sfvF9YwFTbCBCMtGPSQwqTDFkjz5edgX+yocndVhKy+Rwd4h6t8RTKD7bUBKyIPb/nlUZN7l6b8bIbL0lTFoMi/qxdvonpviaaV0ui5szBQrW2zxk4ob0Jn5+fdLUrIdkwQAF3LKJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nIkJfIxm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E60E5C2BBFC;
	Sat, 29 Jun 2024 18:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719687258;
	bh=h3pcQDAvvq6HFxa7uRxPPUPp9rBdRJXWaZhpH2XU/S4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nIkJfIxmOWNpv1CnluAL4r8Y2paaFuymucgaKYLWhCMkwng1cQrNOorvRQJS8YYc4
	 OF6uy/qrHPgN4CsiMCNTY9PDNtuJUpEVd8ROOCiSC0RkvVb4s1vbgRnLBbL4/7uwx1
	 2ygegtT+PvgCvFTybRifH8bKQ7St2Qsr1aeia5Zeg3Qmo8RXdgQBZzgVUO7seHf7Sl
	 aonOLXeUbx4/D8cq2QKVKESSmvULh8Qm2FvKizIm2B+gn4JhxXKqNfId+jgwlCRC5J
	 r3lNeTrol74cfOH6byQ9gHF9bUjy8mdOFEGd98MiiOdT4yOGdZhEyl/+CslcEv6c1X
	 Y3TVXxdjXl+9Q==
Date: Sat, 29 Jun 2024 19:54:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Olivier Moysan <olivier.moysan@foss.st.com>
Cc: <fabrice.gasnier@foss.st.com>, Nuno Sa <nuno.sa@analog.com>, Lars-Peter
 Clausen <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/8] iio: add child nodes support in iio backend
 framework
Message-ID: <20240629195411.63a72497@jic23-huawei>
In-Reply-To: <20240625150717.1038212-4-olivier.moysan@foss.st.com>
References: <20240625150717.1038212-1-olivier.moysan@foss.st.com>
	<20240625150717.1038212-4-olivier.moysan@foss.st.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jun 2024 17:07:11 +0200
Olivier Moysan <olivier.moysan@foss.st.com> wrote:

> Add an API to support IIO generic channels binding:
> http://devicetree.org/schemas/iio/adc/adc.yaml#
> This new API is needed, as generic channel DT node isn't populated as a
> device.
> Add devm_iio_backend_fwnode_get() to allow an IIO device backend
> consumer to reference backend phandles in its child nodes.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>

A passing comment inline. I'm not asking for any changes in this
series (unless you want to make it more complex ;)

> ---
>  drivers/iio/industrialio-backend.c | 62 +++++++++++++++++++++---------
>  include/linux/iio/backend.h        |  2 +
>  2 files changed, 45 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
> index 6be1fa9a960b..8cc959ac278a 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -577,19 +577,10 @@ static int __devm_iio_backend_get(struct device *dev, struct iio_backend *back)
>  	return 0;
>  }
>  
> -/**
> - * devm_iio_backend_get - Device managed backend device get
> - * @dev: Consumer device for the backend
> - * @name: Backend name
> - *
> - * Get's the backend associated with @dev.
> - *
> - * RETURNS:
> - * A backend pointer, negative error pointer otherwise.
> - */
> -struct iio_backend *devm_iio_backend_get(struct device *dev, const char *name)
> +static struct iio_backend *__devm_iio_backend_fwnode_get(struct device *dev, const char *name,
> +							 struct fwnode_handle *fwnode)
>  {
> -	struct fwnode_handle *fwnode;
> +	struct fwnode_handle *fwnode_back;
>  	struct iio_backend *back;
>  	unsigned int index;
>  	int ret;
> @@ -604,19 +595,19 @@ struct iio_backend *devm_iio_backend_get(struct device *dev, const char *name)
>  		index = 0;
>  	}
>  
> -	fwnode = fwnode_find_reference(dev_fwnode(dev), "io-backends", index);
> -	if (IS_ERR(fwnode)) {
> -		dev_err_probe(dev, PTR_ERR(fwnode),
> +	fwnode_back = fwnode_find_reference(fwnode, "io-backends", index);

Not really related, but this looks 'ripe' for some cleanup.h magic.

> +	if (IS_ERR(fwnode_back)) {
> +		dev_err_probe(dev, PTR_ERR(fwnode_back),
>  			      "Cannot get Firmware reference\n");
> -		return ERR_CAST(fwnode);
> +		return ERR_CAST(fwnode_back);
>  	}
>  
>  	guard(mutex)(&iio_back_lock);
>  	list_for_each_entry(back, &iio_back_list, entry) {
> -		if (!device_match_fwnode(back->dev, fwnode))
> +		if (!device_match_fwnode(back->dev, fwnode_back))
>  			continue;
>  
> -		fwnode_handle_put(fwnode);
> +		fwnode_handle_put(fwnode_back);
>  		ret = __devm_iio_backend_get(dev, back);
>  		if (ret)
>  			return ERR_PTR(ret);
> @@ -624,11 +615,44 @@ struct iio_backend *devm_iio_backend_get(struct device *dev, const char *name)
>  		return back;
>  	}
>  
> -	fwnode_handle_put(fwnode);
> +	fwnode_handle_put(fwnode_back);
>  	return ERR_PTR(-EPROBE_DEFER);
>  }

