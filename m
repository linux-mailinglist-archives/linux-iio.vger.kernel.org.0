Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F04B41C84E
	for <lists+linux-iio@lfdr.de>; Wed, 29 Sep 2021 17:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345198AbhI2P05 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Sep 2021 11:26:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:36670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344945AbhI2P05 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 29 Sep 2021 11:26:57 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89FD661440;
        Wed, 29 Sep 2021 15:25:11 +0000 (UTC)
Date:   Wed, 29 Sep 2021 16:29:05 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Lee Jones <lee.jones@linaro.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        bcousson@baylibre.com, Tony Lindgren <tony@atomide.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Ryan Barnett <ryan.barnett@collins.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Jason Reeder <jreeder@ti.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 25/48] mfd: ti_am335x_tscadc: Use the new HZ_PER_MHZ
 macro
Message-ID: <20210929162905.5fc771c5@jic23-huawei>
In-Reply-To: <20210928133143.157329-26-miquel.raynal@bootlin.com>
References: <20210928133143.157329-1-miquel.raynal@bootlin.com>
        <20210928133143.157329-26-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 28 Sep 2021 15:31:20 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Before adding another frequency with even more zeroes, use the
> HZ_PER_MHZ macro to clarify the number.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
You missed tag I gave on v3.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks,

> ---
>  include/linux/mfd/ti_am335x_tscadc.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
> index 893c474c1f8c..a85643677bef 100644
> --- a/include/linux/mfd/ti_am335x_tscadc.h
> +++ b/include/linux/mfd/ti_am335x_tscadc.h
> @@ -9,6 +9,7 @@
>  #define __LINUX_TI_AM335X_TSCADC_MFD_H
>  
>  #include <linux/mfd/core.h>
> +#include <linux/units.h>
>  
>  #define REG_RAWIRQSTATUS	0x024
>  #define REG_IRQSTATUS		0x028
> @@ -133,7 +134,7 @@
>  #define SEQ_STATUS		BIT(5)
>  #define CHARGE_STEP		0x11
>  
> -#define ADC_CLK			3000000
> +#define ADC_CLK			(3 * HZ_PER_MHZ)
>  #define TOTAL_STEPS		16
>  #define TOTAL_CHANNELS		8
>  #define FIFO1_THRESHOLD		19

