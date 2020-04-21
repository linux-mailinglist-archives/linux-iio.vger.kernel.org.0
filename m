Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0BB1B1AF0
	for <lists+linux-iio@lfdr.de>; Tue, 21 Apr 2020 02:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgDUAvJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Apr 2020 20:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726055AbgDUAvJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Apr 2020 20:51:09 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D23C061A0E
        for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2020 17:51:09 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id u5so11872223ilb.5
        for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2020 17:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bV0+FfJ6CB9x5sFed6laUKon9bIF3Z2Vd/AiZjqBpDY=;
        b=GwbnEhXkMtEeUcMfwrViRB/NOcjo7mglR2fiFymnjtm8+Q1WsjW5vzgUHnnRuxputU
         ju7VOA6J5NwK3hJFethPJOKUhVQZD8rYcYNxLrRdP+LIiEzoJN3fBWf9DOUrhN2LgqHI
         Hi8vmmeaAtefmqXCtVemBm9K9U7yGMtUQc2laHtG3VNiY0c1Z/A0RDHMvWoeA/L/MUb7
         4hLzztp0y1BVdyEEIrg8wfPo4/8h1YB+y/l6/SfSjWHQaNbv3u1b70OCd1qE78x5yRPf
         TWAKO2vo1s/WYsoLPBCLZsIIcIH5cqmJT29iqr91f3ZUcRnelbV9ggUluzcMKV5OEy/B
         +a6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bV0+FfJ6CB9x5sFed6laUKon9bIF3Z2Vd/AiZjqBpDY=;
        b=hnKYzMdMZvKjPBroGmPDMBX7zr1c6Y8Mz4DpRo1RwiIEQA6m04df40wQKUObQb1K5R
         hC0VGns6yd1YLeKoaEFDJZahNjCDD66XlT3vD/ACBC4KQc0pWKMH+9Be7KsU96Inh44v
         r2DOb8IzKl1UChd8Jk7bdn/Djw4DthDAYZyjTECeEd7208blsRGEsxdtFZV98g8x2B7g
         zQVXpM+9tTxnZI0cEDZc1WFnGi74rDNWQogfJpwTPTXJhIUC2S3Gla+m+mv0FaSiiUNx
         qUIzcKvcaXIpI5pY8GKeRshm51a3prqEkamqalXCmlgcfUeYbtxkzDHWnDC0jTITPDBF
         InSw==
X-Gm-Message-State: AGi0PuboKEZBD0dqG+d/lW3r4xVUzRxC+oqRX2q1HReyxSaymKlH9ZJN
        oUiyzZ457p9xevR6317ZL2Y9Eq1ThJqvJEWsIqwz8wvqYDs=
X-Google-Smtp-Source: APiQypJTCwUAXIJuKUMocL6ksOYdXmKH/QNaDaEQC6YOwkRJvtDGeNybq+kMZfak7sQhTwzczjAIvKhmwFZddrMolEs=
X-Received: by 2002:a92:858b:: with SMTP id f133mr16884139ilh.97.1587430268736;
 Mon, 20 Apr 2020 17:51:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200419150206.43033-1-jic23@kernel.org> <beff54a412caddaaa7facbc2df2ddf939668fc44.camel@analog.com>
 <03f6eb6e7cf61c6dfd8bcd9aeaaf6977cb095191.camel@analog.com> <20200420164832.00004065@Huawei.com>
In-Reply-To: <20200420164832.00004065@Huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 21 Apr 2020 03:50:57 +0300
Message-ID: <CAHp75VfRV4eLun7CoY0WORxzczjyT5GCB3f1d561LrLMx644Ng@mail.gmail.com>
Subject: Re: [PATCH 0/7] iio: light: clean out of_match_ptr and tidy headers
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Apr 20, 2020 at 6:49 PM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
> On Mon, 20 Apr 2020 06:22:09 +0000
> "Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:
> > On Mon, 2020-04-20 at 06:04 +0000, Ardelean, Alexandru wrote:
> > > On Sun, 2020-04-19 at 16:01 +0100, jic23@kernel.org wrote:

> > One thing I noticed in the series.
> > No idea if it is needed or not; a build would tell:
> >    Is '#include <linux/mod_devicetable.h>' required for this change?
> > Most patches add it, but I don't feel it is needed; I could be wrong though.
>
> I addressed this in reply to patch 7.  It's mainly obtained via
> i2c.h and spi.h in these drivers.  They don't have any particular need
> to include it as they could deal with an opaque pointer.
>
> However, seems unlikely that'll get tidied up any time soon and
> debatable whether there is any point in doing so.

I would use the simple rule, we include header if we have direct user of it.

> > What I noticed is that all 'linux/of.h' , 'linux/of_device.h' &
> > 'linux/of_platform.h' include it.
>
> True, but we shouldn't include any of them unless we have reason to do
> so. They bring baggage we don't need for these drivers.


--
With Best Regards,
Andy Shevchenko
