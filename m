Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0947CCF7E
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2019 10:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfJFIqV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Oct 2019 04:46:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:46984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbfJFIqV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Oct 2019 04:46:21 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A61C82084B;
        Sun,  6 Oct 2019 08:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570351580;
        bh=hf30g4d8JZ11GzLvpR7H04sV2GMkhrx+p1kiP+B0azY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2LJ+/zh5VABr02frYcHGE7Cc46uW0q0IKteroMEn73P2ECn2ICmzlgpsOFSLKctp2
         zLKV8U+y5hyjtjhfAb5xe5WQ2CmbBydYwZn974xqBBCx1dyM8g3HTy2EslMEloE7hK
         5zjQtRSWmcIia/Xlv4Zh5FcSjJvGPkn2HQfqJ5D8=
Date:   Sun, 6 Oct 2019 09:46:15 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Colin King <colin.king@canonical.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: stm32: clean up indentation issue
Message-ID: <20191006094615.5b798a42@archlinux>
In-Reply-To: <20191005173004.GA7431@icarus>
References: <20190925095126.20219-1-colin.king@canonical.com>
        <20191005173004.GA7431@icarus>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 5 Oct 2019 13:30:04 -0400
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> On Wed, Sep 25, 2019 at 10:51:26AM +0100, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > There is an if statement that is indented one level too deeply,
> > remove the extraneous tabs.
> > 
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >  drivers/counter/stm32-timer-cnt.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
> > index 644ba18a72ad..613dcccf79e1 100644
> > --- a/drivers/counter/stm32-timer-cnt.c
> > +++ b/drivers/counter/stm32-timer-cnt.c
> > @@ -219,8 +219,8 @@ static ssize_t stm32_count_enable_write(struct counter_device *counter,
> >  
> >  	if (enable) {
> >  		regmap_read(priv->regmap, TIM_CR1, &cr1);
> > -			if (!(cr1 & TIM_CR1_CEN))
> > -				clk_enable(priv->clk);
> > +		if (!(cr1 & TIM_CR1_CEN))
> > +			clk_enable(priv->clk);
> >  
> >  		regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN,
> >  				   TIM_CR1_CEN);
> > -- 
> > 2.20.1  
> 
> Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to poke it.

Thanks,

Jonathan

> 
> Fabrice,
> 
> I noticed the TIM_CR1_CEN check is happening before the
> regmap_update_bits call for the enable path, while the disable path does
> the check after. Is this logic is correct.
> 
> William Breathitt Gray

