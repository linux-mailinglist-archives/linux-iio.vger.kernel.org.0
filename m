Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7B923A192A
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jun 2021 17:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbhFIPVz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Jun 2021 11:21:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:48318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230086AbhFIPVy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 9 Jun 2021 11:21:54 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9F7B611CC;
        Wed,  9 Jun 2021 15:19:55 +0000 (UTC)
Date:   Wed, 9 Jun 2021 16:21:48 +0100
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
Subject: Re: [PATCH v11 08/33] counter: interrupt-cnt: Add const qualifier
 for functions_list array
Message-ID: <20210609162148.3f6631c6@jic23-huawei>
In-Reply-To: <86f7fb77f703cf2508a6b4ee9cf80aa523392976.1623201081.git.vilhelm.gray@gmail.com>
References: <cover.1623201081.git.vilhelm.gray@gmail.com>
        <86f7fb77f703cf2508a6b4ee9cf80aa523392976.1623201081.git.vilhelm.gray@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed,  9 Jun 2021 10:31:11 +0900
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> The struct counter_count functions_list member expects a const enum
> counter_count_function array. This patch adds the const qualifier to the
> interrupt__cnt_functions to match functions_list.
> 
> Cc: Oleksij Rempel <o.rempel@pengutronix.de>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
Applied
> ---
>  drivers/counter/interrupt-cnt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/interrupt-cnt.c
> index a99ee7996977..827d785e19b4 100644
> --- a/drivers/counter/interrupt-cnt.c
> +++ b/drivers/counter/interrupt-cnt.c
> @@ -112,7 +112,7 @@ static int interrupt_cnt_write(struct counter_device *counter,
>  	return 0;
>  }
>  
> -static enum counter_count_function interrupt_cnt_functions[] = {
> +static const enum counter_count_function interrupt_cnt_functions[] = {
>  	COUNTER_COUNT_FUNCTION_INCREASE,
>  };
>  

