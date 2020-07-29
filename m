Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E50C231A00
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jul 2020 09:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbgG2HFb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Jul 2020 03:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgG2HFb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Jul 2020 03:05:31 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC49BC061794;
        Wed, 29 Jul 2020 00:05:30 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id l12so2692575pgt.13;
        Wed, 29 Jul 2020 00:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aqneD3uac2LdOmEkTebU7/iHb0Bb9C+xYvrOoegSBgs=;
        b=Lh3i7c+OL3d+WLkPoNum5UxxmjDrhR7GDKRz6sULoHyatpZS2MPkG9So13ntBRx7vY
         Ceyk6+qTG/biB3GeJ1fr+xMwbIN4uXvFksnueRi9RYeLaWN+wdeq+on+DX4NjbbKTfqZ
         vBbQeTn43whAKfi8uNc4FsePsP8Q0l7xpi9kB2fRfzyYHKP7/VNfmBXFktwyafjt0lqx
         cLSkpuZAewmbzaJhUhkGHDN6rzOrclI5xZMHEmAdzGmC0iB+knOpFr3FI73kM0KbaXvn
         /SRU8m1xO/bi525c8tfsyb7nRtEZrLShkV2cqgd58TE8OK+v0ZNZUBcbFeti8CIp87GY
         sakg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aqneD3uac2LdOmEkTebU7/iHb0Bb9C+xYvrOoegSBgs=;
        b=WI7oM8aaMij8/mNCzSRuB5Dzp3aKgf3A7CnkMssG5b+/PLYKLtJB+5n+TuDdeYoTaB
         8vHMaXNg6OqaRI0o1nNilGE6LO+O/zQmtvKOcYpNW2nEIJVG/HscFFhlKlgfsyAI0Afc
         ST3N1U+jruKTlZvS2uVT8g0aDrExiLeNu6UBXYO66NEl4S1u9vo0XmAJz1gxiygSZ6wc
         M5wpPhSsZosfu9+awaSJaT9SbLLRzA0+bPpj6/xvGAt04OcgH/3bGRU8ado/1bcrvZvQ
         I49usvEgWPCnc+2XZCLaUAML/i7ligoW/4hJ6DZypLeeBNugSffdm4blg6SaRk5dDH65
         7tqQ==
X-Gm-Message-State: AOAM530oDSGwZ5bkuM0vUEANIwlz9mv9/y8xYJw8JwkBZE872m0I8zWQ
        8pZ7Af+BSowtftv+ESTuXaqf/m6p+cyLNudo6mo=
X-Google-Smtp-Source: ABdhPJyk6o8rBmKoUdAMTmnz/y0G9FAdd8Efbgcb4Gh9SbYuQB7jrAq58GKL82gQqlt6ZSrBU6EBHu/xHQRRLV+ACfo=
X-Received: by 2002:a63:ce41:: with SMTP id r1mr28668169pgi.203.1596006330322;
 Wed, 29 Jul 2020 00:05:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200729003243.32097-1-b18007@students.iitmandi.ac.in>
In-Reply-To: <20200729003243.32097-1-b18007@students.iitmandi.ac.in>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 29 Jul 2020 10:05:14 +0300
Message-ID: <CAHp75VcmMf5dt7mu9N0C=6Rej-WzZ0EpzntHYCQkgNLVZkPbgg@mail.gmail.com>
Subject: Re: [PATCH] Staging : iio : Fixed a punctuation and a spelling mistake.
To:     Ankit Baluni <b18007@students.iitmandi.ac.in>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jul 29, 2020 at 3:34 AM Ankit Baluni
<b18007@students.iitmandi.ac.in> wrote:
>
> Added a missing comma and changed 'it it useful' to 'it is useful'.

Please, drop spaces before : in the subject line. In all patches you
submitted there is such an issue.

-- 
With Best Regards,
Andy Shevchenko
