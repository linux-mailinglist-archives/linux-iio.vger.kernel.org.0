Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 694222B35BB
	for <lists+linux-iio@lfdr.de>; Sun, 15 Nov 2020 16:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbgKOP0W (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Nov 2020 10:26:22 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:49499 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbgKOP0W (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Nov 2020 10:26:22 -0500
Received: from kb-xps (unknown [78.193.40.249])
        (Authenticated sender: kamel.bouhara@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 38229200002;
        Sun, 15 Nov 2020 15:26:19 +0000 (UTC)
Date:   Sun, 15 Nov 2020 16:26:17 +0100
From:   Kamel Bouhara <kamel.bouhara@bootlin.com>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     jic23@kernel.org, robh+dt@kernel.org,
        alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] counter: microchip-tcb-capture: Fix CMR value check
Message-ID: <20201115152617.GB2233@kb-xps>
References: <20201114232805.253108-1-vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201114232805.253108-1-vilhelm.gray@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Nov 14, 2020 at 06:28:05PM -0500, William Breathitt Gray wrote:
> The ATMEL_TC_ETRGEDG_* defines are not masks but rather possible values
> for CMR. This patch fixes the action_get() callback to properly check
> for these values rather than mask them.
>
> Fixes: 106b104137fd ("counter: Add microchip TCB capture counter")
> Cc: Kamel Bouhara <kamel.bouhara@bootlin.com>
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---

Acked-by: Kamel Bouhara <kamel.bouhara@bootlin.com>

>  drivers/counter/microchip-tcb-capture.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
> index 039c54a78aa5..710acc0a3704 100644
> --- a/drivers/counter/microchip-tcb-capture.c
> +++ b/drivers/counter/microchip-tcb-capture.c
> @@ -183,16 +183,20 @@ static int mchp_tc_count_action_get(struct counter_device *counter,
>
>  	regmap_read(priv->regmap, ATMEL_TC_REG(priv->channel[0], CMR), &cmr);
>
> -	*action = MCHP_TC_SYNAPSE_ACTION_NONE;
> -
> -	if (cmr & ATMEL_TC_ETRGEDG_NONE)
> +	switch (cmr & ATMEL_TC_ETRGEDG) {
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
Kamel Bouhara, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
