Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3080A1A4F3D
	for <lists+linux-iio@lfdr.de>; Sat, 11 Apr 2020 11:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbgDKJ6x (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 Apr 2020 05:58:53 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:47283 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgDKJ6w (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Apr 2020 05:58:52 -0400
Received: from kb-xps (unknown [78.193.40.249])
        (Authenticated sender: kamel.bouhara@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id F0911200007;
        Sat, 11 Apr 2020 09:58:48 +0000 (UTC)
Date:   Sat, 11 Apr 2020 11:58:47 +0200
From:   Kamel Bouhara <kamel.bouhara@bootlin.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/3] counter: add an inkernel API
Message-ID: <20200411095847.GA161090@kb-xps>
References: <20200406155806.1295169-1-kamel.bouhara@bootlin.com>
 <20200406155806.1295169-2-kamel.bouhara@bootlin.com>
 <7651ea0d-91c2-49db-9af7-b01a78868d7e@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7651ea0d-91c2-49db-9af7-b01a78868d7e@infradead.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Apr 10, 2020 at 10:34:34AM -0700, Randy Dunlap wrote:
> Hi--
>

Hello,

> On 4/6/20 8:58 AM, Kamel Bouhara wrote:
> > ---
> >  drivers/counter/counter.c | 213 ++++++++++++++++++++++++++++++++++++++
> >  include/linux/counter.h   |  27 +++++
> >  2 files changed, 240 insertions(+)
> >
> > diff --git a/drivers/counter/counter.c b/drivers/counter/counter.c
> > index 6a683d086008..f81d2d1dbca7 100644
> > --- a/drivers/counter/counter.c
> > +++ b/drivers/counter/counter.c
>
> [snip]
>
> Please use
> /**
> on these functions so that kernel-doc will process them.
>

OK, fixed.

Thanks.

> > +
> > +/*
> > + * devm_counter_get - Obtain an exclusive access to a counter.
> > + * @dev: device for counter "consumer"
> > + *
> > + * Returns a struct counter_device matching the counter producer, or
> > + * IS_ERR() condition containing errno.
> > + *
> > + */
> > +struct counter_device *devm_counter_get(struct device *dev)
> > +{
> > +	struct counter_device **ptr, *counter;
> > +
> > +	ptr = devres_alloc(devm_counter_release, sizeof(*ptr), GFP_KERNEL);
> > +	if (!ptr)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	counter = counter_get(dev);
> > +	if (IS_ERR(counter)) {
> > +		devres_free(ptr);
> > +		return counter;
> > +	}
> > +
> > +	*ptr = counter;
> > +	devres_add(dev, ptr);
> > +
> > +	return counter;
> > +}
> > +EXPORT_SYMBOL_GPL(devm_counter_get);
> > +
> > +/*
> > + * counter_action_get - get counter synapse mode
> > + * @counter: counter device to operate with
> > + * @action: pointer to store the current counter synapse mode
>
> should be @mode: ^^^^^
>

Fixed.

Thanks.

Kamel

> > + * returns:
> > + *	0 on success, error code on failure.
> > + */
> > +int counter_action_get(struct counter_device *counter, int *mode)
> > +{
> > +	struct counter_synapse *synapse = counter->counts->synapses;
> > +	size_t action_index;
> > +	int err;
> > +
> > +	err = counter->ops->action_get(counter, counter->counts, synapse,
> > +				       &action_index);
> > +	if (err)
> > +		return err;
> > +
> > +	*mode = synapse->actions_list[action_index];
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(counter_action_get);
> > +
> > +/*
> > + * counter_action_set - set counter device synapse
> > + * @counter: counter device to operate with
> > + * @action: enum of the synapse mode
> > + * returns:
> > + *	0 on success, error code on failure.
> > + */
> > +int counter_action_set(struct counter_device *counter,
> > +		       enum counter_synapse_action action)
> > +{
> > +	struct counter_synapse *synapse = counter->counts->synapses;
> > +	const size_t num_actions = synapse->num_actions;
> > +	size_t action_index;
> > +
> > +	/* Find requested action mode */
> > +	for (action_index = 0; action_index < num_actions; action_index++) {
> > +		if (action == synapse->actions_list[action_index])
> > +			break;
> > +	}
> > +
> > +	if (action_index >= num_actions)
> > +		return -EINVAL;
> > +
> > +	return counter->ops->action_set(counter, counter->counts, synapse,
> > +					action_index);
> > +}
> > +EXPORT_SYMBOL_GPL(counter_action_set);
> > +
> > +/*
> > + * counter_function_get - get the count function
> > + * @counter: pointer to counter device to operate with
> > + * @mode: pointer to store the current counter function mode
> > + * returns:
> > + *	0 on success, error code on failure.
> > + */
> > +int counter_function_get(struct counter_device *counter, int *mode)
> > +{
> > +	size_t func_index;
> > +	int err;
> > +
> > +	err = counter->ops->function_get(counter, counter->counts,
> > +					 &func_index);
> > +	if (err)
> > +		return err;
> > +
> > +	*mode = counter->counts->functions_list[func_index];
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(counter_function_get);
> > +
> > +/*
> > + * counter_function_set - set a count function
> > + * @counter: pointer to a counter device to operate with
> > + * @function: enum of the function mode
> > + * returns:
> > + *	0 on success, error code on failure.
> > + */
> > +int counter_function_set(struct counter_device *counter,
> > +			  enum counter_count_function function)
> > +{
> > +	const size_t num_functions = counter->counts->num_functions;
> > +	size_t func_index;
> > +
> > +	for (func_index = 0; func_index < num_functions; func_index++) {
> > +		if (function == counter->counts->functions_list[func_index])
> > +			break;
> > +	}
> > +
> > +	if (func_index >= num_functions)
> > +		return -EINVAL;
> > +
> > +	return counter->ops->function_set(counter, counter->counts, func_index);
> > +}
> > +EXPORT_SYMBOL_GPL(counter_function_set);
> > +
> > +/*
> > + * counter_count_set - set a count value
> > + * @counter: pointer to the counter device to operate with
> > + * @val: count value to write into the counter
> > + * @len: length of the value written to the counter
> > + * returns:
> > + *	bytes length of the value on success, error code on failure.
> > + */
> > +size_t counter_count_set(struct counter_device *counter,
> > +			 unsigned long val, size_t len)
> > +{
> > +	return counter->ops->count_write(counter, counter->counts, val);
> > +}
> > +EXPORT_SYMBOL_GPL(counter_count_set);
> > +
> > +/*
> > + * counter_count_get - read the count value
> > + * @counter: pointer to the counter device to operate with
> > + * @val: pointer to store the count value
> > + * returns:
> > + *  0 on success, error code on failure.
> > + */
> > +int counter_count_get(struct counter_device *counter, unsigned long *val)
> > +{
> > +	return counter->ops->count_read(counter, counter->counts, val);
> > +}
> > +EXPORT_SYMBOL_GPL(counter_count_get);
> > +
> >  /**
> >   * devm_counter_unregister - Resource-managed counter_unregister
> >   * @dev:	device this counter_device belongs to
>
>
> thanks.
> --
> ~Randy
>

--
Kamel Bouhara, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
