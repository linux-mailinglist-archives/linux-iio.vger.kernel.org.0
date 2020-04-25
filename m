Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD8EC1B87B6
	for <lists+linux-iio@lfdr.de>; Sat, 25 Apr 2020 18:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgDYQb0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Apr 2020 12:31:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:54290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbgDYQb0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Apr 2020 12:31:26 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D607C20644;
        Sat, 25 Apr 2020 16:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587832285;
        bh=QdZ4lkq2YTUstUt+fB81CancoOuBMTAizh96xUzjiAQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Q46JTUaEoIxGR2exGKM9vChWwqAe3zabJKcdFb0YUyGqLa/yrvNNGt0dlgD89FYGh
         VcOTL7bTAk8ggktsXHPd6Ew0WvbLMnAlyFNhSDMQxBvYqsELEkHpq9wACZAw2fnLl6
         ySvacR6fPqWOCl/C4RSMg0QV4ph6F2rxEaQs6jwo=
Date:   Sat, 25 Apr 2020 17:31:22 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v1 06/16] iio: dac: ad5446: Use put_unaligned_be24()
Message-ID: <20200425173122.59cb5ddf@archlinux>
In-Reply-To: <20200421003135.23060-6-andriy.shevchenko@linux.intel.com>
References: <20200421003135.23060-1-andriy.shevchenko@linux.intel.com>
        <20200421003135.23060-6-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 21 Apr 2020 03:31:25 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> This makes the driver code slightly easier to read.
> 
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

You've guessed it. Applied with missing header added.

Thanks, J
> ---
>  drivers/iio/dac/ad5446.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
> index 61c670f7fc5f..87ff863bdc10 100644
> --- a/drivers/iio/dac/ad5446.c
> +++ b/drivers/iio/dac/ad5446.c
> @@ -302,9 +302,7 @@ static int ad5660_write(struct ad5446_state *st, unsigned val)
>  	struct spi_device *spi = to_spi_device(st->dev);
>  	uint8_t data[3];
>  
> -	data[0] = (val >> 16) & 0xFF;
> -	data[1] = (val >> 8) & 0xFF;
> -	data[2] = val & 0xFF;
> +	put_unaligned_be24(val, &data[0]);
>  
>  	return spi_write(spi, data, sizeof(data));
>  }

