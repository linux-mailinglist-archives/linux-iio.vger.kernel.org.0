Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D431320BB5
	for <lists+linux-iio@lfdr.de>; Sun, 21 Feb 2021 17:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhBUQ17 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Feb 2021 11:27:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:54102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229933AbhBUQ16 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 Feb 2021 11:27:58 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5641964EF1;
        Sun, 21 Feb 2021 16:27:17 +0000 (UTC)
Date:   Sun, 21 Feb 2021 16:27:13 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 1/2] iio:health:afe4403: Fix naming of tx supply to
 match dt-bindings
Message-ID: <20210221162713.35634481@archlinux>
In-Reply-To: <20201128162334.382837-1-jic23@kernel.org>
References: <20201128162334.382837-1-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 28 Nov 2020 16:23:33 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> These have always been different and the name tx_sup-supply that
> would work for the driver is rather nonsensical so let us go with
> what was described in the dt-binding doc.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Fixes: eec96d1e2d318 ("iio: health: Add driver for the TI AFE4403 heart monitor")
Another old series that I could do with a sanity check / review on.

Thanks,

Jonathan

> ---
>  drivers/iio/health/afe4403.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/health/afe4403.c b/drivers/iio/health/afe4403.c
> index 38734e4ce360..94bbfc065bed 100644
> --- a/drivers/iio/health/afe4403.c
> +++ b/drivers/iio/health/afe4403.c
> @@ -486,7 +486,7 @@ static int afe4403_probe(struct spi_device *spi)
>  		}
>  	}
>  
> -	afe->regulator = devm_regulator_get(afe->dev, "tx_sup");
> +	afe->regulator = devm_regulator_get(afe->dev, "tx");
>  	if (IS_ERR(afe->regulator)) {
>  		dev_err(afe->dev, "Unable to get regulator\n");
>  		return PTR_ERR(afe->regulator);

