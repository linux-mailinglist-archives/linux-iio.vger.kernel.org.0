Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC93A11DCBB
	for <lists+linux-iio@lfdr.de>; Fri, 13 Dec 2019 05:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731684AbfLMEDe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Dec 2019 23:03:34 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33306 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbfLMEDe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Dec 2019 23:03:34 -0500
Received: by mail-lj1-f193.google.com with SMTP id 21so1110732ljr.0;
        Thu, 12 Dec 2019 20:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=L5uQwSQlRWVR2cnkqQftE5urW2BObiyzOTOXDSJ+kFg=;
        b=vBHRZju2P7wqsFDu1I1BrVyl+TSGW35FeBwccHGI55Ahuh9KF8JP9UfIsjVabDT7nn
         nujCbqKj1GAKOvoOd7SKsrlGZsmvp7L/egqhgp95a1uWh0lZDyEZi107UHEVlU47UIA6
         BgiLT6CGjfAHTlFKfefaQ2CGduDv992dpZuu1PE4LnXPOGepgDswA+bzQyWxBfEm5a8o
         d0hZAPnC1UIZ6toRqaiWvJi5Rct5Ky/ofx1UZ8CtMmqzigDliaNhSW4Figad2GmHimo1
         7KUBJf1qydJXa2Ml3/Z586FTYUw1VeemQkwx9SJBVJSxGC7/97fZUwow82uvGjez+AzZ
         yNkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=L5uQwSQlRWVR2cnkqQftE5urW2BObiyzOTOXDSJ+kFg=;
        b=bZlX8zxjBG8qcV99Eod31tBadDJX5fwWoQ1o4zIV1jibuFqj3xvBnI5oK2UIHpZN5B
         j7iVS0OVClZqJ9Jfb6jJg5ImLeJ5n0wNDR/MYLDcceolDkFtEmCaiPDJDouPwwxceQnc
         xFwB4GjhPByuJKfM/VW4a5YFymehIWgkAIwduHz86ZN5M3uBuphPZitSpXu4TXaOF9Wb
         B5WfdkqysW4R376Bareo+laabeuWygqSYviRja1QVHvrbr/Xcmm87eKXnrZksEqYOke9
         QDRAEfiizw6wPgnnBPwMH6nXIeX4zjk22z+Cr+HmLTVdlNTRLHSKbwv/4lMs7A+8kqN2
         vboA==
X-Gm-Message-State: APjAAAViePkNoyGUFkYIofYDY2z4ZVnYxMmZz/Sjty3UeE4SH/feDNbh
        9zG55ZKTY6/jNse1k1oswvfOxl4trIXpj6Qa6rw=
X-Google-Smtp-Source: APXvYqyT8v8iAkBDf8j+50bdcZNss1V7LWKa6r0wn8vjpJJcFL0sE3pcZPl7nzaBuH2jdvozf4gysX5sLdUJRv/KSFs=
X-Received: by 2002:a05:651c:29b:: with SMTP id b27mr7973573ljo.31.1576209811384;
 Thu, 12 Dec 2019 20:03:31 -0800 (PST)
MIME-Version: 1.0
References: <1576075099-3441-1-git-send-email-akinobu.mita@gmail.com>
 <1576075099-3441-3-git-send-email-akinobu.mita@gmail.com> <CAHp75Vfq4KqNAGY4ivveR7D0Z1fA1EOFT+oL9+f+Ak2jikCTVg@mail.gmail.com>
In-Reply-To: <CAHp75Vfq4KqNAGY4ivveR7D0Z1fA1EOFT+oL9+f+Ak2jikCTVg@mail.gmail.com>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Fri, 13 Dec 2019 13:03:19 +0900
Message-ID: <CAC5umyiMZLM6rObaKc25+5nFg2rug69zJMF-jPUH6NAgX8-qPw@mail.gmail.com>
Subject: Re: [PATCH v3 02/12] ACPI: thermal: switch to use <linux/units.h> helpers
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        linux-hwmon@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>,
        "open list:TI WILINK WIRELES..." <linux-wireless@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sujith Thomas <sujith.thomas@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

2019=E5=B9=B412=E6=9C=8812=E6=97=A5(=E6=9C=A8) 0:29 Andy Shevchenko <andy.s=
hevchenko@gmail.com>:
>
> On Wed, Dec 11, 2019 at 4:39 PM Akinobu Mita <akinobu.mita@gmail.com> wro=
te:
> >
> > This switches the ACPI thermal zone driver to use celsius_to_deci_kelvi=
n(),
> > deci_kelvin_to_celsius(), and deci_kelvin_to_millicelsius_with_offset()=
 in
> > <linux/units.h> instead of helpers in <linux/thermal.h>.
> >
> > This is preparation for centralizing the kelvin to/from Celsius convers=
ion
> > helpers in <linux/units.h>.
>
> >  #include <linux/reboot.h>
> >  #include <linux/device.h>
> >  #include <linux/thermal.h>
>
> > +#include <linux/units.h>
>
> Can we try to keep *some* order, i.e. put this after acpi.h below?

OK.

> >  #include <linux/acpi.h>
> >  #include <linux/workqueue.h>
> >  #include <linux/uaccess.h>
>
> >                         } else if (crt > 0) {
> > -                               unsigned long crt_k =3D CELSIUS_TO_DECI=
_KELVIN(crt);
> > +                               unsigned long crt_k =3D
> > +                                       celsius_to_deci_kelvin(crt);
>
> It used to be one line, why do two?

Because this line over 80 characters.  This patch doesn't make this line
longer, but checkpatch.pl complains about it.

> >         pr_info(PREFIX "%s [%s] (%ld C)\n", acpi_device_name(device),
> > -               acpi_device_bid(device), DECI_KELVIN_TO_CELSIUS(tz->tem=
perature));
> > +               acpi_device_bid(device),
> > +               deci_kelvin_to_celsius(tz->temperature));
>
> Ditto.

Same as above, checkpatch.pl complains about line over 80 characters.
