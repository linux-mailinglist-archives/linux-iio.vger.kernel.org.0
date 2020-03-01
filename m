Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F32B5174E13
	for <lists+linux-iio@lfdr.de>; Sun,  1 Mar 2020 16:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgCAPu5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Mar 2020 10:50:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:35524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbgCAPu4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Mar 2020 10:50:56 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3619A20658;
        Sun,  1 Mar 2020 15:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583077856;
        bh=uOj+fapkd+GLFBLFWS2JlD5R+ivG/dADjtKhRNHcazM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zH8J0WHLWIG0gPyCpElZZ35ZbQFmC/868sNZJ1uRrkTOyDW/V18ImzDaQRtLXO3jM
         R7vTAjBcZo8sz78pUYrHU6/Ck3O8T7KQmcwFqJyyYRz/xrA+WozObuT2k2HtOjWhrX
         9fvLZCYIIpiHqGupFmovZadZCP2V6+HovKHYCdIA=
Date:   Sun, 1 Mar 2020 15:50:48 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <info@metux.net>, <lukas@wunner.de>,
        <tglx@linutronix.de>
Subject: Re: [PATCH] iio: adc: mcp320x: Use new structure for SPI transfer
 delays
Message-ID: <20200301155048.76223dfc@archlinux>
In-Reply-To: <20200227122940.18243-1-sergiu.cuciurean@analog.com>
References: <20200227122940.18243-1-sergiu.cuciurean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 27 Feb 2020 14:29:40 +0200
Sergiu Cuciurean <sergiu.cuciurean@analog.com> wrote:

> In a recent change to the SPI subsystem [1], a new `delay` struct was added
> to replace the `delay_usecs`. This change replaces the current
> `delay_usecs` with `delay` for this driver.
> 
> The `spi_transfer_delay_exec()` function [in the SPI framework] makes sure
> that both `delay_usecs` & `delay` are used (in this order to preserve
> backwards compatibility).
> 
> [1] commit bebcfd272df6 ("spi: introduce `delay` field for
> `spi_transfer` + spi_transfer_delay_exec()")
> 
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to poke at it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/mcp320x.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
> index 465c7625a55a..2c0eb5de110c 100644
> --- a/drivers/iio/adc/mcp320x.c
> +++ b/drivers/iio/adc/mcp320x.c
> @@ -421,7 +421,8 @@ static int mcp320x_probe(struct spi_device *spi)
>  			adc->transfer[1].len++;
>  
>  		/* conversions are started by asserting CS pin for 8 usec */
> -		adc->start_conv_transfer.delay_usecs = 8;
> +		adc->start_conv_transfer.delay.value = 8;
> +		adc->start_conv_transfer.delay.unit = SPI_DELAY_UNIT_USECS;
>  		spi_message_init_with_transfers(&adc->start_conv_msg,
>  						&adc->start_conv_transfer, 1);
>  

