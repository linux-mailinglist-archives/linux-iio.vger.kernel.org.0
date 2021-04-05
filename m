Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDA9354522
	for <lists+linux-iio@lfdr.de>; Mon,  5 Apr 2021 18:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242355AbhDEQ0l (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Apr 2021 12:26:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:37468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242354AbhDEQ0h (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 5 Apr 2021 12:26:37 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 385A761394;
        Mon,  5 Apr 2021 16:26:28 +0000 (UTC)
Date:   Mon, 5 Apr 2021 17:26:46 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] iio: hrtimer-trigger: Fix potential integer
 overflow in iio_hrtimer_store_sampling_frequency
Message-ID: <20210405172646.6a9f1b7d@jic23-huawei>
In-Reply-To: <20210329205817.GA188755@embeddedor>
References: <20210329205817.GA188755@embeddedor>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 29 Mar 2021 15:58:17 -0500
"Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:

> Add suffix ULL to constant 1000 in order to avoid a potential integer
> overflow and give the compiler complete information about the proper
> arithmetic to use. Notice that this constant is being used in a context
> that expects an expression of type unsigned long long, but it's
> currently evaluated using 32-bit arithmetic.
> 
> Addresses-Coverity-ID: 1503062 ("Unintentional integer overflow")
> Fixes: dafcf4ed8392 ("iio: hrtimer: Allow sub Hz granularity")
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks, Applied to the togreg branch of iio.git and pushed out as testing
for 0-day to poke at it.

Thanks,

Jonathan

> ---
>  drivers/iio/trigger/iio-trig-hrtimer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/trigger/iio-trig-hrtimer.c b/drivers/iio/trigger/iio-trig-hrtimer.c
> index 51e362f091c2..716c795d08fb 100644
> --- a/drivers/iio/trigger/iio-trig-hrtimer.c
> +++ b/drivers/iio/trigger/iio-trig-hrtimer.c
> @@ -63,7 +63,7 @@ ssize_t iio_hrtimer_store_sampling_frequency(struct device *dev,
>  	if (integer < 0 || fract < 0)
>  		return -ERANGE;
>  
> -	val = fract + 1000 * integer;  /* mHz */
> +	val = fract + 1000ULL * integer;  /* mHz */
>  
>  	if (!val || val > UINT_MAX)
>  		return -EINVAL;

