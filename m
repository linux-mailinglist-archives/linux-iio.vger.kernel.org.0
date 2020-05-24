Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6837B1DFF0F
	for <lists+linux-iio@lfdr.de>; Sun, 24 May 2020 15:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbgEXNNL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 24 May 2020 09:13:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:55266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbgEXNNL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 May 2020 09:13:11 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FBBF20787;
        Sun, 24 May 2020 13:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590325990;
        bh=Lcf8VBXRWwR3/d5jNdn1zKLq0hrW94IIhtTMeUpk/Qs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=l1OWd1cNWrdKlfgLyXcpYOANbARyD0Y9kAt+VzDNhgMP0eS8/7ABU3I5iCG6h+qDz
         bVYT7R1FYK63LqRNYu7h+asIZiDJk/JvTfNC1LIyeBEZSVdcYjQXqh9amWdWeBpFDA
         9zyZVPsk0iMy26L1lnYYMwnPNwhr6eGhxeR01ELc=
Date:   Sun, 24 May 2020 14:13:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>
Subject: Re: [PATCH] iio: stm32-dfsdm-adc: keep a reference to the iio
 device on the state struct
Message-ID: <20200524141306.139d7433@archlinux>
In-Reply-To: <20200522130804.631508-1-alexandru.ardelean@analog.com>
References: <20200522130804.631508-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 22 May 2020 16:08:04 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> We may want to get rid of the iio_priv_to_dev() helper. The reason is that
> we will hide some of the members of the iio_dev structure (to prevent
> drivers from accessing them directly), and that will also mean hiding the
> implementation of the iio_priv_to_dev() helper inside the IIO core.
> 
> Hiding the implementation of iio_priv_to_dev() implies that some fast-paths
> may not be fast anymore, so a general idea is to try to get rid of the
> iio_priv_to_dev() altogether.
> The iio_priv() helper won't be affected by the rework.
> 
> For this driver, not using iio_priv_to_dev(), means keeping a reference to
> the IIO device on the state struct.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

As this one is a bit simpler, I think the case for just changing the callbacks
to take the iio_dev directly is stronger than adding this level of indirection.

Again, perhaps I'm missing something.

Jonathan

> ---
>  drivers/iio/adc/stm32-dfsdm-adc.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
> index 76a60d93fe23..ff7a6afa4558 100644
> --- a/drivers/iio/adc/stm32-dfsdm-adc.c
> +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
> @@ -69,6 +69,7 @@ struct stm32_dfsdm_dev_data {
>  
>  struct stm32_dfsdm_adc {
>  	struct stm32_dfsdm *dfsdm;
> +	struct iio_dev *indio_dev;
>  	const struct stm32_dfsdm_dev_data *dev_data;
>  	unsigned int fl_id;
>  	unsigned int nconv;
> @@ -332,7 +333,7 @@ static int stm32_dfsdm_compute_all_osrs(struct iio_dev *indio_dev,
>  
>  static int stm32_dfsdm_start_channel(struct stm32_dfsdm_adc *adc)
>  {
> -	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
> +	struct iio_dev *indio_dev = adc->indio_dev;
>  	struct regmap *regmap = adc->dfsdm->regmap;
>  	const struct iio_chan_spec *chan;
>  	unsigned int bit;
> @@ -352,7 +353,7 @@ static int stm32_dfsdm_start_channel(struct stm32_dfsdm_adc *adc)
>  
>  static void stm32_dfsdm_stop_channel(struct stm32_dfsdm_adc *adc)
>  {
> -	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
> +	struct iio_dev *indio_dev = adc->indio_dev;
>  	struct regmap *regmap = adc->dfsdm->regmap;
>  	const struct iio_chan_spec *chan;
>  	unsigned int bit;
> @@ -422,7 +423,7 @@ static int stm32_dfsdm_filter_set_trig(struct stm32_dfsdm_adc *adc,
>  				       unsigned int fl_id,
>  				       struct iio_trigger *trig)
>  {
> -	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
> +	struct iio_dev *indio_dev = adc->indio_dev;
>  	struct regmap *regmap = adc->dfsdm->regmap;
>  	u32 jextsel = 0, jexten = STM32_DFSDM_JEXTEN_DISABLED;
>  	int ret;
> @@ -451,7 +452,7 @@ static int stm32_dfsdm_channels_configure(struct stm32_dfsdm_adc *adc,
>  					  unsigned int fl_id,
>  					  struct iio_trigger *trig)
>  {
> -	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
> +	struct iio_dev *indio_dev = adc->indio_dev;
>  	struct regmap *regmap = adc->dfsdm->regmap;
>  	struct stm32_dfsdm_filter *fl = &adc->dfsdm->fl_list[fl_id];
>  	struct stm32_dfsdm_filter_osr *flo = &fl->flo[0];
> @@ -495,7 +496,7 @@ static int stm32_dfsdm_filter_configure(struct stm32_dfsdm_adc *adc,
>  					unsigned int fl_id,
>  					struct iio_trigger *trig)
>  {
> -	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
> +	struct iio_dev *indio_dev = adc->indio_dev;
>  	struct regmap *regmap = adc->dfsdm->regmap;
>  	struct stm32_dfsdm_filter *fl = &adc->dfsdm->fl_list[fl_id];
>  	struct stm32_dfsdm_filter_osr *flo = &fl->flo[fl->fast];
> @@ -1314,7 +1315,7 @@ static const struct iio_info stm32_dfsdm_info_adc = {
>  static irqreturn_t stm32_dfsdm_irq(int irq, void *arg)
>  {
>  	struct stm32_dfsdm_adc *adc = arg;
> -	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
> +	struct iio_dev *indio_dev = adc->indio_dev;
>  	struct regmap *regmap = adc->dfsdm->regmap;
>  	unsigned int status, int_en;
>  
> @@ -1569,6 +1570,7 @@ static int stm32_dfsdm_adc_probe(struct platform_device *pdev)
>  
>  	adc = iio_priv(iio);
>  	adc->dfsdm = dev_get_drvdata(dev->parent);
> +	adc->indio_dev = iio;
>  
>  	iio->dev.parent = dev;
>  	iio->dev.of_node = np;
> @@ -1651,7 +1653,7 @@ static int stm32_dfsdm_adc_probe(struct platform_device *pdev)
>  static int stm32_dfsdm_adc_remove(struct platform_device *pdev)
>  {
>  	struct stm32_dfsdm_adc *adc = platform_get_drvdata(pdev);
> -	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
> +	struct iio_dev *indio_dev = adc->indio_dev;
>  
>  	if (adc->dev_data->type == DFSDM_AUDIO)
>  		of_platform_depopulate(&pdev->dev);
> @@ -1664,7 +1666,7 @@ static int stm32_dfsdm_adc_remove(struct platform_device *pdev)
>  static int __maybe_unused stm32_dfsdm_adc_suspend(struct device *dev)
>  {
>  	struct stm32_dfsdm_adc *adc = dev_get_drvdata(dev);
> -	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
> +	struct iio_dev *indio_dev = adc->indio_dev;
>  
>  	if (iio_buffer_enabled(indio_dev))
>  		__stm32_dfsdm_predisable(indio_dev);
> @@ -1675,7 +1677,7 @@ static int __maybe_unused stm32_dfsdm_adc_suspend(struct device *dev)
>  static int __maybe_unused stm32_dfsdm_adc_resume(struct device *dev)
>  {
>  	struct stm32_dfsdm_adc *adc = dev_get_drvdata(dev);
> -	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
> +	struct iio_dev *indio_dev = adc->indio_dev;
>  	const struct iio_chan_spec *chan;
>  	struct stm32_dfsdm_channel *ch;
>  	int i, ret;

