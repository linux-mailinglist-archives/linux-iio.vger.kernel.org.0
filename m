Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCA13FB622
	for <lists+linux-iio@lfdr.de>; Mon, 30 Aug 2021 14:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbhH3MgG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Aug 2021 08:36:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:54006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232267AbhH3MgF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Aug 2021 08:36:05 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 642A060724;
        Mon, 30 Aug 2021 12:35:06 +0000 (UTC)
Date:   Mon, 30 Aug 2021 13:38:17 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, bcousson@baylibre.com,
        Tony Lindgren <tony@atomide.com>,
        Tero Kristo <t-kristo@ti.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "Ryan J . Barnett" <ryan.barnett@collins.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH 08/40] mfd: ti_am335x_tscadc: Replace license text with
 SPDX tag
Message-ID: <20210830133817.0c994062@jic23-huawei>
In-Reply-To: <20210825152518.379386-9-miquel.raynal@bootlin.com>
References: <20210825152518.379386-1-miquel.raynal@bootlin.com>
        <20210825152518.379386-9-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 25 Aug 2021 17:24:46 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Drop the text license and replace it with an equivalent SPDX license tag
> identifier.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Matches with the MODULE_LICENSE(GPL) so make sense to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I wonder how this one managed to escape being updated before?  Ah well..

> ---
>  drivers/mfd/ti_am335x_tscadc.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
> index 0e6e25308190..45262ca7734a 100644
> --- a/drivers/mfd/ti_am335x_tscadc.c
> +++ b/drivers/mfd/ti_am335x_tscadc.c
> @@ -1,16 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * TI Touch Screen / ADC MFD driver
>   *
>   * Copyright (C) 2012 Texas Instruments Incorporated - https://www.ti.com/
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License as
> - * published by the Free Software Foundation version 2.
> - *
> - * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> - * kind, whether express or implied; without even the implied warranty
> - * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
>   */
>  
>  #include <linux/module.h>

