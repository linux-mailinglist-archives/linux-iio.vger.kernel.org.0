Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBDD682E15
	for <lists+linux-iio@lfdr.de>; Tue, 31 Jan 2023 14:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbjAaNgP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Jan 2023 08:36:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232217AbjAaNgK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Jan 2023 08:36:10 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836FA518C6
        for <linux-iio@vger.kernel.org>; Tue, 31 Jan 2023 05:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675172166; x=1706708166;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=GwpIUhG7uRfVyEr3MWGnjz6l22kNs898ZHye4Zo1pUg=;
  b=lv27XRHEtfN6L16sIZ0oGsarLbLFItBqE1D5gOvG7+sJvIjnd5ToHMJi
   BbBHzG5r0QE6B12+HFUd18bL1YEI1Gc7/17aa1Cp7G3Br9HY/Os21nqwY
   d00jLBwMnvXa4QLmMAkOzxDp0tW8p7EMCVdBYpAA0eYQov/DO1Tuud2W3
   i5nTyeu9GqHbRQFbkzGeL/K9E6BTpttlFyumXXG5aF9qgFvyz5hApQIiV
   YlJALZyAhbrtjceztGCLR5qww+y8T1TWWqG/jTYH26cKXRfAQ1iGSrmTl
   lKWBw29UF7KueXSiQicwVMJ3HeH9Iyv7PKwdAwlOZPd+JJHZ40cF6KsC5
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="327856085"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="327856085"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 05:36:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="909907363"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="909907363"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 31 Jan 2023 05:36:04 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pMqnq-000GrN-25;
        Tue, 31 Jan 2023 15:36:02 +0200
Date:   Tue, 31 Jan 2023 15:36:02 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?iso-8859-1?Q?M=E5rten?= Lindahl <martenli@axis.com>
Cc:     Cai Huoqing <cai.huoqing@linux.dev>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH v2] iio: light: vcnl4000: Fix WARN_ON on uninitialized
 lock
Message-ID: <Y9kZQjYZfrkgHQBr@smile.fi.intel.com>
References: <20230131102951.2012021-1-marten.lindahl@axis.com>
 <Y9kNuPlRBVCnCHFb@chq-MS-7D45>
 <d1ab0530-ef51-988b-f8b3-c69f6d3abb8e@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d1ab0530-ef51-988b-f8b3-c69f6d3abb8e@axis.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jan 31, 2023 at 02:33:38PM +0100, Mårten Lindahl wrote:
> On 1/31/23 13:46, Cai Huoqing wrote:
> > On 31 1月 23 11:29:51, Mårten Lindahl wrote:

...

> > Why not add mutex_init(&data->vcnl4000_lock) in vcnl4200_init.
> > like this
> > 
> > @@ -330,6 +330,7 @@ static int vcnl4200_init(struct vcnl4000_data *data)
> >          }
> >          mutex_init(&data->vcnl4200_al.lock);
> >          mutex_init(&data->vcnl4200_ps.lock);
> > +       mutex_init(&data->vcnl4000_lock);
> > 
> >          ret = data->chip_spec->set_power_state(data, true);
> >          if (ret < 0)
> > 
> > Perfer adding mutex_init to vcnl4200_init.
> 
> Hi Cai!
> 
> This is what I did in v1, but I got a suggestion to move it to the probe
> instead.
> 
> Having it in probe takes one mutex_init. Otherwise it needs to be in two
> places (both init functions).

Exactly and if one more device will be added, we won't miss it, so it's less
error prone.

-- 
With Best Regards,
Andy Shevchenko


