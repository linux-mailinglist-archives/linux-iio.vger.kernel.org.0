Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC1113EA731
	for <lists+linux-iio@lfdr.de>; Thu, 12 Aug 2021 17:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236942AbhHLPLW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Aug 2021 11:11:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:36616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235052AbhHLPLW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 12 Aug 2021 11:11:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BCA24610A4
        for <linux-iio@vger.kernel.org>; Thu, 12 Aug 2021 15:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628781056;
        bh=kkFquyJZIvadNOvjAdT4UgIaA4b6Wd9tQp2EI4WkqJU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ooZbDZSHRT/DENRuGewZ8lxQVt54sT3jwcOJMYuWMoUnP1NO6TepMRhBejKiqTXle
         oRzoWnn0CngUJsnCWCq2NCKwOaujno71lnLKS+J97D+U47G9JvV0qjCgv5xxwYfQZO
         l+VZje4ITryTL57h9wsmX0S27avkOKg7ADqIMv8WKFz7TNv7HLHhukckMxYdYPtTcK
         ZMdYrzZWOHWicjJVbw2LqjJunBHHK/+DAv1rYh0YA3dEzmN7UFOXaUvH5UtdzbHrOG
         3s/AEffJTuo61DjfJaN2Qb+eZogaRAXek2UlnUkOvizT5jj3DsB3K/glBcXZUBEseT
         S6/6JrW9xrZGw==
Received: by mail-ed1-f48.google.com with SMTP id r19so6881065eds.13
        for <linux-iio@vger.kernel.org>; Thu, 12 Aug 2021 08:10:56 -0700 (PDT)
X-Gm-Message-State: AOAM531D0ZQUO/2B4UxAb+m+cyLrEPpN3+MT1OLEL+xR3HQLe2nxqLVo
        DUk4E0HfgBTlWNxK9ZFnkOWDphHhTcmgDKO3zQ==
X-Google-Smtp-Source: ABdhPJyLX51lQQeCdop0uaLltLKFWJYFvmB9iTN/MqeJC3gw4OkeEyRXZlK3Hh/UQ8Fqh7T4+jTwLmq/Fef1uUKrTHc=
X-Received: by 2002:a05:6402:557:: with SMTP id i23mr5910985edx.373.1628781055292;
 Thu, 12 Aug 2021 08:10:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210811074827.21889-1-nuno.sa@analog.com> <CAHp75VeLfxyLG-zTdVVnwB+PR2v=LW-PcvM4ZkEoLq+Ht0-iCg@mail.gmail.com>
 <PH0PR03MB6366283246B9D4925BFA444C99F99@PH0PR03MB6366.namprd03.prod.outlook.com>
 <CAHp75VeZLKN0C_+PopKfYtPMqEzGLd4paSKYnrHr1B2Y1Nk9=w@mail.gmail.com> <PH0PR03MB636647F75955CF0C5E6D5A3D99F99@PH0PR03MB6366.namprd03.prod.outlook.com>
In-Reply-To: <PH0PR03MB636647F75955CF0C5E6D5A3D99F99@PH0PR03MB6366.namprd03.prod.outlook.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 12 Aug 2021 10:10:43 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+V0++aO8cTcd3A-nBiG_X4wzJ+ZXWnXeRMPb=2QYOUhw@mail.gmail.com>
Message-ID: <CAL_Jsq+V0++aO8cTcd3A-nBiG_X4wzJ+ZXWnXeRMPb=2QYOUhw@mail.gmail.com>
Subject: Re: [PATCH] iio: ad5770r: make devicetree property reading consistent
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Aug 12, 2021 at 3:14 AM Sa, Nuno <Nuno.Sa@analog.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Sent: Thursday, August 12, 2021 9:06 AM
> > To: Sa, Nuno <Nuno.Sa@analog.com>
> > Cc: linux-iio <linux-iio@vger.kernel.org>; Jonathan Cameron
> > <jic23@kernel.org>; Hennerich, Michael
> > <Michael.Hennerich@analog.com>; Lars-Peter Clausen
> > <lars@metafoo.de>
> > Subject: Re: [PATCH] iio: ad5770r: make devicetree property reading
> > consistent
> >
> >
> >
> > On Thursday, August 12, 2021, Sa, Nuno <Nuno.Sa@analog.com
> > <mailto:Nuno.Sa@analog.com> > wrote:
> >
> >
> >       > From: Andy Shevchenko <andy.shevchenko@gmail.com
> > <mailto:andy.shevchenko@gmail.com> >
> >       > Sent: Wednesday, August 11, 2021 6:04 PM
> >       > To: Sa, Nuno <Nuno.Sa@analog.com
> > <mailto:Nuno.Sa@analog.com> >
> >       > Cc: linux-iio <linux-iio@vger.kernel.org <mailto:linux-
> > iio@vger.kernel.org> >; Jonathan Cameron
> >       > <jic23@kernel.org <mailto:jic23@kernel.org> >; Hennerich,
> > Michael
> >       > <Michael.Hennerich@analog.com
> > <mailto:Michael.Hennerich@analog.com> >; Lars-Peter Clausen
> >       > <lars@metafoo.de <mailto:lars@metafoo.de> >
> >       > Subject: Re: [PATCH] iio: ad5770r: make devicetree property
> > reading
> >       > consistent
> >       >
> >       > On Wed, Aug 11, 2021 at 10:46 AM Nuno S=C3=A1
> > <nuno.sa@analog.com <mailto:nuno.sa@analog.com> >
> >       > wrote:
> >       > >
> >       > > The bindings file for this driver is defining the property as
> > 'reg' but
> >       > > the driver was reading it with the 'num' name. This patches
> > makes
> >       > the
> >       >
> >       > "This patches makes the..." --> "Make the..."
> >       >
> >       > > driver consistent with what is defined in the bindings.
> >       >
> >       > While it seems okay, it may be now a chicken-egg issue
> > (somebody
> >       > created a DT with "num" property).
> >       >
> >
> >       Arghh, I see. Well, maybe let's go the other way around and
> > change the
> >       bindings doc to 'num'?
> >
> >
> > Not sure, like I said it=E2=80=99s a chicken-egg issue. Consult with Ro=
b perhaps?
>
> Hi Rob,
>
> Could you give your input on this one?

There's no context, but I'm assuming this is in channel nodes. Keep
the binding 'reg' and make the driver support both if needed.
Considering the author of the binding also changed the binding from
num to reg shortly after adding the binding, I don't think 'num'
support is needed. If someone used 'num' and didn't run validation,
well, that's their problem.

Rob
