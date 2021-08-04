Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDBF3E08D3
	for <lists+linux-iio@lfdr.de>; Wed,  4 Aug 2021 21:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240776AbhHDT2a (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 4 Aug 2021 15:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240768AbhHDT21 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Aug 2021 15:28:27 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654ACC0617BD;
        Wed,  4 Aug 2021 12:28:11 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id e2-20020a17090a4a02b029016f3020d867so5007827pjh.3;
        Wed, 04 Aug 2021 12:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WNboISic187HJKXZS9VE236kup1IeE1JWro+1xmidcM=;
        b=GJPbeGh55CJKv39VJSXNqgMjxD1h+2nXiUD3qVFJON7Juuw4/HWc9gntuzSOCLjlsE
         FVnc/OTP3sdFyDJ5ifb4uSgHQZng9wmTtC4+Kbb5/V82h1W+dCtIm3DXRmPXOE4LKlwz
         id1hgnf7Z/TL0Q0oMM4bx05GufqGJ1KvDr8HWHySrVTdKWB0IKd+8sy4XqVkUKigLZyo
         7md6QI96hWS/kgzS79s5sKV5bYcANCghSiPga3u3hmWNTS2f2NoTGPQsq1YG7mI7EAyT
         6ug/fVH3USnb2okw582C2uz4jejx4P2STwtKDQ7TWvpVsakmn6tO5I6EbCX3OLbj+A+0
         fA3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WNboISic187HJKXZS9VE236kup1IeE1JWro+1xmidcM=;
        b=uZsj0LIbauQleNP5zYXL0oGtYnzh6zbLOFrd+YHJmOmf+2Y7JfXjzmpAuTDh8IxxmN
         FeuBGMpXE/8DxOeVyYw0iDB6RNLHQfYWv+4N7uncxyB6VgdJNDooQIr9+Po85EuEpCQt
         E2AwUEoRaJP+xH8PcW3N68EG2QXtPdtRkbtCQLOrVbB78pHHHu+PRp0GZ+Rd3nmvIbo0
         J6gwSjIzd2FJfN6OJsQRP6zb3nqac8VOYKbCkiQ3lQgqyvc1KZFrw/UM6kjSW7up/Cu+
         z61RXERSfWdxSohwqe/ilxHcBQVXHCj3k9mdAneUG3nqcHmZTajuCe2lUAGTWtup0p4E
         z79w==
X-Gm-Message-State: AOAM531Oisuu3OUJxSgrYua0N6lwHeGiv/e5rmiif0HuduIorHIAw5Df
        EHGdgksKXkS7julH1nGJCYx6/qXzV7XaznsoUoA=
X-Google-Smtp-Source: ABdhPJzEP4W1PxkJN0f0Snn5Td3BjxZPcvwFyMPwMigP+Ztps0Hlxs46mTV9dmwWdPsrUrfMY5nGDfkACpJVU5Ykc6Q=
X-Received: by 2002:a17:902:ac90:b029:12c:e7a:c183 with SMTP id
 h16-20020a170902ac90b029012c0e7ac183mr965027plr.21.1628105290885; Wed, 04 Aug
 2021 12:28:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210715141742.15072-1-andrea.merello@gmail.com>
 <20210715141742.15072-3-andrea.merello@gmail.com> <20210717163236.1553fbfa@jic23-huawei>
 <CAN8YU5NctVMPfNZn7ya-Jw7yE=NQDBq1aweWn0fX0Rp1p1P=aw@mail.gmail.com>
 <20210724180823.692b203f@jic23-huawei> <CAN8YU5PcrR-xM5A=3jd50=UaY9wWDJZGBqajmvM8Te1Ly14Hew@mail.gmail.com>
 <20210731190103.6e2a3d41@jic23-huawei> <CAN8YU5OrXy0c5D+5141izDJHxqSakGsbrnkug2M56qczxK0BfQ@mail.gmail.com>
 <20210804175002.000059c5@Huawei.com>
In-Reply-To: <20210804175002.000059c5@Huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 4 Aug 2021 22:27:34 +0300
Message-ID: <CAHp75Ve8s_XygKp1Z6=HEvmXGLOfj6fE4qn5viFF_ZwcXNfOmw@mail.gmail.com>
Subject: Re: [PATCH 2/4] iio: imu: add Bosch Sensortec BNO055 core driver
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Andrea Merello <andrea.merello@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Andrea Merello <andrea.merello@iit.it>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Aug 4, 2021 at 7:51 PM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
> On Wed, 4 Aug 2021 12:06:46 +0200
> Andrea Merello <andrea.merello@gmail.com> wrote:
> > Il giorno sab 31 lug 2021 alle ore 19:58 Jonathan Cameron
> > <jic23@kernel.org> ha scritto:

...

> > Isn't this like doing a cut-and-paste of check+dev_err() in more than
> > a dozen places in the code?
> >
> > If you just want more information about the caller then we could
> > macroize those functions, so they can also print the caller code line
> > number (or they could accept an additional argument, which is the code
> > line number to print, and then a macro helper that adds that last
> > argument can be used to invoke them).. But this wouldn't address your
> > second point..
> It's a trade off between reviewability which these wrappers make worse
> and short code.
>
> My personal preference is don't bother with messages on simple reg read /write
> failures.  If it happens you either get an error reported to userspace and
> can do some more debug, or the driver doesn't probe - again, more debug to
> be done even if you know it was a read or write.

The advantage of regmap is that it has already established trace
events. No need to add additional stuff (at least it's easy to see,
read or write or what values were there). I personally put messages on
regmap reads and writes in the specific cases only, when it indeed may
shed a light on some events.


-- 
With Best Regards,
Andy Shevchenko
