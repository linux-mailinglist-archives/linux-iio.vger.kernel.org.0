Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4AC2B7DE1
	for <lists+linux-iio@lfdr.de>; Wed, 18 Nov 2020 13:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbgKRMwu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Nov 2020 07:52:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgKRMwu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Nov 2020 07:52:50 -0500
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6380BC0613D4;
        Wed, 18 Nov 2020 04:52:50 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id y18so1836712ilp.13;
        Wed, 18 Nov 2020 04:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wzrnd7ru2kaBqfdd45rq9TddpeZGif2RVKPJRSLQI3s=;
        b=TlYBdSZzpaW2FiQluPWVvSNLkouu0qMkLKKotMHfTu5dwanD115LCVtGRmnM7tViyi
         dNqpq57hCD0IerxpBbQeEO+Ka10SeoQX5/3GWolmUlM2xJne/riLoYCfcgSTWG4t+xWJ
         6vZo5LgtSRwRPeeHSOHWcdVK7PxlJyMoLsOEGydNb+uP5dSrW6jDv8SCaSsjBQ8AP5Ga
         QV5JPNk8Yr2nZfXJLRC4u+r54Im/D830HIdHbPqVKHc1TMwgLaRLKhZujC1MhTI2C/jn
         6cZIZR6g3+2PB9+VoTmbU7Ot2ZJxnODHZ3TJns8Ey8Lb0gm4sVaS+ZId4sT66b5rMzmj
         Sx8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wzrnd7ru2kaBqfdd45rq9TddpeZGif2RVKPJRSLQI3s=;
        b=XP8cX1ioLbFfUpvz5Zy5wZ1ia6efwuw2BawYXG+vygpt78/SMMzdrnXv4y/lNNN8hQ
         l1MaAv2mwQnZIJQcx9HOU7JEtmTMFdMnYG46In5Wa8kTLS8zvAn45p2LKDMZa3aCtrgH
         AuaSBiebRK0OTSEHnFwE4af/XZQXLsk6XSLGUqG7JSiafCV5tQogZffOgjGUGKzTGzlj
         D5mqkz5ebRdWl1CikFMDn3a0Rvr9LRsZXOuOdgRRxqVBzVgxAB9vcy/bXlx5mh5fMzlX
         4hPQQ8uF0P5TyK8SzmfQAC0RELtU2nkJz9bZKiH/xYUSqV7eXz8CQZXmA5abNedM3QU8
         bgaQ==
X-Gm-Message-State: AOAM532uha85CPPkwa+kdjX71y8ruJqDdh7dFMuKe+1BZ5doyJX+25EX
        2LuB+g7MIMWG0NraXonoEjNtfIMdM0x4YvP4Hr6G/Thkuh1Arw==
X-Google-Smtp-Source: ABdhPJy0fX+lcmmXzIlqfNie1TanUYv4qa3GgtyYnMvOyW5qYXKut25OlReiNtNCQIHAvDYyZBL5zpZaYK4HMiOlZ5o=
X-Received: by 2002:a92:d90c:: with SMTP id s12mr17061620iln.100.1605703969800;
 Wed, 18 Nov 2020 04:52:49 -0800 (PST)
MIME-Version: 1.0
References: <20201117075254.4861-1-alexandru.ardelean@analog.com>
 <20201117104126.00000516@Huawei.com> <CAHp75VfKDSsiWqK0Bkkbe1ChntsRAFP5C_2qEzw+YE_qPjhJcQ@mail.gmail.com>
In-Reply-To: <CAHp75VfKDSsiWqK0Bkkbe1ChntsRAFP5C_2qEzw+YE_qPjhJcQ@mail.gmail.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Wed, 18 Nov 2020 14:52:38 +0200
Message-ID: <CA+U=DsqF5tu8Be9KXeyCWD2uHvV688Nc3n=z_Xi2J6H6DFJPRQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] iio: adc: ad7887: convert dual-channel mode to DT/ACPI
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Nov 17, 2020 at 1:10 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Nov 17, 2020 at 12:42 PM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Tue, 17 Nov 2020 09:52:52 +0200
> > Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
> >
> > > This change converts the configuration of the dual-channel mode from the
> > > old platform-data, to the device_property_present() function, which
> > > supports both device-tree and ACPI configuration setups.
> > >
> > > With this change the old platform_data include of the driver can be
> > > removed.
> > >
> > > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > Hi Alex,
> >
> > I'm a bit in too minds about device_property_present()
> > vs device_property_read_bool() which are the same thing under the hood.
> >
> > Not sure which one conveys the correct semantics here.
> > I don't feel strongly enough about it though to do more than raise
> > eyebrows (i.e. not blocking this series).
>
> The idea as I understand it is that the 'present' can be run against
> any type of property, while 'bool' is specifically for boolean (the
> similarities is a detail of implementation).

Yeah, I'm also not sure which to use here.
I guess I got used to using device_property_present() a bit more.
They're both pretty used around other drivers.
I guess I'll leave it as is for now, unless other complaints.


>
> --
> With Best Regards,
> Andy Shevchenko
