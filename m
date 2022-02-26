Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916964C572A
	for <lists+linux-iio@lfdr.de>; Sat, 26 Feb 2022 18:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbiBZRyL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 26 Feb 2022 12:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiBZRyK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 26 Feb 2022 12:54:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17ED237D3
        for <linux-iio@vger.kernel.org>; Sat, 26 Feb 2022 09:53:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CAA18B80947
        for <linux-iio@vger.kernel.org>; Sat, 26 Feb 2022 17:53:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2017C340E8;
        Sat, 26 Feb 2022 17:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645898012;
        bh=VIfKV/A7k3FnJWADKVUq0cdczoP09UdBX8T7X4jHHCo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VIuYPZeKVVkLRGy2MbqyzV1ZhwEYvH2qfnxaLNNZcoYP9CSXExnHSiVzfqKdwD3AD
         qnP5XdmKKJvh9zTppnC+ng/wzxeQzBrK+EloN+oh4pLEMl3648gKT2+mIwZYQ5/2wr
         efu19OwcAHnDBeoxbREGR1jhA2LFHj2Qgozfw05ZbqBk2f2y8BzPYxwoGBigVXFtyv
         UPqPzCH0BbOL+Uo6vxAmQA1tzQIIV/23FdZWemRoE1oRLyWkAxpd1hx2TUhfOPeSUr
         ha/e47aMUxQdu1NrneragnIbpkHw4N69UDjP5IbN1AtOezNBJQ6XPMZ7yYvHhPGLf2
         pJhEFntjgBxdA==
Date:   Sat, 26 Feb 2022 18:00:32 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        linux-iio@vger.kernel.org, patches@lists.linux.dev,
        llvm@lists.linux.dev, kernel test robot <lkp@intel.com>,
        Colin Ian King <colin.i.king@gmail.com>
Subject: Re: [PATCH] iio: accel: adxl367: Fix handled initialization in
 adxl367_irq_handler()
Message-ID: <20220226180032.455dc1c2@jic23-huawei>
In-Reply-To: <20220224211034.625130-1-nathan@kernel.org>
References: <20220224211034.625130-1-nathan@kernel.org>
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

On Thu, 24 Feb 2022 14:10:34 -0700
Nathan Chancellor <nathan@kernel.org> wrote:

> Clang warns:
> 
>   drivers/iio/accel/adxl367.c:887:2: error: variable 'handled' is uninitialized when used here [-Werror,-Wuninitialized]
>           handled |= adxl367_push_event(indio_dev, status);
>           ^~~~~~~
>   drivers/iio/accel/adxl367.c:879:14: note: initialize the variable 'handled' to silence this warning
>           bool handled;
>                       ^
>                        = 0
>   1 error generated.
> 
> This should have used '=' instead of '|='; make that change to resolve
> the warning.
> 
> Fixes: cbab791c5e2a ("iio: accel: add ADXL367 driver")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1605
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Applied to the togreg branch of iio.git.
I also added a second reported-by to reflect the next patch setting in my inbox which
was Colin fixing the same thing.

Thanks!

> ---
>  drivers/iio/accel/adxl367.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
> index b452d74b1d4d..350a89b61179 100644
> --- a/drivers/iio/accel/adxl367.c
> +++ b/drivers/iio/accel/adxl367.c
> @@ -884,7 +884,7 @@ static irqreturn_t adxl367_irq_handler(int irq, void *private)
>  	if (ret)
>  		return IRQ_NONE;
>  
> -	handled |= adxl367_push_event(indio_dev, status);
> +	handled = adxl367_push_event(indio_dev, status);
>  	handled |= adxl367_push_fifo_data(indio_dev, status, fifo_entries);
>  
>  	return handled ? IRQ_HANDLED : IRQ_NONE;
> 
> base-commit: 2be8795a609800e5071d868d459ce29232fce2c8

