Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8839143840A
	for <lists+linux-iio@lfdr.de>; Sat, 23 Oct 2021 17:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbhJWPlf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 23 Oct 2021 11:41:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:52862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229901AbhJWPle (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 23 Oct 2021 11:41:34 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1ADA60FE3;
        Sat, 23 Oct 2021 15:39:12 +0000 (UTC)
Date:   Sat, 23 Oct 2021 16:43:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, gregkh@linuxfoundation.org
Subject: Re: [PATCH] iio: frequency: adrf6780: Fix
 adrf6780_spi_{read,write}()
Message-ID: <20211023164333.36b2ea2c@jic23-huawei>
In-Reply-To: <20211022195656.1513147-1-nathan@kernel.org>
References: <20211022195656.1513147-1-nathan@kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 22 Oct 2021 12:56:56 -0700
Nathan Chancellor <nathan@kernel.org> wrote:

> Clang warns:
> 
> drivers/iio/frequency/adrf6780.c:117:1: error: all paths through this
> function will call itself [-Werror,-Winfinite-recursion]
> {
> ^
> drivers/iio/frequency/adrf6780.c:138:1: error: all paths through this
> function will call itself [-Werror,-Winfinite-recursion]
> {
> ^
> 2 errors generated.
> 
> The underscore variants should be used here.
> 
> Fixes: 63aaf6d06d87 ("iio: frequency: adrf6780: add support for ADRF6780")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1490
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Thanks Nathan, (bit embarrassed I missed this in review :(
As you probably guessed I didn't run an llvm test this time - guess I should
start doing that on a regular basis.

We obviously have plenty of time to get this fix in place but
seeing as I just sent a pull request for the driver a few hours before this
patch:

Greg, would you mind picking this one up directly on top of
[PULL] 2nd set of IIO new device support, features, cleanup for 5.16 
if you take that pull request?

Message ID for this one is:

20211022195656.1513147-1-nathan@kernel.org

No problem if you'd rather I just queue this fix up for post merge
window.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks,

Jonathan

> ---
>  drivers/iio/frequency/adrf6780.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/frequency/adrf6780.c b/drivers/iio/frequency/adrf6780.c
> index abe8b30fceca..8255ffd174f6 100644
> --- a/drivers/iio/frequency/adrf6780.c
> +++ b/drivers/iio/frequency/adrf6780.c
> @@ -118,7 +118,7 @@ static int adrf6780_spi_read(struct adrf6780_state *st, unsigned int reg,
>  	int ret;
>  
>  	mutex_lock(&st->lock);
> -	ret = adrf6780_spi_read(st, reg, val);
> +	ret = __adrf6780_spi_read(st, reg, val);
>  	mutex_unlock(&st->lock);
>  
>  	return ret;
> @@ -139,7 +139,7 @@ static int adrf6780_spi_write(struct adrf6780_state *st, unsigned int reg,
>  	int ret;
>  
>  	mutex_lock(&st->lock);
> -	ret = adrf6780_spi_write(st, reg, val);
> +	ret = __adrf6780_spi_write(st, reg, val);
>  	mutex_unlock(&st->lock);
>  
>  	return ret;
> 
> base-commit: 77af145dc7eadcb78d38912b67d6a68050d21a9b

