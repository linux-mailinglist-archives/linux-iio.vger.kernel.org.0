Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 815BE2A1EEA
	for <lists+linux-iio@lfdr.de>; Sun,  1 Nov 2020 16:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgKAPNZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Nov 2020 10:13:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:45168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbgKAPNZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Nov 2020 10:13:25 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1EBE2223F;
        Sun,  1 Nov 2020 15:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604243604;
        bh=1WOrV1jjtHcG7addgh8YJpo8rrwOUU24MJKpjdERXRE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ec+X8YBt7oP1F3vLOxylHK9Ei/R7rhJqbRKWffexjKA4K0qzs03KxfUKe4UVaRlef
         mSgIzJDEYz/zpcLh7fDzUl21l8n2OlHH00lNG1VGW/ynJeXu6hIdF18OHEA3AISzv4
         1fcdhrX8RXoLyROvANs1aksll0pv4qc89vhlFImY=
Date:   Sun, 1 Nov 2020 15:13:18 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        matthias.bgg@gmail.com, chun-hung.wu@mediatek.com,
        alexandru.ardelean@analog.com, pmeerw@pmeerw.net, lars@metafoo.de
Subject: Re: [PATCH v3] iio: adc: mediatek: fix unset field
Message-ID: <20201101151318.052a9d19@archlinux>
In-Reply-To: <20201018194644.3366846-1-fparent@baylibre.com>
References: <20201018194644.3366846-1-fparent@baylibre.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 18 Oct 2020 21:46:44 +0200
Fabien Parent <fparent@baylibre.com> wrote:

> dev_comp field is used in a couple of places but it is never set. This
> results in kernel oops when dereferencing a NULL pointer. Set the
> `dev_comp` field correctly in the probe function.
> 
> Fixes: 6d97024dce23 ("iio: adc: mediatek: mt6577-auxadc, add mt6765 support")
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan
> ---
> 
> Changelog:
> V2:
> 	* s/of_device_get_match_data/device_get_match_data
> 	* include mod_devicetable.h and property.h instead of of_*.h headers
> V3:
> 	* Remove extra space between Fixes tag and Signed-off-by tag
> 	* Add missing Reviewed-by tag from Matthias Brugger
> 
>  drivers/iio/adc/mt6577_auxadc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/mt6577_auxadc.c b/drivers/iio/adc/mt6577_auxadc.c
> index ac415cb089cd..79c1dd68b909 100644
> --- a/drivers/iio/adc/mt6577_auxadc.c
> +++ b/drivers/iio/adc/mt6577_auxadc.c
> @@ -9,9 +9,9 @@
>  #include <linux/err.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/of.h>
> -#include <linux/of_device.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
>  #include <linux/iopoll.h>
>  #include <linux/io.h>
>  #include <linux/iio/iio.h>
> @@ -276,6 +276,8 @@ static int mt6577_auxadc_probe(struct platform_device *pdev)
>  		goto err_disable_clk;
>  	}
>  
> +	adc_dev->dev_comp = device_get_match_data(&pdev->dev);
> +
>  	mutex_init(&adc_dev->lock);
>  
>  	mt6577_auxadc_mod_reg(adc_dev->reg_base + MT6577_AUXADC_MISC,

