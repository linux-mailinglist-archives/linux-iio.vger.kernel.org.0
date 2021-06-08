Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0358F39FC45
	for <lists+linux-iio@lfdr.de>; Tue,  8 Jun 2021 18:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbhFHQWg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Jun 2021 12:22:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:52786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231794AbhFHQWf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 8 Jun 2021 12:22:35 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50DA561249;
        Tue,  8 Jun 2021 16:20:41 +0000 (UTC)
Date:   Tue, 8 Jun 2021 17:22:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Wolfram Sang <wsa@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Tom Rix <trix@redhat.com>, Sean Nyekjaer <sean@geanix.com>
Subject: Re: [PATCH] i2c: core: Add stub for i2c_verify_client() if
 !CONFIG_I2C
Message-ID: <20210608172233.47397d2d@jic23-huawei>
In-Reply-To: <YLkzx7TD/BFu/CAQ@kunai>
References: <20210603165835.3594557-1-jic23@kernel.org>
        <YLkzx7TD/BFu/CAQ@kunai>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 3 Jun 2021 21:55:51 +0200
Wolfram Sang <wsa@kernel.org> wrote:

> On Thu, Jun 03, 2021 at 05:58:35PM +0100, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > If I2C is not compiled, there is no way we should see a call to
> > i2c_verify_client() on a device that is an i2c client. As such,
> > provide a stub to return NULL to resolve an associated build failure.
> > 
> > The build is failing with this link error
> > ld: fxls8962af-core.o: in function `fxls8962af_fifo_transfer':
> > fxls8962af-core.c: undefined reference to `i2c_verify_client'
> > 
> > Reported-by: Tom Rix <trix@redhat.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Fixes: 68068fad0e1c ("iio: accel: fxls8962af: fix errata bug E3 - I2C burst reads")
> > Reviewed-by: Sean Nyekjaer <sean@geanix.com>
> > Cc: Wolfram Sang <wsa@kernel.org>  
> 
> Thanks for doing this!
> 
> Acked-by: Wolfram Sang <wsa@kernel.org>
> 

immutable branch at:
ib-iio-i2c-5.13rc1 https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git

I let this sit in next (via a merge with IIO togreg branch) for a day to
shake out any ways in which I messed it up.

As it turns out, that was a good plan given the fixes tag had gone stale.
Now fixed that and will be sending a pull request to Greg KH including the
update IIO merge shortly (which is in linux-next today).

Thanks,

Jonathan
