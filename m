Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1802D1AAE80
	for <lists+linux-iio@lfdr.de>; Wed, 15 Apr 2020 18:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406869AbgDOQlK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Apr 2020 12:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404524AbgDOQlJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Apr 2020 12:41:09 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69186C061A0C;
        Wed, 15 Apr 2020 09:41:06 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id 7so24838pjo.0;
        Wed, 15 Apr 2020 09:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8fY6HIScFUhUnoCuOazyJ7I6i4IwGnwhNXDcGExeiw8=;
        b=W82pyamZdYLII/DxDYCS0WiQMhoC57ijsJiJaNdq0w9QZtaxYZ8DQpLzBeGon5V3IU
         zIO7yIVanbnWEQ/3mkzdwk2y0Dhy9jttKsD6kAci8bl0rCc+uzJ6uFXcLVB6Nkxp3Cri
         HjXoyMsqEi8Oyb20fyNbtGfYvxCWH1Qiir9BPI0p76Q1u5QMz+2x06LmSUUYtbqOBsWl
         ypBhp3VHH/OvXt1aNYpP5uO3C9A4USa/AZqSUY19AbcZ4wUTvL3O5dvkzQpXi5ZeRfKU
         L1ku4GKTuaVbaYD6ySQC+o4mOfD1LsBadjFprlLV6smV0NWnhVPBTbRuenmf90hS4Wmr
         vJ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8fY6HIScFUhUnoCuOazyJ7I6i4IwGnwhNXDcGExeiw8=;
        b=mV4VDqHBu6gnYvieY/DNhhQkcmH2WY2CxsvkJRDCTnEi9mh3m5MIkAIP42l+7yAQg6
         KsNxvqfsyQrv5DwldRf2cDfDX+l/HtFkidMrgRENRBz2wGatCJ4x9d3t2vbzCouWUHwi
         CBkOgwzxoR962mtuzsietn5f0YnZ/JZDeq6e12KoLFnArTUv1dF7Z24Aq+r8QgLLSz79
         OHGwZZ6f9KmfXuqBkOEmpLCct9PW1F2F53Zpps4FgiHhZvU/R5BErD3BhcFLGRt171eW
         ofaQ9GAtD7qr2w4YnVY1YEl930YuFBBt4okAdFIdUav0RwbxjlDCQ7GIyVhhnYmDLv0l
         bjMQ==
X-Gm-Message-State: AGi0PualvDZL266589rGFZbxgV7QL8U2zO92haMDoPOrz2c+1wXJdL9L
        OdEun1ksb5/4IcKBFPjvCrr7E6As2N52vqGzm14=
X-Google-Smtp-Source: APiQypLpQ4BROYdkU/nhbjPTGt2JOPmF/DEXW5LmQFkYYyuvsNmnZbJZcRNBJoHz5G5fpiRtiT7hy0mb14znCc2fFY0=
X-Received: by 2002:a17:902:aa09:: with SMTP id be9mr5868784plb.18.1586968865614;
 Wed, 15 Apr 2020 09:41:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200415162030.16414-1-sravanhome@gmail.com>
In-Reply-To: <20200415162030.16414-1-sravanhome@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 15 Apr 2020 19:40:58 +0300
Message-ID: <CAHp75VerGG0_J+fHrZfwJRa3EHtGuz-pJbD7zwoXN2jfO7dszA@mail.gmail.com>
Subject: Re: [PATCH v9 0/6] Add battery charger driver support for MP2629
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

On Wed, Apr 15, 2020 at 7:20 PM Saravanan Sekar <sravanhome@gmail.com> wrote:
>
> changes in v9:
>  - fixed review comments in mp2629 power supply such as resource based
>    iio channel, replace workqueue by threaded irq, irq get with "_optional"
>

May I ask you why you are ignoring my tag?
If you don't want to have your patches reviewed / applied, just don't send them.

> changes in v8:
>  - fixed order of call in probe/remove in iio adc
>  - add ABI documentation for mp2629 power supply
>
> changes in v7:
>  - fixed probe/remove order, managed and unmanaged call mix use in adc.
>  - Documentation dual license, i2c node with controller address
>
> Overall looks good to me, FWIW,
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>
> One question though in reply to patch 4.
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
>  drivers/power/supply/mp2629_charger.c         | 667 ++++++++++++++++++
>  include/linux/mfd/mp2629.h                    |  28 +
>  13 files changed, 1095 insertions(+)
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
