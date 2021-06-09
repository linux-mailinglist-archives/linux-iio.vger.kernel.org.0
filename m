Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 741E83A199E
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jun 2021 17:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbhFIPdK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Jun 2021 11:33:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:57114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233384AbhFIPdJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 9 Jun 2021 11:33:09 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2579E61351;
        Wed,  9 Jun 2021 15:31:07 +0000 (UTC)
Date:   Wed, 9 Jun 2021 16:33:00 +0100
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
        jarkko.nikula@linux.intel.com,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: Re: [PATCH v11 17/33] counter: stm32-timer-cnt: Add const qualifier
 for actions_list array
Message-ID: <20210609163300.56fe913d@jic23-huawei>
In-Reply-To: <9675edda958ee2ca371d271f46445d3e1934ba82.1623201081.git.vilhelm.gray@gmail.com>
References: <cover.1623201081.git.vilhelm.gray@gmail.com>
        <9675edda958ee2ca371d271f46445d3e1934ba82.1623201081.git.vilhelm.gray@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed,  9 Jun 2021 10:31:20 +0900
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> The struct counter_synapse actions_list member expects a const enum
> counter_synapse_action array. This patch adds the const qualifier to the
> stm32_synapse_actions to match actions_list.
> 
> Cc: Benjamin Gaignard <benjamin.gaignard@st.com>
> Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
Applied.

> ---
>  drivers/counter/stm32-timer-cnt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
> index 0c18573a7837..603b30ada839 100644
> --- a/drivers/counter/stm32-timer-cnt.c
> +++ b/drivers/counter/stm32-timer-cnt.c
> @@ -267,7 +267,7 @@ enum stm32_synapse_action {
>  	STM32_SYNAPSE_ACTION_BOTH_EDGES
>  };
>  
> -static enum counter_synapse_action stm32_synapse_actions[] = {
> +static const enum counter_synapse_action stm32_synapse_actions[] = {
>  	[STM32_SYNAPSE_ACTION_NONE] = COUNTER_SYNAPSE_ACTION_NONE,
>  	[STM32_SYNAPSE_ACTION_BOTH_EDGES] = COUNTER_SYNAPSE_ACTION_BOTH_EDGES
>  };

