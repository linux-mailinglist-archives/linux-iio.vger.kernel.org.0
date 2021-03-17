Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3434333F65B
	for <lists+linux-iio@lfdr.de>; Wed, 17 Mar 2021 18:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbhCQRNt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Mar 2021 13:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbhCQRNn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 17 Mar 2021 13:13:43 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A05C06174A
        for <linux-iio@vger.kernel.org>; Wed, 17 Mar 2021 10:13:43 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id g4so10447pgj.0
        for <linux-iio@vger.kernel.org>; Wed, 17 Mar 2021 10:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FFBUbyWK1zdWa825xbTlbqPxexr9SySJmaNq+f3ib8s=;
        b=pde87lwA6O4xhkOC4yF0Wj3idSVKiVPsEjna8HMAQHujkJ1SxNy/tlqOoKPbbHj/fu
         Mpn9uzEOpbh7G70RqFJwVEJ4bdJMYwVYUsWolenjKSTSP/66OCdpKE2UbqFbHjZS6XgH
         2dM1oDYO0a220D3bRaXFP5miGxJpdThqEOOD0aoJCINqpYgj0MeAJvhdNd/yuCArYeaD
         PY+BPuF3eiY3OiuFtwbYFqgpeYhTFaO0E25uweDrHnDkG6jMoEAiTfGrPjqXM+zA4xeD
         PxZeitKBzVHO2LiGeUY01SCSj5CYv+Km6wT53U9nbufkugVhrU/O1ig/V/EeJ/A1DUa4
         avAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FFBUbyWK1zdWa825xbTlbqPxexr9SySJmaNq+f3ib8s=;
        b=nEebz3QyjE/BQ1sqPWMplM/ZOW2TXZpkF8gadonhB/pylxlevfSUh7I5mJy47tpUa8
         hiKliSyTDV5U2vlEYHgjZxpNXXwed6DxqVadtnTOFz2EhnVkrYvuO0+iVhjn5OpNqJQt
         8qDErlFaKiKO4WnU1ELtYwGkGWrIf4Lu5CEyAHc8AFeGOG64FqM5/uO5mtdvUcxz6Cnw
         +c3qdkAIl3WJGCGSVaCo6UNAJMUT8BfLjR3EqDTFl3BYzr2nMDiGRaxrj0vmhWF7D7F9
         64WwTBJpAnaBtT01VG/+iSX2pCoN77ojo3d4z/tMKYSV8NKPlOBOnFoXI6XrXzvY9t3k
         PJ6g==
X-Gm-Message-State: AOAM5304UZQci0FOZ1CZO5gzAKk8HkoDMCdGVM5fMD0DrU8Ewsi0r4eQ
        XKqPvphW4EIEt/1coe/4bnjyKMyLB+G4+a4KE0k=
X-Google-Smtp-Source: ABdhPJx5tdplggqzc6g2fcEX04Tbygn+VA9FV6Jilpxtw3jAdIDHiI9Yg0CQqxzWtSjTIh74GNRRrGDf4UmclWkF3n4=
X-Received: by 2002:a63:ce15:: with SMTP id y21mr3485129pgf.4.1616001222709;
 Wed, 17 Mar 2021 10:13:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210316202919.1886616-1-gwendal@chromium.org>
 <CAHp75VcV6xQQJuVeVL5TS0ott-cmR4YB-2P+Y3WBarpWSz676w@mail.gmail.com>
 <CA+U=DsrELGfk=8R3fD0OUjUOPD2-gy45oEC4azsfjvz4dcobxw@mail.gmail.com>
 <CAHp75VexBoAky-MF498VP5FTmew54wQNoptP-vKO3T+q3XMLXw@mail.gmail.com> <CAPUE2uu0ggY0p64-9NyZmbxfwkbY9zF6SjkgxG14Xvnox7WA=Q@mail.gmail.com>
In-Reply-To: <CAPUE2uu0ggY0p64-9NyZmbxfwkbY9zF6SjkgxG14Xvnox7WA=Q@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 17 Mar 2021 19:13:26 +0200
Message-ID: <CAHp75VcMOaWQUdA8X1kXE1FT36o=t9hVKo8gR6DjpoT6KMKpOg@mail.gmail.com>
Subject: Re: [PATCH v5] iio: cros: unify hw fifo attributes without API changes
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Mar 17, 2021 at 7:11 PM Gwendal Grignou <gwendal@chromium.org> wrote:
>
> On Wed, Mar 17, 2021 at 6:38 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Wed, Mar 17, 2021 at 3:21 PM Alexandru Ardelean
> > <ardeleanalex@gmail.com> wrote:
> > > On Wed, Mar 17, 2021 at 3:16 PM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> > > >
> > > > On Tue, Mar 16, 2021 at 11:24 PM Gwendal Grignou <gwendal@chromium.org> wrote:
> > > > >
> > > > > fixes commit 2e2366c2d141 ("iio: cros_ec: unify hw fifo attributes into the core file")
> > > > > fixes commit 165aea80e2e2 ("iio: cros_ec: use devm_iio_triggered_buffer_setup_ext()")
> > > >
> > > > Use the proper Fixes tag(s) in the tag block below.
> > > >
> > > > > 1. Instead of adding has_fw_fifo, deduct it from the configuration:
> > > > > - EC must support FIFO (EC_FEATURE_MOTION_SENSE_FIFO) set.
> > > > > - sensors send data a regular interval (accelerometer, gyro,
> > > > >   magnetomer, barometer, light sensor).
> > > > > - "Legacy accelerometer" is only present on EC without FIFO, so we don't
> > > > > need to set buffer attributes.
> > > > >
> > > > > 2. devm_iio_triggered_buffer_setup_ext() does not need to be called when
> > > > > EC does not support FIFO, as there is no FIFO to manage.
> > > > >
> > > > > 3. Use devm_iio_triggered_buffer_setup_ext() when EC has a FIFO to
> > > > > specify the buffer extended attributes.
> > > >
> > > > Sounds like three patches in one. Please, split and add proper Fixes
> > > > tag(s) to each of them.
> > >
> > > The code [at least] can be a single patch.
> > > Albeit, it describes 3 different issues.
> >
> > I didn't get this. Is it one fix in one place which luckily fixes
> > three issues (because the root cause of them is the same) or it's
> > really three fixes in one patch because of some other reasons?
> > In either case first what should be done is elaboration in the commit
> > message(s). And if the latter is true, this needs to be split to patch
> > per (logical) fix.
>
> As it stands, we can not properly read sensor samples from the
> chromebook embedded controller (EC).
> The commits 2e2366c2d141 and 165aea80e2e2 should be reverted, but the
> kernel would not compile as the IIO API has changed
> (iio_buffer_set_attrs() has been removed in commit 21232b4456b ("iio:
> buffer: remove iio_buffer_set_attrs() helper")). It would be a problem
> when we do bisections.
> This single commit removes the unnecessary code and set the buffer
> |attr| field at the right place, reverting back to a working cros_ec
> driver.
> I thought about reverting commits 21232b4456b, 165aea80e2e2,
> 2e2366c2d141, adding a commit to call
> devm_iio_triggered_buffer_setup_ext() instead of
> iio_buffer_set_attrs(), and then reapplying 21232b4456b, but I believe
> it is more confusing than a single commit.

Please, elaborate this in the commit message and use proper Fixes tags.

-- 
With Best Regards,
Andy Shevchenko
