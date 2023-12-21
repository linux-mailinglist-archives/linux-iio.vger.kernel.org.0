Return-Path: <linux-iio+bounces-1204-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC7981BD82
	for <lists+linux-iio@lfdr.de>; Thu, 21 Dec 2023 18:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A74BD1C2360D
	for <lists+linux-iio@lfdr.de>; Thu, 21 Dec 2023 17:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4210862814;
	Thu, 21 Dec 2023 17:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZhLH7F06"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBAFBA2F;
	Thu, 21 Dec 2023 17:44:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA4CC433C8;
	Thu, 21 Dec 2023 17:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703180693;
	bh=BMIHeLuCeYwSHNOqRNr2btusBnP1gL+BuDzUPQ2zqJs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZhLH7F06LBAkWbWZHgFrICFKjJJS1sJPoYKS7/NxxANich6F24fsHeYj+6eEr/w+0
	 8/ewzzR7yaBOFof0zyxQx6e7QMtrse4Er5d99kGFNmIffmpxuBkefedhF2ME/0dIgb
	 eP0d/EEpZTvo8vspPc5nPkYwS2b32OBaVHJygB90eadWAZylpfgBEJxabncYnwkNmJ
	 7WYZ3Ti+YVC6MqKHafpERZF98ftYR/8ziQZl9C399B/6lmGYa0dToujGpmXVNUs3Ou
	 1FLAL0Qh1GNzS7SkOA6RRNDysZT2hTHU6yrrpDkqNSJ+Y54hlN+6oXMOOURagXkV+T
	 yorMF3x7gaVQw==
Date: Thu, 21 Dec 2023 17:44:37 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa <nuno.sa@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Frank Rowand
 <frowand.list@gmail.com>, Olivier Moysan <olivier.moysan@foss.st.com>
Subject: Re: [PATCH v4 6/8] iio: add the IIO backend framework
Message-ID: <20231221174437.5935a5c3@jic23-huawei>
In-Reply-To: <20231220-iio-backend-v4-6-998e9148b692@analog.com>
References: <20231220-iio-backend-v4-0-998e9148b692@analog.com>
	<20231220-iio-backend-v4-6-998e9148b692@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Dec 2023 16:34:09 +0100
Nuno Sa <nuno.sa@analog.com> wrote:

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

A few minor comments, but seems good to me otherwise.

Jonathan

> ---
>  MAINTAINERS                        |   8 +
>  drivers/iio/Kconfig                |   5 +
>  drivers/iio/Makefile               |   1 +
>  drivers/iio/industrialio-backend.c | 456 +++++++++++++++++++++++++++++++++++++
>  include/linux/iio/backend.h        |  75 ++++++
>  5 files changed, 545 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3029841e92a8..df5f5b988926 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10334,6 +10334,14 @@ L:	linux-media@vger.kernel.org
>  S:	Maintained
>  F:	drivers/media/rc/iguanair.c
>  
> +IIO BACKEND FRAMEWORK
> +M:	Nuno Sa <nuno.sa@analog.com>
> +R:	Olivier Moysan <olivier.moysan@foss.st.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	drivers/iio/industrialio-backend.c
> +F:	include/linux/iio/backend.h
> +
>  IIO DIGITAL POTENTIOMETER DAC
>  M:	Peter Rosin <peda@axentia.se>
>  L:	linux-iio@vger.kernel.org
> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
> index 52eb46ef84c1..451671112f73 100644
> --- a/drivers/iio/Kconfig
> +++ b/drivers/iio/Kconfig
> @@ -71,6 +71,11 @@ config IIO_TRIGGERED_EVENT
>  	help
>  	  Provides helper functions for setting up triggered events.
>  
> +config IIO_BACKEND
> +	tristate
> +	help
> +	  Framework to handle complex IIO aggregate devices.

Add some more description here. Not sure the current text will help
anyone understand it :)

> +
>  source "drivers/iio/accel/Kconfig"
>  source "drivers/iio/adc/Kconfig"
>  source "drivers/iio/addac/Kconfig"
> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
> index 9622347a1c1b..0ba0e1521ba4 100644
> --- a/drivers/iio/Makefile
> +++ b/drivers/iio/Makefile
> @@ -13,6 +13,7 @@ obj-$(CONFIG_IIO_GTS_HELPER) += industrialio-gts-helper.o
>  obj-$(CONFIG_IIO_SW_DEVICE) += industrialio-sw-device.o
>  obj-$(CONFIG_IIO_SW_TRIGGER) += industrialio-sw-trigger.o
>  obj-$(CONFIG_IIO_TRIGGERED_EVENT) += industrialio-triggered-event.o
> +obj-$(CONFIG_IIO_BACKEND) += industrialio-backend.o
>  
>  obj-y += accel/
>  obj-y += adc/
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
> new file mode 100644
> index 000000000000..75a0a66003e1
> --- /dev/null
> +++ b/drivers/iio/industrialio-backend.c
> @@ -0,0 +1,456 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Framework to handle complex IIO aggregate devices.
> + *
> + * The typical architecture is to have one device as the frontend device which
> + * can be "linked" against one or multiple backend devices. All the IIO and
> + * userspace interface is expected to be registers/managed by the frontend
> + * device which will callback into the backends when needed (to get/set some
> + * configuration that it does not directly control).
> + *
> + * The framework interface is pretty simple:
> + *   - Backends should register themselves with @devm_iio_backend_register()
> + *   - Frontend devices should get backends with @devm_iio_backend_get()
> + *
> + * Also to note that the primary target for this framework are converters like
> + * ADC/DACs so @iio_backend_ops will have some operations typical of converter
> + * devices. On top of that, this is "generic" for all IIO which means any kind
> + * of device can make use of the framework. That said, If the @iio_backend_ops
> + * struct begins to grow out of control, we can always refactor things so that
> + * the industrialio-backend.c is only left with the really generic stuff. Then,
> + * we can build on top of it depending on the needs.
> + *
> + * Copyright (C) 2023 Analog Devices Inc.
> + */
> +#define pr_fmt(fmt) "iio-backend: " fmt
> +
> +#include <linux/cleanup.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/list.h>
> +#include <linux/lockdep.h>
> +#include <linux/kref.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/property.h>
> +#include <linux/slab.h>
> +
> +#include <linux/iio/backend.h>
> +
> +struct iio_backend {
> +	struct list_head entry;
> +	const struct iio_backend_ops *ops;
> +	struct device *dev;
> +	struct module *owner;
> +	void *priv;
> +	/*
> +	 * mutex used to synchronize backend callback access with concurrent
> +	 * calls to @iio_backend_unregister. The lock makes sure a device is
> +	 * not unregistered while a callback is being run.
> +	 */
> +	struct mutex lock;
> +	struct kref ref;
> +};
> +

...

> +
> +static void iio_backend_release(void *arg)
> +{
> +	struct iio_backend *back = arg;
> +
> +	module_put(back->owner);
> +	kref_put(&back->ref, iio_backend_free);
> +}
> +
> +static int __devm_iio_backend_get(struct device *dev, struct iio_backend *back)
> +{
> +	struct device_link *link;
> +	int ret;
> +
> +	kref_get(&back->ref);
> +	if (!try_module_get(back->owner)) {
> +		pr_err("%s: Cannot get module reference\n", dev_name(dev));

Why do you need the reference?  Good to add a comment on that here.

> +		return -ENODEV;
> +	}
> +
> +	ret = devm_add_action_or_reset(dev, iio_backend_release, back);
> +	if (ret)
> +		return ret;
> +
> +	link = device_link_add(dev, back->dev, DL_FLAG_AUTOREMOVE_CONSUMER);
> +	if (!link)
> +		pr_warn("%s: Could not link to supplier(%s)\n", dev_name(dev),
> +			dev_name(back->dev));

Why is that not an error and we try to carry on?

> +
> +	pr_debug("%s: Found backend(%s) device\n", dev_name(dev),
> +		 dev_name(back->dev));
> +	return 0;
> +}
> +
> +/**
> + * devm_iio_backend_get - Get a backend device
> + * @dev:	Device where to look for the backend.
> + * @name:	Backend name.
> + *
> + * Get's the backend associated with @dev.
> + *
> + * RETURNS:
> + * A backend pointer, negative error pointer otherwise.
> + */
> +struct iio_backend *devm_iio_backend_get(struct device *dev, const char *name)
> +{
> +	struct fwnode_handle *fwnode;
> +	struct iio_backend *back;
> +	int index = 0, ret;
> +
> +	if (name) {
> +		index = device_property_match_string(dev, "io-backends-names",
> +						     name);
> +		if (index < 0)
> +			return ERR_PTR(index);
> +	}
> +
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

FYI. I have a series doing auto cleanup of fwnode_handles in progress.
Should get some time over the weekend to snd that out.  Aim is to avoid need
to dance around manually freeing them (similar to the DT __free(device_node)
series I posted the other day).

> +	return ERR_PTR(-EPROBE_DEFER);
> +}
> +EXPORT_SYMBOL_NS_GPL(devm_iio_backend_get, IIO_BACKEND);
> +
> +/**
> + * devm_iio_backend_get_optional - Get optional backend device
> + * @dev:	Device where to look for the backend.
> + * @name:	Backend name.
> + *
> + * Same as @devm_iio_backend_get() but return NULL if backend not found.
> + *
> + * RETURNS:
> + * A backend pointer, negative error pointer otherwise or NULL if not found.
> + */
> +struct iio_backend *devm_iio_backend_get_optional(struct device *dev,
> +						  const char *name)
> +{
> +	struct iio_backend *back;
> +
> +	back = devm_iio_backend_get(dev, name);
> +	if (IS_ERR(back) && PTR_ERR(back) == -ENOENT)
> +		return NULL;
> +
> +	return back;
> +}
> +EXPORT_SYMBOL_NS_GPL(devm_iio_backend_get_optional, IIO_BACKEND);

I'm not convinced the optional variant is worth while.  Could just choose
a particular return value to mean that e.g. ERR_PTR(-ENOENT) and document
it for the normal get.  Then have special handling in the drivers where
you need backwards compatibility with a previous approach.

I'd rather pay the complexity price in a couple of drivers than have
to explain backends aren't typically optional for years to come.


> +
> +/**
> + * devm_iio_backend_get_from_fwnode_lookup
> + * @dev:	Device where to bind the backend lifetime.
> + * @fwnode:	Firmware node of the backend device.
> + *
> + * It directly looks the backend device list for a device matching @fwnode.

I would word this:
Search the backend list for a device matchign &fwnode.

> + * This API should not be used and it's only present for preventing the first
> + * user of this framework to break it's DT ABI.

You could stick a __ in front of the name to hopefully scare people away :)
+ highlight something odd is going on to reviewers seeing this called in
some future driver.
Also I can we might convert other drivers that are doing similar things
(dfsdm for example) and maybe this will be useful
so __devm_iio_backend_get_from_fwnode_lookup() and
"preventing breakage of old DT bindings".

> + *
> + * RETURNS:
> + * A backend pointer, negative error pointer otherwise.
> + */
> +struct iio_backend *
> +devm_iio_backend_get_from_fwnode_lookup(struct device *dev,
> +					struct fwnode_handle *fwnode)
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
> +EXPORT_SYMBOL_NS_GPL(devm_iio_backend_get_from_fwnode_lookup, IIO_BACKEND);



