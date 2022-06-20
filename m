Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C095524D7
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jun 2022 21:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiFTTxe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jun 2022 15:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiFTTxb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jun 2022 15:53:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B9619C3F
        for <linux-iio@vger.kernel.org>; Mon, 20 Jun 2022 12:53:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6456A61631
        for <linux-iio@vger.kernel.org>; Mon, 20 Jun 2022 19:53:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F505C3411B;
        Mon, 20 Jun 2022 19:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655754808;
        bh=IMdeFzYQ1mLSZrBCJiTAF5cg7K7jo5xuv61owUiLAhU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nAqWbgEfkrcUXOVmJ5yeVnmT4zGaZ4LhNLFvblIfS7RaSU+oxajq+KX6ArU1gQ4tN
         csWsWVpQq9JsQMAosxq7UN2r1VzH+vycFccyGG1S/Q+hdyNRAkCKYxYP/734Zbx5mS
         eTe0KxMlTl0rYVEforAFOzrP9Z8A8WapH1R2vRI1sJ+nwJdEwdaTIAiPcC/JK4zJF7
         1N1m+oyHPCNJkwfu5xW3CJOjxfgqveDqCEZ1fCHWFoeozTIJtF2O3YNGK3AQfDDr+7
         Zl29yGp5caSMIWTL6o6XLmktNWtzeHrRC6bhzbEMNOWIh8B//wOJD/dNqDs/jVS5Va
         ofvYNDtwDEWBg==
Date:   Mon, 20 Jun 2022 20:53:22 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Peter Rosin <peda@axentia.se>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: Re: [PATCH v2 16/17] iio: cdc: ad7746: Move driver out of staging.
Message-ID: <20220620205322.737f4a57@jic23-huawei>
In-Reply-To: <CAHp75Vd6V0-h82MmDfwWa5e_0_DD1-S7jAmse-fhiAc2nmRc_w@mail.gmail.com>
References: <20220619185839.1363503-1-jic23@kernel.org>
        <20220619185839.1363503-17-jic23@kernel.org>
        <CAHp75VdTwj6sAQp2r2egFXvr5RQvnDHrOUo45==UT-_6A9GKrg@mail.gmail.com>
        <20220620174044.000061af@Huawei.com>
        <CAHp75Vd6V0-h82MmDfwWa5e_0_DD1-S7jAmse-fhiAc2nmRc_w@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 20 Jun 2022 20:40:17 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Mon, Jun 20, 2022 at 6:40 PM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> > On Mon, 20 Jun 2022 01:11:36 +0200
> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:  
> > > On Sun, Jun 19, 2022 at 8:59 PM Jonathan Cameron <jic23@kernel.org> wrote:  
> 
> ...
> 
> > > >  drivers/iio/cdc/ad7746.c         | 818 +++++++++++++++++++++++++++++++
> > > >  drivers/staging/iio/cdc/ad7746.c | 818 -------------------------------  
> > >
> > > It's a bit hard to review, perhaps you forgot to add -M -C when
> > > generating this patch?  
> >
> > Specifically passed --no-renames because this is a direct file move -
> > I should have stated that though.
> >
> > The intent is to allow review of the full driver as being proposed for
> > move out of staging.  
> 
> In (my) practice it only makes review much harder without any
> additional benefits. Git is smart to understand renaming and in the
> diffstat there is a special line about renaming.
> 
> >  Including the bits that otherwise aren't
> > visible anywhere in the driver.  I only do this (and ask for it from others)
> > for staging graduation patches.  
> 
> Perhaps somebody finds that useful, but me :-)
> 

I definitely do as lets me lazy and not apply the patches just do a review
+ where do you comment on something in the original driver that is getting moved?
That particularly use case only really applies to drivers moving out of staging
though.  Alternative is to paste the entire driver in the cover letter which
is not a great solution either...

Jonathan


