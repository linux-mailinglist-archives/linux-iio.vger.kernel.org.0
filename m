Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E4235B5CF
	for <lists+linux-iio@lfdr.de>; Sun, 11 Apr 2021 17:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235920AbhDKPHR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Apr 2021 11:07:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:51582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235503AbhDKPHQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Apr 2021 11:07:16 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 190C4610C7;
        Sun, 11 Apr 2021 15:06:57 +0000 (UTC)
Date:   Sun, 11 Apr 2021 16:07:20 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     kjlu@umn.edu, Linus Walleij <linus.walleij@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: gp2ap002: Fix rumtime PM imbalance on error
Message-ID: <20210411160720.037c405c@jic23-huawei>
In-Reply-To: <20210407034927.16882-1-dinghao.liu@zju.edu.cn>
References: <20210407034927.16882-1-dinghao.liu@zju.edu.cn>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed,  7 Apr 2021 11:49:27 +0800
Dinghao Liu <dinghao.liu@zju.edu.cn> wrote:

> When devm_request_threaded_irq() fails, we should decrease the
> runtime PM counter to keep the counter balanced. But when
> iio_device_register() fails, we need not to decrease it because
> we have already decreased it before.

Whilst agree with your assessment that the code is wrong, I'm not
totally sure why we need to do the pm_runtime_get_noresume() in
the first place.   Why do we need to hold the reference for
the operations going on here?  What can race against this that
might care about that reference count?

Jonathan


> 
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>  drivers/iio/light/gp2ap002.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/light/gp2ap002.c b/drivers/iio/light/gp2ap002.c
> index 7ba7aa59437c..040d8429a6e0 100644
> --- a/drivers/iio/light/gp2ap002.c
> +++ b/drivers/iio/light/gp2ap002.c
> @@ -583,7 +583,7 @@ static int gp2ap002_probe(struct i2c_client *client,
>  					"gp2ap002", indio_dev);
>  	if (ret) {
>  		dev_err(dev, "unable to request IRQ\n");
> -		goto out_disable_vio;
> +		goto out_put_pm;
>  	}
>  	gp2ap002->irq = client->irq;
>  
> @@ -613,8 +613,9 @@ static int gp2ap002_probe(struct i2c_client *client,
>  
>  	return 0;
>  
> -out_disable_pm:
> +out_put_pm:
>  	pm_runtime_put_noidle(dev);
> +out_disable_pm:
>  	pm_runtime_disable(dev);
>  out_disable_vio:
>  	regulator_disable(gp2ap002->vio);

