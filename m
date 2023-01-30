Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B8A680DE8
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jan 2023 13:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235170AbjA3Mkl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Jan 2023 07:40:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjA3Mkk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Jan 2023 07:40:40 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D988135
        for <linux-iio@vger.kernel.org>; Mon, 30 Jan 2023 04:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675082440; x=1706618440;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=lc6FfgcNB4rKr9lZDnlC3ixZkEpXf6JgPUs0td1pVVw=;
  b=FDThkr2ziZc63FQEKN8rjDVajVeMtf/oTl1DkJg0Z49fCyBWW0+K0f1s
   OZvLMMakbEuGC7Qx3S42jOA0mV36zRuHnk3F0pZM3Ja5ra7wR4cuKQTCe
   llOJRN0m3CDDNb1FXAUw7qz7SGX59xHh1I314IkOPClF0nnXYFsCQO8d7
   gkU9qUVrX/nHY6gG3eZxzXbn27hysX50ATanC3fnf0o/93E8pH12WpeY4
   Oz7QyGH/HdYSTy7DJ1ARf/u7Hmr9jTImYa5wlQw1+SOGmK/G7fXuwBhTz
   PYhDPe5uVtpE23viaQD1Y1vavLiFo37K9sVUsI7FrqCSV4azv/qrC0cG3
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="354860179"
X-IronPort-AV: E=Sophos;i="5.97,258,1669104000"; 
   d="scan'208";a="354860179"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 04:40:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="788010953"
X-IronPort-AV: E=Sophos;i="5.97,258,1669104000"; 
   d="scan'208";a="788010953"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 30 Jan 2023 04:40:37 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pMTSe-00HLiK-02;
        Mon, 30 Jan 2023 14:40:36 +0200
Date:   Mon, 30 Jan 2023 14:40:35 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?iso-8859-1?Q?M=E5rten?= Lindahl <marten.lindahl@axis.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH] iio: light: vcnl4000: Fix WARN_ON on uninitialized lock
Message-ID: <Y9e6w3bUmNKDSdej@smile.fi.intel.com>
References: <20230130093742.838577-1-marten.lindahl@axis.com>
 <Y9e6cGDYxkrTtQtC@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y9e6cGDYxkrTtQtC@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jan 30, 2023 at 02:39:12PM +0200, Andy Shevchenko wrote:
> On Mon, Jan 30, 2023 at 10:37:42AM +0100, Mårten Lindahl wrote:

...

> > Fixes: e21b5b1f2 ("iio: light: vcnl4000: Preserve conf bits when toggle power")

Actually one more, please provide a proper Fixes tag.

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes

It's explained there.

-- 
With Best Regards,
Andy Shevchenko


