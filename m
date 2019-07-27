Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 131FF77BB7
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2019 22:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388210AbfG0UBE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Jul 2019 16:01:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:42992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388203AbfG0UBE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 27 Jul 2019 16:01:04 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A8622147A;
        Sat, 27 Jul 2019 20:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564257663;
        bh=DgDNlm7F27FXgbQd9yjqj5Ay218U2CBBs+IC8mU3nV8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tVxqXJoYgKqDdbrxcOzfaOLkxjpg/RhOPTZOxQxkuOyUcuOsWjLQa7FCg6xZSUbGt
         GbuGbfPFgkvB+bTCzhPyCDjzhWCB7PZ3X2TUedpRd1jYl2XsgyHj/wc3kRINwvS9Xo
         q/uEFENRUv2HraKQcqKcBLj0cZP6fNBrxCm48jR4=
Date:   Sat, 27 Jul 2019 21:00:56 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        tglx@linutronix.de, alexios.zavras@intel.com,
        gregkh@linuxfoundation.org, kstewart@linuxfoundation.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: magnetometer: mmc35240: Fix a typo in the name of
 a constant
Message-ID: <20190727210056.63e7e9d2@archlinux>
In-Reply-To: <20190721213533.9214-1-christophe.jaillet@wanadoo.fr>
References: <20190721213533.9214-1-christophe.jaillet@wanadoo.fr>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 21 Jul 2019 23:35:33 +0200
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> Everything is about mmc35240_ except MMC53240_WAIT_SET_RESET (3 and 5
> switched).
> 
> This is likely a typo. Define and use MMC35240_WAIT_SET_RESET instead.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to see what we missed.

Thanks,

Jonathan

> ---
>  drivers/iio/magnetometer/mmc35240.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/mmc35240.c b/drivers/iio/magnetometer/mmc35240.c
> index 7de10281ad9e..425cdd07b4e5 100644
> --- a/drivers/iio/magnetometer/mmc35240.c
> +++ b/drivers/iio/magnetometer/mmc35240.c
> @@ -53,7 +53,7 @@
>  #define MMC35240_CTRL1_BW_SHIFT		0
>  
>  #define MMC35240_WAIT_CHARGE_PUMP	50000	/* us */
> -#define MMC53240_WAIT_SET_RESET		1000	/* us */
> +#define MMC35240_WAIT_SET_RESET		1000	/* us */
>  
>  /*
>   * Memsic OTP process code piece is put here for reference:
> @@ -225,7 +225,7 @@ static int mmc35240_init(struct mmc35240_data *data)
>  	ret = mmc35240_hw_set(data, true);
>  	if (ret < 0)
>  		return ret;
> -	usleep_range(MMC53240_WAIT_SET_RESET, MMC53240_WAIT_SET_RESET + 1);
> +	usleep_range(MMC35240_WAIT_SET_RESET, MMC35240_WAIT_SET_RESET + 1);
>  
>  	ret = mmc35240_hw_set(data, false);
>  	if (ret < 0)

