Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E80466E2F3
	for <lists+linux-iio@lfdr.de>; Tue, 17 Jan 2023 17:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjAQQAC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Jan 2023 11:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbjAQP7v (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Jan 2023 10:59:51 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499862BF26
        for <linux-iio@vger.kernel.org>; Tue, 17 Jan 2023 07:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673971190; x=1705507190;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=O8FIb+vp3um71H3NJHK/7gsHhNElnEPLVetCs9gQGkE=;
  b=RyzsDnN2mavHS9FUypVBF+ChUG7F+fat0UNO9WWZPmOut9zEwKqzkypD
   BQuhr2xyEcHOPi1BZRB4uSAiLfBWqafrsciH0wk42ZNDBPcT6l/R1pUfE
   7clfEEV0FRw6q/2I5H7Z1aERncyv1ntWs5vfWMiGuFfubMn02YmsDoqHY
   2bSN5hzwpEpQmcsDlTIrfi6PwfSf1f5zFpDPFSrsSMBLlDybSCKHfg0rs
   YGOCWec12L1GGVs80ms+9x0Kd1hzGQldyU0H0ybQ2Ro7GE2xBuc7jQRQs
   1948ynLRPQd2dt/9Iq/ka9qbhL60AuNOkVxzmwc9WiBi+88/wMmicDrlC
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="304414701"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="304414701"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 07:59:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="727831145"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="727831145"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 17 Jan 2023 07:59:48 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pHoNH-00AeCn-0D;
        Tue, 17 Jan 2023 17:59:47 +0200
Date:   Tue, 17 Jan 2023 17:59:46 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?iso-8859-1?Q?M=E5rten?= Lindahl <marten.lindahl@axis.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH v4 3/3] iio: light: vcnl4000: Add interrupt support for
 vcnl4040
Message-ID: <Y8bF8oeBWGbs7zE4@smile.fi.intel.com>
References: <20230117152435.3510319-1-marten.lindahl@axis.com>
 <20230117152435.3510319-4-marten.lindahl@axis.com>
 <Y8bFvovmqKCO6fVC@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y8bFvovmqKCO6fVC@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jan 17, 2023 at 05:58:54PM +0200, Andy Shevchenko wrote:
> On Tue, Jan 17, 2023 at 04:24:35PM +0100, Mårten Lindahl wrote:

...

> > +	val = ret;
> > +
> > +	if (dir == IIO_EV_DIR_RISING)
> > +		val = state ? (val | VCNL4040_PS_IF_AWAY) :
> > +		    (val & ~VCNL4040_PS_IF_AWAY);
> > +	else
> > +		val = state ? (val | VCNL4040_PS_IF_CLOSE) :
> > +		    (val & ~VCNL4040_PS_IF_CLOSE);
> 
> 
> Wouldn't be better
> 
> 	uXX val, mask;
> 
> 
> 	if (dir == IIO_EV_DIR_RISING)
> 		mask = VCNL4040_PS_IF_AWAY;
> 	else
> 		mask = VCNL4040_PS_IF_CLOSE;
> 
> 	val = state ? (val | mask) : (val & ~mask);

Of course I meant

	val = state ? (ret | mask) : (ret & ~mask);

> ?

-- 
With Best Regards,
Andy Shevchenko


