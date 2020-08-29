Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10954256906
	for <lists+linux-iio@lfdr.de>; Sat, 29 Aug 2020 18:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbgH2Q0A (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Aug 2020 12:26:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:35848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728422AbgH2QZ6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 29 Aug 2020 12:25:58 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8215D20757;
        Sat, 29 Aug 2020 16:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598718358;
        bh=VUtBauJ47pgm9pXDykb9ZdpG6WyVP6v53G/qCbGvngI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ANW8LLjznPypRpmgaiyh3pRUtPqoMv4JPmFrOnogCTlMGZcGAihyUuoI8kMK3ARDf
         U7IwDSOOy0rJUXnZ9cgPvEZio8yGGm1cI7x+1tp5qrle2q1XEAifRcip4F+n+XYpoS
         sluhyM8j3C83YPt4uxRcM+HUIlZvbfxBdURKIfcw=
Date:   Sat, 29 Aug 2020 17:25:54 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nishant Malpani <nish.malpani25@gmail.com>
Cc:     dragos.bogdan@analog.com, darius.berghe@analog.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/1] iio: gyro: adxrs290: Insert missing mutex
 initialization call
Message-ID: <20200829172554.288e314d@archlinux>
In-Reply-To: <20200825124552.11155-1-nish.malpani25@gmail.com>
References: <20200825124552.11155-1-nish.malpani25@gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 25 Aug 2020 18:15:52 +0530
Nishant Malpani <nish.malpani25@gmail.com> wrote:

> Insert a missing mutex_init() call during the probe that initializes
> the driver's local lock to unlocked state.
> 
> Fixes: 2c8920fff145 ("iio: gyro: Add driver support for ADXRS290")
> Signed-off-by: Nishant Malpani <nish.malpani25@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it

Thanks,

Jonathan

> ---
>  drivers/iio/gyro/adxrs290.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/gyro/adxrs290.c b/drivers/iio/gyro/adxrs290.c
> index 38bab4e3eee9..ff989536d2fb 100644
> --- a/drivers/iio/gyro/adxrs290.c
> +++ b/drivers/iio/gyro/adxrs290.c
> @@ -385,6 +385,8 @@ static int adxrs290_probe(struct spi_device *spi)
>  	indio_dev->num_channels = ARRAY_SIZE(adxrs290_channels);
>  	indio_dev->info = &adxrs290_info;
>  
> +	mutex_init(&st->lock);
> +
>  	val = spi_w8r8(spi, ADXRS290_READ_REG(ADXRS290_REG_ADI_ID));
>  	if (val != ADXRS290_ADI_ID) {
>  		dev_err(&spi->dev, "Wrong ADI ID 0x%02x\n", val);

