Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7749185C68
	for <lists+linux-iio@lfdr.de>; Sun, 15 Mar 2020 13:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbgCOMkW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Mar 2020 08:40:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:38424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728467AbgCOMkV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Mar 2020 08:40:21 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CE3B20674;
        Sun, 15 Mar 2020 12:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584276021;
        bh=22d1gmGr6RPHbg1B1zL63VVmjMqOXL7v9outywE+lfo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OezuvYa4n6v+QBtGw3R9It7xW4pX4ngHh+eU+PACQu9aa8SQvUdsQYjDxErMHUpkA
         Y/ZOITcH2hL+bchRCaNcJ4lRmd95tYWs1gN+MYfFsHq9qH/NueBNdvD3a47P1fsGOx
         Qf0/y3ZmdaPkKnbT+cC1b/LX22afOdWiGo1y7eic=
Date:   Sun, 15 Mar 2020 12:40:17 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Denis Ciocca <denis.ciocca@st.com>
Subject: Re: [PATCH v2 4/8] iio: st_sensors: Drop unneeded casting when
 print error code
Message-ID: <20200315124017.074ec820@archlinux>
In-Reply-To: <20200313104955.30423-4-andriy.shevchenko@linux.intel.com>
References: <20200313104955.30423-1-andriy.shevchenko@linux.intel.com>
        <20200313104955.30423-4-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 13 Mar 2020 12:49:51 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Explicit casting in printf() usually shows that something is not okay.
> Here, we really don't need it by providing correct specifier.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
applied, thanks.

Jonathan

> ---
> v2: no change
>  drivers/iio/common/st_sensors/st_sensors_i2c.c | 4 ++--
>  drivers/iio/common/st_sensors/st_sensors_spi.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/common/st_sensors/st_sensors_i2c.c b/drivers/iio/common/st_sensors/st_sensors_i2c.c
> index 286830fb5d35..b400560bac93 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_i2c.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_i2c.c
> @@ -49,8 +49,8 @@ int st_sensors_i2c_configure(struct iio_dev *indio_dev,
>  
>  	sdata->regmap = devm_regmap_init_i2c(client, config);
>  	if (IS_ERR(sdata->regmap)) {
> -		dev_err(&client->dev, "Failed to register i2c regmap (%d)\n",
> -			(int)PTR_ERR(sdata->regmap));
> +		dev_err(&client->dev, "Failed to register i2c regmap (%ld)\n",
> +			PTR_ERR(sdata->regmap));
>  		return PTR_ERR(sdata->regmap);
>  	}
>  
> diff --git a/drivers/iio/common/st_sensors/st_sensors_spi.c b/drivers/iio/common/st_sensors/st_sensors_spi.c
> index dcbdef4a77f8..ee70515bb89f 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_spi.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_spi.c
> @@ -101,8 +101,8 @@ int st_sensors_spi_configure(struct iio_dev *indio_dev,
>  
>  	sdata->regmap = devm_regmap_init_spi(spi, config);
>  	if (IS_ERR(sdata->regmap)) {
> -		dev_err(&spi->dev, "Failed to register spi regmap (%d)\n",
> -			(int)PTR_ERR(sdata->regmap));
> +		dev_err(&spi->dev, "Failed to register spi regmap (%ld)\n",
> +			PTR_ERR(sdata->regmap));
>  		return PTR_ERR(sdata->regmap);
>  	}
>  

