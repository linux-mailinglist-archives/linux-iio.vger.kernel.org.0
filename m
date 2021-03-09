Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6DB332399
	for <lists+linux-iio@lfdr.de>; Tue,  9 Mar 2021 12:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbhCILFu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Mar 2021 06:05:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhCILFo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Mar 2021 06:05:44 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB11C06174A;
        Tue,  9 Mar 2021 03:05:43 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id lr10-20020a17090b4b8ab02900dd61b95c5eso2550450pjb.4;
        Tue, 09 Mar 2021 03:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3T4W4xV4Tf3QOElTCSezyQGIMFwB4ft/YIBh6UXVS8s=;
        b=RIY35qb6rf0fzFHNnG54ojrKJX9RKNfRAtFmlwJlQouu+k/mgFGYylDSGNJ2/e3OsH
         zUTAhWc3w4FMtnnANd/1aZT7deE7RjOkc134fnm5q26+a63FG1pdJwrm+lmYw5IbTTSC
         xQ+b8AdQcyKU57HJOaMOqDZJc4rDQOH1XDz9ogRgPh5cXPb3pNhaDkx/GG9q28zU6ygd
         cbKepLPv/pnTcxw+ESAKe3n8wWny4gu+00fpTEEdZMwEFAY+x4rUECMgfslfTw1jdpvx
         lAXkbcSkHjfc1A/lzVfeywPrqGAqjm5aXOsXCWSYNwqGdzMppa0YlTRnrv1yvq/nzTot
         T5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3T4W4xV4Tf3QOElTCSezyQGIMFwB4ft/YIBh6UXVS8s=;
        b=EqQ7CxduprRdmBpmEGMg/P4RdZJBROC4peWfRsjH3mwpkw9ijv/FdPJql2jE6J7xEt
         WY+MEvjlh5o7W9S9nox35oaN+emm02ToWEgDJm8T74TtjDwboawTXEsj2z8cba92YEZs
         +jnU7Td1ZC0s8fNtzKUF32PRDYg2rxXCKHR5PvBX5vJn8lHo5lrl5XsHwevhJ4CaVM7c
         pHz9tgISTWgfpqG0vIgBNLYhvkBbMoA70hdpBcdNOhPaTE1/i9IWIoMps7v2FW+3njvX
         wZt3kxV9wNqrjDvl5ev7jRsJMHFlzeE6Gg9zlHyUc2drPdlswqBWhc6igPICFEAQPcr1
         kxWg==
X-Gm-Message-State: AOAM533/IefIXL+I8uAPcfhQfHVOBHTSLhrytETpQn8IbR/4OKei890q
        MygIwUKNp1hDwMOqCyKCIB//iI9colkOoMD3XxTOVZh8C++nuQ==
X-Google-Smtp-Source: ABdhPJzIuJ6hLAK8fFWlrH+mxFgPVgYC2CvPYakI0dg/jy1WNPvCByyQjHV+7I3A5z7rd2DWJLua2Kz7/HyVVcRGDMc=
X-Received: by 2002:a17:90a:db49:: with SMTP id u9mr4261198pjx.181.1615287943267;
 Tue, 09 Mar 2021 03:05:43 -0800 (PST)
MIME-Version: 1.0
References: <20210305133813.27967-1-o.rempel@pengutronix.de>
 <20210305133813.27967-3-o.rempel@pengutronix.de> <20210305190239.000075fe@Huawei.com>
In-Reply-To: <20210305190239.000075fe@Huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 9 Mar 2021 13:05:27 +0200
Message-ID: <CAHp75Veu-G41mDUZubCgHD_V+_znd0HJoO03ZL7JpgwtjMYLCQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] iio: adc: add ADC driver for the TI TSC2046 controller
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Mar 5, 2021 at 9:05 PM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Fri, 5 Mar 2021 14:38:13 +0100
> Oleksij Rempel <o.rempel@pengutronix.de> wrote:
>
> > Basically the TI TSC2046 touchscreen controller is 8 channel ADC optimized for
> > the touchscreen use case. By implementing it as IIO ADC device, we can
> > make use of resistive-adc-touch and iio-hwmon drivers.
> >
> > So far, this driver was tested with custom version of resistive-adc-touch driver,
> > since it need to be extended to make use of Z1 and Z2 channels. The X/Y
> > are working without additional changes.
> >
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
>
> Hi Oleksij,
>
> To consider this as a possible long term route instead of just making this
> a touchscreen driver, we'll want to see those mods to the resistive-adc-touch.
> Of course that doesn't stop review of this in the meantime.
>
> There are quite a few things in here that feel pretty specific to the touchscreen
> usecase. That makes me wonder if this is a sensible approach or not.

I'm wondering if this has any similarities with existing drivers under
drivers/input/touchscreen.

-- 
With Best Regards,
Andy Shevchenko
