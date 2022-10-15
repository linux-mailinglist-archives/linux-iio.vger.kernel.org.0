Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD85C5FFB37
	for <lists+linux-iio@lfdr.de>; Sat, 15 Oct 2022 18:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiJOQdh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 15 Oct 2022 12:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiJOQdg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 15 Oct 2022 12:33:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83072459A6;
        Sat, 15 Oct 2022 09:33:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08E3060DF1;
        Sat, 15 Oct 2022 16:33:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7170C433C1;
        Sat, 15 Oct 2022 16:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665851614;
        bh=sv8xBoBbu1BXG+yJjHDJHajZELLSh/s25hm4T7FUqdY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qbXle7DojehGW5QAMmXjbqHSlL4uQ+bmBPvdOFCCduGgkp3HqXl5A4MVA6yRSd8j/
         588pbWy9gc0xX9mHVT+ieKRqpx0a6l23gb+WxzWO5LMBeDUqq+j1QqOaYOvF1qLAPy
         pUvfnBJNeNhqIeJEyRQCUpZWyays7GO/sC9aEXPobXRZ5pYX4sek8l2Q3ttf7bHJNZ
         xoH4eHgEn7sFqtz3MGQcL7mxQKhj7aHeT75g9ul98k3hL8bc/63Lw/L/VRs8lQF42J
         55lC6qpZOYYzg09uOgts8rXloFBSwuqi+ClLeInSxQoOijcARELkmDklSF6mgCY2uJ
         cPTWf2E825sfg==
Date:   Sat, 15 Oct 2022 17:33:59 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Andrea Merello <andrea.merello@iit.it>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: imu: bno055: uninitialized variable bug in
 bno055_trigger_handler()
Message-ID: <20221015173359.20c7928e@jic23-huawei>
In-Reply-To: <Y0kuaO9PQkSQja+A@kili>
References: <Y0kuaO9PQkSQja+A@kili>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 14 Oct 2022 12:39:52 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> This bug is basically harmless, although it will trigger a runtime warning
> if you use KMSan.  On the first iteration through the loop, the
> "best_delta" variable is uninitialized so re-order the condition to
> prevent reading uninitialized memory.
> 
> Fixes: 4aefe1c2bd0c ("iio: imu: add Bosch Sensortec BNO055 core driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

You reported this a while back along with a second issue (false positive)
with hwval.

I posted a patch fixing both 
https://lore.kernel.org/linux-iio/20221002145324.3776484-1-jic23@kernel.org/

I don't really care which patch goes in, but curious to reasoning to not also
deal with the hwval warning here?

Jonathan

> ---
>  drivers/iio/imu/bno055/bno055.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/bno055/bno055.c b/drivers/iio/imu/bno055/bno055.c
> index 307557a609e3..52744dd98e65 100644
> --- a/drivers/iio/imu/bno055/bno055.c
> +++ b/drivers/iio/imu/bno055/bno055.c
> @@ -632,7 +632,7 @@ static int bno055_set_regmask(struct bno055_priv *priv, int val, int val2,
>  			return -EINVAL;
>  		}
>  		delta = abs(tbl_val - req_val);
> -		if (delta < best_delta || first) {
> +		if (first || delta < best_delta) {
>  			best_delta = delta;
>  			hwval = i;
>  			first = false;

