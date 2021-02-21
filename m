Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87F26320B88
	for <lists+linux-iio@lfdr.de>; Sun, 21 Feb 2021 16:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhBUPso (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Feb 2021 10:48:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:42752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229802AbhBUPsn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 Feb 2021 10:48:43 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B4C464E24;
        Sun, 21 Feb 2021 15:48:01 +0000 (UTC)
Date:   Sun, 21 Feb 2021 15:47:58 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Gene Chen <gene_chen@richtek.com>,
        Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: [PATCH] iio: adc: mt6360: Include right header
Message-ID: <20210221154758.10aa25a3@archlinux>
In-Reply-To: <20210215153447.48457-1-linus.walleij@linaro.org>
References: <20210215153447.48457-1-linus.walleij@linaro.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 15 Feb 2021 16:34:47 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> To get access to the big endian byte order parsing helpers
> drivers need to include <asm/unaligned.h> and nothing else.
> 
> Cc: Gene Chen <gene_chen@richtek.com>
> Suggested-by: Harvey Harrison <harvey.harrison@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Applied to the togreg branch of iio.git and pushed out as testing for
all the normal reasons.

I'm not rushing this one through as it's a SoC ADC so I assume the
endian choice is right, even though not how it should be done.

Jonathan

> ---
>  drivers/iio/adc/mt6360-adc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/mt6360-adc.c b/drivers/iio/adc/mt6360-adc.c
> index f57db3056fbe..6b39a139ce28 100644
> --- a/drivers/iio/adc/mt6360-adc.c
> +++ b/drivers/iio/adc/mt6360-adc.c
> @@ -9,13 +9,14 @@
>  #include <linux/mutex.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
> -#include <linux/unaligned/be_byteshift.h>
>  
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/triggered_buffer.h>
>  
> +#include <asm/unaligned.h>
> +
>  #define MT6360_REG_PMUCHGCTRL3	0x313
>  #define MT6360_REG_PMUADCCFG	0x356
>  #define MT6360_REG_PMUADCIDLET	0x358

