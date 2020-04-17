Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22E741AE7D6
	for <lists+linux-iio@lfdr.de>; Fri, 17 Apr 2020 23:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbgDQVxG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Apr 2020 17:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728202AbgDQVxF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Apr 2020 17:53:05 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81261C061A0C;
        Fri, 17 Apr 2020 14:53:05 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id o127so4057526iof.0;
        Fri, 17 Apr 2020 14:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4ZIurRzvKzhZuoAvzk1jdWnYdjdZhwYCtTWY/kwzyzc=;
        b=MHHFmFflGHZyA2d+a2MGEW/nmBW/qkwy1pEjJjNIVx0DLkbEfA5uQGiN+YeqIu9IGQ
         gjkX85oS7YUx6MoTbSTQJGGLMZop4tAJIwi/LP73NSiTkHtyafiRbf8kpxh7QclX9ph8
         Yc+OO6r0wSDWZEqSqSVen+xjO6bjAg7VM4zzEsfgYTys0OdPp2+h4gzAWXBWKsvsy65B
         31Xr8p7AcOxf3dOxW5j8xhyFOvO66LHO1tqkHGQXwQ+tFFaxVzEGUOH8umsayWtukALW
         fmGFlCCPtaA4HvlpIp16CsOt6l4Ou2DBzVxl4yhWzcb0YEi363RJnr/JSY022CFbRY/w
         wQmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4ZIurRzvKzhZuoAvzk1jdWnYdjdZhwYCtTWY/kwzyzc=;
        b=cJME+b4oiQ5QqZyMaN6abiVr3p7+WhQ3EyR3nFtKiF0YUC7cTLbIjJe9X0tpYbfBMn
         ekJgtaq4BwC0FyfWY3wCkD5jsT9g11MxiW4bfkqHuqLqAQ47NSWpc57d3Zf8Dfm/CUB4
         TAxez9X2CIhmCadr8b09MpQlPqCe4r3+9gSanoviTojtz0wVxeZfpkw9UdlcmNbPi3Le
         doYx3VwtuciDg6vMpJ0jH/osGiOSsD68W78+Cdh8WrIALRfGMxysLXO8txnb9gNXUNpU
         sD+g4zCrhnzihlnfWse3n3LszbZx/lmWISdnEyP8ojl0UH7PU1Rvg3yIqiDufz5dd1ol
         Pz+Q==
X-Gm-Message-State: AGi0PuafbnFN6ZmleFpytDzvQ2sqCjLOBzTOBRFKOPE6sKN+t2pcU8+e
        g2fnqcnKSjRrU1duXHfqIQMrpALLy/DBYHScFqA=
X-Google-Smtp-Source: APiQypLAFZkouE78x0T4U8EwYbe0dJ4blPl6DgsReNwyOBiVFNhNnnJGPaQ/xk8e6/vk7O8AdOVmT6SUhBMxZZfeKv4=
X-Received: by 2002:a02:c998:: with SMTP id b24mr5357266jap.23.1587160384789;
 Fri, 17 Apr 2020 14:53:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200417202859.35427-1-contact@artur-rojek.eu>
 <20200417202859.35427-3-contact@artur-rojek.eu> <CAHp75Vcwnu8tw92nMYc_5-x_iX+FY8_OhtaJkSYNehmNUDkHGQ@mail.gmail.com>
 <3KAY8Q.NNI6X4F9QRIX1@crapouillou.net> <CAHp75VfxQFFnVMhGvv0GCb3gv5jTPLDqLyhihRVc2earY=aYcg@mail.gmail.com>
 <86BY8Q.C5XO8D57M7BI1@crapouillou.net> <CAHp75VfULLBpFx-W04z+jRFv-hGZkTt1k7T9+eMurW55Mdc=+g@mail.gmail.com>
 <EFCY8Q.V3Q81CTO8TBP2@crapouillou.net>
In-Reply-To: <EFCY8Q.V3Q81CTO8TBP2@crapouillou.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 18 Apr 2020 00:52:53 +0300
Message-ID: <CAHp75VdBr-o61QESQcbF97F5+JAU=XjVsvZ01M=nN-pe50-H9w@mail.gmail.com>
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

On Sat, Apr 18, 2020 at 12:45 AM Paul Cercueil <paul@crapouillou.net> wrote=
:
> Le sam. 18 avril 2020 =C3=A0 0:42, Andy Shevchenko
> <andy.shevchenko@gmail.com> a =C3=A9crit :
> > On Sat, Apr 18, 2020 at 12:18 AM Paul Cercueil <paul@crapouillou.net>
> > wrote:
> >>  Le sam. 18 avril 2020 =C3=A0 0:13, Andy Shevchenko
> >>  <andy.shevchenko@gmail.com> a =C3=A9crit :
> >>  > On Sat, Apr 18, 2020 at 12:05 AM Paul Cercueil
> >> <paul@crapouillou.net>
> >>  > wrote:
> >>  >>  Le ven. 17 avril 2020 =C3=A0 23:59, Andy Shevchenko
> >>  >>  <andy.shevchenko@gmail.com> a =C3=A9crit :
> >>  >>  > On Fri, Apr 17, 2020 at 11:21 PM Artur Rojek
> >>  >> <contact@artur-rojek.eu>
> >>  >>  > wrote:
> >>  >
> >>  > ...
> >>  >
> >>  >>  >>  +       irq =3D platform_get_irq(pdev, 0);
> >>  >>  >
> >>  >>  > Before it worked w/o IRQ, here is a regression you introduced.
> >>  >>
> >>  >>  Before it simply did not need the IRQ, which is provided by the
> >>  >>  devicetree anyway. No regression here.
> >>  >
> >>  > Does it work without IRQ? Or it was a dead code till now?
> >>  > For me it's clear regression. Otherwise something is really wrong
> >> in a
> >>  > process of development of this driver.
> >>
> >>  Nothing wrong here. The IRQ was not used by the driver for the
> >>  functionality it provided before. It is required now to support the
> >>  touchscreen channels.
> >
> > This is exactly what's wrong.
> > Previous DTS for my (hypothetical) case has no IRQ defined. Everything
> > works, right?
> > Now, due to this change it breaks my setup. Don't you see the problem?
>
> The IRQ has been provided by every concerned DTS file since the
> introduction of this driver and the related bindings, even though it
> was not used by the driver.

Can you speak for all possible DTSs/DTBs in the wild?
Okay, in any case it will be problem of maintainers and yours if
somebody complains.
I'm not going to push this anyway -- your choice.

But I see a (potential) regression.

> >>  >>  >>  +       if (irq < 0) {
> >>  >>  >
> >>  >>  >>  +               dev_err(dev, "Failed to get irq: %d\n",
> >> irq);
> >>  >>  >
> >>  >>  > Redundant message.
> >>  >>  >
> >>  >>  >>  +               return irq;
> >>  >>  >>  +       }

--=20
With Best Regards,
Andy Shevchenko
