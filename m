Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAE93C3BF1
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jul 2021 13:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbhGKLm5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Jul 2021 07:42:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:46518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229688AbhGKLm5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Jul 2021 07:42:57 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 576B861220;
        Sun, 11 Jul 2021 11:40:04 +0000 (UTC)
Date:   Sun, 11 Jul 2021 12:42:20 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-stm32@st-md-mailman.stormreply.com, kernel@pengutronix.de,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de,
        jarkko.nikula@linux.intel.com,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v12 06/17] counter: Internalize sysfs interface code
Message-ID: <20210711124220.0a601741@jic23-huawei>
In-Reply-To: <834dadaa68af74c703f19f8ddcca5512dd1d177e.1625471640.git.vilhelm.gray@gmail.com>
References: <cover.1625471640.git.vilhelm.gray@gmail.com>
        <834dadaa68af74c703f19f8ddcca5512dd1d177e.1625471640.git.vilhelm.gray@gmail.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  5 Jul 2021 17:18:54 +0900
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

Hi William,

There is some type confusion going on in the stm32_lptim driver that should
be cleaned up.

A few other minor things but basically looks good to me so I probably won't
look through this one again for v13 unless some discussion starts!

One to note is that Andy just moved the kstrtoxx definitions to a new header,
so we should include that where they are used going forwards.  Can do that
as a cleanup later though given you probably don't want to rebase this on
a mid merge window state.

Jonathan


> ---

...

> diff --git a/drivers/counter/counter-sysfs.c b/drivers/counter/counter-sysfs.c
> new file mode 100644
> index 000000000000..07588130600a
> --- /dev/null
> +++ b/drivers/counter/counter-sysfs.c


...

> +static ssize_t counter_comp_u8_show(struct device *dev,
> +				    struct device_attribute *attr, char *buf)
> +{
> +	const struct counter_attribute *const a = to_counter_attribute(attr);
> +	struct counter_device *const counter = dev_get_drvdata(dev);
> +	int err;
> +	u8 data = 0;
> +
> +	switch (a->scope) {
> +	case COUNTER_SCOPE_DEVICE:
> +		err = a->comp.device_u8_read(counter, &data);
> +		break;
> +	case COUNTER_SCOPE_SIGNAL:
> +		err = a->comp.signal_u8_read(counter, a->parent, &data);
> +		break;
> +	case COUNTER_SCOPE_COUNT:
> +		err = a->comp.count_u8_read(counter, a->parent, &data);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	if (err < 0)
> +		return err;
> +
> +	if (a->comp.type == COUNTER_COMP_BOOL)
> +		data = !!data;

You have some drivers that do this internally then you replicate it here?
An example is cable_fault in the quad 8.  That is not necessarily a
problem, but perhaps a comment to say this one should be paranoia and
expectation is drivers will deliver 0 or 1.

> +
> +	return sprintf(buf, "%u\n", (unsigned int)data);
> +}
> +


...

> +static int counter_sysfs_attr_add(struct counter_device *const counter,
> +				  struct counter_attribute_group *group)

As below, group is a confusing name, so I'd prefix it with something.

> +{
> +	const enum counter_scope scope = COUNTER_SCOPE_DEVICE;
> +	struct device *const dev = &counter->dev;
> +	int err;
> +	size_t i;
> +
> +	/* Add Signals sysfs attributes */
> +	err = counter_sysfs_signals_add(counter, group);
> +	if (err < 0)
> +		return err;
> +	group += counter->num_signals;
> +
> +	/* Add Counts sysfs attributes */
> +	err = counter_sysfs_counts_add(counter, group);
> +	if (err < 0)
> +		return err;
> +	group += counter->num_counts;
> +
> +	/* Create name attribute */
> +	err = counter_name_attr_create(dev, group, counter->name);
> +	if (err < 0)
> +		return err;
> +
> +	/* Create num_signals attribute */
> +	err = counter_attr_create(dev, group, &counter_num_signals_comp, scope,
> +				  NULL);
> +	if (err < 0)
> +		return err;
> +
> +	/* Create num_counts attribute */
> +	err = counter_attr_create(dev, group, &counter_num_counts_comp, scope,
> +				  NULL);
> +	if (err < 0)
> +		return err;
> +
> +	/* Create an attribute for each extension */
> +	for (i = 0; i < counter->num_ext; i++) {
> +		err = counter_attr_create(dev, group, counter->ext + i, scope,
> +					  NULL);
> +		if (err < 0)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * counter_sysfs_add - Adds Counter sysfs attributes to the device structure
> + * @counter:	Pointer to the Counter device structure
> + *
> + * Counter sysfs attributes are created and added to the respective device
> + * structure for later registration to the system. Resource-managed memory
> + * allocation is performed by this function, and this memory should be freed
> + * when no longer needed (automatically by a device_unregister call, or
> + * manually by a devres_release_all call).
> + */
> +int counter_sysfs_add(struct counter_device *const counter)
> +{
> +	struct device *const dev = &counter->dev;
> +	const size_t num_groups = counter->num_signals + counter->num_counts + 1;
> +	struct counter_attribute_group *groups;

Naming is a bit too similar to 'group' to lead to nice readable code.  Maybe
cattr_groups or something like that?  groups and dev->groups not being the same
thing is definitely confusing!

> +	size_t i, j;
> +	int err;
> +	struct attribute_group *group;
> +	struct counter_attribute *p;
> +
> +	/* Allocate space for attribute groups (signals, counts, and ext) */
> +	groups = devm_kcalloc(dev, num_groups, sizeof(*groups), GFP_KERNEL);
> +	if (!groups)
> +		return -ENOMEM;
> +
> +	/* Initialize attribute lists */
> +	for (i = 0; i < num_groups; i++)
> +		INIT_LIST_HEAD(&groups[i].attr_list);
> +
> +	/* Add Counter device sysfs attributes */
> +	err = counter_sysfs_attr_add(counter, groups);
> +	if (err < 0)
> +		return err;
> +
> +	/* Allocate attribute groups for association with device */
> +	dev->groups = devm_kcalloc(dev, num_groups + 1, sizeof(*dev->groups),
> +				   GFP_KERNEL);
> +	if (!dev->groups)
> +		return -ENOMEM;
> +
> +	/* Prepare each group of attributes for association */
> +	for (i = 0; i < num_groups; i++) {
> +		/* Allocate space for attribute group */
> +		group = devm_kzalloc(dev, sizeof(*group), GFP_KERNEL);
> +		if (!group)
> +			return -ENOMEM;

Slight nitpick, is I'd have been tempted to reduce the number of allocations
by doing this as a single array allocation then use the groups within this
loop.  Really trivial though!

> +		group->name = groups[i].name;
> +
> +		/* Allocate space for attribute pointers */
> +		group->attrs = devm_kcalloc(dev, groups[i].num_attr + 1,
> +					    sizeof(*group->attrs), GFP_KERNEL);
> +		if (!group->attrs)
> +			return -ENOMEM;
> +
> +		/* Add attribute pointers to attribute group */
> +		j = 0;
> +		list_for_each_entry(p, &groups[i].attr_list, l)
> +			group->attrs[j++] = &p->dev_attr.attr;
> +
> +		/* Associate attribute group */
> +		dev->groups[i] = group;
> +	}
> +
> +	return 0;
> +}



...

> diff --git a/drivers/counter/stm32-lptimer-cnt.c b/drivers/counter/stm32-lptimer-cnt.c
> index 13656957c45f..aef78a4217b5 100644
> --- a/drivers/counter/stm32-lptimer-cnt.c
> +++ b/drivers/counter/stm32-lptimer-cnt.c
> @@ -17,6 +17,7 @@
>  #include <linux/module.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
> +#include <linux/types.h>
>  
>  struct stm32_lptim_cnt {
>  	struct counter_device counter;
> @@ -130,32 +131,46 @@ static int stm32_lptim_setup(struct stm32_lptim_cnt *priv, int enable)
>   * +---------+----------+----------+---------+----------+---------+
>   */
>  enum stm32_lptim_cnt_function {
> -	STM32_LPTIM_COUNTER_INCREASE,
> -	STM32_LPTIM_ENCODER_BOTH_EDGE,
> +	STM32_LPTIM_COUNTER_INCREASE = COUNTER_FUNCTION_INCREASE,
> +	STM32_LPTIM_ENCODER_BOTH_EDGE = COUNTER_FUNCTION_QUADRATURE_X4,
>  };
>  
>  static const enum counter_function stm32_lptim_cnt_functions[] = {
> -	[STM32_LPTIM_COUNTER_INCREASE] = COUNTER_FUNCTION_INCREASE,
> -	[STM32_LPTIM_ENCODER_BOTH_EDGE] = COUNTER_FUNCTION_QUADRATURE_X4,
> +	STM32_LPTIM_COUNTER_INCREASE,
> +	STM32_LPTIM_ENCODER_BOTH_EDGE,
>  };
>  
>  enum stm32_lptim_synapse_action {
> +	/* Index must match with stm32_lptim_cnt_polarity[] (priv->polarity) */
>  	STM32_LPTIM_SYNAPSE_ACTION_RISING_EDGE,
>  	STM32_LPTIM_SYNAPSE_ACTION_FALLING_EDGE,
>  	STM32_LPTIM_SYNAPSE_ACTION_BOTH_EDGES,
>  	STM32_LPTIM_SYNAPSE_ACTION_NONE,
>  };
>  
> -static const enum counter_synapse_action stm32_lptim_cnt_synapse_actions[] = {
> -	/* Index must match with stm32_lptim_cnt_polarity[] (priv->polarity) */
> +static const enum stm32_lptim_synapse_action stm32_lptim_c2l_actions_map[] = {
> +	[COUNTER_SYNAPSE_ACTION_RISING_EDGE] = STM32_LPTIM_SYNAPSE_ACTION_RISING_EDGE,
> +	[COUNTER_SYNAPSE_ACTION_FALLING_EDGE] = STM32_LPTIM_SYNAPSE_ACTION_FALLING_EDGE,
> +	[COUNTER_SYNAPSE_ACTION_BOTH_EDGES] = STM32_LPTIM_SYNAPSE_ACTION_BOTH_EDGES,
> +	[COUNTER_SYNAPSE_ACTION_NONE] = STM32_LPTIM_SYNAPSE_ACTION_NONE,
> +};
> +
> +static const enum counter_synapse_action stm32_lptim_l2c_actions_map[] = {
>  	[STM32_LPTIM_SYNAPSE_ACTION_RISING_EDGE] = COUNTER_SYNAPSE_ACTION_RISING_EDGE,
>  	[STM32_LPTIM_SYNAPSE_ACTION_FALLING_EDGE] = COUNTER_SYNAPSE_ACTION_FALLING_EDGE,
>  	[STM32_LPTIM_SYNAPSE_ACTION_BOTH_EDGES] = COUNTER_SYNAPSE_ACTION_BOTH_EDGES,
>  	[STM32_LPTIM_SYNAPSE_ACTION_NONE] = COUNTER_SYNAPSE_ACTION_NONE,
>  };
>  
> +static const enum counter_synapse_action stm32_lptim_cnt_synapse_actions[] = {
> +	COUNTER_SYNAPSE_ACTION_RISING_EDGE,
> +	COUNTER_SYNAPSE_ACTION_FALLING_EDGE,
> +	COUNTER_SYNAPSE_ACTION_BOTH_EDGES,
> +	COUNTER_SYNAPSE_ACTION_NONE,
> +};
> +
>  static int stm32_lptim_cnt_read(struct counter_device *counter,
> -				struct counter_count *count, unsigned long *val)
> +				struct counter_count *count, u64 *val)
>  {
>  	struct stm32_lptim_cnt *const priv = counter->priv;
>  	u32 cnt;
> @@ -170,9 +185,9 @@ static int stm32_lptim_cnt_read(struct counter_device *counter,
>  	return 0;
>  }
>  
> -static int stm32_lptim_cnt_function_get(struct counter_device *counter,
> -					struct counter_count *count,
> -					size_t *function)
> +static int stm32_lptim_cnt_function_read(struct counter_device *counter,
> +					 struct counter_count *count,
> +					 enum counter_function *function)
>  {
>  	struct stm32_lptim_cnt *const priv = counter->priv;
>  
> @@ -189,9 +204,9 @@ static int stm32_lptim_cnt_function_get(struct counter_device *counter,
>  	return -EINVAL;
>  }
>  
> -static int stm32_lptim_cnt_function_set(struct counter_device *counter,
> -					struct counter_count *count,
> -					size_t function)
> +static int stm32_lptim_cnt_function_write(struct counter_device *counter,
> +					  struct counter_count *count,
> +					  enum counter_function function)

As mentioned below, there is a bit of a mess of types here that you should clean up.

>  {
>  	struct stm32_lptim_cnt *const priv = counter->priv;
>  
> @@ -212,9 +227,9 @@ static int stm32_lptim_cnt_function_set(struct counter_device *counter,
>  	}
>  }
>  
> -static ssize_t stm32_lptim_cnt_enable_read(struct counter_device *counter,
> -					   struct counter_count *count,
> -					   void *private, char *buf)
> +static int stm32_lptim_cnt_enable_read(struct counter_device *counter,
> +				       struct counter_count *count,
> +				       u8 *enable)
>  {
>  	struct stm32_lptim_cnt *const priv = counter->priv;
>  	int ret;
> @@ -223,22 +238,18 @@ static ssize_t stm32_lptim_cnt_enable_read(struct counter_device *counter,
>  	if (ret < 0)
>  		return ret;
>  
> -	return scnprintf(buf, PAGE_SIZE, "%u\n", ret);
> +	*enable = ret;
> +
> +	return 0;
>  }
>  
> -static ssize_t stm32_lptim_cnt_enable_write(struct counter_device *counter,
> -					    struct counter_count *count,
> -					    void *private,
> -					    const char *buf, size_t len)
> +static int stm32_lptim_cnt_enable_write(struct counter_device *counter,
> +					struct counter_count *count,
> +					u8 enable)
>  {
>  	struct stm32_lptim_cnt *const priv = counter->priv;
> -	bool enable;
>  	int ret;
>  
> -	ret = kstrtobool(buf, &enable);
> -	if (ret)
> -		return ret;
> -
>  	/* Check nobody uses the timer, or already disabled/enabled */
>  	ret = stm32_lptim_is_enabled(priv);
>  	if ((ret < 0) || (!ret && !enable))
> @@ -254,65 +265,54 @@ static ssize_t stm32_lptim_cnt_enable_write(struct counter_device *counter,
>  	if (ret)
>  		return ret;
>  
> -	return len;
> +	return 0;
>  }
>  
> -static ssize_t stm32_lptim_cnt_ceiling_read(struct counter_device *counter,
> -					    struct counter_count *count,
> -					    void *private, char *buf)
> +static int stm32_lptim_cnt_ceiling_read(struct counter_device *counter,
> +					struct counter_count *count,
> +					u64 *ceiling)
>  {
>  	struct stm32_lptim_cnt *const priv = counter->priv;
>  
> -	return snprintf(buf, PAGE_SIZE, "%u\n", priv->ceiling);
> +	*ceiling = priv->ceiling;
> +
> +	return 0;
>  }
>  
> -static ssize_t stm32_lptim_cnt_ceiling_write(struct counter_device *counter,
> -					     struct counter_count *count,
> -					     void *private,
> -					     const char *buf, size_t len)
> +static int stm32_lptim_cnt_ceiling_write(struct counter_device *counter,
> +					 struct counter_count *count,
> +					 u64 ceiling)
>  {
>  	struct stm32_lptim_cnt *const priv = counter->priv;
> -	unsigned int ceiling;
> -	int ret;
>  
>  	if (stm32_lptim_is_enabled(priv))
>  		return -EBUSY;
>  
> -	ret = kstrtouint(buf, 0, &ceiling);
> -	if (ret)
> -		return ret;
> -
>  	if (ceiling > STM32_LPTIM_MAX_ARR)
>  		return -ERANGE;
>  
>  	priv->ceiling = ceiling;
>  
> -	return len;
> +	return 0;
>  }
>  
> -static const struct counter_count_ext stm32_lptim_cnt_ext[] = {
> -	{
> -		.name = "enable",
> -		.read = stm32_lptim_cnt_enable_read,
> -		.write = stm32_lptim_cnt_enable_write
> -	},
> -	{
> -		.name = "ceiling",
> -		.read = stm32_lptim_cnt_ceiling_read,
> -		.write = stm32_lptim_cnt_ceiling_write
> -	},
> +static struct counter_comp stm32_lptim_cnt_ext[] = {
> +	COUNTER_COMP_ENABLE(stm32_lptim_cnt_enable_read,
> +			    stm32_lptim_cnt_enable_write),
> +	COUNTER_COMP_CEILING(stm32_lptim_cnt_ceiling_read,
> +			     stm32_lptim_cnt_ceiling_write),
>  };
>  
> -static int stm32_lptim_cnt_action_get(struct counter_device *counter,
> -				      struct counter_count *count,
> -				      struct counter_synapse *synapse,
> -				      size_t *action)
> +static int stm32_lptim_cnt_action_read(struct counter_device *counter,
> +				       struct counter_count *count,
> +				       struct counter_synapse *synapse,
> +				       enum counter_synapse_action *action)
>  {
>  	struct stm32_lptim_cnt *const priv = counter->priv;
> -	size_t function;
> +	enum counter_function function;
>  	int err;
>  
> -	err = stm32_lptim_cnt_function_get(counter, count, &function);
> +	err = stm32_lptim_cnt_function_read(counter, count, &function);
>  	if (err)
>  		return err;
>  
> @@ -320,12 +320,12 @@ static int stm32_lptim_cnt_action_get(struct counter_device *counter,
>  	case STM32_LPTIM_COUNTER_INCREASE:
>  		/* LP Timer acts as up-counter on input 1 */
>  		if (synapse->signal->id == count->synapses[0].signal->id)
> -			*action = priv->polarity;
> +			*action = stm32_lptim_l2c_actions_map[priv->polarity];
>  		else
> -			*action = STM32_LPTIM_SYNAPSE_ACTION_NONE;
> +			*action = COUNTER_SYNAPSE_ACTION_NONE;
>  		return 0;
>  	case STM32_LPTIM_ENCODER_BOTH_EDGE:
> -		*action = priv->polarity;
> +		*action = stm32_lptim_l2c_actions_map[priv->polarity];
>  		return 0;
>  	default:
>  		/* should never reach this path */
> @@ -333,43 +333,39 @@ static int stm32_lptim_cnt_action_get(struct counter_device *counter,
>  	}
>  }
>  
> -static int stm32_lptim_cnt_action_set(struct counter_device *counter,
> -				      struct counter_count *count,
> -				      struct counter_synapse *synapse,
> -				      size_t action)
> +static int stm32_lptim_cnt_action_write(struct counter_device *counter,
> +					struct counter_count *count,
> +					struct counter_synapse *synapse,
> +					enum counter_synapse_action action)
>  {
>  	struct stm32_lptim_cnt *const priv = counter->priv;
> -	size_t function;
> +	enum counter_function function;
>  	int err;
>  
>  	if (stm32_lptim_is_enabled(priv))
>  		return -EBUSY;
>  
> -	err = stm32_lptim_cnt_function_get(counter, count, &function);
> +	err = stm32_lptim_cnt_function_read(counter, count, &function);
>  	if (err)
>  		return err;
>  
>  	/* only set polarity when in counter mode (on input 1) */
> -	if (function == STM32_LPTIM_COUNTER_INCREASE
> -	    && synapse->signal->id == count->synapses[0].signal->id) {
> -		switch (action) {
> -		case STM32_LPTIM_SYNAPSE_ACTION_RISING_EDGE:
> -		case STM32_LPTIM_SYNAPSE_ACTION_FALLING_EDGE:
> -		case STM32_LPTIM_SYNAPSE_ACTION_BOTH_EDGES:
> -			priv->polarity = action;
> -			return 0;
> -		}
> -	}
> +	if ((enum stm32_lptim_cnt_function)function != STM32_LPTIM_COUNTER_INCREASE

This bothers me a little. Why are you casting from enum counter_function to enum stm32_lptim_cnt_function?
That function is indeed putting an enum stm32_lptim_cnt_function into function and it really shouldn't
be.  Whilst the values of the enums are the same, it would be better to have explicit item by
item conversion if that's necessary.  I 'think' you can just get rid of the
enum stm32_lptim_cnt_function though and use the counter one throughout the driver.

If you want to keep changes minimal, put a conversion function in place.

> +	    || synapse->signal->id != count->synapses[0].signal->id
> +	    || action == COUNTER_SYNAPSE_ACTION_NONE)
> +		return -EINVAL;
>  
> -	return -EINVAL;
> +	priv->polarity = stm32_lptim_c2l_actions_map[action];
> +
> +	return 0;
>  }
>  
>  static const struct counter_ops stm32_lptim_cnt_ops = {
>  	.count_read = stm32_lptim_cnt_read,
> -	.function_get = stm32_lptim_cnt_function_get,
> -	.function_set = stm32_lptim_cnt_function_set,
> -	.action_get = stm32_lptim_cnt_action_get,
> -	.action_set = stm32_lptim_cnt_action_set,
> +	.function_read = stm32_lptim_cnt_function_read,
> +	.function_write = stm32_lptim_cnt_function_write,
> +	.action_read = stm32_lptim_cnt_action_read,
> +	.action_write = stm32_lptim_cnt_action_write,
>  };
>  
>  static struct counter_signal stm32_lptim_cnt_signals[] = {

