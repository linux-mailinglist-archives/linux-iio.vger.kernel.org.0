Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C03FC2F50
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2019 10:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbfJAIyz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 1 Oct 2019 04:54:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:36484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726568AbfJAIyy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 1 Oct 2019 04:54:54 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4E4F2133F;
        Tue,  1 Oct 2019 08:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569920093;
        bh=szecxbNIyt9fQKdI3mGXWWqH6xc6Il8EeHjy2q22MmE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Dw4H4ZgGHfx/ZI6u+yBi43GwHZD0pDN+dtBIoa/0toBp0bJaCpdYHjNkGLCFAI9sf
         p885axzz4B5SVa572ab3PX675xVLqnNifp3CrsKEnCpiFERdRAknYwkpPY5g2i7kq1
         M36qcriDMmumSxbNIUz0jbiLSTvWluo3nA59W9Xg=
Date:   Tue, 1 Oct 2019 09:54:46 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Yizhuo <yzhai003@ucr.edu>, csong@cs.ucr.edu,
        Kate Stewart <kstewart@linuxfoundation.org>,
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
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] iio: adc: imx25-gcq: Variable could be uninitialized if
 regmap_read() fails
Message-ID: <20191001095446.17bc9cd8@archlinux>
In-Reply-To: <20190930074412.up4k6zdus4y7u4xb@pengutronix.de>
References: <20190928002852.28329-1-yzhai003@ucr.edu>
        <20190930074412.up4k6zdus4y7u4xb@pengutronix.de>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 30 Sep 2019 09:44:12 +0200
Marco Felsch <m.felsch@pengutronix.de> wrote:

> Hi Yizhuo,
> 
> thanks for your patch.
> 
> On 19-09-27 17:28, Yizhuo wrote:
> > In function mx25_gcq_irq(), local variable "stats" could
> > be uninitialized if function regmap_read() returns -EINVAL.
> > However, this value is used in if statement, which is
> > potentially unsafe. The same case applied to the variable
> > "data" in function mx25_gcq_get_raw_value() in the same file.  
> 
> IMHO the commit header should be something like: "iio: adc: imx25-gcq:
> fix uninitialized variable usage"...
> 
> and please add a fixes tag.
As with the others, before adding a fixes tag, please verify there
is an actual path to trigger this.

In this case it's an mmio regmap with no clock. For those, I'm not sure
if there is a failure path.

Still a worthwhile hardening / cleanup patch, but shouldn't be called
a fix or marked with a fixes tag because we don't want people to think
it is necessary to backport it.

Thanks,

Jonathan


> 
> > 
> > Signed-off-by: Yizhuo <yzhai003@ucr.edu>
> > ---
> >  drivers/iio/adc/fsl-imx25-gcq.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/fsl-imx25-gcq.c b/drivers/iio/adc/fsl-imx25-gcq.c
> > index df19ecae52f7..dbf3e8e85aba 100644
> > --- a/drivers/iio/adc/fsl-imx25-gcq.c
> > +++ b/drivers/iio/adc/fsl-imx25-gcq.c
> > @@ -74,7 +74,10 @@ static irqreturn_t mx25_gcq_irq(int irq, void *data)
> >  	struct mx25_gcq_priv *priv = data;
> >  	u32 stats;
> >  
> > -	regmap_read(priv->regs, MX25_ADCQ_SR, &stats);
> > +	int ret = regmap_read(priv->regs, MX25_ADCQ_SR, &stats);  
> 
> Please don't do this. First declare the variable and then use it.
> 
> Regards,
>   Marco
> 
> > +
> > +	if (ret)
> > +		return ret;
> >  
> >  	if (stats & MX25_ADCQ_SR_EOQ) {
> >  		regmap_update_bits(priv->regs, MX25_ADCQ_MR,
> > @@ -121,7 +124,10 @@ static int mx25_gcq_get_raw_value(struct device *dev,
> >  		return -ETIMEDOUT;
> >  	}
> >  
> > -	regmap_read(priv->regs, MX25_ADCQ_FIFO, &data);
> > +	int ret = regmap_read(priv->regs, MX25_ADCQ_FIFO, &data);
> > +
> > +	if (ret)
> > +		return ret;
> >  
> >  	*val = MX25_ADCQ_FIFO_DATA(data);
> >  
> > -- 
> > 2.17.1
> > 
> > 
> >   
> 

