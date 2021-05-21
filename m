Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 386C838CC0C
	for <lists+linux-iio@lfdr.de>; Fri, 21 May 2021 19:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbhEURZc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 May 2021 13:25:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:47524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230301AbhEURZc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 21 May 2021 13:25:32 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD5FB6109F;
        Fri, 21 May 2021 17:24:06 +0000 (UTC)
Date:   Fri, 21 May 2021 18:25:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     tq17373059@buaa.edu.cn
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        baijiaju@tsinghua.edu.cn, TOTE Robot <oslab@tsinghua.edu.cn>
Subject: Re: [PATCH] iio: adf4350: fix a possible divided-by-zero bug in
 adf4350_set_freq()
Message-ID: <20210521182528.014f3870@jic23-huawei>
In-Reply-To: <20210521061953.35873-1-tq17373059@buaa.edu.cn>
References: <20210521061953.35873-1-tq17373059@buaa.edu.cn>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 21 May 2021 14:19:53 +0800
tq17373059@buaa.edu.cn wrote:

> From: Qi Teng <tq17373059@buaa.edu.cn>
> 
> The variable st->r1_mod is checked in:
>   if (st->r0_fract && st->r1_mod)
> 
> This indicates that st->r1_mod can be zero. Its value is the same as
> that in:
>   st->r0_fract = do_div(tmp, st->r1_mod);
> 
> However, st->r1_mod performs as a divisor in this statement, which
> implies a possible divided-by-zero bug.
> 
> To fix this possible bug, st->r1_mod is checked before the division
> operation. If it is zero, st->r0_fract is set to zero instead of
> do_div(tmp, st->r1_mod).
> 
> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn> 
> Signed-off-by: Qi Teng <tq17373059@buaa.edu.cn>

Patch seems to be inverse of the intended.  You are removing a
divide by 0 protection that isn't present in the current driver.

Also, a fix like this needs a Fixes: tag.

The maths is sufficiently messy that I can't immediately tell if this
can actually be zero or whether the check you are highlighting is
paranoia.  Given that, I agree that a fix here makes sense whether
or not we have a verified bug.

Thanks,

Jonathan

> ---
>  drivers/iio/frequency/adf4350.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
> index 99c6f260cc21..1462a6a5bc6d 100644
> --- a/drivers/iio/frequency/adf4350.c
> +++ b/drivers/iio/frequency/adf4350.c
> @@ -182,10 +182,7 @@ static int adf4350_set_freq(struct adf4350_state *st, unsigned long long freq)
>  
>  		tmp = freq * (u64)st->r1_mod + (st->fpfd >> 1);
>  		do_div(tmp, st->fpfd); /* Div round closest (n + d/2)/d */
> -		if (st->r1_mod)
> -			st->r0_fract = do_div(tmp, st->r1_mod);
> -		else
> -			st->r0_fract = 0;
> +		st->r0_fract = do_div(tmp, st->r1_mod);
>  		st->r0_int = tmp;
>  	} while (mdiv > st->r0_int);
>  

