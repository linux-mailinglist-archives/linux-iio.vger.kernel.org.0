Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB26525C993
	for <lists+linux-iio@lfdr.de>; Thu,  3 Sep 2020 21:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbgICTdk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Sep 2020 15:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728312AbgICTdj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 3 Sep 2020 15:33:39 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B73C061244
        for <linux-iio@vger.kernel.org>; Thu,  3 Sep 2020 12:33:38 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id g29so2937909pgl.2
        for <linux-iio@vger.kernel.org>; Thu, 03 Sep 2020 12:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oeNeiTVjJMGwcRNsu1rCd66K2IBTjlcY6jJxYDyv9ag=;
        b=UZG6aXDr3tmCZz++aOlU9rBuZrIaSX3cFR/8LIUzN9//3ejcgU8HHPR3aSKvIv/0Hs
         3QhgEYwV2EGZH1DFczrJ+3xioNjeDgKwrWwzpv3d9U/xxd2gVXz7tttd2fCpzUItf6zj
         usaOsQypxhv3ozvdb5g7L5Y+Cwqpq5dca7vqgwmxTSc8SFb3UiFsGJU5jRHCW1gWQswY
         2WPrwBEDTJ0xr2PysaMu0HKYqgDmRFW50dKJi9ToPEu/bdgXWbp7Ihe0RNqedY32443h
         WeYI1wVXx3hoyoujBj51mg8xvyCDNTda6HEXGHJ90pcKrR3XfUiCClMSs6Ol3Ii6tzid
         Wr5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oeNeiTVjJMGwcRNsu1rCd66K2IBTjlcY6jJxYDyv9ag=;
        b=KL6utIp3gb2JpXiYau4EoRSUbccgj1UcpPNrIIQtLkJ7VIONTXAllfSU75JkyUqw8u
         AJWY13XnYjZmsZieDeURE06csFrRJzWNl91SJyIQjmn1cidbCT8DzurOJ0mKYLLOD9xM
         NYRm07breEHbJ5Mbznk3StpFclOOj1MK6ZKQo0vo69gNLWqIOGP96nuPRjHuTdF8p6PQ
         VH+VuSn56h4W6T8KSlN9fgFtaIQxLZtIxKVfiP5S6196omIOLaADigC5Pj8TuvnRHwX1
         Qm2k1vdSWi7T6L7sznL64esE+1AqY68zR0sdLnovzmRML3xPsQpCJI0hAMjriIcDsMlJ
         wfng==
X-Gm-Message-State: AOAM530hRHSDNrb+aMGnziAiYxSXuf9PvLfz5DAxyZuPQyM6Sko0B9O2
        Leebcmh8ChwvNCTaaGP3RJs+E6jryHGn4HhlpG6IxPcz8C8=
X-Google-Smtp-Source: ABdhPJynyN+kTDuW0Ecuwzwv1msmTH3R2UA4Y6xgvrPaqw1Foh35yrDBglB9USnE6cEgtNzkF/0xB0vd88SJ77qAaKc=
X-Received: by 2002:a17:902:b289:: with SMTP id u9mr5429167plr.226.1599161617699;
 Thu, 03 Sep 2020 12:33:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200831090813.78841-1-andriy.shevchenko@linux.intel.com>
 <20200831090813.78841-2-andriy.shevchenko@linux.intel.com> <20200903193551.3b89702e@archlinux>
In-Reply-To: <20200903193551.3b89702e@archlinux>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 3 Sep 2020 22:33:19 +0300
Message-ID: <CAHp75VdtE+xVc++Jtvr0mL_f7NpOYGPap10yA1-m7aSNm0oO8g@mail.gmail.com>
Subject: Re: [PATCH v1 2/8] iio: accel: bma220: Convert to use ->read_avail()
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Sep 3, 2020 at 9:36 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Mon, 31 Aug 2020 12:08:07 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>
> > Convert to use ->read_avail() instead of open-coded attribute handling.
> >
> > While here, fix the typo in array definition and append comma in case of
> > the future extension.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> I missed a build warning inline. Now fixed.

Thanks!

-- 
With Best Regards,
Andy Shevchenko
