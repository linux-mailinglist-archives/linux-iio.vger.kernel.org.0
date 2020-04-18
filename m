Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 703251AEC42
	for <lists+linux-iio@lfdr.de>; Sat, 18 Apr 2020 13:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725891AbgDRL5o (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Apr 2020 07:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725869AbgDRL5o (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Apr 2020 07:57:44 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E2BC061A0C;
        Sat, 18 Apr 2020 04:57:44 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t16so2011671plo.7;
        Sat, 18 Apr 2020 04:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JmiC2uXHtR2fV4jcRb3MLojHtDU/Lt+48l8G1gdW4pk=;
        b=TQt1XJ/LmDCzVPpYbHIgAtwOcv0IN+PJyZ7rRRdduFFG3Xd4a/d9TxeRnt7+Rr5q1x
         XP4B+7fX3pjxV1n034fkSnVYfU5Dpnf6dz/OCAkfJ481soIXIdWvd4vrKxBHcKlojlrz
         keQGStkoVc8svZAU889HjBeS0bsEMBsRK53PzxSL0RjVcaKXOABRHtTr0UDN6+kxZNDP
         ctziZkG8W9U9uJtM857JK1YwRKBn/SIrK58kl07tpXlJIktMhUfRTpHAyXN17D/19bL5
         7+lsS6C6AdTVGzml6Wla4yaxDOqD+FRDTUjevnICk4GnNNifHsfJPKoJRtAs3TgqR34W
         keXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JmiC2uXHtR2fV4jcRb3MLojHtDU/Lt+48l8G1gdW4pk=;
        b=dVixjpAit8GoS0uw7Z77mDuqr6aWr7iGjNY4pOgRjdzzqrGnm4g12km/ropgFrp14z
         DRTib9f0o6+WJ8PG2O3z4Jtgv9Ry2knASWZrVn9mYQ9EVeZHWQv5d07J73PGkzPhzLEL
         QDMKRJ8YFazSk+uKQckIuFOb2GX7TlgbqEU1PMTdQKoHjGZmuVsJuTE5tnOSvbVhmDlp
         2h06Il/6yxtcyvxDDoP3Mr+8mU3UeG6R64Xpt+AM54Voeh+9YF8dt6c/661lgzYhCDF7
         1ePcMSLBpfF2TAZnPhq1visT2dFtt6MFvlxG3uwb66YpM256XtHGvqZlmZLY573MqaOv
         vu8w==
X-Gm-Message-State: AGi0PuZeGcu8DXgFdLjDtfj5euobYhYgnCZ4moy6QCfQS0CQptkCXcP1
        3BQ3h38+siMSCc8KMvmRD4AhdYNtqyWFhNMvMCw=
X-Google-Smtp-Source: APiQypIkRVqzXq895RV9hhPGbuM0W9MxE/rC5o4RLalyLhdj3OLmCHMZ8c7Ked3P4y/YyFrIg7si9CRwm17dYUECkRg=
X-Received: by 2002:a17:90a:224b:: with SMTP id c69mr10131123pje.8.1587211063897;
 Sat, 18 Apr 2020 04:57:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200417202859.35427-1-contact@artur-rojek.eu>
 <20200417202859.35427-5-contact@artur-rojek.eu> <CAHp75VfRbnnuUhfyXpu+5dp4TutHSrHus=sX_vG_5F0dX4k0fQ@mail.gmail.com>
 <UFBY8Q.ES4D59V22INC1@crapouillou.net> <CAHp75VfEAtqucMPdkygfBhojTJoHO5vFk_o0suiyf7i2JCMw9Q@mail.gmail.com>
 <7CFY8Q.68YMS0V08F992@crapouillou.net>
In-Reply-To: <7CFY8Q.68YMS0V08F992@crapouillou.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 18 Apr 2020 14:57:32 +0300
Message-ID: <CAHp75VeVvE8LAO8f=-cwfgL6erFZACGwMnriNRaQnfnHw31wkg@mail.gmail.com>
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

On Sat, Apr 18, 2020 at 1:48 AM Paul Cercueil <paul@crapouillou.net> wrote:
>
>
>
> Le sam. 18 avril 2020 =C3=A0 0:49, Andy Shevchenko
> <andy.shevchenko@gmail.com> a =C3=A9crit :
> > On Sat, Apr 18, 2020 at 12:24 AM Paul Cercueil <paul@crapouillou.net>
> > wrote:
> >>  Le sam. 18 avril 2020 =C3=A0 0:10, Andy Shevchenko
> >>  <andy.shevchenko@gmail.com> a =C3=A9crit :
> >>  > On Fri, Apr 17, 2020 at 11:21 PM Artur Rojek
> >> <contact@artur-rojek.eu>
> >>  > wrote:
> >
> > ...
> >
> >>  >>  +#include <linux/of.h>
> >>  >
> >>  > Do you really need this? (See below as well)
> >
> >>  >>  +static const struct of_device_id adc_joystick_of_match[] =3D {
> >>  >>  +       { .compatible =3D "adc-joystick", },
> >>  >>  +       { },
> >>  >>  +};
> >>  >>  +MODULE_DEVICE_TABLE(of, adc_joystick_of_match);
> >>  >>  +
> >>  >>  +static struct platform_driver adc_joystick_driver =3D {
> >>  >>  +       .driver =3D {
> >>  >>  +               .name =3D "adc-joystick",
> >>  >
> >>  >>  +               .of_match_table =3D
> >>  >> of_match_ptr(adc_joystick_of_match),
> >>  >
> >>  > Drop this a bit harmful of_match_ptr() macro. It should go with
> >> ugly
> >>  > #ifdeffery. Here you simple introduced a compiler warning.
> >>
> >>  I assume you mean #ifdef around the of_device_id + module table
> >> macro?
> >
> > Yes.
> >
> >>  > On top of that, you are using device property API, OF use in this
> >> case
> >>  > is contradictory (at lest to some extend).
> >>
> >>  I don't see why. The fact that the driver can work when probed from
> >>  platform code
> >
> > Ha-ha, tell me how. I would like to be very surprised.
>
> iio_map_array_register(),
> pinctrl_register_mappings(),
> platform_add_devices(),
>
> you're welcome.

I think above has no relation to what I'm talking about.

How *this* driver can work as a platform instantiated one?
We seems have a conceptual misunderstanding here.

For example, how can probe of this driver not fail, if it is not
backed by a DT/ACPI properties?

> >>  doesn't mean that it shouldn't have a table to probe
> >>  from devicetree.
> >
> > I didn't get what you are talking about here. The idea of _unified_
> > device property API is to get rid of OF-centric code in favour of more
> > generic approach. Mixing those two can be done only in specific cases
> > (here is not the one).
>
> And how are we mixing those two here? The only OF-centric thing here is
> the device table, which is required if we want the driver to probe from
> devicetree.

Table is fine(JFYI the types and sections are defined outside of OF
stuff, though being [heavily] used by it) , API (of_match_ptr() macro
use) is not.

--=20
With Best Regards,
Andy Shevchenko
