Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37BB418F61F
	for <lists+linux-iio@lfdr.de>; Mon, 23 Mar 2020 14:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbgCWNrT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Mar 2020 09:47:19 -0400
Received: from mga05.intel.com ([192.55.52.43]:40309 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728423AbgCWNrT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Mar 2020 09:47:19 -0400
IronPort-SDR: tGwxL37sMIBQW1FtZKs/yoMMTP1KumafGwBPHbBE3wGRV8Ui9BUFH8qk25b9v4pJ6VlsM44uW0
 q5OQN3K9PaOw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 06:47:19 -0700
IronPort-SDR: rU6ZruHZL9LuDD+ibcJ/b0tRraG7jvEecNXQUxYnobPYS6j/gPqCEn0a1cev/xUZEhNQ47WOBz
 aD0HkkLYU/KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,296,1580803200"; 
   d="scan'208";a="325573648"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001.jf.intel.com with ESMTP; 23 Mar 2020 06:47:17 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1jGNQF-00CFtU-Gp; Mon, 23 Mar 2020 15:47:19 +0200
Date:   Mon, 23 Mar 2020 15:47:19 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     jic23@kernel.org, linux-iio@vger.kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net
Subject: Re: [PATCH v4] iio: accel: Add support for the Bosch-Sensortec BMI088
Message-ID: <20200323134719.GN1922688@smile.fi.intel.com>
References: <20200323092830.29708-1-mike.looijmans@topic.nl>
 <20200323113120.GI1922688@smile.fi.intel.com>
 <35eef6af-bf1f-53e0-56a7-aa8161b4f867@topic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35eef6af-bf1f-53e0-56a7-aa8161b4f867@topic.nl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Mar 23, 2020 at 01:33:58PM +0100, Mike Looijmans wrote:
> On 23-03-2020 12:31, Andy Shevchenko wrote:
> > On Mon, Mar 23, 2020 at 10:28:30AM +0100, Mike Looijmans wrote:
> > > The BMI088 is a combined module with both accelerometer and gyroscope.
> > > This adds the accelerometer driver support for the SPI interface.
> > > The gyroscope part is already supported by the BMG160 driver.
> > 
> > 
> > Thank you, the comment about shared buffer given to v3 still applies.
> > Also see below.

Since you didn't comment on many, I assume you are in favor to follow.
Please, comment if it's not the case.

...

> As most of the method body depends on that "bool" argument, I would actually
> just split it into separate "enable" and "disable" methods. Simpler to read
> and understand, and probably doesn't make a difference in compiled size
> either.

It's even better!

...

> > > +#ifndef BMI088_ACCEL_H
> > > +#define BMI088_ACCEL_H
> > > +
> > > +extern const struct regmap_config bmi088_regmap_conf;
> > > +extern const struct dev_pm_ops bmi088_accel_pm_ops;
> > 
> > Do you need extern?
> 
> probably not.
> 
> > 
> > > +int bmi088_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
> > > +			    const char *name, bool block_supported);
> > > +int bmi088_accel_core_remove(struct device *dev);
> > 
> > This needs
> > 
> > #include <linux/types.h>
> > 
> > struct device;
> > struct regmap;
> > 
> 
> Hmm, and "struct regmap_config" as well I guess (see above)

Oh, it requires headers then

So,

#include <linux/pm.h>
#include <linux/regmap.h>
#include <linux/types.h>

struct device;

-- 
With Best Regards,
Andy Shevchenko


