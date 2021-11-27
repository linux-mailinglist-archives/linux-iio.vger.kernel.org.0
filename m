Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8C54600A7
	for <lists+linux-iio@lfdr.de>; Sat, 27 Nov 2021 18:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355784AbhK0Rr6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Nov 2021 12:47:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355931AbhK0Rp6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 27 Nov 2021 12:45:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD46C0613F4;
        Sat, 27 Nov 2021 09:41:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D4EC60EDF;
        Sat, 27 Nov 2021 17:41:07 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id CF786C53FAD;
        Sat, 27 Nov 2021 17:41:01 +0000 (UTC)
Date:   Sat, 27 Nov 2021 17:46:02 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alyssa Ross <hi@alyssa.is>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        linux-stm32@st-md-mailman.stormreply.com (moderated list:ARM/STM32
        ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/STM32
        ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH] iio: trigger: stm32-timer: fix MODULE_ALIAS
Message-ID: <20211127174602.6f674d37@jic23-huawei>
In-Reply-To: <20211125182850.2645424-1-hi@alyssa.is>
References: <20211125182850.2645424-1-hi@alyssa.is>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 25 Nov 2021 18:28:48 +0000
Alyssa Ross <hi@alyssa.is> wrote:

> modprobe can't handle spaces in aliases.
> 
> Fixes: 93fbe91b5521 ("iio: Add STM32 timer trigger driver")
> Signed-off-by: Alyssa Ross <hi@alyssa.is>
Hi Alysaa,

Looks fine to me, but I'd like to give it a little longer on list before
taking it as a fix, particularly as this probably wants to get backported
to stable.

Thanks,

Jonathan

> ---
>  drivers/iio/trigger/stm32-timer-trigger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
> index 33083877cd19..4353b749ecef 100644
> --- a/drivers/iio/trigger/stm32-timer-trigger.c
> +++ b/drivers/iio/trigger/stm32-timer-trigger.c
> @@ -912,6 +912,6 @@ static struct platform_driver stm32_timer_trigger_driver = {
>  };
>  module_platform_driver(stm32_timer_trigger_driver);
>  
> -MODULE_ALIAS("platform: stm32-timer-trigger");
> +MODULE_ALIAS("platform:stm32-timer-trigger");
>  MODULE_DESCRIPTION("STMicroelectronics STM32 Timer Trigger driver");
>  MODULE_LICENSE("GPL v2");

