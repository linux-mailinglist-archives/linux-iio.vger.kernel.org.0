Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1FA851E7CA
	for <lists+linux-iio@lfdr.de>; Sat,  7 May 2022 16:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbiEGOa0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 May 2022 10:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234096AbiEGOaZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 7 May 2022 10:30:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D292DFC
        for <linux-iio@vger.kernel.org>; Sat,  7 May 2022 07:26:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1087F608C3
        for <linux-iio@vger.kernel.org>; Sat,  7 May 2022 14:26:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B272C385A6;
        Sat,  7 May 2022 14:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651933597;
        bh=r2RR8Oj94rmdytDHfyHW+xPREWfiOCu6MVxS088cpKU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Mf5yc42oL9iC1l6R0gsW2jj8GlEKuCOxFiCuftZkx86XhAqCPJ1V2/1KCs81NAZsd
         mRLZgbf0QkauDplokzkXnF4BLSSXOQA6wq8mqWZJY/Ambl0JQtlGapPBDkNYv5dYS8
         3xe0wutF20f0JvSkzpocc8utGZ5Fg4oL7laz3iL50lVqcjJ84EkPqMm7KTaeYhH/oi
         JbKpf4fDqvHv8cZ4Z1wx9QbK/PDevfHY+S6f1nSBIaD6j9pmz6+XRFUiWL2ho8B9KH
         pj0zc9Ml/IiaUmFBviYMmwloEzRITSrsBvHEikNPn47fSK2p4vTxpdja1yVh2QP6ah
         DjNBYMf7gouuQ==
Date:   Sat, 7 May 2022 15:35:05 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Jakob Hauser <jahau@rocketmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] iio: magnetometer: yas530: Fix memchr_inv() misuse
Message-ID: <20220507153505.15a83c1a@jic23-huawei>
In-Reply-To: <20220501195029.151852-1-linus.walleij@linaro.org>
References: <20220501195029.151852-1-linus.walleij@linaro.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-pc-linux-gnu)
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

On Sun,  1 May 2022 21:50:29 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> The call to check if the calibration is all zeroes is doing
> it wrong: memchr_inv() returns NULL if the the calibration
> contains all zeroes, but the check is for != NULL.
> 
> Fix it up. It's probably not an urgent fix because the inner
> check for BIT(7) in data[13] will save us. But fix it.
> 
> Fixes: de8860b1ed47 ("iio: magnetometer: Add driver for Yamaha YAS530")
> Reported-by: Jakob Hauser <jahau@rocketmail.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

> ---
>  drivers/iio/magnetometer/yamaha-yas530.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
> index 9ff7b0e56cf6..b2bc637150bf 100644
> --- a/drivers/iio/magnetometer/yamaha-yas530.c
> +++ b/drivers/iio/magnetometer/yamaha-yas530.c
> @@ -639,7 +639,7 @@ static int yas532_get_calibration_data(struct yas5xx *yas5xx)
>  	dev_dbg(yas5xx->dev, "calibration data: %*ph\n", 14, data);
>  
>  	/* Sanity check, is this all zeroes? */
> -	if (memchr_inv(data, 0x00, 13)) {
> +	if (memchr_inv(data, 0x00, 13) == NULL) {
>  		if (!(data[13] & BIT(7)))
>  			dev_warn(yas5xx->dev, "calibration is blank!\n");
>  	}

