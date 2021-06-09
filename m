Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9033A1B35
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jun 2021 18:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhFIQvT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Jun 2021 12:51:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:43002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230103AbhFIQvT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 9 Jun 2021 12:51:19 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9797C613CB;
        Wed,  9 Jun 2021 16:49:22 +0000 (UTC)
Date:   Wed, 9 Jun 2021 17:51:15 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Jonathan.Cameron@Huawei.com,
        linux-stm32@st-md-mailman.stormreply.com, kernel@pengutronix.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RESEND PATCH v11 22/33] counter: Internalize sysfs interface
 code
Message-ID: <20210609175115.1692f5dc@jic23-huawei>
In-Reply-To: <87dec6c889e40068ed27cbb3e66a6376856e2267.1623201082.git.vilhelm.gray@gmail.com>
References: <cover.1623201081.git.vilhelm.gray@gmail.com>
        <87dec6c889e40068ed27cbb3e66a6376856e2267.1623201082.git.vilhelm.gray@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed,  9 Jun 2021 23:11:45 +0900
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> This is a reimplementation of the Generic Counter driver interface.
> There are no modifications to the Counter subsystem userspace interface,
> so existing userspace applications should continue to run seamlessly.
> 
> The purpose of this patch is to internalize the sysfs interface code
> among the various counter drivers into a shared module. Counter drivers
> pass and take data natively (i.e. u8, u64, etc.) and the shared counter
> module handles the translation between the sysfs interface and the
> device drivers. This guarantees a standard userspace interface for all
> counter drivers, and helps generalize the Generic Counter driver ABI in
> order to support the Generic Counter chrdev interface (introduced in a
> subsequent patch) without significant changes to the existing counter
> drivers.
> 
> Note, Counter device registration is the same as before: drivers
> populate a struct counter_device with components and callbacks, then
> pass the structure to the devm_counter_register function. However,
> what's different now is how the Counter subsystem code handles this
> registration internally.
> 
> Whereas before callbacks would interact directly with sysfs data, this
> interaction is now abstracted and instead callbacks interact with native
> C data types. The counter_comp structure forms the basis for Counter
> extensions.
> 
> The counter-sysfs.c file contains the code to parse through the
> counter_device structure and register the requested components and
> extensions. Attributes are created and populated based on type, with
> respective translation functions to handle the mapping between sysfs and
> the counter driver callbacks.
> 
> The translation performed for each attribute is straightforward: the
> attribute type and data is parsed from the counter_attribute structure,
> the respective counter driver read/write callback is called, and sysfs
> I/O is handled before or after the driver read/write function is called.
> 
> Cc: Syed Nayyar Waris <syednwaris@gmail.com>
> Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Cc: Patrick Havelange <patrick.havelange@essensium.com>
> Cc: Kamel Bouhara <kamel.bouhara@bootlin.com>
> Cc: Fabrice Gasnier <fabrice.gasnier@st.com>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Reviewed-by: David Lechner <david@lechnology.com>
> Tested-by: David Lechner <david@lechnology.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Given you will probably do a v12 anyway, a few comments inline.

Jonathan

> ---
>  MAINTAINERS                             |    1 -
>  drivers/counter/104-quad-8.c            |  449 +++----
>  drivers/counter/Makefile                |    1 +
>  drivers/counter/counter-core.c          |  155 +++
>  drivers/counter/counter-sysfs.c         |  846 +++++++++++++
>  drivers/counter/counter-sysfs.h         |   13 +
>  drivers/counter/counter.c               | 1496 -----------------------
>  drivers/counter/ftm-quaddec.c           |   56 +-
>  drivers/counter/intel-qep.c             |  144 +--
>  drivers/counter/interrupt-cnt.c         |   62 +-
>  drivers/counter/microchip-tcb-capture.c |   93 +-
>  drivers/counter/stm32-lptimer-cnt.c     |  162 ++-
>  drivers/counter/stm32-timer-cnt.c       |  147 +--
>  drivers/counter/ti-eqep.c               |  180 +--
>  include/linux/counter.h                 |  629 +++++-----
>  include/linux/counter_enum.h            |   45 -
>  16 files changed, 1918 insertions(+), 2561 deletions(-)
>  create mode 100644 drivers/counter/counter-core.c
>  create mode 100644 drivers/counter/counter-sysfs.c
>  create mode 100644 drivers/counter/counter-sysfs.h
>  delete mode 100644 drivers/counter/counter.c
>  delete mode 100644 include/linux/counter_enum.h
> 

...

> diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-core.c
> new file mode 100644
> index 000000000000..e7dd6ea01c8a
> --- /dev/null
> +++ b/drivers/counter/counter-core.c
> @@ -0,0 +1,155 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Generic Counter interface
> + * Copyright (C) 2020 William Breathitt Gray
> + */
> +#include <linux/counter.h>
> +#include <linux/device.h>
> +#include <linux/export.h>
> +#include <linux/gfp.h>
> +#include <linux/idr.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +
> +#include "counter-sysfs.h"
> +
> +/* Provides a unique ID for each counter device */
> +static DEFINE_IDA(counter_ida);
> +

...
> +int counter_register(struct counter_device *const counter)
> +{
> +	struct device *const dev = &counter->dev;
> +	int id;
> +	int err;
> +
> +	/* Acquire unique ID */
> +	id = ida_alloc(&counter_ida, GFP_KERNEL);
> +	if (id < 0)
> +		return id;
> +
> +	/* Configure device structure for Counter */
> +	dev->id = id;
> +	dev->type = &counter_device_type;
> +	dev->bus = &counter_bus_type;
> +	if (counter->parent) {
> +		dev->parent = counter->parent;
> +		dev->of_node = counter->parent->of_node;
> +	}
> +	device_initialize(dev);
> +	dev_set_drvdata(dev, counter);
> +
> +	/* Add Counter sysfs attributes */
> +	err = counter_sysfs_add(counter);
> +	if (err < 0)
> +		goto err_free_id;
> +
> +	/* Add device to system */
> +	err = device_add(dev);
> +	if (err < 0)
> +		goto err_free_id;
> +
> +	return 0;
> +
> +err_free_id:
> +	put_device(dev);
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(counter_register);
> +
> +/**
> + * counter_unregister - unregister Counter from the system
> + * @counter:	pointer to Counter to unregister
> + *
> + * The Counter is unregistered from the system; all allocated memory is freed.

If we are being fussy. This isn't necessarily true. If the reference goes
down to 0 it will be freed, but in theory that could happen later than
this call.  I'm guessing we will have get_device() calls once the
chrdev is in place.

> + */
> +void counter_unregister(struct counter_device *const counter)
> +{
> +	if (!counter)
> +		return;
> +
> +	device_unregister(&counter->dev);
> +}
> +EXPORT_SYMBOL_GPL(counter_unregister);
> +
> +static void devm_counter_release(struct device *dev, void *res)
> +{
> +	counter_unregister(*(struct counter_device **)res);
> +}
> +
> +/**
> + * devm_counter_register - Resource-managed counter_register
> + * @dev:	device to allocate counter_device for
> + * @counter:	pointer to Counter to register
> + *
> + * Managed counter_register. The Counter registered with this function is
> + * automatically unregistered on driver detach. This function calls
> + * counter_register internally. Refer to that function for more information.
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int devm_counter_register(struct device *dev,
> +			  struct counter_device *const counter)
> +{
> +	struct counter_device **ptr;
> +	int err;
> +
> +	ptr = devres_alloc(devm_counter_release, sizeof(*ptr), GFP_KERNEL);
> +	if (!ptr)
> +		return -ENOMEM;

If you look at how devm_iio_device_register() is now done in
the togreg branch of iio.git, you'll see it now just uses
devm_add_action_or_reset() internally.  I think you could do something similar
here and reduce boilerplate a little.

> +
> +	err = counter_register(counter);
> +	if (err < 0) {
> +		devres_free(ptr);
> +		return err;
> +	}
> +
> +	*ptr = counter;
> +	devres_add(dev, ptr);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(devm_counter_register);
> +
> +static int __init counter_init(void)
> +{
> +	return bus_register(&counter_bus_type);
> +}
> +
> +static void __exit counter_exit(void)
> +{
> +	bus_unregister(&counter_bus_type);
> +}
> +
> +subsys_initcall(counter_init);
> +module_exit(counter_exit);
> +
> +MODULE_AUTHOR("William Breathitt Gray <vilhelm.gray@gmail.com>");
> +MODULE_DESCRIPTION("Generic Counter interface");
> +MODULE_LICENSE("GPL v2");

> diff --git a/drivers/counter/counter-sysfs.c b/drivers/counter/counter-sysfs.c
> new file mode 100644
> index 000000000000..07588130600a
> --- /dev/null
> +++ b/drivers/counter/counter-sysfs.c
> @@ -0,0 +1,846 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Generic Counter sysfs interface
> + * Copyright (C) 2020 William Breathitt Gray
> + */
> +#include <linux/counter.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/gfp.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/string.h>
> +#include <linux/sysfs.h>
> +#include <linux/types.h>
> +
> +#include "counter-sysfs.h"
> +

...
