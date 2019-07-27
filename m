Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD96577BF8
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2019 23:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388155AbfG0VQR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Jul 2019 17:16:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:57126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388154AbfG0VQQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 27 Jul 2019 17:16:16 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE100208C0;
        Sat, 27 Jul 2019 21:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564262175;
        bh=/428fxbXHob5HflmGsQkLcv8LLRkG6/CSeEZJP/f1Y8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UROYT3c5wvBGkiMGPGOUovy4t3HoiJRl7qmibLAwGO//PPxP8p80xCSTMUsTlJkhl
         Yc6N5mYlIu07JyJn6ijC+6kwPdSnLyxnNIYwz5eiZ9xm8+MiIA2fGVEWv+kQqyJCbW
         R9b+57t5rsazll+oqGLtgfG3ZROujg3nOxbiSOac=
Date:   Sat, 27 Jul 2019 22:16:11 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio@vger.kernel.org, lorenzo.bianconi83@gmail.com,
        martin@geanix.com
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: flip irq return logic
Message-ID: <20190727221611.46802ce5@archlinux>
In-Reply-To: <20190715070715.75976-1-sean@geanix.com>
References: <20190715070715.75976-1-sean@geanix.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 15 Jul 2019 09:07:15 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> No need for using reverse logic in the irq return,
> fix this by flip things around.
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>

This is indeed rather strange! Code evolution I guess ;)

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> index 38194f4d2b7e..1be1cec2ab23 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> @@ -670,7 +670,7 @@ static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)
>  	count = hw->settings->fifo_ops.read_fifo(hw);
>  	mutex_unlock(&hw->fifo_lock);
>  
> -	return !count ? IRQ_NONE : IRQ_HANDLED;
> +	return count ? IRQ_HANDLED : IRQ_NONE;
>  }
>  
>  static int st_lsm6dsx_buffer_preenable(struct iio_dev *iio_dev)

