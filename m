Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78B15311EFB
	for <lists+linux-iio@lfdr.de>; Sat,  6 Feb 2021 18:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbhBFRBx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 Feb 2021 12:01:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:58496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229788AbhBFRBw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 6 Feb 2021 12:01:52 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C38A64E2C;
        Sat,  6 Feb 2021 17:01:10 +0000 (UTC)
Date:   Sat, 6 Feb 2021 17:01:07 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Wilfried Wessner <wilfried.wessner@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Charles-Antoine Couret <charles-antoine.couret@essensium.com>
Subject: Re: [PATCH v2] iio: ad7949: fix wrong ADC result due to incorrect
 bit mask
Message-ID: <20210206170107.7db71f53@archlinux>
In-Reply-To: <20210206145258.GA603024@ubuntu>
References: <20210206145258.GA603024@ubuntu>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 6 Feb 2021 15:52:58 +0100
Wilfried Wessner <wilfried.wessner@gmail.com> wrote:

> Fixes a wrong bit mask used for the ADC's result, which was caused by an
> improper usage of the GENMASK() macro. The bits higher than ADC's 
> resolution are undefined and if not masked out correctly, a wrong result 
> can be given. The GENMASK() macro indexing is zero based, so the mask has 
> to go from [resolution - 1 , 0].

Hi Wilfried,

Welcome to IIO and kernel in general!

It's useful to add to the description if the error was found by inspection / script
or by observing an actual error on hardware?

Also, needs a fixes tag so we can work out what kernels to back port it to.

+CC Charle-Antoine Couret as the original driver author.

Thanks,

Jonathan

> 
> Signed-off-by: Wilfried Wessner <wilfried.wessner@gmail.com>
> 
> ---
>  drivers/iio/adc/ad7949.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
> index 5d597e5050f6..1b4b3203e428 100644
> --- a/drivers/iio/adc/ad7949.c
> +++ b/drivers/iio/adc/ad7949.c
> @@ -91,7 +91,7 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
>  	int ret;
>  	int i;
>  	int bits_per_word = ad7949_adc->resolution;
> -	int mask = GENMASK(ad7949_adc->resolution, 0);
> +	int mask = GENMASK(ad7949_adc->resolution - 1, 0);
>  	struct spi_message msg;
>  	struct spi_transfer tx[] = {
>  		{

