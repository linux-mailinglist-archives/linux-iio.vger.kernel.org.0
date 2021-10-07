Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE7CE42598C
	for <lists+linux-iio@lfdr.de>; Thu,  7 Oct 2021 19:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242959AbhJGRec (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 7 Oct 2021 13:34:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:55290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242845AbhJGRea (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 7 Oct 2021 13:34:30 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28AF661002;
        Thu,  7 Oct 2021 17:32:33 +0000 (UTC)
Date:   Thu, 7 Oct 2021 18:36:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Kevin Tsai <ktsai@capellamicro.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] iio: light: cm36651: Make use of the helper
 function dev_err_probe()
Message-ID: <20211007183637.0b9f364c@jic23-huawei>
In-Reply-To: <20210928014156.1491-2-caihuoqing@baidu.com>
References: <20210928014156.1491-1-caihuoqing@baidu.com>
        <20210928014156.1491-2-caihuoqing@baidu.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 28 Sep 2021 09:41:53 +0800
Cai Huoqing <caihuoqing@baidu.com> wrote:

> When possible use dev_err_probe help to properly deal with the
> PROBE_DEFER error, the benefit is that DEFER issue will be logged
> in the devices_deferred debugfs file.
> Using dev_err_probe() can reduce code size, and the error value
> gets printed.
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
To cut down on repeat sends I'm going to cherry pick individual patches
out of this series. Please send updates for the those patches I don't pick
up where I've requested changes.

Applied this patch to the togreg branch of iio.git and pushed out as testing
for 0-day to test it.

Thanks,

Jonathan

> ---
> v1->v2: Remove the separate line of PTR_ERR().
> 
>  drivers/iio/light/cm36651.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/light/cm36651.c b/drivers/iio/light/cm36651.c
> index fd83a19929bc..c7cc4b0fe8b2 100644
> --- a/drivers/iio/light/cm36651.c
> +++ b/drivers/iio/light/cm36651.c
> @@ -632,10 +632,9 @@ static int cm36651_probe(struct i2c_client *client,
>  	cm36651 = iio_priv(indio_dev);
>  
>  	cm36651->vled_reg = devm_regulator_get(&client->dev, "vled");
> -	if (IS_ERR(cm36651->vled_reg)) {
> -		dev_err(&client->dev, "get regulator vled failed\n");
> -		return PTR_ERR(cm36651->vled_reg);
> -	}
> +	if (IS_ERR(cm36651->vled_reg))
> +		return dev_err_probe(&client->dev, PTR_ERR(cm36651->vled_reg),
> +				     "get regulator vled failed\n");
>  
>  	ret = regulator_enable(cm36651->vled_reg);
>  	if (ret) {

