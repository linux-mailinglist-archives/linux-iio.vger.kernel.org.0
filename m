Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B302D682CAE
	for <lists+linux-iio@lfdr.de>; Tue, 31 Jan 2023 13:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjAaMhf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Jan 2023 07:37:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbjAaMhc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Jan 2023 07:37:32 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491A34DCCA
        for <linux-iio@vger.kernel.org>; Tue, 31 Jan 2023 04:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675168646; x=1706704646;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=fAOS0e5g0uC+YwV4s6KTO9nmwK9JNYvPO28Po+j5wbE=;
  b=N3SL0J+0oFO3t7w9suAAtYe++G9JvUVbBuf9YYpxYBLaIPZaJWG60wSS
   TbLY0UWHYCCzvuQvm/R+7nGzeBVVPMv4n6n/agYkf3Qwmu3dj8XA3A1T7
   QuIUn/banqqTeXP0hxCXN2ZasBz3Y9Slv7nnm88zRObKzRDq2/g6u7vrY
   4ovGXQgiQuoeIk5X7diRLKbuseVvTDuk0/I+q6OKzpIlSh7wxM4MPw10w
   dzYLtjSGY3lutOPKbE8DgbmJ3RGqVexYzh3lkn6xa8IXmfUyJR0hpLYM2
   aqyCZS3bux/xhrzMuE1uM4wu0Gd1FyoaQtuliLfB/MFb9+nKo5j/LlCmQ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="325524641"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="325524641"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 04:37:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="733094796"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="733094796"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 31 Jan 2023 04:37:21 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pMpt2-000FUX-0t;
        Tue, 31 Jan 2023 14:37:20 +0200
Date:   Tue, 31 Jan 2023 14:37:20 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?iso-8859-1?Q?M=E5rten?= Lindahl <marten.lindahl@axis.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH v2] iio: light: vcnl4000: Fix WARN_ON on uninitialized
 lock
Message-ID: <Y9kLgOHRCJqNXkG4@smile.fi.intel.com>
References: <20230131102951.2012021-1-marten.lindahl@axis.com>
 <Y9kKsv7OJ1KoImjJ@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y9kKsv7OJ1KoImjJ@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jan 31, 2023 at 02:33:54PM +0200, Andy Shevchenko wrote:
> On Tue, Jan 31, 2023 at 11:29:51AM +0100, Mårten Lindahl wrote:

...

> >  - Trimmed backtrace in commit message
> 
> Not enough, please try harder. The ideal is to have ~3-5 lines of traceback.

Just to clarify, the above example (in previous mail) under "E.g." is just to
show the way of thinking about the traceback data significance. Looking at the
whole traceback I believe ~7 lines is what should be left in the result.

-- 
With Best Regards,
Andy Shevchenko


