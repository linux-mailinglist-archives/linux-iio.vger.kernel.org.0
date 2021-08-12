Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 534923E9D74
	for <lists+linux-iio@lfdr.de>; Thu, 12 Aug 2021 06:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbhHLE0m (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Aug 2021 00:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbhHLE0m (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Aug 2021 00:26:42 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF77C061765;
        Wed, 11 Aug 2021 21:26:17 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id x7so8507137ljn.10;
        Wed, 11 Aug 2021 21:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rC7a2eJigRCbjOi5vndYpSm7lFSYsWKvgT4cUb1MVwU=;
        b=AWCW9diWNKW83c6VHqZXaWStYuufK98+hpJtMogri3k01AgFTB4fupowIqU+xGYHR1
         SEDqoE7QE5s3kUTyFQFC2gijBSYbkVJE+tG3GqfOxE7g3txy/DKWJQW2DQP22m4kNCDf
         y8somif0X4gjiF2i21AVw64e3+C8pxHZ9GTzstgQM59S5aPpZo3feHDiSGqGNwJV5Rdg
         kF3uwn9WVsWmWRgV8QFemnx2w0vKdOH6x0/U71HOZU195EF1nKY+CSnfi80v74zslq7h
         167pHMyh7TY0QAa9zm7BxrZgOZ8vkEwpRjEYX9w4XtB6ivuis3yPSji5hbhKRrwZRgr1
         oyCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rC7a2eJigRCbjOi5vndYpSm7lFSYsWKvgT4cUb1MVwU=;
        b=LNa/KEKb9M965giZ0Gho+MREyHpleD4K7tE7txhlMnqlZPpwCDr9D16mAeKMYMOrdV
         g9XCxB8KVKe9aHRqWaupKqwOvQGg5mFDteSlgR6FC+1Uw6FKyaP21zf9NaF9wgjj/F+F
         VDWzPM+FQrP9ahCoq+a9LKPVQEfp379eptsLLnrn7vluIZy2T9JzlGo5RAnbSUZWNX6l
         Jv+fSe7ktUFL9HwUfrH8x362hIW4oxiPazuIvthVwEY0lN/ZT/crDKFFfZKezyLnFmQU
         0YBSYWAgvJTxz70QnPCItfk6pE2F1fGlWc8saqnBIisORLzS+ePe1OrjQO//tm2kj7Ud
         6YCg==
X-Gm-Message-State: AOAM532onEJwyiCLN/Qoiw/F30WykOdcnKTlhtgRkEswxG3GdnGgT+ql
        K/x+EIlZ4A/gx3RcMqAmIRDu52dF6ZsFsRjZkvs=
X-Google-Smtp-Source: ABdhPJyVBL4SS2DvCj+dswUs8qRmjCEBxaOxDNgn5CXfZ+XjoAVWYAaotkGIynPqUopgAIu/NIS5FN5gw49jxAqE+Z0=
X-Received: by 2002:a05:651c:23c:: with SMTP id z28mr1494107ljn.161.1628742375712;
 Wed, 11 Aug 2021 21:26:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210811073027.124619-1-puranjay12@gmail.com> <CAHp75VeGKYe_OhAhZJ5zaHnLgrn-yv6viz37yrz5ucqvBw3eFg@mail.gmail.com>
In-Reply-To: <CAHp75VeGKYe_OhAhZJ5zaHnLgrn-yv6viz37yrz5ucqvBw3eFg@mail.gmail.com>
From:   Puranjay Mohan <puranjay12@gmail.com>
Date:   Thu, 12 Aug 2021 09:56:04 +0530
Message-ID: <CANk7y0jUw32F3SM=1dbA7WzmKYUo2nFvzezc132-GNU=0qS67A@mail.gmail.com>
Subject: Re: [PATCH v12 0/2] iio: accel: add support for ADXL355
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        Darius <Darius.Berghe@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Aug 11, 2021 at 9:32 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Aug 11, 2021 at 10:30 AM Puranjay Mohan <puranjay12@gmail.com> wrote:
> >
> > Add the dt-bindings and the driver for ADXL355 3-axis MEMS Accelerometer.
> >
> > Changes since v11:
> > 1. Add forward declaration of struct device in header.
>
> > 2. Use defines for power-of-10s.
>
> TWIMC, Wolfram applied patch against units.h to add the SI prefixes:
> https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git/commit/?id=26471d4a6cf8d5d0bd0fb55c7169de7d67cc703a
>
I will change to this once this patch gets merged.
> --
> With Best Regards,
> Andy Shevchenko



-- 
Thanks and Regards

Yours Truly,

Puranjay Mohan
