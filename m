Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94AD441FCF5
	for <lists+linux-iio@lfdr.de>; Sat,  2 Oct 2021 18:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbhJBQJc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 2 Oct 2021 12:09:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:43064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233451AbhJBQJb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 2 Oct 2021 12:09:31 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6940B61A0A;
        Sat,  2 Oct 2021 16:07:43 +0000 (UTC)
Date:   Sat, 2 Oct 2021 17:11:40 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Billy Tsai <billy_tsai@aspeedtech.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] iio: adc: aspeed: Fix spelling mistake "battey"
 -> "battery"
Message-ID: <20211002171140.1af667ef@jic23-huawei>
In-Reply-To: <20211001120018.17570-1-colin.king@canonical.com>
References: <20211001120018.17570-1-colin.king@canonical.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri,  1 Oct 2021 13:00:18 +0100
Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a dev_warn message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Hi Colin,

Thanks and applied.

Jonathan

> ---
>  drivers/iio/adc/aspeed_adc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
> index 3e9850a43372..a957cad1bfab 100644
> --- a/drivers/iio/adc/aspeed_adc.c
> +++ b/drivers/iio/adc/aspeed_adc.c
> @@ -581,7 +581,7 @@ static int aspeed_adc_probe(struct platform_device *pdev)
>  			}
>  		} else
>  			dev_warn(&pdev->dev,
> -				 "Failed to enable battey-sensing mode\n");
> +				 "Failed to enable battery-sensing mode\n");
>  	}
>  
>  	ret = clk_prepare_enable(data->clk_scaler->clk);

