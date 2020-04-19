Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBA111AFA3A
	for <lists+linux-iio@lfdr.de>; Sun, 19 Apr 2020 14:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgDSMzD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Apr 2020 08:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbgDSMzD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Apr 2020 08:55:03 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA72DC061A41
        for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2020 05:55:02 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id k22so816296eds.6
        for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2020 05:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Pe8Qy0Gf3UYgcgfyDsFH4TWiKOw4rDRv4sJ8XYFqXvU=;
        b=u5lsvyNiSZb72r61DjpSksiUWO68i7LgEwVmotr4VBUqiRFRHbu2EruGUR/XBlNEO0
         w71OJJQA2nfs4t0byKoJVt3UH1HkQWxyvbQSfFBKBADfB3hAbDPA970lzbHMpYbIvwqL
         RZ8lKNLdNGbBmxLFk9m5TQ/NmAZJJIDm1RHwU3fInbPJOk725NoYiS4UDtO199ntC7ep
         dIbdnH6ZEg7srkRWiZQo2AFfsNsYI2pMQhYoRkdzl5fHj57TMSgxYcz07QJp/iUeySl9
         h874sFgcXFQ4EfR7A7gVAKFCBENF8X40dhP9BkbjLSaY1E0q1cMS4g87YmZoAEnm25Jq
         a0TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Pe8Qy0Gf3UYgcgfyDsFH4TWiKOw4rDRv4sJ8XYFqXvU=;
        b=Qdn4taVRCmeDeIA7jL53cqyt70mEunmOZE8eYGpw4cn7yMZnKayuKISKwneoVfK7WQ
         ayAHDMpJcq3YIaaaFtV06k+8UjwG71UgATwnOv9WaCBt8KKehkcNzjK6xSK1FwXw8rAz
         /TUofhfuEmZOGa/0fGUbRcr9yBnqzv5PCOhhpdh/BDxNmbGGC5d3OLQBAohNPXj1uoIG
         ow2HJLBhk/SfvcnyFVosEaZ6a2oDSaPEsPlPya3N201or1WohXCVgq960CDH4ezngkip
         XdEQg4dI7NCRSStvZeuz8/YcI38HsNpoX2RlBPk0k1QVLNC6pHcXYWDMAbNBESvRQ11k
         n9JA==
X-Gm-Message-State: AGi0PubxkhsWnj6Zqw6oQOdlxvHJdmSaK6IRr9Sg/uyQuaKbvTNOhvjd
        GhPE9MkBrhFBcxvqEA1joFpuoe0idGiU8DFd/J+BLw==
X-Google-Smtp-Source: APiQypJGVGjxtdPPkJ5/MNfOnUxhN+8psU1U9lQOyFemqbXIrJY0T9nZmKqlxy3Xpjm3uBwBmE88iVK+GHu7W9vYYM8=
X-Received: by 2002:a05:6402:391:: with SMTP id o17mr4297099edv.71.1587300901412;
 Sun, 19 Apr 2020 05:55:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200417202859.35427-1-contact@artur-rojek.eu>
 <20200417202859.35427-3-contact@artur-rojek.eu> <CAHp75Vcwnu8tw92nMYc_5-x_iX+FY8_OhtaJkSYNehmNUDkHGQ@mail.gmail.com>
 <3KAY8Q.NNI6X4F9QRIX1@crapouillou.net> <CAHp75VfxQFFnVMhGvv0GCb3gv5jTPLDqLyhihRVc2earY=aYcg@mail.gmail.com>
 <86BY8Q.C5XO8D57M7BI1@crapouillou.net> <CAHp75VfULLBpFx-W04z+jRFv-hGZkTt1k7T9+eMurW55Mdc=+g@mail.gmail.com>
 <EFCY8Q.V3Q81CTO8TBP2@crapouillou.net> <CAHp75VdBr-o61QESQcbF97F5+JAU=XjVsvZ01M=nN-pe50-H9w@mail.gmail.com>
In-Reply-To: <CAHp75VdBr-o61QESQcbF97F5+JAU=XjVsvZ01M=nN-pe50-H9w@mail.gmail.com>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Sun, 19 Apr 2020 09:54:49 -0300
Message-ID: <CAAEAJfDLQnpsMPs8n4S1O6dA9155=mUPE7FqNQo_yNmp--UFgg@mail.gmail.com>
Subject: Re: [RESEND PATCH v5 3/5] IIO: Ingenic JZ47xx: Add touchscreen mode.
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Paul Cercueil <paul@crapouillou.net>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 17 Apr 2020 at 18:54, Andy Shevchenko <andy.shevchenko@gmail.com> w=
rote:
>
> On Sat, Apr 18, 2020 at 12:45 AM Paul Cercueil <paul@crapouillou.net> wro=
te:
> > Le sam. 18 avril 2020 =C3=A0 0:42, Andy Shevchenko
> > <andy.shevchenko@gmail.com> a =C3=A9crit :
> > > On Sat, Apr 18, 2020 at 12:18 AM Paul Cercueil <paul@crapouillou.net>
> > > wrote:
> > >>  Le sam. 18 avril 2020 =C3=A0 0:13, Andy Shevchenko
> > >>  <andy.shevchenko@gmail.com> a =C3=A9crit :
> > >>  > On Sat, Apr 18, 2020 at 12:05 AM Paul Cercueil
> > >> <paul@crapouillou.net>
> > >>  > wrote:
> > >>  >>  Le ven. 17 avril 2020 =C3=A0 23:59, Andy Shevchenko
> > >>  >>  <andy.shevchenko@gmail.com> a =C3=A9crit :
> > >>  >>  > On Fri, Apr 17, 2020 at 11:21 PM Artur Rojek
> > >>  >> <contact@artur-rojek.eu>
> > >>  >>  > wrote:
> > >>  >
> > >>  > ...
> > >>  >
> > >>  >>  >>  +       irq =3D platform_get_irq(pdev, 0);
> > >>  >>  >
> > >>  >>  > Before it worked w/o IRQ, here is a regression you introduced=
.
> > >>  >>
> > >>  >>  Before it simply did not need the IRQ, which is provided by the
> > >>  >>  devicetree anyway. No regression here.
> > >>  >
> > >>  > Does it work without IRQ? Or it was a dead code till now?
> > >>  > For me it's clear regression. Otherwise something is really wrong
> > >> in a
> > >>  > process of development of this driver.
> > >>
> > >>  Nothing wrong here. The IRQ was not used by the driver for the
> > >>  functionality it provided before. It is required now to support the
> > >>  touchscreen channels.
> > >
> > > This is exactly what's wrong.
> > > Previous DTS for my (hypothetical) case has no IRQ defined. Everythin=
g
> > > works, right?
> > > Now, due to this change it breaks my setup. Don't you see the problem=
?
> >
> > The IRQ has been provided by every concerned DTS file since the
> > introduction of this driver and the related bindings, even though it
> > was not used by the driver.
>
> Can you speak for all possible DTSs/DTBs in the wild?
> Okay, in any case it will be problem of maintainers and yours if
> somebody complains.
> I'm not going to push this anyway -- your choice.
>
> But I see a (potential) regression.
>

So, there are a few things to keep in mind here.

Let's abstract ourselves from this specific driver
for a minute.

First, and just as Andy pointed out, we can never be fully
sure about DTBs out there. These could be out of tree,
so out of our control. By introducing a new requirement
we break them, which may be seen as a regression.

Second, the interrupt is not required as per
current mainline bindings/iio/adc/ingenic,adc.txt,
so it is perfectly legal for users to not have an interrupt
specified.

Now, back to this case, I think we can get away with this
change, provided this hardware is not that widespread
among developers/users that follow upstream closely.

I suspect anyone developing a serious platform
with this SoC is most likely using some vendor kernel.

If that is not the case, i.e. if you have users _actually_
using this upstream driver, then we should consider
making the interrupt optional instead of required.

Or we can also just break it and hope nobody
complaints.

BTW, this series looks great and I'm happy
to see JZ47xx activity :-)

Arthur: perhaps you can consider converting the txt dt binding
to yaml?

Cheers,
Ezequiel
