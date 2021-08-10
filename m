Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1A83E5A20
	for <lists+linux-iio@lfdr.de>; Tue, 10 Aug 2021 14:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238837AbhHJMkL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 10 Aug 2021 08:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240681AbhHJMkL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Aug 2021 08:40:11 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0CAC061798;
        Tue, 10 Aug 2021 05:39:49 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d1so20815367pll.1;
        Tue, 10 Aug 2021 05:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9I0CnBRBS69h5ISxkRVZTJz/oVJGT//9peAin9G2oR0=;
        b=a5N2tYoMh+j84y+bIgz6oG01D0K5QDRWLaZg+31ztimX+GfRHjZQ4sQRrB4p6SLitX
         V14TEE1gTejVfsq+PrL8uLIUrThO8ZrC1MJaRfl4d14PtPvooc6U4SvcOrj3i3Au0kbp
         2aeH5rSg3XSlATKMIGZv0Ttpeotyjb27motXWF8ldnl2GeHEiX2GQhUGwcztpMX1GjH7
         kGsQhdNhUXqny360/iN+y4B9/j0m5yvO0Af/32a9i+KthjiHgAlKIe+SHUMArSizkcdD
         X/2q9P3pI2IqNV8oKdZxNg8mewu7YEDGPwVXuNiqQO6HHSmjWtrZjwwQxOGAxgO50b3F
         Ojrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9I0CnBRBS69h5ISxkRVZTJz/oVJGT//9peAin9G2oR0=;
        b=pk4GfiEYWIMxyVZAY5/xkc0ln8nSbNOR1m/68jYdt4dkSnKX8QScrTkXgNiPyN7oiZ
         qEq3L+bu1Jx0Zj+OEUxHQjd1VYMgeEnJXusMxng2oEFXc5b30KxQh1Kq2uVve3ShuG1c
         qaDD2T0rvaFZucaZrP+8DTF7PAe8JWkf4iOXqmgo0IEuYRxIqeKKQDu5SDB7Q61f6+ji
         gs0YYk2uO80JU+aXPnCvYYIYYiGWljlt8eOTJw/4ulbLHiBEbIVbRmb9mfR+lb9W5ieh
         Pyf16XI9Zh/km83PaqEAXPsoBmrzR+hVN/srh++7FJEyUYPf4Bkc8ODmfraaAmdYdwTn
         4OHw==
X-Gm-Message-State: AOAM531FAzt2wTxZEBtqQ4o49PVHVvLF7HBLQWmqSy1XTWLcSn55UX1L
        yh5sKnywobuwUgAYLF/5BKad/epFf4aUVKqkz5M=
X-Google-Smtp-Source: ABdhPJxknJ/8yapgV7DOjdk/q25wwmvoANXzbC6kDa/PQf+uy3zUoNRhkS3S+e2JHbl0/P9EcODlDqlWmWx5mWKH2ls=
X-Received: by 2002:a17:90a:604e:: with SMTP id h14mr1710147pjm.181.1628599188576;
 Tue, 10 Aug 2021 05:39:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210809080729.57029-1-puranjay12@gmail.com> <20210809080729.57029-3-puranjay12@gmail.com>
 <20210809205141.193d24dc@jic23-huawei>
In-Reply-To: <20210809205141.193d24dc@jic23-huawei>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 10 Aug 2021 15:39:11 +0300
Message-ID: <CAHp75Ve=fnib8YzVH_5LySgQDiWCxNzsJYBBLtB68GrSOCT9SQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v9 2/2] iio: accel: Add driver support for ADXL355
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Puranjay Mohan <puranjay12@gmail.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
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

On Mon, Aug 9, 2021 at 11:56 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Mon,  9 Aug 2021 13:37:29 +0530
> Puranjay Mohan <puranjay12@gmail.com> wrote:
>
> > ADXL355 is 3-axis MEMS Accelerometer. It offers low noise density,
> > low 0g offset drift, low power with selectable measurement ranges.
> > It also features programmable high-pass and low-pass filters.
> >
> > Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/adxl354_adxl355.pdf
> > Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
>
> One odd formatting thing below (tab where it should be a space)
> that I can fix whilst applying if you don't have other reasons to
> do a v10.
>
> Otherwise, looks good to me.

I just reviewed a previous "v9" and I have quite a few comments I
think can be addressed.

-- 
With Best Regards,
Andy Shevchenko
