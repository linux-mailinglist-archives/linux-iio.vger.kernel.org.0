Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D5F5523E4
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jun 2022 20:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243887AbiFTSal (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jun 2022 14:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245116AbiFTSak (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jun 2022 14:30:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E721D0E8
        for <linux-iio@vger.kernel.org>; Mon, 20 Jun 2022 11:30:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 36648B815BD
        for <linux-iio@vger.kernel.org>; Mon, 20 Jun 2022 18:30:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE85BC3411B;
        Mon, 20 Jun 2022 18:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655749835;
        bh=fdyCJemfBRopcbDqNOpLUnGiTLZA1wpnH0r4o9y59k0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Zs65MuOHqkQ77LZoxksW4etYcZTTmYCz0Rp3qgLOueCpJu08sBPU/shH7tfp/WAqF
         7CnTH6ci3ytiZkml2UD22ZXFqGgXwKG366xtD1nDK61zha5ULhBAT9UaZJ2gbj8elA
         QwbkSAdHrHOyPfL+8Qo4wIyz2FFTY4FkyyOqUqvAsOoREZ3O8an5M0BxvSdYRNCXYQ
         zMGIuph8YO7rwf5Tak6/6bjVaDL5EpTMhKeMYUwKVedosLdz5wNWmF6Sy3kvsWfouK
         jIChJr/pfe82SZmrPG6+TvaNdPtPXk0tlteI8BeONQfU3b0oVae4OoAH8J+jaGjk8E
         bEsbaudvrYqKg==
Date:   Mon, 20 Jun 2022 19:30:30 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Peter Rosin <peda@axentia.se>,
        "Michael Hennerich" <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: Re: [PATCH v2 16/17] iio: cdc: ad7746: Move driver out of staging.
Message-ID: <20220620193030.4b4b1764@jic23-huawei>
In-Reply-To: <20220620174044.000061af@Huawei.com>
References: <20220619185839.1363503-1-jic23@kernel.org>
        <20220619185839.1363503-17-jic23@kernel.org>
        <CAHp75VdTwj6sAQp2r2egFXvr5RQvnDHrOUo45==UT-_6A9GKrg@mail.gmail.com>
        <20220620174044.000061af@Huawei.com>
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

On Mon, 20 Jun 2022 17:40:44 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Mon, 20 Jun 2022 01:11:36 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> 
> > On Sun, Jun 19, 2022 at 8:59 PM Jonathan Cameron <jic23@kernel.org> wrote:  
> > >
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >
> > > All known major issues with this driver resolved so time to move
> > > it out of staging.
> > >
> > > Note this cleanup work was done using the roadtest framework.
> > > https://lore.kernel.org/all/20220311162445.346685-1-vincent.whitchurch@axis.com/
> > >
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > ---
> > >  drivers/iio/cdc/Kconfig          |  10 +
> > >  drivers/iio/cdc/Makefile         |   1 +
> > >  drivers/iio/cdc/ad7746.c         | 818 +++++++++++++++++++++++++++++++
> > >  drivers/staging/iio/cdc/ad7746.c | 818 -------------------------------    
> > 
> > It's a bit hard to review, perhaps you forgot to add -M -C when
> > generating this patch?  
> 
> Specifically passed --no-renames because this is a direct file move -
> I should have stated that though.
> 
> The intent is to allow review of the full driver as being proposed for
> move out of staging.  Including the bits that otherwise aren't
> visible anywhere in the driver.  I only do this (and ask for it from others)
> for staging graduation patches.
> 
> However, I've just noticed the diff doesn't include removing the entries
> from drivers/staging/iio/cdc/Kconfig + drivers/staging/iio/cdc/Makefile
> which is weird.  Will check that for v3.

Follow through from using the roadtest specific Makefile which wasn't building
staging drivers.  A normal build indeed through up that there was a clash
due to the leftover files.  Wow, I wasn't on good form whilst doing this!

Jonathan

> 
> Thanks,
> 
> Jonathan
>  
> > 
> > (Also note that `git am` able to parse renamings, the only thing which
> > should be in full in patches is when one deletes the file, although it
> > may be already supported by newest versions of Git, dunno)
> >   
> 

