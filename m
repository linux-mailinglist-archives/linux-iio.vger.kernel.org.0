Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F78C1D9BE6
	for <lists+linux-iio@lfdr.de>; Tue, 19 May 2020 18:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbgESQBl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 May 2020 12:01:41 -0400
Received: from mga11.intel.com ([192.55.52.93]:7761 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729089AbgESQBl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 19 May 2020 12:01:41 -0400
IronPort-SDR: YGm6iid6lnj/vQmKp9sqBZsge8uHzSqxU/jy48viIBkj6JURjh633CdkK8zYsKTTH4BFINykaM
 LZ5kswIgIiyQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2020 09:01:40 -0700
IronPort-SDR: 1Y/n7E8w3aaJVbDXpCS+Re2n7PRcfEj3aJ1T42ra9Cj6N7PVTfTCgsjxJb3pVHvmTlH6N69SqB
 le4LZ4hiY53w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,410,1583222400"; 
   d="scan'208";a="411682609"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004.jf.intel.com with ESMTP; 19 May 2020 09:01:35 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jb4gT-007g4P-KB; Tue, 19 May 2020 19:01:37 +0300
Date:   Tue, 19 May 2020 19:01:37 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Albrieux <jonathan.albrieux@gmail.com>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jilayne Lovejoy <opensource@jilayne.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Steve Winslow <swinslow@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 1/4] dt-bindings: iio: magnetometer: ak8975: convert
 txt format to yaml
Message-ID: <20200519160137.GJ1634618@smile.fi.intel.com>
References: <20200519124402.26076-1-jonathan.albrieux@gmail.com>
 <20200519124402.26076-2-jonathan.albrieux@gmail.com>
 <20200519132207.GA4623@gerhold.net>
 <20200519140354.GB30573@ict14-OptiPlex-980>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519140354.GB30573@ict14-OptiPlex-980>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, May 19, 2020 at 04:03:54PM +0200, Jonathan Albrieux wrote:
> On Tue, May 19, 2020 at 03:22:07PM +0200, Stephan Gerhold wrote:
> > On Tue, May 19, 2020 at 02:43:51PM +0200, Jonathan Albrieux wrote:

...

> > > +maintainers:
> > > +  - can't find a mantainer, author is Laxman Dewangan <ldewangan@nvidia.com>
> > 
> > Should probably add someone here, although I'm not sure who either.
> > 
> 
> Yep I couldn't find a maintainer for that driver..what to do in this case?

Volunteer yourself!

-- 
With Best Regards,
Andy Shevchenko


