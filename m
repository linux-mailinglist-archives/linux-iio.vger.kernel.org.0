Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB0E231B1D3
	for <lists+linux-iio@lfdr.de>; Sun, 14 Feb 2021 19:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbhBNSMe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Feb 2021 13:12:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:55282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229758AbhBNSMd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Feb 2021 13:12:33 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 551FD64E29;
        Sun, 14 Feb 2021 18:11:50 +0000 (UTC)
Date:   Sun, 14 Feb 2021 18:11:46 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de
Subject: Re: [PATCH v8 20/22] counter: Implement events_queue_size sysfs
 attribute
Message-ID: <20210214181146.66d43da7@archlinux>
In-Reply-To: <013b2b8682ddc3c85038083e6d5567696b6254b3.1613131238.git.vilhelm.gray@gmail.com>
References: <cover.1613131238.git.vilhelm.gray@gmail.com>
        <013b2b8682ddc3c85038083e6d5567696b6254b3.1613131238.git.vilhelm.gray@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 12 Feb 2021 21:13:44 +0900
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> The events_queue_size sysfs attribute provides a way for users to
> dynamically configure the Counter events queue size for the Counter
> character device interface. The size is in number of struct
> counter_event data structures. The number of elements will be rounded-up
> to a power of 2 due to a requirement of the kfifo_alloc function called
> during reallocation of the queue.
> 
> Cc: Oleksij Rempel <o.rempel@pengutronix.de>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-counter |  8 +++++++
>  drivers/counter/counter-chrdev.c            | 23 +++++++++++++++++++
>  drivers/counter/counter-chrdev.h            |  2 ++
>  drivers/counter/counter-sysfs.c             | 25 +++++++++++++++++++++
>  4 files changed, 58 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/ABI/testing/sysfs-bus-counter
> index 847e96f19d19..f6cb2a8b08a7 100644
> --- a/Documentation/ABI/testing/sysfs-bus-counter
> +++ b/Documentation/ABI/testing/sysfs-bus-counter
> @@ -212,6 +212,14 @@ Description:
>  		both edges:
>  			Any state transition.
>  
> +What:		/sys/bus/counter/devices/counterX/events_queue_size
> +KernelVersion:	5.13
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Size of the Counter events queue in number of struct
> +		counter_event data structures. The number of elements will be
> +		rounded-up to a power of 2.
> +
>  What:		/sys/bus/counter/devices/counterX/name
>  KernelVersion:	5.2
>  Contact:	linux-iio@vger.kernel.org
> diff --git a/drivers/counter/counter-chrdev.c b/drivers/counter/counter-chrdev.c
> index 16f02df7f73d..53eea894e13f 100644
> --- a/drivers/counter/counter-chrdev.c
> +++ b/drivers/counter/counter-chrdev.c
> @@ -375,6 +375,29 @@ void counter_chrdev_remove(struct counter_device *const counter)
>  	cdev_del(&counter->chrdev);
>  }
>  
> +int counter_chrdev_realloc_queue(struct counter_device *const counter,
> +				 size_t queue_size)
> +{
> +	int err;
> +	DECLARE_KFIFO_PTR(events, struct counter_event);
> +	unsigned long flags;
> +
> +	/* Allocate new events queue */
> +	err = kfifo_alloc(&events, queue_size, GFP_ATOMIC);

Is there any potential for losing events?

> +	if (err)
> +		return err;
> +
> +	raw_spin_lock_irqsave(&counter->events_list_lock, flags);
> +
> +	/* Swap in new events queue */
> +	kfifo_free(&counter->events);
> +	counter->events.kfifo = events.kfifo;
> +
> +	raw_spin_unlock_irqrestore(&counter->events_list_lock, flags);
> +
> +	return 0;
> +}
> +
>  static int counter_get_data(struct counter_device *const counter,
>  			    const struct counter_comp_node *const comp_node,
>  			    u64 *const value)
> diff --git a/drivers/counter/counter-chrdev.h b/drivers/counter/counter-chrdev.h
> index cf5a318fe540..ff7fb0191852 100644
> --- a/drivers/counter/counter-chrdev.h
> +++ b/drivers/counter/counter-chrdev.h
> @@ -12,5 +12,7 @@
>  int counter_chrdev_add(struct counter_device *const counter,
>  		       const dev_t counter_devt);
>  void counter_chrdev_remove(struct counter_device *const counter);
> +int counter_chrdev_realloc_queue(struct counter_device *const counter,
> +				 size_t queue_size);
>  
>  #endif /* _COUNTER_CHRDEV_H_ */
> diff --git a/drivers/counter/counter-sysfs.c b/drivers/counter/counter-sysfs.c
> index 0cb3dba950bc..9abc821a3871 100644
> --- a/drivers/counter/counter-sysfs.c
> +++ b/drivers/counter/counter-sysfs.c
> @@ -13,6 +13,7 @@
>  #include <linux/sysfs.h>
>  #include <linux/types.h>
>  
> +#include "counter-chrdev.h"
>  #include "counter-sysfs.h"
>  
>  /**
> @@ -737,12 +738,30 @@ static int counter_num_counts_read(struct counter_device *counter, u8 *val)
>  	return 0;
>  }
>  
> +static int counter_events_queue_size_read(struct counter_device *counter,
> +					  u64 *val)
> +{
> +	*val = counter->events.kfifo.mask + 1;

kfifo_size() rather than open coding it?

> +	return 0;
> +}
> +
> +static int counter_events_queue_size_write(struct counter_device *counter,
> +					   u64 val)
> +{
> +	return counter_chrdev_realloc_queue(counter, val);
> +}
> +
>  static struct counter_comp counter_num_signals_comp =
>  	COUNTER_COMP_DEVICE_U8("num_signals", counter_num_signals_read, NULL);
>  
>  static struct counter_comp counter_num_counts_comp =
>  	COUNTER_COMP_DEVICE_U8("num_counts", counter_num_counts_read, NULL);
>  
> +static struct counter_comp counter_events_queue_size_comp =
> +	COUNTER_COMP_DEVICE_U64("events_queue_size",
> +				counter_events_queue_size_read,
> +				counter_events_queue_size_write);
> +
>  static int counter_sysfs_attr_add(struct counter_device *const counter,
>  				  struct counter_attribute_group *group)
>  {
> @@ -781,6 +800,12 @@ static int counter_sysfs_attr_add(struct counter_device *const counter,
>  	if (err < 0)
>  		return err;
>  
> +	/* Create num_counts attribute */
> +	err = counter_attr_create(dev, group, &counter_events_queue_size_comp,
> +				  scope, NULL);
> +	if (err < 0)
> +		return err;
> +
>  	/* Create an attribute for each extension */
>  	for (i = 0; i < counter->num_ext; i++) {
>  		ext = counter->ext + i;

