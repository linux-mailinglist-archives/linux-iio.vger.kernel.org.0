Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF5B2686CB
	for <lists+linux-iio@lfdr.de>; Mon, 14 Sep 2020 10:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgINIGH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Sep 2020 04:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgINIFB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Sep 2020 04:05:01 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB72C06174A
        for <linux-iio@vger.kernel.org>; Mon, 14 Sep 2020 01:05:00 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id b17so4943562pji.1
        for <linux-iio@vger.kernel.org>; Mon, 14 Sep 2020 01:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IGvxEz2Oe3+M10o5wXk8wqWB/8mNeZ4wXyl7zb4rfdY=;
        b=g1WNqfn/YEOqdnfPIIUoPQVNWVh2wj6lf4jKLzrcveNhM8GqA9s7SDJF3Oee5HGF4M
         Jf0/2w1rfO+053sMy92v1nym51u8b8mo7tpvK1qo7a5Tw+DyrGlim+m25ZY2WUh0Xy6s
         gIMf2T5avN9FfJHQJXYffkbRaOy9KgbT2ZOjDEr9MnnwiGDcNtr++wB0KKkRua7mfoYm
         aVeKj0/xctaaXhtJyCsJCjp4xtcGy9LrsLbaVvMXtrjpcDOKKWLXp5yxyqGWH4lx9oSY
         CkHVFLbMftZga75GOz/MagyJzBArqCKeU0VcKgsakWpxpcP6djd8wLv2BM8bJR7iSc2q
         cWeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IGvxEz2Oe3+M10o5wXk8wqWB/8mNeZ4wXyl7zb4rfdY=;
        b=XHEtQN3IQcF5KlIcvYmZiBVMNgCjJ1BP9ojaBN5ho78/Gy/Va9tjRoVWWrnwIhZbQG
         M48T7Nn0qiXoyTurxubDsX5ukVFdXpPfNSPL6p7RRAiy7i8RiT/8r+akG3y4pOgB2Zfo
         SV/MVkbaxDXOpivVvEY2nGLMLyBgptOltn5ekgkIEpp5LcsV21vK8zmwhDMnOC7E2BWX
         9kUOnkxEbCP6Tt7JnAsKKP6HsyYDuGuSrYQ8D3Nhhewt4UT4P1a0cBQ582cCX/Ar5yVl
         Wjfw/zvvO5ZPEIZIWyP2L1fsw3YZT1s/m1PcBfWbuonOAVp772VtQGhV/5WhH6lrRkDe
         FGmQ==
X-Gm-Message-State: AOAM530lfpdtzyF0RHOAK+wCyqHhOfm5hpb8BRhiUvYYZ9qW9ZaJmNH0
        vNHGeOMAsgSD5pGTZ1eH9n1k7zMdmp94qgDpCWY=
X-Google-Smtp-Source: ABdhPJxU/afNykcsSdcwSesxY0UC4y9dF+Kwl7GByPku1ARg0lYGZUKuvwaYQ7ZT5JDRFJD8TMemTco6aUIaR7A0IQ4=
X-Received: by 2002:a17:90a:fd98:: with SMTP id cx24mr12334246pjb.181.1600070699985;
 Mon, 14 Sep 2020 01:04:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200910173242.621168-1-jic23@kernel.org>
In-Reply-To: <20200910173242.621168-1-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 14 Sep 2020 11:04:43 +0300
Message-ID: <CAHp75Vf8T44zhS99A9bm3mBO04Cfkqz1N8wGVe0Kjq8JPoPCqQ@mail.gmail.com>
Subject: Re: [PATCH 00/38] iio: remaining easy of_match_ptr removal and related.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Sep 10, 2020 at 8:35 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> This bumper set removes all the remaining cases where of_match_ptr
> is mostly serving to prevent use of the device via ACPI PRP0001 and
> complicating the code. The main aim of this set is to reduce the chances
> of it being used in future drivers.
> It also includes some related refactorings, use of generic fw accessors,
> dropping of CONFIG_OF and lots of header changes inline with the above.
>
> For examples of how to use PRP0001 see https://github.com/westeri/meta-acpi
> which is an excellent resource from which to copy snippets of DSDT tables.
>
> It may well not be worth changing the remaining 10 IIO drivers and I
> certainly don't plan to do so anytime soon.
>

I briefly looked at the series and didn't see anything wrong with it
(esp. taking into consideration that you are already familiar with the
topic).
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Jonathan Cameron (38):
>   iio:potentiometer:ad5272: Drop of_match_ptr and CONFIG_OF protections.
>   iio:potentiometer:ds1803: Drop of_match_ptr and CONFIG_OF protections
>   iio:potentiometer:max5432: Drop of_match_ptr and use generic fw
>     accessors
>   iio:potentiometer:max5481: Drop of_match_ptr and CONFIG_OF
>     protections.
>   iio:potentiometer:max5481: Drop invalid ACPI binding.
>   iio:potentiometer:mcp4018: Drop of_match_ptr and CONFIG_OF
>     protections.
>   iio:potentiometer:mcp4131: Drop of_match_ptr and use generic fw
>     interfaces.
>   iio:potentiometer:mcp4531: Drop of_match_ptr and CONFIG_OF
>     protections.
>   iio:dac:ad5446: Drop of_match_ptr and CONFIG_OF protections
>   iio:dac:ad5592r: Drop of_match_ptr and ACPI_PTR protections.
>   iio:dac:ad5593r: Drop of_match_ptr and ACPI_PTR protections.
>   iio:dac:ad7303: Drop of_match_ptr protection
>   iio:dac:mcp4725: drop of_match_ptr and use generic fw properties
>   iio:dac:ti-dac082s085: Drop of_match_ptr and CONFIG_OF protections
>   iio:dac:ti-dac5571: Drop of_match_ptr and CONFIG_OF protections
>   iio:potentiostat:lmp91000: Drop of_match_ptr and use generic fw
>     accessors
>   iio:pressure:icp10100: Drop of_match_ptr and CONFIG_OF protections
>   iio:pressure:ms5611: Drop of_match_ptr and CONFIG_OF protections
>   iio:pressure:ms5637: Drop of_match_ptr protection
>   iio:pressure:zpa2326: Drop of_match_ptr protection
>   iio:temperature:tsys01: Drop of_match_ptr protection
>   iio:temperature:tmp007: Drop of_match_ptr protection
>   iio:resolver:ad2s1200: Drop of_match_ptr protection
>   iio:chemical:ams-iaq-core: Drop of_match_ptr protection
>   iio:chemical:atlas-sensor: Drop of_match_ptr and use generic fw
>     accessors
>   iio:chemical:sgp30: Use local variable dev to simplify code
>   iio:chemical:sgp30: Drop of_match_ptr and use generic fw accessors
>   iio:chemical:vz89x: Introduce local struct device pointer.
>   iio:chemical:vz89x: Drop of_match_ptr protection and use generic fw
>     accessors
>   iio:humidity:hdc100x: Drop of_match_ptr protection.
>   iio:proximity:as3935: Use local struct device pointer to simplify
>     code.
>   iio:proximity:as3935: Drop of_match_ptr and use generic fw accessors
>   iio:proximity:pulsedlight: Drop of_match_ptr protection
>   iio:magn:ak8975: Drop of_match_ptr and ACPI_PTR protections.
>   iio:magn:ak8974: Drop of_match_ptr protection
>   iio:humidity:htu21: Drop of_match_ptr protection
>   iio:humidity:si7020: Drop of_match_ptr protection
>   iio:health:max30102: Drop of_match_ptr and use generic fw accessors
>
>  drivers/iio/chemical/ams-iaq-core.c           |  3 +-
>  drivers/iio/chemical/atlas-sensor.c           | 10 ++---
>  drivers/iio/chemical/sgp30.c                  | 28 ++++++------
>  drivers/iio/chemical/vz89x.c                  | 18 ++++----
>  drivers/iio/dac/ad5446.c                      |  5 +--
>  drivers/iio/dac/ad5592r.c                     |  7 ++-
>  drivers/iio/dac/ad5593r.c                     |  7 ++-
>  drivers/iio/dac/ad7303.c                      |  3 +-
>  drivers/iio/dac/mcp4725.c                     | 29 +++---------
>  drivers/iio/dac/ti-dac082s085.c               |  5 +--
>  drivers/iio/dac/ti-dac5571.c                  |  7 +--
>  drivers/iio/health/max30102.c                 | 11 +++--
>  drivers/iio/humidity/hdc100x.c                |  3 +-
>  drivers/iio/humidity/htu21.c                  |  3 +-
>  drivers/iio/humidity/si7020.c                 |  3 +-
>  drivers/iio/magnetometer/ak8974.c             |  3 +-
>  drivers/iio/magnetometer/ak8975.c             |  8 ++--
>  drivers/iio/potentiometer/ad5272.c            |  5 +--
>  drivers/iio/potentiometer/ds1803.c            |  6 +--
>  drivers/iio/potentiometer/max5432.c           |  8 ++--
>  drivers/iio/potentiometer/max5481.c           | 23 ++--------
>  drivers/iio/potentiometer/mcp4018.c           | 12 ++---
>  drivers/iio/potentiometer/mcp4131.c           |  8 ++--
>  drivers/iio/potentiometer/mcp4531.c           | 11 ++---
>  drivers/iio/potentiostat/lmp91000.c           | 11 +++--
>  drivers/iio/pressure/icp10100.c               |  3 +-
>  drivers/iio/pressure/ms5611_i2c.c             |  6 +--
>  drivers/iio/pressure/ms5611_spi.c             |  6 +--
>  drivers/iio/pressure/ms5637.c                 |  3 +-
>  drivers/iio/pressure/zpa2326_i2c.c            |  6 +--
>  drivers/iio/pressure/zpa2326_spi.c            |  6 +--
>  drivers/iio/proximity/as3935.c                | 44 +++++++++----------
>  .../iio/proximity/pulsedlight-lidar-lite-v2.c |  3 +-
>  drivers/iio/resolver/ad2s1200.c               |  3 +-
>  drivers/iio/temperature/tmp007.c              |  4 +-
>  drivers/iio/temperature/tsys01.c              |  3 +-
>  36 files changed, 134 insertions(+), 190 deletions(-)
>
> --
> 2.28.0
>


-- 
With Best Regards,
Andy Shevchenko
