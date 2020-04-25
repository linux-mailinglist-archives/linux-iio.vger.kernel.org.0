Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4E311B8768
	for <lists+linux-iio@lfdr.de>; Sat, 25 Apr 2020 17:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgDYPia (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Apr 2020 11:38:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:49150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbgDYPi3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Apr 2020 11:38:29 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 586A620704;
        Sat, 25 Apr 2020 15:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587829108;
        bh=Ds8KaQrPpt8EHTTpcgg2zmlfWdozEAB00KrvzGKb6js=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RAIHf7+UtfbIPbo4W53F5kc5sf/4onjLbcYstU7IQSz9+MFOEz0ctNPTSNK4zO3pk
         ZOvhLhKptGvCsmcv95R39NgkLjIq7qO/N21byl5CES5uzCMdn7wdtyhXE7WbHlVqSm
         M90864ef3Euu13pQao0SeFe43/kOqBFRsgF2xy3k=
Date:   Sat, 25 Apr 2020 16:38:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v3 2/2] irq/irq_sim: simplify the API
Message-ID: <20200425163823.58257e33@archlinux>
In-Reply-To: <20200417080549.23751-3-brgl@bgdev.pl>
References: <20200417080549.23751-1-brgl@bgdev.pl>
        <20200417080549.23751-3-brgl@bgdev.pl>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 17 Apr 2020 10:05:49 +0200
Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> The interrupt simulator API exposes a lot of custom data structures and
> functions and doesn't reuse the interfaces already exposed by the irq
> subsystem. This patch tries to address it.
> 
> We hide all the simulator-related data structures from users and instead
> rely on the well-known irq domain. When creating the interrupt simulator
> the user receives a pointer to a newly created irq_domain and can use it
> to create mappings for simulated interrupts.
> 
> It is also possible to pass a handle to fwnode when creating the simulator
> domain and retrieve it using irq_find_matching_fwnode().
> 
> The irq_sim_fire() function now only takes the virtual interrupt number
> as argument - there's no need anymore to pass it any data structure linked
> to the simulator.
> 
> We modify the two modules that use the simulator at the same time as
> adding these changes in order to reduce the intermediate bloat that would
> result when trying to migrate the drivers in separate patches.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

I'm not going to comment on the more generic bits as I don't have
time today to learn enough about it. IIO changes look sensible to me.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> #for IIO

> ---
>  drivers/gpio/gpio-mockup.c          |  47 ++++--
>  drivers/iio/dummy/iio_dummy_evgen.c |  32 ++--
>  include/linux/irq_sim.h             |  34 ++---
>  kernel/irq/Kconfig                  |   1 +
>  kernel/irq/irq_sim.c                | 225 +++++++++++++++++-----------
>  5 files changed, 202 insertions(+), 137 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
> index 3eb94f3740d1..941a967296c4 100644
> --- a/drivers/gpio/gpio-mockup.c
> +++ b/drivers/gpio/gpio-mockup.c
> @@ -14,6 +14,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
>  #include <linux/irq_sim.h>
> +#include <linux/irqdomain.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/property.h>
> @@ -48,7 +49,7 @@ struct gpio_mockup_line_status {
>  struct gpio_mockup_chip {
>  	struct gpio_chip gc;
>  	struct gpio_mockup_line_status *lines;
> -	struct irq_sim irqsim;
> +	struct irq_domain *irq_sim_domain;
>  	struct dentry *dbg_dir;
>  	struct mutex lock;
>  };
> @@ -144,14 +145,12 @@ static void gpio_mockup_set_multiple(struct gpio_chip *gc,
>  static int gpio_mockup_apply_pull(struct gpio_mockup_chip *chip,
>  				  unsigned int offset, int value)
>  {
> +	int curr, irq, irq_type, ret = 0;
>  	struct gpio_desc *desc;
>  	struct gpio_chip *gc;
> -	struct irq_sim *sim;
> -	int curr, irq, irq_type;
>  
>  	gc = &chip->gc;
>  	desc = &gc->gpiodev->descs[offset];
> -	sim = &chip->irqsim;
>  
>  	mutex_lock(&chip->lock);
>  
> @@ -161,14 +160,24 @@ static int gpio_mockup_apply_pull(struct gpio_mockup_chip *chip,
>  		if (curr == value)
>  			goto out;
>  
> -		irq = irq_sim_irqnum(sim, offset);
> +		irq = irq_find_mapping(chip->irq_sim_domain, offset);
> +		if (!irq)
> +			/*
> +			 * This is fine - it just means, nobody is listening
> +			 * for interrupts on this line, otherwise
> +			 * irq_create_mapping() would have been called from
> +			 * the to_irq() callback.
> +			 */
> +			goto set_value;
> +
>  		irq_type = irq_get_trigger_type(irq);
>  
>  		if ((value == 1 && (irq_type & IRQ_TYPE_EDGE_RISING)) ||
>  		    (value == 0 && (irq_type & IRQ_TYPE_EDGE_FALLING)))
> -			irq_sim_fire(sim, offset);
> +			irq_sim_fire(irq);
>  	}
>  
> +set_value:
>  	/* Change the value unless we're actively driving the line. */
>  	if (!test_bit(FLAG_REQUESTED, &desc->flags) ||
>  	    !test_bit(FLAG_IS_OUT, &desc->flags))
> @@ -177,7 +186,7 @@ static int gpio_mockup_apply_pull(struct gpio_mockup_chip *chip,
>  out:
>  	chip->lines[offset].pull = value;
>  	mutex_unlock(&chip->lock);
> -	return 0;
> +	return ret;
>  }
>  
>  static int gpio_mockup_set_config(struct gpio_chip *gc,
> @@ -236,7 +245,7 @@ static int gpio_mockup_to_irq(struct gpio_chip *gc, unsigned int offset)
>  {
>  	struct gpio_mockup_chip *chip = gpiochip_get_data(gc);
>  
> -	return irq_sim_irqnum(&chip->irqsim, offset);
> +	return irq_create_mapping(chip->irq_sim_domain, offset);
>  }
>  
>  static void gpio_mockup_free(struct gpio_chip *gc, unsigned int offset)
> @@ -389,6 +398,19 @@ static int gpio_mockup_name_lines(struct device *dev,
>  	return 0;
>  }
>  
> +static void gpio_mockup_dispose_mappings(void *data)
> +{
> +	struct gpio_mockup_chip *chip = data;
> +	struct gpio_chip *gc = &chip->gc;
> +	int i, irq;
> +
> +	for (i = 0; i < gc->ngpio; i++) {
> +		irq = irq_find_mapping(chip->irq_sim_domain, i);
> +		if (irq)
> +			irq_dispose_mapping(irq);
> +	}
> +}
> +
>  static int gpio_mockup_probe(struct platform_device *pdev)
>  {
>  	struct gpio_mockup_chip *chip;
> @@ -456,8 +478,13 @@ static int gpio_mockup_probe(struct platform_device *pdev)
>  			return rv;
>  	}
>  
> -	rv = devm_irq_sim_init(dev, &chip->irqsim, gc->ngpio);
> -	if (rv < 0)
> +	chip->irq_sim_domain = devm_irq_domain_create_sim(dev, NULL,
> +							  gc->ngpio);
> +	if (IS_ERR(chip->irq_sim_domain))
> +		return PTR_ERR(chip->irq_sim_domain);
> +
> +	rv = devm_add_action_or_reset(dev, gpio_mockup_dispose_mappings, chip);
> +	if (rv)
>  		return rv;
>  
>  	rv = devm_gpiochip_add_data(dev, &chip->gc, chip);
> diff --git a/drivers/iio/dummy/iio_dummy_evgen.c b/drivers/iio/dummy/iio_dummy_evgen.c
> index a6edf30567aa..31c9e012abeb 100644
> --- a/drivers/iio/dummy/iio_dummy_evgen.c
> +++ b/drivers/iio/dummy/iio_dummy_evgen.c
> @@ -37,8 +37,7 @@ struct iio_dummy_eventgen {
>  	struct iio_dummy_regs regs[IIO_EVENTGEN_NO];
>  	struct mutex lock;
>  	bool inuse[IIO_EVENTGEN_NO];
> -	struct irq_sim irq_sim;
> -	int base;
> +	struct irq_domain *irq_sim_domain;
>  };
>  
>  /* We can only ever have one instance of this 'device' */
> @@ -46,19 +45,17 @@ static struct iio_dummy_eventgen *iio_evgen;
>  
>  static int iio_dummy_evgen_create(void)
>  {
> -	int ret;
> -
>  	iio_evgen = kzalloc(sizeof(*iio_evgen), GFP_KERNEL);
>  	if (!iio_evgen)
>  		return -ENOMEM;
>  
> -	ret = irq_sim_init(&iio_evgen->irq_sim, IIO_EVENTGEN_NO);
> -	if (ret < 0) {
> +	iio_evgen->irq_sim_domain = irq_domain_create_sim(NULL,
> +							  IIO_EVENTGEN_NO);
> +	if (IS_ERR(iio_evgen->irq_sim_domain)) {
>  		kfree(iio_evgen);
> -		return ret;
> +		return PTR_ERR(iio_evgen->irq_sim_domain);
>  	}
>  
> -	iio_evgen->base = irq_sim_irqnum(&iio_evgen->irq_sim, 0);
>  	mutex_init(&iio_evgen->lock);
>  
>  	return 0;
> @@ -80,7 +77,7 @@ int iio_dummy_evgen_get_irq(void)
>  	mutex_lock(&iio_evgen->lock);
>  	for (i = 0; i < IIO_EVENTGEN_NO; i++) {
>  		if (!iio_evgen->inuse[i]) {
> -			ret = irq_sim_irqnum(&iio_evgen->irq_sim, i);
> +			ret = irq_create_mapping(iio_evgen->irq_sim_domain, i);
>  			iio_evgen->inuse[i] = true;
>  			break;
>  		}
> @@ -101,21 +98,27 @@ EXPORT_SYMBOL_GPL(iio_dummy_evgen_get_irq);
>   */
>  void iio_dummy_evgen_release_irq(int irq)
>  {
> +	struct irq_data *irqd = irq_get_irq_data(irq);
> +
>  	mutex_lock(&iio_evgen->lock);
> -	iio_evgen->inuse[irq - iio_evgen->base] = false;
> +	iio_evgen->inuse[irqd_to_hwirq(irqd)] = false;
> +	irq_dispose_mapping(irq);
>  	mutex_unlock(&iio_evgen->lock);
>  }
>  EXPORT_SYMBOL_GPL(iio_dummy_evgen_release_irq);
>  
>  struct iio_dummy_regs *iio_dummy_evgen_get_regs(int irq)
>  {
> -	return &iio_evgen->regs[irq - iio_evgen->base];
> +	struct irq_data *irqd = irq_get_irq_data(irq);
> +
> +	return &iio_evgen->regs[irqd_to_hwirq(irqd)];
> +
>  }
>  EXPORT_SYMBOL_GPL(iio_dummy_evgen_get_regs);
>  
>  static void iio_dummy_evgen_free(void)
>  {
> -	irq_sim_fini(&iio_evgen->irq_sim);
> +	irq_domain_remove_sim(iio_evgen->irq_sim_domain);
>  	kfree(iio_evgen);
>  }
>  
> @@ -131,7 +134,7 @@ static ssize_t iio_evgen_poke(struct device *dev,
>  {
>  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>  	unsigned long event;
> -	int ret;
> +	int ret, irq;
>  
>  	ret = kstrtoul(buf, 10, &event);
>  	if (ret)
> @@ -140,7 +143,8 @@ static ssize_t iio_evgen_poke(struct device *dev,
>  	iio_evgen->regs[this_attr->address].reg_id   = this_attr->address;
>  	iio_evgen->regs[this_attr->address].reg_data = event;
>  
> -	irq_sim_fire(&iio_evgen->irq_sim, this_attr->address);
> +	irq = irq_find_mapping(iio_evgen->irq_sim_domain, this_attr->address);
> +	irq_sim_fire(irq);
>  
>  	return len;
>  }
> diff --git a/include/linux/irq_sim.h b/include/linux/irq_sim.h
> index 4500d453a63e..26bf6164dcc7 100644
> --- a/include/linux/irq_sim.h
> +++ b/include/linux/irq_sim.h
> @@ -1,41 +1,27 @@
>  /* SPDX-License-Identifier: GPL-2.0+ */
>  /*
>   * Copyright (C) 2017-2018 Bartosz Golaszewski <brgl@bgdev.pl>
> + * Copyright (C) 2020 Bartosz Golaszewski <bgolaszewski@baylibre.com>
>   */
>  
>  #ifndef _LINUX_IRQ_SIM_H
>  #define _LINUX_IRQ_SIM_H
>  
> -#include <linux/irq_work.h>
>  #include <linux/device.h>
> +#include <linux/fwnode.h>
> +#include <linux/irqdomain.h>
>  
>  /*
>   * Provides a framework for allocating simulated interrupts which can be
>   * requested like normal irqs and enqueued from process context.
>   */
>  
> -struct irq_sim_work_ctx {
> -	struct irq_work		work;
> -	unsigned long		*pending;
> -};
> -
> -struct irq_sim_irq_ctx {
> -	int			irqnum;
> -	bool			enabled;
> -};
> -
> -struct irq_sim {
> -	struct irq_sim_work_ctx	work_ctx;
> -	int			irq_base;
> -	unsigned int		irq_count;
> -	struct irq_sim_irq_ctx	*irqs;
> -};
> -
> -int irq_sim_init(struct irq_sim *sim, unsigned int num_irqs);
> -int devm_irq_sim_init(struct device *dev, struct irq_sim *sim,
> -		      unsigned int num_irqs);
> -void irq_sim_fini(struct irq_sim *sim);
> -void irq_sim_fire(struct irq_sim *sim, unsigned int offset);
> -int irq_sim_irqnum(struct irq_sim *sim, unsigned int offset);
> +struct irq_domain *irq_domain_create_sim(struct fwnode_handle *fwnode,
> +					 unsigned int num_irqs);
> +struct irq_domain *devm_irq_domain_create_sim(struct device *dev,
> +					      struct fwnode_handle *fwnode,
> +					      unsigned int num_irqs);
> +void irq_domain_remove_sim(struct irq_domain *domain);
> +void irq_sim_fire(int virq);
>  
>  #endif /* _LINUX_IRQ_SIM_H */
> diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
> index 20d501af4f2e..d63c324895ea 100644
> --- a/kernel/irq/Kconfig
> +++ b/kernel/irq/Kconfig
> @@ -72,6 +72,7 @@ config IRQ_DOMAIN
>  config IRQ_SIM
>  	bool
>  	select IRQ_WORK
> +	select IRQ_DOMAIN
>  
>  # Support for hierarchical irq domains
>  config IRQ_DOMAIN_HIERARCHY
> diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
> index b992f88c5613..575c1e3d32a9 100644
> --- a/kernel/irq/irq_sim.c
> +++ b/kernel/irq/irq_sim.c
> @@ -1,14 +1,30 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
>   * Copyright (C) 2017-2018 Bartosz Golaszewski <brgl@bgdev.pl>
> + * Copyright (C) 2020 Bartosz Golaszewski <bgolaszewski@baylibre.com>
>   */
>  
> -#include <linux/slab.h>
> -#include <linux/irq_sim.h>
>  #include <linux/irq.h>
> +#include <linux/irq_sim.h>
> +#include <linux/irq_work.h>
> +#include <linux/slab.h>
> +
> +struct irq_sim_work_ctx {
> +	struct irq_work		work;
> +	int			irq_base;
> +	unsigned int		irq_count;
> +	unsigned long		*pending;
> +	struct irq_domain	*domain;
> +};
> +
> +struct irq_sim_irq_ctx {
> +	int			irqnum;
> +	bool			enabled;
> +	struct irq_sim_work_ctx	*work_ctx;
> +};
>  
>  struct irq_sim_devres {
> -	struct irq_sim		*sim;
> +	struct irq_domain	*domain;
>  };
>  
>  static void irq_sim_irqmask(struct irq_data *data)
> @@ -47,148 +63,179 @@ static void irq_sim_handle_irq(struct irq_work *work)
>  {
>  	struct irq_sim_work_ctx *work_ctx;
>  	unsigned int offset = 0;
> -	struct irq_sim *sim;
>  	int irqnum;
>  
>  	work_ctx = container_of(work, struct irq_sim_work_ctx, work);
> -	sim = container_of(work_ctx, struct irq_sim, work_ctx);
>  
> -	while (!bitmap_empty(work_ctx->pending, sim->irq_count)) {
> +	while (!bitmap_empty(work_ctx->pending, work_ctx->irq_count)) {
>  		offset = find_next_bit(work_ctx->pending,
> -				       sim->irq_count, offset);
> +				       work_ctx->irq_count, offset);
>  		clear_bit(offset, work_ctx->pending);
> -		irqnum = irq_sim_irqnum(sim, offset);
> +		irqnum = irq_find_mapping(work_ctx->domain, offset);
>  		handle_simple_irq(irq_to_desc(irqnum));
>  	}
>  }
>  
> +static int irq_sim_domain_map(struct irq_domain *domain,
> +			      unsigned int virq, irq_hw_number_t hw)
> +{
> +	struct irq_sim_work_ctx *work_ctx = domain->host_data;
> +	struct irq_sim_irq_ctx *irq_ctx;
> +
> +	irq_ctx = kzalloc(sizeof(*irq_ctx), GFP_KERNEL);
> +	if (!irq_ctx)
> +		return -ENOMEM;
> +
> +	irq_set_chip(virq, &irq_sim_irqchip);
> +	irq_set_chip_data(virq, irq_ctx);
> +	irq_set_handler(virq, handle_simple_irq);
> +	irq_modify_status(virq, IRQ_NOREQUEST | IRQ_NOAUTOEN, IRQ_NOPROBE);
> +	irq_ctx->work_ctx = work_ctx;
> +
> +	return 0;
> +}
> +
> +static void irq_sim_domain_unmap(struct irq_domain *domain, unsigned int virq)
> +{
> +	struct irq_sim_irq_ctx *irq_ctx;
> +	struct irq_data *irqd;
> +
> +	irqd = irq_domain_get_irq_data(domain, virq);
> +	irq_ctx = irq_data_get_irq_chip_data(irqd);
> +
> +	irq_set_handler(virq, NULL);
> +	irq_domain_reset_irq_data(irqd);
> +	kfree(irq_ctx);
> +}
> +
> +static const struct irq_domain_ops irq_sim_domain_ops = {
> +	.map		= irq_sim_domain_map,
> +	.unmap		= irq_sim_domain_unmap,
> +};
> +
>  /**
> - * irq_sim_init - Initialize the interrupt simulator: allocate a range of
> - *                dummy interrupts.
> + * irq_domain_create_sim - Create a new interrupt simulator irq_domain and
> + *                         allocate a range of dummy interrupts.
>   *
> - * @sim:        The interrupt simulator object to initialize.
> - * @num_irqs:   Number of interrupts to allocate
> + * @fnode:      struct fwnode_handle to be associated with this domain.
> + * @num_irqs:   Number of interrupts to allocate.
>   *
> - * On success: return the base of the allocated interrupt range.
> - * On failure: a negative errno.
> + * On success: return a new irq_domain object.
> + * On failure: a negative errno wrapped with ERR_PTR().
>   */
> -int irq_sim_init(struct irq_sim *sim, unsigned int num_irqs)
> +struct irq_domain *irq_domain_create_sim(struct fwnode_handle *fwnode,
> +					 unsigned int num_irqs)
>  {
> -	int i;
> +	struct irq_sim_work_ctx *work_ctx;
>  
> -	sim->irqs = kmalloc_array(num_irqs, sizeof(*sim->irqs), GFP_KERNEL);
> -	if (!sim->irqs)
> -		return -ENOMEM;
> +	work_ctx = kmalloc(sizeof(*work_ctx), GFP_KERNEL);
> +	if (!work_ctx)
> +		goto err_out;
>  
> -	sim->irq_base = irq_alloc_descs(-1, 0, num_irqs, 0);
> -	if (sim->irq_base < 0) {
> -		kfree(sim->irqs);
> -		return sim->irq_base;
> -	}
> +	work_ctx->pending = bitmap_zalloc(num_irqs, GFP_KERNEL);
> +	if (!work_ctx->pending)
> +		goto err_free_work_ctx;
>  
> -	sim->work_ctx.pending = bitmap_zalloc(num_irqs, GFP_KERNEL);
> -	if (!sim->work_ctx.pending) {
> -		kfree(sim->irqs);
> -		irq_free_descs(sim->irq_base, num_irqs);
> -		return -ENOMEM;
> -	}
> +	work_ctx->domain = irq_domain_create_linear(fwnode, num_irqs,
> +						    &irq_sim_domain_ops,
> +						    work_ctx);
> +	if (!work_ctx->domain)
> +		goto err_free_bitmap;
>  
> -	for (i = 0; i < num_irqs; i++) {
> -		sim->irqs[i].irqnum = sim->irq_base + i;
> -		sim->irqs[i].enabled = false;
> -		irq_set_chip(sim->irq_base + i, &irq_sim_irqchip);
> -		irq_set_chip_data(sim->irq_base + i, &sim->irqs[i]);
> -		irq_set_handler(sim->irq_base + i, &handle_simple_irq);
> -		irq_modify_status(sim->irq_base + i,
> -				  IRQ_NOREQUEST | IRQ_NOAUTOEN, IRQ_NOPROBE);
> -	}
> +	work_ctx->irq_count = num_irqs;
> +	init_irq_work(&work_ctx->work, irq_sim_handle_irq);
>  
> -	init_irq_work(&sim->work_ctx.work, irq_sim_handle_irq);
> -	sim->irq_count = num_irqs;
> +	return work_ctx->domain;
>  
> -	return sim->irq_base;
> +err_free_bitmap:
> +	bitmap_free(work_ctx->pending);
> +err_free_work_ctx:
> +	kfree(work_ctx);
> +err_out:
> +	return ERR_PTR(-ENOMEM);
>  }
> -EXPORT_SYMBOL_GPL(irq_sim_init);
> +EXPORT_SYMBOL_GPL(irq_domain_create_sim);
>  
>  /**
> - * irq_sim_fini - Deinitialize the interrupt simulator: free the interrupt
> - *                descriptors and allocated memory.
> + * irq_domain_remove_sim - Deinitialize the interrupt simulator domain: free
> + *                         the interrupt descriptors and allocated memory.
>   *
> - * @sim:        The interrupt simulator to tear down.
> + * @domain:     The interrupt simulator domain to tear down.
>   */
> -void irq_sim_fini(struct irq_sim *sim)
> +void irq_domain_remove_sim(struct irq_domain *domain)
>  {
> -	irq_work_sync(&sim->work_ctx.work);
> -	bitmap_free(sim->work_ctx.pending);
> -	irq_free_descs(sim->irq_base, sim->irq_count);
> -	kfree(sim->irqs);
> +	struct irq_sim_work_ctx *work_ctx = domain->host_data;
> +
> +	irq_work_sync(&work_ctx->work);
> +	bitmap_free(work_ctx->pending);
> +	kfree(work_ctx);
> +
> +	irq_domain_remove(domain);
>  }
> -EXPORT_SYMBOL_GPL(irq_sim_fini);
> +EXPORT_SYMBOL_GPL(irq_domain_remove_sim);
>  
> -static void devm_irq_sim_release(struct device *dev, void *res)
> +static void devm_irq_domain_release_sim(struct device *dev, void *res)
>  {
>  	struct irq_sim_devres *this = res;
>  
> -	irq_sim_fini(this->sim);
> +	irq_domain_remove_sim(this->domain);
>  }
>  
>  /**
> - * irq_sim_init - Initialize the interrupt simulator for a managed device.
> + * devm_irq_domain_create_sim - Create a new interrupt simulator for
> + *                              a managed device.
>   *
>   * @dev:        Device to initialize the simulator object for.
> - * @sim:        The interrupt simulator object to initialize.
> + * @fnode:      struct fwnode_handle to be associated with this domain.
>   * @num_irqs:   Number of interrupts to allocate
>   *
> - * On success: return the base of the allocated interrupt range.
> - * On failure: a negative errno.
> + * On success: return a new irq_domain object.
> + * On failure: a negative errno wrapped with ERR_PTR().
>   */
> -int devm_irq_sim_init(struct device *dev, struct irq_sim *sim,
> -		      unsigned int num_irqs)
> +struct irq_domain *devm_irq_domain_create_sim(struct device *dev,
> +					      struct fwnode_handle *fwnode,
> +					      unsigned int num_irqs)
>  {
>  	struct irq_sim_devres *dr;
> -	int rv;
>  
> -	dr = devres_alloc(devm_irq_sim_release, sizeof(*dr), GFP_KERNEL);
> +	dr = devres_alloc(devm_irq_domain_release_sim,
> +			  sizeof(*dr), GFP_KERNEL);
>  	if (!dr)
> -		return -ENOMEM;
> +		return ERR_PTR(-ENOMEM);
>  
> -	rv = irq_sim_init(sim, num_irqs);
> -	if (rv < 0) {
> +	dr->domain = irq_domain_create_sim(fwnode, num_irqs);
> +	if (IS_ERR(dr->domain)) {
>  		devres_free(dr);
> -		return rv;
> +		return dr->domain;
>  	}
>  
> -	dr->sim = sim;
>  	devres_add(dev, dr);
> -
> -	return rv;
> +	return dr->domain;
>  }
> -EXPORT_SYMBOL_GPL(devm_irq_sim_init);
> +EXPORT_SYMBOL_GPL(devm_irq_domain_create_sim);
>  
>  /**
>   * irq_sim_fire - Enqueue an interrupt.
>   *
> - * @sim:        The interrupt simulator object.
> - * @offset:     Offset of the simulated interrupt which should be fired.
> + * @virq:       Virtual interrupt number to fire. It must be associated with
> + *              an existing interrupt simulator.
>   */
> -void irq_sim_fire(struct irq_sim *sim, unsigned int offset)
> +void irq_sim_fire(int virq)
>  {
> -	if (sim->irqs[offset].enabled) {
> -		set_bit(offset, sim->work_ctx.pending);
> -		irq_work_queue(&sim->work_ctx.work);
> +	struct irq_sim_irq_ctx *irq_ctx;
> +	struct irq_data *irqd;
> +
> +	irqd = irq_get_irq_data(virq);
> +	if (!irqd) {
> +		pr_warn_ratelimited("%s: invalid irq number\n", __func__);
> +		return;
>  	}
> -}
> -EXPORT_SYMBOL_GPL(irq_sim_fire);
>  
> -/**
> - * irq_sim_irqnum - Get the allocated number of a dummy interrupt.
> - *
> - * @sim:        The interrupt simulator object.
> - * @offset:     Offset of the simulated interrupt for which to retrieve
> - *              the number.
> - */
> -int irq_sim_irqnum(struct irq_sim *sim, unsigned int offset)
> -{
> -	return sim->irqs[offset].irqnum;
> +	irq_ctx = irq_data_get_irq_chip_data(irqd);
> +
> +	if (irq_ctx->enabled) {
> +		set_bit(irqd_to_hwirq(irqd), irq_ctx->work_ctx->pending);
> +		irq_work_queue(&irq_ctx->work_ctx->work);
> +	}
>  }
> -EXPORT_SYMBOL_GPL(irq_sim_irqnum);
> +EXPORT_SYMBOL_GPL(irq_sim_fire);

