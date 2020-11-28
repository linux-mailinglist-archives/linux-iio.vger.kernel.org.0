Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9802C749A
	for <lists+linux-iio@lfdr.de>; Sat, 28 Nov 2020 23:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388237AbgK1Vtc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Nov 2020 16:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387504AbgK1TVR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 Nov 2020 14:21:17 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B27C0613D1
        for <linux-iio@vger.kernel.org>; Sat, 28 Nov 2020 11:20:37 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id i17so10116912ljd.3
        for <linux-iio@vger.kernel.org>; Sat, 28 Nov 2020 11:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=43RmXr+oUICRvqUaqiDOvs8i6VIL5ddg6rQZbxT/oko=;
        b=cqFpk+T5R9rpm2aep4qzgZty6lmPpCouWcyp00uctKTtY5djLCGqGw/NZbegylgV4u
         0KzKPQIqDnL5HsJAQWdrwk05D51H7uVZgjyi6lOAUinfLaPexqdO1luibzK17z57wCmN
         J5raDzd1Zglysu7hTrJnoBQt4HFUxkoTVfLeWwLVv4MnuBnt8UUwMCNl1hxuqqcwFMux
         vS3APzJWfqVHTvi/MnF4C1soayhk5G2lnfvFgU73rxNQKs2sXOX2QJEFl0ET3Idzyyp/
         eQh3ExmVc0SCPQKa4sHWPfMfdqKH1ZRsNueU5Pt1y8z8Sk1rzCJIigFujcK7T5rMsxC9
         l7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=43RmXr+oUICRvqUaqiDOvs8i6VIL5ddg6rQZbxT/oko=;
        b=SSTeUK+RamztX0myKjZBXuOfBrn/ledZWmqNHha6iXiDQ8UtxbvtTJHUELZYGN03gi
         jf7s2hOxwYYz2Llmciu57tjDd/D+tRaZQG4+41vqHz+31Rmz9Gj1DIy/JXgUDyIb94Vc
         XpbrbJmMNJ6HR43UvY04RNxCt5qE7EbqUXHkBqiC+ff+nkVHMbY04db7ztvkjV6l8Sm5
         SyyNN8yzjIjF0wUnAuER4LkVWMc4RbqGNkmo8e2f36+XZy4aAgg+fU6yQAzrp9ZFSJK6
         QmTDGiaMi4sDimD/eTE/h9nhbhSTr1mJTlwRJqy4G5NvhEpdt80z36a3m+RSvwvwmLYI
         CtOQ==
X-Gm-Message-State: AOAM533hxr1j+/z4KH4ix6tL15DZoFANKJXF0VYhNdn2Ch1E82cGpcot
        umFHR5Vyc46U9x3sjLJ3s/rSQ49yk9FjMiLjUUS6uQ==
X-Google-Smtp-Source: ABdhPJxiYJECrJ08DTMCUTtSfiM6wuKdTxPcEgXlDJPI7YnjClBbyHvObjtq5y2maW5olApd62qPQAj/XpFMrIdlmeo=
X-Received: by 2002:a2e:97c8:: with SMTP id m8mr5649041ljj.338.1606591235814;
 Sat, 28 Nov 2020 11:20:35 -0800 (PST)
MIME-Version: 1.0
References: <20201128185156.428327-1-jic23@kernel.org>
In-Reply-To: <20201128185156.428327-1-jic23@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 28 Nov 2020 20:20:24 +0100
Message-ID: <CACRpkdaA5yhgd4+BgFN6WeC7pmoKPj8kYabD7TtFyEieiNVZfw@mail.gmail.com>
Subject: Re: [PATCH] iio:gyro:mpu3050 Treat otp value as a __le64 and use
 FIELD_GET() to break up
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Nov 28, 2020 at 7:54 PM Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Inspired by Andy Shevchenko's proposal to use get_unaligned_leXX().
>
> The whole one time programable memory is treated as a single 64bit
> little endian value.  Thus we can avoid a lot of messy handling
> of fields overlapping byte boundaries by just loading and manipulating
> it as an __le64 converted to a u64.  That lets us just use FIELD_GET()
> and GENMASK() to extract the values desired.
>
> Note only build tested.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>

Are there any specific prerequisites? linux-next?

When I apply this and try to compile for an ARMv7 target I get
a lot of noise and an error:

In file included from <command-line>:0:0:
../drivers/iio/gyro/mpu3050-core.c: In function =E2=80=98mpu3050_hw_init=E2=
=80=99:
../include/linux/bits.h:36:11: warning: right shift count is negative
[-Wshift-count-negative]
   (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
           ^
./../include/linux/compiler_types.h:299:9: note: in definition of
macro =E2=80=98__compiletime_assert=E2=80=99
   if (!(condition))     \
         ^~~~~~~~~
./../include/linux/compiler_types.h:319:2: note: in expansion of macro
=E2=80=98_compiletime_assert=E2=80=99
  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
  ^~~~~~~~~~~~~~~~~~~
../include/linux/build_bug.h:39:37: note: in expansion of macro
=E2=80=98compiletime_assert=E2=80=99
 #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                     ^~~~~~~~~~~~~~~~~~
../include/linux/bitfield.h:46:3: note: in expansion of macro =E2=80=98BUIL=
D_BUG_ON_MSG=E2=80=99
   BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),  \
   ^~~~~~~~~~~~~~~~
../include/linux/bitfield.h:108:3: note: in expansion of macro
=E2=80=98__BF_FIELD_CHECK=E2=80=99
   __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: "); \
   ^~~~~~~~~~~~~~~~
../include/linux/dev_printk.h:118:33: note: in expansion of macro =E2=80=98=
FIELD_GET=E2=80=99
  _dev_info(dev, dev_fmt(fmt), ##__VA_ARGS__)
                                 ^~~~~~~~~~~
../include/linux/bits.h:38:31: note: in expansion of macro =E2=80=98__GENMA=
SK=E2=80=99
  (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
                               ^~~~~~~~~
../include/linux/dev_printk.h:118:33: note: in expansion of macro =E2=80=98=
GENMASK=E2=80=99
  _dev_info(dev, dev_fmt(fmt), ##__VA_ARGS__)
                                 ^~~~~~~~~~~
../drivers/iio/gyro/mpu3050-core.c:830:2: note: in expansion of macro =E2=
=80=98dev_info=E2=80=99
  dev_info(mpu3050->dev,
  ^~~~~~~~
../include/linux/bits.h:36:11: warning: right shift count is negative
[-Wshift-count-negative]
   (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
           ^
./../include/linux/compiler_types.h:299:9: note: in definition of
macro =E2=80=98__compiletime_assert=E2=80=99
   if (!(condition))     \
         ^~~~~~~~~
./../include/linux/compiler_types.h:319:2: note: in expansion of macro
=E2=80=98_compiletime_assert=E2=80=99
  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
  ^~~~~~~~~~~~~~~~~~~
../include/linux/build_bug.h:39:37: note: in expansion of macro
=E2=80=98compiletime_assert=E2=80=99
 #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                     ^~~~~~~~~~~~~~~~~~
../include/linux/bitfield.h:48:3: note: in expansion of macro =E2=80=98BUIL=
D_BUG_ON_MSG=E2=80=99
   BUILD_BUG_ON_MSG((_mask) =3D=3D 0, _pfx "mask is zero"); \
   ^~~~~~~~~~~~~~~~
../include/linux/bitfield.h:108:3: note: in expansion of macro
=E2=80=98__BF_FIELD_CHECK=E2=80=99
   __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: "); \
   ^~~~~~~~~~~~~~~~
../include/linux/dev_printk.h:118:33: note: in expansion of macro =E2=80=98=
FIELD_GET=E2=80=99
  _dev_info(dev, dev_fmt(fmt), ##__VA_ARGS__)
                                 ^~~~~~~~~~~
(...)

Yours,
Linus Walleij
