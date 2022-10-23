Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A354B6095BE
	for <lists+linux-iio@lfdr.de>; Sun, 23 Oct 2022 21:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbiJWTHF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 Oct 2022 15:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbiJWTHE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Oct 2022 15:07:04 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDE158EA8
        for <linux-iio@vger.kernel.org>; Sun, 23 Oct 2022 12:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666552019; x=1698088019;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=tUHkd133czhDqZk/eo2s4WvfA6JQFGKSyzgbTd/2Zps=;
  b=TcZNVVGdbE3+4s85g4QH2lvMAPSKk9WqzLiFAfa6AUiU+IVyfUzLtdKA
   oeh5+Sp4GNSiEo5PQySpxYdx4n3+8FM6Fd49qbBQBGcDgrEZ7HWggIXxe
   ZG82X4UAnKiHZT9/pqmVXBFSCZoH7VX1KEOQKk57qJbwN+rZwpcanmKoX
   651VsjgMT1cGO2vlmu4WBkUVK+P+O7JDyQ6HUqfvsBBA1dFeb/EXJJgou
   FPwZ2W9yMi7jofLlZVDETWEKTWzOWisaODNSYi7/z34EFAczdvMpFha7i
   4rp1E2Se/QX+0ANa3Fl/k6RCz+qkGKml2Zh+McCxyNpTr8ht5XKlfzvlO
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="287010129"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="287010129"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2022 12:06:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="625870794"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="625870794"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 23 Oct 2022 12:06:55 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1omgJB-0015ux-12;
        Sun, 23 Oct 2022 22:06:53 +0300
Date:   Sun, 23 Oct 2022 22:06:53 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Jonathan Cameron <jic23@kernel.org>, Wolfram Sang <wsa@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Rosin <peda@axentia.se>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Miaoqian Lin <linmq006@gmail.com>, linux-iio@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 16/23] iio: accel: mma9551: Convert to i2c's .probe_new
Message-ID: <Y1WQzXdbNyvre64l@smile.fi.intel.com>
References: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
 <20221023132302.911644-17-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221023132302.911644-17-u.kleine-koenig@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Oct 23, 2022 at 03:22:55PM +0200, Uwe Kleine-König wrote:
> .probe_new() doesn't get the i2c_device_id * parameter, so determine
> that explicitly in .probe(). The device_id array has to move up for that
> to work.

> +static const struct i2c_device_id mma9551_id[] = {
> +	{"mma9551", 0},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, mma9551_id);

Same, please find a way to leave this as it is right now.

-- 
With Best Regards,
Andy Shevchenko


