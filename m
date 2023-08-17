Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A330D77F44A
	for <lists+linux-iio@lfdr.de>; Thu, 17 Aug 2023 12:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349293AbjHQK0j (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 17 Aug 2023 06:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347924AbjHQK0U (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 17 Aug 2023 06:26:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F1A198C;
        Thu, 17 Aug 2023 03:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692267979; x=1723803979;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zCLudt9HOTEOAng+x/juQOoPBWjkyqVLudOlH8KkNVU=;
  b=Rm3+bDWop8zr1C9R2nqe8k6oLw9z+jj2g8NiiuON/0hGzuUK/3mFHIAX
   lxzVwqUjQTt0llW4pCGv/ZZy9BGTUlHvB9NL4eSd0VypSpur2gob93Dqm
   J6zY8y+xBbuaFnP5Tx97If4Qx+an0Ms9rniAnQEyTbCCSyz8GTtzyoinF
   PRWGMOjxRJcYSXzj80hPUbzlLQPg1R8RAkAtGGxpdZrbKG2qXEKOEpTub
   6Dq4XQ2AUewMAvjMbg78DaMj7cZf0sHVoCSyLdidId4j3Wxsiy/SKZxaf
   RYAo11ZcF9nTIHdXKs8qtrLSEVXAXXBJeRxdMclE7AWgdJujk7A0ZT627
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="439124562"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="439124562"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 03:26:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="848838947"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="848838947"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 17 Aug 2023 03:26:16 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qWaCk-007A2N-2T;
        Thu, 17 Aug 2023 13:26:14 +0300
Date:   Thu, 17 Aug 2023 13:26:14 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] iio: magnetometer: ak8975: Convert enum->pointer for
 data in the match tables
Message-ID: <ZN31xhUWgcJC3afb@smile.fi.intel.com>
References: <20230816184015.12420-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816184015.12420-1-biju.das.jz@bp.renesas.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Aug 16, 2023 at 07:40:15PM +0100, Biju Das wrote:
> Convert enum->pointer for data in the match tables to simplify the probe()
> by replacing device_get_match_data() and i2c_client_get_device_id by
> i2c_get_match_data() as we have similar I2C, ACPI and DT matching table.

...

>  static const struct acpi_device_id ak_acpi_match[] = {
> +	{"AK8975", (kernel_ulong_t)&ak_def_array[AK8975] },
> +	{"AK8963", (kernel_ulong_t)&ak_def_array[AK8963] },
> +	{"INVN6500", (kernel_ulong_t)&ak_def_array[AK8963] },
> +	{"AK009911", (kernel_ulong_t)&ak_def_array[AK09911] },
> +	{"AK09911", (kernel_ulong_t)&ak_def_array[AK09911] },
> +	{"AKM9911", (kernel_ulong_t)&ak_def_array[AK09911] },
> +	{"AK09912", (kernel_ulong_t)&ak_def_array[AK09912] },

Please, sort them by HID. ACPI has no issues (as I learnt about OF) with
the ordering of IDs.

>  	{ }
>  };

...

> -	{"AK8963", AK8963},

> +	{"AK8963", (kernel_ulong_t)&ak_def_array[AK8963] },

Seems the wrong ID to begin with.

I would suggest to drop it in a separate patch.

...

>  static const struct of_device_id ak8975_of_match[] = {
> +	{ .compatible = "asahi-kasei,ak8975", .data = &ak_def_array[AK8975] },
> +	{ .compatible = "ak8975", .data = &ak_def_array[AK8975] },
> +	{ .compatible = "asahi-kasei,ak8963", .data = &ak_def_array[AK8963] },
> +	{ .compatible = "ak8963", .data = &ak_def_array[AK8963] },
> +	{ .compatible = "asahi-kasei,ak09911", .data = &ak_def_array[AK09911] },
> +	{ .compatible = "ak09911", .data = &ak_def_array[AK09911] },
> +	{ .compatible = "asahi-kasei,ak09912", .data = &ak_def_array[AK09912] },
> +	{ .compatible = "ak09912", .data = &ak_def_array[AK09912] },
> +	{ .compatible = "asahi-kasei,ak09916", .data = &ak_def_array[AK09916] },
> +	{ .compatible = "ak09916", .data = &ak_def_array[AK09916] },

Maybe the asashi being grouped it won't regress...

	{ .compatible = "asahi-kasei,ak8975", .data = &ak_def_array[AK8975] },
	{ .compatible = "asahi-kasei,ak8963", .data = &ak_def_array[AK8963] },
	{ .compatible = "asahi-kasei,ak09911", .data = &ak_def_array[AK09911] },
	{ .compatible = "asahi-kasei,ak09912", .data = &ak_def_array[AK09912] },
	{ .compatible = "asahi-kasei,ak09916", .data = &ak_def_array[AK09916] },
	{ .compatible = "ak8975", .data = &ak_def_array[AK8975] },
	{ .compatible = "ak8963", .data = &ak_def_array[AK8963] },
	{ .compatible = "ak09911", .data = &ak_def_array[AK09911] },
	{ .compatible = "ak09912", .data = &ak_def_array[AK09912] },
	{ .compatible = "ak09916", .data = &ak_def_array[AK09916] },

>  	{}
>  };

-- 
With Best Regards,
Andy Shevchenko


