Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5132419068
	for <lists+linux-iio@lfdr.de>; Mon, 27 Sep 2021 10:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233371AbhI0ILO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Sep 2021 04:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233362AbhI0ILO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Sep 2021 04:11:14 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F89CC061604
        for <linux-iio@vger.kernel.org>; Mon, 27 Sep 2021 01:09:36 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id x20so5174206wrg.10
        for <linux-iio@vger.kernel.org>; Mon, 27 Sep 2021 01:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=9F/dOrkeMh+t6dNCFSGwYqJcbpKTkv75T5foTFZYKGo=;
        b=iTKf8Re+I7mIU+dY+9f70h+TO1JO28z8McxFJ9wpr9nUjRpAcq2N6jO+Fd7uqgWdT8
         Bel0Q2yBp9zy/+WWlUDNwVgQ9DcPnwGl1zLGtuXWz/irz/2rkcKXpvdiM0UGpz7Rn5Fa
         6oYzQ5m7n2FQDJT2Pa+EAoMcGO4Wc8jTtMQKwBDp5sIcjmSDreg763ZMt4KUNo6J809H
         50x5CGwn+3uIKPoYfsscMPqqfSQLyOdfezeR3NZFRWVwgjTcZscQkEAdb8CQWS4r3RBB
         leyFg1JQaXBJ1+hGlCPZXg0RoXXXztxk4kqZGvo7VpAtBKbCFsT+r5IDYSALNg+g6P56
         9ffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9F/dOrkeMh+t6dNCFSGwYqJcbpKTkv75T5foTFZYKGo=;
        b=zwqVtOruJbhHfJiXHibXZdvbjgRuw707fJwzp1kn8lB3U/h7i2F4QF9WFk0uf2R8fi
         3MA7pxxQOcR5cdZeuCZn9VWLhEqbYR7Oh7lC/mN1Y03ZLzFy5yi12VjfZlHsI4q5NmG8
         vJHP8PtFIs3v8dakH9r9MfjdsiZ24Jjmrp+2ERDmPT5LpkVoWgSLkpDGP3fgTOry4Niz
         1/2IoNRe+PqJPJfmKY6CTsCeJaEk/InBbAco2Oa75xDqE7cHI01wTfONk6anDWKvnugt
         0P+EgdL3BUmgYeLYzdgSdohMvQ33oUziChJTL5dKkkDKrb5xlEyarZhgDl+Hv5xYrCLe
         twVA==
X-Gm-Message-State: AOAM532YD1C6Sbllla3D5jJUuOC9eK8kDIPURnNuBfsc0MduXLyeEbhH
        Lamg/DCiAgwO2WLdrlFynXr+mQ==
X-Google-Smtp-Source: ABdhPJyFXeKtm+hoVqcltCOEbNO4S5Q/93mKEKweRYj2kfH4joPD+V4sXuktCJZGy0649HSQxMJd+w==
X-Received: by 2002:a1c:19c6:: with SMTP id 189mr11595703wmz.121.1632730175006;
        Mon, 27 Sep 2021 01:09:35 -0700 (PDT)
Received: from google.com ([95.148.6.233])
        by smtp.gmail.com with ESMTPSA id w18sm451077wrt.79.2021.09.27.01.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 01:09:34 -0700 (PDT)
Date:   Mon, 27 Sep 2021 09:09:32 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        bcousson@baylibre.com, Tony Lindgren <tony@atomide.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Ryan Barnett <ryan.barnett@collins.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Jason Reeder <jreeder@ti.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 36/47] mfd: ti_am335x_tscadc: Support the correctly
 spelled DT property
Message-ID: <YVF8PDl54lpUc+6S@google.com>
References: <20210915155908.476767-1-miquel.raynal@bootlin.com>
 <20210915155908.476767-37-miquel.raynal@bootlin.com>
 <YUtSVo9HBAiomswv@google.com>
 <20210923101922.2c108d2b@xps13>
 <YUxEsfOvn7Vr8F2c@google.com>
 <20210923113312.14fc9027@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210923113312.14fc9027@xps13>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 23 Sep 2021, Miquel Raynal wrote:

> Hi Lee,
> 
> lee.jones@linaro.org wrote on Thu, 23 Sep 2021 10:11:13 +0100:
> 
> > On Thu, 23 Sep 2021, Miquel Raynal wrote:
> > 
> > > Hi Lee,
> > > 
> > > lee.jones@linaro.org wrote on Wed, 22 Sep 2021 16:57:10 +0100:
> > >   
> > > > On Wed, 15 Sep 2021, Miquel Raynal wrote:
> > > >   
> > > > > There was in the past a typo in the coordinate readouts property. The
> > > > > bindings have been updated, the touchscreen driver as well and now
> > > > > supports both. However, the MFD driver that is in charge of verifying
> > > > > the validity of the property only checks the bogus one. Add support for
> > > > > the correctly spelled DT property.
> > > > > 
> > > > > Fixes: c9aeb249bf72 ("Input: ti_am335x_tsc - fix spelling mistake in TSC/ADC DT binding")
> > > > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > > ---
> > > > >  drivers/mfd/ti_am335x_tscadc.c | 8 +++++++-
> > > > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
> > > > > index 155a8ed879b3..aa46ed669016 100644
> > > > > --- a/drivers/mfd/ti_am335x_tscadc.c
> > > > > +++ b/drivers/mfd/ti_am335x_tscadc.c
> > > > > @@ -144,8 +144,14 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
> > > > >  	if (tscadc->data->has_tsc) {
> > > > >  		node = of_get_child_by_name(pdev->dev.of_node, "tsc");
> > > > >  		of_property_read_u32(node, "ti,wires", &tscmag_wires);
> > > > > -		of_property_read_u32(node, "ti,coordiante-readouts", &readouts);
> > > > > +		err = of_property_read_u32(node, "ti,coordinate-readouts",
> > > > > +					   &readouts);
> > > > > +		if (err < 0)
> > > > > +			of_property_read_u32(node, "ti,coordiante-readouts",
> > > > > +					     &readouts);
> > > > > +    
> > > > 
> > > > How long are you proposing that we support this churn?  
> > > 
> > > Well, I am not proposing anything, I am just "fixing" the driver so
> > > that it fits the bindings :) Given the fact that at the end of this
> > > series there is a patch that changes the "coordiante" typo to
> > > "coordinate" in a device tree source file, I believe it is still too
> > > soon...  
> > 
> > If this is something you're changing in this set, please reconsider.
> > 
> > I'd rather have a slightly misspelled documented property than being
> > forced to support 2 for any length of time.
> 
> I am not suggesting anything here:
> - "coordiante" was introduced back in 2014.
> - "coordinate" was introduced shortly later.
> - "coordiante" was considered part of the "stable API" back in 2014 and
>   even though the right spelling got introduced very shortly after, DT
>   stability rules wanted us to support it forever.
> - The touchscreen driver has immediately be fixed to support both but
>   not the MFD driver, and this does not make any sense!
> 
> We *should* either support only one property (1) or support both in the
> two drivers (2), but supporting the two in one driver and supporting
> only one in the other one does not make any sense (given the fact that
> these two drives are tied together, the touchscreen driver does not
> exist without the MFD driver). That is what I am fixing here.
> 
> Is #1 valid? Theoretically it's the best scenario. In practice it is
> not (yet) possible because the two versions are still used in the
> mainline device trees:
> $ git grep coordiante-readouts -- arch/arm/boot/dts/ | wc -l
> 1
> $ git grep coordinate-readouts -- arch/arm/boot/dts/ | wc -l
> 5
> 
> So in this series I am fixing the MFD driver to be sure it handles
> correctly the correctly spelled DT property which is used by 5 boards
> since at least 6 years and I am also updating the remaining DT to use
> the correctly spelled property as well.
> 
> I suppose we could propose to drop support for the "coordiante"
> version of that property in a few years but if we decide to do it right
> now we're definitely gonna break users.

It's a shame that the misspelled one is still in use.  If they were
all changed over at the start, there would be a strong case for
dropping support for it.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
