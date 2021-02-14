Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57C2231B1C9
	for <lists+linux-iio@lfdr.de>; Sun, 14 Feb 2021 19:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhBNSG7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Feb 2021 13:06:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:54772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229768AbhBNSG7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Feb 2021 13:06:59 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BFAC64E4E;
        Sun, 14 Feb 2021 18:06:15 +0000 (UTC)
Date:   Sun, 14 Feb 2021 18:06:12 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v8 17/22] counter: Add character device interface
Message-ID: <20210214180612.03af6f0d@archlinux>
In-Reply-To: <720278e3aaf3f249657ec18d158eca3f962baf8e.1613131238.git.vilhelm.gray@gmail.com>
References: <cover.1613131238.git.vilhelm.gray@gmail.com>
        <720278e3aaf3f249657ec18d158eca3f962baf8e.1613131238.git.vilhelm.gray@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 12 Feb 2021 21:13:41 +0900
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> This patch introduces a character device interface for the Counter
> subsystem. Device data is exposed through standard character device read
> operations. Device data is gathered when a Counter event is pushed by
> the respective Counter device driver. Configuration is handled via ioctl
> operations on the respective Counter character device node.
> 
> Cc: David Lechner <david@lechnology.com>
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Oleksij Rempel <o.rempel@pengutronix.de>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Hi William,

A few minor comments.  Mostly seems to have come together well and
makes sense to me.

Jonathan

> ---
>  drivers/counter/Makefile         |   2 +-
>  drivers/counter/counter-chrdev.c | 496 +++++++++++++++++++++++++++++++
>  drivers/counter/counter-chrdev.h |  16 +
>  drivers/counter/counter-core.c   |  37 ++-
>  include/linux/counter.h          |  45 +++
>  include/uapi/linux/counter.h     |  70 +++++
>  6 files changed, 661 insertions(+), 5 deletions(-)
>  create mode 100644 drivers/counter/counter-chrdev.c
>  create mode 100644 drivers/counter/counter-chrdev.h
> 

...

> diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-core.c
> index bcf672e1fc0d..c137fcb97d9c 100644
> --- a/drivers/counter/counter-core.c
> +++ b/drivers/counter/counter-core.c
> @@ -5,12 +5,16 @@
>   */
>  #include <linux/counter.h>
>  #include <linux/device.h>
> +#include <linux/device/bus.h>
>  #include <linux/export.h>
> +#include <linux/fs.h>
>  #include <linux/gfp.h>
>  #include <linux/idr.h>
>  #include <linux/init.h>
>  #include <linux/module.h>
> +#include <linux/types.h>
>  
> +#include "counter-chrdev.h"
>  #include "counter-sysfs.h"
>  
>  /* Provides a unique ID for each counter device */
> @@ -33,6 +37,8 @@ static struct bus_type counter_bus_type = {
>  	.name = "counter"
>  };
>  
> +static dev_t counter_devt;
> +
>  /**
>   * counter_register - register Counter to the system
>   * @counter:	pointer to Counter to register
> @@ -54,7 +60,6 @@ int counter_register(struct counter_device *const counter)
>  	if (counter->id < 0)
>  		return counter->id;
>  
> -	/* Configure device structure for Counter */

Not sure why this comment gets removed here.

>  	dev->type = &counter_device_type;
>  	dev->bus = &counter_bus_type;
>  	if (counter->parent) {
> @@ -65,18 +70,25 @@ int counter_register(struct counter_device *const counter)
>  	device_initialize(dev);
>  	dev_set_drvdata(dev, counter);
>  
> +	/* Add Counter character device */
> +	err = counter_chrdev_add(counter, counter_devt);
> +	if (err < 0)
> +		goto err_free_id;
> +
>  	/* Add Counter sysfs attributes */
>  	err = counter_sysfs_add(counter);
>  	if (err < 0)
> -		goto err_free_id;
> +		goto err_remove_chrdev;
>  
>  	/* Add device to system */
>  	err = device_add(dev);
>  	if (err < 0)
> -		goto err_free_id;
> +		goto err_remove_chrdev;

It might be worth thinking about using cdev_device_add()
though will require a slightly different order of adding.


>  
>  	return 0;
>  
> +err_remove_chrdev:
> +	counter_chrdev_remove(counter);
>  err_free_id:
>  	put_device(dev);
>  	return err;
> @@ -138,13 +150,30 @@ int devm_counter_register(struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(devm_counter_register);
>  
> +#define COUNTER_DEV_MAX 256
> +
>  static int __init counter_init(void)
>  {
> -	return bus_register(&counter_bus_type);
> +	int err;
> +
> +	err = bus_register(&counter_bus_type);
> +	if (err < 0)
> +		return err;
> +
> +	err = alloc_chrdev_region(&counter_devt, 0, COUNTER_DEV_MAX, "counter");
> +	if (err < 0)
> +		goto err_unregister_bus;
> +
> +	return 0;
> +
> +err_unregister_bus:
> +	bus_unregister(&counter_bus_type);
> +	return err;
>  }
>  
>  static void __exit counter_exit(void)
>  {
> +	unregister_chrdev_region(counter_devt, COUNTER_DEV_MAX);
>  	bus_unregister(&counter_bus_type);
>  }
>  

...

> diff --git a/include/uapi/linux/counter.h b/include/uapi/linux/counter.h
> index 6113938a6044..3d647a5383b8 100644
> --- a/include/uapi/linux/counter.h
> +++ b/include/uapi/linux/counter.h
> @@ -6,6 +6,19 @@
>  #ifndef _UAPI_COUNTER_H_
>  #define _UAPI_COUNTER_H_
>  
> +#include <linux/ioctl.h>
> +#include <linux/types.h>
> +
> +/* Component type definitions */
> +enum counter_component_type {
> +	COUNTER_COMPONENT_NONE,
> +	COUNTER_COMPONENT_SIGNAL,
> +	COUNTER_COMPONENT_COUNT,
> +	COUNTER_COMPONENT_FUNCTION,
> +	COUNTER_COMPONENT_SYNAPSE_ACTION,
> +	COUNTER_COMPONENT_EXTENSION,
> +};
> +
>  /* Component scope definitions */
>  enum counter_scope {
>  	COUNTER_SCOPE_DEVICE,
> @@ -13,6 +26,63 @@ enum counter_scope {
>  	COUNTER_SCOPE_COUNT,
>  };
>  
> +/**
> + * struct counter_component - Counter component identification
> + * @type: component type (one of enum counter_component_type)
> + * @scope: component scope (one of enum counter_scope)
> + * @parent: parent component ID (matching the Y/Z suffix of the respective sysfs
> + *	    path as described in Documentation/ABI/testing/sysfs-bus-counter)

Probably good to give an example here as well as the cross reference.

> + * @id: component ID (matching the Y/Z suffix of the respective sysfs path as
> + *	described in Documentation/ABI/testing/sysfs-bus-counter)
> + */
> +struct counter_component {
> +	__u8 type;
> +	__u8 scope;
> +	__u8 parent;
> +	__u8 id;
> +};
> +
> +/* Event type definitions */
> +enum counter_event_type {
> +	COUNTER_EVENT_OVERFLOW,
> +	COUNTER_EVENT_UNDERFLOW,
> +	COUNTER_EVENT_OVERFLOW_UNDERFLOW,
> +	COUNTER_EVENT_THRESHOLD,
> +	COUNTER_EVENT_INDEX,
> +};
> +
> +/**
> + * struct counter_watch - Counter component watch configuration
> + * @component: component to watch when event triggers
> + * @event: event that triggers (one of enum counter_event_type)
> + * @channel: event channel (typically 0 unless the device supports concurrent
> + *	     events of the same type)
> + */
> +struct counter_watch {
> +	struct counter_component component;
> +	__u8 event;
> +	__u8 channel;
> +};
> +
> +/* ioctl commands */
> +#define COUNTER_ADD_WATCH_IOCTL _IOW(0x3E, 0x00, struct counter_watch)
> +#define COUNTER_ENABLE_EVENTS_IOCTL _IO(0x3E, 0x01)
> +#define COUNTER_DISABLE_EVENTS_IOCTL _IO(0x3E, 0x02)
> +
> +/**
> + * struct counter_event - Counter event data
> + * @timestamp: best estimate of time of event occurrence, in nanoseconds
> + * @value: component value
> + * @watch: component watch configuration
> + * @status: return status (system error number)
> + */
> +struct counter_event {
> +	__aligned_u64 timestamp;
> +	__aligned_u64 value;
> +	struct counter_watch watch;
> +	__u8 status;
> +};
> +
>  /* Count direction values */
>  enum counter_count_direction {
>  	COUNTER_COUNT_DIRECTION_FORWARD,

