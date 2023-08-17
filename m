Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5698A77F441
	for <lists+linux-iio@lfdr.de>; Thu, 17 Aug 2023 12:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349118AbjHQKWq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 17 Aug 2023 06:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348524AbjHQKWQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 17 Aug 2023 06:22:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB67198C;
        Thu, 17 Aug 2023 03:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692267735; x=1723803735;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Ss7gCg55nt/Mplxkim4ZflEyJooGqNvzgPK7BVhYsBc=;
  b=nCTgHA8wXthPIvDF3P3XgNrGSkfrMi1mdEYG5xvHq9Eq0A6dtGgZPPQ5
   tq23l0ZFmbyTfkKame9JmJZ/0FXSauENoNU+JhaZT5llus3p8kEotntVQ
   E9uCzGR8XTp2nRLG0l3FcZQ7OPgs6I27VyMTHGmEIFKxGrRNqxxFdPV4p
   /ov5+4buABIREyz/6DUm1uQPeJkhAZNJWtDcOPI/pNzVBWip2CyMOm9Ki
   Hk8KQgGf+Jh2x02QBV4Vc54JidnUCAJzCPhs/FpMfcmYKX72r7CursOjT
   MjorVu8cgsMub/YSppsdik1GhPxrNoSWNcnwSHegYJ5HN3P9FD3y036T5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="439123337"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="439123337"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 03:22:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="848837294"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="848837294"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 17 Aug 2023 03:22:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qWa8g-0070sj-0O;
        Thu, 17 Aug 2023 13:22:02 +0300
Date:   Thu, 17 Aug 2023 13:22:01 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jean Delvare <jdelvare@suse.de>,
        Vladimir Oltean <olteanv@gmail.com>, linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] iio: dac: ti-dac5571: Use i2c_get_match_data()
Message-ID: <ZN30yevtrxRrzmS5@smile.fi.intel.com>
References: <20230812090418.75020-1-biju.das.jz@bp.renesas.com>
 <ZNsm3efpkYlL4Gki@smile.fi.intel.com>
 <CAMuHMdVcQ06ydE7uEZ4kqM3A19exR1g+xAGSqiGXJ_KJpZYn-w@mail.gmail.com>
 <ZNusymsNh/zFgHg7@smile.fi.intel.com>
 <CAMuHMdUVCS_D0SBtDBrLQbAkdt0ZUbMOca+ukdwUtnGqzUr+cA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdUVCS_D0SBtDBrLQbAkdt0ZUbMOca+ukdwUtnGqzUr+cA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Aug 16, 2023 at 10:16:00AM +0200, Geert Uytterhoeven wrote:
> On Tue, Aug 15, 2023 at 6:50 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Aug 15, 2023 at 09:29:06AM +0200, Geert Uytterhoeven wrote:
> > > On Tue, Aug 15, 2023 at 9:19 AM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Sat, Aug 12, 2023 at 10:04:18AM +0100, Biju Das wrote:

...

> > > > > +     {.compatible = "ti,dac5571", .data = &dac5571_spec[single_8bit] },
> > > > > +     {.compatible = "ti,dac6571", .data = &dac5571_spec[single_10bit] },
> > > > > +     {.compatible = "ti,dac7571", .data = &dac5571_spec[single_12bit] },
> > > > > +     {.compatible = "ti,dac5574", .data = &dac5571_spec[quad_8bit] },
> > > > > +     {.compatible = "ti,dac6574", .data = &dac5571_spec[quad_10bit] },
> > > > > +     {.compatible = "ti,dac7574", .data = &dac5571_spec[quad_12bit] },
> > > > > +     {.compatible = "ti,dac5573", .data = &dac5571_spec[quad_8bit] },
> > > > > +     {.compatible = "ti,dac6573", .data = &dac5571_spec[quad_10bit] },
> > > > > +     {.compatible = "ti,dac7573", .data = &dac5571_spec[quad_12bit] },
> > > > > +     {.compatible = "ti,dac121c081", .data = &dac5571_spec[single_12bit] },
> > > >
> > > > I would reorder them a bit.
> > >
> > > Which is safe in this particular case...
> > > But not in general, as there might be fall-back compatible values.
> >
> > You mean the OF ID list must be specifically ordered?! What a nice minefield!
> > This has to be fixed somewhere else, surely.
> 
> Seems like it is, cfr. the scoring system in drivers/of/base.c
> __of_device_is_compatible().  Sorry for the confusion.
> 
> I still tend to order them in match tables though, from most-specific
> to least-specific.
> 
> Note that soc_device_match() (which is used less, fortunately) does
> not have such a scoring system, so order does matter there.

Should be fixed there, because it's a big downside of OF.

-- 
With Best Regards,
Andy Shevchenko


