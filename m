Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51E602568AA
	for <lists+linux-iio@lfdr.de>; Sat, 29 Aug 2020 17:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbgH2P3Q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Aug 2020 11:29:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:45972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728235AbgH2P3P (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 29 Aug 2020 11:29:15 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E96220707;
        Sat, 29 Aug 2020 15:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598714954;
        bh=RAU2WGOhvq2URERSZLQaFJ42fOzyVnlaF9adY9/UjmA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xN1U/q8QV8Y9/BF2SlB6nga5fAAJEPr4h+Aq+WCWm9H9z3/b8njZRvTlEppVHOxUm
         Bz8YsBZGeJUDWCp0BPFMXbbhAaP8Ow3l8zNH7T2mYCQXIJUQZutFCYAuGDxZDUTKSS
         DXKqxlmnIa1MyVZleWSejSCqPXtQBnI+ZDE6Eb3s=
Date:   Sat, 29 Aug 2020 16:29:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <shawnguo@kernel.org>, <s.hauer@pengutronix.de>,
        Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Subject: Re: [PATCH] iio: adc: fsl-imx25-gcq: Replace indio_dev->mlock with
 own device lock
Message-ID: <20200829162910.379c1a87@archlinux>
In-Reply-To: <20200826120609.203724-1-alexandru.ardelean@analog.com>
References: <20200826120609.203724-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 26 Aug 2020 15:06:09 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> 
> As part of the general cleanup of indio_dev->mlock, this change replaces
> it with a local lock, to protect against any other accesses during the
> reading of sample. Reading a sample requires multiple consecutive regmap
> operations and a completion callback, so this requires that no other
> read occurs until it completes.
> 
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  drivers/iio/adc/fsl-imx25-gcq.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/fsl-imx25-gcq.c b/drivers/iio/adc/fsl-imx25-gcq.c
> index 8cb51cf7a816..2a56ed0fc793 100644
> --- a/drivers/iio/adc/fsl-imx25-gcq.c
> +++ b/drivers/iio/adc/fsl-imx25-gcq.c
> @@ -38,6 +38,7 @@ struct mx25_gcq_priv {
>  	struct completion completed;
>  	struct clk *clk;
>  	int irq;
> +	struct mutex lock;

Rule 1 of locks. Every single one need documentation so that the
scope that the lock protects is clearly stated.

Otherwise patch looks fine to me.

thanks,

Jonathan


>  	struct regulator *vref[4];
>  	u32 channel_vref_mv[MX25_NUM_CFGS];
>  };
> @@ -137,9 +138,9 @@ static int mx25_gcq_read_raw(struct iio_dev *indio_dev,
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
> @@ -314,6 +315,8 @@ static int mx25_gcq_probe(struct platform_device *pdev)
>  		return PTR_ERR(priv->regs);
>  	}
>  
> +	mutex_init(&priv->lock);
> +
>  	init_completion(&priv->completed);
>  
>  	ret = mx25_gcq_setup_cfgs(pdev, priv);

