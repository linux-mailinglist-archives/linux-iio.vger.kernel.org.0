Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9AE82B313A
	for <lists+linux-iio@lfdr.de>; Sat, 14 Nov 2020 23:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgKNWsb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 Nov 2020 17:48:31 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:35451 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgKNWsa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 Nov 2020 17:48:30 -0500
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 341E3240004;
        Sat, 14 Nov 2020 22:48:28 +0000 (UTC)
Date:   Sat, 14 Nov 2020 23:48:27 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     jic23@kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kamel Bouhara <kamel.bouhara@bootlin.com>
Subject: Re: [PATCH] counter: microchip-tcb-capture: Fix CMR value check
Message-ID: <20201114224827.GQ4556@piout.net>
References: <20201111163807.10201-1-vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111163807.10201-1-vilhelm.gray@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 11/11/2020 11:38:07-0500, William Breathitt Gray wrote:
> The ATMEL_TC_ETRGEDG_* defines are not masks but rather possible values
> for CMR. This patch fixes the action_get() callback to properly check
> for these values rather than mask them.
> 
> Fixes: 106b104137fd ("counter: Add microchip TCB capture counter")
> Cc: Kamel Bouhara <kamel.bouhara@bootlin.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

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
> -- 
> 2.29.2
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
