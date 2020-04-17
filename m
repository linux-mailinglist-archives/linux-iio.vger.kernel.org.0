Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C21131AE7B2
	for <lists+linux-iio@lfdr.de>; Fri, 17 Apr 2020 23:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgDQVmh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Apr 2020 17:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727889AbgDQVmh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Apr 2020 17:42:37 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FBBC061A0C;
        Fri, 17 Apr 2020 14:42:37 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id h11so1421906plr.11;
        Fri, 17 Apr 2020 14:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wJCxR0QUwLSKrpIugTVYPgkrEcw0H43/duFN1sQDZmw=;
        b=WpXr8dmyOqM1OiiXf44f9ECwAEggig32ZlUa5KS0kLJctQwMiMXakngbqWv3LvsCnL
         ThoPqdhlP2OtH2Nj0eqx0SSobKKMD5FGEXNnpfDZYoGNg/A7aoi2JrU2GtUKW5Dzk0HY
         xj5KZvNO4DwjVCx9X31FjWnPVGybi1ruchRHhfYKO5NQPlBbFGPbckaT44zrjSn6/EE8
         IR8CV8f3RDQyuNfvwS40M7qOqCpAWiy5D6p7/HFlj3vq8AbTJyF/H/AE2bnmLlN6bJGd
         ukxvIvWRZFXlTQ5N3RidH7qO58cBKeNkvfZtSPUJH+YE6fOwqHBN0fgCRw0S3LoQnhUM
         MFeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wJCxR0QUwLSKrpIugTVYPgkrEcw0H43/duFN1sQDZmw=;
        b=Yo/gmM6I4FyiKmDueRLvU9e4nXC+nsAsTMCZcyWD/WLxwhmDVXLDu0sJ94OlnMCuZQ
         n88wHsTmSwq/cL8ZuPteo8iaY36y24R7DywEmsO4b1WddgpReb7Y0bcOWpg5gKQzaARa
         iwYyR4WdwDT01Mdu1FPI5/pkXwKhpoCcYbX2AQWt6jgtY39qoUtJualQQF3lPFHV4gAn
         ICmyerJF/ISX079xJ1uYxIKLDc7xtSsQdLkdoke8jCS+TeCyE9gHDK2fJbsSc1ZydmwW
         HlHRIhxmxE5fWX431WRlleVuJS/bs85SIFKolYOud2XIk2Gi3gH+1bO95NCBt5vge0o7
         839g==
X-Gm-Message-State: AGi0Pub4I9p4NCIoyUhVFAdfBjXbubYl08me1Kf55paYXi0f1/XXp2gJ
        bwLISua1Tb/kDxzKkRAeE9OZqN+6mnpcM4Lx5DY=
X-Google-Smtp-Source: APiQypIBLm58Ay7O0Ceh4Ol6/asI7ebiv0F7ZyemYLRT2HLDFyyXpgyfg4snSkjpFzuEbCHSrSWbd39eL5uSDUagkos=
X-Received: by 2002:a17:90a:224b:: with SMTP id c69mr6938323pje.8.1587159755973;
 Fri, 17 Apr 2020 14:42:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200417202859.35427-1-contact@artur-rojek.eu>
 <20200417202859.35427-3-contact@artur-rojek.eu> <CAHp75Vcwnu8tw92nMYc_5-x_iX+FY8_OhtaJkSYNehmNUDkHGQ@mail.gmail.com>
 <3KAY8Q.NNI6X4F9QRIX1@crapouillou.net> <CAHp75VfxQFFnVMhGvv0GCb3gv5jTPLDqLyhihRVc2earY=aYcg@mail.gmail.com>
 <86BY8Q.C5XO8D57M7BI1@crapouillou.net>
In-Reply-To: <86BY8Q.C5XO8D57M7BI1@crapouillou.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 18 Apr 2020 00:42:23 +0300
Message-ID: <CAHp75VfULLBpFx-W04z+jRFv-hGZkTt1k7T9+eMurW55Mdc=+g@mail.gmail.com>
Subject: Re: [RESEND PATCH v5 3/5] IIO: Ingenic JZ47xx: Add touchscreen mode.
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

On Sat, Apr 18, 2020 at 12:18 AM Paul Cercueil <paul@crapouillou.net> wrote=
:
> Le sam. 18 avril 2020 =C3=A0 0:13, Andy Shevchenko
> <andy.shevchenko@gmail.com> a =C3=A9crit :
> > On Sat, Apr 18, 2020 at 12:05 AM Paul Cercueil <paul@crapouillou.net>
> > wrote:
> >>  Le ven. 17 avril 2020 =C3=A0 23:59, Andy Shevchenko
> >>  <andy.shevchenko@gmail.com> a =C3=A9crit :
> >>  > On Fri, Apr 17, 2020 at 11:21 PM Artur Rojek
> >> <contact@artur-rojek.eu>
> >>  > wrote:
> >
> > ...
> >
> >>  >>  +       irq =3D platform_get_irq(pdev, 0);
> >>  >
> >>  > Before it worked w/o IRQ, here is a regression you introduced.
> >>
> >>  Before it simply did not need the IRQ, which is provided by the
> >>  devicetree anyway. No regression here.
> >
> > Does it work without IRQ? Or it was a dead code till now?
> > For me it's clear regression. Otherwise something is really wrong in a
> > process of development of this driver.
>
> Nothing wrong here. The IRQ was not used by the driver for the
> functionality it provided before. It is required now to support the
> touchscreen channels.

This is exactly what's wrong.
Previous DTS for my (hypothetical) case has no IRQ defined. Everything
works, right?
Now, due to this change it breaks my setup. Don't you see the problem?

> >>  >>  +       if (irq < 0) {
> >>  >
> >>  >>  +               dev_err(dev, "Failed to get irq: %d\n", irq);
> >>  >
> >>  > Redundant message.
> >>  >
> >>  >>  +               return irq;
> >>  >>  +       }

--=20
With Best Regards,
Andy Shevchenko
