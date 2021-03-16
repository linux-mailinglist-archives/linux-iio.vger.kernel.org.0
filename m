Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5031733DB82
	for <lists+linux-iio@lfdr.de>; Tue, 16 Mar 2021 18:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239350AbhCPRyQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Mar 2021 13:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbhCPRxp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 16 Mar 2021 13:53:45 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97034C061762
        for <linux-iio@vger.kernel.org>; Tue, 16 Mar 2021 10:53:43 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id s21so11036072pjq.1
        for <linux-iio@vger.kernel.org>; Tue, 16 Mar 2021 10:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l7cCd6nspXNqWfZCDlihpaBU82Un768UFhkLI5YdecA=;
        b=oqhV9HUSqXuokLziiYGQaGZD9a0vvmOFl8k5q6vYZsPrI6VCFKvROrD/JCEpFkpEtJ
         GjsWOvZTShbysMcvoqo1r3FfEsWergIHb1xBnfZl29JA2K2uZ21z9MbQPg3fVVCEAcGa
         s1BgeTOzgS6ema+La6r3p7GJO7K5/509sGUZ5kJlHxg3Q9rxuhpDbGSp93c+imYKVCmc
         VId911dl6zfytPRNWmL2Pec8XWa9uxoVFdRk358YOsy/PY84HaGBF8kERUi8EIr+fi4A
         eS3J1BF5EgDAMCvYzzlE7aeYDRfMJmtE4jei2lPsUkvLriRNMOSB1hhwXDw9y2OsiQ4w
         rgRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l7cCd6nspXNqWfZCDlihpaBU82Un768UFhkLI5YdecA=;
        b=sCFSLgWlW+fhnSOtNuCpAnCf9/l6YEK6KNNusV6R+qd+N3J2mgeoEo3J4XQYIhKAKN
         rLUjljgTtKu2EBeAdYpwlXOMUmQJFL/kG4t7mxYK7AlBCUbXXWWBD87Pii4R1g3j34Lc
         7F1Blr4/z2kmt97mo8lgw+JSeZR1RXTJpl/dH+AbCgEjKiwNaRNqmFYp/77WS8DLsg57
         9oBOoZV85XNb2cN6VzF+yGMTYNjD/xBfT2rbe6TlIch3O7LvhL2QrxXq9RPmhh8NVwar
         84Rwimwqn7Lz7proGQ1NWTw84MHZS/p4z0QaDUquml7pRPqZzhXXIvjUPfRtbPi5cLFV
         bitg==
X-Gm-Message-State: AOAM533ZbmccuDBcuyQcReqTeFbVTmnZR1F/8b2+edJr/S9v5rOySyET
        R/y5GZQrIfBdZoLczyzejUHM8MmOJrOJLnPP2srZsQ==
X-Google-Smtp-Source: ABdhPJwtz2CiY4BGbbujhdm8nXOffcTlbwfFgcze2Eti94js3p4IpOAaFaIVGqnEnh2O8N37QKU/pqnFlGdj6lr8MWw=
X-Received: by 2002:a17:902:7407:b029:e4:9b2c:528b with SMTP id
 g7-20020a1709027407b02900e49b2c528bmr602784pll.6.1615917222874; Tue, 16 Mar
 2021 10:53:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210309231259.78050-1-jbhayana@google.com> <20210309231259.78050-2-jbhayana@google.com>
 <20210311210844.34371d8d@archlinux> <20210312121639.00001c31@Huawei.com>
 <20210312133101.GG30179@e120937-lin> <CA+=V6c0boA1Q+k4rM0NOcK4ek_FYU7omEWhvMowqACH_t44sAQ@mail.gmail.com>
 <20210313171107.4c8215e7@archlinux> <CA+=V6c0a8z9+gkD_M6KNviN-VActtmpTgkuCBn-sgC4Fm2C6QA@mail.gmail.com>
 <20210314154033.3facf1a2@archlinux> <CA+=V6c341JjXQ+QFpiSES_Lm7PT0qCh2WU0uQWrmrFaPr_2QiA@mail.gmail.com>
 <20210316131314.GI30179@e120937-lin>
In-Reply-To: <20210316131314.GI30179@e120937-lin>
From:   Jyoti Bhayana <jbhayana@google.com>
Date:   Tue, 16 Mar 2021 10:53:31 -0700
Message-ID: <CA+=V6c0MPo9ehxtHyf5FmYk9QB--K_N8qkggkN1M=zwKEQ8h3Q@mail.gmail.com>
Subject: Re: [PATCH v7 1/1] iio/scmi: Adding support for IIO SCMI Based Sensors
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Enrico Granata <egranata@google.com>,
        Mikhail Golubev <mikhail.golubev@opensynergy.com>,
        Igor Skalkin <Igor.Skalkin@opensynergy.com>,
        Peter Hilber <Peter.hilber@opensynergy.com>,
        Ankit Arora <ankitarora@google.com>,
        Guru Nagarajan <gurunagarajan@google.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Christian,

Thanks for porting the driver to the new interface. I have commented
on changes in v7-0025-iio-scmi-port-driver-to-the-new-scmi_sensor_proto.patch.

Thanks,
Jyoti

On Tue, Mar 16, 2021 at 6:13 AM Cristian Marussi
<cristian.marussi@arm.com> wrote:
>
> Hi
>
> I reposted my series on top of the take3 immutable branch from Jonathan
> at:
>
> https://lore.kernel.org/lkml/20210316124903.35011-1-cristian.marussi@arm.com/T/#t
>
> You should have received an email regarding the relevant IIO SCMI patch
>
> v7-0025-iio-scmi-port-driver-to-the-new-scmi_sensor_proto.patch
>
> which includes the port of your v7 IIO SCMI driver to the new API, and moved
> also the notification registration to the probe phase to simplify it
> further.
>
> On my side I tested with some fake emulated sensors emitting periodic
> 100ms SENSOR_UPDATE notifs...and verifying that notifications are still
> dispatched and received fine. (values are just fakes)
>
> If you can have a look, comment and possibly Ack.
>
> Thanks
>
> Cristian
>
> ---
>
> (debian-arm64)root@debarm64:~# /root/iio_generic_buffer -a -c -1 -g -l 100 -N 0
> iio device number being used is 0
> trigger-less mode selected
> Enabling all channels
> Enabling: in_accel_x_en
> Enabling: in_accel_z_en
> Enabling: in_timestamp_en
> Enabling: in_accel_y_en
> -9465 -9457 -9449 6169807244683640832.000000
> -9464 -9456 -9448 6169807244683640832.000000
> -9463 -9455 -9447 6169807244683640832.000000
> -9462 -9454 -9446 6169807244683640832.000000
> -9461 -9453 -9445 6169807244683640832.000000
> -9460 -9452 -9444 6169807244683640832.000000
> -9459 -9451 -9443 7169807022831960064.000000
> -9458 -9450 -9442 7169807022831960064.000000
> -9457 -9449 -9441 7169807022831960064.000000
> -9456 -9448 -9440 7169807022831960064.000000
> -9455 -9447 -9439 7169807022831960064.000000
> -9454 -9446 -9438 7169807022831960064.000000
> -9453 -9445 -9437 7169807022831960064.000000
> -9452 -9444 -9436 7169807022831960064.000000
> -9451 -9443 -9435 7169807022831960064.000000
> -9450 -9442 -9434 7169807022831960064.000000
> -9449 -9441 -9433 8169806800980279296.000000
> -9448 -9440 -9432 8169806800980279296.000000
> -9447 -9439 -9431 8169806800980279296.000000
> -9446 -9438 -9430 8169806800980279296.000000
> -9445 -9437 -9429 8169806800980279296.000000
> -9444 -9436 -9428 8169806800980279296.000000
> -9443 -9435 -9427 8169806800980279296.000000
> -9442 -9434 -9426 8169806800980279296.000000
> -9441 -9433 -9425 8169806800980279296.000000
> -9440 -9432 -9424 8169806800980279296.000000
> -9439 -9431 -9423 9169807128884412416.000000
> -9438 -9430 -9422 9169807128884412416.000000
> -9437 -9429 -9421 9169807128884412416.000000
> -9436 -9428 -9420 9169807128884412416.000000
> -9435 -9427 -9419 9169807128884412416.000000
> ^CCaught signal 2
> Disabling: in_accel_x_en
> Disabling: in_accel_z_en
> Disabling: in_timestamp_en
> Disabling: in_accel_y_en
>
>
> On Sun, Mar 14, 2021 at 11:47:25AM -0700, Jyoti Bhayana wrote:
> > Hi Jonathan,
> >
> > No worries. Thanks for the update. It looks good now.
> >
> > Thanks,
> > Jyoti
> >
> > On Sun, Mar 14, 2021 at 8:40 AM Jonathan Cameron <jic23@kernel.org> wrote:
> > >
> > > On Sat, 13 Mar 2021 11:55:39 -0800
> > > Jyoti Bhayana <jbhayana@google.com> wrote:
> > >
> > > > Hi Jonathan,
> > > >
> > > > I still see the old version 6 in ib-iio-scmi-5.12-rc2-take2 as well.
> > >
> > > OK. I'm completely confused as to what is going with my local tree.
> > > I have the right patch in the history but it didn't end up in the final
> > > pushed out version.  Fat finger mess-up I guess and too many similarly named
> > > branches and the fact I didn't check the final result closely enough.
> > >
> > > There is now an ib-iio-scmi-5.12-rc2-take3 branch
> > >
> > > This time it definitely has your patch from the 9th of March with no
> > > instances of long long in it.
> > >
> > > Sorry I messed this one up (again!)
> > >
> > > Jonathan
> > >
> > > >
> > > > Thanks,
> > > > Jyoti
> > >
