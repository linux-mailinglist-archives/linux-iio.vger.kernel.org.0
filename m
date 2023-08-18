Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E01780F48
	for <lists+linux-iio@lfdr.de>; Fri, 18 Aug 2023 17:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357510AbjHRPfz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Aug 2023 11:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378195AbjHRPf3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Aug 2023 11:35:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D646F2D5A;
        Fri, 18 Aug 2023 08:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692372928; x=1723908928;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=aHPesWzI2q66E3D2T90Mmbv5OkczsTXWcHwv/MUk1F8=;
  b=SB1nzBJxFS9D848kk4MLT59IMuUkKCd4pvaLFsWoqgjCcVxJpkYSWNQ6
   /dICER2P/N6G07S2bdweqs7PhW3EPI5T29p+de41AdoAoD8NZ3bsn5sz7
   J+caRiGCjadmSuyNWJ9ePfEaWpB29vNgrxZIoCto5Jebixo5w3ryLXikR
   YsdMcubpw+s0XvQ2qwNOhBrWMu24O1ahiBFvaD0zYZ7LNazOOTwyBVnxV
   uG2qdZdouK6xj+KgmDcdevAstfjTExwYUTy7b6RVnKqju8u4a4y/zdjnp
   qpnFoyhDnuXVJzJVZt8e1ZcYcEYxpB6FXHZYMCTuguqxFT/NcdAlpdoJC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="375904366"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="375904366"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 08:35:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="770170999"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="770170999"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 18 Aug 2023 08:35:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qX1V7-00E5ai-0T;
        Fri, 18 Aug 2023 18:35:01 +0300
Date:   Fri, 18 Aug 2023 18:35:00 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 5/5] iio: magnetometer: ak8975: Sort OF table
Message-ID: <ZN+PpLsAayzfgTtb@smile.fi.intel.com>
References: <20230818075600.24277-1-biju.das.jz@bp.renesas.com>
 <20230818075600.24277-6-biju.das.jz@bp.renesas.com>
 <ZN9WVvo+pixspCsw@smile.fi.intel.com>
 <CAMuHMdX0cnPDNHdUoquGTzZJE-CD81Lor=3q+j36rJyS23mJqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdX0cnPDNHdUoquGTzZJE-CD81Lor=3q+j36rJyS23mJqw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Aug 18, 2023 at 04:55:18PM +0200, Geert Uytterhoeven wrote:
> On Fri, Aug 18, 2023 at 1:30 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, Aug 18, 2023 at 08:56:00AM +0100, Biju Das wrote:
> > > Sort OF table alphabetically by compatibles.
> >
> > > Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> > Wrong, I haven't suggested that. See comment to the previous patch.
> >
> > And this is definitely wrong as Geert explained already why.
> > You need to fix the code that handles the ID table first.
> 
> I retracted my own comment:
> https://lore.kernel.org/r/CAMuHMdUVCS_D0SBtDBrLQbAkdt0ZUbMOca+ukdwUtnGqzUr+cA@mail.gmail.com
> 
> Upon a second read, I agree my reply
> 
>     Seems like it is, cfr. the scoring system in drivers/of/base.c
> 
> was confusing, as it was not super clear if it was a response to the
> first or the second line of your comment:
> 
>     You mean the OF ID list must be specifically ordered?! What a nice
> minefield!
>     This has to be fixed somewhere else, surely.
> 
> Conclusion: there is no issue, the scoring system handles primary
> vs. fallback compatible values, irrespective of ordering.

Now I'm totally confused. Previously you mentioned a couple of
different APIs — one in OF, one in SoC. AFAIU the second one
still needs to be fixed to follow the logic that OF does.

My previous understanding was that
  OF code — no issue
  SoC code — the ordering is required to be correct

Can you confirm that there is no issue in that second case?
And if there is none, why did you mention it?

-- 
With Best Regards,
Andy Shevchenko


