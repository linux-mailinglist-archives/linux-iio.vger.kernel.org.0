Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 005301B87B2
	for <lists+linux-iio@lfdr.de>; Sat, 25 Apr 2020 18:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgDYQ0f (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Apr 2020 12:26:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:51708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbgDYQ0f (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Apr 2020 12:26:35 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 419E620714;
        Sat, 25 Apr 2020 16:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587831995;
        bh=9WLvDBgE/YgX97bhT1BdzRcjY2RANJDmxOCINSLtASA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XYK47m28fUS0Lt7vE2FBGtwzh/0qCLoVYN0x/WGmC6qTht5T0d+EQSBQief1U2uob
         bmHPHHldq8ZJNquAnc3uGUP+yf9bp9AkBuDiY7foaeHB+Gt2Ch3HS2vbhAyneB54nm
         /XKWUHPT9re7zqXM67eNODYfEdyEAApSd/dzUTJk=
Date:   Sat, 25 Apr 2020 17:26:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v1 04/16] iio: dac: ltc2632: Use put_unaligned_be24()
Message-ID: <20200425172631.6781d044@archlinux>
In-Reply-To: <20200421003135.23060-4-andriy.shevchenko@linux.intel.com>
References: <20200421003135.23060-1-andriy.shevchenko@linux.intel.com>
        <20200421003135.23060-4-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 21 Apr 2020 03:31:23 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> This makes the driver code slightly easier to read.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied with same include fix.

Jonathan

> ---
>  drivers/iio/dac/ltc2632.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/dac/ltc2632.c b/drivers/iio/dac/ltc2632.c
> index 7adc91056aa1..5123776cb63e 100644
> --- a/drivers/iio/dac/ltc2632.c
> +++ b/drivers/iio/dac/ltc2632.c
> @@ -75,9 +75,7 @@ static int ltc2632_spi_write(struct spi_device *spi,
>  	 * 10-, 8-bit input code followed by 4, 6, or 8 don't care bits.
>  	 */
>  	data = (cmd << 20) | (addr << 16) | (val << shift);
> -	msg[0] = data >> 16;
> -	msg[1] = data >> 8;
> -	msg[2] = data;
> +	put_unaligned_be24(data, &msg[0]);
>  
>  	return spi_write(spi, msg, sizeof(msg));
>  }

