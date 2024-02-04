Return-Path: <linux-iio+bounces-2155-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A552848F06
	for <lists+linux-iio@lfdr.de>; Sun,  4 Feb 2024 16:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B289B22416
	for <lists+linux-iio@lfdr.de>; Sun,  4 Feb 2024 15:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A41422301;
	Sun,  4 Feb 2024 15:53:28 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C429241E0
	for <linux-iio@vger.kernel.org>; Sun,  4 Feb 2024 15:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707062008; cv=none; b=CQm1v0zDwoeIuzfODS4xCqsPAf9ev2URE0SwMowJ5+Sp5F3PPPzIVgF9EswTAfVfJOVDu8yK5lQHXZ7PESs3Kg3F5NZy3nVNifLA8DVhDhk20lpgHA9plMbCRwC0i0IwOlMm6L8OuWXyNS0Am9xG1AUUJ4k27xyCDQoakn0/OB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707062008; c=relaxed/simple;
	bh=wmK4ySri2WrQrOwSyCzeMO/QXjrOEztuK3gEmrdLlWo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GK8b/42OwsljtKD7Eu2lOwQ65cv0XOkhbFdfn8znhEZnZHx2SmLyavSY2sn/zNrE4nWgzb0og0sNpy+fN2jFj7tO8+UUjHwcauT1x1vmy7XGYp7t701M9GpGVMMygG4fkdNKX7VdMU18typhAROmxJMEM384hae/aVIz8JDERew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-30.elisa-laajakaista.fi [88.113.26.30])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id 5e66bdbe-c375-11ee-abf4-005056bdd08f;
	Sun, 04 Feb 2024 17:52:16 +0200 (EET)
From: andy.shevchenko@gmail.com
Date: Sun, 4 Feb 2024 17:52:15 +0200
To: Nuno Sa <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>
Subject: Re: [PATCH v8 5/7] iio: add the IIO backend framework
Message-ID: <Zb-yr0u_a9-vE86t@surfacebook.localdomain>
References: <20240202-iio-backend-v8-0-f65ee8c8203d@analog.com>
 <20240202-iio-backend-v8-5-f65ee8c8203d@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202-iio-backend-v8-5-f65ee8c8203d@analog.com>

Fri, Feb 02, 2024 at 04:08:36PM +0100, Nuno Sa kirjoitti:
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

...

> + * Copyright (C) 2023 Analog Devices Inc.

2024 as well?

...

> +#include <linux/cleanup.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/property.h>
> +#include <linux/slab.h>

Missing types.h and maybe more. (E.g., IIRC linux/err.h doesn't cover
linux/errno.h for Linux internal error codes, >= 512.)

...

> +int devm_iio_backend_request_buffer(struct device *dev,
> +				    struct iio_backend *back,
> +				    struct iio_dev *indio_dev)
> +{
> +	struct iio_backend_buffer_pair *pair;
> +	struct iio_buffer *buffer;
> +
> +	buffer = iio_backend_ptr_op_call(back, request_buffer, indio_dev);
> +	if (IS_ERR(buffer))
> +		return PTR_ERR(buffer);
> +
> +	pair = devm_kzalloc(dev, sizeof(*pair), GFP_KERNEL);
> +	if (!pair)
> +		return -ENOMEM;

Shouldn't we try memory allocation first? Otherwise seems to me like freeing
buffer is missed here.

> +	/* weak reference should be all what we need */
> +	pair->back = back;
> +	pair->buffer = buffer;
> +
> +	return devm_add_action_or_reset(dev, iio_backend_free_buffer, pair);
> +}

...

> +static int __devm_iio_backend_get(struct device *dev, struct iio_backend *back)
> +{
> +	struct device_link *link;
> +	int ret;
> +
> +	/*
> +	 * Make sure the provider cannot be unloaded before the consumer module.
> +	 * Note that device_links would still guarantee that nothing is
> +	 * accessible (and breaks) but this makes it explicit that the consumer
> +	 * module must be also unloaded.
> +	 */
> +	if (!try_module_get(back->owner)) {
> +		pr_err("%s: Cannot get module reference\n", dev_name(dev));

NIH dev_err(). If you want the prefix, define dev_fmt() (or how is it called?)
as well.

> +		return -ENODEV;
> +	}
> +
> +	ret = devm_add_action_or_reset(dev, iio_backend_release, back);
> +	if (ret)
> +		return ret;
> +
> +	link = device_link_add(dev, back->dev, DL_FLAG_AUTOREMOVE_CONSUMER);
> +	if (!link) {
> +		pr_err("%s: Could not link to supplier(%s)\n", dev_name(dev),
> +		       dev_name(back->dev));

Ditto.

> +		return -EINVAL;
> +	}
> +
> +	pr_debug("%s: Found backend(%s) device\n", dev_name(dev),
> +		 dev_name(back->dev));

Ditto (dev_dbg() here).

> +	return 0;
> +}

...

> +struct iio_backend *devm_iio_backend_get(struct device *dev, const char *name)

Same comments regarding pr_*() vs. dev_*().

> +	struct fwnode_handle *fwnode;
> +	struct iio_backend *back;

> +	int index = 0, ret;

Wouldn't be better to have it done differently and actually using int is not
okay strictly speaking? It's unsigned in your case.

	unsigned int index;
	int ret;


> +	if (name) {
> +		index = device_property_match_string(dev, "io-backends-names",
> +						     name);
> +		if (index < 0)
> +			return ERR_PTR(index);
> +	}

	if (name) {
		ret = device_property_match_string(dev, "io-backends-names", name);
		if (ret < 0)
			return ERR_PTR(ret);
		index = ret;
	} else {
		index = 0;
	}

> +	fwnode = fwnode_find_reference(dev_fwnode(dev), "io-backends", index);
> +	if (IS_ERR(fwnode)) {
> +		/* not an error if optional */
> +		pr_debug("%s: Cannot get Firmware reference\n", dev_name(dev));
> +		return ERR_CAST(fwnode);
> +	}
> +
> +	guard(mutex)(&iio_back_lock);
> +	list_for_each_entry(back, &iio_back_list, entry) {
> +		if (!device_match_fwnode(back->dev, fwnode))
> +			continue;
> +
> +		fwnode_handle_put(fwnode);
> +		ret = __devm_iio_backend_get(dev, back);
> +		if (ret)
> +			return ERR_PTR(ret);
> +
> +		return back;
> +	}
> +
> +	fwnode_handle_put(fwnode);
> +	return ERR_PTR(-EPROBE_DEFER);
> +}

...

> +static void iio_backend_unregister(void *arg)
> +{
> +	struct iio_backend *back = arg;

No guard() here, why?

> +	mutex_lock(&iio_back_lock);
> +	list_del(&back->entry);
> +	mutex_unlock(&iio_back_lock);
> +}

> +int devm_iio_backend_register(struct device *dev,
> +			      const struct iio_backend_ops *ops, void *priv)

Use dev_err() et al.

...

> +	mutex_lock(&iio_back_lock);
> +	list_add(&back->entry, &iio_back_list);
> +	mutex_unlock(&iio_back_lock);

scoped_guard()?

-- 
With Best Regards,
Andy Shevchenko



