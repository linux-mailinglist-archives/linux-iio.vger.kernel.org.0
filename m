Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E31B609E3B
	for <lists+linux-iio@lfdr.de>; Mon, 24 Oct 2022 11:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbiJXJqm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Oct 2022 05:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbiJXJqY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Oct 2022 05:46:24 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71E411A00
        for <linux-iio@vger.kernel.org>; Mon, 24 Oct 2022 02:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666604780; x=1698140780;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=+BdyzKD+YDZhcqrXeL6i8itQQKr6+HAe+PtbfPi49xo=;
  b=kfR84W7yGS/CdQsxOYF8C8wqF0K71k85d+/EZ8e1sIpxjkJJiMixu+xq
   wREBZ8lk4/EZu7Yxvk5dxJy4TX+ba3IUjVuDHeZByTZzY6EPo6vjAlDAB
   nIvQd+O6zuRqcWWI61WRLJbcXV1KGAqUQnh4P1+K09YKWlA8j/Z6sqRqb
   Uunh3PsD3bMcWuAtGnhI5NN08PK/rmP4Ngu73Yp21nUU4XuVqRW+sRFuS
   agXBFlWa+IW7rfaNChQRg2UZEaVhbfEwMs8n/jP6vwT/D8OAOinatHVHV
   81RPxmOCdNO9a1YgMV0d6fDnUyWR/HWVGLO/U25VNkfRl02P/DAfka9k0
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="393694525"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="393694525"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 02:46:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="609136137"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="609136137"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 24 Oct 2022 02:46:05 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1omu1y-001NG1-2r;
        Mon, 24 Oct 2022 12:46:02 +0300
Date:   Mon, 24 Oct 2022 12:46:02 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Miaoqian Lin <linmq006@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>,
        Wolfram Sang <wsa@kernel.org>,
        Vladimir Oltean <olteanv@gmail.com>, kernel@pengutronix.de,
        Yang Yingliang <yangyingliang@huawei.com>,
        wangjianli <wangjianli@cdjrlc.com>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 10/23] iio: accel: kxcjk-1013: Convert to i2c's .probe_new
Message-ID: <Y1Ze2gw3hNgp6FT5@smile.fi.intel.com>
References: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
 <20221023132302.911644-11-u.kleine-koenig@pengutronix.de>
 <Y1WQoyek5KBwDqCd@smile.fi.intel.com>
 <20221024070518.dnrhsijfphbhs2la@pengutronix.de>
 <Y1ZPVw1qBx1MkZgY@smile.fi.intel.com>
 <20221024091456.vuw3mqcokfrbrozh@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221024091456.vuw3mqcokfrbrozh@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Oct 24, 2022 at 11:14:56AM +0200, Uwe Kleine-König wrote:
> On Mon, Oct 24, 2022 at 11:39:51AM +0300, Andy Shevchenko wrote:
> > On Mon, Oct 24, 2022 at 09:05:18AM +0200, Uwe Kleine-König wrote:
> > > On Sun, Oct 23, 2022 at 10:06:11PM +0300, Andy Shevchenko wrote:
> > > > On Sun, Oct 23, 2022 at 03:22:49PM +0200, Uwe Kleine-König wrote:

...

> > > > > +static const struct i2c_device_id kxcjk1013_id[] = {
> > > > > +	{"kxcjk1013", KXCJK1013},
> > > > > +	{"kxcj91008", KXCJ91008},
> > > > > +	{"kxtj21009", KXTJ21009},
> > > > > +	{"kxtf9",     KXTF9},
> > > > > +	{"kx023-1025", KX0231025},
> > > > > +	{"SMO8500",   KXCJ91008},
> > > > > +	{}
> > > > > +};
> > > > > +MODULE_DEVICE_TABLE(i2c, kxcjk1013_id);
> > > > 
> > > > I don't like this part. Can we, please, find a way how to dereference this
> > > > table via struct i2c_client, please?
> > > 
> > > It would be possible to do (on top of my patch here as PoC):
> > > 
> > > diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> > > index e043dd698747..00269b25af99 100644
> > > --- a/drivers/iio/accel/kxcjk-1013.c
> > > +++ b/drivers/iio/accel/kxcjk-1013.c
> > > @@ -1445,7 +1445,7 @@ MODULE_DEVICE_TABLE(i2c, kxcjk1013_id);
> > >  
> > >  static int kxcjk1013_probe(struct i2c_client *client)
> > >  {
> > > -	const struct i2c_device_id *id = i2c_match_id(kxcjk1013_id, client);
> > > +	const struct i2c_device_id *id = i2c_match_id(to_i2c_driver(client->dev.driver)->id_table, client);
> > >  	struct kxcjk1013_data *data;
> > >  	struct iio_dev *indio_dev;
> > >  	struct kxcjk_1013_platform_data *pdata;
> > > 
> > > (only compile tested), you could even create a function or macro to make
> > > this a bit prettier on the source level. For the compiler loading the
> > > address from a local symbol instead of from two pointer dereferences is
> > > (I guess) a bit more effective and IMHO more natural.
> > > 
> > > *shrug*, I don't care much, but I don't like to have to rework this
> > > series just because you don't like this part. You even didn't give a
> > > rationale, I can imagine several different ones:
> > 
> > And I don't want to have ping-ponging the pieces of code (ID tables) because
> > some API has to be fixes or so.
> 
> In this series it's only ping without pong.

Exactly. And it means let's put my problem to someone's else shoulders.

> To benefit from the local
> table instead of fishing the table out of client, the table must be
> declared already when it's used.

I don't see benefit of dereferencing tables by name. The table has to be
available via struct driver, otherwise, how the heck we even got into the
->probe() there.

> > >  [ ] it makes the patch bigger
> > >  [ ] it results in an unnatural order of symbols in the driver
> > >  [ ] it's some kind of duplication
> > >  [ ] something else
> > >      please elaborate: ________________________________
> > 
> > It adds a burden to the future work with no good justification along with
> 
> This burden exists in the drivers that already today have the table
> above the probe function? (Ok, there are none in this series, but it
> happens, see for example
> 
> 	https://lore.kernel.org/linux-rtc/20221021130706.178687-4-u.kleine-koenig@pengutronix.de
> 
> and a few more in the rtc series.) I don't see a burden here, we're
> talking about the id table being defined before the probe function, right?
> How is that a burden? What am I missing?

Yeah, people haven't had no idea about accessing tables via struct driver,
reviewers of that code neither. Should it be excuse for us to follow that
example?

> > a churn in _this_ series.
> 
> The alternatives are: Split the patch into reorder + convert to
> .probe_new, or add a declaration for the id table. Among these I like
> the current approach besto.

Alternative is to avoid reordering to begin with, no?

> > While I like the rest of the series, these things I would rather postpone
> > or rework.
> 
> There is no win in postponing, is there?[1] What would be your preferred
> way to rework?

My understand of the probe_new is that an attempt to unify i2c with how spi
does. So, why not teach i2c_match_id() to handle this nicely for the caller?

This will allow to leave tables where they are (or move closer to struct
driver), reduce churn with the using of current i2c_match_id() as you
showed the long line to get that table. This might need a new API to avoid
changing many drivers at once. But it's business as usual.

-- 
With Best Regards,
Andy Shevchenko


