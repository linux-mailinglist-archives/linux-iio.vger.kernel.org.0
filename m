Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEBCD1A4F50
	for <lists+linux-iio@lfdr.de>; Sat, 11 Apr 2020 12:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbgDKKRH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 Apr 2020 06:17:07 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36454 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbgDKKRH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Apr 2020 06:17:07 -0400
Received: by mail-pl1-f194.google.com with SMTP id g2so1514734plo.3;
        Sat, 11 Apr 2020 03:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+KhT4Lw+E5hrVuuvNZOtXCA2e1KBZDLsYmSlwMgDSyg=;
        b=TWEUX3Fl2swRdWz1CPY9/HNUxPMMtmhelCLQ8zPb4wYHGuGI9SpL/HzaYcX16EELqZ
         BXN0p1OBYoA6HjRK8EbmVcQ1UZ7YnhYSjkdTzBSnSG88f+VjOjHU/r5cB1ZBQA12+vNO
         UFD4IP8e817V2PQN5efSqYJ6nKR1zEZ7tPW8Zl9koZbPe/2xF89FZYc1/zxm5baDE8kR
         UsJnvbCyQgDwxGBDIGIj4TCs2IFCUvTzlj4n0H24f4cGsOkd1BVmmc0PR51dMFRuEdEd
         p1ZbT0tzx+EcKlQWZslSb8Th5r5btoHG5z/Fg7+HD0Ab/ITdri8x2ja6kfGVPsgndwIi
         JFIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+KhT4Lw+E5hrVuuvNZOtXCA2e1KBZDLsYmSlwMgDSyg=;
        b=bwzUHxvckPq+1Ghycx8SnGAooZAWyPvAV8wdncb0QdnHacnHqvKZGZ05AkAfvTt3UX
         SKoJaiKusU+0KIeixKZDJQseg+hfoKO+v/imkAA1YascDDfKs4O4ySifOJR0aBptziYU
         lFFeF3LN1VMSe6yG20VRn9JZ6AnpdyRsVFPPa2GbhgLNc7M2iiCD4lxRgliefbKOSSCW
         mYAAdnrmL0JuU3I2mnlmeVG/1QDeI/vP0k8BUnttuVVePunqKYikZtGLH2goYe/cTUcv
         KKB3ai1FwkNPO3/++GvMieB3+kBBu6Znx3nkQW3vjgD8YhHGtdJdP9cN1XpxOIXyg6b9
         jrJw==
X-Gm-Message-State: AGi0PubRyEezX6gwpzvoyfXf17u0UFOl8x98LnFalGOcjCiW1Cyesvya
        S5rNZLhn7ngCLjMznFQ/zpqM7wWGd/lHSVLofAg=
X-Google-Smtp-Source: APiQypKBxqyP2VTpmEejb05I4p492JmmrAy8Kn3YOkmqKWJ44ajFN7cG6Yd4Z7a8ByaUsXFQr/6Fx/zuKiqXXAhbmLo=
X-Received: by 2002:a17:902:5985:: with SMTP id p5mr4048369pli.262.1586600225472;
 Sat, 11 Apr 2020 03:17:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200410201948.1293-1-sravanhome@gmail.com>
In-Reply-To: <20200410201948.1293-1-sravanhome@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 11 Apr 2020 13:16:53 +0300
Message-ID: <CAHp75Vem_Uifke36hZrWJutddJbar1t2CK7qrydg91=Fdu_GzQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] Add battery charger driver support for MP2629
To:     Saravanan Sekar <sravanhome@gmail.com>
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

On Fri, Apr 10, 2020 at 11:19 PM Saravanan Sekar <sravanhome@gmail.com> wrote:
>
> changes in v7:
>  - fixed probe/remove order, managed and unmanaged call mix use in adc.
>  - Documentation dual license, i2c node with controller address

Overall looks good to me, FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

One question though in reply to patch 4.

> changes in v6:
>  - removed includes types.h in mfd, of_device.h in adc.
>  - fixed review comments parentheses, err check, kstrtouint
>
> changes in v5:
>  - removed platfrom data stored in mfd and directly accessed mfd struct in child
>  - fixed spell check and capitalization in mfd and documentation
>
> changes in v4:
>  - fixed capitalization in mfg Kconfig and documentation
>
> changes in v3:
>  - regmap for children passed using platform data and remove mfd driver info
>    access directly from children
>
> changes in v2:
>  - removed EXPORT_SYMBOL of register set/get helper
>  - regmap bit filed used, fixed other review comments
>
> This patch series add support for Battery charger control driver for Monolithic
> Power System's MP2629 chipset, includes MFD driver for ADC battery & input
> power supply measurement and battery charger control driver.
>
> Thanks,
> Saravanan
>
> Saravanan Sekar (5):
>   dt-bindings: mfd: add document bindings for mp2629
>   mfd: mp2629: Add support for mps battery charger
>   iio: adc: mp2629: Add support for mp2629 ADC driver
>   power: supply: Add support for mps mp2629 battery charger
>   MAINTAINERS: Add entry for mp2629 Battery Charger driver
>
>  .../devicetree/bindings/mfd/mps,mp2629.yaml   |  60 ++
>  MAINTAINERS                                   |   5 +
>  drivers/iio/adc/Kconfig                       |  10 +
>  drivers/iio/adc/Makefile                      |   1 +
>  drivers/iio/adc/mp2629_adc.c                  | 208 ++++++
>  drivers/mfd/Kconfig                           |   9 +
>  drivers/mfd/Makefile                          |   2 +
>  drivers/mfd/mp2629.c                          |  86 +++
>  drivers/power/supply/Kconfig                  |  10 +
>  drivers/power/supply/Makefile                 |   1 +
>  drivers/power/supply/mp2629_charger.c         | 687 ++++++++++++++++++
>  include/linux/mfd/mp2629.h                    |  28 +
>  12 files changed, 1107 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
>  create mode 100644 drivers/iio/adc/mp2629_adc.c
>  create mode 100644 drivers/mfd/mp2629.c
>  create mode 100644 drivers/power/supply/mp2629_charger.c
>  create mode 100644 include/linux/mfd/mp2629.h
>
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
