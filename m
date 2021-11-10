Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E7144BD5A
	for <lists+linux-iio@lfdr.de>; Wed, 10 Nov 2021 09:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbhKJI4K (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 Nov 2021 03:56:10 -0500
Received: from mga03.intel.com ([134.134.136.65]:42422 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229919AbhKJI4G (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 10 Nov 2021 03:56:06 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10163"; a="232575566"
X-IronPort-AV: E=Sophos;i="5.87,223,1631602800"; 
   d="scan'208";a="232575566"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 00:53:19 -0800
X-IronPort-AV: E=Sophos;i="5.87,223,1631602800"; 
   d="scan'208";a="533982079"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 00:53:16 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mkjLs-005MHd-HB;
        Wed, 10 Nov 2021 10:53:04 +0200
Date:   Wed, 10 Nov 2021 10:53:04 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        heikki.krogerus@linux.intel.com, kuba@kernel.org,
        saravanak@google.com, linux-kernel@vger.kernel.org,
        lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/2] device property: Add fwnode_irq_get_byname()
Message-ID: <YYuIcPLx0uoUZ88B@smile.fi.intel.com>
References: <20211109200840.135019-1-puranjay12@gmail.com>
 <20211109200840.135019-2-puranjay12@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109200840.135019-2-puranjay12@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Nov 10, 2021 at 01:38:39AM +0530, Puranjay Mohan wrote:
> The fwnode framework did not have means to obtain the IRQ number from
> the name of a node.
> Add that now, in form of the fwnode_irq_get_byname() function.

...

> +int fwnode_irq_get_byname(struct fwnode_handle *fwnode, const char *name)
> +{
> +	int index;
> +
> +	if (unlikely(!name))
> +		return -EINVAL;

> +	index = fwnode_property_match_string(fwnode, "interrupt-names", name);
> +	if (index < 0)
> +		return index;

It won't work like this. The ACPI table quite likely won't have this in them.
Also it doesn't cover the GPIO interrupts in ACPI case.

> +	return fwnode_irq_get(fwnode, index);

Neither this covers GPIO IRQs.

> +}
> +EXPORT_SYMBOL(fwnode_irq_get_byname);

So, first you need to provide a design for this how ACPI cases can be handled.

Imagine these cases (at least) for _CRS method in ACPI:
  1/ Single GSI

	Interrupt()

  2/ Single GPIO IRQ

	GpioInt()

  3/ Both in different orders
    a)
	Interrupt()
	GpioInt()

    b)
	GpioInt()
	Interrupt()

  4/ Mixed (complicated cases)

	Interrupt()
	Interrupt()
	GpioInt()
	Interrupt()
	GpioInt()

Obvious question, what does the index mean in all these cases?

Next one is, how can we quirk out the platforms with the old ACPI tables
where no properties are provided? For GPIO there is struct acpi_gpio_params
which goes deep into ACPI glue layer.

Luckily, the GPIO IRQ case has already available APIs for indexing and naming
match: acpi_dev_gpio_irq_get_by().

Hence, the main task is to define index in cases like 4 and see what can be
done for the GSI cases.

-- 
With Best Regards,
Andy Shevchenko


