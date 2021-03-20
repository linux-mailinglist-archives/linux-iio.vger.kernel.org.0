Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B693342D8F
	for <lists+linux-iio@lfdr.de>; Sat, 20 Mar 2021 16:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhCTPID (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 20 Mar 2021 11:08:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:36130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229570AbhCTPHg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 20 Mar 2021 11:07:36 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7267861936;
        Sat, 20 Mar 2021 15:07:34 +0000 (UTC)
Date:   Sat, 20 Mar 2021 15:07:30 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Guoqing chi <chi962464zy@163.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        lars@metafoo.de, Michael.Hennerich@analog.com,
        marcelo.schmitt1@gmail.com, pmeerw@pmeerw.net,
        chiguoqing@yulong.com
Subject: Re: [PATCH] iio: adc: ad7292: Modify the bool initialization
 assignment
Message-ID: <20210320150730.67635739@jic23-huawei>
In-Reply-To: <20210319062706.5135-1-chi962464zy@163.com>
References: <20210319062706.5135-1-chi962464zy@163.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 19 Mar 2021 14:27:06 +0800
Guoqing chi <chi962464zy@163.com> wrote:

> From: Guoqing Chi <chiguoqing@yulong.com>
> 
> A bool initializer is best assigned to false rather than 0.
> 
> Signed-off-by: Guoqing Chi <chiguoqing@yulong.com>

Hi

This one is a bit marginal as counting as noise rather that a useful
change in an existing driver. I'll take it this time, but I'm not
keen to see lots of these unless they form part of larger sets cleaning
up the drivers in question.

Applied to the togreg branch of iio.git and pushed out as testing for
the auto builders to ignore it.

thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7292.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad7292.c b/drivers/iio/adc/ad7292.c
> index 70e33dd1c9f7..3271a31afde1 100644
> --- a/drivers/iio/adc/ad7292.c
> +++ b/drivers/iio/adc/ad7292.c
> @@ -260,7 +260,7 @@ static int ad7292_probe(struct spi_device *spi)
>  	struct ad7292_state *st;
>  	struct iio_dev *indio_dev;
>  	struct device_node *child;
> -	bool diff_channels = 0;
> +	bool diff_channels = false;
>  	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));

