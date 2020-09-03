Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F74625C99D
	for <lists+linux-iio@lfdr.de>; Thu,  3 Sep 2020 21:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbgICTmL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Sep 2020 15:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbgICTmK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 3 Sep 2020 15:42:10 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3908C061244;
        Thu,  3 Sep 2020 12:42:08 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id e33so2958681pgm.0;
        Thu, 03 Sep 2020 12:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=64wdOe+m4X3LlgmhQ/Anjpyk3DyuY0i8xhdssKAxr9o=;
        b=ksSWkAtGUD9gN1y6I26GOinjjVHtHTzjudrp5b0/y3/MzYYTqSNhx5Q0lxITHCSsTw
         Peed0e8+DjVU/M5rPRHXyqe+Wipy1nawo/ItJK1dMG+KBXm8fRRbgyKRvdTL0Rp0AB4g
         0s/+Y34KIyzk4g0XppagwedewNf44kYN2DHRYqqg1uxI/8oK17NL4zOQmRrf8aNNT6hn
         gxN8dkuiRFmbtOBwE0sMZPrtboHadYIs7UdTR61gQCxts0GMjOnlYqhE0C/IFxFWg8yy
         mEvUfShepn0iYGzTxRVjkdyxyoJgZO6Y0H8Cp/Ez0hDylcxikHpkX3KKwm2zJnRGJuY3
         Zn2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=64wdOe+m4X3LlgmhQ/Anjpyk3DyuY0i8xhdssKAxr9o=;
        b=stTQXVEgSbp3BndVZ+tUnlzESd8DFKTnrneDy/2e07Ba2NXdbXJ8JchfFeICWV+DWn
         9NsPZwIMT/R1ifudMdKZFawgUv95FYKIrXhwGCwOu1FmEy97pRBQnWZH5Bn7tLmArDBz
         TTZdRf1GW5qLXbwyHx940MeUMk0mPZB2xYBnpDk399cE0vPS+7rxKf4mPUS8F4pv56C9
         mZoaxJkTCNT+QNDAANfeuUHeSaNQ97ZZmbElMhCOZ5U5aDIxqoiTW/kC8YU3eovlJGrG
         hA/sixEgc+BqOsPPppJPTzlltWzcVBXSazHrnyLLGULp9jAVVQdJePq82yCaAEztvTRI
         g4HA==
X-Gm-Message-State: AOAM532/SHM9debiFUHEFKLYnrmGotH3tslYAA8LcJfZQaNqtwpUQbXz
        HqjnAayvBcpY2dbtF8WgdwT/QNN2tegUUAyqIUc/i3+g5x7hBA==
X-Google-Smtp-Source: ABdhPJwNokACHFpiiIHxqrP8z9dSRKkN3pBN5Alt7WQLCuezH78+g6OAHrqAaD2MTv2upvQoRQ7wt17tPMdaKLfz2mU=
X-Received: by 2002:a62:6083:0:b029:13c:1611:66c4 with SMTP id
 u125-20020a6260830000b029013c161166c4mr3646465pfb.15.1599162128118; Thu, 03
 Sep 2020 12:42:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200903181926.5606-1-krzk@kernel.org>
In-Reply-To: <20200903181926.5606-1-krzk@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 3 Sep 2020 22:41:51 +0300
Message-ID: <CAHp75VeXTN5gTv2Pj33N9EB9i2U7R+uvgZ-Ad4_SMgKkrB0F3g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] MAINTAINERS: Consolidate Analog Devices IIO
 entries and remove Beniamin Bia
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Sep 3, 2020 at 9:19 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Emails to Beniamin Bia bounce with no such address so remove him from
> maintainers.  After this removal, many entries for Analog Devices Inc
> IIO drivers look exactly the same so consolidate them.
>
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: linux-iio <linux-iio@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

...

>  ANALOG DEVICES INC IIO DRIVERS
>  M:     Lars-Peter Clausen <lars@metafoo.de>
>  M:     Michael Hennerich <Michael.Hennerich@analog.com>
> @@ -1152,8 +1101,11 @@ W:       http://wiki.analog.com/
>  W:     http://ez.analog.com/community/linux-device-drivers
>  F:     Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9523
>  F:     Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4350
> +F:     Documentation/devicetree/bindings/iio/*/adi,*
> +F:     Documentation/devicetree/bindings/iio/dac/ad5758.txt
>  F:     drivers/iio/*/ad*
>  F:     drivers/iio/adc/ltc249*
> +F:     drivers/iio/amplifiers/hmc425a.c
>  F:     drivers/staging/iio/*/ad*
>  X:     drivers/iio/*/adjd*

>  STAGING - SEPS525 LCD CONTROLLER DRIVERS
>  M:     Michael Hennerich <michael.hennerich@analog.com>
> -M:     Beniamin Bia <beniamin.bia@analog.com>
>  L:     linux-fbdev@vger.kernel.org
>  S:     Supported
>  F:     Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml

It's not related to this series, but I'm wondering why the above
binding is attached to a staging driver...

-- 
With Best Regards,
Andy Shevchenko
