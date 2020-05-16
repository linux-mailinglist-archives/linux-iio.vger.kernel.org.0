Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBE61D621F
	for <lists+linux-iio@lfdr.de>; Sat, 16 May 2020 17:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgEPPgw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 May 2020 11:36:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:38622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbgEPPgw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 May 2020 11:36:52 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FAC520727;
        Sat, 16 May 2020 15:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589643411;
        bh=zfBU1IWpkQBvNmTBIKKrHwm1RzQ5E2IL5ncgKrz/5Sg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MZGF+892d2LsFM0NMl4IIElfgRPC73dcp4ko+QetcoSa84mAJleGJY/h1t9n4TyZ+
         E/VxqIIvOIN/nYahMCpi6JK3iagjRmfzBvByOwc4/psnRDFn3RR4NhVxTaRvWSVEyW
         bi1hqkbpPDw68pJPQhg8evCvPnmPWhuxrwJd6fLA=
Date:   Sat, 16 May 2020 16:36:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] iio: dac: vf610_dac: Replace indio_dev->mlock with own
 device lock
Message-ID: <20200516163647.5e3b7415@archlinux>
In-Reply-To: <20200514085835.80275-1-sergiu.cuciurean@analog.com>
References: <20200514085835.80275-1-sergiu.cuciurean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 14 May 2020 11:58:15 +0300
Sergiu Cuciurean <sergiu.cuciurean@analog.com> wrote:

> As part of the general cleanup of indio_dev->mlock, this change replaces
> it with a local lock on the device's state structure.
> 
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>

Applied, thanks,

Jonathan

> ---
>  drivers/iio/dac/vf610_dac.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/dac/vf610_dac.c b/drivers/iio/dac/vf610_dac.c
> index 71f8a5c471c4..c1e15ede0e8e 100644
> --- a/drivers/iio/dac/vf610_dac.c
> +++ b/drivers/iio/dac/vf610_dac.c
> @@ -36,6 +36,7 @@ struct vf610_dac {
>  	struct device *dev;
>  	enum vf610_conversion_mode_sel conv_mode;
>  	void __iomem *regs;
> +	struct mutex lock;
>  };
>  
>  static void vf610_dac_init(struct vf610_dac *info)
> @@ -64,7 +65,7 @@ static int vf610_set_conversion_mode(struct iio_dev *indio_dev,
>  	struct vf610_dac *info = iio_priv(indio_dev);
>  	int val;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&info->lock);
>  	info->conv_mode = mode;
>  	val = readl(info->regs + VF610_DACx_STATCTRL);
>  	if (mode)
> @@ -72,7 +73,7 @@ static int vf610_set_conversion_mode(struct iio_dev *indio_dev,
>  	else
>  		val &= ~VF610_DAC_LPEN;
>  	writel(val, info->regs + VF610_DACx_STATCTRL);
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&info->lock);
>  
>  	return 0;
>  }
> @@ -147,9 +148,9 @@ static int vf610_write_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		mutex_lock(&indio_dev->mlock);
> +		mutex_lock(&info->lock);
>  		writel(VF610_DAC_DAT0(val), info->regs);
> -		mutex_unlock(&indio_dev->mlock);
> +		mutex_unlock(&info->lock);
>  		return 0;
>  
>  	default:
> @@ -205,6 +206,8 @@ static int vf610_dac_probe(struct platform_device *pdev)
>  	indio_dev->channels = vf610_dac_iio_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(vf610_dac_iio_channels);
>  
> +	mutex_init(&info->lock);
> +
>  	ret = clk_prepare_enable(info->clk);
>  	if (ret) {
>  		dev_err(&pdev->dev,

