Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49A6325AC3B
	for <lists+linux-iio@lfdr.de>; Wed,  2 Sep 2020 15:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbgIBNqK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Sep 2020 09:46:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:37120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbgIBNp2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 2 Sep 2020 09:45:28 -0400
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F16C72083B;
        Wed,  2 Sep 2020 13:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599053758;
        bh=mlVSzvECMBL4DuwaHxiiBTcwnXHH869ZUNFNn5ZDfIE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DwzP+62VAkbSZJH8gW+nur/seLAwcNH8Ot1zw2vohP9iERCpl+JdNyWK+dAjlIBnm
         FggnPXJH4LDrWLkgYmIpCe4olylTBdsvVLMkwhMcsq63oBMMBJ+AEUHGzVgkisBFIy
         MavokkFPF7CcXwUWfrLhL5UlGLpKzoT3KeMfLI4M=
Received: by mail-ed1-f51.google.com with SMTP id ba12so4951029edb.2;
        Wed, 02 Sep 2020 06:35:57 -0700 (PDT)
X-Gm-Message-State: AOAM533GsUM+0dZ3Pl1SDkzZ3skkYTgjfzm73wAeMX1PuCPbE5GA7KKL
        N+Yswd37JpLFXR5M4TpkHAev9vI591tqPdDUl3U=
X-Google-Smtp-Source: ABdhPJz83yuoWiKxgnivqzO50jIviESHbD2DdRL9JF0O0+pfD5vS2zg0SRBJnAffD9VLx1ZV5W17UvR9A9KJ7ydvdaM=
X-Received: by 2002:a05:6402:ca7:: with SMTP id cn7mr70494edb.143.1599053756468;
 Wed, 02 Sep 2020 06:35:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200827201707.27075-1-krzk@kernel.org> <CAHp75VcnV8_SRQuiTnzzaWxfA1m37gVXfxgPkH51tbMT+-T2RA@mail.gmail.com>
 <20200829155410.6d34a8b9@archlinux> <CAJKOXPd78m-3jMsFRa7ySREDdx+GMZ_YHMG3AcqCHTABLBwqVA@mail.gmail.com>
 <DM6PR03MB441122FDB3323690166C21A0F92F0@DM6PR03MB4411.namprd03.prod.outlook.com>
 <CAHp75VeOQpR00AZhaw=Dy3sEArhSQAPHXb7mhJGB80uyrSZ3Qg@mail.gmail.com> <20200902142656.00007ad1@Huawei.com>
In-Reply-To: <20200902142656.00007ad1@Huawei.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 2 Sep 2020 15:35:45 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcSctHLWGWwSPCyCR-U4QsB=WYBX3JMRqE7U9RHVKhNHA@mail.gmail.com>
Message-ID: <CAJKOXPcSctHLWGWwSPCyCR-U4QsB=WYBX3JMRqE7U9RHVKhNHA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Remove bouncing email of Beniamin Bia
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 2 Sep 2020 at 15:28, Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Wed, 2 Sep 2020 10:49:04 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
> > On Wed, Sep 2, 2020 at 8:56 AM Ardelean, Alexandru
> > <alexandru.Ardelean@analog.com> wrote:
> > >
> > > [yes, I know, bad-email format, but I wanted this to come from my work email]
> > >
> > > Apologies also for the delay here. Things pile-up on my side and I defer things a bit.
> > >
> > > Talked to Michael Hennerich about this [since he's the more senior contact at Analog].
> > > We can replace the email from Beniamin Bia with Michael's.
> > > Or, we can remove the "Orphan" blocks and just have the catch-all "drivers/iio/*/ad*" cover this driver and others that were upstreamed by Beniamin.
> > >
> > > Either option is fine from us.
> >
> > As a participant of activity to put MAINTAINERS in some order, I
> > prefer to have similar blocks be squashed.
> > If there will be a dedicated maintainer for a certain driver in the
> > future, we can always split into separate sections.
> >
> > So, something like
> > ANALOG DEVICES ADC (I guess it makes sense to have some grouping still)
> > ...
> > F: .../ad1234
> > F: .../ad2345
> >
> > In one section (no need to have wildcards right now).
> >
>
> ANALOG DEVICES INC IIO DRIVERS
> M:      Lars-Peter Clausen <lars@metafoo.de>
> M:      Michael Hennerich <Michael.Hennerich@analog.com>
> S:      Supported
> W:      http://wiki.analog.com/
> W:      http://ez.analog.com/community/linux-device-drivers
> F:      Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9523
> F:      Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4350
> F:      drivers/iio/*/ad*
> F:      drivers/iio/adc/ltc249*
> F:      drivers/staging/iio/*/ad*
> X:      drivers/iio/*/adjd*
>
> Already exists.  We could potentially clean that up.
>
> For the block that started this thread, we can just drop it.

I can send a follow up to merge/remove the entries.

Best regards,
Krzysztof
