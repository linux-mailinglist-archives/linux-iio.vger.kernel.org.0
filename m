Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F040D43E2F9
	for <lists+linux-iio@lfdr.de>; Thu, 28 Oct 2021 16:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbhJ1ODR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Oct 2021 10:03:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:47274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231303AbhJ1ODF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 28 Oct 2021 10:03:05 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF313610CA;
        Thu, 28 Oct 2021 14:00:36 +0000 (UTC)
Date:   Thu, 28 Oct 2021 15:05:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Tiberiu Breana <tiberiu.a.breana@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: ltr501: Don't return error code in trigger
 handler
Message-ID: <20211028150503.507c7d34@jic23-huawei>
In-Reply-To: <20211024171251.22896-1-lars@metafoo.de>
References: <20211024171251.22896-1-lars@metafoo.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 24 Oct 2021 19:12:49 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> IIO trigger handlers need to return one of the irqreturn_t values.
> Returning an error code is not supported.
> 
> The ltr501 interrupt handler gets this right for most error paths, but
> there is one case where it returns the error code.
> 
> In addition for this particular case the trigger handler does not call
> `iio_trigger_notify_done()`. Which when not done keeps the triggered
> disabled forever.
> 
> Modify the code so that the function returns a valid irqreturn_t value as
> well as calling `iio_trigger_notify_done()` on all exit paths.
> 
> Fixes: 2690be905123 ("iio: Add Lite-On ltr501 ambient light / proximity sensor driver")
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Series applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> ---
>  drivers/iio/light/ltr501.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
> index 7e51aaac0bf8..b2983b1a9ed1 100644
> --- a/drivers/iio/light/ltr501.c
> +++ b/drivers/iio/light/ltr501.c
> @@ -1275,7 +1275,7 @@ static irqreturn_t ltr501_trigger_handler(int irq, void *p)
>  		ret = regmap_bulk_read(data->regmap, LTR501_ALS_DATA1,
>  				       als_buf, sizeof(als_buf));
>  		if (ret < 0)
> -			return ret;
> +			goto done;
>  		if (test_bit(0, indio_dev->active_scan_mask))
>  			scan.channels[j++] = le16_to_cpu(als_buf[1]);
>  		if (test_bit(1, indio_dev->active_scan_mask))

