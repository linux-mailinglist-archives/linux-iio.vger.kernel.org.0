Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7A6E2A81D6
	for <lists+linux-iio@lfdr.de>; Thu,  5 Nov 2020 16:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730822AbgKEPGI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 5 Nov 2020 10:06:08 -0500
Received: from mga03.intel.com ([134.134.136.65]:53579 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730501AbgKEPGH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 5 Nov 2020 10:06:07 -0500
IronPort-SDR: pnXp52/wALCp1rz0f1t91QuvuQYFil+VY4RFWhfCs+Ds/SfgjxgW3q82qW9Y7s6j4RX/lG8mpP
 Y87VLW04Hubg==
X-IronPort-AV: E=McAfee;i="6000,8403,9795"; a="169505029"
X-IronPort-AV: E=Sophos;i="5.77,453,1596524400"; 
   d="scan'208";a="169505029"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 07:06:06 -0800
IronPort-SDR: iAgcZfHuOCTIT26pyIor40uA+gSy9PsKDBlTIwRxyO6MdG590hAg2FmisUF4pH/jcq+AXjHnO9
 L/hnYpz8jtIw==
X-IronPort-AV: E=Sophos;i="5.77,453,1596524400"; 
   d="scan'208";a="364367834"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 07:06:04 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1kagqw-00459k-Sm; Thu, 05 Nov 2020 17:07:06 +0200
Date:   Thu, 5 Nov 2020 17:07:06 +0200
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v1] iio: gyro: mpu3050: Use get_unaligned_leXX()
Message-ID: <20201105150706.GT4077@smile.fi.intel.com>
References: <20201026175340.19570-1-andriy.shevchenko@linux.intel.com>
 <20201029150444.28f4e18d@archlinux>
 <CAHp75VfzV=VY5R1oVx+2mtbdNj97rJCh6tqeUnzYt=MDGpCsfQ@mail.gmail.com>
 <CACRpkdYG4Z6vaKp9woULPz0CKyTCr6ZocfvRm4gxw2JktStggg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdYG4Z6vaKp9woULPz0CKyTCr6ZocfvRm4gxw2JktStggg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Nov 05, 2020 at 03:23:07PM +0100, Linus Walleij wrote:
> On Thu, Oct 29, 2020 at 6:10 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Thu, Oct 29, 2020 at 5:05 PM Jonathan Cameron <jic23@kernel.org> wrote:
> > >
> > > On Mon, 26 Oct 2020 19:53:40 +0200
> > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > > This makes the driver code slightly easier to read.
> > > >
> > > > Cc: Linus Walleij <linus.walleij@linaro.org>
> > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > >
> > > What you have is good, but could we do better?
> > >
> > > Why not use an __le64 to grab the whole thing, convert it to a local
> > > cpu endian u64 then use FIELD_GET or similar to pull out the right bits.
> > > Would be fairly self documenting as well which is always nice.
> > >
> > > Or am I missing something?
> >
> > My laziness. I shared this as a leftover from a big series of
> > converting a lot of drivers to get_unligned_.eXX(). If you consider
> > this is not good enough, just don't apply (no hard feelings :-) I will
> > drop it from my local branches.
> 
> I would suggest to apply it anyways because the kernel will look
> better after than before this patch.
> 
> Possibly Jonathan could just slip in a TODO comment for this?

Sorry, I have already dropped, but if you convince Jonathan to apply, I agree
on whatever you propose (TODO comment as I see). I think patchwork or lore
still keeps a track of this.

-- 
With Best Regards,
Andy Shevchenko


