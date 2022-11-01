Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55387614D28
	for <lists+linux-iio@lfdr.de>; Tue,  1 Nov 2022 15:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiKAOzB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 1 Nov 2022 10:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiKAOy7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 1 Nov 2022 10:54:59 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138A2117D
        for <linux-iio@vger.kernel.org>; Tue,  1 Nov 2022 07:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667314499; x=1698850499;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=jsJhilSccqtqzdriy2qKuc3FTOQLCm6DHhZBcz6JPMY=;
  b=HOeMc/H0eva2gonmolbj1Uh+lLvWLEfGJSswtApZo+4iSNVlVa7dzb42
   4LGkNtbLc8XuuD+hy3wU2JR9HeHDnP4AVBRD6RkgLQBx3EMvNTixpsa40
   XOJoyZolmjHFknPMSQX6Mtkl4NHMAr4Jfn/kFguePzPbWiVxTuno/dTOi
   xHitog4p3IpIFiLO7gsm235ZcJpAi/Zf0xyQI3Fnx0myfiQ31IAyzTpJv
   G4w7KH3Hgplx0tZ0+0gNAH5emQi4Ppt5A0fNWU+bjJ2gBv5JiffmThdgl
   cEBxXBWsmIWDhAk0WJvxR9IOgp9bz4RgwYcZAL4rh+ijMGVI/8zdcPwCi
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="292457543"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="292457543"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 07:54:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="636422265"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="636422265"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 01 Nov 2022 07:54:55 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1opsfF-005dXS-06;
        Tue, 01 Nov 2022 16:54:53 +0200
Date:   Tue, 1 Nov 2022 16:54:52 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Miaoqian Lin <linmq006@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>,
        Wolfram Sang <wsa@kernel.org>, kernel@pengutronix.de,
        Yang Yingliang <yangyingliang@huawei.com>,
        wangjianli <wangjianli@cdjrlc.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 10/23] iio: accel: kxcjk-1013: Convert to i2c's .probe_new
Message-ID: <Y2EzPJvntyGbSKW8@smile.fi.intel.com>
References: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
 <20221023132302.911644-11-u.kleine-koenig@pengutronix.de>
 <Y1WQoyek5KBwDqCd@smile.fi.intel.com>
 <20221024070518.dnrhsijfphbhs2la@pengutronix.de>
 <Y1ZPVw1qBx1MkZgY@smile.fi.intel.com>
 <20221024091456.vuw3mqcokfrbrozh@pengutronix.de>
 <Y1Ze2gw3hNgp6FT5@smile.fi.intel.com>
 <20221031233843.4rbcfs3hstlkv7il@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221031233843.4rbcfs3hstlkv7il@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Nov 01, 2022 at 12:38:43AM +0100, Uwe Kleine-König wrote:
> On Mon, Oct 24, 2022 at 12:46:02PM +0300, Andy Shevchenko wrote:
> > On Mon, Oct 24, 2022 at 11:14:56AM +0200, Uwe Kleine-König wrote:

...

> > Exactly. And it means let's put my problem to someone's else shoulders.
> 
> You have a problem that I fail to see. Why is defining the id table
> before the probe function bad?
> 
> Unless I misunderstand you, you seem to assume that in the nearer future
> someone will have the urge to put the id table below the probe function
> again. What would you think is their motivation?

The problem with moving the table is the sparse locations in the code for
semantically relative things, like all ID tables to be near to each other. With
your approach you can easily break that and go for let's put one ID table on
top, because some code fails to indirectly access it, and leave another
somewhere else. I do not like this.

Besides, your change making unneeded churn of "I like to move it, move it" for
no real gain.

...

> > I don't see benefit of dereferencing tables by name. The table has to be
> > available via struct driver, otherwise, how the heck we even got into the
> > ->probe() there.
> 
> It is possible, it's just cheaper (in cpu cycles) to calculate the
> address of the table directly (i.e. via PC + $offset) instead of via
> dereferencing two pointers.

It's a slow path.

...

> I fail to follow you again. I talked about drivers/rtc/rtc-isl1208.c as
> it is in v6.1-rc1. There the probe function doesn't access the table at
> all. Neither via the driver link nor by name. That driver just defines
> the id table before the probe function.

So, if it is on top, fine, it would be just an inconsistent style.

...

> > Alternative is to avoid reordering to begin with, no?
> 
> Yeah, that could be done. But I don't see the advantage and you fail to
> explain it in a way for me to understand.
> 
> So if i2c_match_id() was changed as follows:

There is another approach in the discussion and Wolfram acknowledged it already
(with a new API to retrieve the necessary data).

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
> +
>  static int kxcjk1013_probe(struct i2c_client *client)
>  {
> -	const struct i2c_device_id *id = i2c_match_id(NULL, client);
> +	const struct i2c_device_id *id = i2c_match_id(kxcjk1013_id, client);
>  	struct kxcjk1013_data *data;
>  	struct iio_dev *indio_dev;
>  	struct kxcjk_1013_platform_data *pdata;
> @@ -1720,18 +1731,6 @@ static const struct acpi_device_id kx_acpi_match[] = {
>  };
>  MODULE_DEVICE_TABLE(acpi, kx_acpi_match);
>  
> -static const struct i2c_device_id kxcjk1013_id[] = {
> -	{"kxcjk1013", KXCJK1013},
> -	{"kxcj91008", KXCJ91008},
> -	{"kxtj21009", KXTJ21009},
> -	{"kxtf9",     KXTF9},
> -	{"kx023-1025", KX0231025},
> -	{"SMO8500",   KXCJ91008},
> -	{}
> -};
> -
> -MODULE_DEVICE_TABLE(i2c, kxcjk1013_id);

Can we avoid moving it?

>  static const struct of_device_id kxcjk1013_of_match[] = {
>  	{ .compatible = "kionix,kxcjk1013", },
>  	{ .compatible = "kionix,kxcj91008", },
> 
> on top to safe two pointer dereferences. The sum of the two driver
> patches is exactly the effect of my patch just without the i2c core
> change. (And the two pointer dereferences that are saved by the 2nd
> patch are introduced by the first, so it's fine to not split that
> change into two parts.)

...

> > So, why not teach i2c_match_id() to handle this nicely for the caller?
> 
> The metric for "nice" is obviously subjective. For me it's nice to pass
> a local symbol to an API function to make the function's job a tad
> easier and more effective to solve. And that even if I have to reorder
> the caller a bit.

So, it seems a preferred design paradigm: straightforward vs. OOP.
Kernel is written with OOP in mind, why to avoid that?

...

> > reduce churn with the using of current i2c_match_id() as you
> > showed the long line to get that table.
> 
> Do you still remember the original patch? That one doesn't have the long
> i2c_match_id() line.
> 
> (Do you see your statement is an argument for my approach? The long line
> is an indication that it's complicated to determine the address of the
> table via ->driver. You can hide that by pushing the needed effort into
> i2c_match_id() or a macro, but in the end the complexity remains for the
> CPU.)

Does it matter?

OTOH that will be aligned with SPI framework and idea behind ->probe_new()
as I understood it.

...

> > This might need a new API to avoid
> > changing many drivers at once. But it's business as usual.
> 
> My approach doesn't need a new API. That's nice, isn't it?

It depends. In this case it's not nice since it requires
"I like to move it, move it".

-- 
With Best Regards,
Andy Shevchenko


