Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3F15ED2EA
	for <lists+linux-iio@lfdr.de>; Sun,  3 Nov 2019 11:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfKCKgx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 Nov 2019 05:36:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:54508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727380AbfKCKgx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Nov 2019 05:36:53 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFD9B20659;
        Sun,  3 Nov 2019 10:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572777413;
        bh=A2UEXhQXk6k5y00/m2PDbrDweQn/S+r13llMRFl/GEs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EPrIqWfRzkiBB+lYcbwWKFCS+xAtWiQ0THdzl5ecRwICJqB1Lai+6zdkQv78qmWue
         WzGTowNESfyde4oCmH6KhnpkQtTfLqjC0jfHv7lTOB/DEQ4T3+AQhtH5THFEmE6KRE
         GF75UAjI75abNRJYKGTwjcgWcPo7X1MPrSNqwN0g=
Date:   Sun, 3 Nov 2019 10:36:48 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dragos.bogdan@analog.com>
Subject: Re: [PATCH 07/10] iio: imu: adis16480: prefer `unsigned int` over
 `unsigned`
Message-ID: <20191103103648.0d99a4fb@archlinux>
In-Reply-To: <20191101093505.9408-8-alexandru.ardelean@analog.com>
References: <20191101093505.9408-1-alexandru.ardelean@analog.com>
        <20191101093505.9408-8-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 1 Nov 2019 11:35:02 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> This is a typical checkpatch warning. The change just renames the type of
> the `freq` var to `unsigned int`.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied.  Thanks,

Jonathan

> ---
>  drivers/iio/imu/adis16480.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
> index d199d3d3c4bd..b9e2695bcfad 100644
> --- a/drivers/iio/imu/adis16480.c
> +++ b/drivers/iio/imu/adis16480.c
> @@ -350,7 +350,7 @@ static int adis16480_get_freq(struct iio_dev *indio_dev, int *val, int *val2)
>  	struct adis16480 *st = iio_priv(indio_dev);
>  	uint16_t t;
>  	int ret;
> -	unsigned freq;
> +	unsigned int freq;
>  	unsigned int reg;
>  
>  	if (st->clk_mode == ADIS16480_CLK_PPS)

