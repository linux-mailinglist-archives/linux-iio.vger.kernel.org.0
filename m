Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358E7780B2E
	for <lists+linux-iio@lfdr.de>; Fri, 18 Aug 2023 13:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376667AbjHRLct (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Aug 2023 07:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376704AbjHRLcW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Aug 2023 07:32:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F014208;
        Fri, 18 Aug 2023 04:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692358340; x=1723894340;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1Mcbemr/JD5HiZoad05SkWOEni3vZ5K/boroirOAabY=;
  b=R9pqnRjoiXW2Io0ZfhjSZgXOurpdDCMN/6+p4lmYtBIdf9u8bAhDS3FF
   xtO/fpjTNlL4KmPEKEKAjGLog1zlXlTw1YWxy4gdAjy/mbDThm0T/+y2w
   eAsOO2YP4iwtGCBplUP1H6xrytsVpg2ez9y/p46+r2qqPs1USPba9yVuL
   HGiwb35OH3elfbBa4rWrMWFsVTfR1qDMbVFCiUHZpt10pfZnlCJaXqrqZ
   lKLXosDGow/+b/yVIrMzELnb1uoA6OqoPxucHQ0/+OKbF8eDkm3aiTXD5
   BiN1N2RithUpTD56ciSdskR8Aj4mdBz9Dg5r+YeIRkccZjlW3we1awkrD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="376840663"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="376840663"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 04:32:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="728580852"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="728580852"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 18 Aug 2023 04:32:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qWxiB-005sl5-1L;
        Fri, 18 Aug 2023 14:32:15 +0300
Date:   Fri, 18 Aug 2023 14:32:14 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 1/5] iio: magnetometer: ak8975: Convert enum->pointer
 for data in the match tables
Message-ID: <ZN9WvtF1wUWwo6tM@smile.fi.intel.com>
References: <20230818075600.24277-1-biju.das.jz@bp.renesas.com>
 <20230818075600.24277-2-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818075600.24277-2-biju.das.jz@bp.renesas.com>
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

On Fri, Aug 18, 2023 at 08:55:56AM +0100, Biju Das wrote:
> Convert enum->pointer for data in the match tables to simplify the probe()
> by replacing device_get_match_data() and i2c_client_get_device_id by
> i2c_get_match_data() as we have similar I2C, ACPI and DT matching table.

As this is a straightforward conversion, nothing should be broken,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


