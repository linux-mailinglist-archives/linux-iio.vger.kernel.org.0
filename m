Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADA6F259014
	for <lists+linux-iio@lfdr.de>; Tue,  1 Sep 2020 16:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgIAOP6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 1 Sep 2020 10:15:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:60930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728173AbgIAOP1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 1 Sep 2020 10:15:27 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A9D72078B;
        Tue,  1 Sep 2020 14:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598969288;
        bh=9u0g5ohi8oruCYzGQVzBTZhpu5OcIiRuX9HVqRnW58Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qCKUYmRYqyvtzMJ0FWlIBW29z1GHj7rs8SqqdeNGFsrt+9zABD/bRMu6HYZuKRf1S
         QhMTddsgXq1CTbcDhYtSabsxBWO0NCPndgI+hYNg7bsJMirE5OZGvOMt4fmxHUmz7t
         zmzwkpQ0CVJ7hSBY/2PhAf00estI9ty1RLVNC46A=
Date:   Tue, 1 Sep 2020 16:08:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Angelo Compagnucci <angelo.compagnucci@gmail.com>,
        linux-iio@vger.kernel.org, jic23@kernel.org,
        Julia Lawall <julia.lawall@inria.fr>
Subject: Re: [PATCH] iio: adc: mcp3422: fix locking on error path
Message-ID: <20200901140836.GB580118@kroah.com>
References: <20200901093218.1500845-1-angelo.compagnucci@gmail.com>
 <20200901110125.000007cf@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901110125.000007cf@Huawei.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Sep 01, 2020 at 11:01:25AM +0100, Jonathan Cameron wrote:
> On Tue, 1 Sep 2020 11:32:18 +0200
> Angelo Compagnucci <angelo.compagnucci@gmail.com> wrote:
> 
> > Reading from the chip should be unlocked on error path else the lock
> > could never being released.
> 
> We should also reference the fix that we are fixing so I've added
> an additional fixes tag below and a reported by tag for Julia.
> 
> > 
> > Fixes: 07914c84ba30 ("iio: adc: Add driver for Microchip MCP3422/3/4 high resolution ADC")
> Fixes: 3f1093d83d71 ("iio: adc: mcp3422: fix locking scope")
> > Signed-off-by: Angelo Compagnucci <angelo.compagnucci@gmail.com>
> Reported-by: Julia Lawall <julia.lawall@inria.fr>
> Acked-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> 
> Greg, this is the fix for the issue Julia reported.
> 
> Sorry for the hassle (and messing this up in the first palce), but
> could you pick this one up directly into your staging-linus branch.

No worries, now queued up, thanks.

greg k-h
