Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2DF1D9414
	for <lists+linux-iio@lfdr.de>; Tue, 19 May 2020 12:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgESKIQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 May 2020 06:08:16 -0400
Received: from mga18.intel.com ([134.134.136.126]:27677 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgESKIP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 19 May 2020 06:08:15 -0400
IronPort-SDR: 39h6fXfKL68fiT/VW7prhj0KD5UGl8/gTx/C1SKpa9RzzTmCztJiM7ROeTprnC4hTogg6L6hyV
 4zdnCNfE2EOA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2020 03:08:15 -0700
IronPort-SDR: SjWFqbbimDqnm/TjnWpuDf0o3/YjENl1YCcC2qrTXp05DIM2wcwv1hDb4TRMTYUr8rYBbxnix7
 URI5O6Ki7tuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,409,1583222400"; 
   d="scan'208";a="264257366"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003.jf.intel.com with ESMTP; 19 May 2020 03:08:12 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jazAV-007c93-I1; Tue, 19 May 2020 13:08:15 +0300
Date:   Tue, 19 May 2020 13:08:15 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Albrieux <jonathan.albrieux@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 0/3] iio: magnetometer: ak8975: Add gpio reset support
Message-ID: <20200519100815.GA1634618@smile.fi.intel.com>
References: <20200519065749.4624-1-jonathan.albrieux@gmail.com>
 <20200519092212.GT1634618@smile.fi.intel.com>
 <20200519094835.GB10391@ict14-OptiPlex-980>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519094835.GB10391@ict14-OptiPlex-980>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, May 19, 2020 at 11:48:35AM +0200, Jonathan Albrieux wrote:
> On Tue, May 19, 2020 at 12:22:12PM +0300, Andy Shevchenko wrote:
> > On Tue, May 19, 2020 at 08:57:40AM +0200, Jonathan Albrieux wrote:

...

> > I dunno if it's your first submission to Linux kernel project or other OSS,
> > but here you missed a changelog. Rule of thumb is to provide a summary of
> > the changes done in the history of the evolution of a patch series.
> > 
> 
> Oh thank you and sorry for not having included it. 
> 
> Does the changelog needs to be added to all patch files or just on the ones
> subject of the changes?

Up to you and maintainer of the corresponding subsystem.

My common sense tells me that
1) if there is a cover letter, just put a joined changelog there
2) otherwise, put changelog in each patch.

I saw in practice all possible variants, i.e.
a) cover letter w/o changelog + changelog per patch;
b) cover letter w/ changelog + changelog per patch;
c) cover letter w/ changelog.

I think any of it is fine in general.

-- 
With Best Regards,
Andy Shevchenko


