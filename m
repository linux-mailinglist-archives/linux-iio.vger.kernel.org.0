Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E70D6265354
	for <lists+linux-iio@lfdr.de>; Thu, 10 Sep 2020 23:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgIJVc0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Sep 2020 17:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730866AbgIJNvl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Sep 2020 09:51:41 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E5AC061798;
        Thu, 10 Sep 2020 06:51:21 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id e4so949739pln.10;
        Thu, 10 Sep 2020 06:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YQY/BzwLp0IYbpZYHdzw7uNAsxXrI8se2a0WI3eUKs4=;
        b=NmBsgwIw4NTs2k+hvdPiqm8JGBLqwAqXao6+P4OHfTM0PjZZwciA1Yt/NFtxg7CfIq
         OJF2fSZ4uKRs1xO6SM3lLJAeZSwhDODoMDsh0HaDfhsGD5RduZqqKEEOl4tblpoa4bYC
         1uthytF1R8ZI/ijiTDOFr8WlfasjjsHzrYd4/aH11YZy9mkwzjTGn727OvgVaZS1LvgK
         2YV5pMbyFJugUvf3j9J+N7xRrmYL2Yj6Uzvrvz3zzbh2yBzhF3F34D7LAK2OMcxI74WE
         xUgaVaq4B30QLpRlHkulK2N1Pe2/uQZ52uXIBxMNMDXERZExLtPI/vDGH3zr6zQItGzs
         pdQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YQY/BzwLp0IYbpZYHdzw7uNAsxXrI8se2a0WI3eUKs4=;
        b=R8u6AdrPydOQvlSiq99Ra4quQ+B/jGu8yZj3j6febDWZKcsMwjL7f23/YttAv3Mnux
         qpVZTmoWwcVXy3lgq1yM7Ma2rF/TCk1FtqrA4imNSJYNg0c+AhsxlaRj71/jF7KHq5I9
         bS6DXCBuWja5mVaf3fFtAJmCKIEyowcu39OflraaNsicYKiKHqIFHSeq5bCnI7vqTjwV
         5qbgRyb6Sl9HORTOgxj6JN8CWL1OJqmKDoVBgaxmWg2epk69zE1ZpcIOvRpTwHECkZ5i
         Q2FdwwtnhUCmnFLvN7Hl5LYT/6oUp0ZzUoOMVIcoCQCgiX17MQwp4KjBpHzOoN5vFN6Y
         R8sg==
X-Gm-Message-State: AOAM533qkfRFRtiPBFJcA7ip5RU8oZBIZ5vhzN2pQd5aDenQqWhsGsTx
        XYo81m/iFh46Zb+ChdFwNpJ9a5LAwCcMoY2KOpk=
X-Google-Smtp-Source: ABdhPJxn81H+GEwcog15nFQEsbcjCrkGA9TTtx4NHM2DdOhwd+jxzWBgoW6VFfC6LJKbl9FKMUC+bVjGudGRxuxWr2o=
X-Received: by 2002:a17:902:28:: with SMTP id 37mr5399908pla.107.1599745880796;
 Thu, 10 Sep 2020 06:51:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200910123000.16860-1-nish.malpani25@gmail.com>
In-Reply-To: <20200910123000.16860-1-nish.malpani25@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 10 Sep 2020 16:51:03 +0300
Message-ID: <CAHp75VfkncWnZROUb9OVf39KcoNXoOYJdsNZStj4R3AZqs_LRw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] iio: gyro: adxrs290: Add triggered buffer &
 debugfs support
To:     Nishant Malpani <nish.malpani25@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Sep 10, 2020 at 3:30 PM Nishant Malpani
<nish.malpani25@gmail.com> wrote:
>
> Introduce DATA_RDY trigger for triggered buffer setup; this enables continuous
> data capture. Additionally, add support for direct register access using the debugfs
> iio interface.
>
> The device-tree bindings documentation illustrates an example of using a GPIO irq
> line to trigger a data capture.
>

Patches 1 and 3 looks good to me now
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Nishant Malpani (3):
>   iio: gyro: adxrs290: Add triggered buffer support
>   dt-bindings: iio: gyro: adxrs290: Add interrupts support
>   iio: gyro: adxrs290: Add debugfs register access support
>
>  .../bindings/iio/gyroscope/adi,adxrs290.yaml  |   6 +
>  drivers/iio/gyro/Kconfig                      |   2 +
>  drivers/iio/gyro/adxrs290.c                   | 237 ++++++++++++++++--
>  3 files changed, 231 insertions(+), 14 deletions(-)
>
> --
> 2.20.1
>


-- 
With Best Regards,
Andy Shevchenko
