Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B386C4DE9FC
	for <lists+linux-iio@lfdr.de>; Sat, 19 Mar 2022 19:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237861AbiCSST4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 19 Mar 2022 14:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234687AbiCSST4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 19 Mar 2022 14:19:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D01719A54E;
        Sat, 19 Mar 2022 11:18:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B77CC60AB4;
        Sat, 19 Mar 2022 18:18:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 402C6C340EC;
        Sat, 19 Mar 2022 18:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647713912;
        bh=W/45bdkqqVIDTi0QdnUU8/dGtYxRWLLNZWpynRVWzsI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OEb2vAIdUMUBvrk6iMO/XL8F2yY4scUfhU97ZQoVKCSW+snL1A5+yMvq/i5KiB/7A
         NT4Mjh+CZ06vBIOIm6YaN28n+ujzKJhRR9EJcL2cVZkkz7ERg49lrX/WhC+3UW43yo
         nKalEmpFD/1TqGuat9eQiKB7CmooEy1URQI0nhq/L3a6PdHAral7uK6KQ7iG08zyy0
         RHnSbu4wiO5lCCBoRqx2MFGCrsoZQEg5uCH5Xl08bggy0GaKuqdxJdI43RyxFyShLI
         y5wWCYf4XgJ7UjGfPMUmYPtbQZkSH1TKVhkWTpTjVutV/CuqscyklGVz8E+ZtIwBzQ
         CIKGEcrPeTE9Q==
Date:   Sat, 19 Mar 2022 18:25:55 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Mihail Chindris <mihail.chindris@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: dac: ad3552r: fix signedness bug in
 ad3552r_reset()
Message-ID: <20220319182555.73aaa20a@jic23-huawei>
In-Reply-To: <20220316122354.GA16825@kili>
References: <20220316122354.GA16825@kili>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 16 Mar 2022 15:23:54 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> The "val" variable is used to store either negative error codes from
> ad3552r_read_reg_wrapper() or positive u16 values on success.  It needs
> to be signed for the error handling to work correctly.
> 
> Fixes: 8f2b54824b28 ("drivers:iio:dac: Add AD3552R driver support")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Applied to the fixes-togreg branch of iio.git, but I won't be pushing it
out publicly until I have rebased that tree on rc1 as it may make a mess
of ordering in linux-next

Thanks,

Jonathan

> ---
>  drivers/iio/dac/ad3552r.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/ad3552r.c b/drivers/iio/dac/ad3552r.c
> index 97f13c0b9631..e0a93b27e0e8 100644
> --- a/drivers/iio/dac/ad3552r.c
> +++ b/drivers/iio/dac/ad3552r.c
> @@ -656,7 +656,7 @@ static int ad3552r_reset(struct ad3552r_desc *dac)
>  {
>  	struct reg_addr_pool addr;
>  	int ret;
> -	u16 val;
> +	int val;
>  
>  	dac->gpio_reset = devm_gpiod_get_optional(&dac->spi->dev, "reset",
>  						  GPIOD_OUT_LOW);

