Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72CEA373FBC
	for <lists+linux-iio@lfdr.de>; Wed,  5 May 2021 18:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234044AbhEEQ17 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 5 May 2021 12:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233826AbhEEQ17 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 May 2021 12:27:59 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8D7C061574;
        Wed,  5 May 2021 09:27:02 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id p4so2415099pfo.3;
        Wed, 05 May 2021 09:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z51fUGrKWnrGPTt/WXkX+t2pL2HZ3YCBg9NsP8Mmlio=;
        b=cjEMK6r/ddM1rs5rW1fowJxVCgnFRjE2hziTWEZknY7yZUwAgtk+07TvbwCcjSH0Iq
         5FoyO9TJ/xNPEPNws5ckbYuYvOYOYmxlz3HDmaMAPgCwgBCC8dWR+N9K6trj8T1Tuz2Z
         imI2IOVBk+f4zu8ZH36jAXezcg3e/pkXhrvrTrRgv7ldGGoShV750vU92n3XiEtvp1nG
         gfWFd7KOmmtopsD/k4/zEkrbbGQbQkurtXAAmI+hvv9eo2Zuy+uTx3jo1P43wpwBMsiV
         iLZcGuneNpR3CGI4txRhcBnDGoeY+ULCA79LHrfYwu+udKrAqJ1/LlTh2GH44AkfpG6m
         Kh5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z51fUGrKWnrGPTt/WXkX+t2pL2HZ3YCBg9NsP8Mmlio=;
        b=ZCNY9Kr1ia+smWX7n9TzzZ4QFqELyfW+v2PPxfi5ntTXkgyjh08fkH5/aoUiDP2hjV
         eGQji3pv9XaNixi3wJpr5y18l9TkHvMdNldF6BL1vFhC8NBs2b3Ck/zI/abJQCixg3we
         q1+atR5DjxMLoTEskxuSz82d5SvFe8wAwUSpSQ3HyN0bW5Edo21bPV5irRuiz2dwCu7h
         YyzzWR79yqjBb412R4lhWCnNvP4as3seoYMWL7bMQ/WYzwP0Nsvg59dLBrYZ/AsoCAen
         zl9ckUctwEHnQPZiwK2MoAlBem7hWrqusb+4WMkUYujmrlYWZ+v4navSQ+DjN/pQqEIE
         DyOg==
X-Gm-Message-State: AOAM530nI09eN7e0pUBZnL3397kKjYpx62V0k1cXU6PxR/FBiLnNPQn+
        3rcC+NcdOYrv1eD0vLvp9lJEXXPBoPXpY54lJPI=
X-Google-Smtp-Source: ABdhPJwh3eEneQdmnhq+u1myyzKeQZ9UlSi1Z4xXcu/MiqxjD9yu5khzzlHLK7VwjVF9jThBf54cyfSc5bC2wBoCL7g=
X-Received: by 2002:a65:5a4d:: with SMTP id z13mr29222301pgs.4.1620232022097;
 Wed, 05 May 2021 09:27:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210504174019.2134652-1-linux@roeck-us.net> <CAHp75Vd-iTkA5Y6tEHtfcqLxxmHaaU8nLQSL7eWb-gaa-c8AJg@mail.gmail.com>
 <8f8b6f33-4308-bfda-2238-9a54e19c3f9f@roeck-us.net> <20210505093235.00007c38@Huawei.com>
 <20210505093438.00005238@Huawei.com> <CAHp75VezSD_TcbQ_OBZXPo-szTr-qwOT9oU+7h7W6nk65ZLBhA@mail.gmail.com>
 <22212bbc-1dc7-c7e7-1954-ebb911754246@redhat.com> <CAHp75Vf+2oVttGhAcpcw-ZsAXno01yuKWz0Xiti_7beHCR81ng@mail.gmail.com>
 <ede732cb-4a23-e5bc-6802-0280dc232876@redhat.com> <CAHp75VciMKfxPvKmY349327FcoUcUMeFnvqkniw2erCyb71BoQ@mail.gmail.com>
 <3121ad81-1dc3-eace-a87c-47ebafa2d615@redhat.com>
In-Reply-To: <3121ad81-1dc3-eace-a87c-47ebafa2d615@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 5 May 2021 19:26:45 +0300
Message-ID: <CAHp75VfosJVmQOBUSQEVwrvkfUKnVdfAW7ctX+Yi8bFu1+jamw@mail.gmail.com>
Subject: Re: [PATCH] iio: bme680_i2c: Make bme680_acpi_match depend on CONFIG_ACPI
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Paul Menzel <paulepanter@users.sourceforge.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@denx.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, May 5, 2021 at 6:19 PM Hans de Goede <hdegoede@redhat.com> wrote:
> On 5/5/21 4:18 PM, Andy Shevchenko wrote:
> > On Wed, May 5, 2021 at 5:11 PM Hans de Goede <hdegoede@redhat.com> wrote:

...

> > Currently the scope is of
> > AOS2315
> > BME0680
> > STK8312
>
> Ok I cannot find any reference to those in the DSDT-s which I have,
> nor in systemd's hwdb.

Thanks for checking.

By the way. Do you have DSDTs in some kind of Git repository?
Shouldn't we have (means to create if not exists) one publicly
available? It would be nice to gather them under the hood for the
purpose of looking into. I have some (small) set of those as well
which might be useful.


-- 
With Best Regards,
Andy Shevchenko
