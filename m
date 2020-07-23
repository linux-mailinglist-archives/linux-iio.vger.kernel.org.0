Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA2B22AED3
	for <lists+linux-iio@lfdr.de>; Thu, 23 Jul 2020 14:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgGWMRc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 23 Jul 2020 08:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgGWMRc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Jul 2020 08:17:32 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB00C0619DC
        for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2020 05:17:32 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id 72so2489195ple.0
        for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2020 05:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eGw+fqsnK/L7rLWjzKpVeCy8EHBYRXFXj1WCW1Tp6Is=;
        b=VbKT7OOqcSce+oiimEp+WzA6QEOMjkToFPimxSk27gfQJ9Z/WsdsTVyk5DiQuosWKF
         u4g1X+1wUziW9B4A2Jezu/iM88rqn9GEo/83KlIwmSs7/ep8Qj6G5rf3vc9auYUDC0r2
         JtYZBiCNWrVqjSxJzLzd0gPyt2o51L51fsxELtMET1yoDnEY+HA8nfMLmpO6TjEgIw+r
         CkEaSnMr8L6r3MraGuc7BGeBTC+Pw776uzO3QuVewxmdWhtcUsxM1AhMtisGdudvlyt6
         tRWwcLJjvKMdICi46WCL/MAXu5GZv8NFLt1nmHGoJI0OVkE58BYSmM5buHOrhoRWanjr
         2JIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eGw+fqsnK/L7rLWjzKpVeCy8EHBYRXFXj1WCW1Tp6Is=;
        b=FHTa3TGepXrPe/CLX4IIJXD7No+3Ran458OcoK3YYlSynZhLhi4jRknoMrwnw+N61X
         Q8nb7S3DPu5o9deY7iyjWwqWyMl4MjL6LB85Cs7mRZwKyvSjYzdqhhtDECKnOYA0Oaun
         zEbQG3q0fmz1Os1L1pHdFixFGh5ErzhlHtyuudVHn4uG/METs72krfhdGHOksesWJV7r
         /zaqFcQ3PRAnDSH7DOMmRzQsMygKuEvjDLyvVZBs9Z8GyOSNkbS2m8rcq3bF8RmTnIt/
         Lfzkdqq52DaX98/dixrXVbo/4Y8vppKArzz6IB8h06jy+KfUhR7egZADVjiryAG6eTGS
         gYsw==
X-Gm-Message-State: AOAM5315wP8Ect6YrOWsIlKei6MoCWjk2OzuhlBK4TIMFCaUDxLA0sBy
        0SX5BlcXavwKKVenukvxRsh0KCwXSEC7o9lHOGM5voE1
X-Google-Smtp-Source: ABdhPJxdCPh7zTr3yn+gkgfa7tcJI6IwNhmUM1NAbs39owjIiDSGFCyMV1+kcB7U6SmoZ8VGQ1pZEbkeI0zewMMQY8g=
X-Received: by 2002:a17:90a:a393:: with SMTP id x19mr147504pjp.228.1595506651723;
 Thu, 23 Jul 2020 05:17:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200722155103.979802-1-jic23@kernel.org> <20200722155103.979802-20-jic23@kernel.org>
In-Reply-To: <20200722155103.979802-20-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 23 Jul 2020 15:17:16 +0300
Message-ID: <CAHp75Ve6UAs+iryEgbcxW6FtbnmUAsV_MPJ7SiiCpkT5_O0xng@mail.gmail.com>
Subject: Re: [PATCH v3 19/27] iio:pressure:mpl3115 Force alignment of buffer
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jul 22, 2020 at 6:53 PM Jonathan Cameron <jic23@kernel.org> wrote:

> This one is unusual.  We have to do an explicit memset each time
> as we are reading 3 bytes into a potential 4 byte channel which
> may sometimes be a 2 byte channel depending on what is enabled.
> As such, moving the buffer to the heap in the iio_priv structure
> doesn't save us much.  We can't use a nice explicit structure
> on the stack either as the data channels have different storage
> sizes and are all separately controlled.

I guess all non-standard cases (where no struct is applicable) deserve
for better comment in the code.

-- 
With Best Regards,
Andy Shevchenko
