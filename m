Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5606540FD44
	for <lists+linux-iio@lfdr.de>; Fri, 17 Sep 2021 17:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241440AbhIQP4S (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Sep 2021 11:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239293AbhIQP4R (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Sep 2021 11:56:17 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CE3C061764
        for <linux-iio@vger.kernel.org>; Fri, 17 Sep 2021 08:54:52 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id p12-20020a17090adf8c00b0019c959bc795so2094132pjv.1
        for <linux-iio@vger.kernel.org>; Fri, 17 Sep 2021 08:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GW1WgRF6SuqTQcN6bjavSevOnivv0wMVUH9HZeNVmaQ=;
        b=kQRB0qqQHop4GG36R07plFb7axL/C9zQw2hxoXCMkt8M/uUXLv+Ms+Ynh0uOyRyA4u
         p8PmstiTAHiZPMYLXQiCx23gFCnU04gp4sxwJFSbm3CEqjrz02chT7gPpZN87AWer8aU
         Ro4752jjV1COVmPQUIiXt1EwH0X4Ijxltlyog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GW1WgRF6SuqTQcN6bjavSevOnivv0wMVUH9HZeNVmaQ=;
        b=BCK494LHa/7dl4CPG+/00uyi1HaKLyq29RpqXzPf8ytc8q1Vx92RXghK+SQ11bJoCB
         hXVUBQ17DYbUenWdnEKYEE3JoRzdsAy0G5nY7f/HmCLgmKuaS0nFcs3kquVblRvcNg9B
         0jvqna9wvOmY0aB1OTozlC3n70Iv+VBHhKuczSjHD6h9fSxT4gZSgA53/FtH2KbLyVEm
         ydihgQh36vHwaL/O27N0fzIZbqtFg95jg6sx/KEJz9xm4oftGPsCTj9IIluq+pxRT4RL
         rReuPPpP/PFTTABY6cTrK0SnZC0YCuyUf4Mb1lqw4pg2rt5yv6xsS3zAaj5ZS/M0yfZ8
         /52A==
X-Gm-Message-State: AOAM531YaNJD9YwxKZrLYTr1EuKa4XFqvMq6PzBEFxz+0JNT7sMW3W5S
        /S2J5O70i71yMtOdIUFObBgEoA==
X-Google-Smtp-Source: ABdhPJzFEnqJQEZhad7EFB5rcTtr5hs+gXwoICQuYe1e+Cip9gwcACVraZFrVhrtRAjqoF8WHL7mJg==
X-Received: by 2002:a17:903:246:b0:13a:22d1:88b with SMTP id j6-20020a170903024600b0013a22d1088bmr10319454plh.16.1631894092540;
        Fri, 17 Sep 2021 08:54:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k25sm6282982pfa.213.2021.09.17.08.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 08:54:51 -0700 (PDT)
Date:   Fri, 17 Sep 2021 08:54:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     shuah@kernel.org, davidgow@google.com, arnd@arndb.de,
        rafael@kernel.org, jic23@kernel.org, lars@metafoo.de,
        ulf.hansson@linaro.org, andreas.noever@gmail.com,
        michael.jamet@intel.com, mika.westerberg@linux.intel.com,
        YehezkelShB@gmail.com, masahiroy@kernel.org,
        michal.lkml@markovi.net, ndesaulniers@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH v1 3/6] device property: build kunit tests without
 structleak plugin
Message-ID: <202109170854.7ACE94F0@keescook>
References: <20210917061104.2680133-1-brendanhiggins@google.com>
 <20210917061104.2680133-4-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210917061104.2680133-4-brendanhiggins@google.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Sep 16, 2021 at 11:11:01PM -0700, Brendan Higgins wrote:
> The structleak plugin causes the stack frame size to grow immensely when
> used with KUnit:
> 
> ../drivers/base/test/property-entry-test.c:492:1: warning: the frame size of 2832 bytes is larger than 2048 bytes [-Wframe-larger-than=]
> ../drivers/base/test/property-entry-test.c:322:1: warning: the frame size of 2080 bytes is larger than 2048 bytes [-Wframe-larger-than=]
> ../drivers/base/test/property-entry-test.c:250:1: warning: the frame size of 4976 bytes is larger than 2048 bytes [-Wframe-larger-than=]
> ../drivers/base/test/property-entry-test.c:115:1: warning: the frame size of 3280 bytes is larger than 2048 bytes [-Wframe-larger-than=]
> 
> Turn it off in this file.
> 
> Co-developed-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
