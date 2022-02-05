Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B3B4AAB15
	for <lists+linux-iio@lfdr.de>; Sat,  5 Feb 2022 19:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351783AbiBESve (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Feb 2022 13:51:34 -0500
Received: from mga05.intel.com ([192.55.52.43]:1835 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241263AbiBESvd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Feb 2022 13:51:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644087093; x=1675623093;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eyTER7PoTb1xRJJC7VnO+4pzGVOkePxUg2TcCM1e6qg=;
  b=ScSuaUazyfoCdoXgVx0nhXUS5iCCA8PpS/HgVfm5MWGpMyOGnmB3hTlw
   6W0i31+yZfwr0wwi8IIVOlG7Z2N0x1xxRIEKLFORaXFLcvw0hhgIFcmWq
   2SfppbE9KNYvkTpfVepNBtUro/efZNEDMrRIOiRDQc2Qbe8UfGrRscO01
   xY2VufNPIrB2ufJmYHMBJjXhLIGNoP4oKItYV2tLWfmCTzS4hxCgnFayM
   SY6pLXzgjMSydsr8La2EG73Pg8kfkU91H9MMLnsK6Pm9FVt0u4fHyw4K3
   GcG0WFuN9VdIJ4iG1wEHFC5bkuJB2pXy0Oo61gI8Oh6m0p412q4gkXOb7
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="334928669"
X-IronPort-AV: E=Sophos;i="5.88,346,1635231600"; 
   d="scan'208";a="334928669"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2022 10:51:33 -0800
X-IronPort-AV: E=Sophos;i="5.88,346,1635231600"; 
   d="scan'208";a="483952943"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2022 10:51:31 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1nGQ8l-001LkB-N7;
        Sat, 05 Feb 2022 20:50:31 +0200
Date:   Sat, 5 Feb 2022 20:50:31 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v3 1/3] iio: dac: add support for ltc2688
Message-ID: <Yf7G91IuwAw0trgz@smile.fi.intel.com>
References: <20220121142501.151-1-nuno.sa@analog.com>
 <20220121142501.151-2-nuno.sa@analog.com>
 <Yf60A1UkbBtQ68qv@smile.fi.intel.com>
 <20220205184459.7aa8e5d5@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220205184459.7aa8e5d5@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Feb 05, 2022 at 06:44:59PM +0000, Jonathan Cameron wrote:
> On Sat, 5 Feb 2022 19:29:39 +0200
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> 
> A few comments from me, mostly because I couldn't resist jumping in ;)
> Note this is only some of the things Andy raised....

...

> > > +static int ltc2688_channel_config(struct ltc2688_state *st)
> > > +{
> > > +	struct device *dev = &st->spi->dev;
> > > +	struct device_node *child;
> > > +	u32 reg, clk_input, val, tmp[2];
> > > +	int ret, span;
> > > +
> > > +	for_each_available_child_of_node(dev->of_node, child) {  
> > 
> > device_for_each_child_node()
> 
> This is the old issue with missing
> device_for_each_available_child_node()
> though can just add a check on whether it's available inside the loop.

Didn't we discuss this with Rob and he told that device_for_each_child_node()
is already for available only?

> > > +		struct ltc2688_chan *chan;
> > > +

-- 
With Best Regards,
Andy Shevchenko


