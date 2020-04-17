Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A45441AE75F
	for <lists+linux-iio@lfdr.de>; Fri, 17 Apr 2020 23:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgDQVNd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Apr 2020 17:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgDQVNc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Apr 2020 17:13:32 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC38C061A0C;
        Fri, 17 Apr 2020 14:13:32 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id w1so3891151iot.7;
        Fri, 17 Apr 2020 14:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LQkMAQhQ3Q4ujKr+N+JcvLq5bxq2t68xKQ23RXwzXF0=;
        b=W88eORhYDvm5Sp7nU3qy+AP4kldFzEtkaOm2qHsbRzoda9gD1KfCMJfVCdoJFl3lYY
         HM4Wpyw/BEMvrD6Fc8/tuwwXzlVLcFWmve4hOXZ7wrtSj/DDoqwq+SOpc8t90d5MK0f9
         FrV1VDywLwP0EJ5pyl7CWWXcoiohg+rXXuJmII79NW4nvEO8NE94f0kWk0RotYFDSVuH
         9CGqraJs27mU2xbsoltqiX0+RDQ1ipym+0BRiyNIRppwgSErTgVF5rs1nrEECghqTd/b
         mikdV9tgg07nZhnFUWJ/sHwP6uV9U8cQ2c36++Btg8qW5JEBq7R7+Z9QQzi1gxPNtugR
         bZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LQkMAQhQ3Q4ujKr+N+JcvLq5bxq2t68xKQ23RXwzXF0=;
        b=kKW6aYyP4pkprgRKMj5hFTkSfNRjA1uEe4z7Gie4Iwd0P5H4DwujuCN8ewmEt4H61j
         zH6R23kYs3i7dOOLdC3A4vibKIRVTGNj/q3w2KB6FWYFHX8/08sR8tlUr/z9VE3btOIO
         xdP7a6iwFt7/NursbCboqhAymBrFnllIkf0kG8eH5h69X3Hon2HRsDP0y6YVXO7NmLp1
         9FYjtjuLwIC4z/bHYqiadH+3DEc5Eb5KY26XvJiSambxfrjfW8VXd/4RinCQvFFMI7JQ
         8kXIoGSSLUPMy7cuPCoKHfczcSXTU7CzlZUWO97lGBOYnOvMN9oX08psG4o6GL0Q6eT5
         Q2yw==
X-Gm-Message-State: AGi0PuYQxSQh8FrLcoXCT0DOG9FCIjGAPHKCcgmF+xlZiFQozXOGNZE9
        ns/Y88AMpesddycJd78QZnyhYQ+aeHsdvN7CsXY=
X-Google-Smtp-Source: APiQypK+f6M+b1hXy4anrYyfrOmuO8ZnxAUJNloH8UY0gYShUDQ/LnZpdnqKunxarl7pQ7XbYNkE2D3oXzhAqMLwcMc=
X-Received: by 2002:a05:6602:1695:: with SMTP id s21mr5165403iow.40.1587158011596;
 Fri, 17 Apr 2020 14:13:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200417202859.35427-1-contact@artur-rojek.eu>
 <20200417202859.35427-3-contact@artur-rojek.eu> <CAHp75Vcwnu8tw92nMYc_5-x_iX+FY8_OhtaJkSYNehmNUDkHGQ@mail.gmail.com>
 <3KAY8Q.NNI6X4F9QRIX1@crapouillou.net>
In-Reply-To: <3KAY8Q.NNI6X4F9QRIX1@crapouillou.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 18 Apr 2020 00:13:20 +0300
Message-ID: <CAHp75VfxQFFnVMhGvv0GCb3gv5jTPLDqLyhihRVc2earY=aYcg@mail.gmail.com>
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

On Sat, Apr 18, 2020 at 12:05 AM Paul Cercueil <paul@crapouillou.net> wrote=
:
> Le ven. 17 avril 2020 =C3=A0 23:59, Andy Shevchenko
> <andy.shevchenko@gmail.com> a =C3=A9crit :
> > On Fri, Apr 17, 2020 at 11:21 PM Artur Rojek <contact@artur-rojek.eu>
> > wrote:

...

> >>  +       irq =3D platform_get_irq(pdev, 0);
> >
> > Before it worked w/o IRQ, here is a regression you introduced.
>
> Before it simply did not need the IRQ, which is provided by the
> devicetree anyway. No regression here.

Does it work without IRQ? Or it was a dead code till now?
For me it's clear regression. Otherwise something is really wrong in a
process of development of this driver.

> >>  +       if (irq < 0) {
> >
> >>  +               dev_err(dev, "Failed to get irq: %d\n", irq);
> >
> > Redundant message.
> >
> >>  +               return irq;
> >>  +       }

--=20
With Best Regards,
Andy Shevchenko
