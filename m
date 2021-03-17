Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFEBB33F651
	for <lists+linux-iio@lfdr.de>; Wed, 17 Mar 2021 18:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbhCQRMN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Mar 2021 13:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbhCQRLt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 17 Mar 2021 13:11:49 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE69C06174A
        for <linux-iio@vger.kernel.org>; Wed, 17 Mar 2021 10:11:49 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id f20so41714227ioo.10
        for <linux-iio@vger.kernel.org>; Wed, 17 Mar 2021 10:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8BJp3tVFFMs51r0HPV/ngIDmDtubwc+o473SaKsBo3E=;
        b=jkTzzB76kLOzmWmH6wXu/XbMdwsw3iAWozIcCUG1n11vv/pHqbn1zhw2Abcqm6bckO
         AhpM6MC/Rbdop48KSS0upyydwPxuuhUdy9u0auZGHHeSjHJJ/+D9ofjNRW3HPusy3jTj
         vuqIWjlnAeMq2qYT0I9FgSWnzeCsbR8I2/oss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8BJp3tVFFMs51r0HPV/ngIDmDtubwc+o473SaKsBo3E=;
        b=Iv1qjbHOf1THiYOrTFKj1qcMtYPDNSpxRejBb9hKL98G3J1DMtdtlQyArXRQE9fzsc
         Q/YwO1fbxfLZ6wOmTc1eg7cZlHFY7kpgyW8t3oxlAxyKIpUX5XP54J+9LfiIwen7+P5f
         wl1P9zBm6RKoxSZC1GqcT9XtZ2kjZs2wjVSmZxD9ssmZba92GYsBgdBB3tIHTe7XWq13
         zaALZZ6Fz8ArukUFvcbXfTZvCmHxXAKVxskT3UhsBu/6Kbizh+kAJ0qYQEws8ik0t4Mq
         RBA4P+8dwLITbFetwjXJ8+aXCQ7XvfaJf5Si7lweQA0jl7Yf+hXn7sPE1Vo2a25qMzMG
         9YQQ==
X-Gm-Message-State: AOAM533uVnKaA3TUoFmiWKlSuZ9qt2tKYCWJKFQFwxJymtr9AIKRnLyW
        dUD3/Rq8W/u5iSYr+ioCbX+ctiHqKS6FyhrZ13fuBA==
X-Google-Smtp-Source: ABdhPJwq5lQ3Sgxkpu5AqD80dHYDyNkabYlnmDtcz5LNSm5qnVP1EHhhdDCalqrzNspKTgTc1DkH+++1z2UKL+2sUtU=
X-Received: by 2002:a5e:8712:: with SMTP id y18mr7322567ioj.65.1616001108587;
 Wed, 17 Mar 2021 10:11:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210316202919.1886616-1-gwendal@chromium.org>
 <CAHp75VcV6xQQJuVeVL5TS0ott-cmR4YB-2P+Y3WBarpWSz676w@mail.gmail.com>
 <CA+U=DsrELGfk=8R3fD0OUjUOPD2-gy45oEC4azsfjvz4dcobxw@mail.gmail.com> <CAHp75VexBoAky-MF498VP5FTmew54wQNoptP-vKO3T+q3XMLXw@mail.gmail.com>
In-Reply-To: <CAHp75VexBoAky-MF498VP5FTmew54wQNoptP-vKO3T+q3XMLXw@mail.gmail.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Wed, 17 Mar 2021 10:11:37 -0700
Message-ID: <CAPUE2uu0ggY0p64-9NyZmbxfwkbY9zF6SjkgxG14Xvnox7WA=Q@mail.gmail.com>
Subject: Re: [PATCH v5] iio: cros: unify hw fifo attributes without API changes
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Mar 17, 2021 at 6:38 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Mar 17, 2021 at 3:21 PM Alexandru Ardelean
> <ardeleanalex@gmail.com> wrote:
> > On Wed, Mar 17, 2021 at 3:16 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > >
> > > On Tue, Mar 16, 2021 at 11:24 PM Gwendal Grignou <gwendal@chromium.org> wrote:
> > > >
> > > > fixes commit 2e2366c2d141 ("iio: cros_ec: unify hw fifo attributes into the core file")
> > > > fixes commit 165aea80e2e2 ("iio: cros_ec: use devm_iio_triggered_buffer_setup_ext()")
> > >
> > > Use the proper Fixes tag(s) in the tag block below.
> > >
> > > > 1. Instead of adding has_fw_fifo, deduct it from the configuration:
> > > > - EC must support FIFO (EC_FEATURE_MOTION_SENSE_FIFO) set.
> > > > - sensors send data a regular interval (accelerometer, gyro,
> > > >   magnetomer, barometer, light sensor).
> > > > - "Legacy accelerometer" is only present on EC without FIFO, so we don't
> > > > need to set buffer attributes.
> > > >
> > > > 2. devm_iio_triggered_buffer_setup_ext() does not need to be called when
> > > > EC does not support FIFO, as there is no FIFO to manage.
> > > >
> > > > 3. Use devm_iio_triggered_buffer_setup_ext() when EC has a FIFO to
> > > > specify the buffer extended attributes.
> > >
> > > Sounds like three patches in one. Please, split and add proper Fixes
> > > tag(s) to each of them.
> >
> > The code [at least] can be a single patch.
> > Albeit, it describes 3 different issues.
>
> I didn't get this. Is it one fix in one place which luckily fixes
> three issues (because the root cause of them is the same) or it's
> really three fixes in one patch because of some other reasons?
> In either case first what should be done is elaboration in the commit
> message(s). And if the latter is true, this needs to be split to patch
> per (logical) fix.

As it stands, we can not properly read sensor samples from the
chromebook embedded controller (EC).
The commits 2e2366c2d141 and 165aea80e2e2 should be reverted, but the
kernel would not compile as the IIO API has changed
(iio_buffer_set_attrs() has been removed in commit 21232b4456b ("iio:
buffer: remove iio_buffer_set_attrs() helper")). It would be a problem
when we do bisections.
This single commit removes the unnecessary code and set the buffer
|attr| field at the right place, reverting back to a working cros_ec
driver.
I thought about reverting commits 21232b4456b, 165aea80e2e2,
2e2366c2d141, adding a commit to call
devm_iio_triggered_buffer_setup_ext() instead of
iio_buffer_set_attrs(), and then reapplying 21232b4456b, but I believe
it is more confusing than a single commit.

Gwendal.



>
> --
> With Best Regards,
> Andy Shevchenko
