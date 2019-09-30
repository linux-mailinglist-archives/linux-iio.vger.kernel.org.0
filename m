Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC471C1C36
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2019 09:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbfI3Hoa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Sep 2019 03:44:30 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37063 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfI3Hoa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Sep 2019 03:44:30 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iEqLy-0006Cg-VU; Mon, 30 Sep 2019 09:44:18 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1iEqLs-0000i1-B9; Mon, 30 Sep 2019 09:44:12 +0200
Date:   Mon, 30 Sep 2019 09:44:12 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, Kate Stewart <kstewart@linuxfoundation.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>, zhiyunq@cs.ucr.edu,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] iio: adc: imx25-gcq: Variable could be uninitialized if
 regmap_read() fails
Message-ID: <20190930074412.up4k6zdus4y7u4xb@pengutronix.de>
References: <20190928002852.28329-1-yzhai003@ucr.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190928002852.28329-1-yzhai003@ucr.edu>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:37:13 up 135 days, 13:55, 87 users,  load average: 0.06, 0.15,
 0.15
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Yizhuo,

thanks for your patch.

On 19-09-27 17:28, Yizhuo wrote:
> In function mx25_gcq_irq(), local variable "stats" could
> be uninitialized if function regmap_read() returns -EINVAL.
> However, this value is used in if statement, which is
> potentially unsafe. The same case applied to the variable
> "data" in function mx25_gcq_get_raw_value() in the same file.

IMHO the commit header should be something like: "iio: adc: imx25-gcq:
fix uninitialized variable usage"...

and please add a fixes tag.

> 
> Signed-off-by: Yizhuo <yzhai003@ucr.edu>
> ---
>  drivers/iio/adc/fsl-imx25-gcq.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/fsl-imx25-gcq.c b/drivers/iio/adc/fsl-imx25-gcq.c
> index df19ecae52f7..dbf3e8e85aba 100644
> --- a/drivers/iio/adc/fsl-imx25-gcq.c
> +++ b/drivers/iio/adc/fsl-imx25-gcq.c
> @@ -74,7 +74,10 @@ static irqreturn_t mx25_gcq_irq(int irq, void *data)
>  	struct mx25_gcq_priv *priv = data;
>  	u32 stats;
>  
> -	regmap_read(priv->regs, MX25_ADCQ_SR, &stats);
> +	int ret = regmap_read(priv->regs, MX25_ADCQ_SR, &stats);

Please don't do this. First declare the variable and then use it.

Regards,
  Marco

> +
> +	if (ret)
> +		return ret;
>  
>  	if (stats & MX25_ADCQ_SR_EOQ) {
>  		regmap_update_bits(priv->regs, MX25_ADCQ_MR,
> @@ -121,7 +124,10 @@ static int mx25_gcq_get_raw_value(struct device *dev,
>  		return -ETIMEDOUT;
>  	}
>  
> -	regmap_read(priv->regs, MX25_ADCQ_FIFO, &data);
> +	int ret = regmap_read(priv->regs, MX25_ADCQ_FIFO, &data);
> +
> +	if (ret)
> +		return ret;
>  
>  	*val = MX25_ADCQ_FIFO_DATA(data);
>  
> -- 
> 2.17.1
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
