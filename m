Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83D7D108AF6
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2019 10:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfKYJd2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 Nov 2019 04:33:28 -0500
Received: from mga09.intel.com ([134.134.136.24]:3022 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbfKYJd2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 25 Nov 2019 04:33:28 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Nov 2019 01:33:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,241,1571727600"; 
   d="scan'208";a="233344925"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004.fm.intel.com with ESMTP; 25 Nov 2019 01:33:24 -0800
Received: from andy by smile with local (Exim 4.93-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iZAkF-0007pQ-Al; Mon, 25 Nov 2019 11:33:23 +0200
Date:   Mon, 25 Nov 2019 11:33:23 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Vincent Pelletier <plr.vincent@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: adc: intel_mrfld_adc: Allocating too much data in
 probe()
Message-ID: <20191125093323.GZ32742@smile.fi.intel.com>
References: <20191119062124.kgwg7ujxe6k2ft3o@kili.mountain>
 <20191119102332.GC32742@smile.fi.intel.com>
 <20191123144206.7d3e5bd4@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191123144206.7d3e5bd4@archlinux>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Nov 23, 2019 at 02:42:06PM +0000, Jonathan Cameron wrote:
> On Tue, 19 Nov 2019 12:23:32 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > On Tue, Nov 19, 2019 at 09:21:24AM +0300, Dan Carpenter wrote:
> > > This probe function is passing the wrong size to devm_iio_device_alloc().
> > > It is supposed to be the size of the private data.  Fortunately,
> > > sizeof(*indio_dev) is larger than sizeof(struct mrfld_adc) so it doesn't
> > > cause a runtime problem.
> > >   
> > 
> > Ah, indeed, thanks for fixing this!
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Applied to the fixes-togreg branch of iio.git.

Thanks!

> I'll wait until after the merge window now to send a pull request for this
> one so will be rc2ish before it's in.

Sure, as pointed out by Dan it seems to work due to size of wrong structure is
bigger than needed, thus it's not a critical fix.

-- 
With Best Regards,
Andy Shevchenko


