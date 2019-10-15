Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07641D7987
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2019 17:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbfJOPOy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Oct 2019 11:14:54 -0400
Received: from mga02.intel.com ([134.134.136.20]:31153 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725991AbfJOPOy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 15 Oct 2019 11:14:54 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Oct 2019 08:14:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,300,1566889200"; 
   d="scan'208";a="198637451"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003.jf.intel.com with ESMTP; 15 Oct 2019 08:14:51 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iKOXC-0002I3-7d; Tue, 15 Oct 2019 18:14:50 +0300
Date:   Tue, 15 Oct 2019 18:14:50 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Vincent Pelletier <plr.vincent@gmail.com>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2] iio: adc: intel_mrfld_adc: Add Basin Cove ADC driver
Message-ID: <20191015151450.GL32742@smile.fi.intel.com>
References: <20190326145138.19717-1-andriy.shevchenko@linux.intel.com>
 <20190330153140.7bfecadf@archlinux>
 <20190902131301.GI2680@smile.fi.intel.com>
 <20190903185119.2328cf86@archlinux>
 <20191001081933.GD32742@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001081933.GD32742@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Oct 01, 2019 at 11:19:33AM +0300, Andy Shevchenko wrote:
> On Tue, Sep 03, 2019 at 06:51:19PM +0100, Jonathan Cameron wrote:
> > On Mon, 2 Sep 2019 16:13:01 +0300
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > On Sat, Mar 30, 2019 at 03:31:40PM +0000, Jonathan Cameron wrote:
> > > > On Tue, 26 Mar 2019 16:51:38 +0200
> > > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > > > Give me a poke if I seem to have forgotten it.  
> 
> > > Lee applied the main driver to his tree [1].
> > > Should I do anything for this one or is it applicable clean?
> > > 
> > > [1]: https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git/commit/?id=b9a801dfa591
> > > 
> > Hmm. It's very late in the cycle and Lee doesn't have that in an immutable
> > branch (presumably because it's very late or it wasn't clear there was
> > a need to do so).  In theory I've done my last pull request to Greg
> > (though I messed it up so that's not quite true).
> > 
> > Will have to pick this up towards the start of the next cycle now I think.
> 
> Now everything needed is in v5.4-rc1. Your move!

Jonathan, anything I can do to make this accepted?

-- 
With Best Regards,
Andy Shevchenko


