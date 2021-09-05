Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D96400F9A
	for <lists+linux-iio@lfdr.de>; Sun,  5 Sep 2021 14:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237952AbhIEMUM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Sep 2021 08:20:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:46786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232137AbhIEMUK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Sep 2021 08:20:10 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBF2C60EE6;
        Sun,  5 Sep 2021 12:19:01 +0000 (UTC)
Date:   Sun, 5 Sep 2021 13:22:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, bcousson@baylibre.com,
        Tony Lindgren <tony@atomide.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Ryan Barnett <ryan.barnett@collins.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Jason Reeder <jreeder@ti.com>
Subject: Re: [PATCH v2 24/46] mfd: ti_am335x_tscadc: Fix header spacing
Message-ID: <20210905132228.1ef9f662@jic23-huawei>
In-Reply-To: <20210902215144.507243-25-miquel.raynal@bootlin.com>
References: <20210902215144.507243-1-miquel.raynal@bootlin.com>
        <20210902215144.507243-25-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  2 Sep 2021 23:51:22 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Harmonize the spacing within macro definitions.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
LGTM
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  include/linux/mfd/ti_am335x_tscadc.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
> index 334ce1a879df..efafecfc87a7 100644
> --- a/include/linux/mfd/ti_am335x_tscadc.h
> +++ b/include/linux/mfd/ti_am335x_tscadc.h
> @@ -41,7 +41,7 @@
>  /* Step Enable */
>  #define STEPENB_MASK		(0x1FFFF << 0)
>  #define STEPENB(val)		((val) << 0)
> -#define ENB(val)			(1 << (val))
> +#define ENB(val)		(1 << (val))
>  #define STPENB_STEPENB		STEPENB(0x1FFFF)
>  #define STPENB_STEPENB_TC	STEPENB(0x1FFF)
>  
> @@ -122,15 +122,15 @@
>  #define CNTRLREG_TSCENB		BIT(7)
>  
>  /* FIFO READ Register */
> -#define FIFOREAD_DATA_MASK (0xfff << 0)
> -#define FIFOREAD_CHNLID_MASK (0xf << 16)
> +#define FIFOREAD_DATA_MASK	(0xfff << 0)
> +#define FIFOREAD_CHNLID_MASK	(0xf << 16)
>  
>  /* DMA ENABLE/CLEAR Register */
>  #define DMA_FIFO0		BIT(0)
>  #define DMA_FIFO1		BIT(1)
>  
>  /* Sequencer Status */
> -#define SEQ_STATUS BIT(5)
> +#define SEQ_STATUS		BIT(5)
>  #define CHARGE_STEP		0x11
>  
>  #define ADC_CLK			3000000
> @@ -150,7 +150,7 @@
>   *
>   * max processing time: 266431 * 308ns = 83ms(approx)
>   */
> -#define IDLE_TIMEOUT 83 /* milliseconds */
> +#define IDLE_TIMEOUT		83 /* milliseconds */
>  
>  #define TSCADC_CELLS		2
>  

