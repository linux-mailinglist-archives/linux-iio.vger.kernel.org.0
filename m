Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1332341411A
	for <lists+linux-iio@lfdr.de>; Wed, 22 Sep 2021 07:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbhIVFM0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Sep 2021 01:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbhIVFMZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Sep 2021 01:12:25 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40664C061574
        for <linux-iio@vger.kernel.org>; Tue, 21 Sep 2021 22:10:56 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id a13so1216812qvo.9
        for <linux-iio@vger.kernel.org>; Tue, 21 Sep 2021 22:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rYboVHviwFFsuLqq3kpVgXhVY//iVNZLUAjdGvDG3mo=;
        b=Og8+RVSJHWXVIYHtCNK3l0ccrNobHnUuWx5NXPeSp4/kNbp2dQLSQHKGkokgpo18ju
         wodJ4BW2q3bUi5Qi0pYHsdVXkAN8/zWmfRF9LFsyRUaclgAWQa9KWOKliW70K2Et2xcU
         BFBRvMEUQZeGjINfXp48DrxI/qOa36lE3hVy7FICAAiwPIYSjmUbHGIcbybjQJhgR0kI
         5o95zGx27NXt7hbLLaxeRzvYA8tS9Dqmr61iasCOUvPEFUaHAjVYrhpdc61WwzHHEsep
         dReG7Bc+zz+YdMGAtek+gP5qPMJcuFg28wF2qP8UQGM+vWITXVP+u3Wd7VnF79meww7e
         RTpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rYboVHviwFFsuLqq3kpVgXhVY//iVNZLUAjdGvDG3mo=;
        b=jLnHovppclEn9Q6mXQHbBV9Q7NSSuuWXIjt0pmd5V8WxQOX2kMFZ5vr+Qc8S7NlEaL
         1RHapXGE6uLJpCc3RomW6nqydP50Afq2E2G4D+MPoJELRRQaGPo4K6czC9CiktrveRFJ
         a9AKlqjGx+DUP04qU7DZRY42htWuUu6oIcVbSBrIJyVtMOfO+8De3MvOPtiFIeNXFWPZ
         GT4du2tYm1Pf5uFmm6oOR3pFkkZ1RISH547M4/JYJNxsr4mqaFYvVdl7bKxCedJ9vk24
         2IPgDtgdWo+n+3NS5Qs4sQLZIRfAoWNBp5LORiVXRNncIlVZJtpvBhz0nEQvstgJhFMO
         Qm0A==
X-Gm-Message-State: AOAM531M4gDoEeMOfid4XXYahIsqUoT5lPjH4VylbPwNZwVrAPPPqYDE
        dzIkjVktjlqlHPoDnkSNW4M=
X-Google-Smtp-Source: ABdhPJzwg53DIAHDf+lz1Yg0bLFH7BEVhsZUdFalmM8Xtk8UNcj/6VNWTNSrXybrxX2wXUaP8I1EgA==
X-Received: by 2002:ad4:44f3:: with SMTP id p19mr35620677qvt.33.1632287455343;
        Tue, 21 Sep 2021 22:10:55 -0700 (PDT)
Received: from shaak (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id n73sm945459qkn.123.2021.09.21.22.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 22:10:54 -0700 (PDT)
Date:   Wed, 22 Sep 2021 01:10:52 -0400
From:   Liam Beguin <liambeguin@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     lvb@xiphos.com, linux-iio@vger.kernel.org, liambeguin@gmail.com
Subject: Re: [bug report] iio: adc: ad7949: add vref selection support
Message-ID: <YUq63O3ksdr9R3pE@shaak>
References: <20210921063509.GA26209@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921063509.GA26209@kili>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Dan,

On Tue, Sep 21, 2021 at 09:35:09AM +0300, Dan Carpenter wrote:
> Hello Liam Beguin,
> 
> The patch 379306506049: "iio: adc: ad7949: add vref selection
> support" from Aug 15, 2021, leads to the following
> Smatch static checker warning:
> 
> 	drivers/iio/adc/ad7949.c:387 ad7949_spi_probe()
> 	error: 'ad7949_adc->vref' dereferencing possible ERR_PTR()
> 
> drivers/iio/adc/ad7949.c
>     309 static int ad7949_spi_probe(struct spi_device *spi)
>     310 {
>     311         u32 spi_ctrl_mask = spi->controller->bits_per_word_mask;
>     312         struct device *dev = &spi->dev;
>     313         const struct ad7949_adc_spec *spec;
>     314         struct ad7949_adc_chip *ad7949_adc;
>     315         struct iio_dev *indio_dev;
>     316         u32 tmp;
>     317         int ret;
>     318 
>     319         indio_dev = devm_iio_device_alloc(dev, sizeof(*ad7949_adc));
>     320         if (!indio_dev) {
>     321                 dev_err(dev, "can not allocate iio device\n");
>     322                 return -ENOMEM;
>     323         }
>     324 
>     325         indio_dev->info = &ad7949_spi_info;
>     326         indio_dev->name = spi_get_device_id(spi)->name;
>     327         indio_dev->modes = INDIO_DIRECT_MODE;
>     328         indio_dev->channels = ad7949_adc_channels;
>     329         spi_set_drvdata(spi, indio_dev);
>     330 
>     331         ad7949_adc = iio_priv(indio_dev);
>     332         ad7949_adc->indio_dev = indio_dev;
>     333         ad7949_adc->spi = spi;
>     334 
>     335         spec = &ad7949_adc_spec[spi_get_device_id(spi)->driver_data];
>     336         indio_dev->num_channels = spec->num_channels;
>     337         ad7949_adc->resolution = spec->resolution;
>     338 
>     339         /* Set SPI bits per word */
>     340         if (spi_ctrl_mask & SPI_BPW_MASK(ad7949_adc->resolution)) {
>     341                 spi->bits_per_word = ad7949_adc->resolution;
>     342         } else if (spi_ctrl_mask == SPI_BPW_MASK(16)) {
>     343                 spi->bits_per_word = 16;
>     344         } else if (spi_ctrl_mask == SPI_BPW_MASK(8)) {
>     345                 spi->bits_per_word = 8;
>     346         } else {
>     347                 dev_err(dev, "unable to find common BPW with spi controller\n");
>     348                 return -EINVAL;
>     349         }
>     350 
>     351         /* Setup internal voltage reference */
>     352         tmp = 4096000;
>     353         device_property_read_u32(dev, "adi,internal-ref-microvolt", &tmp);
>     354 
>     355         switch (tmp) {
>     356         case 2500000:
>     357                 ad7949_adc->refsel = AD7949_CFG_VAL_REF_INT_2500;
>     358                 break;
>     359         case 4096000:
>     360                 ad7949_adc->refsel = AD7949_CFG_VAL_REF_INT_4096;
>     361                 break;
>     362         default:
>     363                 dev_err(dev, "unsupported internal voltage reference\n");
>     364                 return -EINVAL;
>     365         }
>     366 
>     367         /* Setup external voltage reference, buffered? */
>     368         ad7949_adc->vref = devm_regulator_get_optional(dev, "vrefin");
> 
> Apparenty it's really rare to have an optional regulator?  This function
> is very tricky.  It should return NULL if the option is not like all the
> other optional features in the kernel.  But the regulator code is really
> not set up for not having a regulator.  If it were then there would be a
> lot of NULL checks in the regulator code.  But since it's not then you
> have to add them to the driver instead.
> 
>     369         if (IS_ERR(ad7949_adc->vref)) {
>     370                 ret = PTR_ERR(ad7949_adc->vref);
>     371                 if (ret != -ENODEV)
>     372                         return ret;
>     373                 /* unbuffered? */
>     374                 ad7949_adc->vref = devm_regulator_get_optional(dev, "vref");
>     375                 if (IS_ERR(ad7949_adc->vref)) {
>     376                         ret = PTR_ERR(ad7949_adc->vref);
>     377                         if (ret != -ENODEV)
>     378                                 return ret;
> 
> Instead of returning NULL when the regulator is disabled it returns
> -ENODEV.  How do you differentiate from an -ENODEV which is caused by an
> error vs an -ENODEV which is caused because the optional regulator is
> disabled?  You'll just have to hope that the errors are less common and
> assume it means disabled.

I see.. So far, I've only used fixed-regulators to provide a constant
voltage reference here, and I guess those are quite unlikely to fail.

> You might be doubting that devm_regulator_get_optional() can return
> -ENODEV on error?  Look at the code and prepare your heart for sadness.

Thanks for the warning, I see what you meant now.

I wasn't able to use smatch to reproduce the error with the following:

	make O=builds/smatch CHECK="~/dev/smatch/smatch -p=kernel" C=1 Image.gz

Would you have any pointer for that?

Anyway, I believe the following would address the error you mentioned.

-- >8 --
diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
index 44bb5fde83de..3613f4e55e1c 100644
--- a/drivers/iio/adc/ad7949.c
+++ b/drivers/iio/adc/ad7949.c
@@ -368,12 +368,14 @@ static int ad7949_spi_probe(struct spi_device *spi)
 	ad7949_adc->vref = devm_regulator_get_optional(dev, "vrefin");
 	if (IS_ERR(ad7949_adc->vref)) {
 		ret = PTR_ERR(ad7949_adc->vref);
+		ad7949_adc->vref = NULL;
 		if (ret != -ENODEV)
 			return ret;
 		/* unbuffered? */
 		ad7949_adc->vref = devm_regulator_get_optional(dev, "vref");
 		if (IS_ERR(ad7949_adc->vref)) {
 			ret = PTR_ERR(ad7949_adc->vref);
+			ad7949_adc->vref = NULL;
 			if (ret != -ENODEV)
 				return ret;
 		} else {
-- >8 --

I'd like to be able to reproduce the error to make sure everything is okay but
otherwise I can still send a patch.

Thanks,
Liam

>     379                 } else {
>     380                         ad7949_adc->refsel = AD7949_CFG_VAL_REF_EXT_TEMP;
>     381                 }
>     382         } else {
>     383                 ad7949_adc->refsel = AD7949_CFG_VAL_REF_EXT_TEMP_BUF;
>     384         }
>     385 
>     386         if (ad7949_adc->refsel & AD7949_CFG_VAL_REF_EXTERNAL) {
> --> 387                 ret = regulator_enable(ad7949_adc->vref);
>                                                ^^^^^^^^^^^^^^^^
> Every reference to ->vref will crash if the optional regulator is
> disabled.
> 
>     388                 if (ret < 0) {
>     389                         dev_err(dev, "fail to enable regulator\n");
>     390                         return ret;
>     391                 }
>     392 
>     393                 ret = devm_add_action_or_reset(dev, ad7949_disable_reg,
>     394                                                ad7949_adc->vref);
>     395                 if (ret)
>     396                         return ret;
>     397         }
>     398 
>     399         mutex_init(&ad7949_adc->lock);
>     400 
>     401         ret = ad7949_spi_init(ad7949_adc);
>     402         if (ret) {
>     403                 dev_err(dev, "enable to init this device: %d\n", ret);
>     404                 return ret;
>     405         }
>     406 
>     407         ret = devm_iio_device_register(dev, indio_dev);
>     408         if (ret)
>     409                 dev_err(dev, "fail to register iio device: %d\n", ret);
>     410 
>     411         return ret;
>     412 }
> 
> regards,
> dan carpenter
