Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A897418ECDB
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 23:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgCVWTP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 18:19:15 -0400
Received: from mga09.intel.com ([134.134.136.24]:5508 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726786AbgCVWTO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 22 Mar 2020 18:19:14 -0400
IronPort-SDR: MnHtTAhXaQ4HBKsKSXHdFg95ntStwAeBdkcA1gia4PzMZbQQLmfse14sVBF7cS13xrjwUB2jtI
 z98QpBxUHdNg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2020 15:19:12 -0700
IronPort-SDR: ArCCCWHZfxdjjjQGOMdgfA+yfU2ZGiAWq4zyZfdIijj1MbxJkGc/2Lb2CyulLY0Y45akDwVBGA
 QNH8hg24P3UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,294,1580803200"; 
   d="scan'208";a="280987324"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002.fm.intel.com with ESMTP; 22 Mar 2020 15:19:10 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1jG8w5-00C5OE-1f; Mon, 23 Mar 2020 00:19:13 +0200
Date:   Mon, 23 Mar 2020 00:19:13 +0200
From:   "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "Tachici, Alexandru" <Alexandru.Tachici@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Caprioru, Mircea" <Mircea.Caprioru@analog.com>
Subject: Re: [PATCH v4 1/2] iio: dac: ad5770r: Add AD5770R support
Message-ID: <20200322221913.GA1922688@smile.fi.intel.com>
References: <20200218121031.27233-1-alexandru.tachici@analog.com>
 <20200218121031.27233-2-alexandru.tachici@analog.com>
 <20200321210921.GA2814584@smile.fi.intel.com>
 <2942e900ab01957027b918b2a5fdbd665fe6b2ed.camel@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2942e900ab01957027b918b2a5fdbd665fe6b2ed.camel@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Mar 22, 2020 at 09:17:06AM +0000, Ardelean, Alexandru wrote:
> On Sat, 2020-03-21 at 23:09 +0200, Andy Shevchenko wrote:
> > On Tue, Feb 18, 2020 at 02:10:30PM +0200, Alexandru Tachici wrote:
> > > The AD5770R is a 6-channel, 14-bit resolution, low noise, programmable
> > > current output digital-to-analog converter (DAC) for photonics control
> > > applications.
> > > 
> > > It contains five 14-bit resolution current sourcing DAC channels and one
> > > 14-bit resolution current sourcing/sinking DAC channel.
> > 
> 
> This patch made it into linux-next.
> Doing a v2 now may be a bit noisy.
> 
> Maybe we can tidy-this-up later.
> To be honest, it won't be the highest on our list.
> [ I know how that sounds ]

Yes, you may consider a follow up.

> We can probably leave it for other people to clean it up.
> [ People that want to start contributing to the kernel ]

Maybe, but isn't better to supply cleaner code in the first place?

I mean that these comments may be taken into consideration for the future
contributions.

-- 
With Best Regards,
Andy Shevchenko


