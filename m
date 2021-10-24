Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5A0043887C
	for <lists+linux-iio@lfdr.de>; Sun, 24 Oct 2021 13:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbhJXLRh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 24 Oct 2021 07:17:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:52744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229867AbhJXLRh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 Oct 2021 07:17:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 957246101C;
        Sun, 24 Oct 2021 11:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1635074117;
        bh=LawrTZjKX8RHjwzakLGkqtpEnHHyyNhHyCEsGZokAJc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Iz36/38TUM8O+nW4U6+1KTSfGZ0BHY/gqPAWU638wiseGo4DHqnB0Xifs4AI6y+YZ
         9711tyWCRipO8Xuz85qWXaqqK4TYdeKEAYIBchi47nsAqTgyhc8+Phgx0JFaMtAts/
         1LRE9uLnqwBPZ/gw0PcWtngBmHrQLi6xL9Viicac=
Date:   Sun, 24 Oct 2021 13:14:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] iio: frequency: adrf6780: Fix adrf6780_spi_{read,write}()
Message-ID: <YXVAK9ffYSpY1m/N@kroah.com>
References: <20211022195656.1513147-1-nathan@kernel.org>
 <20211023164333.36b2ea2c@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211023164333.36b2ea2c@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Oct 23, 2021 at 04:43:33PM +0100, Jonathan Cameron wrote:
> On Fri, 22 Oct 2021 12:56:56 -0700
> Nathan Chancellor <nathan@kernel.org> wrote:
> 
> > Clang warns:
> > 
> > drivers/iio/frequency/adrf6780.c:117:1: error: all paths through this
> > function will call itself [-Werror,-Winfinite-recursion]
> > {
> > ^
> > drivers/iio/frequency/adrf6780.c:138:1: error: all paths through this
> > function will call itself [-Werror,-Winfinite-recursion]
> > {
> > ^
> > 2 errors generated.
> > 
> > The underscore variants should be used here.
> > 
> > Fixes: 63aaf6d06d87 ("iio: frequency: adrf6780: add support for ADRF6780")
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1490
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> 
> Thanks Nathan, (bit embarrassed I missed this in review :(
> As you probably guessed I didn't run an llvm test this time - guess I should
> start doing that on a regular basis.
> 
> We obviously have plenty of time to get this fix in place but
> seeing as I just sent a pull request for the driver a few hours before this
> patch:
> 
> Greg, would you mind picking this one up directly on top of
> [PULL] 2nd set of IIO new device support, features, cleanup for 5.16 
> if you take that pull request?
> 
> Message ID for this one is:
> 
> 20211022195656.1513147-1-nathan@kernel.org
> 
> No problem if you'd rather I just queue this fix up for post merge
> window.
> 
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Picked it up now, thanks!

greg k-h
