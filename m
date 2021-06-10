Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94EC73A22BD
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jun 2021 05:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhFJDZq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Jun 2021 23:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbhFJDZq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Jun 2021 23:25:46 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18872C061574
        for <linux-iio@vger.kernel.org>; Wed,  9 Jun 2021 20:23:51 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1lrBIK-0005oq-3y; Thu, 10 Jun 2021 05:23:48 +0200
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1lrBIJ-0002a5-A4; Thu, 10 Jun 2021 05:23:47 +0200
Date:   Thu, 10 Jun 2021 05:23:47 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     jic23@kernel.org, linux@rempel-privat.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] counter: interrupt-cnt: Add const qualifier for
 actions_list array
Message-ID: <20210610032347.wb4wcwr37p7qn7j7@pengutronix.de>
References: <20210610013642.149961-1-vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210610013642.149961-1-vilhelm.gray@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 05:22:36 up 189 days, 17:28, 37 users,  load average: 0.01, 0.03,
 0.00
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi William,

On Thu, Jun 10, 2021 at 10:36:42AM +0900, William Breathitt Gray wrote:
> The struct counter_synapse actions_list member expects a const enum
> counter_synapse_action array. This patch renames
> interrupt_cnt_synapse_actionss to interrupt_cnt_synapse_actions and adds
> a const qualifier to match actions_list.
> 
> Cc: Oleksij Rempel <o.rempel@pengutronix.de>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Reviewed-by: <o.rempel@pengutronix.de>

thank you!

> ---
>  drivers/counter/interrupt-cnt.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/interrupt-cnt.c
> index 827d785e19b4..5df7cd13d4c7 100644
> --- a/drivers/counter/interrupt-cnt.c
> +++ b/drivers/counter/interrupt-cnt.c
> @@ -77,7 +77,7 @@ static const struct counter_count_ext interrupt_cnt_ext[] = {
>  	},
>  };
>  
> -static enum counter_synapse_action interrupt_cnt_synapse_actionss[] = {
> +static const enum counter_synapse_action interrupt_cnt_synapse_actions[] = {
>  	COUNTER_SYNAPSE_ACTION_RISING_EDGE,
>  };
>  
> @@ -194,8 +194,8 @@ static int interrupt_cnt_probe(struct platform_device *pdev)
>  	priv->counter.signals = &priv->signals;
>  	priv->counter.num_signals = 1;
>  
> -	priv->synapses.actions_list = interrupt_cnt_synapse_actionss;
> -	priv->synapses.num_actions = ARRAY_SIZE(interrupt_cnt_synapse_actionss);
> +	priv->synapses.actions_list = interrupt_cnt_synapse_actions;
> +	priv->synapses.num_actions = ARRAY_SIZE(interrupt_cnt_synapse_actions);
>  	priv->synapses.signal = &priv->signals;
>  
>  	priv->cnts.name = "Channel 0 Count";
> -- 
> 2.32.0
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
