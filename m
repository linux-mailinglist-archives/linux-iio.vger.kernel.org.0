Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FE2780B1F
	for <lists+linux-iio@lfdr.de>; Fri, 18 Aug 2023 13:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349895AbjHRL3c (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Aug 2023 07:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376667AbjHRL3R (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Aug 2023 07:29:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC65BFC;
        Fri, 18 Aug 2023 04:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692358156; x=1723894156;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PF6FoIrItHUNJ7l+gEfrgtJkg7XIWtZUI8g+RRWWx8Y=;
  b=NQ00YANH4a/7AhhsG38eKoSCRC4QDbhEuusmRLT834K63ZEDa3mwK6r0
   CejcC3q3CH+xQ+2VlZ9P2ntmB5rncdRArUW3qLeAYZxL4hB7AEOAws9Vf
   BOTuQkZO3PjAoqEfhT3+FZEwZTex+KVXAUIe5sITcOMo9B1YIDfn88Kdo
   /eu162xOJQQkIrVlmGZYAJsWViDnIPKxWpiUk0XM4h/E+FN+kG7M7ft7O
   z5sWvIkI3kkTxu5mvm3h1PAm7lqaFCq9bd8W1G2VazSNjDtnOKzpVJExm
   OdR/mlXmVGnj+sUMJas2AfltqsdTST0phiFw0h7CUQB5/O8T41tFsWdr5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="370539251"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="370539251"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 04:29:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="825090865"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="825090865"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Aug 2023 04:29:14 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qWxfE-005mXV-14;
        Fri, 18 Aug 2023 14:29:12 +0300
Date:   Fri, 18 Aug 2023 14:29:12 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 4/5] iio: magnetometer: ak8975: Drop deprecated enums
 from OF table
Message-ID: <ZN9WCKQ/hv4zKfsK@smile.fi.intel.com>
References: <20230818075600.24277-1-biju.das.jz@bp.renesas.com>
 <20230818075600.24277-5-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818075600.24277-5-biju.das.jz@bp.renesas.com>
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

On Fri, Aug 18, 2023 at 08:55:59AM +0100, Biju Das wrote:
> Drop deprecated enums from OF table as corresponding entries
> are removed from bindings and it also saves memory.

You can't do this.

Only sorting by "prefixed first" criteria is possible.

-- 
With Best Regards,
Andy Shevchenko


