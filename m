Return-Path: <linux-iio+bounces-1641-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDEC82CDE7
	for <lists+linux-iio@lfdr.de>; Sat, 13 Jan 2024 18:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBC0D1F2228F
	for <lists+linux-iio@lfdr.de>; Sat, 13 Jan 2024 17:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6015227;
	Sat, 13 Jan 2024 17:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q7fbicXh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915C95223;
	Sat, 13 Jan 2024 17:22:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52831C433F1;
	Sat, 13 Jan 2024 17:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705166542;
	bh=w+xQUE9BpQOiqBSKyEmQx0VOMX/yj6HPQlUxGJJ2xkc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q7fbicXhCZf+ttB9pYafLxfV5n0V8sVgoNJyRfH2m8h07gIwBS1sQsEgKjMxkF3OQ
	 oaLkQaBQHjaO3US510r+NLlZyMpon6IP9L0VhdbcQTm/d9YFfxLJhO/d3LIY60QSHI
	 b/mAdw/xHqTZ3pbDxRRN0/t1wkHO+DNAp4tsYYqSUCnqnm026wTAempBtdqpF0pyYG
	 5nt3PRmxEOZRS0wvdMY6rtCOECkw19dSRmFGreUtpcQisQAm4px+jN4smwq2jVVgH9
	 jNtH3mk5wuEZNXAc4m+i3SJZLEwuBlpFTJ9p+xYcrXCP11KyPj/uoRQExB4gp7H2hb
	 AToh4nSk0jIDw==
Date: Sat, 13 Jan 2024 17:22:08 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Frank Rowand
 <frowand.list@gmail.com>, Olivier Moysan <olivier.moysan@foss.st.com>
Subject: Re: [PATCH v5 6/8] iio: add the IIO backend framework
Message-ID: <20240113172208.6c4cfdbb@jic23-huawei>
In-Reply-To: <20240112-iio-backend-v5-6-bdecad041ab4@analog.com>
References: <20240112-iio-backend-v5-0-bdecad041ab4@analog.com>
	<20240112-iio-backend-v5-6-bdecad041ab4@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jan 2024 17:40:20 +0100
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno Sa <nuno.sa@analog.com>
> 
> This is a Framework to handle complex IIO aggregate devices.
> 
> The typical architecture is to have one device as the frontend device which
> can be "linked" against one or multiple backend devices. All the IIO and
> userspace interface is expected to be registers/managed by the frontend
> device which will callback into the backends when needed (to get/set
> some configuration that it does not directly control).
> 
> The basic framework interface is pretty simple:
>  - Backends should register themselves with @devm_iio_backend_register()
>  - Frontend devices should get backends with @devm_iio_backend_get()
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>

A few minor comments inline.

...

> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
> new file mode 100644
> index 000000000000..994bc68c2679
> --- /dev/null
> +++ b/drivers/iio/industrialio-backend.c
> @@ -0,0 +1,411 @@

...

> +
> +/*
> + * Helper struct for requesting buffers. Allows for multiple buffers per
> + * backend.
Only seems to be used to ensure we have all the data needed to free it...
So comment seems less than obviously connected to that.
> + */
> +struct iio_backend_buffer_pair {
> +	struct iio_backend *back;
> +	struct iio_buffer *buffer;
> +};
> +

> +/**
> + * iio_backend_chan_enable - Enable a backend channel.
> + * @back:	Backend device.
> + * @chan:	Channel number.
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int iio_backend_chan_enable(struct iio_backend *back, unsigned int chan)
> +{
> +	return iio_backend_op_call(back, chan_enable, chan);
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_chan_enable, IIO_BACKEND);
> +
> +/**
> + * iio_backend_chan_disable - Disable a backend channel.
> + * @back:	Backend device.
> + * @chan:	Channel number.
Would be good to be consistent on . or not.
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int iio_backend_chan_disable(struct iio_backend *back, unsigned int chan)
> +{
> +	return iio_backend_op_call(back, chan_disable, chan);
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_chan_disable, IIO_BACKEND);
> +
> +/**
> + * iio_backend_chan_enable - Enable the backend.
> + * @back:	Backend device



...


> +/**
> + * devm_iio_backend_get_from_fwnode_lookup

Not valid kernel doc + name is wrong.  Make sure you run
the kernel-doc script over this and fix any errors or warnings
reported.

> + * @dev:	Device where to bind the backend lifetime.
> + * @fwnode:	Firmware node of the backend device.
> + *
> + * Search the backend list for a device matching @fwnode.
> + * This API should not be used and it's only present for preventing the first
> + * user of this framework to break it's DT ABI.
> + *
> + * RETURNS:
> + * A backend pointer, negative error pointer otherwise.
> + */
> +struct iio_backend *
> +__devm_iio_backend_get_from_fwnode_lookup(struct device *dev,
> +					  struct fwnode_handle *fwnode)
> +{
> +	struct iio_backend *back;
> +	int ret;
> +
> +	guard(mutex)(&iio_back_lock);
> +	list_for_each_entry(back, &iio_back_list, entry) {
> +		if (!device_match_fwnode(back->dev, fwnode))
> +			continue;
> +
> +		ret = __devm_iio_backend_get(dev, back);
> +		if (ret)
> +			return ERR_PTR(ret);
> +
> +		return back;
> +	}
> +
> +	return ERR_PTR(-EPROBE_DEFER);
> +}
> +EXPORT_SYMBOL_NS_GPL(__devm_iio_backend_get_from_fwnode_lookup, IIO_BACKEND);
>


> +/**
> + * devm_iio_backend_register - Register a new backend device
> + * @dev:	Backend device being registered.
> + * @ops:	Backend ops
> + * @priv:	Device private data.
> + *
> + * @ops and @priv are both mandatory. Not providing them results in -EINVAL.

It's unusual to 'insist' on the private data.
Whilst it's highly likely it will always be there from a core point of view
we don't mind it being NULL.  This is different from the ops as we want
to be able to call those without checking they are there.

> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int devm_iio_backend_register(struct device *dev,
> +			      const struct iio_backend_ops *ops, void *priv)
> +{
> +	struct iio_backend *back;
> +
> +	if (!ops || !priv) {

> +		pr_err("%s: No backend ops or private data given\n",
> +		       dev_name(dev));
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Through device_links, we guarantee that a frontend device cannot be
> +	 * bound/exist if the backend driver is not around. Hence, we can bind
> +	 * the backend object lifetime with the device being passed since
> +	 * removing it will torn the frontend down.

"will have torn" or "will tear the"

> +	 */
> +	back = devm_kzalloc(dev, sizeof(*back), GFP_KERNEL);
> +	if (!back)
> +		return -ENOMEM;
> +
> +	back->ops = ops;
> +	back->owner = dev->driver->owner;
> +	back->dev = dev;
> +	back->priv = priv;
> +	mutex_lock(&iio_back_lock);
> +	list_add(&back->entry, &iio_back_list);
> +	mutex_unlock(&iio_back_lock);
> +
> +	return devm_add_action_or_reset(dev, iio_backend_unregister, back);
> +}
> +EXPORT_SYMBOL_NS_GPL(devm_iio_backend_register, IIO_BACKEND);
> +
> +MODULE_AUTHOR("Nuno Sa <nuno.sa@analog.com>");
> +MODULE_DESCRIPTION("Framework to handle complex IIO aggregate devices");
> +MODULE_LICENSE("GPL");



