Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403C7609CF2
	for <lists+linux-iio@lfdr.de>; Mon, 24 Oct 2022 10:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiJXIkD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Oct 2022 04:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiJXIj7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Oct 2022 04:39:59 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C221A24087
        for <linux-iio@vger.kernel.org>; Mon, 24 Oct 2022 01:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666600797; x=1698136797;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=P7Ekk70wZK5L+S9pwrodOdwFkyQD8yeF5wU42rUSWgM=;
  b=hKIoS/fwaPPCtGkjfTQncr5EAXGL74W+2YUpoOxDbls1bEHML6Q/Qj3l
   r09wKFYVzOj0ZlKYwg3lf2PJV/c+FYuWAr1B2CYLHYDF+9/O+dND1HtKk
   TvolUwHgKzHuf/Aevo67k8VetvhBEMRiGRlGHnJK9CPtsB7noj5pxqtYV
   s+RcR4QQOCvlL+lltIphEtK+VA2an8NnpTL9t7fY7rWcjrCZRXFSgH/sp
   I7dnKswD+mMpC+KkMSHyaAUtksluX2hUvSdaWwfwcTFUu0BxMMVX8H8JG
   xQ7WxqIqR88JgM8/zmSQZ+RlaEgPNNRDMuGx1KL3CMenNgvRU+sRO/XwN
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="309054546"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="309054546"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 01:39:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="736333107"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="736333107"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 24 Oct 2022 01:39:54 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1omszv-001LvX-33;
        Mon, 24 Oct 2022 11:39:51 +0300
Date:   Mon, 24 Oct 2022 11:39:51 +0300
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
Message-ID: <Y1ZPVw1qBx1MkZgY@smile.fi.intel.com>
References: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
 <20221023132302.911644-11-u.kleine-koenig@pengutronix.de>
 <Y1WQoyek5KBwDqCd@smile.fi.intel.com>
 <20221024070518.dnrhsijfphbhs2la@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221024070518.dnrhsijfphbhs2la@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Oct 24, 2022 at 09:05:18AM +0200, Uwe Kleine-König wrote:
> On Sun, Oct 23, 2022 at 10:06:11PM +0300, Andy Shevchenko wrote:
> > On Sun, Oct 23, 2022 at 03:22:49PM +0200, Uwe Kleine-König wrote:

...

> > > +static const struct i2c_device_id kxcjk1013_id[] = {
> > > +	{"kxcjk1013", KXCJK1013},
> > > +	{"kxcj91008", KXCJ91008},
> > > +	{"kxtj21009", KXTJ21009},
> > > +	{"kxtf9",     KXTF9},
> > > +	{"kx023-1025", KX0231025},
> > > +	{"SMO8500",   KXCJ91008},
> > > +	{}
> > > +};
> > > +MODULE_DEVICE_TABLE(i2c, kxcjk1013_id);
> > 
> > I don't like this part. Can we, please, find a way how to dereference this
> > table via struct i2c_client, please?
> 
> It would be possible to do (on top of my patch here as PoC):
> 
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index e043dd698747..00269b25af99 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -1445,7 +1445,7 @@ MODULE_DEVICE_TABLE(i2c, kxcjk1013_id);
>  
>  static int kxcjk1013_probe(struct i2c_client *client)
>  {
> -	const struct i2c_device_id *id = i2c_match_id(kxcjk1013_id, client);
> +	const struct i2c_device_id *id = i2c_match_id(to_i2c_driver(client->dev.driver)->id_table, client);
>  	struct kxcjk1013_data *data;
>  	struct iio_dev *indio_dev;
>  	struct kxcjk_1013_platform_data *pdata;
> 
> (only compile tested), you could even create a function or macro to make
> this a bit prettier on the source level. For the compiler loading the
> address from a local symbol instead of from two pointer dereferences is
> (I guess) a bit more effective and IMHO more natural.
> 
> *shrug*, I don't care much, but I don't like to have to rework this
> series just because you don't like this part. You even didn't give a
> rationale, I can imagine several different ones:

And I don't want to have ping-ponging the pieces of code (ID tables) because
some API has to be fixes or so.

>  [ ] it makes the patch bigger
>  [ ] it results in an unnatural order of symbols in the driver
>  [ ] it's some kind of duplication
>  [ ] something else
>      please elaborate: ________________________________

It adds a burden to the future work with no good justification along with
a churn in _this_ series.

While I like the rest of the series, these things I would rather postpone
or rework.

-- 
With Best Regards,
Andy Shevchenko


