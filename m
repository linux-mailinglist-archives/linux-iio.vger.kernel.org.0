Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E53C115BBF
	for <lists+linux-iio@lfdr.de>; Sat,  7 Dec 2019 10:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfLGJoP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Dec 2019 04:44:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:53670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbfLGJoP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Dec 2019 04:44:15 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0D582173E;
        Sat,  7 Dec 2019 09:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575711854;
        bh=zKUt0zWqEpyq7pKzwKvy5c2qAU6CwaNc1rc87W9jXVY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DFOmsGIzOFHCk2HUiNPuUYp/Vn+Wut1sE2vNXMRjAGxCmLJgU1VyQjWJkMvNtLqyv
         6WxO9GOBLchCpMAdZq4u0LQTlMy9pxXubt9G/nH8em4biJRL9sBDEgJtfpmOBt1eOT
         HW6aHHdYfFrc3uNfQF3zclfi4d4M80t80Qt2azwk=
Date:   Sat, 7 Dec 2019 09:44:10 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: itg3200: Drop GPIO include
Message-ID: <20191207094410.2d5581b3@archlinux>
In-Reply-To: <20191202082603.63227-1-linus.walleij@linaro.org>
References: <20191202082603.63227-1-linus.walleij@linaro.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  2 Dec 2019 09:26:03 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> The driver include <linux/gpio.h> yet does not use any
> of the symbols from the header, so drop the include.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Applied,
> ---
>  drivers/iio/gyro/itg3200_core.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/gyro/itg3200_core.c b/drivers/iio/gyro/itg3200_core.c
> index 981ae2291505..b3afa556f973 100644
> --- a/drivers/iio/gyro/itg3200_core.c
> +++ b/drivers/iio/gyro/itg3200_core.c
> @@ -15,7 +15,6 @@
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
>  #include <linux/i2c.h>
> -#include <linux/gpio.h>
>  #include <linux/slab.h>
>  #include <linux/stat.h>
>  #include <linux/module.h>

