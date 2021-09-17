Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24C4B40FD6B
	for <lists+linux-iio@lfdr.de>; Fri, 17 Sep 2021 17:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243172AbhIQP7O (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Sep 2021 11:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243113AbhIQP7N (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Sep 2021 11:59:13 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D0DC061574
        for <linux-iio@vger.kernel.org>; Fri, 17 Sep 2021 08:57:51 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id j1so7244585pjv.3
        for <linux-iio@vger.kernel.org>; Fri, 17 Sep 2021 08:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=r6MdFPfPUAZH3+HZlPktkkcgyhh/J6s1d9EKnLc8sLI=;
        b=cVRmNTsiGusduzzBZ0I0VDwRsgxPiX0DIHlnWw6Se7sfNbDpGRiSTLvTlZtIThSTQO
         8Iq2NwZoaHIDpechq2RhvvyJvdrbKPHw1+n+7wPIlBMrVoDW3PXN++ki6UAMxgRCzQMe
         1l//5Z7Px9GtWSlr/+iGzFDVVYKKNPnCzniEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r6MdFPfPUAZH3+HZlPktkkcgyhh/J6s1d9EKnLc8sLI=;
        b=KHu+Ecb+xsxQyCF4ZwUNWBp2UKlFLPCekDegdsQcxTUwPaY5MdP4l/E8WTK0tr/K1y
         c+dW66efp3G7OqA+GH3vKLs4Hcv1xxH9D46s7TyupAWQTnbkrt71YGLC8Dv51XuIFHRo
         8w7UY6+wCJ1I9BqLoE8cY0VbZPxLtCe1bAXodGRst4P1XxPC5t3ijL+dWXlw4naS8zBV
         PwE9d5pnXCYJb5MaWCBn/mRxDGtH+606djWrA3606yzVAJF07nBxKznawVyMZZDLG6l+
         g9pDb2crbQ/+7PVff1HgJkYfAAwh20BRClhlrDoX5g9/F4hRbzmY3wYPW/MB6G3oOdX2
         /KXg==
X-Gm-Message-State: AOAM531pgo7FloCxzO+VWwhzgn2vtAcLO9Gzr7IupqVAAd0Foku37i72
        Kl+cWlAw0vwpwK83lWa6e+SGPg==
X-Google-Smtp-Source: ABdhPJz9vij1VDEQP6wMABN1KinAsDThb7qqcjn08XngLn0itqVa2eHpdQK0v808VVyWyogNtOKZyw==
X-Received: by 2002:a17:902:c411:b0:13c:9748:badf with SMTP id k17-20020a170902c41100b0013c9748badfmr10322686plk.18.1631894271017;
        Fri, 17 Sep 2021 08:57:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k3sm10981540pjg.43.2021.09.17.08.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 08:57:50 -0700 (PDT)
Date:   Fri, 17 Sep 2021 08:57:49 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <shuah@kernel.org>, David Gow <davidgow@google.com>,
        Rafael Wysocki <rafael@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ulf Hansson <ulf.hansson@linaro.org>, andreas.noever@gmail.com,
        michael.jamet@intel.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        YehezkelShB@gmail.com, Masahiro Yamada <masahiroy@kernel.org>,
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
Subject: Re: [PATCH v1 6/6] bitfield: build kunit tests without structleak
 plugin
Message-ID: <202109170857.80F9B319@keescook>
References: <20210917061104.2680133-1-brendanhiggins@google.com>
 <20210917061104.2680133-7-brendanhiggins@google.com>
 <CAK8P3a21j9yJe_X=kU6v2YgOnrhunRbPv+O6STSH71qTb7xnfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a21j9yJe_X=kU6v2YgOnrhunRbPv+O6STSH71qTb7xnfg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Sep 17, 2021 at 09:22:08AM +0200, Arnd Bergmann wrote:
> On Fri, Sep 17, 2021 at 8:11 AM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> >
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > The structleak plugin causes the stack frame size to grow immensely:
> >
> > lib/bitfield_kunit.c: In function 'test_bitfields_constants':
> > lib/bitfield_kunit.c:93:1: error: the frame size of 7440 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
> >
> > Turn it off in this file.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > ---
> >  lib/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/lib/Makefile b/lib/Makefile
> > index 5efd1b435a37c..c93c4b59af969 100644
> > --- a/lib/Makefile
> > +++ b/lib/Makefile
> > @@ -351,7 +351,7 @@ obj-$(CONFIG_OBJAGG) += objagg.o
> >  obj-$(CONFIG_PLDMFW) += pldmfw/
> >
> >  # KUnit tests
> > -CFLAGS_bitfield_kunit.o := $(call cc-option,-Wframe-larger-than=10240)
> > +CFLAGS_bitfield_kunit.o := $(call cc-option,-Wframe-larger-than=10240) $(DISABLE_STRUCTLEAK_PLUGIN)
> 
> I think the  $(call cc-option,-Wframe-larger-than=10240) needs to be dropped
> here. This was not in my original patch and it is definitely broken on
> all architectures
> with 8KB stack size or less if the function needs that much. What is the amount
> of actual stack usage you observe without this? If we still get a warning, then
> I think this needs to be fixed in the code.

With the frame-larger-than dropped:

Reviewed-by: Kees Cook <keescook@chromium.org>


-- 
Kees Cook
