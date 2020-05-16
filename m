Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 235481D6305
	for <lists+linux-iio@lfdr.de>; Sat, 16 May 2020 19:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgEPRVi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 May 2020 13:21:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:48550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726257AbgEPRVi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 May 2020 13:21:38 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 872FF2065C;
        Sat, 16 May 2020 17:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589649697;
        bh=E7aJfRYTPqnzUYF0jUB/Z7E0AkaqB7I5mvXPP1NvKLU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NIjlWLwcVz+dtLu9dYyJRabC3U+b6Wao6I6WeWZ4h6B19HoMmDOEfPhW/Q8Oka7Z1
         H4rKdHytyXZS4p2Eui+gZA1Acost9MUGJcPYelrKABTJN6ZEQUxJMnnujhSJR9ccA7
         RO20EpEY2+gqaDMVnDsEn4bx+zLiU4TG9Yfb61aE=
Date:   Sat, 16 May 2020 18:21:32 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <ludovic.desroches@microchip.com>,
        <eugen.hristev@microchip.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <alexandre.torgue@st.com>,
        <mcoquelin.stm32@gmail.com>, <ak@it-klinger.de>
Subject: Re: [PATCH v2 5/8] iio: stm32-adc: pass iio device as arg for the
 interrupt handler
Message-ID: <20200516182132.0d8ed09b@archlinux>
In-Reply-To: <20200514131710.84201-6-alexandru.ardelean@analog.com>
References: <20200514131710.84201-1-alexandru.ardelean@analog.com>
        <20200514131710.84201-6-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 14 May 2020 16:17:07 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> This changes the argument for the interrupt handler to be the IIO device
> instead of the state-struct.
> Since there will be some changes to how iio_priv_to_dev() is implemented,
> it could be that the helper becomes a bit slower, as it will be hidden away
> in the IIO core.
> 
> The iio_priv() call will still be fast enough, as it will return a void
> pointer from the public IIO device structure. So it's better to switch the
> order.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
As with previous patch - looks good to me, but I'd like an stm32
Ack / review.

thanks,

Jonathan

> ---
>  drivers/iio/adc/stm32-adc.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index 80c3f963527b..34885387fbdb 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -1227,8 +1227,8 @@ static int stm32_adc_read_raw(struct iio_dev *indio_dev,
>  
>  static irqreturn_t stm32_adc_threaded_isr(int irq, void *data)
>  {
> -	struct stm32_adc *adc = data;
> -	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
> +	struct iio_dev *indio_dev = data;
> +	struct stm32_adc *adc = iio_priv(indio_dev);
>  	const struct stm32_adc_regspec *regs = adc->cfg->regs;
>  	u32 status = stm32_adc_readl(adc, regs->isr_eoc.reg);
>  
> @@ -1240,8 +1240,8 @@ static irqreturn_t stm32_adc_threaded_isr(int irq, void *data)
>  
>  static irqreturn_t stm32_adc_isr(int irq, void *data)
>  {
> -	struct stm32_adc *adc = data;
> -	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
> +	struct iio_dev *indio_dev = data;
> +	struct stm32_adc *adc = iio_priv(indio_dev);
>  	const struct stm32_adc_regspec *regs = adc->cfg->regs;
>  	u32 status = stm32_adc_readl(adc, regs->isr_eoc.reg);
>  
> @@ -1882,7 +1882,7 @@ static int stm32_adc_probe(struct platform_device *pdev)
>  
>  	ret = devm_request_threaded_irq(&pdev->dev, adc->irq, stm32_adc_isr,
>  					stm32_adc_threaded_isr,
> -					0, pdev->name, adc);
> +					0, pdev->name, indio_dev);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to request IRQ\n");
>  		return ret;

