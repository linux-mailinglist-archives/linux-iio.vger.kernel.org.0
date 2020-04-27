Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 223E11B9ACC
	for <lists+linux-iio@lfdr.de>; Mon, 27 Apr 2020 10:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgD0Ivy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Apr 2020 04:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgD0Ivy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Apr 2020 04:51:54 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F229C061A0F
        for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2020 01:51:53 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id j1so19545443wrt.1
        for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2020 01:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=YPX4x0jDIEDTz7nvc7sn5bHK6BG3ihIkRvdS/BPSLzE=;
        b=kWzVEYgY/9/widQPXrFcowP4ZjgLQHkdS9enzKduSjdkfx0EjP8bo0XL/1eJr3WKSX
         JaXngTlXbRhWYn2hX9lTbL3BYOqB19rkhQThOErWAmIF/qonKh6RswR09vTh231Wumen
         kkhqjmo/YdeXh0zkjImVDbUiZWOQt5OyFIRoy4ZvEENcfdPREtsZ5U6G1/quPfUCxTIt
         5WXJoK36jKqIJyTxsTPlB5EpFR3KR7+KpsTR2iyPEYyeeX6eEN0rh8FYAJP1NsCNeGda
         ozRxEpQyGjVLx9eZmfL6/SZ/2VZ5D0pd0rGMWpG6pqLBK3piKAxPdyCLrOe8OBJMZ1fF
         OK0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=YPX4x0jDIEDTz7nvc7sn5bHK6BG3ihIkRvdS/BPSLzE=;
        b=hiD0LRy10O/EteUgnDhqVJnS8PW7+NTsa8RIv+yGDDLZveBSMYZgeIBIXghW1j7+ia
         NXOQPuj+VwJni7il0kO8yt/jxZuOqVxGnlmb4HSXTWVIR5C15YHQW2TOtw7QTOO33YOa
         pUgh4HQhY595S23+CY4GnouFqxjI+AGVtF8R1VAimsK12ey7vBCDloW4Ist7o/mD59Cq
         mCa++XconO1ba6tY31Q3d9iyVKq1MfStRZlR3KVP2MUYncnsOFOO3Y124sehjWwDC0BA
         q+afGAVgaeprLDEVl2Up2Yg74ZNSO9nzfspCgTXa5eh9QQDHvDNqZskiKFCIdJseMHv6
         03hw==
X-Gm-Message-State: AGi0PubIBD9DERVPJpioE1SayhakXf7ls3aiVHqW38CWONGp2CXd1nWC
        B/5pdOEs6jceYMSrFteSoAGxs9F3lCE=
X-Google-Smtp-Source: APiQypLxApUbpg3TJ0ILuchowzV4ZZ5EBCvXW4eaI3vv4CK0MLDKEWjIbJVseNky+c8kdrfJlPFTuQ==
X-Received: by 2002:adf:dd8a:: with SMTP id x10mr26630284wrl.308.1587977511933;
        Mon, 27 Apr 2020 01:51:51 -0700 (PDT)
Received: from dell ([2.31.163.63])
        by smtp.gmail.com with ESMTPSA id x18sm14507505wmi.29.2020.04.27.01.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 01:51:51 -0700 (PDT)
Date:   Mon, 27 Apr 2020 09:51:49 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     saravanan sekar <sravanhome@gmail.com>
Cc:     andy.shevchenko@gmail.com, robh+dt@kernel.org, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        sre@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v9 2/6] mfd: mp2629: Add support for mps battery charger
Message-ID: <20200427085149.GF3559@dell>
References: <20200415162030.16414-1-sravanhome@gmail.com>
 <20200415162030.16414-3-sravanhome@gmail.com>
 <20200424071822.GM3612@dell>
 <8ff17d07-8030-fcfe-8d8a-3011e4077778@gmail.com>
 <20200424093720.GA3542@dell>
 <864eb6ad-a605-c0a0-c3e7-23c0c70f5ede@gmail.com>
 <20200424105319.GD8414@dell>
 <c62cd5f2-6d82-0a2a-5ee5-a3e99e188a05@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c62cd5f2-6d82-0a2a-5ee5-a3e99e188a05@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 24 Apr 2020, saravanan sekar wrote:

> 
> On 24/04/20 12:53 pm, Lee Jones wrote:
> > On Fri, 24 Apr 2020, saravanan sekar wrote:
> > 
> > > Hi Lee,
> > > 
> > > On 24/04/20 11:37 am, Lee Jones wrote:
> > > > On Fri, 24 Apr 2020, saravanan sekar wrote:
> > > > 
> > > > > Hi Lee,
> > > > > 
> > > > > On 24/04/20 9:18 am, Lee Jones wrote:
> > > > > > On Wed, 15 Apr 2020, Saravanan Sekar wrote:
> > > > > > 
> > > > > > > mp2629 is a highly-integrated switching-mode battery charge management
> > > > > > > device for single-cell Li-ion or Li-polymer battery.
> > > > > > > 
> > > > > > > Add MFD core enables chip access for ADC driver for battery readings,
> > > > > > > and a power supply battery-charger driver
> > > > > > > 
> > > > > > > Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> > > > > > > ---
> > > > > > >     drivers/mfd/Kconfig        |  9 ++++
> > > > > > >     drivers/mfd/Makefile       |  2 +
> > > > > > >     drivers/mfd/mp2629.c       | 86 ++++++++++++++++++++++++++++++++++++++
> > > > > > >     include/linux/mfd/mp2629.h | 19 +++++++++
> > > > > > >     4 files changed, 116 insertions(+)
> > > > > > >     create mode 100644 drivers/mfd/mp2629.c
> > > > > > >     create mode 100644 include/linux/mfd/mp2629.h
> > > > > > How is this driver registered?
> > > > > > 
> > > > > > Looks like it has device tree support.  Is there another way?
> > > > > Yes, only using device tree
> > > > Then how about using 'simple-mfd' and 'syscon'?
> > > > 
> > > > Then you can omit this driver completely.
> > > The exception is to support for non device tree platform as well, but I have
> > > tested only for ARM device tree platform.
> > Is that a reality though?
> > 
> > How else do you see this realistically being registered?
> > 
> I understand that acpi related device table are not covered here, well I
> don't have to platform to test so.
> If you ask me to cover acpi related table, I can do but hard to test.

I don't know of any reasons why syscon can't be used by ACPI.

Please try to solve this issue using 'simple-mfd' and 'syscon'.

> > > > > > > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > > > > > > index 3c547ed575e6..85be799795aa 100644
> > > > > > > --- a/drivers/mfd/Kconfig
> > > > > > > +++ b/drivers/mfd/Kconfig
> > > > > > > @@ -434,6 +434,15 @@ config MFD_MC13XXX_I2C
> > > > > > >     	help
> > > > > > >     	  Select this if your MC13xxx is connected via an I2C bus.
> > > > > > > +config MFD_MP2629
> > > > > > > +	tristate "Monolithic power system MP2629 ADC and Battery charger"
> > > > > > > +	depends on I2C
> > > > > > > +	select REGMAP_I2C
> > > > > > > +	help
> > > > > > > +	  Select this option to enable support for monolithic power system
> > > > > > > +	  battery charger. This provides ADC, thermal, battery charger power
> > > > > > > +	  management functions on the systems.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
