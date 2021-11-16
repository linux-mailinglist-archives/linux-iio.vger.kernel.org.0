Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C45A45385A
	for <lists+linux-iio@lfdr.de>; Tue, 16 Nov 2021 18:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237607AbhKPRRq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Nov 2021 12:17:46 -0500
Received: from mga02.intel.com ([134.134.136.20]:39628 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229509AbhKPRRp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 16 Nov 2021 12:17:45 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10169"; a="220949150"
X-IronPort-AV: E=Sophos;i="5.87,239,1631602800"; 
   d="scan'208";a="220949150"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2021 09:07:45 -0800
X-IronPort-AV: E=Sophos;i="5.87,239,1631602800"; 
   d="scan'208";a="472386445"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2021 09:07:42 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mn1vi-007UvA-3l;
        Tue, 16 Nov 2021 19:07:34 +0200
Date:   Tue, 16 Nov 2021 19:07:33 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, jic23@kernel.org, lars@metafoo.de,
        linux-iio@vger.kernel.org, git@xilinx.com, michal.simek@xilinx.com,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-acpi@vger.kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v9 1/5] device property: Add fwnode_iomap()
Message-ID: <YZPlVfYjXWiOm+Mg@smile.fi.intel.com>
References: <20211116150842.1051-1-anand.ashok.dumbre@xilinx.com>
 <20211116150842.1051-2-anand.ashok.dumbre@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211116150842.1051-2-anand.ashok.dumbre@xilinx.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Nov 16, 2021 at 03:08:38PM +0000, Anand Ashok Dumbre wrote:
> This patch introduces a new helper routine - fwnode_iomap(), which
> allows to map the memory mapped IO for a given device node.
> 
> This implementation does not cover the ACPI case and may be expanded
> in the future. The main purpose here is to be able to develop resource
> provider agnostic drivers.

Thanks! LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

TWIMC I have some ideas about ACPI implementation. Just let this one
settled first.

> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
> ---
>  drivers/base/property.c  | 16 ++++++++++++++++
>  include/linux/property.h |  2 ++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 453918eb7390..d2cca7ffea18 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -1021,6 +1021,22 @@ int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index)
>  }
>  EXPORT_SYMBOL(fwnode_irq_get);
>  
> +/**
> + * fwnode_iomap - Maps the memory mapped IO for a given fwnode
> + * @fwnode:	Pointer to the firmware node
> + * @index:	Index of the IO range
> + *
> + * Returns a pointer to the mapped memory.
> + */
> +void __iomem *fwnode_iomap(struct fwnode_handle *fwnode, int index)
> +{
> +	if (is_of_node(fwnode))
> +		return of_iomap(to_of_node(fwnode), index);
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL(fwnode_iomap);
> +
>  /**
>   * fwnode_graph_get_next_endpoint - Get next endpoint firmware node
>   * @fwnode: Pointer to the parent firmware node
> diff --git a/include/linux/property.h b/include/linux/property.h
> index 357513a977e5..9bb0b0155402 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -121,6 +121,8 @@ void fwnode_handle_put(struct fwnode_handle *fwnode);
>  
>  int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index);
>  
> +void __iomem *fwnode_iomap(struct fwnode_handle *fwnode, int index);
> +
>  unsigned int device_get_child_node_count(struct device *dev);
>  
>  static inline bool device_property_read_bool(struct device *dev,
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko


