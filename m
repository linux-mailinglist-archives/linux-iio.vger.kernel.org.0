Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B0A4AAC22
	for <lists+linux-iio@lfdr.de>; Sat,  5 Feb 2022 20:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbiBETBj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Feb 2022 14:01:39 -0500
Received: from mga12.intel.com ([192.55.52.136]:35881 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1382860AbiBETBP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Feb 2022 14:01:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644087675; x=1675623675;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RPTYqe6PAP+xAsk6gDKIccqhay0CazxZLMQxmkYLCFI=;
  b=ZMD2FZ94BjpU2n4KHrAUNwwAsFZ4UjjSxZ+5fftz6jx6HsdeCTEgTSX/
   1KwtSYmf1NrhI+WwPXk/u2JDBW/OlLwCYMkWWd4gap3tL0FMeitRtfrJl
   6YIKw6GJpHH9gnaMQ7NSOpWaFJ75AVU4S6QeHmhFv995yGWAH8gKx39W3
   6L1lMDZeulQja4kz1VbDY/ZfjDNK+PkgTYLpFPAj7p7PRFpmcctoSKODt
   VDM4OuLbyCXxQ9FlRYIVUGdBnOkekPyeMaqJ+93KeEq/ulwgsecds7AmZ
   gV2C1NJb/1BmQdUtXdjdL8CDV8+l7Iku2YXW+c6TLwXm3oN68cz0goqhy
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="228500829"
X-IronPort-AV: E=Sophos;i="5.88,346,1635231600"; 
   d="scan'208";a="228500829"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2022 10:59:30 -0800
X-IronPort-AV: E=Sophos;i="5.88,346,1635231600"; 
   d="scan'208";a="481154887"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2022 10:59:28 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nGQGQ-001Lr9-Re;
        Sat, 05 Feb 2022 20:58:26 +0200
Date:   Sat, 5 Feb 2022 20:58:12 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v3 1/3] iio: dac: add support for ltc2688
Message-ID: <Yf7IxJKmAtgqT2rB@smile.fi.intel.com>
References: <20220121142501.151-1-nuno.sa@analog.com>
 <20220121142501.151-2-nuno.sa@analog.com>
 <Yf60A1UkbBtQ68qv@smile.fi.intel.com>
 <20220205184459.7aa8e5d5@jic23-huawei>
 <Yf7G91IuwAw0trgz@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yf7G91IuwAw0trgz@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Feb 05, 2022 at 08:50:31PM +0200, Andy Shevchenko wrote:
> On Sat, Feb 05, 2022 at 06:44:59PM +0000, Jonathan Cameron wrote:
> > On Sat, 5 Feb 2022 19:29:39 +0200
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > 
> > A few comments from me, mostly because I couldn't resist jumping in ;)
> > Note this is only some of the things Andy raised....
> 
> ...
> 
> > > > +static int ltc2688_channel_config(struct ltc2688_state *st)
> > > > +{
> > > > +	struct device *dev = &st->spi->dev;
> > > > +	struct device_node *child;
> > > > +	u32 reg, clk_input, val, tmp[2];
> > > > +	int ret, span;
> > > > +
> > > > +	for_each_available_child_of_node(dev->of_node, child) {  
> > > 
> > > device_for_each_child_node()
> > 
> > This is the old issue with missing
> > device_for_each_available_child_node()
> > though can just add a check on whether it's available inside the loop.
> 
> Didn't we discuss this with Rob and he told that device_for_each_child_node()
> is already for available only?

https://lore.kernel.org/lkml/20211205190101.26de4a57@jic23-huawei/T/#u

So, the fwnode has a correct implementation, and we may use it here.

-- 
With Best Regards,
Andy Shevchenko


