Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A80A014172E
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2020 12:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgARLUM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jan 2020 06:20:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:40158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726961AbgARLUM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jan 2020 06:20:12 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DB482468B;
        Sat, 18 Jan 2020 11:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579346411;
        bh=eb/ffuQCnjGU8Wnjpp4BEJc6hOcGxDzaA3lFz2VXzuY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ro3xRUe6E3TqNVbU1xEWJG3JiNL1787H9YjtyPYRUv3whVCKfq5Zy5ZbdpNkRlWeg
         sFpv49Y2EZ/BwfgPbNv7jGLJiNC403AlPA3Sg03TCPDi/iN5+Im8Lo6zowUzL455Rq
         8tLrMY+W3G87wHQ6HHYCmOj6mtRF16hZAPQKe/yw=
Date:   Sat, 18 Jan 2020 11:20:07 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Tachici <alexandru.tachici@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2 V3] iio: adc: ad7124: Set IRQ type to falling
Message-ID: <20200118112007.43ab1f13@archlinux>
In-Reply-To: <20200113102653.20900-3-alexandru.tachici@analog.com>
References: <20200111112317.1cf2d878@archlinux>
        <20200113102653.20900-1-alexandru.tachici@analog.com>
        <20200113102653.20900-3-alexandru.tachici@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 13 Jan 2020 12:26:53 +0200
Alexandru Tachici <alexandru.tachici@analog.com> wrote:

> Ad7124 data-sheet specifies that the falling edge
> of the DOUT line should be used for an interrupt.
> The current irq flag (IRQF_TRIGGER_LOW) used will
> cause unwanted behaviour. When enabling the interrupt
> it will fire once because the DOUT line is already low.
> This will make the driver to read an unfinished conversion
> from the chip.
> 
> This patch sets the irq type to the one specified in
> the data-sheet.
> 
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7124.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> index 9531d8a6cb27..9113f6d36ad4 100644
> --- a/drivers/iio/adc/ad7124.c
> +++ b/drivers/iio/adc/ad7124.c
> @@ -223,7 +223,7 @@ static const struct ad_sigma_delta_info ad7124_sigma_delta_info = {
>  	.addr_shift = 0,
>  	.read_mask = BIT(6),
>  	.data_reg = AD7124_DATA,
> -	.irq_flags = IRQF_TRIGGER_LOW,
> +	.irq_flags = IRQF_TRIGGER_FALLING,
>  };
>  
>  static int ad7124_set_channel_odr(struct ad7124_state *st,

