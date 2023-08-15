Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9BB77D05D
	for <lists+linux-iio@lfdr.de>; Tue, 15 Aug 2023 18:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238578AbjHOQu0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Aug 2023 12:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238594AbjHOQuZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Aug 2023 12:50:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D51C1B5;
        Tue, 15 Aug 2023 09:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692118224; x=1723654224;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=xdukeKdTluwoMnyduKt+1RgIaLQYrs1HJOdTlBpzsAs=;
  b=TTEMmx5e9Q9LNvipGFTwX66qqeSZ2HiwmkzFQqiY+Sa5BgiZmyKf/fkJ
   8FlVCs6vgTjCY97kuRbZBcYRzqMcZr4/vIsyaMI2aQ+DkYqngC8Y5D4ju
   oz1Os/Zj4buG8HxftJrp5E8WzcZ6esmyUV+JPQsSvY+j/+dDcT0qCcufF
   XSjCm10aif2N20y1I9rhRSjf7auFf2/c3mu0iVpvYVuuqeZGzLccxG651
   AMKrDLHb0Hkgt6YkzzgfNaOKGqd4FMglcuYiCZ4+qTml56A4LlDj+tsU8
   RNWt3IB7pf/8DqMTPAR1VfmdOD57KKrVyosGEq6lwT70ZtBZ0k629qq0g
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="436217514"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="436217514"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 09:50:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="727423065"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="727423065"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 15 Aug 2023 09:50:20 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qVxFK-00A7aM-1E;
        Tue, 15 Aug 2023 19:50:18 +0300
Date:   Tue, 15 Aug 2023 19:50:18 +0300
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
Message-ID: <ZNusymsNh/zFgHg7@smile.fi.intel.com>
References: <20230812090418.75020-1-biju.das.jz@bp.renesas.com>
 <ZNsm3efpkYlL4Gki@smile.fi.intel.com>
 <CAMuHMdVcQ06ydE7uEZ4kqM3A19exR1g+xAGSqiGXJ_KJpZYn-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdVcQ06ydE7uEZ4kqM3A19exR1g+xAGSqiGXJ_KJpZYn-w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Aug 15, 2023 at 09:29:06AM +0200, Geert Uytterhoeven wrote:
> On Tue, Aug 15, 2023 at 9:19 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Sat, Aug 12, 2023 at 10:04:18AM +0100, Biju Das wrote:
> > > Replace device_get_match_data() and id lookup for retrieving match data
> > > by i2c_get_match_data() by converting enum->pointer for data in the
> > > match table.

...

> > > +     {.compatible = "ti,dac5571", .data = &dac5571_spec[single_8bit] },
> > > +     {.compatible = "ti,dac6571", .data = &dac5571_spec[single_10bit] },
> > > +     {.compatible = "ti,dac7571", .data = &dac5571_spec[single_12bit] },
> > > +     {.compatible = "ti,dac5574", .data = &dac5571_spec[quad_8bit] },
> > > +     {.compatible = "ti,dac6574", .data = &dac5571_spec[quad_10bit] },
> > > +     {.compatible = "ti,dac7574", .data = &dac5571_spec[quad_12bit] },
> > > +     {.compatible = "ti,dac5573", .data = &dac5571_spec[quad_8bit] },
> > > +     {.compatible = "ti,dac6573", .data = &dac5571_spec[quad_10bit] },
> > > +     {.compatible = "ti,dac7573", .data = &dac5571_spec[quad_12bit] },
> > > +     {.compatible = "ti,dac121c081", .data = &dac5571_spec[single_12bit] },
> >
> > I would reorder them a bit.
> 
> Which is safe in this particular case...
> But not in general, as there might be fall-back compatible values.

You mean the OF ID list must be specifically ordered?! What a nice minefield!
This has to be fixed somewhere else, surely.

-- 
With Best Regards,
Andy Shevchenko


