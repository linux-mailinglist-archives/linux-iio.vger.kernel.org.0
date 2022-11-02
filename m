Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B510616428
	for <lists+linux-iio@lfdr.de>; Wed,  2 Nov 2022 14:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbiKBN5d (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Nov 2022 09:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKBN5c (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Nov 2022 09:57:32 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4612C1006D
        for <linux-iio@vger.kernel.org>; Wed,  2 Nov 2022 06:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667397451; x=1698933451;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=8L/RKcNHU6Kwo5etFQltNFCRDCpwOUP1vTrbmOP6A9w=;
  b=nSItBEAeyZwlKgBKFKFWdiuRPsEDMxtOxp4wLDonDlD08qdJGKvgfmOU
   1fSnp6bxG+cLRYZd//atY1nZxBIoBFDif5TgoJvtby0ki57YJEoVQ+agk
   GLLrJmfCJeoECqJJ1WTmginRC9XZ+aEETisIS+HhYwVDjgrvMbeqsJRki
   mjwm9leDdhqCuVejvqTd1I+bIMx6Nc2m6o8uxuC+Bnt/tObb0A7MNU9Yh
   fgwAPuvG481DsP+XUH1uyLSCK/inA9MkQoMRqReLXHnKX7u3zq1W1b9Gw
   9RU6Cha3C1rQYFodp4fszJHnGnbS5vNvBF6hJf55ufZcjcvMxsH10SZhx
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="336090812"
X-IronPort-AV: E=Sophos;i="5.95,234,1661842800"; 
   d="scan'208";a="336090812"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 06:57:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="739760147"
X-IronPort-AV: E=Sophos;i="5.95,234,1661842800"; 
   d="scan'208";a="739760147"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 02 Nov 2022 06:57:27 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oqEFB-006Clp-19;
        Wed, 02 Nov 2022 15:57:25 +0200
Date:   Wed, 2 Nov 2022 15:57:24 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Miaoqian Lin <linmq006@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>,
        Wolfram Sang <wsa@kernel.org>,
        Vladimir Oltean <olteanv@gmail.com>, kernel@pengutronix.de,
        Yang Yingliang <yangyingliang@huawei.com>,
        wangjianli <wangjianli@cdjrlc.com>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 10/23] iio: accel: kxcjk-1013: Convert to i2c's .probe_new
Message-ID: <Y2J3RMu6qNgozZ81@smile.fi.intel.com>
References: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
 <20221023132302.911644-11-u.kleine-koenig@pengutronix.de>
 <Y1WQoyek5KBwDqCd@smile.fi.intel.com>
 <20221024070518.dnrhsijfphbhs2la@pengutronix.de>
 <Y1ZPVw1qBx1MkZgY@smile.fi.intel.com>
 <20221024091456.vuw3mqcokfrbrozh@pengutronix.de>
 <Y1Ze2gw3hNgp6FT5@smile.fi.intel.com>
 <20221031233843.4rbcfs3hstlkv7il@pengutronix.de>
 <Y2EzPJvntyGbSKW8@smile.fi.intel.com>
 <20221101214939.seiuaj7un4cbcbpn@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221101214939.seiuaj7un4cbcbpn@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Nov 01, 2022 at 10:49:39PM +0100, Uwe Kleine-König wrote:
> On Tue, Nov 01, 2022 at 04:54:52PM +0200, Andy Shevchenko wrote:
> > On Tue, Nov 01, 2022 at 12:38:43AM +0100, Uwe Kleine-König wrote:
> > > On Mon, Oct 24, 2022 at 12:46:02PM +0300, Andy Shevchenko wrote:
> > > > On Mon, Oct 24, 2022 at 11:14:56AM +0200, Uwe Kleine-König wrote:

I really do appreciate your work on this, but it's pity that my point
is still unclear to you. As a beginning point I assume that the idea
of ->probe_new() is to mimic what SPI core does. That's why I consider
moving the tables is smelling like a half-baked work. Besides that
I tried to explain again on the concerns I have below.

...

> > > > Exactly. And it means let's put my problem to someone's else shoulders.
> > > 
> > > You have a problem that I fail to see. Why is defining the id table
> > > before the probe function bad?
> > > 
> > > Unless I misunderstand you, you seem to assume that in the nearer future
> > > someone will have the urge to put the id table below the probe function
> > > again. What would you think is their motivation?
> > 
> > The problem with moving the table is the sparse locations in the code for
> > semantically relative things, like all ID tables to be near to each other.
> 
> I don't understand that reasoning. Is that important for the compiler or
> the human reader? What is "semantically relative"?

If we have let's say 2+ ID tables, without your patches

...module code...

...TABLE 1...
...TABLE 2...

static struct foo_driver *drv = {
	...references to the tables...
};

With your patches (that move the ID table):


...module header...
...module code...

...TABLE 1...

...more module code...

...TABLE 2...

static struct foo_driver *drv = {
	...references to the tables...
};

which I consider as unneeded sparse for like you said micro-optimization
of the direct access to the table.

There are two ways to solve this:
- move all tables together
- provide an API as done by SPI core

I prefer the latter over the former.

> > With
> > your approach you can easily break that and go for let's put one ID table on
> > top, because some code fails to indirectly access it, and leave another
> > somewhere else. I do not like this.
> > 
> > Besides, your change making unneeded churn of "I like to move it, move it" for
> > no real gain.
> 
> That's not true. It's not that I like to move it. Moving is necessary to
> make use of the local symbol in .probe() without a forward declaration.
> (If you claimed that adding a forward declaration was churn, I'd agree.)

On forward declaration we agree.

But using local symbol directly as a shortcut to access some field of the
instance of some object is against OOP paradigm.

I.o.w. some shortcuts maybe nice, but this kind of approach leads to
layering violation and similar problems to begin with.

...

> > There is another approach in the discussion and Wolfram acknowledged it already
> > (with a new API to retrieve the necessary data).
> 
> Yeah, saw it. And as expected the follow up patch converting
> drivers/iio/pressure/bmp280-i2c.c "suffers" from the double pointer
> dereference. But it looks nice because the effort to determine the table
> via driver is well hidden.

Yes, that is the downside of OOP, I agree.

...

> > > > reduce churn with the using of current i2c_match_id() as you
> > > > showed the long line to get that table.
> > > 
> > > Do you still remember the original patch? That one doesn't have the long
> > > i2c_match_id() line.
> > > 
> > > (Do you see your statement is an argument for my approach? The long line
> > > is an indication that it's complicated to determine the address of the
> > > table via ->driver. You can hide that by pushing the needed effort into
> > > i2c_match_id() or a macro, but in the end the complexity remains for the
> > > CPU.)
> > 
> > Does it matter?
> 
> What is "it"? The long line? (Then no, it doesn't matter because it
> doesn't appear in neither your nor my approach.) The effort to pull the
> table's address out of ->driver? (We seem to disagree. I think it's easy
> enough not to do it to justify the optimisation.) Or to hide the effort?
> (I think hiding effort and so making it easy to pick a more expensive
> approach is at least questionable.)

IT == The length of dereferencing chain to get the pointer to the data
structure in question.

So, it is OOP model versus micro-optimization on a slow path.
That's how I can class the basis of our disagreement.

> > OTOH that will be aligned with SPI framework and idea behind ->probe_new()
> > as I understood it.

...

> What I consider "churn" though is this discussion.

I agree on that as well. Nut it's partially my issue and I'm sorry for that.

> I will stop my participation here. That's a bit sad because in my eyes all
> patches in this series have a positive value

Your patches (that don't move the tables) are nice job!

> and the discussion about (from
> my POV) incomprehensible minor details destroyed my motivation to work on
> the quest to convert all drivers to .probe_new() :-\

It's pity to hear, but you may also imagine how many times I was in
the similar situation and for some cases I lost my motivation, indeed.
I feel your pain.

-- 
With Best Regards,
Andy Shevchenko


