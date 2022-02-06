Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F614AB01D
	for <lists+linux-iio@lfdr.de>; Sun,  6 Feb 2022 16:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234424AbiBFPJ6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Feb 2022 10:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbiBFPJ6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Feb 2022 10:09:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6AB0C06173B;
        Sun,  6 Feb 2022 07:09:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 430E4B80DD6;
        Sun,  6 Feb 2022 15:09:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFCD2C340E9;
        Sun,  6 Feb 2022 15:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644160192;
        bh=8XiFZAt3Z+S3cquKSI5VSpHORDUu4uQH/dqqt0anApU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=baPXJzngV2Lcq6Zq7D7mPFGy31M0sEJyZJFEesYruGQiL6UGpm/SF0lp3UCe3XX23
         tvCUCUDkXbIl23VjzVDGF3dcxupFKDAu8etJBs2Ephfz5kqmQ7P0yqOO6JOKplEaO6
         kMDZKhcZD2MYKvFAtae0Gq92uZXl5UHBeEH9zZ2J56VK//50d/itSwG6CouuTTjMlk
         qHDWt0R2KwZY3kAJZTLMsTYtgHGfDOy/rwe9yP5RxFsJ7543QJQK1gTo2jfEDk0WL4
         b8IXHELPbULDXVbQHMxHuwD33YVyLHn5oNfUkq7JlhdWZWroHGNhE63JKJOouiggQr
         Wh2w/JOBjz/jQ==
Date:   Sun, 6 Feb 2022 15:16:24 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v3 1/3] iio: dac: add support for ltc2688
Message-ID: <20220206151624.58589a05@jic23-huawei>
In-Reply-To: <Yf7IxJKmAtgqT2rB@smile.fi.intel.com>
References: <20220121142501.151-1-nuno.sa@analog.com>
        <20220121142501.151-2-nuno.sa@analog.com>
        <Yf60A1UkbBtQ68qv@smile.fi.intel.com>
        <20220205184459.7aa8e5d5@jic23-huawei>
        <Yf7G91IuwAw0trgz@smile.fi.intel.com>
        <Yf7IxJKmAtgqT2rB@smile.fi.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 5 Feb 2022 20:58:12 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Sat, Feb 05, 2022 at 08:50:31PM +0200, Andy Shevchenko wrote:
> > On Sat, Feb 05, 2022 at 06:44:59PM +0000, Jonathan Cameron wrote:  
> > > On Sat, 5 Feb 2022 19:29:39 +0200
> > > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > > 
> > > A few comments from me, mostly because I couldn't resist jumping in ;)
> > > Note this is only some of the things Andy raised....  
> > 
> > ...
> >   
> > > > > +static int ltc2688_channel_config(struct ltc2688_state *st)
> > > > > +{
> > > > > +	struct device *dev = &st->spi->dev;
> > > > > +	struct device_node *child;
> > > > > +	u32 reg, clk_input, val, tmp[2];
> > > > > +	int ret, span;
> > > > > +
> > > > > +	for_each_available_child_of_node(dev->of_node, child) {    
> > > > 
> > > > device_for_each_child_node()  
> > > 
> > > This is the old issue with missing
> > > device_for_each_available_child_node()
> > > though can just add a check on whether it's available inside the loop.  
> > 
> > Didn't we discuss this with Rob and he told that device_for_each_child_node()
> > is already for available only?  
> 
> https://lore.kernel.org/lkml/20211205190101.26de4a57@jic23-huawei/T/#u
> 
> So, the fwnode has a correct implementation, and we may use it here.
> 
I wasn't totally sure of the conclusion of that discussion.
a) Fine to just use device_for_each_child_node() for this case and not worry about it.
b) Worth adding device_for_each_available_child_node() with the same implementation
c) (possibly workaround / avoid the issue) Use device_for_each_child_node() but also
check validity (hopefully compiler would remove the check) in order to act
as documentation.

I'm fine with any of the above.

J

