Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A96A1AE7BB
	for <lists+linux-iio@lfdr.de>; Fri, 17 Apr 2020 23:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbgDQVpc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Apr 2020 17:45:32 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:54294 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727899AbgDQVpb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Apr 2020 17:45:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1587159928; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GDrjhz1ENVMvfgoCf0EYV/5TG0WL1W6/+3LS7tljxdw=;
        b=W6E+W7AjsDTvA3BqvTgnCcRGL1CPeI62wxw1zsG7t6+zo7rCVcLANDTVEJqzFYN3q1jSb7
        543eXxewuQDowRtorlYn4KAHEDmsIsXrDOThx1642yIwFQYEGq9Y3t4S2NntK7Hb30WcO/
        qFRTHyPXbUgugdrc2ghr77x1TiKBHp4=
Date:   Fri, 17 Apr 2020 23:45:14 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [RESEND PATCH v5 3/5] IIO: Ingenic JZ47xx: Add touchscreen mode.
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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
Message-Id: <EFCY8Q.V3Q81CTO8TBP2@crapouillou.net>
In-Reply-To: <CAHp75VfULLBpFx-W04z+jRFv-hGZkTt1k7T9+eMurW55Mdc=+g@mail.gmail.com>
References: <20200417202859.35427-1-contact@artur-rojek.eu>
        <20200417202859.35427-3-contact@artur-rojek.eu>
        <CAHp75Vcwnu8tw92nMYc_5-x_iX+FY8_OhtaJkSYNehmNUDkHGQ@mail.gmail.com>
        <3KAY8Q.NNI6X4F9QRIX1@crapouillou.net>
        <CAHp75VfxQFFnVMhGvv0GCb3gv5jTPLDqLyhihRVc2earY=aYcg@mail.gmail.com>
        <86BY8Q.C5XO8D57M7BI1@crapouillou.net>
        <CAHp75VfULLBpFx-W04z+jRFv-hGZkTt1k7T9+eMurW55Mdc=+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



Le sam. 18 avril 2020 =E0 0:42, Andy Shevchenko=20
<andy.shevchenko@gmail.com> a =E9crit :
> On Sat, Apr 18, 2020 at 12:18 AM Paul Cercueil <paul@crapouillou.net>=20
> wrote:
>>  Le sam. 18 avril 2020 =E0 0:13, Andy Shevchenko
>>  <andy.shevchenko@gmail.com> a =E9crit :
>>  > On Sat, Apr 18, 2020 at 12:05 AM Paul Cercueil=20
>> <paul@crapouillou.net>
>>  > wrote:
>>  >>  Le ven. 17 avril 2020 =E0 23:59, Andy Shevchenko
>>  >>  <andy.shevchenko@gmail.com> a =E9crit :
>>  >>  > On Fri, Apr 17, 2020 at 11:21 PM Artur Rojek
>>  >> <contact@artur-rojek.eu>
>>  >>  > wrote:
>>  >
>>  > ...
>>  >
>>  >>  >>  +       irq =3D platform_get_irq(pdev, 0);
>>  >>  >
>>  >>  > Before it worked w/o IRQ, here is a regression you introduced.
>>  >>
>>  >>  Before it simply did not need the IRQ, which is provided by the
>>  >>  devicetree anyway. No regression here.
>>  >
>>  > Does it work without IRQ? Or it was a dead code till now?
>>  > For me it's clear regression. Otherwise something is really wrong=20
>> in a
>>  > process of development of this driver.
>>=20
>>  Nothing wrong here. The IRQ was not used by the driver for the
>>  functionality it provided before. It is required now to support the
>>  touchscreen channels.
>=20
> This is exactly what's wrong.
> Previous DTS for my (hypothetical) case has no IRQ defined. Everything
> works, right?
> Now, due to this change it breaks my setup. Don't you see the problem?

The IRQ has been provided by every concerned DTS file since the=20
introduction of this driver and the related bindings, even though it=20
was not used by the driver.

-Paul

>>  >>  >>  +       if (irq < 0) {
>>  >>  >
>>  >>  >>  +               dev_err(dev, "Failed to get irq: %d\n",=20
>> irq);
>>  >>  >
>>  >>  > Redundant message.
>>  >>  >
>>  >>  >>  +               return irq;
>>  >>  >>  +       }
>=20
> --
> With Best Regards,
> Andy Shevchenko


