Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0AB26C689
	for <lists+linux-iio@lfdr.de>; Wed, 16 Sep 2020 19:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbgIPRxF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Sep 2020 13:53:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:43374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727294AbgIPRwg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 16 Sep 2020 13:52:36 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DA05206F7;
        Wed, 16 Sep 2020 17:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600278755;
        bh=qtv1VH/lpDHNP4K1hT8rAdmDRzl6jlj/EIejRq6sqbM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JrVlBOLxNcilm6sLhM9bAJJOwFcJcdsVCk8k8N5S1f2dOztgBjoFniBlVcxNGf07N
         ikMhBD9w4QtsOnVMbBvdBylxMa6WEdZ6zney8xAm8/+iu+wtHo0f4vHzypodHRsz9Y
         O8b76NNvKUPPw+pgOy5YlKh+MBvOVrP/lU5aPFnM=
Date:   Wed, 16 Sep 2020 18:52:30 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <olivier.moysan@st.com>,
        Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Subject: Re: [PATCH v2] iio: stm32-dac: Replace indio_dev->mlock with own
 device lock
Message-ID: <20200916185230.45c0b7d4@archlinux>
In-Reply-To: <b8d5cbb5-f393-6a5f-19cd-afa983b9f10a@st.com>
References: <20200826063850.47625-1-alexandru.ardelean@analog.com>
        <20200916092349.75647-1-alexandru.ardelean@analog.com>
        <b8d5cbb5-f393-6a5f-19cd-afa983b9f10a@st.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 16 Sep 2020 12:18:02 +0200
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> On 9/16/20 11:23 AM, Alexandru Ardelean wrote:
> > From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> > 
> > As part of the general cleanup of indio_dev->mlock, this change replaces
> > it with a local lock. The lock protects against potential races when
> > reading the CR reg and then updating, so that the state of pm_runtime
> > is consistent between the two operations.
> > 
> > This is part of a bigger cleanup.
> > Link: https://lore.kernel.org/linux-iio/CA+U=Dsoo6YABe5ODLp+eFNPGFDjk5ZeQEceGkqjxXcVEhLWubw@mail.gmail.com/
> > 
> > Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > ---
> >  drivers/iio/dac/stm32-dac.c | 13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)  
> 
> Hi Alexandru,
> 
> Many thanks for this updated patch,
> 
> Reviewed-by: Fabrice Gasnier <fabrice.gasnier@st.com>

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to poke at it.

Thanks,

Jonathan

> 
> Best regards,
> Fabrice
> 
> > 
> > diff --git a/drivers/iio/dac/stm32-dac.c b/drivers/iio/dac/stm32-dac.c
> > index 092c796fa3d9..12dec68c16f7 100644
> > --- a/drivers/iio/dac/stm32-dac.c
> > +++ b/drivers/iio/dac/stm32-dac.c
> > @@ -26,9 +26,12 @@
> >  /**
> >   * struct stm32_dac - private data of DAC driver
> >   * @common:		reference to DAC common data
> > + * @lock:		lock to protect against potential races when reading
> > + *			and update CR, to keep it in sync with pm_runtime
> >   */
> >  struct stm32_dac {
> >  	struct stm32_dac_common *common;
> > +	struct mutex		lock;
> >  };
> >  
> >  static int stm32_dac_is_enabled(struct iio_dev *indio_dev, int channel)
> > @@ -58,10 +61,10 @@ static int stm32_dac_set_enable_state(struct iio_dev *indio_dev, int ch,
> >  	int ret;
> >  
> >  	/* already enabled / disabled ? */
> > -	mutex_lock(&indio_dev->mlock);
> > +	mutex_lock(&dac->lock);
> >  	ret = stm32_dac_is_enabled(indio_dev, ch);
> >  	if (ret < 0 || enable == !!ret) {
> > -		mutex_unlock(&indio_dev->mlock);
> > +		mutex_unlock(&dac->lock);
> >  		return ret < 0 ? ret : 0;
> >  	}
> >  
> > @@ -69,13 +72,13 @@ static int stm32_dac_set_enable_state(struct iio_dev *indio_dev, int ch,
> >  		ret = pm_runtime_get_sync(dev);
> >  		if (ret < 0) {
> >  			pm_runtime_put_noidle(dev);
> > -			mutex_unlock(&indio_dev->mlock);
> > +			mutex_unlock(&dac->lock);
> >  			return ret;
> >  		}
> >  	}
> >  
> >  	ret = regmap_update_bits(dac->common->regmap, STM32_DAC_CR, msk, en);
> > -	mutex_unlock(&indio_dev->mlock);
> > +	mutex_unlock(&dac->lock);
> >  	if (ret < 0) {
> >  		dev_err(&indio_dev->dev, "%s failed\n", en ?
> >  			"Enable" : "Disable");
> > @@ -327,6 +330,8 @@ static int stm32_dac_probe(struct platform_device *pdev)
> >  	indio_dev->info = &stm32_dac_iio_info;
> >  	indio_dev->modes = INDIO_DIRECT_MODE;
> >  
> > +	mutex_init(&dac->lock);
> > +
> >  	ret = stm32_dac_chan_of_init(indio_dev);
> >  	if (ret < 0)
> >  		return ret;
> >   

