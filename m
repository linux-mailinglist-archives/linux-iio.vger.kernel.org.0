Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B53A81966A8
	for <lists+linux-iio@lfdr.de>; Sat, 28 Mar 2020 15:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgC1OUu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Mar 2020 10:20:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:52864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726378AbgC1OUu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Mar 2020 10:20:50 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C363020578;
        Sat, 28 Mar 2020 14:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585405250;
        bh=g1NR3gwhSKnc6eZy/94lJOcdR9sRfUGkaU4+IhRhi/k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DaJs9sFMHj4FF625s52AeuxiAw48Yp0PtJUB8KMR5ui0/98Vp/GSJRR260/ICFyIn
         +dRfMqMA1NTjwdlB7fMcupCeD7p8w05atjoPNXr4I1vPaIwiwQfA/lPQgi5gFU1m08
         gxpGh37Ui6+z9kRydb6ZSImz5o07wGjwzoxMDIrk=
Date:   Sat, 28 Mar 2020 14:20:45 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nishant Malpani <nish.malpani25@gmail.com>
Cc:     andriy.shevchenko@linux.intel.com, joe@perches.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/13] iio: imu: bmi160_spi: Use vsprintf extension
 %pe for symbolic error name
Message-ID: <20200328142045.69c68f18@archlinux>
In-Reply-To: <df440b36aee29cc14c21a3153983c7dfaaf7172a.1584897364.git.nish.malpani25@gmail.com>
References: <cover.1584897364.git.nish.malpani25@gmail.com>
        <df440b36aee29cc14c21a3153983c7dfaaf7172a.1584897364.git.nish.malpani25@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 22 Mar 2020 22:53:10 +0530
Nishant Malpani <nish.malpani25@gmail.com> wrote:

> Utilize %pe format specifier from vsprintf while printing error logs
> with dev_err(). Discards the use of unnecessary explicit casting and
> prints symbolic error name which might prove to be convenient during
> debugging.
> 
> Signed-off-by: Nishant Malpani <nish.malpani25@gmail.com>
Applied,

Thanks,

Jonathan
> ---
> 
> Changes in v2:
>   - Rewrite commit subject line outlining the usage of %pe.
>   - Add a separator between regmap and its error name.
> 
> Based on conversations in [1] & [2].
> 
> [1] https://marc.info/?l=linux-iio&m=158427554607223&w=2
> [2] https://marc.info/?l=linux-iio&m=158481647605891&w=2
> ---
>  drivers/iio/imu/bmi160/bmi160_spi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/bmi160/bmi160_spi.c b/drivers/iio/imu/bmi160/bmi160_spi.c
> index c19e3df35559..61389b41c6d9 100644
> --- a/drivers/iio/imu/bmi160/bmi160_spi.c
> +++ b/drivers/iio/imu/bmi160/bmi160_spi.c
> @@ -20,8 +20,8 @@ static int bmi160_spi_probe(struct spi_device *spi)
>  
>  	regmap = devm_regmap_init_spi(spi, &bmi160_regmap_config);
>  	if (IS_ERR(regmap)) {
> -		dev_err(&spi->dev, "Failed to register spi regmap %d\n",
> -			(int)PTR_ERR(regmap));
> +		dev_err(&spi->dev, "Failed to register spi regmap: %pe\n",
> +			regmap);
>  		return PTR_ERR(regmap);
>  	}
>  	return bmi160_core_probe(&spi->dev, regmap, id->name, true);

