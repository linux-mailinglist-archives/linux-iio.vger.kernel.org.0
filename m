Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB9D41A09EE
	for <lists+linux-iio@lfdr.de>; Tue,  7 Apr 2020 11:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgDGJTn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 Apr 2020 05:19:43 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:38070 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgDGJTn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 Apr 2020 05:19:43 -0400
Received: by mail-pj1-f67.google.com with SMTP id m15so487135pje.3;
        Tue, 07 Apr 2020 02:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lROniNDiIOjjpIjvHpnVkfnddBnlAAfl2vsiVaC1w6o=;
        b=mGRWXEx53f8V++y2sqBoAJ0W40h0u3ObljSb2j8iQQAvSDWZZ70AVb3Pwu0EEylo0w
         NfLeJuroWUEq8q+pTLmqGSg05cDpZZCwMFe3N3rwXulOIfMdbz4/vhJYAOztxH0EwjQa
         b3pwIwxm3xvYCgz9wPIPHEWpO5ov9nunx8fWrPmEHvlTp7GTnY6ZakEVE86A6Udjqloj
         qDcS6FiCWb4JDhSQUIybCEtTJydQ39jZpqAjPLVPWPNhJji0Zlk4f9N2VX/mFFfAjU9g
         krp3/qosAdizvvC0zP7r6b2ypy0PDA3Q3mWVPWA8KeKtmdAi9PkTYW4305s1AIWuKzvE
         c1Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lROniNDiIOjjpIjvHpnVkfnddBnlAAfl2vsiVaC1w6o=;
        b=JoEWzI/xU8DFiZWTiAPAt/SojvgKXTiLWWMJiI5yzcCeT4zLU1J+wCTsMci7jrqWoQ
         nMAFbuxgolkYgN+2QUujtH4niM2iD2uUuwywV/MY+tXMJ97TJpFlmbtxfXUfI8J1AHCt
         QaWvNkzFQHyh7YCFrAI1NTKkkgTI2s0IkMatYPTLqUNeAgivffrll10lGW7KL51A0KOD
         YfQ2p/1pcpckqXU6M0f120lEPaPH8+yRIyGGbJ8rA0RLuJJTlTVMtfzG5l7Bma5V0sRh
         obShttVsIlDB/XpC76kbQK6IQR/khHlHjB/+Fz0HdVJtPITREGfOp+pdPSRYYIZ/DWgy
         zR6A==
X-Gm-Message-State: AGi0PuYfRmRKK+XFo0ZXx5tI1IDqzpj6kIrq2NF6j/K4F/FJkXPPINNi
        Oy0jkGvcLRJRfVbStRTgGUqslNodmMuAsJU5gail1v0FwrY=
X-Google-Smtp-Source: APiQypJordqgk/ugka5pE/qIu6yAn6IP19nsSoS08a2JxwizKmaqj9yLRA/TujXhtXBTWSBFc0Rp6rWmNZb5NKEH1B0=
X-Received: by 2002:a17:902:5acb:: with SMTP id g11mr1627149plm.18.1586251180188;
 Tue, 07 Apr 2020 02:19:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200406150846.878-1-nuno.sa@analog.com> <20200406150846.878-6-nuno.sa@analog.com>
 <CAHp75VeK8K0WHK3gDwyT3ZAaMaVdfZ5xVG94JY4O8fd2U0HEHg@mail.gmail.com> <BN6PR03MB33476ECFB3F8454CC6C67F0E99C30@BN6PR03MB3347.namprd03.prod.outlook.com>
In-Reply-To: <BN6PR03MB33476ECFB3F8454CC6C67F0E99C30@BN6PR03MB3347.namprd03.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 7 Apr 2020 12:19:28 +0300
Message-ID: <CAHp75VcOxjnNRetQxUR=8Z-WA=V6rzAFwCfhjNCmjQE3hgAEEA@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] iio: imu: Add support for adis16475
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Apr 7, 2020 at 10:26 AM Sa, Nuno <Nuno.Sa@analog.com> wrote:
> > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Sent: Montag, 6. April 2020 18:20
> > To: Sa, Nuno <Nuno.Sa@analog.com>
> > Cc: linux-iio <linux-iio@vger.kernel.org>; devicetree
> > <devicetree@vger.kernel.org>; Jonathan Cameron <jic23@kernel.org>;
> > Hartmut Knaack <knaack.h@gmx.de>; Lars-Peter Clausen
> > <lars@metafoo.de>; Peter Meerwald-Stadler <pmeerw@pmeerw.net>; Rob
> > Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>;
> > Ardelean, Alexandru <alexandru.Ardelean@analog.com>; Hennerich,
> > Michael <Michael.Hennerich@analog.com>
> > Subject: Re: [PATCH v4 5/6] iio: imu: Add support for adis16475
> >
> > On Mon, Apr 6, 2020 at 6:10 PM Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

...

> > > +       for_each_set_bit(bit, indio_dev->active_scan_mask,
> > > +                        indio_dev->masklength) {
> >
> > One line?
> >
>
> It goes beyond 80 col limit... I know I could initialize these to some lo=
cal const but...

That's why question mark is there.
Nonetheless, if it ~2-3 characters more, I would leave it on one line anywa=
y.

JFYI: readability has a priority over 80 limit.

> > > +       }

...

> > > +                       if (scaled_out_freq < 1900 || scaled_out_freq=
 > 2100) {
> > > +                               dev_err(dev,
> > > +                                       "Invalid value:%u for adi,sca=
led-output-hz",
> > > +                                       scaled_out_freq);
> >
> > When there is no property or property has a value 0 this message can't
> > tell the difference.
> > Perhaps you have to check return code from device_property_read_u32()
> > call.
> >
>
> Well, I think we don't really need to. If the sync mode is scaled, then t=
his property is mandatory
> (and this is stated in the bindings). So, I don't really care if the prop=
erty is not there or if it's just
> a wrong value. We should fail either way and I'm not sure an extra if wit=
h some other message will
> give us that extra value...

Up to maintainer (I have no strong opinion about this)

> > > +                               return -EINVAL;
> > > +                       }

...

> > > +       /*
> > > +        * It is possible to configure the data ready polarity. Furth=
ermore, we
> > > +        * need to update the adis struct if we want data ready as ac=
tive low.
> > > +        */
> > > +       irq_type =3D irqd_get_trigger_type(desc);
> > > +       if (irq_type =3D=3D IRQF_TRIGGER_RISING) {

> > > +               polarity =3D 1;

For the sake of consistency I would assign irq_flag here as well.

> > > +       } else if (irq_type =3D=3D IRQF_TRIGGER_FALLING) {
> > > +               polarity =3D 0;
> > > +               st->adis.irq_flag =3D IRQF_TRIGGER_FALLING;
> > > +       } else {
> > > +               dev_err(&spi->dev, "Invalid interrupt type 0x%x speci=
fied\n",
> > > +                       irq_type);
> > > +               return -EINVAL;
> > > +       }
> >
> > Here is the problem. You got type, but you compare it to flags. It's
> > not correct.
> > Although values are the same, the meaning is different.
> >
>
> Hmm, thanks! Honestly, this was copy paste from adis16480 and I never rea=
lized this. I will
> use IRQ_TYPE_EDGE_RISING and IRQ_TYPE_EDGE_FALLING. I guess we need a pat=
ch changing this
> in adis16480...

As a separate patch, yes.

--=20
With Best Regards,
Andy Shevchenko
