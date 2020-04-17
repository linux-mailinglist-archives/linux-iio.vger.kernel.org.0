Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3961AE6F9
	for <lists+linux-iio@lfdr.de>; Fri, 17 Apr 2020 22:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgDQUuv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Apr 2020 16:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbgDQUuv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Apr 2020 16:50:51 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB58C061A0F;
        Fri, 17 Apr 2020 13:50:51 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id f2so3492883ilq.7;
        Fri, 17 Apr 2020 13:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nKy+MVhaXGCVle0vERWmxzcdk4A2+h6/ggdCYc2ZwIE=;
        b=GRhCunsn03ZRp1cS6yqRICUkb06cwMQ8Cmsrs/P8fCXfLJ9lGAmnZLba0rqEa4Z+RX
         Q27nsaDKU2xafZntkrjuNcq7CkyDLyZetKaZCJ67mTCsd5bTT0dQUeWYc2StOKc8p80C
         uJzZ1KAAlSKfh04KiOrwHRLn0DdHT2tkGBtvrtmCB78CpVf7u/7ixLEA2Jxi22YbG/Jo
         7mVAZv1bC4HWnxzJmE4VZ7XtQxTx+eKNLICTRgTlfO4dwIwuGuWP0hE7Zqc2v+0Fn2Q1
         F29S9TBm7Q8dwW+4RGKRnsTjgoWBKm1py0rPVETTebSshBF6eGNTTXpZJxxvOjihKDNG
         qphg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nKy+MVhaXGCVle0vERWmxzcdk4A2+h6/ggdCYc2ZwIE=;
        b=FpNkuXlpljoTdMqOEBiMV1Ucq7PY22Sp8qqyffw4yh7gYrrEzjB7Fdc3Nha4rbrhuT
         /tn7qul0xHikn+2obypArZN/2+nC5tWS6NMC/dFAIzfig3lLnGsQUkRAbr+wNzO3j3Pi
         wbF9OqCOp7uSgpHNJLqMLqnZcOzVAXirJo4v6Cdc1Hz6Gfo12j90rvAS3rrzxEQ2Jqfi
         Qxu04Y0FRtvI8IYZibiKDdb1NVSzrNYp0LSoOEc4jEF1t2m0DNYo8cr6mpqDEd066fmd
         OyAaEOTDK7aAXxQwXORFRauhUJOso6YjeGeZiMXL0dsTiZauMu2i8G1+vQvQW6k1KMO8
         LvRw==
X-Gm-Message-State: AGi0Pubxh5y5j36vjGStm7R4UWrzPHdwpnf38HHlsJn4I3YvKTgIZqBf
        zagHVX7nK4p2XBWdc4aSaX8LgXESHJmj2ezGX68=
X-Google-Smtp-Source: APiQypLVsyXbxBwjGzuPo7cVWPa6XCFicY+ZWr/zP+jvxIetFYyeyAZpF4o60Zt/A65ahz1e2VNBOgTbLnRQeeVTTlU=
X-Received: by 2002:a92:bbd8:: with SMTP id x85mr5073175ilk.23.1587156650429;
 Fri, 17 Apr 2020 13:50:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200417162204.14463-1-digetx@gmail.com> <CAHp75VdAn3QYY3gejnsdKuSyaLme1tiksSnoeg9rtzcJNG6S0w@mail.gmail.com>
In-Reply-To: <CAHp75VdAn3QYY3gejnsdKuSyaLme1tiksSnoeg9rtzcJNG6S0w@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 17 Apr 2020 23:50:37 +0300
Message-ID: <CAHp75VdKxRGrmqPDTugVNrc3i_JDyEdJ6gmjyH=t9OiRTGg+AA@mail.gmail.com>
Subject: Re: [PATCH v2] iio: magnetometer: ak8974: Silence deferred-probe error
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Apr 17, 2020 at 11:49 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Fri, Apr 17, 2020 at 7:24 PM Dmitry Osipenko <digetx@gmail.com> wrote:
> >
> > It's not uncommon that voltage regulator becomes available later during
> > kernel's boot process. This patch adds info message about unavailable
> > regulators in a case of the deferred-probe error and also amends the
> > error message with a error code.
>
>
> > +               if (ret == -EPROBE_DEFER)
>
> > +                       dev_info(&i2c->dev,
> > +                                "regulators unavailable, deferring probe\n");
>
> I dunno why you think it is worth to spam log with this?
> This message will be printed as many times as driver got deferred
> probe cycle (maybe dozens in worst case).

As you may see in other drivers we usually have the opposite check and
print error message in case of != EPROBE_DEFER.


>
> > +               else
> > +                       dev_err(&i2c->dev, "cannot get regulators: %d\n", ret);

-- 
With Best Regards,
Andy Shevchenko
