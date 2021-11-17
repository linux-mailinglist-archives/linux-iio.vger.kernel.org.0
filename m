Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3C4D45469C
	for <lists+linux-iio@lfdr.de>; Wed, 17 Nov 2021 13:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237287AbhKQMwF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Nov 2021 07:52:05 -0500
Received: from mga01.intel.com ([192.55.52.88]:49920 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237290AbhKQMwF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 17 Nov 2021 07:52:05 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10170"; a="257706591"
X-IronPort-AV: E=Sophos;i="5.87,241,1631602800"; 
   d="scan'208";a="257706591"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2021 04:49:06 -0800
X-IronPort-AV: E=Sophos;i="5.87,241,1631602800"; 
   d="scan'208";a="604719627"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2021 04:49:03 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mnKMx-007nDj-7t;
        Wed, 17 Nov 2021 14:48:55 +0200
Date:   Wed, 17 Nov 2021 14:48:54 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Anand Ashok Dumbre <ANANDASH@xilinx.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        git <git@xilinx.com>, Michal Simek <michals@xilinx.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        Manish Narani <MNARANI@xilinx.com>
Subject: Re: [PATCH v9 3/5] iio: adc: Add Xilinx AMS driver
Message-ID: <YZT6NgAbkHVNAst0@smile.fi.intel.com>
References: <20211116150842.1051-1-anand.ashok.dumbre@xilinx.com>
 <20211116150842.1051-4-anand.ashok.dumbre@xilinx.com>
 <YZPspfolQkDrz22s@smile.fi.intel.com>
 <BY5PR02MB6916E4CF9E34190CF7D24AE4A9999@BY5PR02MB6916.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR02MB6916E4CF9E34190CF7D24AE4A9999@BY5PR02MB6916.namprd02.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Nov 16, 2021 at 08:29:21PM +0000, Anand Ashok Dumbre wrote:
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Sent: Tuesday 16 November 2021 5:39 PM
> > On Tue, Nov 16, 2021 at 03:08:40PM +0000, Anand Ashok Dumbre wrote:

...

> > > +#define AMS_ALARM_THR_MIN		0x0000
> > > +#define AMS_ALARM_THR_MAX		0xFFFF
> > 
> > If this is limited by hardware register, I would rather use (BIT(16) - 1)
> > notation. It will give immediately amount of bits used for the value.

> So ~(BIT(16) - 1) for AMS_ALARM_THR_MIN

This will give wrong value, so preserving 0 as plain decimal is fine.

> (BIT(16) - 1) for AMS_ALARM_THR_MAX

...

> > > +	u32 reg;
> > > +	int ret;
> > 
> > 	u32 expect = AMS_PS_CSTS_PS_READY;
> > 
> > (Use similar approach for other readX_poll_timeout() cases)
> > 
> > > +		ret = readl_poll_timeout(ams->base + AMS_PS_CSTS, reg,
> > > +					 (reg & AMS_PS_CSTS_PS_READY) ==
> > > +					 AMS_PS_CSTS_PS_READY, 0,
> > > +					 AMS_INIT_TIMEOUT_US);
> > 
> > 		ret = readl_poll_timeout(ams->base + AMS_PS_CSTS, reg,
> > 					 (reg & expect) == expect,
> > 					 0, AMS_INIT_TIMEOUT_US);

> > 0?!

Any comments on this?

Besides there are other cases you haven't answered on, so I assume you agreed
to change as suggested.

> > > +		if (ret)
> > > +			return ret;
> > 
> > ...
> > 
> > > +		ret = readl(ams->base + AMS_PL_CSTS);
> > > +		if (ret == 0)
> > > +			return ret;
> > 
> > Assigning u32 to int seems wrong.
> 
> It's a single bit register.
> Even if I use u32 here, the return type is int.

The problem here is that you checked not for error code, readl() doesn't return
an error. So semantic issue.

> So, is it ok if I read using u32 and return it by typecasting to int?

No. You need to have something like this:

	value = readl(...);
	if (value == 0)
		return 0;

this will keep proper meaning of each number and variable, while compiler may
optimize it.

...

> > > +					regval = readl(ams->pl_base +
> > > +						       AMS_REG_CONFIG4);
> > 
> > One line?
> > 
> > > +					regval = readl(ams->pl_base +
> > > +						       AMS_REG_CONFIG4);
> > 
> > Ditto and so on...
> > 
> It goes over 80 chars per line.

Is it a problem?

...

> > > +	schedule_delayed_work(&ams->ams_unmask_work,
> > > +			      msecs_to_jiffies(AMS_UNMASK_TIMEOUT_MS));
> > 
> > Can be one line.
> 
> Over 80 characters.

Is it a problem?

> Oh! I just saw that upto 100 chars is ok.

-- 
With Best Regards,
Andy Shevchenko


