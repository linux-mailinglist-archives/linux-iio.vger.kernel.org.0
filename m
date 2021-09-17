Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70D9C40FD40
	for <lists+linux-iio@lfdr.de>; Fri, 17 Sep 2021 17:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237707AbhIQP4J (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Sep 2021 11:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235784AbhIQP4I (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Sep 2021 11:56:08 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E73AC061767
        for <linux-iio@vger.kernel.org>; Fri, 17 Sep 2021 08:54:46 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 17so10026170pgp.4
        for <linux-iio@vger.kernel.org>; Fri, 17 Sep 2021 08:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+QhNx1xL4TTv0Q4Zmru2yDL9Dg0TE9nnDuxrWUBBR84=;
        b=UzTRN8S+SFaS0NcA2X93VlLRRLwVuNfxQ7NfzwkE+I7/olmwRoLLJAmuJx30dIORIa
         d0hK4cEU//XVhpq8K6KGV69vJbwzGUnQQUnubK9I2xnkdVgTlCGAQ7msHG/9QTcv6Ycb
         ibLejp56H/G5YUjxLUEPMiLjsES/wNBmzTgyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+QhNx1xL4TTv0Q4Zmru2yDL9Dg0TE9nnDuxrWUBBR84=;
        b=NShdoWZRfnIT2gFF3bLyHtJHAg5jzxl5GMuyzHutJYSqXcAhfOKEcHXHQG16SXbzG6
         OW3HrVejqa7bm6zu4Cyi7ee3UYLDFr5yp1K1TH50CZ2Se9KBtFxguYm5x6XjJ2eVi7pM
         7wVoPeq+km950irECZi/mjBdm/gTBYWZMMnojL/afE7gJouuYdrCDdoq3TM4SNkDutfA
         nvJyvobL3QOIZZ6pxirGwn9MVDPTdvSPbti2JIVO2I5XNQGWYo85kBnN4Ps9UwR+Q3J7
         E2qF+WYLQzNu1x352tcz+IOHClQTjcsVQAeiP9uQUstnDw4tgo9PyyYBTZGJj2JXg1eR
         V7Ew==
X-Gm-Message-State: AOAM531wPnDkPQFVmCHvIXoJbxVsQ8+bCz6XPx8/xXKBRBo7KIwhNArx
        M3EM8ZOgSkYWSS1kuNs2wvJ0TQ==
X-Google-Smtp-Source: ABdhPJzpWIoc5zT5RwybN9lLYKDIkzgT1DK7K6W4lRjZBgZOR0pFTwHhbVoLjM1hQc9M9qiRyhom1w==
X-Received: by 2002:a62:6244:0:b0:43e:ee5:c7b5 with SMTP id w65-20020a626244000000b0043e0ee5c7b5mr11319098pfb.28.1631894085801;
        Fri, 17 Sep 2021 08:54:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m64sm7006875pga.55.2021.09.17.08.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 08:54:45 -0700 (PDT)
Date:   Fri, 17 Sep 2021 08:54:44 -0700
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
Subject: Re: [PATCH v1 2/6] iio/test-format: build kunit tests without
 structleak plugin
Message-ID: <202109170851.4485B94148@keescook>
References: <20210917061104.2680133-1-brendanhiggins@google.com>
 <20210917061104.2680133-3-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210917061104.2680133-3-brendanhiggins@google.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Sep 16, 2021 at 11:11:00PM -0700, Brendan Higgins wrote:
> The structleak plugin causes the stack frame size to grow immensely when
> used with KUnit:
> 
> ../drivers/iio/test/iio-test-format.c: In function ‘iio_test_iio_format_value_fixedpoint’:
> ../drivers/iio/test/iio-test-format.c:98:1: warning: the frame size of 2336 bytes is larger than 2048 bytes [-Wframe-larger-than=]
> 
> Turn it off in this file.

Given that these are all for KUnit tests, is it possible there are going
to be other CONFIGs that will interact poorly (e.g. KASAN)? Maybe there
needs to be a small level of indirection with something like:

DISABLE_UNDER_KUNIT := $(DISABLE_STRUCTLEAK_PLUGIN)
export DISABLE_UNDER_KUNIT

then all of these become:

+CFLAGS_iio-test-format.o += $(DISABLE_UNDER_KUNIT)

Either way, I think these are fine to add.

Reviewed-by: Kees Cook <keescook@chromium.org>


> 
> Co-developed-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>  drivers/iio/test/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/test/Makefile b/drivers/iio/test/Makefile
> index f1099b4953014..467519a2027e5 100644
> --- a/drivers/iio/test/Makefile
> +++ b/drivers/iio/test/Makefile
> @@ -5,3 +5,4 @@
>  
>  # Keep in alphabetical order
>  obj-$(CONFIG_IIO_TEST_FORMAT) += iio-test-format.o
> +CFLAGS_iio-test-format.o += $(DISABLE_STRUCTLEAK_PLUGIN)
> -- 
> 2.33.0.464.g1972c5931b-goog
> 

-- 
Kees Cook
