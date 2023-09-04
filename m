Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07EF279162D
	for <lists+linux-iio@lfdr.de>; Mon,  4 Sep 2023 13:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350249AbjIDLXi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Sep 2023 07:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352783AbjIDLXi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Sep 2023 07:23:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE61C1AB
        for <linux-iio@vger.kernel.org>; Mon,  4 Sep 2023 04:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693826614; x=1725362614;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wHzBjqWujwA+QopF4QZ8KMuZ34E3CKVcZkX+ifLsU1c=;
  b=S1C3Ljtj62PjcZCEe49Wr/YUAVSFc9ddC9BECMUGdvP4ex45Nu29m8/K
   8WDq1f8b/cepVK0GtmB1jwsP7Npx0Wb8bAE/0l5lsua2HWFhDgbQ5sxXT
   VxdVAWUcwy2N3h/0BsgPlKoj1AlAMR/LQ/aQ3n6KbLeeWNa64nfkqwcUI
   6nZVrE4XI4EJEkhC1VG4HHG7q9BogioyZRLD7wWmFZMdNmBtK55At9hWE
   W0W0Wj5Voe4AUnps2GLyAJx+iTzb9aeAHWXP9Rt1DNL7HNmDfGCStHmvD
   PKAEKoNYh45Cb/og+2lC3JBJFlD/3stI+Jc2AgMkBpebKLb8AcImeGMKm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="380377638"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="380377638"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 04:23:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="914478701"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="914478701"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 04:23:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qd7g1-006PVs-2z;
        Mon, 04 Sep 2023 14:23:29 +0300
Date:   Mon, 4 Sep 2023 14:23:29 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tomas Melin <tomas.melin@vaisala.com>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org, lars@metafoo.de,
        u.kleine-koenig@pengutronix.de
Subject: Re: [PATCH] iio: adc: ti-ads1015: support deferred probe
Message-ID: <ZPW+MXuBSYEE1GfF@smile.fi.intel.com>
References: <20230904101533.455896-1-tomas.melin@vaisala.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230904101533.455896-1-tomas.melin@vaisala.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Sep 04, 2023 at 01:15:22PM +0300, Tomas Melin wrote:
> Support deferred probe for cases where communication on
> i2c bus fails. These failures could happen for a variety of
> reasons including bus arbitration error or power failure.

> +out:
> +	if ((ret == -EAGAIN) || (ret == -ENXIO))
> +		return -EPROBE_DEFER;
> +	return ret;

Oh my... This looks so-o hackish.
If anything, it has to be fixed on the level of regmap I2C APIs or so.

Maybe something like regmap_i2c_try_write()/try_read() new APIs that
will provide the above. Otherwise you want to fix _every single driver_
in the Linux kernel

...

$ git grep -lw builtin_i2c_driver | wc
      5       5     123
$ git grep -lw module_i2c_driver | wc
      1164    1164   35240

(and more that don't use either of the above macros).

-- 
With Best Regards,
Andy Shevchenko


