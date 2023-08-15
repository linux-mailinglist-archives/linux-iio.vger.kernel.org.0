Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE0877C871
	for <lists+linux-iio@lfdr.de>; Tue, 15 Aug 2023 09:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjHOHTk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Aug 2023 03:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234634AbjHOHS7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Aug 2023 03:18:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE66106;
        Tue, 15 Aug 2023 00:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692083938; x=1723619938;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7A9zUtNY8TYGnryTMNNJIGQt/lVLXvC5tdkl1W8egoA=;
  b=lVNnbF0S2G3mqOElDV0ZIpM08tWDWZv6HS6MjMrv2uL+sDfTRElEfoz6
   nAzVej9k5JzBdlF6miHIBnJJ6Lj4FQxpt7FJA6bFc4+WHyKTrzwUtBx/Z
   7wj2ccMvZxVjQhoaBsx28VFODeclZfI01qRGeizxW5Pi/0u53AYqjIRU+
   8WCMEsMD1Hr7EULkcl3EoGMYCx6ufgIdRzZxAZ7n2prRFH28g2SrBitmd
   Dd+NhL/7/vnccdPcJPXImltSqrRcnQDsNaDeKiGoaMaASqYBpS5/KsoQn
   n1RFHJSQLGFbCZJtI/GYY6M1FLK8l6Iuz8qJ/47d7Jpn1kghK3al3kYwM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="372216404"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="372216404"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 00:18:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="799106608"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="799106608"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 15 Aug 2023 00:18:55 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qVoKL-0084Nz-1I;
        Tue, 15 Aug 2023 10:18:53 +0300
Date:   Tue, 15 Aug 2023 10:18:53 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jean Delvare <jdelvare@suse.de>,
        Vladimir Oltean <olteanv@gmail.com>, linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] iio: dac: ti-dac5571: Use i2c_get_match_data()
Message-ID: <ZNsm3efpkYlL4Gki@smile.fi.intel.com>
References: <20230812090418.75020-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230812090418.75020-1-biju.das.jz@bp.renesas.com>
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

On Sat, Aug 12, 2023 at 10:04:18AM +0100, Biju Das wrote:
> Replace device_get_match_data() and id lookup for retrieving match data
> by i2c_get_match_data() by converting enum->pointer for data in the
> match table.

...

> +	{.compatible = "ti,dac5571", .data = &dac5571_spec[single_8bit] },
> +	{.compatible = "ti,dac6571", .data = &dac5571_spec[single_10bit] },
> +	{.compatible = "ti,dac7571", .data = &dac5571_spec[single_12bit] },
> +	{.compatible = "ti,dac5574", .data = &dac5571_spec[quad_8bit] },
> +	{.compatible = "ti,dac6574", .data = &dac5571_spec[quad_10bit] },
> +	{.compatible = "ti,dac7574", .data = &dac5571_spec[quad_12bit] },
> +	{.compatible = "ti,dac5573", .data = &dac5571_spec[quad_8bit] },
> +	{.compatible = "ti,dac6573", .data = &dac5571_spec[quad_10bit] },
> +	{.compatible = "ti,dac7573", .data = &dac5571_spec[quad_12bit] },
> +	{.compatible = "ti,dac121c081", .data = &dac5571_spec[single_12bit] },

I would reorder them a bit.

	{.compatible = "ti,dac121c081", .data = &dac5571_spec[single_12bit] },
	{.compatible = "ti,dac5571", .data = &dac5571_spec[single_8bit] },
	{.compatible = "ti,dac6571", .data = &dac5571_spec[single_10bit] },
	{.compatible = "ti,dac7571", .data = &dac5571_spec[single_12bit] },
	{.compatible = "ti,dac5573", .data = &dac5571_spec[quad_8bit] },
	{.compatible = "ti,dac6573", .data = &dac5571_spec[quad_10bit] },
	{.compatible = "ti,dac7573", .data = &dac5571_spec[quad_12bit] },
	{.compatible = "ti,dac5574", .data = &dac5571_spec[quad_8bit] },
	{.compatible = "ti,dac6574", .data = &dac5571_spec[quad_10bit] },
	{.compatible = "ti,dac7574", .data = &dac5571_spec[quad_12bit] },

Same for I2C ID table.

-- 
With Best Regards,
Andy Shevchenko


