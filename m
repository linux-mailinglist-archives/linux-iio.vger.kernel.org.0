Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE87177C86A
	for <lists+linux-iio@lfdr.de>; Tue, 15 Aug 2023 09:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235399AbjHOHRA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Aug 2023 03:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235406AbjHOHQn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Aug 2023 03:16:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C07E10F0;
        Tue, 15 Aug 2023 00:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692083802; x=1723619802;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/mlvvjIFvWIdiSjHe5NJBgFrsCzJfxnD8Y0lh2BJltE=;
  b=nNjbYeP3JsbgfPIV52exynN+EN5/ndwbaJ0Kbtl6GQgmFJsalY53lLwe
   wUr4ZSnqlEiN2HxJhSQrUch5WKcisPvzLgcUFyVQv0Qfr3zzfbBWcOR72
   5EXjPyiyS8/ZGWjIhBjWZet4UNY06xkCdscxITW0HtIXhSG3csbvttyXx
   NZUx1uFnCV1d0arzseqZPwThpZvv3/VE6FWJOzilg/3cLqD8pF3Qp4K5J
   iXRV2kpwhwQ24VZ7IhnH3fkbnn9M6SB/Dvm7xm9lGES4gjfuDMh6QhFFz
   F9VL1sCyPsXGqTOfzySsuSMtKb45ywkkPrEA9FA7VjCohUBsQX1nzUQai
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="375951193"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="375951193"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 00:16:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="847957824"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="847957824"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 15 Aug 2023 00:16:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qVoHz-007zDX-2M;
        Tue, 15 Aug 2023 10:16:27 +0300
Date:   Tue, 15 Aug 2023 10:16:27 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH RFC/RFT] iio: imu: lsm6dsx: Use i2c_get_match_data()
Message-ID: <ZNsmS/7U28fTG5VN@smile.fi.intel.com>
References: <20230812083204.55346-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230812083204.55346-1-biju.das.jz@bp.renesas.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Aug 12, 2023 at 09:32:04AM +0100, Biju Das wrote:
> Replace device_get_match_data() and id lookup for retrieving match data
> by i2c_get_match_data() by converting enum->pointer for data in the
> match table.

...

> +static const int lsm6ds3 = ST_LSM6DS3_ID;
> +static const int lsm6ds3h = ST_LSM6DS3H_ID;
> +static const int lsm6dsl = ST_LSM6DSL_ID;
> +static const int lsm6dsm = ST_LSM6DSM_ID;
> +static const int ism330dlc = ST_ISM330DLC_ID;
> +static const int lsm6dso = ST_LSM6DSO_ID;
> +static const int asm330lhh = ST_ASM330LHH_ID;
> +static const int lsm6dsox = ST_LSM6DSOX_ID;
> +static const int lsm6dsr = ST_LSM6DSR_ID;
> +static const int lsm6ds3tr_c = ST_LSM6DS3TRC_ID;
> +static const int ism330dhcx = ST_ISM330DHCX_ID;
> +static const int lsm9ds1_imu = ST_LSM9DS1_ID;
> +static const int lsm6ds0 = ST_LSM6DS0_ID;
> +static const int lsm6dsrx = ST_LSM6DSRX_ID;
> +static const int lsm6dst = ST_LSM6DST_ID;
> +static const int lsm6dsop = ST_LSM6DSOP_ID;
> +static const int asm330lhhx = ST_ASM330LHHX_ID;
> +static const int lsm6dstx = ST_LSM6DSTX_ID;
> +static const int lsm6dsv = ST_LSM6DSV_ID;
> +static const int lsm6dsv16x = ST_LSM6DSV16X_ID;
> +static const int lsm6dso16is = ST_LSM6DSO16IS_ID;
> +static const int ism330is = ST_ISM330IS_ID;
> +static const int asm330lhb = ST_ASM330LHB_ID;

I think it would be better to have a data type for this

struct st_lsm6dsx_id {
	int id;
};

...

>  	{
>  		.compatible = "st,lsm6ds3",
> -		.data = (void *)ST_LSM6DS3_ID,
> +		.data = &lsm6ds3,
>  	},

And these can be folded at least by one line each (if you want to be
in 80 limit).

-- 
With Best Regards,
Andy Shevchenko


