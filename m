Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 899A01B7283
	for <lists+linux-iio@lfdr.de>; Fri, 24 Apr 2020 12:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbgDXKxY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 Apr 2020 06:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbgDXKxX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Apr 2020 06:53:23 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6D3C09B047
        for <linux-iio@vger.kernel.org>; Fri, 24 Apr 2020 03:53:22 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id b11so10226296wrs.6
        for <linux-iio@vger.kernel.org>; Fri, 24 Apr 2020 03:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ANVFxj0a3PZxuvcR/cQpqDlmHqLVaxnBkwvzY2D+yRQ=;
        b=TqnzzbkLwgVbmsD15PJo6vPGbNOmNr2/mJjPgL9eevI2ZbgbaLKHqzcjjpusU51Doh
         NVKcjMg+bWBhUhNbQDdkbqj9ERt0ChWSN01vAzVDSi9CmtdIQtsX8VUHEB3/jNNRSerX
         y9U+/g8CZ27zw3gjVVpl4mV24Jl5Fr5r/scKO/zgNbjmn48lfTIykG9/YnSj4IzlpQ7x
         9sCMoDp9Q+frjZdGucx9E0GLUTjBwivWtbkXOEqoXAzz/EXNwZawwuny5QWFYB/4wCko
         MgQOaXyD5AxOimhaN8V4FFfg8BCImvzBgwiESTze/+9yXbeRgPdupE3wfoBu6Sl2sbkX
         PAyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ANVFxj0a3PZxuvcR/cQpqDlmHqLVaxnBkwvzY2D+yRQ=;
        b=BQRbeJ2ORUNU3xDKk7zZA3/XOuimAsNdDGaAfzz1dPu7E8I3NXksQcQMFKwviCa8ks
         FDrcZ5E/AxaNRoRQBbie8gFKC8edOp5YQZ//gjnNhxrsQoFWAs6/SNRv9Uqd+7dG4X5Y
         tzpSfILjTTlZIVt7o4iZnrVN00vNZWRibjd7Xe8jwakuVtPM3E4JmN6j/hJNidso32nO
         G0U95V7lFestXETXDf0t7Y6tOAe3k025N8XMPDE6HJQy8KDeyhlAqOgFo5nr8aFmPNsk
         5I9lqreZcVGNJlI5GoTiSFAMIeIOTd3a/XMtB0MVZkX37SeLNoI4Sd8MrJK08IIGF7+F
         Mq4A==
X-Gm-Message-State: AGi0PubR6kWYP2kg9EpTYcI6shOvCE1F3qrs3ZDHH6oqath2gAU77qg4
        /M3asEGLQeibXQUzUkJnRp+kFQ==
X-Google-Smtp-Source: APiQypKP9clOM1Dthyy7Ek8Ij90zL+Giy22gsKlvN3INV/Bf1kE9Y4mK9kb1o6kuHIq3Nyvws+waXA==
X-Received: by 2002:adf:cd12:: with SMTP id w18mr10512940wrm.177.1587725601416;
        Fri, 24 Apr 2020 03:53:21 -0700 (PDT)
Received: from dell ([2.31.163.63])
        by smtp.gmail.com with ESMTPSA id c25sm2218532wmb.44.2020.04.24.03.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 03:53:20 -0700 (PDT)
Date:   Fri, 24 Apr 2020 11:53:19 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     saravanan sekar <sravanhome@gmail.com>
Cc:     andy.shevchenko@gmail.com, robh+dt@kernel.org, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        sre@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v9 2/6] mfd: mp2629: Add support for mps battery charger
Message-ID: <20200424105319.GD8414@dell>
References: <20200415162030.16414-1-sravanhome@gmail.com>
 <20200415162030.16414-3-sravanhome@gmail.com>
 <20200424071822.GM3612@dell>
 <8ff17d07-8030-fcfe-8d8a-3011e4077778@gmail.com>
 <20200424093720.GA3542@dell>
 <864eb6ad-a605-c0a0-c3e7-23c0c70f5ede@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <864eb6ad-a605-c0a0-c3e7-23c0c70f5ede@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 24 Apr 2020, saravanan sekar wrote:

> Hi Lee,
> 
> On 24/04/20 11:37 am, Lee Jones wrote:
> > On Fri, 24 Apr 2020, saravanan sekar wrote:
> > 
> > > Hi Lee,
> > > 
> > > On 24/04/20 9:18 am, Lee Jones wrote:
> > > > On Wed, 15 Apr 2020, Saravanan Sekar wrote:
> > > > 
> > > > > mp2629 is a highly-integrated switching-mode battery charge management
> > > > > device for single-cell Li-ion or Li-polymer battery.
> > > > > 
> > > > > Add MFD core enables chip access for ADC driver for battery readings,
> > > > > and a power supply battery-charger driver
> > > > > 
> > > > > Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> > > > > ---
> > > > >    drivers/mfd/Kconfig        |  9 ++++
> > > > >    drivers/mfd/Makefile       |  2 +
> > > > >    drivers/mfd/mp2629.c       | 86 ++++++++++++++++++++++++++++++++++++++
> > > > >    include/linux/mfd/mp2629.h | 19 +++++++++
> > > > >    4 files changed, 116 insertions(+)
> > > > >    create mode 100644 drivers/mfd/mp2629.c
> > > > >    create mode 100644 include/linux/mfd/mp2629.h
> > > > How is this driver registered?
> > > > 
> > > > Looks like it has device tree support.  Is there another way?
> > > Yes, only using device tree
> > Then how about using 'simple-mfd' and 'syscon'?
> > 
> > Then you can omit this driver completely.
> 
> The exception is to support for non device tree platform as well, but I have
> tested only for ARM device tree platform.

Is that a reality though?

How else do you see this realistically being registered?

> > > > > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > > > > index 3c547ed575e6..85be799795aa 100644
> > > > > --- a/drivers/mfd/Kconfig
> > > > > +++ b/drivers/mfd/Kconfig
> > > > > @@ -434,6 +434,15 @@ config MFD_MC13XXX_I2C
> > > > >    	help
> > > > >    	  Select this if your MC13xxx is connected via an I2C bus.
> > > > > +config MFD_MP2629
> > > > > +	tristate "Monolithic power system MP2629 ADC and Battery charger"
> > > > > +	depends on I2C
> > > > > +	select REGMAP_I2C
> > > > > +	help
> > > > > +	  Select this option to enable support for monolithic power system
> > > > > +	  battery charger. This provides ADC, thermal, battery charger power
> > > > > +	  management functions on the systems.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
