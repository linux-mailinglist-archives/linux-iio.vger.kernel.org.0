Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0DD645D979
	for <lists+linux-iio@lfdr.de>; Thu, 25 Nov 2021 12:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238139AbhKYLrf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 25 Nov 2021 06:47:35 -0500
Received: from mga07.intel.com ([134.134.136.100]:58135 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234439AbhKYLpf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 25 Nov 2021 06:45:35 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10178"; a="298907558"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="298907558"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 03:42:23 -0800
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="457839555"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 03:42:20 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mqD8r-00AQ6Z-QG;
        Thu, 25 Nov 2021 13:42:17 +0200
Date:   Thu, 25 Nov 2021 13:42:17 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, jic23@kernel.org, lars@metafoo.de,
        linux-iio@vger.kernel.org, git@xilinx.com, michal.simek@xilinx.com,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-acpi@vger.kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v11 1/5] device property: Add fwnode_iomap()
Message-ID: <YZ92mTURrFWZPUXp@smile.fi.intel.com>
References: <20211124225407.17793-1-anand.ashok.dumbre@xilinx.com>
 <20211124225407.17793-2-anand.ashok.dumbre@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124225407.17793-2-anand.ashok.dumbre@xilinx.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Nov 24, 2021 at 10:54:03PM +0000, Anand Ashok Dumbre wrote:
> This patch introduces a new helper routine - fwnode_iomap(), which
> allows to map the memory mapped IO for a given device node.
> 
> This implementation does not cover the ACPI case and may be expanded
> in the future. The main purpose here is to be able to develop resource
> provider agnostic drivers.

...

> +void __iomem *fwnode_iomap(struct fwnode_handle *fwnode, int index)
> +{

> +	if (is_of_node(fwnode))
> +		return of_iomap(to_of_node(fwnode), index);

It seems this part should be wrapped in some ifdeffery according to kbuild bot
report.

> +	return NULL;
> +}
> +EXPORT_SYMBOL(fwnode_iomap);

-- 
With Best Regards,
Andy Shevchenko


