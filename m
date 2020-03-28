Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAE41966BC
	for <lists+linux-iio@lfdr.de>; Sat, 28 Mar 2020 15:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgC1O0X (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Mar 2020 10:26:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:53718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726325AbgC1O0X (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Mar 2020 10:26:23 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6119206F6;
        Sat, 28 Mar 2020 14:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585405582;
        bh=4x4rXvtnC0B2Hl2G8lyRv7k0jB+8get01hPUdCAkHKk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gnyvH9YRef4E2bgvtoJjLHGCTTuXGfPGib0+f0GEaumolySRmZ5yKZP73qRSNef/z
         HU1H5kGqWhhhukL3dRecgLCq8PA98BAEtAmtKPV3zHc9t907NNtbt8WgsFkgbjYZ/4
         notdNfHnvaQs9j0d169c7V49wQmFEl06ms/x03a8=
Date:   Sat, 28 Mar 2020 14:26:17 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nishant Malpani <nish.malpani25@gmail.com>
Cc:     andriy.shevchenko@linux.intel.com, joe@perches.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 13/13] iio: magn: bmc150: Use vsprintf extension %pe
 for symbolic error name
Message-ID: <20200328142617.50524604@archlinux>
In-Reply-To: <aea18dc7c140eacaaba24b82ee7809196047c1e7.1584897364.git.nish.malpani25@gmail.com>
References: <cover.1584897364.git.nish.malpani25@gmail.com>
        <aea18dc7c140eacaaba24b82ee7809196047c1e7.1584897364.git.nish.malpani25@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 22 Mar 2020 22:53:15 +0530
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
>  drivers/iio/magnetometer/bmc150_magn_spi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/bmc150_magn_spi.c b/drivers/iio/magnetometer/bmc150_magn_spi.c
> index ed9be0490d77..c6ed3ea8460a 100644
> --- a/drivers/iio/magnetometer/bmc150_magn_spi.c
> +++ b/drivers/iio/magnetometer/bmc150_magn_spi.c
> @@ -22,8 +22,8 @@ static int bmc150_magn_spi_probe(struct spi_device *spi)
>  
>  	regmap = devm_regmap_init_spi(spi, &bmc150_magn_regmap_config);
>  	if (IS_ERR(regmap)) {
> -		dev_err(&spi->dev, "Failed to register spi regmap %d\n",
> -			(int)PTR_ERR(regmap));
> +		dev_err(&spi->dev, "Failed to register spi regmap: %pe\n",
> +			regmap);
>  		return PTR_ERR(regmap);
>  	}
>  	return bmc150_magn_probe(&spi->dev, regmap, spi->irq, id->name);

