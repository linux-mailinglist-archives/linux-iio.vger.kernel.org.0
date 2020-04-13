Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1A541A6CE7
	for <lists+linux-iio@lfdr.de>; Mon, 13 Apr 2020 22:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388188AbgDMUBz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Apr 2020 16:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388135AbgDMUBz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Apr 2020 16:01:55 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A92C0A3BDC;
        Mon, 13 Apr 2020 13:01:54 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id d17so4963584pgo.0;
        Mon, 13 Apr 2020 13:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J3cCNpgRJA9avR4kz32VesjN9UmFQ5b6+1OU9lUWCYU=;
        b=PJwMvVoXHoh4ZCGjOlCpUMNzvy6UrIjQWAHhMIjj+JVy8Pu82RfBsUSKYmE/Rf2mqN
         qhfFm/q/wzwzjvL69WZlhzM+tYdCmkg8xvV92ag8NduUlZikQ3Qo7MkcM/aGSRaZbbm1
         PR2isRezDgLdCJC5x3+1TtkUhf0BRkive2D9kL3EzKQAx01uFitZpemacjOiiim14BMp
         tjGWSfV4s9rj3B5jnS7OnBZUjOIzfUMOk3OakXnSLWgFL9Z3FX27RCNxf7PHl6M0iI/V
         +yipALkcxF2pRKWEcAZJmqTu5yyFZW6mySMJYsLgaA2xL+ZKQsP3zbkU7iAKVZfeGPR2
         Wtzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J3cCNpgRJA9avR4kz32VesjN9UmFQ5b6+1OU9lUWCYU=;
        b=hcbU4jkh7+TZLPMa3PISJiXHvs2MKz+L+Jx6LQl4TLE1xElOwxtMUxG4Zbgj7//yh6
         JUSgoD4ua2G0pnPqICDNfYY+HqdjILl/9+B30CmAldq/NGP5u5aStbL1bU2O8D3nAMQ8
         6IPr0bJhenp2N84N9IMyQxrQiYuo0HCJwgXrOnMTlSpw+k9BYECN1tJGKJeYfm95JIke
         I56ulz215XNQ529zVcg6IxCcLlhnngUqe7Ro+OmYezynDQEVypCWT9pBESXGkR94sAvl
         l0dP1AHc5g+c030WmEkk8dL9OxdG9/1oZ0OTZfmyGWykiK85KOa3vODjsyk3MNP3JwQD
         GA0w==
X-Gm-Message-State: AGi0PuZ7VqmGcNnVpF2WsXEX/bGKqIxTmfhUqMTifQUsQybPJVDUgWke
        svoj6ABPfERd/parWL56oaKdhqbL6vGK9gfGpL4=
X-Google-Smtp-Source: APiQypLkGIBDSBR9xdnow1niyB7RFnE2uJpuzzz/4DpzWuW9cHiK0axj6hAF/dmJp5AW88qWObxtfQMY8x9vdx7+l7M=
X-Received: by 2002:a63:5511:: with SMTP id j17mr2845081pgb.4.1586808114381;
 Mon, 13 Apr 2020 13:01:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200413173656.28522-1-sravanhome@gmail.com>
In-Reply-To: <20200413173656.28522-1-sravanhome@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 13 Apr 2020 23:01:43 +0300
Message-ID: <CAHp75VdLPorP735K1jGSm=XphZ1P3i2YLc-zHWf-S=fWsBOyVg@mail.gmail.com>
Subject: Re: [PATCH v8 0/6] Add battery charger driver support for MP2629
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

On Mon, Apr 13, 2020 at 8:37 PM Saravanan Sekar <sravanhome@gmail.com> wrote:

When somebody gives you a tag, take care and add that tag to all
patches where it applies (if you don't drastically change the code, it
applies to all mentioned in the corresponding reply).

> changes in v8:
>  - fixed order of call in probe/remove in iio adc
>  - add ABI documentation for mp2629 power supply
>
> changes in v7:
>  - fixed probe/remove order, managed and unmanaged call mix use in adc.
>  - Documentation dual license, i2c node with controller address
>
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
> Saravanan Sekar (6):
>   dt-bindings: mfd: add document bindings for mp2629
>   mfd: mp2629: Add support for mps battery charger
>   iio: adc: mp2629: Add support for mp2629 ADC driver
>   power: supply: Add support for mps mp2629 battery charger
>   power: supply: mp2629: Add impedance compenstation config
>   MAINTAINERS: Add entry for mp2629 Battery Charger driver
>
>  .../ABI/testing/sysfs-class-power-mp2629      |   8 +
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
>  13 files changed, 1115 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-power-mp2629
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
