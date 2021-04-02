Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB3D352485
	for <lists+linux-iio@lfdr.de>; Fri,  2 Apr 2021 02:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbhDBAjI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Apr 2021 20:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbhDBAjH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Apr 2021 20:39:07 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B68C0613E6
        for <linux-iio@vger.kernel.org>; Thu,  1 Apr 2021 17:39:07 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id h20so1820428plr.4
        for <linux-iio@vger.kernel.org>; Thu, 01 Apr 2021 17:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=C5nDZ2Lf/vMBfXoBtSWjP1kUmR4Tb4xAiaE8aD5EI4M=;
        b=gwSU4xMAvwRs7LySnRHQ7ZK/t4tUdSrA1QBTekRzaEXCBtH9mS0zoeqG9MgZ2eUnfF
         2AT0InyqZ3r345wfAJFaRIOVF/kjF0eAGERJ4cbePRmZVqTuWukQq7zz/ENdrlIMFRQv
         9/z227zDpda/rsQk32GZ2LRiXjXZw8RN3cl2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=C5nDZ2Lf/vMBfXoBtSWjP1kUmR4Tb4xAiaE8aD5EI4M=;
        b=mS2/0yYBOGV2Ke9sLGntiMkreVTrELzU2RRY0Lariygk8NC/uQ6LeuWntqscDjo1yW
         bda97k3Yt9UfV0FP9pZ2o8SEACQyWmio2oQEBaewTxIg6Lr6VVN+elOdnJFKtrcfWlcW
         x8z74B+q8ht1yLm4+SnrTE6/hj7FYHcajjWFmMoBURYakmVwgOuN652832jXwgC4lFdD
         fPwO/XbBR9uAI8ozCpabK/MmNIGBzlgrz/7zpbqmiJzVfHPsUaqUmyf8JAz26yTgsy/V
         hsxjoeyw5cKyesZXUW1kkQFyiDUdaCUNVGT1AaouV749UOVSA+2qh+zA/d3gz81gx8vd
         o/QA==
X-Gm-Message-State: AOAM533rlMKF1wA/zyr/THSJ+QZaoq5u0jwNN+tgy/5QgjLBGQUP6Obi
        9DDhV+d5PXmq6VqVSu/kYg7FOg==
X-Google-Smtp-Source: ABdhPJxwnsMgU3W+NQYajY8Tz2NMW08vZpOG174uPq/qM2OMGNob2WKjT1p9zaB1pnECIhmQiBK+XA==
X-Received: by 2002:a17:90a:f298:: with SMTP id fs24mr11529362pjb.57.1617323947036;
        Thu, 01 Apr 2021 17:39:07 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:201:450:f2a9:b3ca:879f])
        by smtp.gmail.com with ESMTPSA id g3sm6158983pfk.186.2021.04.01.17.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 17:39:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210401141935.1fd2e15d@jic23-huawei>
References: <20210328033639.1021599-1-gwendal@chromium.org> <161698755179.3012082.10332557476670862687@swboyd.mtv.corp.google.com> <CAPUE2usX-Tq2wyO4ekkAUaR6rRfJ3mZG3SQMqJbpzzUTMwd-0A@mail.gmail.com> <20210401141935.1fd2e15d@jic23-huawei>
Subject: Re: [PATCH 0/2] iio: sx9310: Add debouncer-depth parameters
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Daniel Campello <campello@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>
Date:   Thu, 01 Apr 2021 17:39:05 -0700
Message-ID: <161732394517.2260335.9268876008128877361@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Jonathan Cameron (2021-04-01 06:19:35)
> On Tue, 30 Mar 2021 17:38:03 -0700
> Gwendal Grignou <gwendal@chromium.org> wrote:
>=20
> > On Sun, Mar 28, 2021 at 8:12 PM Stephen Boyd <swboyd@chromium.org> wrot=
e:
> > >
> > > Quoting Gwendal Grignou (2021-03-27 20:36:37) =20
> > > > Semtech SX9310 SAR sensor has a debouncer filter: only when N
> > > > measurements are above/below the far/close threshold an event is
> > > > sent to the host.
> > > > By default the debouncer is set to 2 events for the close to far
> > > > transition and 1 event (no debounce) for far to close.
> > > > It is a balance speed of detection and false positive avoidance.
> > > >
> > > > On some chromebooks, the debouncer is set to a larger number.
> > > >
> > > > This patch applies on top of commit 103d6ec82676 ("iio: sx9310: Sup=
port ACPI properties") =20
> > >
> > > The near/far debounce settings are already supported via sysfs. Can y=
ou
> > > use those instead of putting this into DT/ACPI? See
> > > sx9310_read_far_debounce() and associated code. =20
> > Stephen, I missed you already proposed these bindings earlier
> > [https://lore.kernel.org/linux-devicetree/20200906150247.3aaef3a3@archl=
inux/].
> > After Jonathan inputs, it is done via sysfs interface
> > [events/thresh_{falling|rising}_period].
> >=20
> > The debounce parameters are in the same class as the other parameters
> > already present in the DT. They are calculated during tests to meet
> > FCC requirements, in particular the time it takes to detect a human
> > body near the antennas.

The same could be said for the threshold values but those are in sysfs.

> > Depending on the SAR antenna design, it is a balance between lowering
> > the debouncer "period" to raise an event as soon as possible, and
> > increasing it to prevent false posible.
> >=20
> > In addition to controlling it from sysfs, could it be acceptable to
> > have it in DT/ACPI as well?
> > In the meantime, I will make sure semtech,sx9310.yaml matches
> > in_proximityX_hardwaregain_available and connect to that attribute.
> >=20

My understanding from the previous discussions with Jonathan was that
anything that could be delayed until later should be done through sysfs.
That's why only some properties are in DT, because they were used during
initial compensation of the device that happens when the device driver
probes. These other values like thresholds and debounce weren't required
for that so I put them into sysfs.

>=20
>=20
> Ok, add something to make it clear that these effectively tied to the boa=
rd
> hardware because of this FCC requirement.
>=20
> As long as that's clear the Rob is fine with the DT binding I don't mind.
>=20
> Is there a requirement as a result of this FCC stuff that we should not
> expose them to userspace control if they are provided in DT?
>=20
> If so we should figure out a sensible way of doing that without breaking
> the existing ABI.
>
