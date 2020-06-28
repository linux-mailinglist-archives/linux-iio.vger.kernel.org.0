Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D23E620C966
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jun 2020 19:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgF1Rx1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Jun 2020 13:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgF1Rx1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Jun 2020 13:53:27 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6847C03E979
        for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2020 10:53:26 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id t6so7266262pgq.1
        for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2020 10:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rgp+yt4J7orAoe42XZc0QR1DUh0NxIXuu/SPaeSuq9A=;
        b=VATNagJvzFKDLfWXrg8n1F5yju0or2Eb0b9hGkPw0ffr9SEqbBhpBEmoFu6GRDqZ18
         A0R6/z6yHok6+zX8VtsoufkBXHKYTKVDuOxbaHK94Ishooc22xxixzum0x5AnvipYUec
         QzmrZ6mVQy3LB5zv4pICHB0CRXYmTcv0wZegn+VIC4f4KxQG8yDGj2x5txgDq3sNnB9h
         ZU6qqcAS0Yky+yYJ7/Bp/hl3ATiaYFzMhtHy2qIjVh4IjSXxZaqr46bAAjYoNxYKf6/x
         K3RlYNUNv+9udjpLRxGm2jD7G/6uPWMhf2zYmcGEadDpueIQ16j/Gs3qlRpL2CTTVCRL
         duDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rgp+yt4J7orAoe42XZc0QR1DUh0NxIXuu/SPaeSuq9A=;
        b=p8n/Sxhx42KhGPsvJU0uIwEpdWtWP9VXfxkLP0P5VKvK4m4+50szsDOmyOJRyQR679
         R/OjSw9p15JMRR3n3lmxAfrBfGm/ywrUd/p+/y/z5UGZMkyJ9WlDg9ZD6+uaCTAaq4wV
         rRZVi4o8bAoR0NP3ZES7QATjBrGtj0M2Sfvprb6IMvuLIJlkgmFU6tlTV7DXs8KWUZKe
         eD+iihmuRCaJBGtTFszok227+8WuHysnevXag+PWrDqGBtNsli0RU3lbegqqQ82p6Zk0
         +thGDChgZ39MNCxA7b9qPPc3oSM1fpN3DhcwGedw5PBKkkP/VQpp2bWyZ19rLWtasqKo
         hUvQ==
X-Gm-Message-State: AOAM533PgGUe2kxd7YEGXViK9ypP4Q7Q0Lph2Hs7WneUoH/nX6AjkmeW
        eFadBf1io+QNBvjQqD6Fa0bVjrGQVAg1dB32WXQ=
X-Google-Smtp-Source: ABdhPJzf7sAhINd3UDwwiwVFdZ1UPxOwmn1gVC4GDp8KHKjkAd4kLwZtsFLIiHwDSDpfRCdhHpbrWrP24HFFGig73qc=
X-Received: by 2002:a62:7657:: with SMTP id r84mr11059832pfc.130.1593366806216;
 Sun, 28 Jun 2020 10:53:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200628123654.32830-1-jic23@kernel.org>
In-Reply-To: <20200628123654.32830-1-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 28 Jun 2020 20:53:09 +0300
Message-ID: <CAHp75VfP69DZqA2rH+RCTWnwrU=sYX98zXuWqVE9K3UTzCOeJQ@mail.gmail.com>
Subject: Re: [PATCH 00/23] iio:adc more of_match_ptr and similar removal
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Alexandru Ardelean <alexandru.Ardelean@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jun 28, 2020 at 3:38 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Continuation of slow process to try and remove use of of_match_ptr
> to supress asignment of the of_device_id table when !CONFIG_OF.

suppress assignment ?

> Usual argument that it prevents ACPI being used with these drivers
> via PRP0001 in DSDT.  Perhaps more usefully we are cutting down on the
> number of places it can be cut and paste from into new drivers.
>
> This is just the low hanging fruit.  I'm not yet sure if it makes
> sense to expend the effort to use generic firmware properties etc
> for some of the remaining drivers as it is unlikely they'll ever
> be used with anything other than device tree. There are 4 current
> ADC drivers in this more complex category.

All of them make sense to me, but I did only a shallow review (I would
look closer next week).
Also, perhaps it makes sense to give people an example of what it
looks like in the ACPI table. For example, in the cover letter (this
message) mention a link to meta-acpi repository [1] which has a lot of
examples [2].

[1]: https://github.com/westeri/meta-acpi
[2]: https://github.com/westeri/meta-acpi/tree/master/recipes-bsp/acpi-tables/samples
(Edison has most of the examples right now)


> Jonathan Cameron (23):
>   iio:adc:lpc32xx: Drop of_match_ptr protection
>   iio:adc:axp20x: Convert from OF to generic fw / device properties
>   iio:adc:hi8435: Drop unused of_gpio.h header
>   iio:adc:hi8435: Drop of_match_ptr protection.
>   iio:adc:max1363: Drop of_match_ptr and use generic
>     device_get_match_data
>   iio:adc:max1027: drop of_match_ptr and CONFIG_OF protections
>   iio:adc:ltc2496: Drop of_match_ptr and use mod_devicetable.h
>   iio:adc:cpcap-adc: Drop of_match_ptr protection and use
>     device_get_match_data
>   iio:adc:ltc2497 drop of_match_ptr protection
>   iio:adc:max11100: Drop of_match_ptr protection / add mod_devicetable.h
>     include
>   iio:adc:max1118: Drop CONFIG_OF / of_match_ptr protections
>   iio:adc:mcp320x: Drop CONFIG_OF and of_match_ptr protections
>   iio:adc:mcp3422: remove CONFIG_OF and of_match_ptr protections
>   iio:adc:sd_adc_modulator: Drop of_match_ptr and tweak includes
>   iio:adc:ti-adc081c: Drop of_match_ptr and change to mod_devicetable.h
>   iio:adc:ti-adc0832: drop CONFIG_OF and of_match_ptr protections
>   iio:adc:ti-adc084s021: drop of_match_ptr protection
>   iio:adc:ti-adc108s102: Drop CONFIG_OF and of_match_ptr protections
>   iio:adc:ti-adc128s052: drop of_match_ptr protection
>   iio:adc:ti-adc161s626: Drop of_match_ptr protection.
>   iio:adc:ti-tlc4541: Drop CONFIG_OF and of_match_ptr protections.
>   iio:adc:bcm_iproc: Drop of_match_ptr protection and switch to
>     mod_devicetable.h
>   iio:adc:ingenic: drop of_match_ptr protection and include
>     mod_devicetable.h
>
>  drivers/iio/adc/axp20x_adc.c       | 10 +++++-----
>  drivers/iio/adc/bcm_iproc_adc.c    |  4 ++--
>  drivers/iio/adc/cpcap-adc.c        | 22 ++++++----------------
>  drivers/iio/adc/hi8435.c           |  6 ++----
>  drivers/iio/adc/ingenic-adc.c      |  5 ++---
>  drivers/iio/adc/lpc32xx_adc.c      |  5 ++---
>  drivers/iio/adc/ltc2496.c          |  4 ++--
>  drivers/iio/adc/ltc2497.c          |  4 ++--
>  drivers/iio/adc/max1027.c          |  5 ++---
>  drivers/iio/adc/max11100.c         |  3 ++-
>  drivers/iio/adc/max1118.c          |  7 ++-----
>  drivers/iio/adc/max1363.c          | 11 ++++-------
>  drivers/iio/adc/mcp320x.c          |  5 ++---
>  drivers/iio/adc/mcp3422.c          |  6 ++----
>  drivers/iio/adc/sd_adc_modulator.c |  5 +++--
>  drivers/iio/adc/ti-adc081c.c       |  6 ++----
>  drivers/iio/adc/ti-adc0832.c       |  7 ++-----
>  drivers/iio/adc/ti-adc084s021.c    |  3 ++-
>  drivers/iio/adc/ti-adc108s102.c    |  5 ++---
>  drivers/iio/adc/ti-adc128s052.c    |  3 ++-
>  drivers/iio/adc/ti-adc161s626.c    |  3 ++-
>  drivers/iio/adc/ti-tlc4541.c       |  5 ++---
>  22 files changed, 54 insertions(+), 80 deletions(-)
>
> --
> 2.27.0
>


-- 
With Best Regards,
Andy Shevchenko
