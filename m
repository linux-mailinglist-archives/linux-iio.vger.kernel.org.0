Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2AB3A1973
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jun 2021 17:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234362AbhFIP20 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Jun 2021 11:28:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:53152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233681AbhFIP2Z (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 9 Jun 2021 11:28:25 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 618D060E0B;
        Wed,  9 Jun 2021 15:26:26 +0000 (UTC)
Date:   Wed, 9 Jun 2021 16:28:19 +0100
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
Subject: Re: [PATCH v11 13/33] counter: ftm-quaddec: Add const qualifier for
 actions_list array
Message-ID: <20210609162819.3b466e32@jic23-huawei>
In-Reply-To: <db1df2021efb1b98e6d1a50787be5a52a1896574.1623201081.git.vilhelm.gray@gmail.com>
References: <cover.1623201081.git.vilhelm.gray@gmail.com>
        <db1df2021efb1b98e6d1a50787be5a52a1896574.1623201081.git.vilhelm.gray@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed,  9 Jun 2021 10:31:16 +0900
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> The struct counter_synapse actions_list member expects a const enum
> counter_synapse_action array. This patch adds the const qualifier to the
> ftm_quaddec_synapse_actions to match actions_list.
> 
> Cc: Patrick Havelange <patrick.havelange@essensium.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
Applied.

Thanks,

Jonathan

> ---
>  drivers/counter/ftm-quaddec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/counter/ftm-quaddec.c b/drivers/counter/ftm-quaddec.c
> index c2b3fdfd8b77..9371532406ca 100644
> --- a/drivers/counter/ftm-quaddec.c
> +++ b/drivers/counter/ftm-quaddec.c
> @@ -162,7 +162,7 @@ enum ftm_quaddec_synapse_action {
>  	FTM_QUADDEC_SYNAPSE_ACTION_BOTH_EDGES,
>  };
>  
> -static enum counter_synapse_action ftm_quaddec_synapse_actions[] = {
> +static const enum counter_synapse_action ftm_quaddec_synapse_actions[] = {
>  	[FTM_QUADDEC_SYNAPSE_ACTION_BOTH_EDGES] =
>  	COUNTER_SYNAPSE_ACTION_BOTH_EDGES
>  };

