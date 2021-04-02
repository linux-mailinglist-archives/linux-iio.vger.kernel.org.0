Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CECD835248C
	for <lists+linux-iio@lfdr.de>; Fri,  2 Apr 2021 02:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbhDBAns (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Apr 2021 20:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbhDBAnr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Apr 2021 20:43:47 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5F3C0613E6;
        Thu,  1 Apr 2021 17:43:46 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id y6so3917094eds.1;
        Thu, 01 Apr 2021 17:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7UrqDDIRn+G5yinBQZ3ltJnZdRsMl7oWcUPTgk2Dir4=;
        b=XYZnRD8SG0fD4hiN/6u5iJnkyNaBaChUDm+M0Q7D2dy9lsSNGUDOPlvUg0czvyN+sr
         Q7wHzsfyxEFdbzvKRawoe+5i7mQpyC+Dk7ePIYTkkk+UB8zDRShF0BXj2ZHacwf2I/HJ
         D11+Uzo6x9Z/2b25FBdi0OXQwSbtOcexXwolmIcQT2Yapk7QW7GbhY/aNGQv8/ldZcec
         1jSMs+vllkYo5wFME0tCgF5vYL2Hfgin3BW3CVE4+pj4KzW3iKVmzS01j/qm9UCQzjU/
         7k4QSPjcNRoQ9cPHD9chHhrIfeWpRfaqqSq120QxxZO64yAmB+Sk4n/MvgW4thtr5T2S
         4OpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7UrqDDIRn+G5yinBQZ3ltJnZdRsMl7oWcUPTgk2Dir4=;
        b=Yt9KtciHy/m3vxU5gu7ednhr7dJm8GjKaZl1pmkdTISOdT7z9M2ibUu0vhfKKAg5S6
         up8PFOYieAHW0WZ1fzHLh8vcgSSKiHn2iJTJPGuOX23DssVgUxBXLNiZBD9ISjCKzImg
         6MvtZnjoe7ROLTNVvRevqsxgK8FGX1SM/PLq08VuVzoPJowRRglYANwY9q+etp76RB4G
         gFCK9sU+m+mVWLVAlmFcr3rM3rfQJD5pbmKS8Vki2vxkyPWjWtp2f9G/BO9wtGuraN8G
         MPhZzOgTQ5vfk74ZdnAFkBtC8/AC/tAB68NffmwQCgJlgQI9Vg/CIi2nKl/LrENFa4Mn
         ajfg==
X-Gm-Message-State: AOAM5302Cgg7B5uPwh5kvZb7iKzeFYt6SyRTE9Ft8qigipFYQe9TaLSg
        XtaR9zhlIFbq1JvPVS1vRwA=
X-Google-Smtp-Source: ABdhPJymnDNjJPPhcffXrecS1m6STmKkl5TA3xsipMY5so77b22+mxwc1TfydA+yvQBgzb8BhZl91Q==
X-Received: by 2002:a05:6402:278d:: with SMTP id b13mr12641332ede.34.1617324224900;
        Thu, 01 Apr 2021 17:43:44 -0700 (PDT)
Received: from pop-os.localdomain (cpc97922-walt21-2-0-cust248.13-2.cable.virginm.net. [82.16.251.249])
        by smtp.gmail.com with ESMTPSA id p19sm4560876edr.57.2021.04.01.17.43.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Apr 2021 17:43:44 -0700 (PDT)
Date:   Fri, 2 Apr 2021 01:43:42 +0100
From:   Joe Sandom <joe.g.sandom@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 1/2] Added AMS tsl2591 driver implementation
Message-ID: <20210402004342.bkbtgc2yondhnwto@pop-os.localdomain>
References: <20210325220505.14507-1-joe.g.sandom@gmail.com>
 <CAHp75VcfE0VUrtAqCM0KC9RFvy8XMv++tjYCP2dKZCMosPQ2tw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VcfE0VUrtAqCM0KC9RFvy8XMv++tjYCP2dKZCMosPQ2tw@mail.gmail.com>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Mar 26, 2021 at 01:01:57PM +0200, Andy Shevchenko wrote:
> On Fri, Mar 26, 2021 at 12:05 AM Joe Sandom <joe.g.sandom@gmail.com> wrote:
> >
> > Driver implementation for AMS/TAOS tsl2591 ambient light sensor.
> >
> > This driver supports configuration via device tree and sysfs.
> > Supported channels for raw infrared light intensity,
> > raw combined light intensity and illuminance in lux.
> > The driver additionally supports iio events on lower and
> > upper thresholds.
> >
> > This is a very-high sensitivity light-to-digital converter that
> > transforms light intensity into a digital signal.
> 
> I'm under the impression that you ignored at least half of my comments

The majority of your comments were applied in V5 as far as I can see.
Some of them I recognised as optional at the time. I had another sweep
through and have seen value in enforcing a few of the other points you
mentioned. I've added them to V7 and will release shortly. Thanks for
the feedback Andy.

> [1]. Have you seen them?
> 
> [1]: https://lore.kernel.org/linux-iio/CAHp75VcSW2xXdH--rXaN7xt0Ju+qfw9c_va0gGRGPgpBua0H-Q@mail.gmail.com/
> 
> Please. address and come again.
> NAK for this version, sorry.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
