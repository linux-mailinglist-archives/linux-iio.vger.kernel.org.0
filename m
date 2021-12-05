Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D21B468BBA
	for <lists+linux-iio@lfdr.de>; Sun,  5 Dec 2021 16:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235289AbhLEPU6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Dec 2021 10:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235251AbhLEPU5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Dec 2021 10:20:57 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEC2C061714
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 07:17:30 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id r25so32407809edq.7
        for <linux-iio@vger.kernel.org>; Sun, 05 Dec 2021 07:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1sjD3I1npsRn1PiVFpokBRNo78DIfjUXhw4+JHAC6Sg=;
        b=UK36pzJeJNHZTQdUtSJa6GKAu8XxZ0ufTGS0/crKj1Jg6h0uFsK4w+Kbw+PQ+NFVPx
         Bf/pAQXQ4sm+X1VtcJ1v/nceyMMPxI/SUynRV5tXjC93o+f7WPp5krRJ1as9bIcVzKaB
         cjecWSPLIiUp8v9JLqtAkmUHLEHUA6CVvHjIcz5TWnyLc8P44x/0RqjXp7vbqI14UQgc
         c5wLebWpYMEqjslnlIG2q0kxkbkdEkmphY2b5cDye0nG0e4wOjnPmVOVqVeAdqIworPP
         StCB5sEByA8AIEmSW8Qo9wa6h/ZHcuik/R1X0xHAy/N0QxPvZ0t7+FGvvCdiRrMXu/21
         CFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1sjD3I1npsRn1PiVFpokBRNo78DIfjUXhw4+JHAC6Sg=;
        b=KjG72GqEuTljGMxqdWBbG/03p6Xoe3QFMzzFFSS6z2WAIdPkEKVYPsz4KLkZ726CZP
         vU2VC0S6BdfRLaoiDxVC0Yv8VYdx64KphTac5DWVXM8U9eOtu1FO1fj0KkJfCljaqLeu
         nTvmHc7H9UwP+cqB21MahzZ+RA3bOeGw6ZecJPT1pz3O4i86wzRJXMl6gKLBRItyLmDI
         nPqO9sr3XuVf/VuXgERlO1wMqAMVjFF80oIxSIhuwttlIMizqEPJ5+mfBlW9uMgITVjx
         NSqppxVvtZ4tEtXCdPCT3dSkstFBG+sBh3geHf8WO9lyc77ilKsJOyRoXQ6ZgQ+7k43t
         IACA==
X-Gm-Message-State: AOAM531b89EUGcREYLO5Bqca7W68IZOni+UEAajxb5XhWtVhHgAQTVDu
        46YynE8+NzUYqq0a2UTqDdJ4crq7WCZHJXW3CEI=
X-Google-Smtp-Source: ABdhPJw+V+cnr3LP6b2zsj3HV+GeEOYpbWdkxg5C9W++EHz7ysfik4DTJTi+30FSHTH0862Fcu0UaJx5SpP18A0AQrE=
X-Received: by 2002:a17:907:869e:: with SMTP id qa30mr36906285ejc.356.1638717449165;
 Sun, 05 Dec 2021 07:17:29 -0800 (PST)
MIME-Version: 1.0
References: <20211204171237.2769210-1-jic23@kernel.org>
In-Reply-To: <20211204171237.2769210-1-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 5 Dec 2021 17:16:53 +0200
Message-ID: <CAHp75Vc5Lk=2HrzsQu4rNtJEYbj90FbD3xChjtG5MKmv1qkeYQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] IIO: More of to generic fw conversions.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Dec 4, 2021 at 7:07 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> v2: Drop platform data from ad5755 as suggested by Lars.
>     Collect tags.
>
> Nothing particularly special about this series, just a few
> more drifvers converted and related header and Kconfig
> dependency cleanups.
>
> For now I'm focussing mostly on standalone parts rather than
> those integrated in SoCs.
>
> Any feedback welcome.

I like the series!
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmial.com>
But see some (important in patch 9 and 12) comments to address.

> Thanks,
>
> Jonathan
>
> Jonathan Cameron (12):
>   iio:dac:ad5755: Switch to generic firmware properties and drop pdata
>   iio:dac:ad5758: Drop unused of specific headers.
>   iio:dac:dpot-dac: Swap of.h for mod_devicetable.h
>   iio:dac:lpc18xx_dac: Swap from of* to mod_devicetable.h
>   iio:pot:mcp41010: Switch to generic firmware properties.
>   iio:light:cm3605: Switch to generic firmware properties.
>   iio:adc:max9611: Switch to generic firmware properties.
>   iio:adc:mcp3911: Switch to generic firmware properties.
>   iio:adc:ti-adc12138: Switch to generic firmware properties.
>   iio:adc:envelope-detector: Switch from of headers to mod_devicetable.h
>   iio:adc:ti-ads124s08: Drop dependency on OF.
>   iio:adc/dac:Kconfig: Update to drop OF dependencies.
>
>  drivers/iio/adc/Kconfig              |   6 +-
>  drivers/iio/adc/envelope-detector.c  |   3 +-
>  drivers/iio/adc/max9611.c            |  20 ++--
>  drivers/iio/adc/mcp3911.c            |   8 +-
>  drivers/iio/adc/ti-adc12138.c        |   9 +-
>  drivers/iio/adc/ti-ads124s08.c       |   3 +-
>  drivers/iio/dac/Kconfig              |   1 -
>  drivers/iio/dac/ad5755.c             | 150 ++++++++++++++++++++-------
>  drivers/iio/dac/ad5758.c             |   3 +-
>  drivers/iio/dac/dpot-dac.c           |   2 +-
>  drivers/iio/dac/lpc18xx_dac.c        |   3 +-
>  drivers/iio/light/cm3605.c           |   6 +-
>  drivers/iio/potentiometer/mcp41010.c |   6 +-
>  include/linux/platform_data/ad5755.h | 102 ------------------
>  14 files changed, 145 insertions(+), 177 deletions(-)
>  delete mode 100644 include/linux/platform_data/ad5755.h
>
> --
> 2.34.1
>


-- 
With Best Regards,
Andy Shevchenko
