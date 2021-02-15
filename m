Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA4C31BAEB
	for <lists+linux-iio@lfdr.de>; Mon, 15 Feb 2021 15:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbhBOOXB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Feb 2021 09:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbhBOOXA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Feb 2021 09:23:00 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A7FC061574
        for <linux-iio@vger.kernel.org>; Mon, 15 Feb 2021 06:22:19 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id g6so9078656wrs.11
        for <linux-iio@vger.kernel.org>; Mon, 15 Feb 2021 06:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=cNvVdIdxlGj+Sfuamem72Qeix0oXAhgklbIFT61Vzrw=;
        b=bmcYji8KmCDbksc8hp2MPVH5eDhkXRgtiRRfCRq6DoX2SEzAHyOlzQ8MimKicYZ9xC
         7T87ysTFuAlWQw/+jY0Gid3ydZ+2hT460y3G8h1X2uC2a78MZckm5G4Noz+gW+rkep05
         lVKA9dNP2HfcTsfjRTtZvbrLf5wmJAOZE4k+2Dh5baeQhavOwAiNWxaC6o6QaM9+8zP/
         54JW0GJMfUMwO2nQg8Py25NO45SApbJ8njSeJ1SDZgXnhEmwi6VtSn2qwARAwFplSZgV
         KZrsU//AhVGco7TlybPeYe9+BZSj0rvHalZIUlQ4kyX3keUE81D19FNWvFN39+PVh+bZ
         YcFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=cNvVdIdxlGj+Sfuamem72Qeix0oXAhgklbIFT61Vzrw=;
        b=kVvEmOF7cu+4BOnK/zSDLO8YsXAAe1qaKGrVP50+rzXiEnUEenx2nJWJlPnq826o1D
         f43Q3ZHMyS6E2b8Lrm3aSlw2IbBKonSfZmyxlLtqziaFA98c5lHGAOVeVub6wL0ggc5l
         h75S930SIliuKau/ejtObmFcvofZpoDf1JdHbFzCWa+v9mCvEtGF3gccu1tU8P4zTNa4
         PqPu1JZfk3caMETwFt6kGftQvheUTAhL2EARwrwCZYo1wmFcEWUspaIPNRS0HjPE1ajk
         tJFT09sU0EgEpRq9Or855P/PMWj4mILf6t7Cxn4KVegVujJHx+qVMJ2Rp3w2M/RVsc8o
         9Lbg==
X-Gm-Message-State: AOAM5323789lHWIfsF1TeOLeFA04Xma9rYidA/cimrC87gZ20foej0nL
        laOIbpvr5amaRHZ1jiocZbCERA==
X-Google-Smtp-Source: ABdhPJyvLoPzpqgceTkmdirn2jBoo7kyNUoI9xyniMGSW3yxHYUlh/mGG05y681DGTzNHzaIx7MD9w==
X-Received: by 2002:adf:fc4c:: with SMTP id e12mr19808318wrs.106.1613398938553;
        Mon, 15 Feb 2021 06:22:18 -0800 (PST)
Received: from dell ([91.110.221.146])
        by smtp.gmail.com with ESMTPSA id f14sm17218090wmg.28.2021.02.15.06.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 06:22:18 -0800 (PST)
Date:   Mon, 15 Feb 2021 14:22:16 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Emil Velikov <emil.l.velikov@gmail.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>, linux-pwm@vger.kernel.org,
        linux-fbdev <linux-fbdev@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linux PM <linux-pm@vger.kernel.org>, linux-iio@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, Pavel Machek <pavel@ucw.cz>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH v4] MAINTAINERS: move Milo Kim to credits
Message-ID: <20210215142216.GA4770@dell>
References: <20210212163229.68270-1-krzk@kernel.org>
 <20210215085241.GG179940@dell>
 <CACvgo53wn84G8wuyF++=bwtjnVzVB31BA2_JBWnihnwinSFD7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACvgo53wn84G8wuyF++=bwtjnVzVB31BA2_JBWnihnwinSFD7A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 15 Feb 2021, Emil Velikov wrote:

> Greetings everyone,
> 
> On Mon, 15 Feb 2021 at 08:52, Lee Jones <lee.jones@linaro.org> wrote:
> >
> > On Fri, 12 Feb 2021, Krzysztof Kozlowski wrote:
> >
> > > Milo Kim's email in TI bounces with permanent error (550: Invalid
> > > recipient).  Last email from him on LKML was in 2017.  Move Milo Kim to
> > > credits and remove the separate driver entries for:
> > >  - TI LP855x backlight driver,
> > >  - TI LP8727 charger driver,
> > >  - TI LP8788 MFD (ADC, LEDs, charger and regulator) drivers.
> > >
> > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > > Cc: Mark Brown <broonie@kernel.org>
> > > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Cc: Jingoo Han <jingoohan1@gmail.com>
> > > Cc: Lee Jones <lee.jones@linaro.org>
> > > Cc: Pavel Machek <pavel@ucw.cz>
> > > Cc: Thierry Reding <thierry.reding@gmail.com>
> > > Cc: Sebastian Reichel <sre@kernel.org>
> > > Cc: Daniel Thompson <daniel.thompson@linaro.org>
> > >
> > > ---
> > >
> > > Dear Lee,
> > >
> > > Could you take care about this patch?
> >
> > Yes, but I'll be sending out my pull-request for v5.12 in the next
> > couple of days (maybe even today if I can find some time), so this
> > will have to wait until v5.13.
> >
> Would it make sense to keep the MAINTAINERS entries as "orphan"?
> Checking with linux-next, the drivers are still present in-tree.

Please see:

 https://lore.kernel.org/patchwork/patch/1379016/

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
