Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF2C781132
	for <lists+linux-iio@lfdr.de>; Fri, 18 Aug 2023 19:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377759AbjHRREm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Aug 2023 13:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378911AbjHRREi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Aug 2023 13:04:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE9B10C0;
        Fri, 18 Aug 2023 10:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692378277; x=1723914277;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=jQpQLbZDv97aKF5UDVT3TwVaSF8Gz3GtlMhp1lfjfBA=;
  b=SWq1b1HW9Vubl1om7+DIJtkiKLb6yJQkydqhZjvgXfr/obKJZaEO46Vu
   eOFLGxIDTav7C+ZusFepr7L74KuxFzwCfrnmJaP0oU6hEA3vrhx/jf9w3
   d5XcVFkWwM6rlmwvu/8chqCcu2YcvtcZeUarnBirIl8BJqr0EE5KAGvfM
   29Lfa7D35LnugqYEk1EB60uC/6ptBboQ0dToU1qQAFXL1KJrxSAr5LDYu
   Ks4LPxWqjXF/YOKwGcMAJISQs/uibtwfgqWWncVkDUo3W0KcYlc4GeAFU
   XxhF1uP2mHFU7H88+SZasKZY0GYeQmVtfS1KSgVziuLETOu1QjDd+JvXB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="376906589"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="376906589"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 10:04:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="712074162"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="712074162"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 18 Aug 2023 10:04:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qX2th-00H4lp-0o;
        Fri, 18 Aug 2023 20:04:29 +0300
Date:   Fri, 18 Aug 2023 20:04:28 +0300
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
Message-ID: <ZN+knFD5pFilfBcT@smile.fi.intel.com>
References: <20230818075600.24277-1-biju.das.jz@bp.renesas.com>
 <20230818075600.24277-6-biju.das.jz@bp.renesas.com>
 <ZN9WVvo+pixspCsw@smile.fi.intel.com>
 <CAMuHMdX0cnPDNHdUoquGTzZJE-CD81Lor=3q+j36rJyS23mJqw@mail.gmail.com>
 <ZN+PpLsAayzfgTtb@smile.fi.intel.com>
 <CAMuHMdXAG8JmOaGzeRd8kgoZqMmG1Qf7PFjZFJiQBXpp9Sa8pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdXAG8JmOaGzeRd8kgoZqMmG1Qf7PFjZFJiQBXpp9Sa8pg@mail.gmail.com>
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

On Fri, Aug 18, 2023 at 05:43:15PM +0200, Geert Uytterhoeven wrote:
> On Fri, Aug 18, 2023 at 5:35 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, Aug 18, 2023 at 04:55:18PM +0200, Geert Uytterhoeven wrote:
> > > On Fri, Aug 18, 2023 at 1:30 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Fri, Aug 18, 2023 at 08:56:00AM +0100, Biju Das wrote:
> > > > > Sort OF table alphabetically by compatibles.
> > > >
> > > > > Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > >
> > > > Wrong, I haven't suggested that. See comment to the previous patch.
> > > >
> > > > And this is definitely wrong as Geert explained already why.
> > > > You need to fix the code that handles the ID table first.
> > >
> > > I retracted my own comment:
> > > https://lore.kernel.org/r/CAMuHMdUVCS_D0SBtDBrLQbAkdt0ZUbMOca+ukdwUtnGqzUr+cA@mail.gmail.com
> > >
> > > Upon a second read, I agree my reply
> > >
> > >     Seems like it is, cfr. the scoring system in drivers/of/base.c
> > >
> > > was confusing, as it was not super clear if it was a response to the
> > > first or the second line of your comment:
> > >
> > >     You mean the OF ID list must be specifically ordered?! What a nice
> > > minefield!
> > >     This has to be fixed somewhere else, surely.
> > >
> > > Conclusion: there is no issue, the scoring system handles primary
> > > vs. fallback compatible values, irrespective of ordering.
> >
> > Now I'm totally confused. Previously you mentioned a couple of
> > different APIs — one in OF, one in SoC. AFAIU the second one
> > still needs to be fixed to follow the logic that OF does.
> >
> > My previous understanding was that
> >   OF code — no issue
> >   SoC code — the ordering is required to be correct
> 
> Correct.
> 
> > Can you confirm that there is no issue in that second case?
> > And if there is none, why did you mention it?
> 
> There is still an issue (read: you have to be careful) in the second
> case, which does not matter here, as this driver does not use
> soc_device_match().
> I mentioned soc_device_match() because it is the second popular way
> to match on OF platforms, but behaves slightly different than
> of_match_node().

Now it's clear, thanks.
Biju, please add that to the commit message.

-- 
With Best Regards,
Andy Shevchenko


