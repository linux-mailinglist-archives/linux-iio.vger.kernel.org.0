Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8665452EB7
	for <lists+linux-iio@lfdr.de>; Tue, 16 Nov 2021 11:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbhKPKMr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Nov 2021 05:12:47 -0500
Received: from mga04.intel.com ([192.55.52.120]:27172 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233836AbhKPKMo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 16 Nov 2021 05:12:44 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10169"; a="232384891"
X-IronPort-AV: E=Sophos;i="5.87,238,1631602800"; 
   d="scan'208";a="232384891"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2021 02:09:46 -0800
X-IronPort-AV: E=Sophos;i="5.87,238,1631602800"; 
   d="scan'208";a="494403820"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2021 02:09:43 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mmvPD-007NgD-HR;
        Tue, 16 Nov 2021 12:09:35 +0200
Date:   Tue, 16 Nov 2021 12:09:35 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, jic23@kernel.org, lars@metafoo.de,
        linux-iio@vger.kernel.org, git@xilinx.com, michal.simek@xilinx.com,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-acpi@vger.kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH] device property: Add fwnode_iomap()
Message-ID: <YZODX7TxrbbzWwVr@smile.fi.intel.com>
References: <20211115173819.22778-1-anand.ashok.dumbre@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115173819.22778-1-anand.ashok.dumbre@xilinx.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Nov 15, 2021 at 05:38:19PM +0000, Anand Ashok Dumbre wrote:

Sorry that I was probably not clear about how to sent this and Greg is
absolutely right. Make this the first patch in your series.

> This patch introduces a new helper routine - fwnode_iomap(),
> which allows to map the memory mapped IO for a given device node.

This needs additional things:

- explanation that for now it doesn't cover ACPI case and it may be expanded
  to cover it in the future, hence the main purpose is to get possible to
  develop resource provider agnostic drivers

- Suggested-by tag

-- 
With Best Regards,
Andy Shevchenko


