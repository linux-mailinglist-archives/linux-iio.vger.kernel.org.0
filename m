Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1AAE455FBC
	for <lists+linux-iio@lfdr.de>; Thu, 18 Nov 2021 16:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbhKRPp5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Nov 2021 10:45:57 -0500
Received: from mga05.intel.com ([192.55.52.43]:10575 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232602AbhKRPp4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 18 Nov 2021 10:45:56 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10172"; a="320420114"
X-IronPort-AV: E=Sophos;i="5.87,245,1631602800"; 
   d="scan'208";a="320420114"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2021 07:42:42 -0800
X-IronPort-AV: E=Sophos;i="5.87,245,1631602800"; 
   d="scan'208";a="605196377"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2021 07:42:38 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mnjYV-008DMI-OZ;
        Thu, 18 Nov 2021 17:42:31 +0200
Date:   Thu, 18 Nov 2021 17:42:31 +0200
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
Subject: Re: [PATCH v10 3/5] iio: adc: Add Xilinx AMS driver
Message-ID: <YZZ0Z++xlAjBbRtI@smile.fi.intel.com>
References: <20211117161028.11775-1-anand.ashok.dumbre@xilinx.com>
 <20211117161028.11775-4-anand.ashok.dumbre@xilinx.com>
 <YZVf+Y/KxASvT2MU@smile.fi.intel.com>
 <BY5PR02MB6916A1C867FCD6C289E894A2A99B9@BY5PR02MB6916.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BY5PR02MB6916A1C867FCD6C289E894A2A99B9@BY5PR02MB6916.namprd02.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Nov 18, 2021 at 02:14:41PM +0000, Anand Ashok Dumbre wrote:
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Sent: Wednesday 17 November 2021 8:03 PM
> > On Wed, Nov 17, 2021 at 04:10:26PM +0000, Anand Ashok Dumbre wrote:

...

> > > +			ret = ams_read_vcc_reg(ams, chan->address, val);
> > > +			if (ret) {
> > > +				mutex_unlock(&ams->lock);
> > > +				return -EINVAL;
> > 
> > Shadowed error code.
> 
> I don’t understand.

You get an error code in ret variable, but you always return -EINVAL, why?

> > > +			}

...

> > default: ?
> 
> This is limited by hw bits.
> For default I will use the default scan_index value.
> Is that ok?

I think so, you know hardware better, you decide what to put there.

...

> > > +		if (ret || reg > (AMS_PL_MAX_EXT_CHANNEL + 30))
> > 
> > Too many parentheses.
> 
> Is it a good practice to not have parantheses around (AMS_PL_MAX_EXT_CHANNEL + 30) ?

It's minor thing, up to you.

> > > +			continue;

...

> > > +	dev_chan_size = array_size((size_t)num_channels, sizeof(struct
> > iio_chan_spec));
> > > +	if (dev_chan_size == SIZE_MAX)
> > > +		return -EINVAL;
> > 
> > Why is it needed now?
> > 
> > > +	dev_channels = devm_kcalloc(&pdev->dev, (size_t)num_channels,
> > 
> > Why casting?
> > 
> > > +				    sizeof(struct iio_chan_spec), GFP_KERNEL);
> > 
> > sizeof(*dev_channels)
> > 
> > > +	if (!dev_channels) {
> > > +		ret = -ENOMEM;
> > > +		goto free_mem;
> > > +	}
> > 
> > > +	memcpy(dev_channels, ams_channels,
> > > +	       sizeof(*ams_channels) * num_channels);
> > 
> > Hmm... according to the code the num_channels can be less than or equal to
> > num_chan. Hence, what you should use is the devm_krealloc_array().
> > 
> > static inline void *devm_krealloc_aray(...) {
> > 	...see how krealloc_array() is defined...
> > }
> > 
> > No need to copy memory again.
> 
> Will take a look.

-- 
With Best Regards,
Andy Shevchenko


