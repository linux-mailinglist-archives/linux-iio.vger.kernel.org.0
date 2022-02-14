Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336844B5225
	for <lists+linux-iio@lfdr.de>; Mon, 14 Feb 2022 14:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353731AbiBNNvL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Feb 2022 08:51:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234131AbiBNNup (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Feb 2022 08:50:45 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DE249FB2;
        Mon, 14 Feb 2022 05:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644846637; x=1676382637;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=b7kPAai/90Fh6uEklYtyfVplInelIF3pPCFrq5PdET8=;
  b=JN4Pskca1lIsCLx3h1tgjfogT7AlxbYYBKpy4drbmgoe/0HLlCk31QtZ
   6UP9034p+7c9pcsmTxiYp2nNUdVfPpuoTY420RNLzyvxOcKPD3lALI0w3
   RCkS9m42AjxRiKv2gRNjqyO6buVwujmG5wV9rH8TmdyXs4kKJT75GII6D
   M7uAH6qomd8vT+Dr3+VX9FvnHILIwOpd72GsYz6LLME+uucPo+ABUGVkT
   fNt8ogKr81L78yvXuUbURL4XUIkpsBrEZhOpt/dYiIqs5CLOwWGJ4yWuU
   ma/KaFvp7OVO4pU1ovo9jfcdHBdumZ2fJ2r6PGCGgaPqzaLNfrE5W4FQn
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="336517281"
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="336517281"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 05:50:37 -0800
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="703092185"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.59])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 05:50:34 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1nJbjX-004YYi-DX;
        Mon, 14 Feb 2022 15:49:39 +0200
Date:   Mon, 14 Feb 2022 15:49:34 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc:     "Sa, Nuno" <Nuno.Sa@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v3 1/3] iio: dac: add support for ltc2688
Message-ID: <Ygpd7pebiuGuB8nT@smile.fi.intel.com>
References: <20220121142501.151-1-nuno.sa@analog.com>
 <20220121142501.151-2-nuno.sa@analog.com>
 <Yf60A1UkbBtQ68qv@smile.fi.intel.com>
 <PH0PR03MB678628C341A1972BC31F5BBA992B9@PH0PR03MB6786.namprd03.prod.outlook.com>
 <YgD91zg4L1S5KH5k@smile.fi.intel.com>
 <e1bd9f14e63e55f48f804568705a9ab8c1a09f62.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e1bd9f14e63e55f48f804568705a9ab8c1a09f62.camel@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Feb 07, 2022 at 09:19:46PM +0100, Nuno Sá wrote:
> On Mon, 2022-02-07 at 13:09 +0200, Andy Shevchenko wrote:
> > On Sun, Feb 06, 2022 at 01:19:59PM +0000, Sa, Nuno wrote:
> > > > From: Andy Shevchenko <andriy.shevchenko@intel.com>
> > > > Sent: Saturday, February 5, 2022 6:30 PM
> > > > On Fri, Jan 21, 2022 at 03:24:59PM +0100, Nuno Sá wrote:

...

> > > > Second, why do you need this specific function instead of regmap
> > > > bulk
> > > > ops against be24/le24?
> > > 
> > > Not sure I'm following this one... If you mean why am I using a
> > > custom 
> > > regmap_bus implementation, that was already explained in the RFC
> > > patch.
> > > And IIRC, you were the one already asking 😉.
> > 
> > Hmm... It was some time I have looked there. Any message ID to share,
> > so
> > I can find it quickly?

> https://lore.kernel.org/all/20211112152235.12fdcc49@jic23-huawei/

Thanks!

So, it's all about cs_change, right?
But doesn't bulk operation work exactly as we need here?

Looking again to the RFC code, it seems like we can still do it

First, you call _gather_write() followed by _read(). It will show exactly what
you do, i.e. you send command first with the value 0x0000, followed by sending
command and reading back the value at the same time.

Would it work?

...

> > > > > +       ret = kstrtou16(buf, 10, &val);
> > > > 
> > > > In other function you have long, here u16. I would expect that
> > > > the
> > > > types are of
> > > > the same class, e.g. if here you have u16, then there something
> > > > like
> > > > s32 / s64.
> > > > Or here something like unsigned short.
> > > > 
> > > > A bit of elaboration why u16 is chosen here?
> > > 
> > > Well, I never really saw any enforcement here to be honest (rather
> > > than using
> > > stdint types...). So I pretty much just use these in unsigned types
> > > because
> > > I'm lazy and u16 is faster to type than unsigned short... In this
> > > case, unless Jonathan
> > > really asks for it, I prefer not to go all over the driver and
> > > change this...
> > 
> > This is about consistency. It may work as is, but it feels not good
> > when for
> > int (or unsigned int) one uses fixed-width types. Also it's non-
> > written advice
> > to use fixed-width variables when it's about programming registers or
> > so, for
> > the rest, use POD types.

> I can understand your reasoning but again this is something that
> I never really saw being enforced. So, I'm more than ok to change it
> if it really becomes something that we will try to "enforce" in IIO.
> Otherwise it just feels as a random nitpick :).

No, this is about consistency and common sense. If you define type uXX,
we have an API for that exact type. It's confusing why POD type APIs
are used with fixed-width types or vise versa.

Moreover (which is pure theoretical, though) some architectures might
have no (mutual) equivalency between these types.

...

> > > > > +static int ltc2688_tgp_clk_setup(struct ltc2688_state *st,
> > > > > +                                struct ltc2688_chan *chan,
> > > > > +                                struct device_node *np, int
> > > > > tgp)
> > > > > +{
> > > > > +       unsigned long rate;
> > > > > +       struct clk *clk;
> > > > > +       int ret, f;
> > > > > +
> > > > > +       clk = devm_get_clk_from_child(&st->spi->dev, np, NULL);
> > > > > +       if (IS_ERR(clk))
> > > > 
> > > > Make it optional for non-OF, can be done as easy as
> > > > 
> > > >         if (IS_ERR(clk)) {
> > > >                 if (PTR_ERR(clk) == -ENOENT)
> > > >                         clk = NULL;
> > > >                 else
> > > >                         return dev_err_probe(...);
> > > >         }
> > > > 
> > > > > +               return dev_err_probe(&st->spi->dev,
> > > > > PTR_ERR(clk),
> > > > > +                                    "failed to get tgp
> > > > > clk.\n");
> > > 
> > > Well, I might be missing the point but I think this is not so
> > > straight....
> > > We will only get here if the property " adi,toggle-dither-input" is
> > > given
> > > in which case having the associated clocks is __mandatory__.
> > 
> > Ah, okay, would be a limitation for non-OF platforms.
> > 
> > > Hence,
> > > once we are here, this can never be optional. That said, we need
> > > device_node 
> > 
> > That's fine, since CCF is OF-centric API.
> > 
> > > and hence of.h
> > 
> > Why? This header doesn't bring anything you will use here.
> 
> Correct me if Im missing something. AFAIU, the idea is to use
> 'device_for_each_child_node()' which returns a fwnode_handle. That
> means, that we will have to pass that to this function and use
> 'to_of_node()' to pass a device_node to 'devm_get_clk_from_child()'.
> 
> This means, we need of.h for 'to_of_node()'...

Yeah, you are right, but it would be still better since it narrows
the problem to the CCF calls only.

-- 
With Best Regards,
Andy Shevchenko


