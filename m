Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C942468C20
	for <lists+linux-iio@lfdr.de>; Sun,  5 Dec 2021 17:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235934AbhLEQgo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Dec 2021 11:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbhLEQgn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Dec 2021 11:36:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DF9C061714
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 08:33:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 11264B80E87
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 16:33:15 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 7191CC00446;
        Sun,  5 Dec 2021 16:33:12 +0000 (UTC)
Date:   Sun, 5 Dec 2021 16:38:23 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 09/12] iio:adc:ti-adc12138: Switch to generic
 firmware properties.
Message-ID: <20211205163823.1ed4f546@jic23-huawei>
In-Reply-To: <CAHp75VcHiX+DzxTSu7HtymtJ9CSZeVmtimK16wMOMQ44FS_=9A@mail.gmail.com>
References: <20211204171237.2769210-1-jic23@kernel.org>
        <20211204171237.2769210-10-jic23@kernel.org>
        <CAHp75VdsDsG98d4zwSTdVrcD9yiiag82yssLrLB0ehzAiNiRyQ@mail.gmail.com>
        <CAHp75VcHiX+DzxTSu7HtymtJ9CSZeVmtimK16wMOMQ44FS_=9A@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 5 Dec 2021 17:13:42 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sun, Dec 5, 2021 at 5:12 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Sat, Dec 4, 2021 at 7:07 PM Jonathan Cameron <jic23@kernel.org> wrote:  
> 
> ...
> 
> > > -#ifdef CONFIG_OF
> > > -  
> >
> > It's a sign that somewhere should be of_match_ptr().
> > Please, double check that you remove that as well in all conversion patches.  
Indeed - missed this one.  I'll fix up for v3.  I just checked and no others
in this set.

> 
> Also, check that you drop OF dependencies (where it's the case) from a
> certain Kconfig.

There were very few with an OF dependency in this set (just the ads124s08 in
patch 11).

Jonathan

> 
> > >  static const struct of_device_id adc12138_dt_ids[] = {
> > >         { .compatible = "ti,adc12130", },
> > >         { .compatible = "ti,adc12132", },  
> 

