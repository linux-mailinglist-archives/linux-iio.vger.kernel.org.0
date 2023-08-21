Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB19782A0B
	for <lists+linux-iio@lfdr.de>; Mon, 21 Aug 2023 15:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbjHUNLZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Aug 2023 09:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbjHUNLZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Aug 2023 09:11:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC2FE3;
        Mon, 21 Aug 2023 06:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692623483; x=1724159483;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pMwU+CdEC2YSyeEHaaiJ+SMaR8fR74jck0bC+EsQsFY=;
  b=DnDxXBTSLVa6mFYrn+9nNVj6bp/MCwPejlzBjIzqGGOwnJXIE51t2Gfq
   WGVcH/ez8pAsjZu1ZO8vdkMRgV9jgYc6xCtlSeTglvK2dJ4wUIhXkt2W8
   Re8PzDD+lPys+tBMbyGaKRnIrYtspfhtCN1Z82tpMtcJQMI5wQJ10fivh
   SiixdQtMDifhIVOAQ2mQHHNi/Xig44WhuQ8zvb132rkhq6TikJuBJwcg5
   YrCAli21CWvdaXR4bzcORAMDiScTSV7hNxfkCEmE1Zi+rqW8ABiyGZ/W0
   P/w1Dl5oXRZoGrzHlCXz2dDyf2lyTuFGqvk+hZQnEUKpScXnyDkeNiFmq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="459952844"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; 
   d="scan'208";a="459952844"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 06:10:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="805925542"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; 
   d="scan'208";a="805925542"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 21 Aug 2023 06:10:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qY4gF-00FGey-0I;
        Mon, 21 Aug 2023 16:10:51 +0300
Date:   Mon, 21 Aug 2023 16:10:50 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Mehdi Djait <mehdi.djait.k@gmail.com>,
        Rob Herring <robh@kernel.org>, linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 RESEND 2/2] iio: accel: mma8452: Sort match tables
Message-ID: <ZONiWnLpY7FD/+lj@smile.fi.intel.com>
References: <20230818184033.335502-1-biju.das.jz@bp.renesas.com>
 <20230818184033.335502-3-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818184033.335502-3-biju.das.jz@bp.renesas.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Aug 18, 2023 at 07:40:33PM +0100, Biju Das wrote:
> Sort ID table alphabetically by name and OF table by compatible.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


