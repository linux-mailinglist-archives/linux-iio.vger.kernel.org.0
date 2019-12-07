Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8723115BED
	for <lists+linux-iio@lfdr.de>; Sat,  7 Dec 2019 12:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfLGLCC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Dec 2019 06:02:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:42952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbfLGLCC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Dec 2019 06:02:02 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A44424673;
        Sat,  7 Dec 2019 11:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575716522;
        bh=XfWWb2zhJ7AuVZ9dOAp6k4DacxupN3foMgPCX9OIU7A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xli1/JIdLkD3V6DS654kyik3cYiEiC2hsSC7fTHIbGqLG0/YIwRkNAQbrh2Ww5Hls
         JbMFCnZRdr4+05d6S0BfJY493aTpcXGbXKY3eDPS+WdyUMQ0ohMPrNfM9o+LzYbo0f
         +OaMjDhNtsb7ZEbi0o8beVlh3I16MbgwvwB5wxsA=
Date:   Sat, 7 Dec 2019 11:01:57 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        justinpopo6@gmail.com, linus.walleij@linaro.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-ads7950: Fix a typo in an error message
Message-ID: <20191207110157.35dd39eb@archlinux>
In-Reply-To: <20191204064535.13025-1-christophe.jaillet@wanadoo.fr>
References: <20191204064535.13025-1-christophe.jaillet@wanadoo.fr>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed,  4 Dec 2019 07:45:35 +0100
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> Fix a typo:
>    s/get get/to get/
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Applied,

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ti-ads7950.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
> index 2e66e4d586ff..f9edc1207f75 100644
> --- a/drivers/iio/adc/ti-ads7950.c
> +++ b/drivers/iio/adc/ti-ads7950.c
> @@ -602,7 +602,7 @@ static int ti_ads7950_probe(struct spi_device *spi)
>  
>  	st->reg = devm_regulator_get(&spi->dev, "vref");
>  	if (IS_ERR(st->reg)) {
> -		dev_err(&spi->dev, "Failed get get regulator \"vref\"\n");
> +		dev_err(&spi->dev, "Failed to get regulator \"vref\"\n");
>  		ret = PTR_ERR(st->reg);
>  		goto error_destroy_mutex;
>  	}

