Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 223EC1AE7CF
	for <lists+linux-iio@lfdr.de>; Fri, 17 Apr 2020 23:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbgDQVuh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Apr 2020 17:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728202AbgDQVuh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Apr 2020 17:50:37 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26505C061A0C;
        Fri, 17 Apr 2020 14:50:37 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id z6so1428044plk.10;
        Fri, 17 Apr 2020 14:50:37 -0700 (PDT)
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
        b=pwTNs4qDe8WibAPeb6HbRk1vu+p3Xqj5bLrNXE/mfMk3ABc9+MynAoc2tD0JwBYkrg
         evv1/gQV5i4jflhZwseyKWpr8nT6Pk8qmZJJt6c3B03YdhGPk83CWzRVkQVatqAtII0s
         Fc8VKaHpVXNF+1zJeu8QztLhzDPSr3YGHHfuq2vmzSJlvOd1kUxbfFupkYIhOqvd+Pcd
         /yfrPE8BgceRh7J9zlD0vy98KdzridwTxFDeY8RIaB4Bc6+TMnvk9TJnbEQQrr3NCatg
         ZwIAw9QsidSR4gp91ElVqPPabnrysMD0ssApMzw7thVz9/w6i9v5+EDwq7V0dvTekLWJ
         cMng==
X-Gm-Message-State: AGi0PubNt6ViZI8ro2ZB9jn2ZsjJIxbUly4EF/mohhih/2POjLumrZj2
        1/X5W7WJ52Dmir1qmP4HSzqenZ9puCkwH3ae2dU=
X-Google-Smtp-Source: APiQypJkWQMGu9vzO25yxEIMTiFKD/QbefkVkLHcC5m213DXMOEFIc8Qj7+9MmcLHIdm1bGzG+j8Q0PI84zMeHEHUDA=
X-Received: by 2002:a17:902:854a:: with SMTP id d10mr5458422plo.262.1587160236702;
 Fri, 17 Apr 2020 14:50:36 -0700 (PDT)
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
