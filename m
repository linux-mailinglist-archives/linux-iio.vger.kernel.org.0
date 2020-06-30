Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5CDC20EF4C
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jun 2020 09:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730976AbgF3H2D (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 30 Jun 2020 03:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbgF3H2D (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 30 Jun 2020 03:28:03 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D476C061755
        for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2020 00:28:03 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id h22so9116881pjf.1
        for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2020 00:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HCMpvgthjXkLq6Sy/yjpOvY4JnDUMzQ5/rLZ73hgPQg=;
        b=ZBkrwvI4RqtyiQyi5Du7OPGRbRMEdnM545i6M7C4/pE1EAljAPCRu9NgejPKhHIyxu
         SkUpzN8abgm60svdX/2qsZ0XlpwQVR7r6q/Gsjy6Hek+T8Q7SJO7hRd6s3en1zHD33a3
         GDGKtKT9CsxjMMwQdLTWoeWDFjLIMPZQI7ob9iX936NI/lHYSg75RE6cGXw2mjblCKhh
         tAiZg1MRinx5/rAKDYYiIpRirbV1tNiewNps3NNMrpQbL7S2iUU1mztqN4r01/vORsXi
         UKBO5pnrf+4JAez4vGGQl5sOXBr05ynmx+h28A7p+WQtJyxcBimpsuyLZ+KMVpCiE+Kb
         b7Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HCMpvgthjXkLq6Sy/yjpOvY4JnDUMzQ5/rLZ73hgPQg=;
        b=MR9XU/5vGnR2wostQn9YTYqCes/N9J5K+aq6xlL3EEljDCvB3xpaR8xtWka8/F36TC
         atkUlZIX5s6Ch25XMTiQuEqGgpo5RnqgIPbuPhzsLens0jW0f/1QKny5rNA3CuVmRb41
         TFSet1MQyPfZFah/ToLL6P4p81Gh3MT3rnYsKdNSASlO9vHbxVktLktGYeOWd6NTLXcp
         5QdUxPWn6Hli7sNA6zoB3LDamVszCFm4YlJ5O7Cy9mvw1ukwI8NIM08fDz3hJbzU+kgJ
         cB4XV2CAGM6lZDbEYjQz7Pp43p8lmhauI7Sqlh+nkXsaMmmnH/rGNB3xtJ9d/5njP8GG
         VzXw==
X-Gm-Message-State: AOAM532LPKZF2FUXCfg6HimJSiH00XfiPSkoS1hdgmInqI7CCARI+bip
        2zApfVQiu1bxB/y4/Njh/ACYba4x+ChqGrmHRNc=
X-Google-Smtp-Source: ABdhPJy9bEWtZb45j6gAGtpTGHBTEHC4MmyqkixhB0YzRAaozhVC3vC72GCmFB2Mtp1EKUOrGiQD0Q8odeiUA/cg4ZY=
X-Received: by 2002:a17:90a:b30d:: with SMTP id d13mr20904680pjr.181.1593502082849;
 Tue, 30 Jun 2020 00:28:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200628123654.32830-1-jic23@kernel.org>
In-Reply-To: <20200628123654.32830-1-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 30 Jun 2020 10:27:49 +0300
Message-ID: <CAHp75VeXWF1VuWeh=-S26=zn8bqXRZFuvQxUEy8Ez8oxxrWAjQ@mail.gmail.com>
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
>
> Usual argument that it prevents ACPI being used with these drivers
> via PRP0001 in DSDT.  Perhaps more usefully we are cutting down on the
> number of places it can be cut and paste from into new drivers.
>
> This is just the low hanging fruit.  I'm not yet sure if it makes
> sense to expend the effort to use generic firmware properties etc
> for some of the remaining drivers as it is unlikely they'll ever
> be used with anything other than device tree. There are 4 current
> ADC drivers in this more complex category.

For the non-commented,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Commented with LGTM also can have Rb tag.
The rest, please consider to address.

Thanks for a nice clean up!

>
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
