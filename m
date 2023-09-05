Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AECA97925B1
	for <lists+linux-iio@lfdr.de>; Tue,  5 Sep 2023 18:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237631AbjIEQTW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 5 Sep 2023 12:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354332AbjIEKpz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 5 Sep 2023 06:45:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C04199
        for <linux-iio@vger.kernel.org>; Tue,  5 Sep 2023 03:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693910748; x=1725446748;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HNPwCnC1djlcmIxUV2dUyoA7cOsHxuuhbGyWpmkIKQw=;
  b=FF+pk4Y/lYRTMonjajRwsjHuyLePcPNOaQAl4ICTK7hnm0A6rdbT+qwY
   OYrqeM1i5LOnIScghiCJdiV184M94fDdxcr2irf5lwUOPxs+Ri0w3+US3
   9rMf5ZWtGWO4giXCaaopwLe0VyQCOubB2RCKInhsdhmdPvoSHXifSCkDq
   ASIiJea9Ok/bQ9mZxYyt9C54oAGHmZ3erLdst4kQwYb5NWdrpOIGWvKbK
   dCzniygcxYyX8yNxQT5oQSh+Cuanq/5tB28l3ouhT9H6mTGwc2gnvC8Uq
   IWxnjsUt27rjm4Pz4olO60rVUTybQsh4gPbrOa1hnf5n4BFTmWoLjH7wu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="443162580"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="443162580"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 03:45:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="884275198"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="884275198"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 03:45:33 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qdTYw-006evp-0v;
        Tue, 05 Sep 2023 13:45:38 +0300
Date:   Tue, 5 Sep 2023 13:45:37 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tomas Melin <tomas.melin@vaisala.com>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org, lars@metafoo.de,
        u.kleine-koenig@pengutronix.de
Subject: Re: [PATCH] iio: adc: ti-ads1015: support deferred probe
Message-ID: <ZPcG0fzoMU5OMave@smile.fi.intel.com>
References: <20230904101533.455896-1-tomas.melin@vaisala.com>
 <ZPW+MXuBSYEE1GfF@smile.fi.intel.com>
 <e12f3459-7025-89a1-704b-209391cb8f55@vaisala.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e12f3459-7025-89a1-704b-209391cb8f55@vaisala.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Sep 05, 2023 at 09:13:28AM +0300, Tomas Melin wrote:
> On 04/09/2023 14:23, Andy Shevchenko wrote:
> > On Mon, Sep 04, 2023 at 01:15:22PM +0300, Tomas Melin wrote:

...

> >> +out:
> >> +	if ((ret == -EAGAIN) || (ret == -ENXIO))
> >> +		return -EPROBE_DEFER;
> >> +	return ret;
> > 
> > Oh my... This looks so-o hackish.> If anything, it has to be fixed on the level of regmap I2C APIs or
> so.As such this does fix a real world issue. Providing some helpers for
> this on regmap level would probably be great. To add such an API I
> suspect there should first be existing users for it, and this would be
> one example.
> Until there would be such an generic API, I'm not sure if there are many
> other alternatives than to check for invalid returns and defer the probe.

As Jonathan said, please try to elaborate better what the real word issue is,
how it can be reproduced, etc.

-- 
With Best Regards,
Andy Shevchenko


