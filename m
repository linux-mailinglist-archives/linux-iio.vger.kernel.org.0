Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F713A63AF
	for <lists+linux-iio@lfdr.de>; Mon, 14 Jun 2021 13:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234882AbhFNLQB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Jun 2021 07:16:01 -0400
Received: from mail-pl1-f179.google.com ([209.85.214.179]:39705 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235415AbhFNLOA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Jun 2021 07:14:00 -0400
Received: by mail-pl1-f179.google.com with SMTP id v11so6359206ply.6
        for <linux-iio@vger.kernel.org>; Mon, 14 Jun 2021 04:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PHosKG4LDFRN2LL0xDRanEgIKg/4w7yIjo5WgKJ2lAc=;
        b=YsUXyoGcr9SE8Wdv7xNXtWEuk2TeKeWHBiw86pPYLI4C1LGbyqTbctPLVHvm0vnF8K
         WSzQ6GzbpHpeEBhFcABVush1Fj/+4lKbhCDNdQj290wKzj9a8GCVcN74NzhYFi4+T7X7
         eVR1INjomgJY/Vo/OrV7nzG7pBQP/E/eGSAvMlPpdzpWIStWkcrBX/e2qPfcLBpdKiAe
         kovYSf0hy43kygRDi2WSkfs5iNS8ZnVTMBwnDpMB2BfQgTrevdXfjgQQjZcS43pJwQcL
         UBE7a2j5s1XgbGUYHsoWC3BTvXGera34cLiiIoctx33KBIi9EMNAnmYe8bLCOaa+XzPw
         0ILQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PHosKG4LDFRN2LL0xDRanEgIKg/4w7yIjo5WgKJ2lAc=;
        b=aMVEJ5HqSfVYACnNAkEo11ajaHkLKf27/YACbdrziTF3KJss/55e1NwaAIVJ69Welh
         z3isXRRO+WBKm+6/DAk8euDCgHKDRBez78qXQ/+MiuhNe4fw4thyaZIFdDonYPPsPD59
         kG6NSlzlqD1m51gnFo91tnSZ0ttfeXO/BPQPQatDD3k8SOe68T6TyTgzk6spc+JZ7HHW
         WsTd780Uw00Y5DnUJhBlNGZCrJ8+kvQIzU5Mafbjxy0FNEniZYQr77LcYb+fQSn0a6sQ
         Qr9Znp8xshGhx+mmnyulQ0iRY7qNJneNK++fdiX0yWyY9dmJmf3h/DsIn842boBlRaZ9
         Uzbw==
X-Gm-Message-State: AOAM533VYEd27WduaIjk2uhMJLh/rRiBQj8aSpV/KWGJk28sgj0UY9S7
        GknewX7HldQqVVMC27FnZ5ZnK7znuQJYKge5R4Q=
X-Google-Smtp-Source: ABdhPJyLP1C8OrrbTzpwTOxWu8T86Mka+7ey8ORlHO30LEGYm0TD9U0EOs9wr5q47jUd94oV2ETmG3V49cfQQ0r9IEA=
X-Received: by 2002:a17:90a:17ad:: with SMTP id q42mr23373744pja.181.1623669058013;
 Mon, 14 Jun 2021 04:10:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210611115558.796338-1-jarkko.nikula@linux.intel.com>
 <20210611115558.796338-2-jarkko.nikula@linux.intel.com> <CAHp75VfBoOvGp7O3-WSWFuXGbQP0EbSQYaJi5B28oBkazkV8+w@mail.gmail.com>
 <839944ff-e4e3-86c1-8d53-abaf96fa9271@linux.intel.com> <CAHp75VfqUftwaGrJVR0qAkLG=-=qNLEV=9fLAC5SCNtt2i_bJg@mail.gmail.com>
 <20210614093722.rurmqljcvzvlxpjp@pengutronix.de> <20210614114744.011e5abc@jic23-huawei>
In-Reply-To: <20210614114744.011e5abc@jic23-huawei>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 14 Jun 2021 14:10:41 +0300
Message-ID: <CAHp75VfzPG8ZD5QDEFhFHrqTZY2iMxo_YwJCp3kh6OeqJ8LAtg@mail.gmail.com>
Subject: Re: [PATCH 2/2] counter: intel-qep: Use to_pci_dev() helper
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jun 14, 2021 at 1:45 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Mon, 14 Jun 2021 11:37:22 +0200
> Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:
> > On Mon, Jun 14, 2021 at 11:57:46AM +0300, Andy Shevchenko wrote:
> > > +Uwe Kleine-K=C3=B6nig
> > > On Mon, Jun 14, 2021 at 11:24 AM Jarkko Nikula
> > > <jarkko.nikula@linux.intel.com> wrote:
> > > > On 6/13/21 1:36 PM, Andy Shevchenko wrote:
> > > > > On Fri, Jun 11, 2021 at 2:57 PM Jarkko Nikula
> > > > > <jarkko.nikula@linux.intel.com> wrote:

...

> > > > >> -       struct pci_dev *pdev =3D container_of(dev, struct pci_de=
v, dev);
> > > > >> +       struct pci_dev *pdev =3D to_pci_dev(dev);
> > > > >>          struct intel_qep *qep =3D pci_get_drvdata(pdev);
> > > > >
> > > > > Why not change both lines to dev_get_drvdata()?
> > > > >
> > > > I thought it before and Uwe had a good point why it isn't necessari=
ly a
> > > > good idea:
> > > >
> > > > https://www.spinics.net/lists/linux-pwm/msg15325.html
> > >
> > > I understand this point, but the problem is that we often use
> > > different callbacks for different layers. For example, the PM
> > > callbacks are operating with generic 'struct device' and using the PC=
I
> > > device there is non-flexible layering violation, so in my opinion it'=
s
> > > the opposite to what Uwe says. I.o.w. we need to use corresponding AP=
I
> > > to what we have in the callbacks. If the callback comes from generic
> > > level =3D=3D> generic APIs more appropriate.
> >
> > Without having looked at the driver in question: I (think I) understand
> > both sides here and both variants have their own downside.
> >
> >  - Using dev_get_drvdata() makes use of the fact that pci_set_drvdata()
> >    is a wrapper around dev_set_drvdata for the pcidev's struct device.
> >
> >  - Using pci_get_drvdata() adds overhead (for humans only though, the
> >    compiler doesn't care and creates the same code) and having the pci
> >    device in the callback isn't necessary.
> >
> > My personal opinion is: The first is the graver layer violation because
> > it relies on an implementation detail in the PCI framework. The latter
> > is relying on a fact that is local to the driver only: All devices this
> > driver is bound to are pci devices. The main benefit of explicitly usin=
g
> > pci_get_drvdata =E2=88=98 to_pci_dev I see is that someone having only =
shallow
> > knowledge of the PCI stuff can easier match a pci_get_drvdata() to the
> > pci_set_drvdata() called in .probe() than a dev_get_drvdata() and so
> > while it uses a function call/code line more, it is more explicit and
> > more obviously correct.
> >
> > And regarding your argument about the matching API: I think the above
> > code uses the matching API, that is make a pci_dev from a device using
> > to_pci_dev().
> >
> > So this is about weighting up- and downsides. How you judge them is
> > subjective. (Though my judgement is naturally the better one :-)
>
> Personally I'm happy with either
>
> dev_set_drvdata / dev_get_drvdata
> or
> pci_set_drvdata / pci_get_drvdata
>
> In this particular case there is a convenient struct device *dev local
> variable anyway in the probe() (IIRC) so could have done option 1 with
> no loss of readability and a tiny saving in code.

As I said this is unflexible.
For example, we have quite a few drivers that split in the way of
core part (as library) + glue driver(s)
How to implement callbacks that will use the same pairs of the callbacks?

I don't think it's possible in a good and neat way.

On top of that I think using the knowledge of the device nature in the
generic callbacks _is_ a layering violation.

TL;DR: the simple rule of thumb may be:
if the callback uses struct device, that dev_get_drvdata(), otherwise
based on what you have got as a parameter.
Does it make sense?

> Not worth changing it though is my 0.02=E2=82=AC


--=20
With Best Regards,
Andy Shevchenko
