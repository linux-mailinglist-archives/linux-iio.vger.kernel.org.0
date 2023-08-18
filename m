Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF3C780B12
	for <lists+linux-iio@lfdr.de>; Fri, 18 Aug 2023 13:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376635AbjHRLZp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Aug 2023 07:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376692AbjHRLZh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Aug 2023 07:25:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE0B3C06;
        Fri, 18 Aug 2023 04:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692357936; x=1723893936;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5vC2p1tFky3h+IlI+5bJ2Y+1QL18JAF7ywXbNL09HWY=;
  b=j3iFVjBiDBKWVVCItJH77Ff73zrkiTGrSGa/ke8UrPEe5JVxlzblOmnm
   56VKvs593qhSKVrwPQ9+phVGNlr92tC8IjWRZmpnBX5DW/Bz7l1EAmCXr
   1bKOzlom8r567WD1F/ipEy0sPpyWFPYi1ccypENHScRWUmcHcx0wMrNvH
   8Oi5CY2gJE5bDZO2fQaFZ8sU24ZyMLvsnvR+/tmEDrf3jfv/+YMqb6tjZ
   sl5wlFk4CaLNt+98EiPKOXu4rKfTC7canYhVAGXMvXV8ln3qpXAIVi+5s
   HxTqcftkKOhx4FhXH5f5kZa6qJ+TDW+9pHFWyClMcNOXOL8VzI8fgnspT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="353383075"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="353383075"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 04:25:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="849258741"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="849258741"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 18 Aug 2023 04:25:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qWxbg-005eaj-2A;
        Fri, 18 Aug 2023 14:25:32 +0300
Date:   Fri, 18 Aug 2023 14:25:32 +0300
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
Message-ID: <ZN9VLNdIe4PE/CSR@smile.fi.intel.com>
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

>  static const struct acpi_device_id ak_acpi_match[] = {
> +	{"AK8975", (kernel_ulong_t)&ak_def_array[AK8975] },
> +	{"AK8963", (kernel_ulong_t)&ak_def_array[AK8963] },
> +	{"INVN6500", (kernel_ulong_t)&ak_def_array[AK8963] },
> +	{"AK009911", (kernel_ulong_t)&ak_def_array[AK09911] },
> +	{"AK09911", (kernel_ulong_t)&ak_def_array[AK09911] },
> +	{"AKM9911", (kernel_ulong_t)&ak_def_array[AK09911] },
> +	{"AK09912", (kernel_ulong_t)&ak_def_array[AK09912] },

Please, sort them by HID. Haven't you read my comments against v1?

>  	{ }
>  };

...

> -	{"AK8963", AK8963},

> +	{"AK8963", (kernel_ulong_t)&ak_def_array[AK8963] },

This seems to be a wrong ID (we never use capitalized version,
at least last 10 years or so). Better to have a precursor patch
that removes it for good. There is no in-kernel user of this either.

...

>  static const struct of_device_id ak8975_of_match[] = {
> -	{ .compatible = "asahi-kasei,ak8975", },
> -	{ .compatible = "ak8975", },
> -	{ .compatible = "asahi-kasei,ak8963", },
> -	{ .compatible = "ak8963", },
> -	{ .compatible = "asahi-kasei,ak09911", },
> -	{ .compatible = "ak09911", },
> -	{ .compatible = "asahi-kasei,ak09912", },
> -	{ .compatible = "ak09912", },
> -	{ .compatible = "asahi-kasei,ak09916", },
> -	{ .compatible = "ak09916", },
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
>  	{}

So, why have you ignored my comments against v1?

-- 
With Best Regards,
Andy Shevchenko


