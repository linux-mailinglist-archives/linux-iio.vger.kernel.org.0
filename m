Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABD0734504C
	for <lists+linux-iio@lfdr.de>; Mon, 22 Mar 2021 20:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbhCVTvh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Mar 2021 15:51:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:38200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232290AbhCVTv0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 22 Mar 2021 15:51:26 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 316C361937;
        Mon, 22 Mar 2021 19:51:23 +0000 (UTC)
Date:   Mon, 22 Mar 2021 19:51:23 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 1/2] iio: magnetometer: yas530: Fix return value on
 errorpath
Message-ID: <20210322195123.61d0688a@jic23-huawei>
In-Reply-To: <CACRpkdbk80cK34vDNjfLkpeso4dC8ZXOe5WGgi2PP8KHSLxuxg@mail.gmail.com>
References: <20210215153023.47899-1-linus.walleij@linaro.org>
        <20210221154511.75b3d8a6@archlinux>
        <CACRpkdbk80cK34vDNjfLkpeso4dC8ZXOe5WGgi2PP8KHSLxuxg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 1 Mar 2021 10:00:35 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Sun, Feb 21, 2021 at 4:45 PM Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > A bit of bad timing on these.  I'm running behind on pull requests for
> > my fixes-togreg branch so it doesn't yet have the driver.
> >
> > Hence I'll pick these up in a couple of weeks once that's rebased after
> > I send Greg a pull request.
> >
> > Give me a poke if I seem to have forgotten them.  
> 
> No problem, the fixes are not critical in any way.
> I'll track them!
> 
Series applied to the fixes-togreg branch of iio.git.

Apologies for the delay.

Jonathan

> Yours,
> Linus Walleij

