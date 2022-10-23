Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519746095C1
	for <lists+linux-iio@lfdr.de>; Sun, 23 Oct 2022 21:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbiJWTHq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 Oct 2022 15:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbiJWTHo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Oct 2022 15:07:44 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5336769BC5
        for <linux-iio@vger.kernel.org>; Sun, 23 Oct 2022 12:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666552061; x=1698088061;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=+itXz2lnXGwOFdcqpB6gJyqAj40EL6WygN0gURwBtMQ=;
  b=AhsNXykhAjX/VewbD/ACZNGoLXwXpRcfLEGsUIetDbcaui4ZQYcNjPhU
   HARGALcuBfmHPnRu2VZKGBINv/zIe+uVfCdrRgLcoZ9hwqwvp8o26lfTY
   IGvu6/lT7BmpuEfq+bMPNSK+9cZo1GHRuR6x7XLeU0JGkGUdeujy/Mczm
   ksItrq2eJcSZAqNqUMUMKqCc9v1W+CBdnCR8pL9H197l7B05zhy6L4jL6
   j02GZ4+R3ZkWE0Zg7jEFF0SfH2rZ3yj8GVicooTGsbdmx3io2TxXtrICf
   1laJYXmWaYJ8eRPFUORWBOw+lpZuZ7CMGZwwQurYymuud9tef0Ol9CWte
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="393606602"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="393606602"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2022 12:07:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="631056063"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="631056063"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 23 Oct 2022 12:07:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1omgJs-0015wq-2G;
        Sun, 23 Oct 2022 22:07:36 +0300
Date:   Sun, 23 Oct 2022 22:07:36 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Jonathan Cameron <jic23@kernel.org>, Wolfram Sang <wsa@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Senna Tschudin <peter.senna@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Miaoqian Lin <linmq006@gmail.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 17/23] iio: accel: mma9553: Convert to i2c's .probe_new
Message-ID: <Y1WQ+Hu4rxRmr6SY@smile.fi.intel.com>
References: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
 <20221023132302.911644-18-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221023132302.911644-18-u.kleine-koenig@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Oct 23, 2022 at 03:22:56PM +0200, Uwe Kleine-König wrote:
> .probe_new() doesn't get the i2c_device_id * parameter, so determine
> that explicitly in .probe(). The device_id array has to move up for that
> to work.

...

> +static const struct i2c_device_id mma9553_id[] = {
> +	{"mma9553", 0},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(i2c, mma9553_id);

Same, no shuffling device ID tables, please.

-- 
With Best Regards,
Andy Shevchenko


