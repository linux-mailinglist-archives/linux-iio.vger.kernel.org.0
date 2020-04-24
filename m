Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20A951B7111
	for <lists+linux-iio@lfdr.de>; Fri, 24 Apr 2020 11:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbgDXJh0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 Apr 2020 05:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726298AbgDXJh0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Apr 2020 05:37:26 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C99C09B048
        for <linux-iio@vger.kernel.org>; Fri, 24 Apr 2020 02:37:24 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id u16so9917630wmc.5
        for <linux-iio@vger.kernel.org>; Fri, 24 Apr 2020 02:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=lpgfeCztxAhzxjhQqiFZc+a2M7I9kDIUKtebW9THuHo=;
        b=E+H+PKEWckalgAUrAxfA2tUr4Dr5zRoWeGzskBy6H53BglCw3eP155NoYhsC7jdQiI
         qluFEhKpQ+DSHSzqLqSZMeD0k14RwoB+SUuhVdhR8jgyw4gXACOPaWr9XutcMcLuLel3
         8WZxlynNH7qJd0BspwLL1sYeTrHFFu3a76G+RdF7obaS1pLM1DSCbMFbNY9dK4EZ5ymT
         tlnH/ERsB9TegNHu+KfzIuiJdzFqqCnkwQ8PTxfEGIX3McYJjbN7mZF6m5rNJlKz3aGn
         ZTeNp7OtPikPXwo7ZqOKDOi+bqkFqVzNR4szarGXzmGI+oivP5a8mWF6fMD7ByBzQbzj
         15Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lpgfeCztxAhzxjhQqiFZc+a2M7I9kDIUKtebW9THuHo=;
        b=dWF+8aUvF5zARbwoAfjSNa14oBx5tgN04JTltQNoWyVMXf5D7+DWGIGrGTi4qEnxEF
         arPKqK7QGCQ9QXmrOII3RV0HhjHij8uWguOBl1FU60OSkXB2QB61yFN2kRWHdFOseHke
         nk1OmIciLtmeiAxAIsxJm5jtCyGG7GLpbTa2G7Ub7nQT0aPr3ITqmy8J0dE1YjASLl5C
         i0RjEa46CkNtSKQTLSyFvMLEQvEw8B/beVaWOUF1af0ghapkGgt1dbuz57IpFeSwqlXM
         aiHoXhQgjRSTDrT3BdXoyGZCLmXqAgCATAG7uPASS8GnaPou6lCcUOLHLngwLgc/fwvN
         lMXw==
X-Gm-Message-State: AGi0PubcqLosjWMtS9HFHUETDKX0A9NsdHkCiUThssdZKX7h98NVcpLA
        Ry6vg6oK6i/lKtDLhzlakncwSA==
X-Google-Smtp-Source: APiQypIP711LckL5LI1ubR6GN3OUzUAydpJDOVRvnJ3Nw6MpHq29JuuPonguAQ22PujRITptpK9QEA==
X-Received: by 2002:a7b:c213:: with SMTP id x19mr8902459wmi.53.1587721043049;
        Fri, 24 Apr 2020 02:37:23 -0700 (PDT)
Received: from dell ([2.31.163.63])
        by smtp.gmail.com with ESMTPSA id a7sm2062330wmj.12.2020.04.24.02.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 02:37:22 -0700 (PDT)
Date:   Fri, 24 Apr 2020 10:37:20 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     saravanan sekar <sravanhome@gmail.com>
Cc:     andy.shevchenko@gmail.com, robh+dt@kernel.org, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        sre@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v9 2/6] mfd: mp2629: Add support for mps battery charger
Message-ID: <20200424093720.GA3542@dell>
References: <20200415162030.16414-1-sravanhome@gmail.com>
 <20200415162030.16414-3-sravanhome@gmail.com>
 <20200424071822.GM3612@dell>
 <8ff17d07-8030-fcfe-8d8a-3011e4077778@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8ff17d07-8030-fcfe-8d8a-3011e4077778@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 24 Apr 2020, saravanan sekar wrote:

> Hi Lee,
> 
> On 24/04/20 9:18 am, Lee Jones wrote:
> > On Wed, 15 Apr 2020, Saravanan Sekar wrote:
> > 
> > > mp2629 is a highly-integrated switching-mode battery charge management
> > > device for single-cell Li-ion or Li-polymer battery.
> > > 
> > > Add MFD core enables chip access for ADC driver for battery readings,
> > > and a power supply battery-charger driver
> > > 
> > > Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> > > ---
> > >   drivers/mfd/Kconfig        |  9 ++++
> > >   drivers/mfd/Makefile       |  2 +
> > >   drivers/mfd/mp2629.c       | 86 ++++++++++++++++++++++++++++++++++++++
> > >   include/linux/mfd/mp2629.h | 19 +++++++++
> > >   4 files changed, 116 insertions(+)
> > >   create mode 100644 drivers/mfd/mp2629.c
> > >   create mode 100644 include/linux/mfd/mp2629.h
> > How is this driver registered?
> > 
> > Looks like it has device tree support.  Is there another way?
> Yes, only using device tree

Then how about using 'simple-mfd' and 'syscon'?

Then you can omit this driver completely.

> > > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > > index 3c547ed575e6..85be799795aa 100644
> > > --- a/drivers/mfd/Kconfig
> > > +++ b/drivers/mfd/Kconfig
> > > @@ -434,6 +434,15 @@ config MFD_MC13XXX_I2C
> > >   	help
> > >   	  Select this if your MC13xxx is connected via an I2C bus.
> > > +config MFD_MP2629
> > > +	tristate "Monolithic power system MP2629 ADC and Battery charger"
> > > +	depends on I2C
> > > +	select REGMAP_I2C
> > > +	help
> > > +	  Select this option to enable support for monolithic power system
> > > +	  battery charger. This provides ADC, thermal, battery charger power
> > > +	  management functions on the systems.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
