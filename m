Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9031AFA7D
	for <lists+linux-iio@lfdr.de>; Sun, 19 Apr 2020 15:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgDSNXw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Apr 2020 09:23:52 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:39152 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgDSNXv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Apr 2020 09:23:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1587302628; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V5aVne3toyOMR2QBY60+iBE8eXu6co6XW9dZTwffKo8=;
        b=T4dD6Mu0qsqoFzPTaTcL7pzwWw/lgS57C09Bl5JrvBSbPnBP5j2jj6o88OOpnUIVgvXWIY
        LSgZbBhuliIt625pMfgkVEdycqk70aK1fm5Q0GhjW+txD1T3dwTXdZTAHR3a/wiDAfbJXC
        mKqFTGItPkROeChe5xiBfhaoqlWY62A=
Date:   Sun, 19 Apr 2020 15:23:36 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [RESEND PATCH v5 3/5] IIO: Ingenic JZ47xx: Add touchscreen mode.
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Artur Rojek <contact@artur-rojek.eu>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-input <linux-input@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-Id: <CJE19Q.00J5TK0U2OLF3@crapouillou.net>
In-Reply-To: <CAAEAJfDLQnpsMPs8n4S1O6dA9155=mUPE7FqNQo_yNmp--UFgg@mail.gmail.com>
References: <20200417202859.35427-1-contact@artur-rojek.eu>
        <20200417202859.35427-3-contact@artur-rojek.eu>
        <CAHp75Vcwnu8tw92nMYc_5-x_iX+FY8_OhtaJkSYNehmNUDkHGQ@mail.gmail.com>
        <3KAY8Q.NNI6X4F9QRIX1@crapouillou.net>
        <CAHp75VfxQFFnVMhGvv0GCb3gv5jTPLDqLyhihRVc2earY=aYcg@mail.gmail.com>
        <86BY8Q.C5XO8D57M7BI1@crapouillou.net>
        <CAHp75VfULLBpFx-W04z+jRFv-hGZkTt1k7T9+eMurW55Mdc=+g@mail.gmail.com>
        <EFCY8Q.V3Q81CTO8TBP2@crapouillou.net>
        <CAHp75VdBr-o61QESQcbF97F5+JAU=XjVsvZ01M=nN-pe50-H9w@mail.gmail.com>
        <CAAEAJfDLQnpsMPs8n4S1O6dA9155=mUPE7FqNQo_yNmp--UFgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Ezequiel,


Le dim. 19 avril 2020 =E0 9:54, Ezequiel Garcia=20
<ezequiel@vanguardiasur.com.ar> a =E9crit :
> On Fri, 17 Apr 2020 at 18:54, Andy Shevchenko=20
> <andy.shevchenko@gmail.com> wrote:
>>=20
>>  On Sat, Apr 18, 2020 at 12:45 AM Paul Cercueil=20
>> <paul@crapouillou.net> wrote:
>>  > Le sam. 18 avril 2020 =E0 0:42, Andy Shevchenko
>>  > <andy.shevchenko@gmail.com> a =E9crit :
>>  > > On Sat, Apr 18, 2020 at 12:18 AM Paul Cercueil=20
>> <paul@crapouillou.net>
>>  > > wrote:
>>  > >>  Le sam. 18 avril 2020 =E0 0:13, Andy Shevchenko
>>  > >>  <andy.shevchenko@gmail.com> a =E9crit :
>>  > >>  > On Sat, Apr 18, 2020 at 12:05 AM Paul Cercueil
>>  > >> <paul@crapouillou.net>
>>  > >>  > wrote:
>>  > >>  >>  Le ven. 17 avril 2020 =E0 23:59, Andy Shevchenko
>>  > >>  >>  <andy.shevchenko@gmail.com> a =E9crit :
>>  > >>  >>  > On Fri, Apr 17, 2020 at 11:21 PM Artur Rojek
>>  > >>  >> <contact@artur-rojek.eu>
>>  > >>  >>  > wrote:
>>  > >>  >
>>  > >>  > ...
>>  > >>  >
>>  > >>  >>  >>  +       irq =3D platform_get_irq(pdev, 0);
>>  > >>  >>  >
>>  > >>  >>  > Before it worked w/o IRQ, here is a regression you=20
>> introduced.
>>  > >>  >>
>>  > >>  >>  Before it simply did not need the IRQ, which is provided=20
>> by the
>>  > >>  >>  devicetree anyway. No regression here.
>>  > >>  >
>>  > >>  > Does it work without IRQ? Or it was a dead code till now?
>>  > >>  > For me it's clear regression. Otherwise something is really=20
>> wrong
>>  > >> in a
>>  > >>  > process of development of this driver.
>>  > >>
>>  > >>  Nothing wrong here. The IRQ was not used by the driver for the
>>  > >>  functionality it provided before. It is required now to=20
>> support the
>>  > >>  touchscreen channels.
>>  > >
>>  > > This is exactly what's wrong.
>>  > > Previous DTS for my (hypothetical) case has no IRQ defined.=20
>> Everything
>>  > > works, right?
>>  > > Now, due to this change it breaks my setup. Don't you see the=20
>> problem?
>>  >
>>  > The IRQ has been provided by every concerned DTS file since the
>>  > introduction of this driver and the related bindings, even though=20
>> it
>>  > was not used by the driver.
>>=20
>>  Can you speak for all possible DTSs/DTBs in the wild?
>>  Okay, in any case it will be problem of maintainers and yours if
>>  somebody complains.
>>  I'm not going to push this anyway -- your choice.
>>=20
>>  But I see a (potential) regression.
>>=20
>=20
> So, there are a few things to keep in mind here.
>=20
> Let's abstract ourselves from this specific driver
> for a minute.
>=20
> First, and just as Andy pointed out, we can never be fully
> sure about DTBs out there. These could be out of tree,
> so out of our control. By introducing a new requirement
> we break them, which may be seen as a regression.
>=20
> Second, the interrupt is not required as per
> current mainline bindings/iio/adc/ingenic,adc.txt,
> so it is perfectly legal for users to not have an interrupt
> specified.
>=20
> Now, back to this case, I think we can get away with this
> change, provided this hardware is not that widespread
> among developers/users that follow upstream closely.
>=20
> I suspect anyone developing a serious platform
> with this SoC is most likely using some vendor kernel.
>=20
> If that is not the case, i.e. if you have users _actually_
> using this upstream driver, then we should consider
> making the interrupt optional instead of required.
>=20
> Or we can also just break it and hope nobody
> complaints.

The vast majority of Ingenic devices running Linux use a 3.x kernel=20
with a lot of patches on top. These kernels don't support devicetree.=20
So there is no problem with legacy devicetree files: there are no=20
legacy devicetree files.

Of the few Ingenic devices running mainline kernels, all of them with=20
an ADC node in the devicetree have the 'interrupts' property specified,=20
out-of-tree or in-tree.

As the informal Ingenic SoCs maintainer I'm pretty aware of these=20
things, and I can assure that we're not breaking anything. The only=20
thing broken is the documentation which doesn't specify that the=20
'interrupts' property is required.

> BTW, this series looks great and I'm happy
> to see JZ47xx activity :-)
>=20
> Arthur: perhaps you can consider converting the txt dt binding
> to yaml?

That would be great.

-Paul


