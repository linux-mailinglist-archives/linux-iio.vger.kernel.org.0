Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12A463A1981
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jun 2021 17:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234531AbhFIP3u (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Jun 2021 11:29:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:54050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233840AbhFIP3t (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 9 Jun 2021 11:29:49 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99688611CC;
        Wed,  9 Jun 2021 15:27:50 +0000 (UTC)
Date:   Wed, 9 Jun 2021 16:29:42 +0100
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
Subject: Re: [PATCH v11 14/33] counter: interrupt-cnt: Add const qualifier
 for actions_list array
Message-ID: <20210609162942.6bdc6d63@jic23-huawei>
In-Reply-To: <a3bdffbe7c38eb95ea692ed30aeb50dbb65c9e6f.1623201081.git.vilhelm.gray@gmail.com>
References: <cover.1623201081.git.vilhelm.gray@gmail.com>
        <a3bdffbe7c38eb95ea692ed30aeb50dbb65c9e6f.1623201081.git.vilhelm.gray@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed,  9 Jun 2021 10:31:17 +0900
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> The struct counter_synapse actions_list member expects a const enum
> counter_synapse_action array. This patch adds the const qualifier to the
> interrupt_cnt_synapse_actionss to match actions_list.
> 
> Cc: Oleksij Rempel <o.rempel@pengutronix.de>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
Naming looks unusual...

> ---
>  drivers/counter/interrupt-cnt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/interrupt-cnt.c
> index 827d785e19b4..0e07607f2cd3 100644
> --- a/drivers/counter/interrupt-cnt.c
> +++ b/drivers/counter/interrupt-cnt.c
> @@ -77,7 +77,7 @@ static const struct counter_count_ext interrupt_cnt_ext[] = {
>  	},
>  };
>  
> -static enum counter_synapse_action interrupt_cnt_synapse_actionss[] = {
> +static const enum counter_synapse_action interrupt_cnt_synapse_actionss[] = {

actions?

Perhaps good to fix that whilst we are here.

>  	COUNTER_SYNAPSE_ACTION_RISING_EDGE,
>  };
>  

