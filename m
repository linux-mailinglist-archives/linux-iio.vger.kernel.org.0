Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCFC4CB510
	for <lists+linux-iio@lfdr.de>; Thu,  3 Mar 2022 03:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbiCCCbQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Mar 2022 21:31:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbiCCCbQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Mar 2022 21:31:16 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D64846666;
        Wed,  2 Mar 2022 18:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646274631; x=1677810631;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=53qEpt+GyHLf4k/a7W4+7EOByfhH4Bt+FR6ZxJQZXFw=;
  b=VWDnTMmbgekfBXUS8uEY3TJJeBU6O9s/TpZ/p9cKHEpusrSqmrP2SX78
   TuV23y1HrAFuaLmUby7R1ephM03357mGBMEvKZcIgpwaOqx6wk6OfXDpE
   mQ1a9N2TiiALlzr5gJhb47cvP5oBs5ULPkCkgpVhRGeaCKKojyygj86Dv
   1KNes7zU7Q8mCbf1PiUVJJi/KjipaEoaVxTtSqxfoOME4ATEuMSZl90we
   G556QUCrXsQSWhrWR2NIE7wxMizX6uWGadYZkQ1dAZ1PRw7+VJxjKpL/R
   AwC7KAkXj1BanhbV6JX9dHrW+6KHvcYZGCtUmp7Ide5j6RY2KhGwbyYe9
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="251132928"
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="251132928"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 18:30:31 -0800
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="551532065"
Received: from rli9-dbox.sh.intel.com (HELO rli9-dbox) ([10.239.159.142])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 18:30:26 -0800
Date:   Thu, 3 Mar 2022 10:28:04 +0800
From:   Philip Li <philip.li@intel.com>
To:     Caleb Connolly <caleb.connolly@linaro.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Lee Jones <lee.jones@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        sumit.semwal@linaro.org, amit.pundir@linaro.org,
        john.stultz@linaro.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v8 2/9] mfd: qcom-spmi-pmic: expose the PMIC revid
 information to clients
Message-ID: <YiAntGyMdJnEjzsT@rli9-dbox>
References: <20220221220743.541704-1-caleb.connolly@linaro.org>
 <20220221220743.541704-3-caleb.connolly@linaro.org>
 <Yhft4zNcbD3ojN6i@builder.lan>
 <YhiYY/sXMvQ4VCZd@google.com>
 <20220225090452.GP3943@kadam>
 <YhigDPC6r7dTJUXd@google.com>
 <20220225094024.GQ3943@kadam>
 <da96bd50-e346-a20c-de53-561c996e826c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da96bd50-e346-a20c-de53-561c996e826c@linaro.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Mar 03, 2022 at 02:20:58AM +0000, Caleb Connolly wrote:
> 
> 
> On 25/02/2022 09:40, Dan Carpenter wrote:
> > On Fri, Feb 25, 2022 at 09:23:24AM +0000, Lee Jones wrote:
> > > On Fri, 25 Feb 2022, Dan Carpenter wrote:
> > > 
> > > > On Fri, Feb 25, 2022 at 08:50:43AM +0000, Lee Jones wrote:
> > > > > On Thu, 24 Feb 2022, Bjorn Andersson wrote:
> > > > > 
> > > > > > On Mon 21 Feb 16:07 CST 2022, Caleb Connolly wrote:
> > > > > > 
> > > > > > > Some PMIC functions such as the RRADC need to be aware of the PMIC
> > > > > > > chip revision information to implement errata or otherwise adjust
> > > > > > > behaviour, export the PMIC information to enable this.
> > > > > > > 
> > > > > > > This is specifically required to enable the RRADC to adjust
> > > > > > > coefficients based on which chip fab the PMIC was produced in,
> > > > > > > this can vary per unique device and therefore has to be read at
> > > > > > > runtime.
> > > > > > > 
> > > > > > > [bugs in previous revision]
> > > > > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > > > > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > > > > 
> > > > > > This says is that "kernel test robot" and Dan reported that something
> > > > > > needed to be fixed and this patch is the fix for this.
> > > > > > 
> > > > > > So even though their emails asks for you to give them credit like this
> > > > > > you can't do it for new patches.
> > > > > 
> > > > > Right, or else you'd have to give credit to anyone who provided you
> > > > > with a review.  This could potentially grow to quite a long list.
> > > > > 
> > > > 
> > > > I always feel like people who find crashing bugs should get credit but
> > > > no credit for complaining about style.  It's like we reward people for
> > > > reporting bugs after it gets merged but not before.
> > > > 
> > > > We've had this debate before and people don't agree with me or they say
> > > > that it's fine to just include the Reported-by kbuild tags and let
> > > > people figure out from the context that probably kbuild didn't tell
> > > > people to write a new driver.
> > > 
> > > Reviews will often consist of both style and logic recommendations.
> > > If not spotted and remedied, the latter of which would likely result
> > > in undesired behaviour a.k.a. bugs.  So at what point, or what type of
> > > bug would warrant a tag?
> > > 
> > 
> > If it's a crash or memory leak.  Style comments and fixing typos are
> > their own reward.  Basically it's the same rule as Fixes tags.  We
> > shouldn't use Fixes tags for typos.
> 
> Hi Dan,
> 
> How (if at all) would you like me to reference the bug reported by LKP
> in my next revision of this patch? It doesn't seem like a fixed conclusion
> was reached here.

Hi Caleb, this is Philip who maintains the LKP (0-day ci). You can ignore
the Reported-by tag freely.

This is confusing sometimes for this Reported-by tag, even we mention to
add it "as appropriately" to allow judgement from author for author's own
situation. Some author uses the style like "Reported-by: xxx # compiling bug fix"
but not all. We will look for how to improve this.

There's one discussion recently at https://lore.kernel.org/lkml/YfPzNNvK8Sy8YmGW@casper.infradead.org/T/
which also encourages to add Reported-by for new features or upstreamed code.

Thanks

> 
> It seems like Reported-by doesn't really represent things well, perhaps we
> could try for "Bugchecked-by" or something like that?
> > 
> > regards,
> > dan carpenter
> > 
> 
> -- 
> Kind Regards,
> Caleb (they/them)
> 
