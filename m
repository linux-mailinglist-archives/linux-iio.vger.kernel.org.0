Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7501AFABB
	for <lists+linux-iio@lfdr.de>; Sun, 19 Apr 2020 15:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725793AbgDSNcA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Apr 2020 09:32:00 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:41203 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgDSNcA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Apr 2020 09:32:00 -0400
Received: from webmail.gandi.net (webmail15.sd4.0x35.net [10.200.201.15])
        (Authenticated sender: contact@artur-rojek.eu)
        by relay10.mail.gandi.net (Postfix) with ESMTPA id B7F79240003;
        Sun, 19 Apr 2020 13:31:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Sun, 19 Apr 2020 15:31:54 +0200
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-input <linux-input@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH v5 3/5] IIO: Ingenic JZ47xx: Add touchscreen mode.
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
Message-ID: <2ac495eef8143f2339b3e2a3eef24b27@artur-rojek.eu>
X-Sender: contact@artur-rojek.eu
User-Agent: Roundcube Webmail/1.3.8
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Ezequiel,

On 2020-04-19 14:54, Ezequiel Garcia wrote:
> On Fri, 17 Apr 2020 at 18:54, Andy Shevchenko 
> <andy.shevchenko@gmail.com> wrote:
>> 
>> On Sat, Apr 18, 2020 at 12:45 AM Paul Cercueil <paul@crapouillou.net> 
>> wrote:
>> > Le sam. 18 avril 2020 à 0:42, Andy Shevchenko
>> > <andy.shevchenko@gmail.com> a écrit :
>> > > On Sat, Apr 18, 2020 at 12:18 AM Paul Cercueil <paul@crapouillou.net>
>> > > wrote:
>> > >>  Le sam. 18 avril 2020 à 0:13, Andy Shevchenko
>> > >>  <andy.shevchenko@gmail.com> a écrit :
>> > >>  > On Sat, Apr 18, 2020 at 12:05 AM Paul Cercueil
>> > >> <paul@crapouillou.net>
>> > >>  > wrote:
>> > >>  >>  Le ven. 17 avril 2020 à 23:59, Andy Shevchenko
>> > >>  >>  <andy.shevchenko@gmail.com> a écrit :
>> > >>  >>  > On Fri, Apr 17, 2020 at 11:21 PM Artur Rojek
>> > >>  >> <contact@artur-rojek.eu>
>> > >>  >>  > wrote:
>> > >>  >
>> > >>  > ...
>> > >>  >
>> > >>  >>  >>  +       irq = platform_get_irq(pdev, 0);
>> > >>  >>  >
>> > >>  >>  > Before it worked w/o IRQ, here is a regression you introduced.
>> > >>  >>
>> > >>  >>  Before it simply did not need the IRQ, which is provided by the
>> > >>  >>  devicetree anyway. No regression here.
>> > >>  >
>> > >>  > Does it work without IRQ? Or it was a dead code till now?
>> > >>  > For me it's clear regression. Otherwise something is really wrong
>> > >> in a
>> > >>  > process of development of this driver.
>> > >>
>> > >>  Nothing wrong here. The IRQ was not used by the driver for the
>> > >>  functionality it provided before. It is required now to support the
>> > >>  touchscreen channels.
>> > >
>> > > This is exactly what's wrong.
>> > > Previous DTS for my (hypothetical) case has no IRQ defined. Everything
>> > > works, right?
>> > > Now, due to this change it breaks my setup. Don't you see the problem?
>> >
>> > The IRQ has been provided by every concerned DTS file since the
>> > introduction of this driver and the related bindings, even though it
>> > was not used by the driver.
>> 
>> Can you speak for all possible DTSs/DTBs in the wild?
>> Okay, in any case it will be problem of maintainers and yours if
>> somebody complains.
>> I'm not going to push this anyway -- your choice.
>> 
>> But I see a (potential) regression.
>> 
> 
> So, there are a few things to keep in mind here.
> 
> Let's abstract ourselves from this specific driver
> for a minute.
> 
> First, and just as Andy pointed out, we can never be fully
> sure about DTBs out there. These could be out of tree,
> so out of our control. By introducing a new requirement
> we break them, which may be seen as a regression.
> 
> Second, the interrupt is not required as per
> current mainline bindings/iio/adc/ingenic,adc.txt,
> so it is perfectly legal for users to not have an interrupt
> specified.
> 
> Now, back to this case, I think we can get away with this
> change, provided this hardware is not that widespread
> among developers/users that follow upstream closely.
> 
> I suspect anyone developing a serious platform
> with this SoC is most likely using some vendor kernel.
> 
> If that is not the case, i.e. if you have users _actually_
> using this upstream driver, then we should consider
> making the interrupt optional instead of required.
> 
> Or we can also just break it and hope nobody
> complaints.
> 
> BTW, this series looks great and I'm happy
> to see JZ47xx activity :-)
> 
> Arthur: perhaps you can consider converting the txt dt binding
> to yaml?
Sure, it will come with v6 of this patchset.
And this time I'll make the `interrupts` property required :-)

- Artur
> 
> Cheers,
> Ezequiel
