Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8839792682
	for <lists+linux-iio@lfdr.de>; Tue,  5 Sep 2023 18:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbjIEQTQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 5 Sep 2023 12:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354559AbjIEMi5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 5 Sep 2023 08:38:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472D81A8
        for <linux-iio@vger.kernel.org>; Tue,  5 Sep 2023 05:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693917534; x=1725453534;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fNTkiZhB9yYSUArcTZ4dI30AGz//+VOyYJh2u4ztezA=;
  b=HpmRyfBaGBxFFnAYv+ysZxuaaCVpRDAC6W9zNWmqE3mx6Mz00cI2pc3n
   t5mDR3WYMZZ/b0vlw2fv9VEH+8eiUnilNEX5IQMFiF6tprip1V0SlADZE
   UaSU7VmoNLgtiCh/dc/KxCtZ2/+bsGSEuhfA97oYma8HwTadeZaTL1naS
   r6fKc7C9S27O6kASA8dfc8oCKvDh9aqQwnJDlIFJ+PwjYutdIMBC8bd9y
   Opo8ggsroNiApmZj6AxLP01H8Pur71XdoBnMOx6nt2NT04+InhffFUpul
   quv2aRpGobSmnWzs0kuoy1Svhi/h3FDj+d/tQWXS+WZyJcSly3bDPB/XM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="380592752"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="380592752"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 05:38:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="806588108"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="806588108"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 05:38:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qdVKS-006gcC-1O;
        Tue, 05 Sep 2023 15:38:48 +0300
Date:   Tue, 5 Sep 2023 15:38:48 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tomas Melin <tomas.melin@vaisala.com>,
        Peter Rosin <peda@axentia.se>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, jic23@kernel.org, lars@metafoo.de,
        u.kleine-koenig@pengutronix.de
Subject: Re: [PATCH] iio: adc: ti-ads1015: support deferred probe
Message-ID: <ZPchWPSiy8J/3hX9@smile.fi.intel.com>
References: <20230904101533.455896-1-tomas.melin@vaisala.com>
 <ZPW+MXuBSYEE1GfF@smile.fi.intel.com>
 <20230904141251.00002b7d@Huawei.com>
 <848d639c-43d1-bf92-2292-059dd1a019cf@vaisala.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <848d639c-43d1-bf92-2292-059dd1a019cf@vaisala.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

+Cc: Peter to look from the i2c mux point of view on the issue.

On Tue, Sep 05, 2023 at 02:43:19PM +0300, Tomas Melin wrote:
> On 04/09/2023 16:12, Jonathan Cameron wrote:
> > On Mon, 4 Sep 2023 14:23:29 +0300
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >> On Mon, Sep 04, 2023 at 01:15:22PM +0300, Tomas Melin wrote:

> >>> Support deferred probe for cases where communication on
> >>> i2c bus fails. These failures could happen for a variety of
> >>> reasons including bus arbitration error or power failure.  

...

> >>> +out:
> >>> +	if ((ret == -EAGAIN) || (ret == -ENXIO))
> >>> +		return -EPROBE_DEFER;
> >>> +	return ret;  
> >>
> >> Oh my... This looks so-o hackish.
> > 
> > Agreed.  This is a non starter.
> > 
> >> If anything, it has to be fixed on the level of regmap I2C APIs or so.
> >>
> >> Maybe something like regmap_i2c_try_write()/try_read() new APIs that
> >> will provide the above. Otherwise you want to fix _every single driver_
> >> in the Linux kernel
> > 
> > Any probe ordering dependencies should be described by the
> > firmware and the driver should 'get' the relevant resource.
> > If there is anything not describable today then that is what we need
> > to fix, not paper over the holes
> > 
> > So can we have specifics of what is happening here?
> > 
> > If it's arbitration with some other entity then fix the arbitration
> > locking / hand over. If it's power, then make sure the relevant
> > regulator get gotten and turned on + has the right delays etc.
> 
> Yes, right. In this use case, the ads1015 is connected to a channel of
> a i2c multiplexer. When the mux is probed, it also enumerates all the
> multiplexed buses and probes devices connected to them.
> For some reason, it behaves so that the ads1015 is not detected on the
> first attempt. Since it's a mux, connected to main i2c line, perhaps
> there really is some bus arbitration issue, or then something else.
> 
> Anyways, when deferring the probe for the ads1015, and attempting later
> again it probes fine.
> 
> So, it might be I've taken the wrong angle at this issue, but
> it does solve the issue at hand. Obviously, there could be some issue
> with the i2c mux driver, or then on hardware level too.
> 
> Point is, that if the communication to the i2c bus has some temporary
> error like EAGAIN, why could it not be reasonable to try again at a
> later time instead of giving up completely.

-- 
With Best Regards,
Andy Shevchenko


