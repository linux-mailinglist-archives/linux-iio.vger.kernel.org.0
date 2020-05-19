Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCD0D1D93AE
	for <lists+linux-iio@lfdr.de>; Tue, 19 May 2020 11:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgESJo2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 May 2020 05:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbgESJo1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 May 2020 05:44:27 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74333C061A0C;
        Tue, 19 May 2020 02:44:27 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id n5so2749775wmd.0;
        Tue, 19 May 2020 02:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cjmj1xzQu18Ru/uezNZCCqloNoHKEc4t1hO8iLb+89w=;
        b=doPr+tGmmoXrEIV8pAXbYbWtSk35ohyC2eHhh7hjPB8PJNH1kytiu/kGI37eRDhvMA
         BprWAATG708q5Or9loDVNLkQxAEhwiPNlAuETX3y9b/zlN9I60lC3Y/XCLYVtuflkZed
         BR/lgrHjNdq+mSvH1CSrYFCrUgHZykgh7JD8DfpllMxRtT+1awR8kN8pp5q2YwpBw/ub
         d0WSgQcjAJ4hW/1n+d5550Gpn/LV/2QMbzF0lJTvoE51Pr7XS6mtJ2IF7HRFR326+ujD
         QkAep131uFWOO8DodV2+jVuALtctIzxnzt2PvjL1+5hHDoOV3LkPFQx+r8x/BTZoIZZ0
         P+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cjmj1xzQu18Ru/uezNZCCqloNoHKEc4t1hO8iLb+89w=;
        b=ny56LZ1ElDLcKW4/3LVh/zc2K6k3d81Acdrh3rLiwaHhsU1imDwug+SVvcl3btP7lY
         HHjQxmeAvfBWVzqL7uKvh9n9AqKt2e2a8LN76mOZQiSOBA6nzo1p2r8kYHdmZS2vszul
         NpT3Kb6lhnLeEpW3UUfhO8y76CdNVIcBirmeFtYEaNVnWVO9ZdjzS2bxSBaxzIKw4rZm
         02tYqY/Jsmh6BVxYDpofFvw4NV4jyGPnc5Zc0bSJB6yIf3s//ZLbeVR+qWakneimCB9m
         XprMLKCo23LnBUvPnedbBbpareuz2UUyqgr5nxlI8fwH2WmJjj78Y3iON3oI+EZ/owyc
         bQvA==
X-Gm-Message-State: AOAM530CU5W29hNBARfz4fVDh8d/ssE548ZQgP3WTQh3RVHC8S2l0yMm
        jq2gZsdusDK/ofUaFASaDyo=
X-Google-Smtp-Source: ABdhPJxbdnRd+quHI/sSSncj5FZ+P/varJ6tdGMUZVPI0wYUfNhu7a6vWVjZXgZUOCkwj4xtkPsGPw==
X-Received: by 2002:a1c:b141:: with SMTP id a62mr4319303wmf.7.1589881466008;
        Tue, 19 May 2020 02:44:26 -0700 (PDT)
Received: from ict14-OptiPlex-980 ([178.23.248.46])
        by smtp.gmail.com with ESMTPSA id z11sm20132484wro.48.2020.05.19.02.44.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 May 2020 02:44:24 -0700 (PDT)
Date:   Tue, 19 May 2020 11:44:18 +0200
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Jilayne Lovejoy <opensource@jilayne.com>
Subject: Re: [PATCH v2 3/3] iio: magnetometer: ak8975: Add gpio reset support
Message-ID: <20200519094418.GA10391@ict14-OptiPlex-980>
References: <20200519065749.4624-1-jonathan.albrieux@gmail.com>
 <20200519065749.4624-4-jonathan.albrieux@gmail.com>
 <20200519092127.GS1634618@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519092127.GS1634618@smile.fi.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, May 19, 2020 at 12:21:27PM +0300, Andy Shevchenko wrote:
> On Tue, May 19, 2020 at 08:57:43AM +0200, Jonathan Albrieux wrote:
> 
> Thanks for an update, my comments below.
> 

Thanks to you for taking time to review the code!

> > According to AK09911 datasheet, if reset gpio is provided then 
> 
> Trailing whitespace.
> 
> > deassert reset on ak8975_power_on and assert reset on ak8975_power_off.
> > 
> > Without reset's deassertion during ak8975_power_on, driver's probe fails on
> > ak8975_who_i_am while checking for device identity for AK09911 chip
> > 
> > AK09911 has an active low reset gpio to handle register's reset.
> > AK09911 datasheed says that, if not used, reset pin should be connected
> > to VID. This patch emulates this situation
> 
> Please, put periods at the end of the phrases.
> 
> >  	/*
> > -	 * According to the datasheet the power supply rise time i 200us
> > +	 * According to the datasheet the power supply rise time is 200us
> >  	 * and the minimum wait time before mode setting is 100us, in
> > -	 * total 300 us. Add some margin and say minimum 500us here.
> > +	 * total 300us. Add some margin and say minimum 500us here.
> >  	 */
> 
> This is not related change (perhaps, you may do in separate patch), but I'm not
> against it. Up to maintainer.
> 

Ok I will separate the patch

> > +	/*
> > +	 * According to AK09911 datasheet, if reset gpio is provided then
> > +	 * deassert reset on ak8975_power_on and assert reset on
> > +	 * ak8975_power_off.
> 
> We try to refer to the code accordingly to the kernel doc recommendations (even
> for non-kdoc comments). So, here, 'function' as 'function()' (without quotes)
> and so on.
> 

Will fix this as like as the other changes you pointed out about periods and
trailing spaces as soon as possible

> > +	 */
> > +	reset_gpiod = devm_gpiod_get_optional(&client->dev,
> > +					      "reset", GPIOD_OUT_HIGH);
> > +	if (IS_ERR(reset_gpiod))
> > +		return PTR_ERR(reset_gpiod);
> > +
> >  	/* Register with IIO */
> >  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> >  	if (indio_dev == NULL)
> > @@ -866,6 +883,7 @@ static int ak8975_probe(struct i2c_client *client,
> >  
> >  	data->client = client;
> >  	data->eoc_gpiod = eoc_gpiod;
> > +	data->reset_gpiod = reset_gpiod;
> >  	data->eoc_irq = 0;
> >  
> >  	err = iio_read_mount_matrix(&client->dev, "mount-matrix", &data->orientation);
> > -- 
> > 2.17.1
> > 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

Again, thank you,
Best regards,
Jonathan Albrieux
