Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F824196690
	for <lists+linux-iio@lfdr.de>; Sat, 28 Mar 2020 15:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgC1OMn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Mar 2020 10:12:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:48798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbgC1OMm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Mar 2020 10:12:42 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84903206E6;
        Sat, 28 Mar 2020 14:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585404762;
        bh=kVGBQaKgMMZXUFWVDRATMl1Gtsj+rhRRmBWPgiZEshI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UbGU3RXLmUiYw9AQzUcNtJq0IJh/mUm/BsAujZPR3W2E3LyLZg7soeLIj4II3kli0
         qFGacZGs+5oJEex7aaFbbyahN41+OKqtF3JvHMv4rteJvPcP1tQYmr8dTliEXzfWNi
         P8f3TDhY+fOihElRhuTdnfbWwkCbBUOYyk1CiGPk=
Date:   Sat, 28 Mar 2020 14:12:37 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nishant Malpani <nish.malpani25@gmail.com>
Cc:     andriy.shevchenko@linux.intel.com, joe@perches.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/13] iio: st_sensors_spi: Use vsprintf extension
 %pe for symbolic error name
Message-ID: <20200328141237.3c10cba7@archlinux>
In-Reply-To: <944c9c32f38a46e9c8589e5297866faa12b2d4ed.1584897364.git.nish.malpani25@gmail.com>
References: <cover.1584897364.git.nish.malpani25@gmail.com>
        <944c9c32f38a46e9c8589e5297866faa12b2d4ed.1584897364.git.nish.malpani25@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 22 Mar 2020 22:53:05 +0530
Nishant Malpani <nish.malpani25@gmail.com> wrote:

> Utilize %pe format specifier from vsprintf while printing error logs
> with dev_err(). Discards the use of unnecessary explicit casting and
> prints symbolic error name which might prove to be convenient during
> debugging.
> 
> Signed-off-by: Nishant Malpani <nish.malpani25@gmail.com>
Same comment as for the previous patch.

Thanks,

J
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
>  drivers/iio/common/st_sensors/st_sensors_spi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/common/st_sensors/st_sensors_spi.c b/drivers/iio/common/st_sensors/st_sensors_spi.c
> index 1275fb0eda31..efa93928b498 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_spi.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_spi.c
> @@ -101,8 +101,8 @@ int st_sensors_spi_configure(struct iio_dev *indio_dev,
>  
>  	sdata->regmap = devm_regmap_init_spi(spi, config);
>  	if (IS_ERR(sdata->regmap)) {
> -		dev_err(&spi->dev, "Failed to register spi regmap (%d)\n",
> -			(int)PTR_ERR(sdata->regmap));
> +		dev_err(&spi->dev, "Failed to register spi regmap: %pe\n",
> +			sdata->regmap);
>  		return PTR_ERR(sdata->regmap);
>  	}
>  

