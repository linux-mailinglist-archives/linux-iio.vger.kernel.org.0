Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 216B744BCEF
	for <lists+linux-iio@lfdr.de>; Wed, 10 Nov 2021 09:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhKJIfH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 Nov 2021 03:35:07 -0500
Received: from mga01.intel.com ([192.55.52.88]:48154 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230053AbhKJIfH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 10 Nov 2021 03:35:07 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10163"; a="256313675"
X-IronPort-AV: E=Sophos;i="5.87,223,1631602800"; 
   d="scan'208";a="256313675"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 00:32:19 -0800
X-IronPort-AV: E=Sophos;i="5.87,223,1631602800"; 
   d="scan'208";a="589202538"
Received: from smile.fi.intel.com ([10.237.72.184])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 00:32:17 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mkj1Z-005LwK-GT;
        Wed, 10 Nov 2021 10:32:05 +0200
Date:   Wed, 10 Nov 2021 10:32:05 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Puranjay Mohan <puranjay12@gmail.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org, heikki.krogerus@linux.intel.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org, lars@metafoo.de,
        Michael.Hennerich@analog.com, jic23@kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 0/2] device property: Adding fwnode_irq_get_byname()
Message-ID: <YYuDhTlMIn9qxlvo@smile.fi.intel.com>
References: <20211109200840.135019-1-puranjay12@gmail.com>
 <CAGETcx9-WoAa8VbEPSthseYNz=L-gnoXLcHFtHrD_+yhQXmJnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx9-WoAa8VbEPSthseYNz=L-gnoXLcHFtHrD_+yhQXmJnA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Nov 09, 2021 at 02:42:35PM -0800, Saravana Kannan wrote:
> On Tue, Nov 9, 2021 at 12:09 PM Puranjay Mohan <puranjay12@gmail.com> wrote:
> >
> > The first patch in this series adds the fwnode_irq_get_byname() which is
> > the generic version of the of_irq_get_byname(). It is used to get the
> > IRQ number from name of the interrupt.
> >
> > The second patch in this series uses the fwnode_irq_get_byname()
> > function in the IIO driver of the ADXL355 accelerometer. The driver has
> > been tested after applying this patch on a Raspberry PI. The ADXL355 was
> > connected to the Raspberry Pi using I2C and fwnode_irq_get_byname() was
> > used to get the IRQ number for the "DRDY" interrupt. Earlier this driver
> > was using of_irq_get_byname() to get this IRQ number.
> 
> Why do we need these changes though? Is there a non-OF device this
> driver would ever probe?

Strange question, TBH. All discrete component drivers are subject to
be enumerated on any type of the systems. So, of course the answer
to it "Definitely yes".

-- 
With Best Regards,
Andy Shevchenko


