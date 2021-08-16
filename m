Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56E183ED3D2
	for <lists+linux-iio@lfdr.de>; Mon, 16 Aug 2021 14:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233115AbhHPMTx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Aug 2021 08:19:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:40836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233062AbhHPMTw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 16 Aug 2021 08:19:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6F37663250
        for <linux-iio@vger.kernel.org>; Mon, 16 Aug 2021 12:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629116361;
        bh=fkwYtGzcGjNX2Kcon/vEUYpEYIRH2QcItHqEfXQT3FU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=G/PLBbS+mAlicy1+899urPvkA6QL3lVeEOgotL4S9gUe+g20e45f3M2RHA3Ajg/a4
         qgeGbFvJKrkvgogMfL+XsJcbZ15xgTtoopnpTqM06TW4Ah2cD59t6PtBJN+/qzADYO
         vFHQ5GVQ3ufVrHuNWjSSVGMwZvG/Z1ISyTLxOwT78lftCXBcIIUMdMlv3lbwubqV98
         m63BBoSPWKes6YhMvLd4akDu/mVgeY4D45+IBNg99HI/7nI4ASuFd5KI99IwpIbAB2
         44WnmGSljWfJjhghAKYU+Ic2Wj4ODtBffhgZBpJzdu+WUIg9R7LPdFcAuuNbQ5z93z
         Egyx8/XSIslog==
Received: by mail-ej1-f42.google.com with SMTP id h9so31398516ejs.4
        for <linux-iio@vger.kernel.org>; Mon, 16 Aug 2021 05:19:21 -0700 (PDT)
X-Gm-Message-State: AOAM533JVyx2mGbt4lB3Z7I5WTNXVFV/B8HSveA0ku3urPi1buPrX9Lk
        kz6ZMNR8nbBK8z+X8HN7FRkGrNrapQ9DvR5KuA==
X-Google-Smtp-Source: ABdhPJyIjvR+iXUBhFE0KqW1I+Yagbvw71KG/FihP4ibB+cX9eY/O2BvqsYMG2RZ5SYZiW6RowcXjSeR+yPUG+5aTq0=
X-Received: by 2002:a17:906:519:: with SMTP id j25mr15278274eja.525.1629116360014;
 Mon, 16 Aug 2021 05:19:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210811074827.21889-1-nuno.sa@analog.com> <CAHp75VeLfxyLG-zTdVVnwB+PR2v=LW-PcvM4ZkEoLq+Ht0-iCg@mail.gmail.com>
 <PH0PR03MB6366283246B9D4925BFA444C99F99@PH0PR03MB6366.namprd03.prod.outlook.com>
 <CAHp75VeZLKN0C_+PopKfYtPMqEzGLd4paSKYnrHr1B2Y1Nk9=w@mail.gmail.com>
 <PH0PR03MB636647F75955CF0C5E6D5A3D99F99@PH0PR03MB6366.namprd03.prod.outlook.com>
 <CAL_Jsq+V0++aO8cTcd3A-nBiG_X4wzJ+ZXWnXeRMPb=2QYOUhw@mail.gmail.com>
 <PH0PR03MB63662507607DD7E06995B7EE99FA9@PH0PR03MB6366.namprd03.prod.outlook.com>
 <CAHp75Ve=C62FmC20qkLsMVFkc-rbhHqmY2StDtrYqG0=mjtcTw@mail.gmail.com>
 <PH0PR03MB63665918437E96CAF35B7CD799FA9@PH0PR03MB6366.namprd03.prod.outlook.com>
 <20210814170204.387bf394@jic23-huawei> <PH0PR03MB6366A5DE7A67BE19759E929499FD9@PH0PR03MB6366.namprd03.prod.outlook.com>
In-Reply-To: <PH0PR03MB6366A5DE7A67BE19759E929499FD9@PH0PR03MB6366.namprd03.prod.outlook.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 16 Aug 2021 07:19:08 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+joQaYrWNj4sHk4XtTnLurb8vjHrnp2L0yQr3gAJGdLQ@mail.gmail.com>
Message-ID: <CAL_Jsq+joQaYrWNj4sHk4XtTnLurb8vjHrnp2L0yQr3gAJGdLQ@mail.gmail.com>
Subject: Re: [PATCH] iio: ad5770r: make devicetree property reading consistent
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 16, 2021 at 2:54 AM Sa, Nuno <Nuno.Sa@analog.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Saturday, August 14, 2021 6:04 PM
> > To: Sa, Nuno <Nuno.Sa@analog.com>
> > Cc: Andy Shevchenko <andy.shevchenko@gmail.com>; Rob Herring
> > <robh+dt@kernel.org>; linux-iio <linux-iio@vger.kernel.org>;
> > Hennerich, Michael <Michael.Hennerich@analog.com>; Lars-Peter
> > Clausen <lars@metafoo.de>
> > Subject: Re: [PATCH] iio: ad5770r: make devicetree property reading
> > consistent
> >
> > [External]
> >
> > On Fri, 13 Aug 2021 10:05:17 +0000
> > "Sa, Nuno" <Nuno.Sa@analog.com> wrote:
> >
> > > > -----Original Message-----
> > > > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > > Sent: Friday, August 13, 2021 10:05 AM
> > > > To: Sa, Nuno <Nuno.Sa@analog.com>
> > > > Cc: Rob Herring <robh+dt@kernel.org>; linux-iio <linux-
> > > > iio@vger.kernel.org>; Jonathan Cameron <jic23@kernel.org>;
> > > > Hennerich, Michael <Michael.Hennerich@analog.com>; Lars-Peter
> > > > Clausen <lars@metafoo.de>
> > > > Subject: Re: [PATCH] iio: ad5770r: make devicetree property
> > reading
> > > > consistent
> > > >
> > > > On Fri, Aug 13, 2021 at 10:47 AM Sa, Nuno <Nuno.Sa@analog.com>
> > > > wrote:
> > > > > > From: Rob Herring <robh+dt@kernel.org>
> > > > > > Sent: Thursday, August 12, 2021 5:11 PM
> > > > > > On Thu, Aug 12, 2021 at 3:14 AM Sa, Nuno
> > <Nuno.Sa@analog.com>
> > > > > > wrote:
> > > >
> > > > ...
> > > >
> > > > > > > Could you give your input on this one?
> > > > > >
> > > > > > There's no context, but I'm assuming this is in channel nodes.
> > Keep
> > > > >
> > > > > Sorry about that. Your assumption is correct, the binding is for a
> > > > channel
> > > > > node [1]. The driver just get's it as 'num' [2] which is not
> > consistent.
> > > > > Naively, I just though changing the driver to use reg would be
> > > > enough
> > > > > but Andy nicely raised the question of someone being already
> > relying
> > > > > on 'num'...
> > > > >
> > > > > > the binding 'reg' and make the driver support both if needed.
> > > > > > Considering the author of the binding also changed the binding
> > > > from
> > > > > > num to reg shortly after adding the binding, I don't think 'num'
> > > > > > support is needed. If someone used 'num' and didn't run
> > > > validation,
> > > > > > well, that's their problem.
> > > > > >
> > > > >
> > > > > So I guess the solution here is just to change the driver to support
> > > > both
> > > > > reg and num.
> > > >
> > > > As far as I got Rob's answer, if the binding never had the 'num',
> > > > dropping it from the driver is what we want now (actually your
> > > > original patch) and users, who are 'too much clever' :-) should have
> > > > had run validation for their DTs before production.
> > > >
> > > > Taking this into account, I'm fine with the patch (but update a
> > commit
> > > > message to summarize this discussion)
> > > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > >
> > >
> > > You're right...
> > > Jonathan, do you want a v2 with an updated commit message?
> >
> > Please do. Also please add a fixes tag given we are treating it
> > as a fix.  If we discover someone is using the num variant then
> > we'll just have to support both values as a fix to the fix.
> > Not ideal, but as observed, hopefully people are validating the
> > DTs (which basically means no one is using this in production or
> > it would have been pointed out before).
> >
>
> Well, It seems we need to go through the support both 'num' and 'reg'
> route... I did some git blaming and it turns out 'num' was actually supported
> in the bindings [1]. After some time it was replaced by 'reg' [2] leaving the
> driver unchanged... I guess we have a significant window of time here
> where someone could deploy a *validated* devicetree using 'num'...

No there wasn't. Both commits landed in v5.7.

> If no objections, on v2 I will just try to get 'reg' and if not present, fallback
> to 'num' before erroring out.

Unless a user turns up and complains, then I say drop 'num'.

Rob
