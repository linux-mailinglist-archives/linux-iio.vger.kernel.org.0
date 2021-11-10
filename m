Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAF9744BCF1
	for <lists+linux-iio@lfdr.de>; Wed, 10 Nov 2021 09:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhKJIf5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 Nov 2021 03:35:57 -0500
Received: from mga12.intel.com ([192.55.52.136]:8725 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229831AbhKJIf5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 10 Nov 2021 03:35:57 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10163"; a="212653576"
X-IronPort-AV: E=Sophos;i="5.87,223,1631602800"; 
   d="scan'208";a="212653576"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 00:33:09 -0800
X-IronPort-AV: E=Sophos;i="5.87,223,1631602800"; 
   d="scan'208";a="669719835"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 00:33:06 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mkj2M-005Lwm-LZ;
        Wed, 10 Nov 2021 10:32:54 +0200
Date:   Wed, 10 Nov 2021 10:32:54 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        heikki.krogerus@linux.intel.com, kuba@kernel.org,
        saravanak@google.com, linux-kernel@vger.kernel.org,
        lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 0/2] device property: Adding fwnode_irq_get_byname()
Message-ID: <YYuDtjVnZS8SBVqE@smile.fi.intel.com>
References: <20211109200840.135019-1-puranjay12@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109200840.135019-1-puranjay12@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Nov 10, 2021 at 01:38:38AM +0530, Puranjay Mohan wrote:
> The first patch in this series adds the fwnode_irq_get_byname() which is
> the generic version of the of_irq_get_byname(). It is used to get the
> IRQ number from name of the interrupt.
> 
> The second patch in this series uses the fwnode_irq_get_byname()
> function in the IIO driver of the ADXL355 accelerometer. The driver has
> been tested after applying this patch on a Raspberry PI. The ADXL355 was
> connected to the Raspberry Pi using I2C and fwnode_irq_get_byname() was
> used to get the IRQ number for the "DRDY" interrupt. Earlier this driver
> was using of_irq_get_byname() to get this IRQ number.

This is marked as v2, can we have a link / changelog from v1, please?

-- 
With Best Regards,
Andy Shevchenko


