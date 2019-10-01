Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 930ABC2F25
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2019 10:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfJAIro (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 1 Oct 2019 04:47:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:32910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbfJAIrn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 1 Oct 2019 04:47:43 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCB262133F;
        Tue,  1 Oct 2019 08:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569919663;
        bh=uyBPyDajI+sn8HwUlo1GdFDsnGTZSyb9f+Mmp5bEyHg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=z3Z5JLeGA1iyieSDx+569nFEbVBAfdHRApgoQIbnHRHTMXOoGYtNzuyPPkLxqvCw8
         kqfgz0ucrmmlWa0P/EvoAEDgVNXhMVI4AWka8Uk8c2truKO9Spl5Trr6wllp7lkTWK
         CwICPefl77M2mzsefxX/hYQ/u3CEWLejiCuA9FWQ=
Date:   Tue, 1 Oct 2019 09:47:35 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Enrico Weigelt <info@metux.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: imx25-gcq: fix uninitialized variable usage
Message-ID: <20191001094735.4f04bfdf@archlinux>
In-Reply-To: <20190930195358.27844-1-yzhai003@ucr.edu>
References: <20190930195358.27844-1-yzhai003@ucr.edu>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 30 Sep 2019 12:53:54 -0700
Yizhuo <yzhai003@ucr.edu> wrote:

> In function mx25_gcq_irq(), local variable "stats" could
> be uninitialized if function regmap_read() returns -EINVAL.
> However, this value is used in if statement, which is
> potentially unsafe. The same case applied to the variable
> "data" in function mx25_gcq_get_raw_value() in the same file.
> 
> Signed-off-by: Yizhuo <yzhai003@ucr.edu>

Following similar logic to the other patch I just reviewed
for the stm32-timer-trigger, lets chase if this can happen.
In this case a clock is not provided during the regmap iomem register
and as such, the call can't actually fail.

So this one is more of a tidy up and hardening against future
problems if the code changes, than an actual fix.

Worth having, but perhaps remove the word fix from the description
unless you can find a path I've missed in which this might actually
happen as the code currently is.

One minor comment inline,

Thanks,

Jonathan
> ---
>  drivers/iio/adc/fsl-imx25-gcq.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/fsl-imx25-gcq.c b/drivers/iio/adc/fsl-imx25-gcq.c
> index fa71489195c6..3b1e12b7c1ac 100644
> --- a/drivers/iio/adc/fsl-imx25-gcq.c
> +++ b/drivers/iio/adc/fsl-imx25-gcq.c
> @@ -73,8 +73,12 @@ static irqreturn_t mx25_gcq_irq(int irq, void *data)
>  {
>  	struct mx25_gcq_priv *priv = data;
>  	u32 stats;
> +	int ret;
>  
> -	regmap_read(priv->regs, MX25_ADCQ_SR, &stats);
> +	ret = regmap_read(priv->regs, MX25_ADCQ_SR, &stats);
> +	if (ret) {

No brackets around a single line block like this.

> +		return ret;
> +	}
>  
>  	if (stats & MX25_ADCQ_SR_EOQ) {
>  		regmap_update_bits(priv->regs, MX25_ADCQ_MR,
> @@ -100,6 +104,7 @@ static int mx25_gcq_get_raw_value(struct device *dev,
>  {
>  	long timeout;
>  	u32 data;
> +	int ret;
>  
>  	/* Setup the configuration we want to use */
>  	regmap_write(priv->regs, MX25_ADCQ_ITEM_7_0,
> @@ -121,7 +126,11 @@ static int mx25_gcq_get_raw_value(struct device *dev,
>  		return -ETIMEDOUT;
>  	}
>  
> -	regmap_read(priv->regs, MX25_ADCQ_FIFO, &data);
> +	ret = regmap_read(priv->regs, MX25_ADCQ_FIFO, &data);
> +	if (ret) {
> +		dev_err(dev, "Failed to read MX25_ADCQ_FIFO.\n");
> +		return ret;
> +	}
>  
>  	*val = MX25_ADCQ_FIFO_DATA(data);
>  

