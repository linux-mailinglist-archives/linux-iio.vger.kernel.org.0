Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D396E2B2E4D
	for <lists+linux-iio@lfdr.de>; Sat, 14 Nov 2020 17:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgKNQDn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 Nov 2020 11:03:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:52570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726356AbgKNQDn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 14 Nov 2020 11:03:43 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B3EF20665;
        Sat, 14 Nov 2020 16:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605369823;
        bh=UITx00zAcB1ZwANInVsxHvLlr4TN0cqsz0W9nq0Fyfo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fUvVti4IZGwyHeRf61jppFlImIY5Ro7vn13y/OLV9gX6sgcZhMuFM4SgBSWj2W9q9
         8IOXY9jLerAw1cURZCTJF2XO+ghUU3Y0ysEh+cauKrjiE41uLWkdex/ggEBE3f3DQk
         AOzGO4hG8XSn2r+YI1jtf17QDp3b3mYvuKDDkcqA=
Date:   Sat, 14 Nov 2020 16:03:38 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     robh+dt@kernel.org, alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kamel Bouhara <kamel.bouhara@bootlin.com>
Subject: Re: [PATCH] counter: microchip-tcb-capture: Fix CMR value check
Message-ID: <20201114160338.29a178f6@archlinux>
In-Reply-To: <20201111163807.10201-1-vilhelm.gray@gmail.com>
References: <20201111163807.10201-1-vilhelm.gray@gmail.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 11 Nov 2020 11:38:07 -0500
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> The ATMEL_TC_ETRGEDG_* defines are not masks but rather possible values
> for CMR. This patch fixes the action_get() callback to properly check
> for these values rather than mask them.
> 
> Fixes: 106b104137fd ("counter: Add microchip TCB capture counter")
> Cc: Kamel Bouhara <kamel.bouhara@bootlin.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Looks fine to me, but ideally after an ack from Kamel

Thanks,

Jonathan

> ---
>  drivers/counter/microchip-tcb-capture.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
> index 039c54a78aa5..142b389fc9db 100644
> --- a/drivers/counter/microchip-tcb-capture.c
> +++ b/drivers/counter/microchip-tcb-capture.c
> @@ -183,16 +183,20 @@ static int mchp_tc_count_action_get(struct counter_device *counter,
>  
>  	regmap_read(priv->regmap, ATMEL_TC_REG(priv->channel[0], CMR), &cmr);
>  
> -	*action = MCHP_TC_SYNAPSE_ACTION_NONE;
> -
> -	if (cmr & ATMEL_TC_ETRGEDG_NONE)
> +	switch (cmr & ATMEL_TC_ETRGEDG_BOTH) {
> +	default:
>  		*action = MCHP_TC_SYNAPSE_ACTION_NONE;
> -	else if (cmr & ATMEL_TC_ETRGEDG_RISING)
> +		break;
> +	case ATMEL_TC_ETRGEDG_RISING:
>  		*action = MCHP_TC_SYNAPSE_ACTION_RISING_EDGE;
> -	else if (cmr & ATMEL_TC_ETRGEDG_FALLING)
> +		break;
> +	case ATMEL_TC_ETRGEDG_FALLING:
>  		*action = MCHP_TC_SYNAPSE_ACTION_FALLING_EDGE;
> -	else if (cmr & ATMEL_TC_ETRGEDG_BOTH)
> +		break;
> +	case ATMEL_TC_ETRGEDG_BOTH:
>  		*action = MCHP_TC_SYNAPSE_ACTION_BOTH_EDGE;
> +		break;
> +	}
>  
>  	return 0;
>  }

