Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26797CF886
	for <lists+linux-iio@lfdr.de>; Thu, 19 Oct 2023 14:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235441AbjJSMQF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Oct 2023 08:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235357AbjJSMQA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Oct 2023 08:16:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFC6273B;
        Thu, 19 Oct 2023 05:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697717162; x=1729253162;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wbG6VSsrlBl4hddw+r+h9iIxWdmh5TUrrYv38LQnvNk=;
  b=mclnZkFHN4nuVo2N4KShG5HFnavnTF3ghl8speQvvEfbnhzSrvJwlu8m
   dxYkq81SgQMY7+gvQsqsaqL7nE2yBo8sLWNt6+AVJ/QFqsXOLfaMjy2GP
   gqwa4kxMTmQD3yGRlFQ0ITUwi5xM5czEK71gDPaJ4fzYhV2t3efOkP4VD
   A30dhnKB6MEukZbymT9HjguqCaZkOgGZBKLe6waOH6FOghDCWONYZgQw0
   dyNbgv6c9w8f9nnyGSqmmS0sPuNnefYkT0QEgG50ITbRHLAKnajl/kIE0
   ZBRjKzrN6oDTHAve1IBHFCfmntlkLI5Rly1JYGWXCaRqXy9MA/W6pkOaB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="452702485"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="452702485"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 05:04:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="750481206"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="750481206"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 05:04:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qtRlG-00000006r4i-2EQa;
        Thu, 19 Oct 2023 15:04:22 +0300
Date:   Thu, 19 Oct 2023 15:04:22 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        =?iso-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>,
        Jonathan Cameron <jic23@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v2 1/5] iio: magnetometer: ak8975: Convert enum->pointer
 for data in the match tables
Message-ID: <ZTEbRsofu6H4eeGT@smile.fi.intel.com>
References: <20230818075600.24277-2-biju.das.jz@bp.renesas.com>
 <5e0d2716fb757d408ebe77cb132ae242ef3aa470.camel@apitzsch.eu>
 <CAMuHMdUTxQym7+vYPtnvMQeH8GKSk0iOyuMnLkgr3LH1E8TTYA@mail.gmail.com>
 <20231018204533.39399b0b@jic23-huawei>
 <82b99e17f45b09623eeaed12e4fac12609c15426.camel@apitzsch.eu>
 <TYCPR01MB11269EEF17ABCE541CC7B38CE86D4A@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <TYCPR01MB11269D21D7DD5356A64E5679586D4A@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <ZTD0UN4+wQjguCDF@smile.fi.intel.com>
 <TYCPR01MB11269269A3237CC119644F4D286D4A@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <20231019121722.00007e6e@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019121722.00007e6e@Huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Oct 19, 2023 at 12:17:22PM +0100, Jonathan Cameron wrote:
> On Thu, 19 Oct 2023 09:41:06 +0000
> Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > > Subject: Re: [PATCH v2 1/5] iio: magnetometer: ak8975: Convert enum-  
> > > >pointer for data in the match tables  
> > > On Thu, Oct 19, 2023 at 07:08:23AM +0000, Biju Das wrote:  
> > > > > Subject: RE: [PATCH v2 1/5] iio: magnetometer: ak8975: Convert enum-  

...

> > > > > As mentioned in the patch.
> > > > > /* If enumerated via firmware node, fix the ABI */
> > > > >
> > > > > Looks like this issue is not introduced by this patch.
> > > > > The previous code uses device_get_match_data() which returns a match
> > > > > as it uses DT node and it uses dev_name(&client->dev) instead of
> > > > > id->name;
> > > > >
> > > > > Am I missing anything here? If it is just a test program, can it be  
> > > fixed??  
> > > > >
> > > > > Please correct me if I am wrong.  
> > > >
> > > > I just realized that there is no .data in previous code for OF tables.
> > > >
> > > > Maybe we should add a check, if it is DT node, return id->name?
> > > >
> > > > Is there any API to distinguish DT node from ACPI??  
> > > 
> > > Of course, but I discourage people to use that, you have to have a very
> > > good justification why you need it (and this case doesn't sound good enough
> > > to me, or please elaborate). Hence I leave it as a homework to find those
> > > APIs.  
> > 
> > Andre, complained that his test app is broken with this patch. I am waiting for his response whether he can fix his test app? 
> > If not, we need to find a solution. One solution
> > is adding a name variable and use consistent name across
> > OF/ACPI/I2C tables for various devices.
> > 
> > Other solution is just add this check,

> > if (dev_fwnode(&client->dev) && !(IS_ENABLED(CONFIG_OF) && dev->of_node))

Taking the Jonathan's comment below into consideration we can do _something_
like above, but using only a single API call instead of this ugly and monstrous
condition.

> > 	name = dev_name(&client->dev);
> > else
> > 	name = id->name;
> 
> Given this is a userspace regression (caused by accidental "fix" - I missed
> the fact it had this impact :(), I think it is valid to special case the ACPI in this rare
> case but definitely needs a big fat comment saying why we are doing it and that it
> should not be copied into other drivers!!!
> 
> If we can get away with fixing the original (many years old ABI misuse - but IIRC from a time
> where our ABI docs were lacking) then I'm keen on doing so, but I doubt we can.
> Definitely don't want to accidentally spread that bug though to new cases!

-- 
With Best Regards,
Andy Shevchenko


