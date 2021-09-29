Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1A4D41CD8F
	for <lists+linux-iio@lfdr.de>; Wed, 29 Sep 2021 22:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346784AbhI2Usn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Sep 2021 16:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346778AbhI2Usm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Sep 2021 16:48:42 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DAFC061766
        for <linux-iio@vger.kernel.org>; Wed, 29 Sep 2021 13:47:01 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id m26so3010999pff.3
        for <linux-iio@vger.kernel.org>; Wed, 29 Sep 2021 13:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=587WM24LTOmLGqLOhSHilj8JkGrTc17zUl7eEsqwOCI=;
        b=c+7CmGlmZFVazVVzOVi/HDc12ybbvnkB6VxnplO+pusVVqCex/prCcPVtqW5ExnqvT
         JG/m6qW6Zsc0Xo7sqqjMQ1JNGGB2W2Xj4i3AsS+/B+ZqoPo+/w2m2sH1i+ADQTd05qV+
         Vi+WLbXl1cStVGz0g6iPLYrGl5ropADB2EP4dtYEaclwMc0RqD62/oX3ycIS3xWTeedP
         P5Q12MPwqa+ud/hWmsg7SeuWHUQ82z1rzhrObCVs58IueuWTf2nGF36vjFf/mAXe7h4A
         DIafjY2YYGoCoPuge5rJqFirrqdjXK5KN0PnJPzRQcmc//3+rtt7xV3smJPMBu85QekS
         or2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=587WM24LTOmLGqLOhSHilj8JkGrTc17zUl7eEsqwOCI=;
        b=mPGn/Lo6GcWM5fS1o8glQtSdJpeyj1sWalzAMWGrS43Efv03KAL7NPB8xRYRIEcmCB
         kRbPenelXnlx2vh+bQmcXTRApYhx4GksGId/BMV3KGXhQqDZQcFYUh4YhcdeuJBJKHC3
         oUYR5viZPVAsfKXis3Wq93UjI3pKTmwT1u+3O/zbApxcMBB21fY3wxSenABWtGC5u+b2
         u8CmNmlqBi7bjzXS2kmEC3fCbZq7+KVgaKR+KiwiMKqmhWihMfHRFr8XmtwcmaGPyT8K
         sKIx5NomQMEZo4lI/delsw3PUynru5J5jVYGhMQM1/hyL1JmVFLzICG/ebUonGIybRfk
         N21Q==
X-Gm-Message-State: AOAM530F1LURmgQ8uELSWZDeUkFz6HCoOiNmXtmt0Tr/yv9rOzT52Pqv
        NAdAaXaPTduwraHfhrheKQShj44hI54v2TPKKdfU0Q==
X-Google-Smtp-Source: ABdhPJyPmBrXk1Wqva0lUIU6lo/HV/Ft5MQ3a+ZXlJHaApR1C4TsCjvKsuFtoHOYYtnX5OpCN1xqViiceZItBbpeJ1I=
X-Received: by 2002:a63:1550:: with SMTP id 16mr1650910pgv.442.1632948420649;
 Wed, 29 Sep 2021 13:47:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210917061104.2680133-1-brendanhiggins@google.com> <CAK8P3a257cAgtPhT1Li2GnZ-UZW3LVZa3fWX1YUnWGEENvpqJA@mail.gmail.com>
In-Reply-To: <CAK8P3a257cAgtPhT1Li2GnZ-UZW3LVZa3fWX1YUnWGEENvpqJA@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 29 Sep 2021 13:46:49 -0700
Message-ID: <CAFd5g44_4+WJrjzSZfQmk+T1Sm-E7ARdWxNzsc+Upku_A-gLqA@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] kunit: build kunit tests without structleak plugin
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Shuah Khan <shuah@kernel.org>, David Gow <davidgow@google.com>,
        Kees Cook <keescook@chromium.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ulf Hansson <ulf.hansson@linaro.org>, andreas.noever@gmail.com,
        michael.jamet@intel.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        yehezkelshb@gmail.com, Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        gregkh <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org,
        linux-mmc <linux-mmc@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Sep 17, 2021 at 12:38 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Sep 17, 2021 at 8:10 AM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> >
> > The structleak plugin causes the stack frame size to grow immensely when
> > used with KUnit; this is caused because KUnit allocates lots of
> > moderately sized structs on the stack as part of its assertion macro
> > implementation. For most tests with small to moderately sized tests
> > cases there are never enough KUnit assertions to be an issue at all;
> > even when a single test cases has many KUnit assertions, the compiler
> > should never put all these struct allocations on the stack at the same
> > time since the scope of the structs is so limited; however, the
> > structleak plugin does not seem to respect the compiler doing the right
> > thing and will still warn of excessive stack size in some cases.
> >
> > These patches are not a permanent solution since new tests can be added
> > with huge test cases, but this serves as a stop gap to stop structleak
> > from being used on KUnit tests which will currently result in excessive
> > stack size.
> >
> > Of the following patches, I think the thunderbolt patch may be
> > unnecessary since Linus already fixed that test. Additionally, I was not
> > able to reproduce the error on the sdhci-of-aspeed test. Nevertheless, I
> > included these tests cases for completeness. Please see my discussion
> > with Arnd for more context[1].
> >
> > NOTE: Arnd did the legwork for most of these patches, but did not
> > actually share code for some of them, so I left his Signed-off-by off of
> > those patches as I don't want to misrepresent him. Arnd, please sign off
> > on those patches at your soonest convenience.
>
> Thanks a lot for picking up this work where I dropped the ball.
>
> Patches 1-5 look good to me, and I replied on one remaining issue I see
> with patch 6. I think you did more work on these that I did, by doing
> a nice write-up and splitting them into separate patches with useful
> changelogs, you should keep authorship, and just change my
> S-o-b to Suggested-by.
>
> If you prefer to keep me as the author, then the correct way would
> be to commit them with --author= to ensure that the author and
> first s-o-b match.

Sounds good. I will keep the one that has you as the author since I
just rebased it, but I will move you to Suggested-by on the others.

Thanks!
