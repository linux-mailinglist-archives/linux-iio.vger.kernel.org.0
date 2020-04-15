Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B10401AAF13
	for <lists+linux-iio@lfdr.de>; Wed, 15 Apr 2020 19:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410666AbgDORFW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Apr 2020 13:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410659AbgDORFU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Apr 2020 13:05:20 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1561C061A0C;
        Wed, 15 Apr 2020 10:05:20 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id d17so214597pgo.0;
        Wed, 15 Apr 2020 10:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0AyhE+CJcuvLJxqL2z6J7uq4KCxVwXM0hQdDcmyUWAY=;
        b=Ug3NRXJ3oZy5EhH7W93/FDpaX87Chj7NImU0fkg87IHrQy0MjCi1Z4Ll8TUe6lH+GX
         UcqSYM51MRv0vg4XWl8oJVDg89eAgIq/IpA431B5CYegYHxv5RIFHXGEWaPjwsOPZwSb
         fY7obQZ8vWsitSjpfWrMzFKYdv2k3Fcx8SZt7p+F/QKMhANwcUS2xnM6cH/IghaL2ITF
         YXikU/OXSxp0kIQf9Zckk4KXTLhYgv8es/6kZ1MwvN5OW5pfAN1xjGxFaozBmKDWN51G
         3PZkhT8MXZmccU/DvzqMi/+TXieOWKrMNaYUF85NbZPArwj9sW5moAF4CkW3HBzWRGf7
         MHpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0AyhE+CJcuvLJxqL2z6J7uq4KCxVwXM0hQdDcmyUWAY=;
        b=XiLOv0L/21MM/GKHpRAZJhs/JKxNHavuVRrjO27Zc1/bbB5yp8rulXpELvsp8Cnyjz
         IPctUEtoUMRVp463MekoSNEotuNPl6SlsJH4AQ323dPTDXWMIFKrTaAHxW1yC4oPgNZV
         +aTqLOTSHAOdyxy1/70hpzpUfDoMosfl+33cFaUpOFQd/ilY6IWYKWRWYLxWLy2TYLb9
         +AmniLWVHmhRM3odEhsLzSZICzxTj80n6WAkp084sklhxhUP8MEyNJDE49kdnCUdwrGL
         pX8YOyG9fJECXpmalsvgi4Imi7yWEVRtdhOPqf96k9O8SU8Cj2dAX268r3OiFmRHd0hC
         t8dQ==
X-Gm-Message-State: AGi0Pua5kPXl5HbiwieBy8MNpZjm/BFFfC30eJk6GXFCWY0H1jkK02TE
        4fwO4QXYNgLRpTvOCLaqQlttD8w5N5v6koqH1H0=
X-Google-Smtp-Source: APiQypJwxVjH6YxiBycXKhEmsD67Wygk8gI1cdUWc3aOnIwtjqPxeiQTzcTh9wWXd9hwUNhlgdFZ/mE2eqmlEkQdNPk=
X-Received: by 2002:a63:1d4:: with SMTP id 203mr26556401pgb.74.1586970320093;
 Wed, 15 Apr 2020 10:05:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200415162030.16414-1-sravanhome@gmail.com> <CAHp75VerGG0_J+fHrZfwJRa3EHtGuz-pJbD7zwoXN2jfO7dszA@mail.gmail.com>
 <dea1d71e-af5d-356a-79c0-38f343f54dfd@gmail.com>
In-Reply-To: <dea1d71e-af5d-356a-79c0-38f343f54dfd@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 15 Apr 2020 20:05:12 +0300
Message-ID: <CAHp75VeHxPFah+02Rj4efziM5bkwbe086aEQOJoHQed0jZmCHw@mail.gmail.com>
Subject: Re: [PATCH v9 0/6] Add battery charger driver support for MP2629
To:     saravanan sekar <sravanhome@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Sebastian Reichel <sre@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Apr 15, 2020 at 7:53 PM saravanan sekar <sravanhome@gmail.com> wrote:
>
> Hi Andy,
>
> On 15/04/20 6:40 pm, Andy Shevchenko wrote:
> > On Wed, Apr 15, 2020 at 7:20 PM Saravanan Sekar <sravanhome@gmail.com> wrote:
> >> changes in v9:
> >>   - fixed review comments in mp2629 power supply such as resource based
> >>     iio channel, replace workqueue by threaded irq, irq get with "_optional"
> >>
> > May I ask you why you are ignoring my tag?
> > If you don't want to have your patches reviewed / applied, just don't send them.
>
>
> Sorry last time it was by mistake. But now I have added in below, if
> suppose to added in top its my ignorance

Ah, I see now. The idea of the tag given against cover letter that it
applies to entire series (if doesn't say otherwise).
It means, if you don't do any (drastic) changes to the patches, the
tag is still valid and you simple add it to each patch in the series
inside the commit message (usually after your SoB tag).

> >> changes in v8:
> >>   - fixed order of call in probe/remove in iio adc
> >>   - add ABI documentation for mp2629 power supply
> >>
> >> changes in v7:
> >>   - fixed probe/remove order, managed and unmanaged call mix use in adc.
> >>   - Documentation dual license, i2c node with controller address
> >>
> >> Overall looks good to me, FWIW,
> >> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> >>
> >> One question though in reply to patch 4.
>
>
> Please see here, this is first experience of tag in cover letter so just
> kept here as you gave against v7
>
> >>
> >> changes in v6:
> >>   - removed includes types.h in mfd, of_device.h in adc.
> >>   - fixed review comments parentheses, err check, kstrtouint
> >>
> >> changes in v5:
> >>   - removed platfrom data stored in mfd and directly accessed mfd struct in child
> >>   - fixed spell check and capitalization in mfd and documentation
> >>
> >> changes in v4:
> >>   - fixed capitalization in mfg Kconfig and documentation
> >>
> >> changes in v3:
> >>   - regmap for children passed using platform data and remove mfd driver info
> >>     access directly from children
> >>
> >> changes in v2:
> >>   - removed EXPORT_SYMBOL of register set/get helper
> >>   - regmap bit filed used, fixed other review comments
> >>
> >> This patch series add support for Battery charger control driver for Monolithic
> >> Power System's MP2629 chipset, includes MFD driver for ADC battery & input
> >> power supply measurement and battery charger control driver.
> >>
> >> Thanks,
> >> Saravanan
> >>
> >> Saravanan Sekar (6):
> >>    dt-bindings: mfd: add document bindings for mp2629
> >>    mfd: mp2629: Add support for mps battery charger
> >>    iio: adc: mp2629: Add support for mp2629 ADC driver
> >>    power: supply: Add support for mps mp2629 battery charger
> >>    power: supply: mp2629: Add impedance compenstation config
> >>    MAINTAINERS: Add entry for mp2629 Battery Charger driver
> >>
> >>   .../ABI/testing/sysfs-class-power-mp2629      |   8 +
> >>   .../devicetree/bindings/mfd/mps,mp2629.yaml   |  60 ++
> >>   MAINTAINERS                                   |   5 +
> >>   drivers/iio/adc/Kconfig                       |  10 +
> >>   drivers/iio/adc/Makefile                      |   1 +
> >>   drivers/iio/adc/mp2629_adc.c                  | 208 ++++++
> >>   drivers/mfd/Kconfig                           |   9 +
> >>   drivers/mfd/Makefile                          |   2 +
> >>   drivers/mfd/mp2629.c                          |  86 +++
> >>   drivers/power/supply/Kconfig                  |  10 +
> >>   drivers/power/supply/Makefile                 |   1 +
> >>   drivers/power/supply/mp2629_charger.c         | 667 ++++++++++++++++++
> >>   include/linux/mfd/mp2629.h                    |  28 +
> >>   13 files changed, 1095 insertions(+)
> >>   create mode 100644 Documentation/ABI/testing/sysfs-class-power-mp2629
> >>   create mode 100644 Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
> >>   create mode 100644 drivers/iio/adc/mp2629_adc.c
> >>   create mode 100644 drivers/mfd/mp2629.c
> >>   create mode 100644 drivers/power/supply/mp2629_charger.c
> >>   create mode 100644 include/linux/mfd/mp2629.h
> >>
> >> --
> >> 2.17.1
> >>
> >



-- 
With Best Regards,
Andy Shevchenko
