Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C4A6095BC
	for <lists+linux-iio@lfdr.de>; Sun, 23 Oct 2022 21:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiJWTGU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 Oct 2022 15:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbiJWTGT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Oct 2022 15:06:19 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108E451A11
        for <linux-iio@vger.kernel.org>; Sun, 23 Oct 2022 12:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666551978; x=1698087978;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=v8hW+lrpW0D+gA63/s3raY3KZ8LMOOylkQf9hN/9E1M=;
  b=OwLhlq2VhGtEa1rrgWWgDbU5/LhhrC6mxg0HRshO4Vv6uxRLTqoirSKJ
   n2rjLJruLrZsZL20qFAKWb37nZI6aHiwALLACo6I3uxlvxbIEsIQZ18Mk
   KwgWtaeYKAJvlhHgMPQDIdaCu1/QtHpnA78Ss5xGjODvYFM8rRL2N/SqD
   Hiar+AADJ3Gwu8/L/wQWD4kcwv0xukVliXEvMBB/yKvnNrSz15lZCii+r
   TDQHeir1AQ9ET/wV4/Kbldyey/GqrW9TvpdZqKPgIYQ8zO1RswoK60jMx
   Q3HpM2jpGrABMQDnnpnOsQU/z9Mwop5SH8tJ4E4byR/easJ7vlg1w3rge
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="393606437"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="393606437"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2022 12:06:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="773609845"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="773609845"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 23 Oct 2022 12:06:14 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1omgIW-0015u1-0Y;
        Sun, 23 Oct 2022 22:06:12 +0300
Date:   Sun, 23 Oct 2022 22:06:11 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Jonathan Cameron <jic23@kernel.org>, Wolfram Sang <wsa@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        Vladimir Oltean <olteanv@gmail.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        wangjianli <wangjianli@cdjrlc.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 10/23] iio: accel: kxcjk-1013: Convert to i2c's .probe_new
Message-ID: <Y1WQoyek5KBwDqCd@smile.fi.intel.com>
References: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
 <20221023132302.911644-11-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221023132302.911644-11-u.kleine-koenig@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Oct 23, 2022 at 03:22:49PM +0200, Uwe Kleine-König wrote:
> .probe_new() doesn't get the i2c_device_id * parameter, so determine
> that explicitly in .probe(). The device_id array has to move up for that
> to work.

...

> +static const struct i2c_device_id kxcjk1013_id[] = {
> +	{"kxcjk1013", KXCJK1013},
> +	{"kxcj91008", KXCJ91008},
> +	{"kxtj21009", KXTJ21009},
> +	{"kxtf9",     KXTF9},
> +	{"kx023-1025", KX0231025},
> +	{"SMO8500",   KXCJ91008},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, kxcjk1013_id);

I don't like this part. Can we, please, find a way how to dereference this
table via struct i2c_client, please?

-- 
With Best Regards,
Andy Shevchenko


