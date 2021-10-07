Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2A72425996
	for <lists+linux-iio@lfdr.de>; Thu,  7 Oct 2021 19:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243261AbhJGRgT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 7 Oct 2021 13:36:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:55790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242002AbhJGRgS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 7 Oct 2021 13:36:18 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 502DA60E09;
        Thu,  7 Oct 2021 17:34:23 +0000 (UTC)
Date:   Thu, 7 Oct 2021 18:38:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Kevin Tsai <ktsai@capellamicro.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] iio: light: noa1305: Make use of the helper
 function dev_err_probe()
Message-ID: <20211007183826.67c0fed4@jic23-huawei>
In-Reply-To: <20210928014156.1491-4-caihuoqing@baidu.com>
References: <20210928014156.1491-1-caihuoqing@baidu.com>
        <20210928014156.1491-4-caihuoqing@baidu.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 28 Sep 2021 09:41:55 +0800
Cai Huoqing <caihuoqing@baidu.com> wrote:

> When possible use dev_err_probe help to properly deal with the
> PROBE_DEFER error, the benefit is that DEFER issue will be logged
> in the devices_deferred debugfs file.
> Using dev_err_probe() can reduce code size, and the error value
> gets printed.
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
Applied this patch to the togreg branch of iio.git and pushed out as
testing for 0-day to try it out.

Note I didn't pick up 1 and 3 from this series and will expect to see
a v3 of those or reply to the relevant reviews.

Thanks,

Jonathan

> ---
> v1->v2: Remove the separate line of PTR_ERR().
> 
>  drivers/iio/light/noa1305.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/light/noa1305.c b/drivers/iio/light/noa1305.c
> index a308fbc2fc7b..71a322227429 100644
> --- a/drivers/iio/light/noa1305.c
> +++ b/drivers/iio/light/noa1305.c
> @@ -217,10 +217,9 @@ static int noa1305_probe(struct i2c_client *client,
>  	priv = iio_priv(indio_dev);
>  
>  	priv->vin_reg = devm_regulator_get(&client->dev, "vin");
> -	if (IS_ERR(priv->vin_reg)) {
> -		dev_err(&client->dev, "get regulator vin failed\n");
> -		return PTR_ERR(priv->vin_reg);
> -	}
> +	if (IS_ERR(priv->vin_reg))
> +		return dev_err_probe(&client->dev, PTR_ERR(priv->vin_reg),
> +				     "get regulator vin failed\n");
>  
>  	ret = regulator_enable(priv->vin_reg);
>  	if (ret) {

