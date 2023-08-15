Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D0877CE6A
	for <lists+linux-iio@lfdr.de>; Tue, 15 Aug 2023 16:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237631AbjHOOsf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Aug 2023 10:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237804AbjHOOsR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Aug 2023 10:48:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F17C10F;
        Tue, 15 Aug 2023 07:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692110894; x=1723646894;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5XifsxKN76Lf2kbZhwglxmihPweM1/g2RD1glBcLEiQ=;
  b=nM33wEnl1+EHWogYKD/xwberMF178xUSGRaHznc9IUwJh9tC7CPeD2Js
   +bzSTUN/y4ggfYOZWcb+42+QkqHKOO0uiBLYiqHO5eX2858mBUp7k9PnH
   JPmO7APMqvLo7upVHOyEzEeIJFt4ZP45P/q9iuBgAFiqbu5/pmLwEJ61b
   PFgZo/ab8m1arX8SrGS4XFONYD/lqEaJnLSGMxPBDnvYCwe4DUp4y3Ck2
   7EY4Y6iyH1NAXCah02jkpSe6wI276McWUHgTEkC1sgdK32wNjoLX+HiUu
   JBo/9zlLwBsD3TWpEehrh0gm4AVKO8ye3YJo0rcMp9pGUHRxY4zVFQICX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="352621162"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="352621162"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 07:48:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="823864624"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="823864624"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Aug 2023 07:47:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qVvKu-005srD-1s;
        Tue, 15 Aug 2023 17:47:56 +0300
Date:   Tue, 15 Aug 2023 17:47:56 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] iio: chemical: sgp30: Convert enum->pointer for data in
 the match tables
Message-ID: <ZNuQHBHvUgzTu2A5@smile.fi.intel.com>
References: <20230812165730.216180-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230812165730.216180-1-biju.das.jz@bp.renesas.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Aug 12, 2023 at 05:57:30PM +0100, Biju Das wrote:
> Convert enum->pointer for data in the match tables, so that
> device_get_match_data() can do match against OF/ACPI/I2C tables, once i2c
> bus type match support added to it.
> 
> Add product_id variable to struct sgp_device and remove the local variable
> product_id in probe() and replace enum->struct *sgp_device for data in the
> match table. Simplify theprobe() by replacing device_get_match_data() and
> ID lookup for retrieving data by i2c_get_match_data().

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


