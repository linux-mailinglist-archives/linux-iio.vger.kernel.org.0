Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E27B1C2BD9
	for <lists+linux-iio@lfdr.de>; Sun,  3 May 2020 13:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgECLh6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 May 2020 07:37:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:37484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727792AbgECLh6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 May 2020 07:37:58 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD391205ED;
        Sun,  3 May 2020 11:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588505877;
        bh=OGiegH7Y1FcxfJPta06unb8ZfPJOBLzHj+Vjm8Hkpx8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vp6Y4Ep0lWA1Y4PuaJnYLumR21o8vn0i6qN0yzg0KEGVHySvo6IDkZwOGTDWN+dzb
         +8wwpQfi1mPsQwurWMoEtqL27el0vr9YVFcGPfcXjPg1e6eyurKUaLE/KgQUxw2TaN
         h7r/sjEF0kXYBQd8+gwnwPvNcB4gadGeY37nP3FI=
Date:   Sun, 3 May 2020 12:37:53 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        Dragos Bogdan <dragos.bogdan@analog.com>
Subject: Re: [PATCH] staging: iio: ad2s1210: Fix SPI reading
Message-ID: <20200503123753.29ea8be0@archlinux>
In-Reply-To: <20200429072129.81504-1-alexandru.ardelean@analog.com>
References: <20200429072129.81504-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 29 Apr 2020 10:21:29 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> From: Dragos Bogdan <dragos.bogdan@analog.com>
> 
> If the serial interface is used, the 8-bit address should be latched using
> the rising edge of the WR/FSYNC signal.
> 
> This basically means that a CS change is required between the first byte
> sent, and the second one.
> This change splits the single-transfer transfer of 2 bytes into 2 transfers
> with a single byte, and CS change in-between.
> 
> Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Fixes tag would have been nice. I've had a go by picking a patch where I
refactored this code, but I think the issue probably predates that one.
Its in 2011 so I doubt anyone will try going past that with backports ;)

Applied to the fixes-togreg branch of iio.git and marked for stable.

I'm guessing this means you have hardware and hope to get this one out
of staging shortly? *crosses fingers* :)

Jonathan

> ---
>  drivers/staging/iio/resolver/ad2s1210.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
> index 4b25a3a314ed..ed404355ea4c 100644
> --- a/drivers/staging/iio/resolver/ad2s1210.c
> +++ b/drivers/staging/iio/resolver/ad2s1210.c
> @@ -130,17 +130,24 @@ static int ad2s1210_config_write(struct ad2s1210_state *st, u8 data)
>  static int ad2s1210_config_read(struct ad2s1210_state *st,
>  				unsigned char address)
>  {
> -	struct spi_transfer xfer = {
> -		.len = 2,
> -		.rx_buf = st->rx,
> -		.tx_buf = st->tx,
> +	struct spi_transfer xfers[] = {
> +		{
> +			.len = 1,
> +			.rx_buf = &st->rx[0],
> +			.tx_buf = &st->tx[0],
> +			.cs_change = 1,
> +		}, {
> +			.len = 1,
> +			.rx_buf = &st->rx[1],
> +			.tx_buf = &st->tx[1],
> +		},
>  	};
>  	int ret = 0;
>  
>  	ad2s1210_set_mode(MOD_CONFIG, st);
>  	st->tx[0] = address | AD2S1210_MSB_IS_HIGH;
>  	st->tx[1] = AD2S1210_REG_FAULT;
> -	ret = spi_sync_transfer(st->sdev, &xfer, 1);
> +	ret = spi_sync_transfer(st->sdev, xfers, 2);
>  	if (ret < 0)
>  		return ret;
>  

