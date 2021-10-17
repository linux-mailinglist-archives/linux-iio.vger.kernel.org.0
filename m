Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE87D430962
	for <lists+linux-iio@lfdr.de>; Sun, 17 Oct 2021 15:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343723AbhJQNfX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 Oct 2021 09:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242216AbhJQNfX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 17 Oct 2021 09:35:23 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0E5C061765
        for <linux-iio@vger.kernel.org>; Sun, 17 Oct 2021 06:33:13 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id q13so50873uaq.2
        for <linux-iio@vger.kernel.org>; Sun, 17 Oct 2021 06:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=jWRL5QHYGlFrwRX9nfH0NjktXPsAElv+E6acDVOY5Wo=;
        b=qjcieQJ/A8crbHHht2Dmi+g5WnQWFklzzXJxq7mO3JE30SquF61AKESe2W7RnSJY/K
         UXRybWTl55edYG2Hp6vkavuXrFNMXqZkqdUV6vLO5xPnkIfvXbIpq57NM1bb2GOd3UgX
         ZA1bQCHYKV8/04lg8ha+tKyCySQwosSXBhnk1vgnmgR5+4VLjdQF0T/vq3K8Kd7LGFhx
         kCpiDgvIEIyOzB9Y/KNqHDhcWAv01NtOr2zAqr5Ih1XEEnrj4pAYMpFtOrkGPUVk8MyT
         aVW30JqrWmLp3wAjpyRWnIUPpT7ycXBs7WKjiUZvARuZacQadWeVE2vMP/1+vTUCOyTC
         cNYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jWRL5QHYGlFrwRX9nfH0NjktXPsAElv+E6acDVOY5Wo=;
        b=ap6PIu6mAyTVARIu666X0yMy5c/zXqVgmDge/zjlZUAo3FZlgfJwB6+0G9GoTrkLKZ
         jgiV+AvUxp15HbcDDg9Ci8fruXidhgFoN82WudQmgh8JI23TMo1bbzK1mCT5DN+ELttZ
         wKZpA1Td3u0UxS80DhJe4iW4W6vP6CD3q7WszOBlJC4tVc7KPofex07RaOSfxpB3n/lk
         4PpsRw2kzsfpzC5XR+sZ4G7EezAtA3g9tG8p69EIf9/vkrLTW5XFOAL3O3YdkonpjCYC
         aWtjDYvoeo9h/gbmze/e/g/UpZI0Zykjf81ZOebgqK1O9TXB6V8rU4AsHB8uJpjYGY+u
         pEQA==
X-Gm-Message-State: AOAM533IkOxzyPX5GLALm/A7jt4cWh6k+L6OJo2TkkedRMGuydR+2OrH
        ZkuiHQ62B8HO3hc/4Taym0KA3Q==
X-Google-Smtp-Source: ABdhPJx3wFK8LQbniuUqDwt6+6Ukbw3fJXLi9Bt4tjRv3cdcV0kSwLUO4P9GhElMXzHZNBl9aWrEOQ==
X-Received: by 2002:a67:d78e:: with SMTP id q14mr693980vsj.55.1634477592376;
        Sun, 17 Oct 2021 06:33:12 -0700 (PDT)
Received: from Andryuu.br ([2804:431:c7fd:7238:311d:169e:a665:1173])
        by smtp.gmail.com with ESMTPSA id n3sm1728662vsq.28.2021.10.17.06.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 06:33:11 -0700 (PDT)
Date:   Sun, 17 Oct 2021 10:33:08 -0300
From:   =?iso-8859-1?Q?Andr=E9?= Gustavo Nakagomi Lopez <andregnl@usp.br>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, lars@metafoo.de, vz@mleia.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: lpc18xx_adc: Convert probe to device
 managed version
Message-ID: <YWwmFDF7Lig2rAuo@Andryuu.br>
References: <YWnMsGlc/I35gYvy@Andryuu.br>
 <20211017123533.33883e16@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211017123533.33883e16@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Oct 17, 2021 at 12:35:33PM +0100, Jonathan Cameron wrote:
> On Fri, 15 Oct 2021 15:47:12 -0300
> André Gustavo Nakagomi Lopez <andregnl@usp.br> wrote:
> 
> > The remove function and the goto sections are not necessary if devm
> > functions are used.
> > 
> > Convert device register to devm version. Add hook functions to release
> > device resources, and use them inside probe with devm_add_action,
> > which will release resources on driver detach.
> > 
> > To maintain the order of which device resources were released/reseted,
> > register the hook functions as soon as resources are obtained/initialized.
> > Since devres actions are called on driver detach, the remove
> > function and the error-handling goto sections are no longer necessary.
> > 
> > Signed-off-by: André Gustavo Nakagomi Lopez <andregnl@usp.br>
> 
> Hi André
> 
> Looks good to me, but I did notice an unrelated issue whilst looking at this driver.
> Comment on that inline.  Follow up patch welcome!
> 
> Applied to the togreg branch of iio.git and pushed out as testing to let 0-day
> see if it can find anything we missed.
> 
> Thanks,
> 
> Jonathan
> 
> 
> 
> > ---
> > Change log V1 -> V2:
> >        -Renamed lpc18xx_clk_disable_unprepare function
> >        -Removed platform_set_drvdata(pdev, indio_dev)
> >        -Renamed lpc18xx_writel to lpc18xx_clear_cr_reg
> >        -devm_iio_device_register now returns directly in the end of probe function
> >  drivers/iio/adc/lpc18xx_adc.c | 61 ++++++++++++++++++-----------------
> >  1 file changed, 31 insertions(+), 30 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/lpc18xx_adc.c b/drivers/iio/adc/lpc18xx_adc.c
> > index 3566990ae87d..7d50107427ac 100644
> > --- a/drivers/iio/adc/lpc18xx_adc.c
> > +++ b/drivers/iio/adc/lpc18xx_adc.c
> > @@ -115,6 +115,23 @@ static const struct iio_info lpc18xx_adc_info = {
> >  	.read_raw = lpc18xx_adc_read_raw,
> >  };
> >  
> > +static void lpc18xx_clear_cr_reg(void *data)
> > +{
> > +	struct lpc18xx_adc *adc = data;
> > +
> > +	writel(0, adc->base + LPC18XX_ADC_CR);
> > +}
> > +
> > +static void lpc18xx_clk_disable(void *clk)
> > +{
> > +	clk_disable_unprepare(clk);
> > +}
> > +
> > +static void lpc18xx_regulator_disable(void *vref)
> > +{
> > +	regulator_disable(vref);
> > +}
> > +
> >  static int lpc18xx_adc_probe(struct platform_device *pdev)
> >  {
> >  	struct iio_dev *indio_dev;
> > @@ -127,7 +144,6 @@ static int lpc18xx_adc_probe(struct platform_device *pdev)
> >  	if (!indio_dev)
> >  		return -ENOMEM;
> >  
> > -	platform_set_drvdata(pdev, indio_dev);
> >  	adc = iio_priv(indio_dev);
> >  	adc->dev = &pdev->dev;
> >  	mutex_init(&adc->lock);
> > @@ -163,44 +179,30 @@ static int lpc18xx_adc_probe(struct platform_device *pdev)
> >  		return ret;
> >  	}
> >  
> > +	ret = devm_add_action_or_reset(&pdev->dev, lpc18xx_regulator_disable, adc->vref);
> > +	if (ret)
> > +		return ret;
> > +
> >  	ret = clk_prepare_enable(adc->clk);
> >  	if (ret) {
> >  		dev_err(&pdev->dev, "unable to enable clock\n");
> > -		goto dis_reg;
> > +		return ret;
> 
> Unrelated but clk_get_rate() as called before the clk_prepare_enable() is not guaranteed
> to work.   So a good follow up patch would reorder that to be after the clk is turned on.
> 
> 
> >  	}
> >  
> > +	ret = devm_add_action_or_reset(&pdev->dev, lpc18xx_clk_disable,
> > +				       adc->clk);
> > +	if (ret)
> > +		return ret;
> > +
> >  	adc->cr_reg = (clkdiv << LPC18XX_ADC_CR_CLKDIV_SHIFT) |
> >  			LPC18XX_ADC_CR_PDN;
> >  	writel(adc->cr_reg, adc->base + LPC18XX_ADC_CR);
> >  
> > -	ret = iio_device_register(indio_dev);
> > -	if (ret) {
> > -		dev_err(&pdev->dev, "unable to register device\n");
> > -		goto dis_clk;
> > -	}
> > -
> > -	return 0;
> > -
> > -dis_clk:
> > -	writel(0, adc->base + LPC18XX_ADC_CR);
> > -	clk_disable_unprepare(adc->clk);
> > -dis_reg:
> > -	regulator_disable(adc->vref);
> > -	return ret;
> > -}
> > -
> > -static int lpc18xx_adc_remove(struct platform_device *pdev)
> > -{
> > -	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> > -	struct lpc18xx_adc *adc = iio_priv(indio_dev);
> > -
> > -	iio_device_unregister(indio_dev);
> > -
> > -	writel(0, adc->base + LPC18XX_ADC_CR);
> > -	clk_disable_unprepare(adc->clk);
> > -	regulator_disable(adc->vref);
> > +	ret = devm_add_action_or_reset(&pdev->dev, lpc18xx_clear_cr_reg, adc);
> > +	if (ret)
> > +		return ret;
> >  
> > -	return 0;
> > +	return devm_iio_device_register(&pdev->dev, indio_dev);
> >  }
> >  
> >  static const struct of_device_id lpc18xx_adc_match[] = {
> > @@ -211,7 +213,6 @@ MODULE_DEVICE_TABLE(of, lpc18xx_adc_match);
> >  
> >  static struct platform_driver lpc18xx_adc_driver = {
> >  	.probe	= lpc18xx_adc_probe,
> > -	.remove	= lpc18xx_adc_remove,
> >  	.driver	= {
> >  		.name = "lpc18xx-adc",
> >  		.of_match_table = lpc18xx_adc_match,
> 

Ok. Thank you for the review, I will work on the change.
