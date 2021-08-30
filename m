Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80DE53FB7BA
	for <lists+linux-iio@lfdr.de>; Mon, 30 Aug 2021 16:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237118AbhH3OR5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Aug 2021 10:17:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:60154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237062AbhH3OR4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Aug 2021 10:17:56 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A45A60E98;
        Mon, 30 Aug 2021 14:16:56 +0000 (UTC)
Date:   Mon, 30 Aug 2021 15:20:08 +0100
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
Subject: Re: [PATCH 34/40] iio: adc: ti_am335x_adc: Add a unit to the
 timeout delay
Message-ID: <20210830152008.1d4b06aa@jic23-huawei>
In-Reply-To: <20210825152518.379386-35-miquel.raynal@bootlin.com>
References: <20210825152518.379386-1-miquel.raynal@bootlin.com>
        <20210825152518.379386-35-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 25 Aug 2021 17:25:12 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> The lack of unit in the macro name kind of tricked me when I was
> troubleshooting an issue. Physical constants should always get a unit.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/iio/adc/ti_am335x_adc.c      | 2 +-
>  include/linux/mfd/ti_am335x_tscadc.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
> index 4eaf5b031707..ebf6326af60d 100644
> --- a/drivers/iio/adc/ti_am335x_adc.c
> +++ b/drivers/iio/adc/ti_am335x_adc.c
> @@ -441,7 +441,7 @@ static int tiadc_read_raw(struct iio_dev *indio_dev,
>  	am335x_tsc_se_set_once(adc_dev->mfd_tscadc, step_en);
>  
>  	/* Wait for Fifo threshold interrupt */
> -	timeout = jiffies + msecs_to_jiffies(IDLE_TIMEOUT * adc_dev->channels);
> +	timeout = jiffies + msecs_to_jiffies(IDLE_TIMEOUT_MS * adc_dev->channels);
>  	while (1) {
>  		fifo1count = tiadc_readl(adc_dev, REG_FIFO1CNT);
>  		if (fifo1count)
> diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
> index 31b22ec567e7..177ab2499200 100644
> --- a/include/linux/mfd/ti_am335x_tscadc.h
> +++ b/include/linux/mfd/ti_am335x_tscadc.h
> @@ -164,7 +164,7 @@
>   *
>   * max processing time: 266431 * 308ns = 83ms(approx)
>   */
> -#define IDLE_TIMEOUT 83 /* milliseconds */
> +#define IDLE_TIMEOUT_MS 83 /* milliseconds */
>  
>  #define TSCADC_CELLS		2
>  

