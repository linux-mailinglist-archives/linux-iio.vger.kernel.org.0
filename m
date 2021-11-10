Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 324E544C5F0
	for <lists+linux-iio@lfdr.de>; Wed, 10 Nov 2021 18:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbhKJRaK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 Nov 2021 12:30:10 -0500
Received: from mga17.intel.com ([192.55.52.151]:50243 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230230AbhKJRaK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 10 Nov 2021 12:30:10 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10164"; a="213446698"
X-IronPort-AV: E=Sophos;i="5.87,224,1631602800"; 
   d="scan'208";a="213446698"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 09:27:18 -0800
X-IronPort-AV: E=Sophos;i="5.87,224,1631602800"; 
   d="scan'208";a="602279130"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 09:27:15 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mkrNH-005UQG-Ii;
        Wed, 10 Nov 2021 19:27:03 +0200
Date:   Wed, 10 Nov 2021 19:27:03 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, rafael@kernel.org,
        heikki.krogerus@linux.intel.com, kuba@kernel.org,
        saravanak@google.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] device property: Add fwnode_irq_get_byname()
Message-ID: <YYwA5/8Zoq6BT29P@smile.fi.intel.com>
References: <20211109200840.135019-1-puranjay12@gmail.com>
 <20211109200840.135019-2-puranjay12@gmail.com>
 <YYuIcPLx0uoUZ88B@smile.fi.intel.com>
 <CANk7y0jRKVrTRZCzq0W1G7_Ef1QqF5yqKs==DwsR+xuhra3b4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk7y0jRKVrTRZCzq0W1G7_Ef1QqF5yqKs==DwsR+xuhra3b4A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Nov 10, 2021 at 10:34:43PM +0530, Puranjay Mohan wrote:
> On Wed, Nov 10, 2021 at 2:23 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Wed, Nov 10, 2021 at 01:38:39AM +0530, Puranjay Mohan wrote:

> I wrote this function keeping the device tree in mind. I will have to
> look into ACPI and see how the cases you mentioned can be implemented.
> Let's see how far I can get with understanding the ACPI.

Yeah.

What you need to have is
1) expand fwnode_irq_get() to support ACPI GPIO IRQ resources.
2) provide a simple version of the fwnode_irq_get_by_name() like

	if (is_of_node())
		return of_...();

	return acpi_dev_gpio_irq_get_by();

3) establish understanding about naming for ACPI and
4) extend fwnode_irq_get_by_name() by it

	if (is_of_node())
		return of_...();

	ret = acpi_irq_get_by_name();
	if (ret > 0)
		return ret;

	return acpi_dev_gpio_irq_get_by();

As I mentioned, items 1 and 2 are easy to achieve with currently existing APIs.

-- 
With Best Regards,
Andy Shevchenko


