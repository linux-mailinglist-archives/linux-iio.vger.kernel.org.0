Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB3D28C70C
	for <lists+linux-iio@lfdr.de>; Tue, 13 Oct 2020 04:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbgJMCPI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Oct 2020 22:15:08 -0400
Received: from vern.gendns.com ([98.142.107.122]:42282 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728583AbgJMCPI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 12 Oct 2020 22:15:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tcBt+ZIFfdDG4AQrVc2/3STIm09DLsIpLLHUc03KQmk=; b=uZ8bO3MitNYLQDhEGVXRN1alnp
        cfxhK2rk+QF79YZoRRN+QcFmlxTXGp+H/gBHkzVlFMeRqhKln5gNLewKVfUxZ59tKHvh3J6Jzj0LY
        tlTdYrMsy7KJ32EXIELCCruQORaOvw5gLucJyBxdguc546Z2w245jwUvgjwrgG3rYdYYbT1hxceJz
        KGkhjLgQSRUEd55TYsZBpz8Y9dGkfEFoqBhXx7QO40AEwmU8d3pKonatBi0V0O07SeZ9Zzq/SGkbr
        30/3vk41qZBtA5Jpwcm86hbsWpoQSPB0U44RcL1P20sFZftxctg0NuCzpSHoo6mc7wPrHXAmLDZzn
        +eF9Cdjw==;
Received: from [2600:1700:4830:165f::19e] (port=58328)
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <david@lechnology.com>)
        id 1kS9qA-0007FQ-KP; Mon, 12 Oct 2020 22:15:02 -0400
Subject: Re: [PATCH v5 1/5] counter: Internalize sysfs interface code
To:     William Breathitt Gray <vilhelm.gray@gmail.com>, jic23@kernel.org
Cc:     kamel.bouhara@bootlin.com, gwendal@chromium.org,
        alexandre.belloni@bootlin.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
References: <cover.1601170670.git.vilhelm.gray@gmail.com>
 <e38f6dc3a08bf2510034334262776a6ed1df8b89.1601170670.git.vilhelm.gray@gmail.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <157d1edf-feec-33b5-7ad5-94f99316ca6e@lechnology.com>
Date:   Mon, 12 Oct 2020 21:15:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e38f6dc3a08bf2510034334262776a6ed1df8b89.1601170670.git.vilhelm.gray@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 9/26/20 9:18 PM, William Breathitt Gray wrote:
> This is a reimplementation of the Generic Counter driver interface.

I'll follow up if I find any problems while testing but here are some
comments I had from looking over the patch.

> diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-core.c
> new file mode 100644
> index 000000000000..987c6e8277eb
> --- /dev/null
> +++ b/drivers/counter/counter-core.c


> +/**
> + * counter_register - register Counter to the system
> + * @counter:	pointer to Counter to register
> + *
> + * This function registers a Counter to the system. A sysfs "counter" directory
> + * will be created and populated with sysfs attributes correlating with the
> + * Counter Signals, Synapses, and Counts respectively.
> + */
> +int counter_register(struct counter_device *const counter)
> +{
> +	struct device *const dev = &counter->dev;
> +	int err;
> +
> +	/* Acquire unique ID */
> +	counter->id = ida_simple_get(&counter_ida, 0, 0, GFP_KERNEL);
> +	if (counter->id < 0)
> +		return counter->id;
> +
> +	/* Configure device structure for Counter */
> +	dev->type = &counter_device_type;
> +	dev->bus = &counter_bus_type;
> +	if (counter->parent) {
> +		dev->parent = counter->parent;
> +		dev->of_node = counter->parent->of_node;
> +	}
> +	dev_set_name(dev, "counter%d", counter->id);
> +	device_initialize(dev);> +	dev_set_drvdata(dev, counter);
> +
> +	/* Add Counter sysfs attributes */
> +	err = counter_sysfs_add(counter);
> +	if (err)
> +		goto err_free_id;
> +
> +	/* Add device to system */
> +	err = device_add(dev);
> +	if (err) {
> +		put_device(dev);
> +		goto err_free_id;
> +	}
> +
> +	return 0;
> +
> +err_free_id:
> +	/* get_device/put_device combo used to free managed resources */
> +	get_device(dev);
> +	put_device(dev);

I've never seen this in a driver before, so it makes me think this is
not the "right way" to do this. After device_initialize() is called, we
already should have a reference to dev, so only device_put() is needed.


> +	ida_simple_remove(&counter_ida, counter->id);

In the case of error after device_initialize() is called, won't this
result in ida_simple_remove() being called twice, once here and once in
the release callback?

> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(counter_register);
> +
> +/**
> + * counter_unregister - unregister Counter from the system
> + * @counter:	pointer to Counter to unregister
> + *
> + * The Counter is unregistered from the system; all allocated memory is freed.
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
> +static void devm_counter_unreg(struct device *dev, void *res)

To be consistent, it would be nice to spell out unregister.

> +{
> +	counter_unregister(*(struct counter_device **)res);
> +}
> +

> diff --git a/drivers/counter/counter-sysfs.c b/drivers/counter/counter-sysfs.c
> new file mode 100644
> index 000000000000..e66ed99dd5ea
> --- /dev/null
> +++ b/drivers/counter/counter-sysfs.c

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
> +	const size_t num_groups = counter->num_signals + counter->num_counts +
> +				  1;

It is OK to go past 80 columns, especially for just for a few characters.

> +	struct counter_attribute_group *groups;
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
> +	/* Register Counter device attributes */
> +	err = counter_device_register(counter, groups);

This function name is a bit misleading. At first I though we were registering
a new counter device (struct device). Maybe counter_sysfs_create_attrs()
would be a better name? (I wouldn't mind having all functions in this
file having a "counter_sysfs_" prefix for that matter.)


> diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
> index 1ff07faef27f..938085dead80 100644
> --- a/drivers/counter/ti-eqep.c
> +++ b/drivers/counter/ti-eqep.c


> @@ -406,7 +414,7 @@ static int ti_eqep_probe(struct platform_device *pdev)
>   
>   	priv->counter.name = dev_name(dev);
>   	priv->counter.parent = dev;
> -	priv->counter.ops = &ti_eqep_counter_ops;
> +	priv->counter.parent = &ti_eqep_counter_ops;
>   	priv->counter.counts = ti_eqep_counts;
>   	priv->counter.num_counts = ARRAY_SIZE(ti_eqep_counts);
>   	priv->counter.signals = ti_eqep_signals;

This looks like an unintentional change and causes a compile error.

> diff --git a/include/linux/counter.h b/include/linux/counter.h
> index 9dbd5df4cd34..132bfecca5c3 100644
> --- a/include/linux/counter.h
> +++ b/include/linux/counter.h
> @@ -6,417 +6,195 @@
>   #ifndef _COUNTER_H_
>   #define _COUNTER_H_
>   
> -#include <linux/counter_enum.h>
>   #include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>

struct list_head is defined in linux/types.h. Is there something else
we are using from linux/list.h in this file?

>   #include <linux/types.h>
>   


It would be helpful to have kernel doc comments on everything in this file.

