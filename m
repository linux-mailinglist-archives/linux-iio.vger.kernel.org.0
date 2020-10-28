Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB6AA29D731
	for <lists+linux-iio@lfdr.de>; Wed, 28 Oct 2020 23:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732618AbgJ1WWH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 28 Oct 2020 18:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732611AbgJ1WWF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 28 Oct 2020 18:22:05 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9B8C0613CF
        for <linux-iio@vger.kernel.org>; Wed, 28 Oct 2020 15:22:04 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id j30so815450lfp.4
        for <linux-iio@vger.kernel.org>; Wed, 28 Oct 2020 15:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DasQpb8CfW8HKEVpu/KOavkRhA8AAHEMsw+zOKV6OFk=;
        b=QPXZdkbF+FeS5uc/aNDlU9mVXmuJa/YXl2FdWJFfcvFa0tYE+7T8fGfRo7S/kDvKZ3
         92sqwNTPczgV1a6N+a6TD0f8nv4eyk+KKv3AlAYOR38gb8W+JzhFri5QEWt6vjpHF+w1
         HnGm4EbsQPu1sZzypyxyeG4GEVAtVj22etFoT5dwRjjCchqmtQ8J/cgoJT0Bep1l+DTg
         pDXr3krTBs4njOGdIhTfrObVSfrR55xFMsY6W7vNm6bnGCVQ+GYnZFUANpzs/k+0hJ9J
         MRm6W6ZI+M60eGS8xAlAr8xWW6gwrGR8GrJqjQlGaE5ogd8FwKzZG5Bas5V56PK264dN
         9aBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DasQpb8CfW8HKEVpu/KOavkRhA8AAHEMsw+zOKV6OFk=;
        b=NWPEsybyILAZn/IjpJkOh/Fy24Gn9Z5sMeOWfu1mVF8btCA/ErDHbwF6+nOvzYy9N7
         UiAi+5lWJBBdFzz75XURSCPRofqhDSxn/jUjqXIvtlpzwEQhOcKKGGIQfFghIH1QUckd
         OKHWRaagzJAN+r9psqE3BAfmvk55l2+dC2qWImk7IiQ+6BHblSFvryH+zSIChzTR5M1/
         ruOKcDLF5BmZ8+g/whqfjjTnc6jvHrLWAEbAdwWONgH7ny2fjBh8nRbnk3bUEQpP+1V+
         uqFPV1yX6/DQa9QpTKlrDW1HaEm9jzpMLgQqSEKg0PNCAXX9vmDcrZw1CnSiJA6qJ8AR
         TAZQ==
X-Gm-Message-State: AOAM531nFh1zobiF/BF6GoSvvc5/2wJkPadS0rO/CxRtT2M9L9ytMwQN
        p9MRl3o82TLzdDzg9upUWPoAyvSmWoUTzM6ST/MCWrjIf2Eang==
X-Google-Smtp-Source: ABdhPJwKMS7NldNI96lpXl48mO0zKQe7LV7FsHiX9udTi/7Fta5ycI9PbLPivsn4y0NgGWNiD/oagwYN9l997N20gng=
X-Received: by 2002:a05:6402:6ca:: with SMTP id n10mr7840705edy.273.1603891510778;
 Wed, 28 Oct 2020 06:25:10 -0700 (PDT)
MIME-Version: 1.0
References: <20201026175340.19570-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20201026175340.19570-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 28 Oct 2020 14:24:59 +0100
Message-ID: <CACRpkdZPJKof4uVk-dHjEwaR2GE9ujjLAO8jZPiKycbQTuBbCA@mail.gmail.com>
Subject: Re: [PATCH v1] iio: gyro: mpu3050: Use get_unaligned_leXX()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Oct 26, 2020 at 6:53 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> This makes the driver code slightly easier to read.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Oh, neat bitting!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
