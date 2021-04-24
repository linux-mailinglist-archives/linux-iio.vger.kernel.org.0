Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2321336A0B6
	for <lists+linux-iio@lfdr.de>; Sat, 24 Apr 2021 13:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbhDXLAz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Apr 2021 07:00:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:55506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231490AbhDXLAy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Apr 2021 07:00:54 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 138D1614A7;
        Sat, 24 Apr 2021 11:00:15 +0000 (UTC)
Date:   Sat, 24 Apr 2021 12:00:56 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno Sa <nuno.sa@analog.com>
Cc:     <linux-iio@vger.kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <ardeleanalex@gmail.com>
Subject: Re: [PATCH v2 2/9] iio: adis16400: do not return ints in irq
 handlers
Message-ID: <20210424120056.369998d7@jic23-huawei>
In-Reply-To: <20210422101911.135630-3-nuno.sa@analog.com>
References: <20210422101911.135630-1-nuno.sa@analog.com>
        <20210422101911.135630-3-nuno.sa@analog.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 22 Apr 2021 12:19:04 +0200
Nuno Sa <nuno.sa@analog.com> wrote:

> On an IRQ handler we should not return normal error codes as 'irqreturn_t'
> is expected.
> 
> Fixes: 5eda3550a3cc1 ("staging:iio:adis16400: Preallocate transfer message")
> Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
Same approach as for previous patch.

Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/adis16400.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/iio/imu/adis16400.c b/drivers/iio/imu/adis16400.c
> index 768aa493a1a6..b2f92b55b910 100644
> --- a/drivers/iio/imu/adis16400.c
> +++ b/drivers/iio/imu/adis16400.c
> @@ -645,9 +645,6 @@ static irqreturn_t adis16400_trigger_handler(int irq, void *p)
>  	void *buffer;
>  	int ret;
>  
> -	if (!adis->buffer)
> -		return -ENOMEM;
> -
>  	if (!(st->variant->flags & ADIS16400_NO_BURST) &&
>  		st->adis.spi->max_speed_hz > ADIS16400_SPI_BURST) {
>  		st->adis.spi->max_speed_hz = ADIS16400_SPI_BURST;

