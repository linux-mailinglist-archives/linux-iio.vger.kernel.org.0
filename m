Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC3877C80F
	for <lists+linux-iio@lfdr.de>; Tue, 15 Aug 2023 08:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbjHOGrk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Aug 2023 02:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235406AbjHOGrC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Aug 2023 02:47:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9724199D;
        Mon, 14 Aug 2023 23:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692082001; x=1723618001;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=80VgbkCOTTKJgkUzkgCIEkXh2+3QGcOKAPmKPCyAtgI=;
  b=Efls5i2x60AiVDZlttL7TZqLBg2hcuphxFQ4vZDp1wg7gMjvPiEivuAB
   QPNkwvy1/v+0xBlznonOTeh/fP96hk/byd8odIXjBmqcZbdDtj4YgUcnA
   YijFf0h4h6bHUA0hedQwY3RAabPI/WS27KS5klhxoMRovwnA00BMS1mM0
   6GjnZmdqvqCHcEpWAhK2Q0oQ6FPpqgsLO0hkvdMQgvvfolNu2mag19jtp
   gtwCK+DdFl2SBoU6A9eLoUGSugtfFuEx6auxAoYDcav6x1M1myIYuPSPJ
   jUORl/86zwMwXBmdbAhXznmZ1rA1HU8da/0JxrrNTB+gFpzZv8e0ryHzp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="362363575"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="362363575"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 23:46:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="763183347"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="763183347"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 14 Aug 2023 23:46:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qVnp6-006xgc-1s;
        Tue, 15 Aug 2023 09:46:36 +0300
Date:   Tue, 15 Aug 2023 09:46:36 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Mehdi Djait <mehdi.djait.k@gmail.com>,
        Rob Herring <robh@kernel.org>, linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] iio: accel: mma8452: Convert enum->pointer for data in
 the ID table
Message-ID: <ZNsfTH3l27oJIT+W@smile.fi.intel.com>
References: <20230812143100.159700-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230812143100.159700-1-biju.das.jz@bp.renesas.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Aug 12, 2023 at 03:31:00PM +0100, Biju Das wrote:
> Convert enum->pointer for data in the ID table, so that
> device_get_match_data() can do match against OF/ACPI/I2C tables, once i2c
> bus type match support added to it.
> 
> Replace enum->struct *mma_chip_info for data in the ID table and simplify
> mma8452_probe() by replacing device_get_match_data() with
> i2c_get_match_data().

...

>  static const struct i2c_device_id mma8452_id[] = {
> -	{ "mma8451", mma8451 },
> -	{ "mma8452", mma8452 },
> -	{ "mma8453", mma8453 },
> -	{ "mma8652", mma8652 },
> -	{ "mma8653", mma8653 },
> -	{ "fxls8471", fxls8471 },
> +	{ "mma8451", (kernel_ulong_t)&mma_chip_info_table[mma8451] },
> +	{ "mma8452", (kernel_ulong_t)&mma_chip_info_table[mma8452] },
> +	{ "mma8453", (kernel_ulong_t)&mma_chip_info_table[mma8453] },
> +	{ "mma8652", (kernel_ulong_t)&mma_chip_info_table[mma8652] },
> +	{ "mma8653", (kernel_ulong_t)&mma_chip_info_table[mma8653] },
> +	{ "fxls8471", (kernel_ulong_t)&mma_chip_info_table[fxls8471] },

You can also keep it sorted by name.

>  	{ }
>  };

-- 
With Best Regards,
Andy Shevchenko


