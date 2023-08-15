Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5CD77CABF
	for <lists+linux-iio@lfdr.de>; Tue, 15 Aug 2023 11:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236230AbjHOJwD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Aug 2023 05:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236218AbjHOJvz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Aug 2023 05:51:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADDE94;
        Tue, 15 Aug 2023 02:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692093113; x=1723629113;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zz64c6hs9zGp40AahrkutfoXqSXXdMqAm8KSjmg0Mac=;
  b=LhzZ916XsqPTXqSNfmJMFC5iPOoF3IPJ8gBQklbpUboCuvYESjP1ut4w
   ph2rFU9/pi1tGoIsVVE3dgxQFd9eG4jyRjpugD8436ltzYc8lbnsQ69Gp
   YGjcGzdRkSLlf8sEqYBFHp0J2sSRhYK9DnFxytxNEz/6q6rSFTPFw5RPJ
   SxBOL16BR7IrBtyihqxdUYKeWe2griMwHJqDTny7A7z2Qmegsr99dejzI
   /8doQoA1EJBPZ8yi7/d51eLN8OB1zAF0Y1Ff5UWAQIDYfjY/Sz8SxpAai
   pBE7Mte9I8J2tZoG29egM2G0gXuMj1tvBZJqgjOQyMTfMHXlJvH6vjEjx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="351832263"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="351832263"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 02:51:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="803767972"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="803767972"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 15 Aug 2023 02:51:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qVqiK-00DJ9y-2g;
        Tue, 15 Aug 2023 12:51:48 +0300
Date:   Tue, 15 Aug 2023 12:51:48 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] iio: potentiometer: ds1803: Convert enum->pointer for
 data in the ID table
Message-ID: <ZNtKtES3GtLKd1eI@smile.fi.intel.com>
References: <20230812144106.163355-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230812144106.163355-1-biju.das.jz@bp.renesas.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Aug 12, 2023 at 03:41:06PM +0100, Biju Das wrote:
> Convert enum->pointer for data in the ID table, so that
> device_get_match_data() can do match against OF/ACPI/I2C tables, once i2c
> bus type match support added to it.
> 
> Replace enum->struct *ds1803_cfg for data in the ID table and simplify
> ds1803_probe() by replacing device_get_match_data() with
> i2c_get_match_data().

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


