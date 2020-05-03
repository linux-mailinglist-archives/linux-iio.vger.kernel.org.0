Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 430731C2CB1
	for <lists+linux-iio@lfdr.de>; Sun,  3 May 2020 15:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbgECNRc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 May 2020 09:17:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:42690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728378AbgECNRc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 May 2020 09:17:32 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CB112084D;
        Sun,  3 May 2020 13:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588511851;
        bh=c41wwaPkMaPx/AbXYXAvHUbp8vk80alaoAI0zA7NCnc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Lp9ZTBlCE+wgj799vIc0GTuXkNxuIRSOL5IdIK2d+0gt4Ekgk7z8vrOWCIlxqyPSG
         QwOxMYR+YGl0Fg1MuRgRFvGjmf45V982vxk/Ye96NHuz2VsDn3iQjCmRKWIaHioSKN
         ZPhyr1ub+1OSTRFeiQEIcEcutXxUSqdLEQqSLE0c=
Date:   Sun, 3 May 2020 14:17:27 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <olivier.moysan@st.com>,
        <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH] iio: adc: stm32-dfsdm: fix device used to request dma
Message-ID: <20200503141727.13269ac2@archlinux>
In-Reply-To: <1588238926-23964-2-git-send-email-fabrice.gasnier@st.com>
References: <1588238926-23964-1-git-send-email-fabrice.gasnier@st.com>
        <1588238926-23964-2-git-send-email-fabrice.gasnier@st.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 30 Apr 2020 11:28:46 +0200
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> DMA channel request should use device struct from platform device struct.
> Currently it's using iio device struct. But at this stage when probing,
> device struct isn't yet registered (e.g. device_register is done in
> iio_device_register). Since commit 71723a96b8b1 ("dmaengine: Create
> symlinks between DMA channels and slaves"), a warning message is printed
> as the links in sysfs can't be created, due to device isn't yet registered:
> - Cannot create DMA slave symlink
> - Cannot create DMA dma:rx symlink
> 
> Fix this by using device struct from platform device to request dma chan.
> 
> Fixes: eca949800d2d ("IIO: ADC: add stm32 DFSDM support for PDM microphone")
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>

Both applied to the fixes-togreg branch of iio.git and marked for stable.

THanks,

Jonathan

> ---
>  drivers/iio/adc/stm32-dfsdm-adc.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
> index 76a60d9..506bf51 100644
> --- a/drivers/iio/adc/stm32-dfsdm-adc.c
> +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
> @@ -62,7 +62,7 @@ enum sd_converter_type {
>  
>  struct stm32_dfsdm_dev_data {
>  	int type;
> -	int (*init)(struct iio_dev *indio_dev);
> +	int (*init)(struct device *dev, struct iio_dev *indio_dev);
>  	unsigned int num_channels;
>  	const struct regmap_config *regmap_cfg;
>  };
> @@ -1365,11 +1365,12 @@ static void stm32_dfsdm_dma_release(struct iio_dev *indio_dev)
>  	}
>  }
>  
> -static int stm32_dfsdm_dma_request(struct iio_dev *indio_dev)
> +static int stm32_dfsdm_dma_request(struct device *dev,
> +				   struct iio_dev *indio_dev)
>  {
>  	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
>  
> -	adc->dma_chan = dma_request_chan(&indio_dev->dev, "rx");
> +	adc->dma_chan = dma_request_chan(dev, "rx");
>  	if (IS_ERR(adc->dma_chan)) {
>  		int ret = PTR_ERR(adc->dma_chan);
>  
> @@ -1425,7 +1426,7 @@ static int stm32_dfsdm_adc_chan_init_one(struct iio_dev *indio_dev,
>  					  &adc->dfsdm->ch_list[ch->channel]);
>  }
>  
> -static int stm32_dfsdm_audio_init(struct iio_dev *indio_dev)
> +static int stm32_dfsdm_audio_init(struct device *dev, struct iio_dev *indio_dev)
>  {
>  	struct iio_chan_spec *ch;
>  	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
> @@ -1452,10 +1453,10 @@ static int stm32_dfsdm_audio_init(struct iio_dev *indio_dev)
>  	indio_dev->num_channels = 1;
>  	indio_dev->channels = ch;
>  
> -	return stm32_dfsdm_dma_request(indio_dev);
> +	return stm32_dfsdm_dma_request(dev, indio_dev);
>  }
>  
> -static int stm32_dfsdm_adc_init(struct iio_dev *indio_dev)
> +static int stm32_dfsdm_adc_init(struct device *dev, struct iio_dev *indio_dev)
>  {
>  	struct iio_chan_spec *ch;
>  	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
> @@ -1499,17 +1500,17 @@ static int stm32_dfsdm_adc_init(struct iio_dev *indio_dev)
>  	init_completion(&adc->completion);
>  
>  	/* Optionally request DMA */
> -	ret = stm32_dfsdm_dma_request(indio_dev);
> +	ret = stm32_dfsdm_dma_request(dev, indio_dev);
>  	if (ret) {
>  		if (ret != -ENODEV) {
>  			if (ret != -EPROBE_DEFER)
> -				dev_err(&indio_dev->dev,
> +				dev_err(dev,
>  					"DMA channel request failed with %d\n",
>  					ret);
>  			return ret;
>  		}
>  
> -		dev_dbg(&indio_dev->dev, "No DMA support\n");
> +		dev_dbg(dev, "No DMA support\n");
>  		return 0;
>  	}
>  
> @@ -1622,7 +1623,7 @@ static int stm32_dfsdm_adc_probe(struct platform_device *pdev)
>  		adc->dfsdm->fl_list[adc->fl_id].sync_mode = val;
>  
>  	adc->dev_data = dev_data;
> -	ret = dev_data->init(iio);
> +	ret = dev_data->init(dev, iio);
>  	if (ret < 0)
>  		return ret;
>  

