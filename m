Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D558439602
	for <lists+linux-iio@lfdr.de>; Mon, 25 Oct 2021 14:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbhJYMVG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 Oct 2021 08:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbhJYMVF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 Oct 2021 08:21:05 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7FFC061767
        for <linux-iio@vger.kernel.org>; Mon, 25 Oct 2021 05:18:43 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id b4so9445934uaq.9
        for <linux-iio@vger.kernel.org>; Mon, 25 Oct 2021 05:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=w8eR9KqhxNIJXnTgkegzXSIyB4t1TslfUURdMx0cmXE=;
        b=UM5I9ujQb8me6F8btbklgehQkvnBJu9XgocDk4soGv6b6cLDiBFrQ/IhPEuLDWV0q8
         DFcyA+iTwgOsvVBgMlwNseljp8FHyixdlE3LRKxHSFyyCsu2RfPATUzVRku2tm+MYkwO
         3Z77Ugz7htXbNHaf34rw7fFvocL5JD/pfIPN7cSUnZiCJ3kD2yWRsbAyxmhP6t6zbHzu
         mNzMGAHF/8nrGJA30IgmvcPqYRgGvyWmQmxlqKjBxc1J4teY4Rprk/JSEKBVp2R9JjpC
         2BGv4lMiT6vXSB3IU/yLecUcSCPTlRjXNJeXQ/2wyeakQACQt+LvEMSIKrOtoKG6pB2Z
         Rifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=w8eR9KqhxNIJXnTgkegzXSIyB4t1TslfUURdMx0cmXE=;
        b=5LGofGNwS6/tc7pA/DztQThiymAGxnqMv+2ZfEJwYSSrcm0fdK3GS/rLY53gywC4Eh
         C7Hc0B7qL4jTx3HYmVwzbaBelx6v7lsH8e899cFNc1N45QhyX5Zudiijp+zWsPfOOB3V
         ZSnbFIqDKcrcFIi3q72NkJIANHPuKK8POO6/iXkPo4dV1NnKpc1sA3QodMy97yiEnLwP
         aKuMlb+yCN6towSp4P8G66CU6RFab8UE1N0/B2iRuWCX4L96FMOhmzP7MOPhLtWzsb5B
         zCEX97lG4CCRJAWJA8Cj/zq1BU4eOXwczzYZMrC+2XMKEztG7yLN/+vvXpOZjrB/s/c8
         LqiA==
X-Gm-Message-State: AOAM532A7QmnwSG4wJvb9h5B3A1mIQSPpny2MmBZVQQIEzzAs/KN3MJ9
        zKiIMuR4vatHuVKv6zzb1mJ5ug==
X-Google-Smtp-Source: ABdhPJwh36gAmINQ22TyFC/es1dzHhqDBwtaPvWPA5EHNi4JTJC0pkrEDs2pgaLbOSqQAA5+DyYhkA==
X-Received: by 2002:a05:6102:3ed4:: with SMTP id n20mr12102869vsv.57.1635164322559;
        Mon, 25 Oct 2021 05:18:42 -0700 (PDT)
Received: from Andryuu.br ([2804:431:c7fd:423:9dac:f639:6086:598])
        by smtp.gmail.com with ESMTPSA id v187sm9665937vsv.26.2021.10.25.05.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 05:18:42 -0700 (PDT)
Date:   Mon, 25 Oct 2021 09:18:38 -0300
From:   =?iso-8859-1?Q?Andr=E9?= Gustavo Nakagomi Lopez <andregnl@usp.br>
To:     Vladimir Zapolskiy <vz@mleia.com>
Cc:     jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: lpc18xx_adc: Reorder clk_get_rate function call
Message-ID: <YXagnudS9eMj9T06@Andryuu.br>
References: <YXW3azIjPzGjvjTX@Andryuu.br>
 <bd79117b-91cc-da4b-abdd-2a41db8b330a@mleia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bd79117b-91cc-da4b-abdd-2a41db8b330a@mleia.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Oct 24, 2021 at 11:12:39PM +0300, Vladimir Zapolskiy wrote:
> Hi André,
> 
> On 10/24/21 10:43 PM, André Gustavo Nakagomi Lopez wrote:
> > clk_get_rate is not garanteed to work if called before clk_prepare_enable.
> 
> typo, s/garanteed/guaranteed/
> 
> > 
> > Reorder clk_get_rate, so it's called after clk_prepare_enable and
> > after devm_add_action_or_reset of lpc18xx_clk_disable.
> > 
> > Signed-off-by: André Gustavo Nakagomi Lopez <andregnl@usp.br>
> > ---
> >   drivers/iio/adc/lpc18xx_adc.c | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/lpc18xx_adc.c b/drivers/iio/adc/lpc18xx_adc.c
> > index ceefa4d793cf..ae9c9384f23e 100644
> > --- a/drivers/iio/adc/lpc18xx_adc.c
> > +++ b/drivers/iio/adc/lpc18xx_adc.c
> > @@ -157,9 +157,6 @@ static int lpc18xx_adc_probe(struct platform_device *pdev)
> >   		return dev_err_probe(&pdev->dev, PTR_ERR(adc->clk),
> >   				     "error getting clock\n");
> > -	rate = clk_get_rate(adc->clk);
> > -	clkdiv = DIV_ROUND_UP(rate, LPC18XX_ADC_CLK_TARGET);
> > -
> >   	adc->vref = devm_regulator_get(&pdev->dev, "vref");
> >   	if (IS_ERR(adc->vref))
> >   		return dev_err_probe(&pdev->dev, PTR_ERR(adc->vref),
> > @@ -192,6 +189,9 @@ static int lpc18xx_adc_probe(struct platform_device *pdev)
> >   	if (ret)
> >   		return ret;
> > +	rate = clk_get_rate(adc->clk);
> > +	clkdiv = DIV_ROUND_UP(rate, LPC18XX_ADC_CLK_TARGET);
> > +
> >   	adc->cr_reg = (clkdiv << LPC18XX_ADC_CR_CLKDIV_SHIFT) |
> >   			LPC18XX_ADC_CR_PDN;
> >   	writel(adc->cr_reg, adc->base + LPC18XX_ADC_CR);
> > 
> 
> Thank you for the change, per se this particular change is not needed on
> LPC18xx/43xx platform, however I don't object to it.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Acked-by: Vladimir Zapolskiy <vz@mleia.com>
> 
> --
> Best wishes,
> Vladimir

Ok, thank you for the review. I will fix the typo and add the appropriate tags.
