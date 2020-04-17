Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A798C1AE778
	for <lists+linux-iio@lfdr.de>; Fri, 17 Apr 2020 23:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgDQVSX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Apr 2020 17:18:23 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:60290 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbgDQVSX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Apr 2020 17:18:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1587158300; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5k83m+YQ/YjzGCYNL53EXy0Y9lSW9rtJnIlxD9H/TDA=;
        b=sKr8AsmVcnP58PaG7Ml8U/UnEWO2S+S8NsYqW3PgRr40iK50euk4O6fUOjT1qSV+tEzetN
        z//xT9wtdEkKLhs1xaAXXWgeTMbNd5f3xWKnZCiYhFYI2VhTEFacMTh9YJ9VqXwgANvOhn
        zpR9n7Rq7LYOjf8HwU//sQMZsQmtkvE=
Date:   Fri, 17 Apr 2020 23:18:08 +0200
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
Message-Id: <86BY8Q.C5XO8D57M7BI1@crapouillou.net>
In-Reply-To: <CAHp75VfxQFFnVMhGvv0GCb3gv5jTPLDqLyhihRVc2earY=aYcg@mail.gmail.com>
References: <20200417202859.35427-1-contact@artur-rojek.eu>
        <20200417202859.35427-3-contact@artur-rojek.eu>
        <CAHp75Vcwnu8tw92nMYc_5-x_iX+FY8_OhtaJkSYNehmNUDkHGQ@mail.gmail.com>
        <3KAY8Q.NNI6X4F9QRIX1@crapouillou.net>
        <CAHp75VfxQFFnVMhGvv0GCb3gv5jTPLDqLyhihRVc2earY=aYcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



Le sam. 18 avril 2020 =E0 0:13, Andy Shevchenko=20
<andy.shevchenko@gmail.com> a =E9crit :
> On Sat, Apr 18, 2020 at 12:05 AM Paul Cercueil <paul@crapouillou.net>=20
> wrote:
>>  Le ven. 17 avril 2020 =E0 23:59, Andy Shevchenko
>>  <andy.shevchenko@gmail.com> a =E9crit :
>>  > On Fri, Apr 17, 2020 at 11:21 PM Artur Rojek=20
>> <contact@artur-rojek.eu>
>>  > wrote:
>=20
> ...
>=20
>>  >>  +       irq =3D platform_get_irq(pdev, 0);
>>  >
>>  > Before it worked w/o IRQ, here is a regression you introduced.
>>=20
>>  Before it simply did not need the IRQ, which is provided by the
>>  devicetree anyway. No regression here.
>=20
> Does it work without IRQ? Or it was a dead code till now?
> For me it's clear regression. Otherwise something is really wrong in a
> process of development of this driver.

Nothing wrong here. The IRQ was not used by the driver for the=20
functionality it provided before. It is required now to support the=20
touchscreen channels.

-Paul


>>  >>  +       if (irq < 0) {
>>  >
>>  >>  +               dev_err(dev, "Failed to get irq: %d\n", irq);
>>  >
>>  > Redundant message.
>>  >
>>  >>  +               return irq;
>>  >>  +       }
>=20
> --
> With Best Regards,
> Andy Shevchenko


