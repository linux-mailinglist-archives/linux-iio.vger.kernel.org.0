Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E256CA5776
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2019 15:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729758AbfIBNNG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Sep 2019 09:13:06 -0400
Received: from mga06.intel.com ([134.134.136.31]:31288 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729690AbfIBNNF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 2 Sep 2019 09:13:05 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 06:13:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,459,1559545200"; 
   d="scan'208";a="333562759"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004.jf.intel.com with ESMTP; 02 Sep 2019 06:13:02 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1i4m8j-0002KP-Bk; Mon, 02 Sep 2019 16:13:01 +0300
Date:   Mon, 2 Sep 2019 16:13:01 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Vincent Pelletier <plr.vincent@gmail.com>,
        Tomasz Duszynski <tduszyns@gmail.com>
Subject: Re: [PATCH v2] iio: adc: intel_mrfld_adc: Add Basin Cove ADC driver
Message-ID: <20190902131301.GI2680@smile.fi.intel.com>
References: <20190326145138.19717-1-andriy.shevchenko@linux.intel.com>
 <20190330153140.7bfecadf@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190330153140.7bfecadf@archlinux>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Mar 30, 2019 at 03:31:40PM +0000, Jonathan Cameron wrote:
> On Tue, 26 Mar 2019 16:51:38 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > From: Vincent Pelletier <plr.vincent@gmail.com>
> > 
> > Exposes the ADC device present on, at least, Intel Merrifield platform.
> > 
> > Based on work done by:
> >   Yang Bin <bin.yang@intel.com>
> >   Huiquan Zhong <huiquan.zhong@intel.com>
> >   Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
> >   Pavan Kumar S <pavan.kumar.s@intel.com>
> > 
> > Though it has been heavily rewritten for upstream.
> > 
> > Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Hmm. There is a very small ordering issue in probe vs remove, which
> I'll probably just fix up.
> 
> However I don't yet have the header in my upstream so will wait
> until that is there before applying.  If Lee or whoever is dealing
> with that patch set puts out an immutable branch with it in then
> let me know.
> 
> Give me a poke if I seem to have forgotten it.

Hi, Jonathan.

Lee applied the main driver to his tree [1].
Should I do anything for this one or is it applicable clean?

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git/commit/?id=b9a801dfa591

-- 
With Best Regards,
Andy Shevchenko


