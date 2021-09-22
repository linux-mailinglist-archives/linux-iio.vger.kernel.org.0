Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 330CC414C65
	for <lists+linux-iio@lfdr.de>; Wed, 22 Sep 2021 16:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235464AbhIVOuT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Sep 2021 10:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235014AbhIVOuS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Sep 2021 10:50:18 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C78C061574
        for <linux-iio@vger.kernel.org>; Wed, 22 Sep 2021 07:48:48 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id 194so10225199qkj.11
        for <linux-iio@vger.kernel.org>; Wed, 22 Sep 2021 07:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kmRlOtuPI5J1/kfxAnr24ju4XEybREitIAFMEFzalBU=;
        b=gBEPeUnkrfIM4UEdWOXaU1+m6bTxs3/ZsPy3T3vlzxqum5bzjiagL8n5n43TVNUoEl
         11I5/IV9gBFqdeCsSWiv6Xz5RVfrlEF6rT5uUtNE+IkEocD3YIkoaq0S/KKG6h/taPbw
         rGStHUT5++nRtacSDQj2HR4rrJYFMa+AH8q7CyqE45WWfZ+cz0sizlMKiLBe5fynXOUt
         4YR49kjZ5yIr+v3JUt2QVZk7RKI4YacPtjzcovm7XLfVXBX9WWVYmG0Vil9fInriFiJC
         eOhOFTyenZymL5URLMlNnWIQYIA3qovKp8fe3x8kpUa8keLMhfypHUe4qUpITfizXhvl
         Yk0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kmRlOtuPI5J1/kfxAnr24ju4XEybREitIAFMEFzalBU=;
        b=VNrkoAm03FO6sy3BaEJ/3LW2Flxp42224MRyr5z9RccceOZgYJ5ycVsjDte6Kmdbz1
         KPBd+BAdX47kN54P2DPFP2iCUK616HjIJN9g67hpR79f14sEO+dlRjBfYxRlAZ+JjKvU
         JHh/WEELhNSuCDpChpCOZGkoec7SPI5yc187ElwHzZQwjzQBeF6mNkC9d8eL6jV/no83
         33IDaKVrqZOgaI97GayZszVPIVyrhjVGVGdoarQUmszNfwm7n4kD1eeZ+bkiee1WUo5R
         IQhj7Gfn7O42JWVarXFyFT64khHmwh8Ci0UIODjUJUzgA498shCHnfpTK24wzE5S+T+U
         iHfw==
X-Gm-Message-State: AOAM532kiqGbUs/9bylRpdZDWZN119HrwP6O7yXJwTIDYsMphBYIbies
        0do+A13jc6ArCT2M6mcAyMAVFfct0q4=
X-Google-Smtp-Source: ABdhPJxSL6+T22rWXZzIy/rEEJ0os9xX9KfEk5kwvdjBwO9th2Gn3MAEa9buTPJHUEITQzIepJT0+Q==
X-Received: by 2002:a05:620a:20db:: with SMTP id f27mr181029qka.496.1632322127877;
        Wed, 22 Sep 2021 07:48:47 -0700 (PDT)
Received: from shaak (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id a189sm1833426qkf.114.2021.09.22.07.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 07:48:47 -0700 (PDT)
Date:   Wed, 22 Sep 2021 10:48:45 -0400
From:   Liam Beguin <liambeguin@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     lvb@xiphos.com, linux-iio@vger.kernel.org
Subject: Re: [bug report] iio: adc: ad7949: add vref selection support
Message-ID: <YUtCTZ2sV/h6+dZ9@shaak>
References: <20210921063509.GA26209@kili>
 <YUq63O3ksdr9R3pE@shaak>
 <20210922060026.GW2116@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922060026.GW2116@kadam>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Dan,

On Wed, Sep 22, 2021 at 09:00:26AM +0300, Dan Carpenter wrote:
> On Wed, Sep 22, 2021 at 01:10:52AM -0400, Liam Beguin wrote:
> > > 
> > >     369         if (IS_ERR(ad7949_adc->vref)) {
> > >     370                 ret = PTR_ERR(ad7949_adc->vref);
> > >     371                 if (ret != -ENODEV)
> > >     372                         return ret;
> > >     373                 /* unbuffered? */
> > >     374                 ad7949_adc->vref = devm_regulator_get_optional(dev, "vref");
> > >     375                 if (IS_ERR(ad7949_adc->vref)) {
> > >     376                         ret = PTR_ERR(ad7949_adc->vref);
> > >     377                         if (ret != -ENODEV)
> > >     378                                 return ret;
> > > 
> > > Instead of returning NULL when the regulator is disabled it returns
> > > -ENODEV.  How do you differentiate from an -ENODEV which is caused by an
> > > error vs an -ENODEV which is caused because the optional regulator is
> > > disabled?  You'll just have to hope that the errors are less common and
> > > assume it means disabled.
> > 
> > I see.. So far, I've only used fixed-regulators to provide a constant
> > voltage reference here, and I guess those are quite unlikely to fail.
> > 
> > > You might be doubting that devm_regulator_get_optional() can return
> > > -ENODEV on error?  Look at the code and prepare your heart for sadness.
> > 
> > Thanks for the warning, I see what you meant now.
> > 
> > I wasn't able to use smatch to reproduce the error with the following:
> > 
> > 	make O=builds/smatch CHECK="~/dev/smatch/smatch -p=kernel" C=1 Image.gz
> > 
> > Would you have any pointer for that?
> 
> This requires building the cross function Database:
> 
> 	~/dev/smatch/smatch_scripts/build_kernel_data.sh
> 
> The command takes 5 hours to run so here is a short cut which just
> builds the minimum two files:
> 
> ~/dev/smatch/smatch_scripts/kchecker --info drivers/regulator/core.c | tee out
> ~/dev/smatch/smatch_data/db/create_db.sh -p=kernel out
> ~/dev/smatch/smatch_scripts/kchecker --info drivers/regulator/devres.c | tee out
> ~/dev/smatch/smatch_data/db/reload_partial.sh out
> ~/dev/smatch/smatch_scripts/kchecker --spammy drivers/iio/adc/ad7949.c

Thanks, I appreciate the shortcuts! I was able to reproduce the error
with these steps.

> > Anyway, I believe the following would address the error you mentioned.
> > 
> > -- >8 --
> > diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
> > index 44bb5fde83de..3613f4e55e1c 100644
> > --- a/drivers/iio/adc/ad7949.c
> > +++ b/drivers/iio/adc/ad7949.c
> > @@ -368,12 +368,14 @@ static int ad7949_spi_probe(struct spi_device *spi)
> >  	ad7949_adc->vref = devm_regulator_get_optional(dev, "vrefin");
> >  	if (IS_ERR(ad7949_adc->vref)) {
> >  		ret = PTR_ERR(ad7949_adc->vref);
> > +		ad7949_adc->vref = NULL;
> 
> This is not required because it will just be reassigned in a couple
> lines.

Right, sorry about that.

> >  		if (ret != -ENODEV)
> >  			return ret;
> >  		/* unbuffered? */
> >  		ad7949_adc->vref = devm_regulator_get_optional(dev, "vref");
> >  		if (IS_ERR(ad7949_adc->vref)) {
> >  			ret = PTR_ERR(ad7949_adc->vref);
> > +			ad7949_adc->vref = NULL;
> 
> But this also won't work.  Passing a NULL to regulator_enable() will
> cause an Oops.  All the reference to ->vref need checks.  :/

I believe it still work since these conditions around
devm_regulator_get_optional() also set ad7949_adc->refsel.

ad7949_adc->refsel is then checked before calling regulator_enable() and
regulator_get_voltage().

Even without the patch, I don't think we can call regulor_enable()
without having it be defined. Am I missing something else?

Thanks,
Liam

> >  			if (ret != -ENODEV)
> >  				return ret;
> >  		} else {
> 
> regards,
> dan carpenter
> 
