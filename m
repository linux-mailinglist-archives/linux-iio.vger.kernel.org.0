Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A253C33F14F
	for <lists+linux-iio@lfdr.de>; Wed, 17 Mar 2021 14:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbhCQNjD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Mar 2021 09:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbhCQNix (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 17 Mar 2021 09:38:53 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CC3C06174A
        for <linux-iio@vger.kernel.org>; Wed, 17 Mar 2021 06:38:53 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id c204so1123986pfc.4
        for <linux-iio@vger.kernel.org>; Wed, 17 Mar 2021 06:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NDblxAdGHtHLoBPgSELX7K9LlkIuz32xfXPg1bTQFOo=;
        b=oKdX8PE9/NOIrH2Bs9sYpuXU2oxJJtroCTr5xpPPNM7N115duTKgwLRefhIY3AvaNz
         MZhcGLaioVUQlzUMoh3xtbtTCywDkmOwXENEPMFKiG+pDR7tCQBCyRcNdMGyt8sZia2h
         +xQhsh5jR5ZrwUJ285waSsARfuJmct1bcp536EC+L5onFl3psFwnNrdUukclWS4bNrqn
         2pdiXAku9Wc9wkCdKXBPUa5nDatL/o5o9DS3jjL4/ivz+yUKdWuMnJ6UQNZNPKWMH5Ou
         LnkTHXBAqpzSEgevci/VIwyypVHp2jKZoa7XXnKUuQeiwlaMh0g0y2cuDXqWNE26vFwZ
         jycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NDblxAdGHtHLoBPgSELX7K9LlkIuz32xfXPg1bTQFOo=;
        b=PTkuqVgs6KVgYdPjZBSLY9zVHF4M1+GETgzEy18+a2pVctnS2pRd0UFBfZJ+yRrswJ
         ne8bLA8hAYwgFoXV0QCfe6zgG/tY5QjESIgsgMDJsLG7NIW+JNLUaukOavoSEfItz2L+
         K/b5jR7YXlv2usp1eTwxtO5/78ez0Oo3dZcFU8zv5ZjAzHALIbkaayzZECuv/FvF33MZ
         KTYIHRANTOKgLWGFw90MpkncgQFVZS3GdvSLhsPqroMmP2ql95wAlhG+sy0tk4c3ZEan
         iJkmlX+3a6kJeMp9RvjJYMvwLY9KehD7jT0FDrPV61TBb7fgR357ZAb4PomunEeew5zv
         1l7w==
X-Gm-Message-State: AOAM532bNFe6C/GmL3aMv/ZCuVo2Ifb2WJ/27OarhlGPlIPpwWINkbgH
        UBTfektc7Q7acOo5S7D5oFrVjYEpGgn1qCbn0co=
X-Google-Smtp-Source: ABdhPJxG52Cf4EZCJHF5OSVg/3p4XtFGcqfVsoIDYuMntDfpLjTtUhfC3wRlP9P6/2YlmxAF9RuR2tgMrMnw5IVrk9s=
X-Received: by 2002:a65:4bc5:: with SMTP id p5mr2678494pgr.74.1615988331603;
 Wed, 17 Mar 2021 06:38:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210316202919.1886616-1-gwendal@chromium.org>
 <CAHp75VcV6xQQJuVeVL5TS0ott-cmR4YB-2P+Y3WBarpWSz676w@mail.gmail.com> <CA+U=DsrELGfk=8R3fD0OUjUOPD2-gy45oEC4azsfjvz4dcobxw@mail.gmail.com>
In-Reply-To: <CA+U=DsrELGfk=8R3fD0OUjUOPD2-gy45oEC4azsfjvz4dcobxw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 17 Mar 2021 15:38:35 +0200
Message-ID: <CAHp75VexBoAky-MF498VP5FTmew54wQNoptP-vKO3T+q3XMLXw@mail.gmail.com>
Subject: Re: [PATCH v5] iio: cros: unify hw fifo attributes without API changes
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Mar 17, 2021 at 3:21 PM Alexandru Ardelean
<ardeleanalex@gmail.com> wrote:
> On Wed, Mar 17, 2021 at 3:16 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Tue, Mar 16, 2021 at 11:24 PM Gwendal Grignou <gwendal@chromium.org> wrote:
> > >
> > > fixes commit 2e2366c2d141 ("iio: cros_ec: unify hw fifo attributes into the core file")
> > > fixes commit 165aea80e2e2 ("iio: cros_ec: use devm_iio_triggered_buffer_setup_ext()")
> >
> > Use the proper Fixes tag(s) in the tag block below.
> >
> > > 1. Instead of adding has_fw_fifo, deduct it from the configuration:
> > > - EC must support FIFO (EC_FEATURE_MOTION_SENSE_FIFO) set.
> > > - sensors send data a regular interval (accelerometer, gyro,
> > >   magnetomer, barometer, light sensor).
> > > - "Legacy accelerometer" is only present on EC without FIFO, so we don't
> > > need to set buffer attributes.
> > >
> > > 2. devm_iio_triggered_buffer_setup_ext() does not need to be called when
> > > EC does not support FIFO, as there is no FIFO to manage.
> > >
> > > 3. Use devm_iio_triggered_buffer_setup_ext() when EC has a FIFO to
> > > specify the buffer extended attributes.
> >
> > Sounds like three patches in one. Please, split and add proper Fixes
> > tag(s) to each of them.
>
> The code [at least] can be a single patch.
> Albeit, it describes 3 different issues.

I didn't get this. Is it one fix in one place which luckily fixes
three issues (because the root cause of them is the same) or it's
really three fixes in one patch because of some other reasons?
In either case first what should be done is elaboration in the commit
message(s). And if the latter is true, this needs to be split to patch
per (logical) fix.

-- 
With Best Regards,
Andy Shevchenko
