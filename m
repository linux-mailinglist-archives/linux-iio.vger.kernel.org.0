Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1CDC4ABD11
	for <lists+linux-iio@lfdr.de>; Mon,  7 Feb 2022 12:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244117AbiBGLoj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Feb 2022 06:44:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240661AbiBGLKN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Feb 2022 06:10:13 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45A6C043188;
        Mon,  7 Feb 2022 03:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644232212; x=1675768212;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=lBgDgsJPVQgblniIqZ1h6mpgjVw09LdoD4WkuVyF3jw=;
  b=Fya8BTdOOSd/SQvuzigCY+si7EudWt4g09Rzj8fZWU/9tSd8xA+g3GOu
   EyDeDxah40xfTbHE/PLh+tkVjK8m3LdANyXQl4C4eP1SLpPwCapmfnnvf
   BSA8oYYUcfRKbBJIyOFA8H9SRN7wRpTfDiV/dZlnYLBNyzTpVEnIHlj/U
   NLMxoP1KuFIOibmm+49eaqjtA5X4bDMyS4HQDqvzowiBUefJ7zIxf+8qG
   nkSW8riVnP0flxNxNsrh5AQnyi+wX481HQSe79E3Y4D94iBU1OmXhxIiH
   Oe83JL8l/Doab/xtZgGo5k5yPfA3Rc4bKuCSaXBRyMoUI01neEeJcBWNY
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="273212523"
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="273212523"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 03:10:12 -0800
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="481551385"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 03:10:10 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1nH1tP-001sGz-B9;
        Mon, 07 Feb 2022 13:09:11 +0200
Date:   Mon, 7 Feb 2022 13:09:11 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v3 1/3] iio: dac: add support for ltc2688
Message-ID: <YgD91zg4L1S5KH5k@smile.fi.intel.com>
References: <20220121142501.151-1-nuno.sa@analog.com>
 <20220121142501.151-2-nuno.sa@analog.com>
 <Yf60A1UkbBtQ68qv@smile.fi.intel.com>
 <PH0PR03MB678628C341A1972BC31F5BBA992B9@PH0PR03MB6786.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH0PR03MB678628C341A1972BC31F5BBA992B9@PH0PR03MB6786.namprd03.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Feb 06, 2022 at 01:19:59PM +0000, Sa, Nuno wrote:
> > From: Andy Shevchenko <andriy.shevchenko@intel.com>
> > Sent: Saturday, February 5, 2022 6:30 PM
> > On Fri, Jan 21, 2022 at 03:24:59PM +0100, Nuno Sá wrote:

...

> > > +#include <linux/of.h>
> > 
> > property.h please/
> 
> That probably means property and of both included. See below in the
> clock_get comments...

Why? OF won't be used at all.

...

> > > +	memcpy(st->tx_data, reg, reg_size);
> > > +
> > > +	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	memcpy(val, &st->rx_data[1], val_size);
> > > +
> > > +	return 0;
> > > +}
> > 
> > First of all, yuo have fixed len in transfer sizes, so what the purpose of
> > the reg_size / val_size?
> 
> Well, reg_size is 1 byte and val_size is 2 as defined in the regmap_bus
> struct. And that is what it must be used for the transfer to work. I 
> could also hardcode 1 and 2 but I preferred to use the parameters. I guess
> you can argue (and probably this is why you are complaining about this)
> for me to use reg_size + val_size in the transfer length for consistency.
> That's fair but I do not think this is __that__ bad...

It's not bad, but I think that division between register and value is a good
thing to have.

> Can make that change though.

Would be nice!

...

> > Second, why do you need this specific function instead of regmap bulk
> > ops against be24/le24?
> 
> Not sure I'm following this one... If you mean why am I using a custom 
> regmap_bus implementation, that was already explained in the RFC patch.
> And IIRC, you were the one already asking 😉.

Hmm... It was some time I have looked there. Any message ID to share, so
I can find it quickly?

...

> > > +	ret = kstrtou16(buf, 10, &val);
> > 
> > In other function you have long, here u16. I would expect that the
> > types are of
> > the same class, e.g. if here you have u16, then there something like
> > s32 / s64.
> > Or here something like unsigned short.
> > 
> > A bit of elaboration why u16 is chosen here?
> 
> Well, I never really saw any enforcement here to be honest (rather than using
> stdint types...). So I pretty much just use these in unsigned types because
> I'm lazy and u16 is faster to type than unsigned short... In this case, unless Jonathan
> really asks for it, I prefer not to go all over the driver and change this...

This is about consistency. It may work as is, but it feels not good when for
int (or unsigned int) one uses fixed-width types. Also it's non-written advice
to use fixed-width variables when it's about programming registers or so, for
the rest, use POD types.

...

> > > +static int ltc2688_tgp_clk_setup(struct ltc2688_state *st,
> > > +				 struct ltc2688_chan *chan,
> > > +				 struct device_node *np, int tgp)
> > > +{
> > > +	unsigned long rate;
> > > +	struct clk *clk;
> > > +	int ret, f;
> > > +
> > > +	clk = devm_get_clk_from_child(&st->spi->dev, np, NULL);
> > > +	if (IS_ERR(clk))
> > 
> > Make it optional for non-OF, can be done as easy as
> > 
> > 	if (IS_ERR(clk)) {
> > 		if (PTR_ERR(clk) == -ENOENT)
> > 			clk = NULL;
> > 		else
> > 			return dev_err_probe(...);
> > 	}
> > 
> > > +		return dev_err_probe(&st->spi->dev, PTR_ERR(clk),
> > > +				     "failed to get tgp clk.\n");
> 
> Well, I might be missing the point but I think this is not so straight....
> We will only get here if the property " adi,toggle-dither-input" is given
> in which case having the associated clocks is __mandatory__.

Ah, okay, would be a limitation for non-OF platforms.

> Hence,
> once we are here, this can never be optional. That said, we need
> device_node 

That's fine, since CCF is OF-centric API.

> and hence of.h

Why? This header doesn't bring anything you will use here.

> to be included and this was the main reason
> why I changed from property.h to of.h (once I started to use
> 'devm_get_clk_from_child()'. I don’t really think that using both of and
> property is a good idea and I raised this in the previous version of this series
> and no one made it clear that using both of and property would be acceptable
> so I kept my move to of in the current version.

It's a good idea for sensors to be able to use them outside of OF platforms.
CCF is PITA, but at least with the conversion to device property API, this
become the only one (and it has a few possible workarounds).

> > > +	ret = clk_prepare_enable(clk);
> > > +	if (ret)
> > > +		return dev_err_probe(&st->spi->dev, ret,
> > > +				     "failed to enable tgp clk.\n");

...

> > > +			clear_bit(IIO_CHAN_INFO_RAW,
> > > +				  &st-
> > >iio_chan[reg].info_mask_separate);
> > 
> > Do you need atomic operation here?
> 
> Not really, but I still prefer to use 'clear_bit()' rather than doing it
> by hand... Is there another utility for this?

__clear_bit().

-- 
With Best Regards,
Andy Shevchenko


