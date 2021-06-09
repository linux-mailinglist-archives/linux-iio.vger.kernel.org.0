Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 742993A1987
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jun 2021 17:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236305AbhFIPa4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Jun 2021 11:30:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:54678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235379AbhFIPaz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 9 Jun 2021 11:30:55 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0616611CC;
        Wed,  9 Jun 2021 15:28:55 +0000 (UTC)
Date:   Wed, 9 Jun 2021 16:30:48 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-stm32@st-md-mailman.stormreply.com, kernel@pengutronix.de,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de,
        jarkko.nikula@linux.intel.com
Subject: Re: [PATCH v11 15/33] counter: microchip-tcb-capture: Add const
 qualifier for actions_list array
Message-ID: <20210609163048.45310556@jic23-huawei>
In-Reply-To: <165f9682ce308a60a477aaa56fdae7bc949dc218.1623201081.git.vilhelm.gray@gmail.com>
References: <cover.1623201081.git.vilhelm.gray@gmail.com>
        <165f9682ce308a60a477aaa56fdae7bc949dc218.1623201081.git.vilhelm.gray@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed,  9 Jun 2021 10:31:18 +0900
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> The struct counter_synapse actions_list member expects a const enum
> counter_synapse_action array. This patch adds the const qualifier to the
> mchp_tc_synapse_actions to match actions_list.
> 
> Cc: Kamel Bouhara <kamel.bouhara@bootlin.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
Applied.
Thanks
> ---
>  drivers/counter/microchip-tcb-capture.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
> index cabcfebfc799..51b8af80f98b 100644
> --- a/drivers/counter/microchip-tcb-capture.c
> +++ b/drivers/counter/microchip-tcb-capture.c
> @@ -49,7 +49,7 @@ enum mchp_tc_synapse_action {
>  	MCHP_TC_SYNAPSE_ACTION_BOTH_EDGE
>  };
>  
> -static enum counter_synapse_action mchp_tc_synapse_actions[] = {
> +static const enum counter_synapse_action mchp_tc_synapse_actions[] = {
>  	[MCHP_TC_SYNAPSE_ACTION_NONE] = COUNTER_SYNAPSE_ACTION_NONE,
>  	[MCHP_TC_SYNAPSE_ACTION_RISING_EDGE] = COUNTER_SYNAPSE_ACTION_RISING_EDGE,
>  	[MCHP_TC_SYNAPSE_ACTION_FALLING_EDGE] = COUNTER_SYNAPSE_ACTION_FALLING_EDGE,

