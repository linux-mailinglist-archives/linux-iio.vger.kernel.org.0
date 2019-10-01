Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACD49C2FDF
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2019 11:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733166AbfJAJS2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 1 Oct 2019 05:18:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:45926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729418AbfJAJS2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 1 Oct 2019 05:18:28 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D0DE20700;
        Tue,  1 Oct 2019 09:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569921507;
        bh=NzrmT6/uM8DiLs5qH8+ADYtEzINy849nBpR8ZrecVm8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=L588/tMWNTk7MXtRD9IvA1JHu70dCQjc453S6/+xuKlyC/78qg1NVjRL8BKf28rgT
         jrF9BjFR/+1s9yLeXhnl8KVNKP8F1cHqWJz6HhBmx1gGwWKkbXDvtpT8DkDtiPlkXj
         B3DSkNGXwOX5vBMN8W+yXusvHJ7ZoK+evcspEJr4=
Date:   Tue, 1 Oct 2019 10:18:21 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Stephen Boyd <swboyd@chromium.org>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: Variables could be uninitalized if
 regmap_read() fails
Message-ID: <20191001101821.438259c2@archlinux>
In-Reply-To: <20190930052540.19168-1-yzhai003@ucr.edu>
References: <20190930052540.19168-1-yzhai003@ucr.edu>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 29 Sep 2019 22:25:39 -0700
Yizhuo <yzhai003@ucr.edu> wrote:

> Several functions in this file are trying to use regmap_read() to
> initialize the specific variable, however, if regmap_read() fails,
> the variable could be uninitialized but used directly, which is
> potentially unsafe. The return value of regmap_read() should be
> checked and handled.
> 
> Signed-off-by: Yizhuo <yzhai003@ucr.edu>
I haven't checked if this one has a clock, but there is a bigger issue.
See inline.

Jonathan

> ---
>  drivers/iio/adc/bcm_iproc_adc.c | 45 ++++++++++++++++++++++++++++-----
>  1 file changed, 39 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
> index 646ebdc0a8b4..6df19ceb5ff2 100644
> --- a/drivers/iio/adc/bcm_iproc_adc.c
> +++ b/drivers/iio/adc/bcm_iproc_adc.c
> @@ -137,6 +137,7 @@ static irqreturn_t iproc_adc_interrupt_thread(int irq, void *data)
>  	u32 channel_intr_status;
>  	u32 intr_status;
>  	u32 intr_mask;
> +	int ret;
>  	struct iio_dev *indio_dev = data;
>  	struct iproc_adc_priv *adc_priv = iio_priv(indio_dev);
>  
> @@ -145,8 +146,19 @@ static irqreturn_t iproc_adc_interrupt_thread(int irq, void *data)
>  	 * Make sure this interrupt is intended for us.
>  	 * Handle only ADC channel specific interrupts.
>  	 */
> -	regmap_read(adc_priv->regmap, IPROC_INTERRUPT_STATUS, &intr_status);
> -	regmap_read(adc_priv->regmap, IPROC_INTERRUPT_MASK, &intr_mask);
> +	ret = regmap_read(adc_priv->regmap,
> +					IPROC_INTERRUPT_STATUS, &intr_status);
> +	if (ret) {
> +		dev_err(&indio_dev->dev, "Fail to read IPROC_INTERRUPT_STATUS.\n");
> +		return ret;
> +	}
> +
> +	ret = regmap_read(adc_priv->regmap, IPROC_INTERRUPT_MASK, &intr_mask);
> +	if (ret) {
> +		dev_err(&indio_dev->dev, "Fail to read IPROC_INTERRUPT_MASK.\n");
> +		return ret;
> +	}
You need to be extremely careful returning error codes from interrupt routines..

Basically you can't ;)

> +
>  	intr_status = intr_status & intr_mask;
>  	channel_intr_status = (intr_status & IPROC_ADC_INTR_MASK) >>
>  				IPROC_ADC_INTR;
> @@ -162,6 +174,7 @@ static irqreturn_t iproc_adc_interrupt_handler(int irq, void *data)
>  	struct iproc_adc_priv *adc_priv;
>  	struct iio_dev *indio_dev = data;
>  	unsigned int valid_entries;
> +	int ret;
>  	u32 intr_status;
>  	u32 intr_channels;
>  	u32 channel_status;
> @@ -169,23 +182,37 @@ static irqreturn_t iproc_adc_interrupt_handler(int irq, void *data)
>  
>  	adc_priv = iio_priv(indio_dev);
>  
> -	regmap_read(adc_priv->regmap, IPROC_INTERRUPT_STATUS, &intr_status);
> +	ret = regmap_read(adc_priv->regmap,
> +					IPROC_INTERRUPT_STATUS, &intr_status);
> +	if (ret) {
> +		dev_err(&indio_dev->dev, "Fail to read IPROC_INTERRUPT_STATUS.\n");
> +		return ret;
> +	}
> +
>  	dev_dbg(&indio_dev->dev, "iproc_adc_interrupt_handler(),INTRPT_STS:%x\n",
>  			intr_status);
>  
>  	intr_channels = (intr_status & IPROC_ADC_INTR_MASK) >> IPROC_ADC_INTR;
>  	if (intr_channels) {
> -		regmap_read(adc_priv->regmap,
> +		ret = regmap_read(adc_priv->regmap,
>  			    IPROC_ADC_CHANNEL_INTERRUPT_STATUS +
>  			    IPROC_ADC_CHANNEL_OFFSET * adc_priv->chan_id,
>  			    &ch_intr_status);
> +		if (ret) {
> +			dev_err(&indio_dev->dev, "Fail to read the register.\n");
> +			return ret;
> +		}
>  
>  		if (ch_intr_status & IPROC_ADC_CHANNEL_WTRMRK_INTR_MASK) {
> -			regmap_read(adc_priv->regmap,
> +			ret = regmap_read(adc_priv->regmap,
>  					IPROC_ADC_CHANNEL_STATUS +
>  					IPROC_ADC_CHANNEL_OFFSET *
>  					adc_priv->chan_id,
>  					&channel_status);
> +			if (ret) {
> +				dev_err(&indio_dev->dev, "Fail to read the register.\n");
> +				return ret;
> +			}
>  
>  			valid_entries = ((channel_status &
>  				IPROC_ADC_CHANNEL_VALID_ENTERIES_MASK) >>
> @@ -230,6 +257,7 @@ static int iproc_adc_do_read(struct iio_dev *indio_dev,
>  	u32 mask;
>  	u32 val_check;
>  	int failed_cnt = 0;
> +	int ret;
>  	struct iproc_adc_priv *adc_priv = iio_priv(indio_dev);
>  
>  	mutex_lock(&adc_priv->mutex);
> @@ -284,7 +312,12 @@ static int iproc_adc_do_read(struct iio_dev *indio_dev,
>  	 * Testing has shown that this may loop a few time, but we have never
>  	 * hit the full count.
>  	 */
> -	regmap_read(adc_priv->regmap, IPROC_INTERRUPT_MASK, &val_check);
> +	ret = regmap_read(adc_priv->regmap, IPROC_INTERRUPT_MASK, &val_check);
> +	if (ret) {
> +		dev_err(&indio_dev->dev, "Fail to read IPROC_INTERRUPT_MASK.\n");
> +		return ret;
> +	}
> +
>  	while (val_check != val) {
>  		failed_cnt++;
>  

