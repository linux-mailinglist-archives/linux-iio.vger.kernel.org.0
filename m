Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA83F26E385
	for <lists+linux-iio@lfdr.de>; Thu, 17 Sep 2020 20:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgIQS2F (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 17 Sep 2020 14:28:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:33988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726540AbgIQS1p (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 17 Sep 2020 14:27:45 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBD52221EE;
        Thu, 17 Sep 2020 18:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600367264;
        bh=x0yrJojLX0QmfsidGFj/TCRgWQNWYafkq8OmMlqEjGo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=btOwzNo+fZeau3dTn6RXwQa+SS26dR/NKoQ00xDO6Z6SDvWshmUBL24SqVqrjP0YV
         ch20VqkkdQX8ZaEtm+t48MKWGTkGUXtsr+Q61GED7+ASnuJNQkWeXtAuibtlgW6uYR
         rfDrWi9v43RZgAWuORQ28FD9xnfvAtBLeTAKaxCw=
Date:   Thu, 17 Sep 2020 19:27:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-imx@nxp.com>,
        <festevam@gmail.com>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
        Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Subject: Re: [PATCH v2] iio: adc: fsl-imx25-gcq: Replace indio_dev->mlock
 with own device lock
Message-ID: <20200917192739.38a13ae0@archlinux>
In-Reply-To: <20200916092928.78026-1-alexandru.ardelean@analog.com>
References: <20200826120609.203724-1-alexandru.ardelean@analog.com>
        <20200916092928.78026-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 16 Sep 2020 12:29:28 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> 
> As part of the general cleanup of indio_dev->mlock, this change replaces
> it with a local lock, to protect against any other accesses during the
> reading of sample. Reading a sample requires multiple consecutive regmap
> operations and a completion callback, so this requires that no other
> read occurs until it completes.
> 
> This is part of a bigger cleanup.
> Link: https://lore.kernel.org/linux-iio/CA+U=Dsoo6YABe5ODLp+eFNPGFDjk5ZeQEceGkqjxXcVEhLWubw@mail.gmail.com/
> 
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
This seems simple enough so I've applied it to the togreg branch of iio.git

Thanks,

Jonathan

> ---
>  drivers/iio/adc/fsl-imx25-gcq.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/fsl-imx25-gcq.c b/drivers/iio/adc/fsl-imx25-gcq.c
> index 8cb51cf7a816..ab5139e911c3 100644
> --- a/drivers/iio/adc/fsl-imx25-gcq.c
> +++ b/drivers/iio/adc/fsl-imx25-gcq.c
> @@ -40,6 +40,15 @@ struct mx25_gcq_priv {
>  	int irq;
>  	struct regulator *vref[4];
>  	u32 channel_vref_mv[MX25_NUM_CFGS];
> +	/*
> +	 * Lock to protect the device state during a potential concurrent
> +	 * read access from userspace. Reading a raw value requires a sequence
> +	 * of register writes, then a wait for a completion callback,
> +	 * and finally a register read, during which userspace could issue
> +	 * another read request. This lock protects a read access from
> +	 * ocurring before another one has finished.
> +	 */
> +	struct mutex lock;
>  };
>  
>  #define MX25_CQG_CHAN(chan, id) {\
> @@ -137,9 +146,9 @@ static int mx25_gcq_read_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		mutex_lock(&indio_dev->mlock);
> +		mutex_lock(&priv->lock);
>  		ret = mx25_gcq_get_raw_value(&indio_dev->dev, chan, priv, val);
> -		mutex_unlock(&indio_dev->mlock);
> +		mutex_unlock(&priv->lock);
>  		return ret;
>  
>  	case IIO_CHAN_INFO_SCALE:
> @@ -314,6 +323,8 @@ static int mx25_gcq_probe(struct platform_device *pdev)
>  		return PTR_ERR(priv->regs);
>  	}
>  
> +	mutex_init(&priv->lock);
> +
>  	init_completion(&priv->completed);
>  
>  	ret = mx25_gcq_setup_cfgs(pdev, priv);

