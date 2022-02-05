Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A8A4AAAF9
	for <lists+linux-iio@lfdr.de>; Sat,  5 Feb 2022 19:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243513AbiBESia (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Feb 2022 13:38:30 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:33724 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237920AbiBESi3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 5 Feb 2022 13:38:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4781C611B7;
        Sat,  5 Feb 2022 18:38:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C75B4C340E8;
        Sat,  5 Feb 2022 18:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644086308;
        bh=iP+ebl79YtPxWlE8t3km8ogN6bHYNRnvY1B53rcByUo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Rg4/aqlrJDfttNlktkIvLnL1i7XteEUtwNIoNYrQlmZcdHuTo7C6r2ZyXvDMwC0Pv
         wmoGeGQ2IoUvpwFUMgbOHvB8dMQaEZIksS0cE2w4D1GNT0x5D3qsyclSkf8KuNK447
         6D+l8kHFfEu3TICsyXQCKk0lQ1FzEsNgqwNgMBlAVhWrLiWmKc1XW6NvYA08BJ2O5n
         W1I1aq9Ug0fopaqGDyQKxrMSVBgE3OqqCixIRsNG3UKeKnUL1z7DmMXsEZeCyjzf/R
         UD6ZEwgCjXvZ8WnGDRh8jc4qWifYGz/0JuzleNQqdW8FLtBJLIHm1f90yqYGuVFuvT
         ozynoyEqkTLmg==
Date:   Sat, 5 Feb 2022 18:44:59 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v3 1/3] iio: dac: add support for ltc2688
Message-ID: <20220205184459.7aa8e5d5@jic23-huawei>
In-Reply-To: <Yf60A1UkbBtQ68qv@smile.fi.intel.com>
References: <20220121142501.151-1-nuno.sa@analog.com>
        <20220121142501.151-2-nuno.sa@analog.com>
        <Yf60A1UkbBtQ68qv@smile.fi.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 5 Feb 2022 19:29:39 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

A few comments from me, mostly because I couldn't resist jumping in ;)
Note this is only some of the things Andy raised....

Jonathan

> 
> > +	if (private == LTC2688_INPUT_B_AVAIL)
> > +		return sysfs_emit(buf, "[%u %u %u]\n", ltc2688_raw_range[0],
> > +				  ltc2688_raw_range[1],
> > +				  ltc2688_raw_range[2] / 4);  
> 
> Is it standard form "[A B C]" for ranges in IIO? I haven't looked into the code
> deeply (and datasheet at all) to understand meaning. To me range is usually out
> of two numbers.

https://elixir.bootlin.com/linux/latest/source/Documentation/ABI/testing/sysfs-bus-iio#L105
Yes, [Min Step Max]

> 
> > +	if (private == LTC2688_DITHER_OFF)
> > +		return sysfs_emit(buf, "0\n");  
> 
> > +	ret = ltc2688_dac_code_read(st, chan->channel, private, &val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return sysfs_emit(buf, "%u\n", val);  
> 
> These three types of output for one sysfs node? Seems it's not align with the
> idea behind sysfs. It maybe that I missed something.

Different sysfs nodes.  Though it's a fair question on whether this would be
better done as a bunch of separate callbacks, rather than one with a lookup
on the private parameter.


> 
> > +static int ltc2688_tgp_clk_setup(struct ltc2688_state *st,
> > +				 struct ltc2688_chan *chan,
> > +				 struct device_node *np, int tgp)
> > +{
> > +	unsigned long rate;
> > +	struct clk *clk;
> > +	int ret, f;
> > +
> > +	clk = devm_get_clk_from_child(&st->spi->dev, np, NULL);
> > +	if (IS_ERR(clk))  
> 
> Make it optional for non-OF, can be done as easy as
> 
> 	if (IS_ERR(clk)) {
> 		if (PTR_ERR(clk) == -ENOENT)
> 			clk = NULL;
> 		else
> 			return dev_err_probe(...);
> 	}

Interesting.  We should probably look at where else this
is appropriate.

> 
> > +		return dev_err_probe(&st->spi->dev, PTR_ERR(clk),
> > +				     "failed to get tgp clk.\n");
> > +
> > +	ret = clk_prepare_enable(clk);
> > +	if (ret)
> > +		return dev_err_probe(&st->spi->dev, ret,
> > +				     "failed to enable tgp clk.\n");
> > +
> > +	ret = devm_add_action_or_reset(&st->spi->dev, ltc2688_clk_disable, clk);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (chan->toggle_chan)
> > +		return 0;
> > +
> > +	/* calculate available dither frequencies */
> > +	rate = clk_get_rate(clk);
> > +	for (f = 0; f < ARRAY_SIZE(chan->dither_frequency); f++)
> > +		chan->dither_frequency[f] = DIV_ROUND_CLOSEST(rate, ltc2688_period[f]);
> > +
> > +	return 0;
> > +}  
> 
> ...
> 
> > +static int ltc2688_channel_config(struct ltc2688_state *st)
> > +{
> > +	struct device *dev = &st->spi->dev;
> > +	struct device_node *child;
> > +	u32 reg, clk_input, val, tmp[2];
> > +	int ret, span;
> > +
> > +	for_each_available_child_of_node(dev->of_node, child) {  
> 
> device_for_each_child_node()

This is the old issue with missing
device_for_each_available_child_node()
though can just add a check on whether it's available inside the loop.
> 
> > +		struct ltc2688_chan *chan;
> > +

...


