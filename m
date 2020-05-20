Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 329C41DB5B4
	for <lists+linux-iio@lfdr.de>; Wed, 20 May 2020 15:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbgETNyD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 May 2020 09:54:03 -0400
Received: from mga04.intel.com ([192.55.52.120]:23368 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726747AbgETNyD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 20 May 2020 09:54:03 -0400
IronPort-SDR: 75lVHhzPn9QnptwYMXyaM2trYBp6kZ1yhvgZC+4XH7uhS95H3WW/E2NMUm8hViFN19M6VPYBJb
 1jB+vzwBFgfQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 06:54:02 -0700
IronPort-SDR: CfjYfYOwGlo7W6hJLSBMB0qq5wkFJd1BYMJO7ohBoc5KzC2dSiRqBuZe3dJC/oK2ZyY7gdK7u6
 5fTK8VVCG0ZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,414,1583222400"; 
   d="scan'208";a="466532442"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006.fm.intel.com with ESMTP; 20 May 2020 06:53:58 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1jbPAX-007qnD-8s; Wed, 20 May 2020 16:54:01 +0300
Date:   Wed, 20 May 2020 16:54:01 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Jonathan Albrieux <jonathan.albrieux@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Allison Randal <allison@lohutok.net>,
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
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4 1/4] dt-bindings: iio: magnetometer: ak8975: convert
 txt format to yaml
Message-ID: <20200520135401.GS1634618@smile.fi.intel.com>
References: <20200520073125.30808-1-jonathan.albrieux@gmail.com>
 <20200520073125.30808-2-jonathan.albrieux@gmail.com>
 <CAHp75VcWBe=3j68t9pmRk=xigsym_f_EHG4HLLKe_cmQi5E6mA@mail.gmail.com>
 <20200520134416.GA6875@ict14-OptiPlex-980>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520134416.GA6875@ict14-OptiPlex-980>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, May 20, 2020 at 03:44:16PM +0200, Jonathan Albrieux wrote:
> On Wed, May 20, 2020 at 11:23:18AM +0300, Andy Shevchenko wrote:
> > On Wed, May 20, 2020 at 10:32 AM Jonathan Albrieux
> > <jonathan.albrieux@gmail.com> wrote:
> > 
> > > +maintainers:
> > > +  - can't find a maintainer, author is Laxman Dewangan <ldewangan@nvidia.com>
> > 
> > Alas, you'll never go forward with this.
> > One (easiest way) is to drop this patch completely if you won't be a
> > maintainer of the binding.
> >
> 
> That's too bad. How can I be a maintainer of the binding?

Put your name there as Jonathan and me suggested. :-)

maintainers:
  - Jonathan Albrieux <jonathan.albrieux@gmail.com>

-- 
With Best Regards,
Andy Shevchenko


