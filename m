Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 673031AE7CA
	for <lists+linux-iio@lfdr.de>; Fri, 17 Apr 2020 23:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbgDQVuS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Apr 2020 17:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728202AbgDQVuR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Apr 2020 17:50:17 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9B8C061A0C;
        Fri, 17 Apr 2020 14:50:17 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id f19so4013087iog.5;
        Fri, 17 Apr 2020 14:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Yyfon3UjJVDXM3n7BEphB31enIUKUa7u+sxxgo0yrmI=;
        b=lDFcR1J7gKBByK0QttqrKwokhUL2wCzjXuKSau5eGx+XywUWM/r1Vl0xcmmygV8P29
         ptZLOj1qlHCQby9gugBWaQ8SI1/uDqNd5q7wLHETkOILxr7gmODBwTX5+RBlmeEuO611
         Q3ZG5mQjiisZ02za5ZRrHB1wdMX9sEsAla0KFKrjnWANEZxLSaGx9hbd+1/YNAjeS/Gg
         U1MLeyKI2NniVDgDTxJ6rw2LGNEF6vQnc9Cz+rgAyFK2r1JsyRb/xKc4AhFJAqKNX5o+
         9bOoNJ49E4rlDQF1gQhkFfDSzFWzTSOR35P3nehAqfzpo/cMNrbmSg+dp60zG7UhuLYu
         /3Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Yyfon3UjJVDXM3n7BEphB31enIUKUa7u+sxxgo0yrmI=;
        b=d0Da6GbANZIMM7wP/HU1vBlBphZyiuXjFYrFvVz1sZamxThlDXdOraqVwQnk9kfCCQ
         XAAgXeaQQQOtflSzp5wYFHQWGM2A6J70uZopC3kTlpowYB/JcOVdzSvHqYFrqJcZtVmW
         J1axha5/00pjUlWoTVAVclAS5cqmoqfhc0+bADR+Vvv8rjesoH52BR2G2ni9oOQt0doO
         0OyCTk/TiWXYNb6GmG+qjhre8pG7RjuYfr6F+/jzisrAFvvuafND5Q31FWi1fpCwrHSx
         6bW8bWlw3vGXT4bVAT7l7Vf9pF8jgCva6PAw5jatVzI0k5YntQAZYClKNFw5Kx+9ACuE
         jNFQ==
X-Gm-Message-State: AGi0PuafXloEeBD4YiOl41WcXst6+3QCZA80f9CNVzM8l7I0thou+i9N
        9LPR7Q9hbQyDQPnxy9PZLJPKLOGAgmjtDlxgFFI=
X-Google-Smtp-Source: APiQypLUrYGdfMIZGVFHbJuFwPr6yCRSi6YyHuDuqpJxPmyo6Dj9Pth5VceoheilyTTmiFdw0iypN0Chjm3Lit4vw8U=
X-Received: by 2002:a02:9642:: with SMTP id c60mr5301945jai.87.1587160216862;
 Fri, 17 Apr 2020 14:50:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200417202859.35427-1-contact@artur-rojek.eu>
 <20200417202859.35427-5-contact@artur-rojek.eu> <CAHp75VfRbnnuUhfyXpu+5dp4TutHSrHus=sX_vG_5F0dX4k0fQ@mail.gmail.com>
 <UFBY8Q.ES4D59V22INC1@crapouillou.net>
In-Reply-To: <UFBY8Q.ES4D59V22INC1@crapouillou.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 18 Apr 2020 00:49:41 +0300
Message-ID: <CAHp75VfEAtqucMPdkygfBhojTJoHO5vFk_o0suiyf7i2JCMw9Q@mail.gmail.com>
Subject: Re: [RESEND PATCH v5 5/5] input: joystick: Add ADC attached joystick driver.
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Artur Rojek <contact@artur-rojek.eu>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-input <linux-input@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Apr 18, 2020 at 12:24 AM Paul Cercueil <paul@crapouillou.net> wrote=
:
> Le sam. 18 avril 2020 =C3=A0 0:10, Andy Shevchenko
> <andy.shevchenko@gmail.com> a =C3=A9crit :
> > On Fri, Apr 17, 2020 at 11:21 PM Artur Rojek <contact@artur-rojek.eu>
> > wrote:

...

> >>  +#include <linux/of.h>
> >
> > Do you really need this? (See below as well)

> >>  +static const struct of_device_id adc_joystick_of_match[] =3D {
> >>  +       { .compatible =3D "adc-joystick", },
> >>  +       { },
> >>  +};
> >>  +MODULE_DEVICE_TABLE(of, adc_joystick_of_match);
> >>  +
> >>  +static struct platform_driver adc_joystick_driver =3D {
> >>  +       .driver =3D {
> >>  +               .name =3D "adc-joystick",
> >
> >>  +               .of_match_table =3D
> >> of_match_ptr(adc_joystick_of_match),
> >
> > Drop this a bit harmful of_match_ptr() macro. It should go with ugly
> > #ifdeffery. Here you simple introduced a compiler warning.
>
> I assume you mean #ifdef around the of_device_id + module table macro?

Yes.

> > On top of that, you are using device property API, OF use in this case
> > is contradictory (at lest to some extend).
>
> I don't see why. The fact that the driver can work when probed from
> platform code

Ha-ha, tell me how. I would like to be very surprised.

> doesn't mean that it shouldn't have a table to probe
> from devicetree.

I didn't get what you are talking about here. The idea of _unified_
device property API is to get rid of OF-centric code in favour of more
generic approach. Mixing those two can be done only in specific cases
(here is not the one).

--=20
With Best Regards,
Andy Shevchenko
