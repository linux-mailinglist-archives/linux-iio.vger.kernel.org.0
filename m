Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA950421133
	for <lists+linux-iio@lfdr.de>; Mon,  4 Oct 2021 16:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233533AbhJDOTH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 4 Oct 2021 10:19:07 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:47641 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233460AbhJDOTH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Oct 2021 10:19:07 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 575D624000C;
        Mon,  4 Oct 2021 14:17:13 +0000 (UTC)
Date:   Mon, 4 Oct 2021 16:17:11 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: adc: max1027: fix error code in max1027_wait_eoc()
Message-ID: <20211004161711.26e6065e@xps13>
In-Reply-To: <20211004134454.GA11689@kili>
References: <20211004134454.GA11689@kili>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,

dan.carpenter@oracle.com wrote on Mon, 4 Oct 2021 16:44:54 +0300:

> Return -ETIMEDOUT on timeout instead of success.
> 
> Fixes: 54f14be01e17 ("iio: adc: max1027: Use the EOC IRQ when populated for single reads")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/iio/adc/max1027.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
> index 45dc8a625fa3..4daf1d576c4e 100644
> --- a/drivers/iio/adc/max1027.c
> +++ b/drivers/iio/adc/max1027.c
> @@ -286,7 +286,7 @@ static int max1027_wait_eoc(struct iio_dev *indio_dev)
>  						  msecs_to_jiffies(1000));
>  		reinit_completion(&st->complete);
>  		if (!ret)
> -			return ret;
> +			return -ETIMEDOUT;

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

>  	} else {
>  		if (indio_dev->active_scan_mask)
>  			conversion_time *= hweight32(*indio_dev->active_scan_mask);


Thanks,
Miquèl
