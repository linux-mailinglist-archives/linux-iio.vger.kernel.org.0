Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4FAA591BB3
	for <lists+linux-iio@lfdr.de>; Sat, 13 Aug 2022 17:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239887AbiHMPrl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 13 Aug 2022 11:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239925AbiHMPrd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 13 Aug 2022 11:47:33 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7492733432
        for <linux-iio@vger.kernel.org>; Sat, 13 Aug 2022 08:47:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C2D35CE090C
        for <linux-iio@vger.kernel.org>; Sat, 13 Aug 2022 15:47:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 186A1C433D6;
        Sat, 13 Aug 2022 15:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660405649;
        bh=lHzsBgRnEig49uIOE7AKs9XEv7/lUa8zuf/07oC+S0Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dnVsgNvSo/gfQMzQTWKZCNecxnLBKM+zdIHmEvG8kn/3cUrHU5PtQcb7FAKNtUE1z
         Ia7maKaVMlACGQLq766NZERnPk7Oxl9wYrYFEizmGwdl1DFtGIDukB84KiXSD6I11w
         7mK+zOkyOczFzMF4Bw8VQaDorS/Y78SVZYTdOFeslXtDuzxQwcyvw1EJemuX3ASTxf
         OXQ5FBRv9UjbOE/SEMZ3Fx/AwJOKL0CgiyukReh/aFv4ZiSPjY0nZlBOr96bQaV4tD
         NPeBd17xZ6RkAng7qZd1+PRB1RnbD32R0aSD1osgrvTHYrz4ojpKhbpwFFE6r/N5Ta
         rL6e5WvaYUNOw==
Date:   Sat, 13 Aug 2022 16:57:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 0/2] IIO: Clean up a couple of warnings that snuck in.
Message-ID: <20220813165758.5050b84e@jic23-huawei>
In-Reply-To: <CAHp75VehuNsXbNO0qW0aYZqZcmAR3VbOR_zQQurhNxyLUtiWeA@mail.gmail.com>
References: <20220807145457.646062-1-jic23@kernel.org>
        <CAHp75VehuNsXbNO0qW0aYZqZcmAR3VbOR_zQQurhNxyLUtiWeA@mail.gmail.com>
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

On Mon, 8 Aug 2022 11:15:52 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sun, Aug 7, 2022 at 4:50 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > I'm not sure how these slipped through my local tests and 0-day.
> > These are definitely shown with W=1, perhaps not without that
> > but IIO is generally W=1 clean.  
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Applied. Thanks,

Jonathan

> 
> > Jonathan Cameron (2):
> >   iio: test: Mark file local structure arrays static.
> >   iio: light: cm32181: Mark the dev_pm_ops static.
> >
> >  drivers/iio/light/cm32181.c         | 2 +-
> >  drivers/iio/test/iio-test-rescale.c | 4 ++--
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > --
> > 2.37.1
> >  
> 
> 

