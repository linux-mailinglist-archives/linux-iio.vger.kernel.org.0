Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2817C4538D7
	for <lists+linux-iio@lfdr.de>; Tue, 16 Nov 2021 18:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239087AbhKPRyg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Nov 2021 12:54:36 -0500
Received: from mga05.intel.com ([192.55.52.43]:7722 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234261AbhKPRyg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 16 Nov 2021 12:54:36 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10170"; a="319982713"
X-IronPort-AV: E=Sophos;i="5.87,239,1631602800"; 
   d="scan'208";a="319982713"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2021 09:41:59 -0800
X-IronPort-AV: E=Sophos;i="5.87,239,1631602800"; 
   d="scan'208";a="472406108"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2021 09:41:55 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mn2Sp-007VN0-VA;
        Tue, 16 Nov 2021 19:41:47 +0200
Date:   Tue, 16 Nov 2021 19:41:47 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, jic23@kernel.org, lars@metafoo.de,
        linux-iio@vger.kernel.org, git@xilinx.com, michal.simek@xilinx.com,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-acpi@vger.kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v9 5/5] MAINTAINERS: Add maintainer for xilinx-ams
Message-ID: <YZPtW5igA8RBYLWv@smile.fi.intel.com>
References: <20211116150842.1051-1-anand.ashok.dumbre@xilinx.com>
 <20211116150842.1051-6-anand.ashok.dumbre@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211116150842.1051-6-anand.ashok.dumbre@xilinx.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Nov 16, 2021 at 03:08:42PM +0000, Anand Ashok Dumbre wrote:
> Add maintaner entry for xilinx-ams driver.

Have you run checkpatch?

>  S:	Maintained
>  F:	drivers/net/ethernet/xilinx/xilinx_axienet*

X...


> +XILINX AMS DRIVER

M...

> +M:	Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
> +F:	drivers/iio/adc/xilinx-ams.c

-- 
With Best Regards,
Andy Shevchenko


