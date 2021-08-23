Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6F883F45E5
	for <lists+linux-iio@lfdr.de>; Mon, 23 Aug 2021 09:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235053AbhHWHkA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Aug 2021 03:40:00 -0400
Received: from mga11.intel.com ([192.55.52.93]:1155 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235038AbhHWHkA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Aug 2021 03:40:00 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10084"; a="213923829"
X-IronPort-AV: E=Sophos;i="5.84,344,1620716400"; 
   d="scan'208";a="213923829"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 00:39:18 -0700
X-IronPort-AV: E=Sophos;i="5.84,344,1620716400"; 
   d="scan'208";a="683054339"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 00:39:16 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1mI4Y2-00ChMN-UB; Mon, 23 Aug 2021 10:39:10 +0300
Date:   Mon, 23 Aug 2021 10:39:10 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] iio: chemical: Add Senseair Sunrise CO2 sensor
Message-ID: <YSNQntuHJjaB6eE1@smile.fi.intel.com>
References: <20210822184927.94673-1-jacopo@jmondi.org>
 <CAHp75VcM8Z58_EdzZKxy8r=BojYsfgSM+F6fSuDgwTbg1zvXVw@mail.gmail.com>
 <20210823071622.3apzw2pxlfebls3m@uno.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210823071622.3apzw2pxlfebls3m@uno.localdomain>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 23, 2021 at 09:16:22AM +0200, Jacopo Mondi wrote:
> On Sun, Aug 22, 2021 at 11:11:59PM +0300, Andy Shevchenko wrote:
> > On Sun, Aug 22, 2021 at 9:49 PM Jacopo Mondi <jacopo@jmondi.org> wrote:
> > >
> > > The driver supports continuous reads of temperature and CO2 concentration
> > > through two dedicated IIO channels. It also supports calibration and error
> > > inspection through the concentration channel ext_info.
> > >
> > > Minor changes in v3
> >
> > Not sure, I have found bigger issues. See my comments in patch 2.
> > So, since it's obvious you haven't tested the patch and we are at rc7
> > I think you can take a few weeks of time to have a look and carefully
> > address all comments and to test.
> 
> I'm sorry if the patches I sent out contain a leftover debug (the
> pr_err) and I cannot explain how the :q commands ended up in the final
> patch, most probably they come from me inspecting the generated patch
> and being sloppy with vim on a sunday night, as they are not in the
> git tree. They won't have even compiled otherwise, and it's obvious
> where they come from if you've ever used vim.
> 
> Aprt from that, this is a v3, not v7, I've tested it several times, there's
> no need to paternalize me as the only thing to fix is to re-add back
> the ending commas in arrays declarations as a result of a comment from
> you which I interpreted as a request from removing them. To me commas
> at the end of an array declaration is mostly nit picking, which I
> accept given the context and given I don't know the subsystem rules,
> but please consider the last version of the patch mostly fixes minor
> style issue which are questionable (lines that can span over 80 cols,
> terminating commas, empty line at the beginning of the switch which I
> liked but you didn't, 'Typically' in the bindings etc)).
> 
> So please consider that it took me a sunday
> afternoon to please your preferences. If a debug printout leftover has
> escaped I'm sorry, I've been sloppy. The ':q' in the final patch are
> another obvious stupid mistake but the assumption that I've not tested
> the patches it's really not appropriate.
> 
> As I appreciate your effort in review and I've silently gone over all
> your comments, even the questionable ones, I don't think it's fair to
> crucify someone which has sent a fully working driver with no major issues
> (none that has been found so far at least) for two stupid leftovers.
> 
> I'll send v4 re-adding back the commas at the end of arrays.

Please, do.

-- 
With Best Regards,
Andy Shevchenko


