Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37F3682E1F
	for <lists+linux-iio@lfdr.de>; Tue, 31 Jan 2023 14:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjAaNiM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Jan 2023 08:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbjAaNiK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Jan 2023 08:38:10 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA0029E10
        for <linux-iio@vger.kernel.org>; Tue, 31 Jan 2023 05:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675172287; x=1706708287;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=yqrH5h5bOVxWLUUBh/mFHYGGj/pTHat91loHT7C/hzU=;
  b=BqvViqdOEwjKaLYG4soDUA/FBY3p0YD2YOowdfEj8jUKonWCVGrJb0Lp
   awyBmQrBi/dG7Lx+dm3rvoeqr9vUzCUWqmGeo3DvaK9KPsIMoyA4UfQUx
   L4QYEH80Y3A7ciR6p32A6yGRovd3yWMNkLLpO6nOQWksZC58R7W/EDZR4
   F86oyDq7KZqZry+QCOy8fC82eMKTMuQw2pYVhV0st6nCdJl7YmyPRCYiO
   AMdMsmnwBx2bXWqA78yl30fFKWNH9I/ItYmTvm0mxtohJJaN9R6Er9GzN
   CDSZnnCYtBHsX2P76SIzKkI7/BFX8nkeznZNdmecAq7oUhqtthOLWB/4E
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="390202746"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="390202746"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 05:38:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="838387738"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="838387738"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 31 Jan 2023 05:38:01 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pMqpk-000Gu6-0S;
        Tue, 31 Jan 2023 15:38:00 +0200
Date:   Tue, 31 Jan 2023 15:37:59 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?iso-8859-1?Q?M=E5rten?= Lindahl <martenli@axis.com>
Cc:     =?iso-8859-1?Q?M=E5rten?= Lindahl <marten.lindahl@axis.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH v2] iio: light: vcnl4000: Fix WARN_ON on uninitialized
 lock
Message-ID: <Y9kZt0Me9xPp3MaZ@smile.fi.intel.com>
References: <20230131102951.2012021-1-marten.lindahl@axis.com>
 <Y9kKsv7OJ1KoImjJ@smile.fi.intel.com>
 <67f7888c-5d5b-4c63-42d3-cf2b15602478@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67f7888c-5d5b-4c63-42d3-cf2b15602478@axis.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jan 31, 2023 at 02:27:51PM +0100, Mårten Lindahl wrote:
> On 1/31/23 13:33, Andy Shevchenko wrote:
> > On Tue, Jan 31, 2023 at 11:29:51AM +0100, Mårten Lindahl wrote:

...

> > >   - Trimmed backtrace in commit message
> > Not enough, please try harder. The ideal is to have ~3-5 lines of traceback.
> 
> Hi Andy, Maybe I get it right soon ;). Could it perhaps be stripped like
> this?

Lockdep warning is important.

Assuming you left the warning still in place, almost there.

> Call trace:
> __mutex_lock
> mutex_lock_nested
> vcnl4200_set_power_state
> vcnl4200_init
> vcnl4000_probe

Can be cut out:

> i2c_device_probe

-- 
With Best Regards,
Andy Shevchenko


