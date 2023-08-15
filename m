Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7016B77C820
	for <lists+linux-iio@lfdr.de>; Tue, 15 Aug 2023 08:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235245AbjHOGuz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Aug 2023 02:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235275AbjHOGui (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Aug 2023 02:50:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFFA10DD;
        Mon, 14 Aug 2023 23:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692082224; x=1723618224;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CRAqsHTSI4VHgi/GgBFA5YJUWQdKoAu/xc+6cSx5XUo=;
  b=jLl6Sxl18951/i0GvwsASOCLTe8PKnn5w17mgtia/E8czq+BqWwFyVPa
   IL8v3MNdogqJPaQYhiJqMs45IjsUpO175Cv1HbP+Aj3jZSS9EZEgxJlor
   iOkUxzngwZcMpYQeUnRyMJlaMVNXmp2ptbplLobV/iMo9bx17qxu4t6kc
   jAHdIFqNU7EkQ1+a6KoJf+TE7xgfK9ssC4XJ/Y8EYd2xgIsWjEv97giRN
   5m6puEKFlR3TE3r/HR46ZXwMbu+rjjJzhP25SJm0rM1gkI/6leJCuGauw
   sO59IoyfMu6uLWnyG1ig5RHFR9LEiiDaZTb0+wBbpPTPfhwJc0LjQRxcM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="352541379"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="352541379"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 23:50:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="768724782"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="768724782"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 14 Aug 2023 23:50:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qVnsh-0075jy-0N;
        Tue, 15 Aug 2023 09:50:19 +0300
Date:   Tue, 15 Aug 2023 09:50:18 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jakob Hauser <jahau@rocketmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio: magnetometer: yamaha-yas530: Use
 i2c_get_match_data()
Message-ID: <ZNsgKjxlvycW4UQc@smile.fi.intel.com>
References: <20230812065741.20990-1-biju.das.jz@bp.renesas.com>
 <20230812065741.20990-2-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230812065741.20990-2-biju.das.jz@bp.renesas.com>
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

On Sat, Aug 12, 2023 at 07:57:40AM +0100, Biju Das wrote:
> Simplify the probe() by replacing device_get_match_data() with
> i2c_get_match_data().

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


