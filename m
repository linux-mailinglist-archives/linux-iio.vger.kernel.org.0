Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F14B4515B6
	for <lists+linux-iio@lfdr.de>; Mon, 15 Nov 2021 21:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239827AbhKOUtw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Nov 2021 15:49:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:45398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345099AbhKOT0Z (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 15 Nov 2021 14:26:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E4A5263719;
        Mon, 15 Nov 2021 19:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637003418;
        bh=BwxPc7c1wjSTV7MEv9Nn62AA4PzI2jDHLDTmxs6KIlY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MwKQvLq/bLruM69kjCboNLIJbH4xE+WX97Xf0CWg7+iTgFZiBVsUw3wx76Lh9iNiq
         bh4JG+W97lwQa+yLvG7aKhwpLS9EC0r/VQXLd6qJ+bWIp67GMi20vYfJXzD2nnyFv7
         CLz/L23z3BeaLAdrx6uy3taxBnFj4lman52AZhnA=
Date:   Mon, 15 Nov 2021 19:08:36 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, jic23@kernel.org, lars@metafoo.de,
        linux-iio@vger.kernel.org, git@xilinx.com, michal.simek@xilinx.com,
        rafael@kernel.org, linux-acpi@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH] device property: Add fwnode_iomap()
Message-ID: <YZKiJFpSU8kIK6Tq@kroah.com>
References: <20211115173819.22778-1-anand.ashok.dumbre@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115173819.22778-1-anand.ashok.dumbre@xilinx.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Nov 15, 2021 at 05:38:19PM +0000, Anand Ashok Dumbre wrote:
> This patch introduces a new helper routine - fwnode_iomap(),
> which allows to map the memory mapped IO for a given device node.
> 
> Signed-off-by: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
> ---
>  drivers/base/property.c  | 15 +++++++++++++++
>  include/linux/property.h |  2 ++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 453918eb7390..9323e9b5de02 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -1021,6 +1021,21 @@ int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index)
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
> +void __iomem *fwnode_iomap(struct fwnode_handle *fwnode, int index) {
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

Also, always run scripts/checkpatch.pl before sending patches out so you
do not get grumpy maintainers telling you to run scripts/checkpatch.pl
on your patches :)

thanks,

greg k-h
