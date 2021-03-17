Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7BB33F114
	for <lists+linux-iio@lfdr.de>; Wed, 17 Mar 2021 14:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhCQNVi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Mar 2021 09:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbhCQNVN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 17 Mar 2021 09:21:13 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84366C06174A
        for <linux-iio@vger.kernel.org>; Wed, 17 Mar 2021 06:21:13 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id n14so40924241iog.3
        for <linux-iio@vger.kernel.org>; Wed, 17 Mar 2021 06:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ztw1HDEAs6OnodVeAD5bM0bnk3tZqDLL6zMVKnMAJfQ=;
        b=DunsJvZ8BHwsTPd8wcqyXQoVAxIosmEXKT6a9dI1igeje4TPAg+lZm0P8BCAX/I8AN
         MbVyQt9MqoSPtExGSyS/PNjUYUyjUXKrliU9xVVrFjCL1BgnqXaXx9nOJZVPa/wzmm0r
         oW6maZTr4qgMzD1vH0xJ6GzVWcj55yb1Df9Ny8YixtnpRf07ZvVHcoKAO/aEt0dVIBkI
         3196hzf3e0X65Z4FHo5Vwyg/wuk9s/wixuKZqbQxQRgMkp5FnivzxYXpQXzIHOQgrqaT
         mUveEwb1i+cWi/18YpHu0umSBYJWH+XNuNdLSc/OtuJ/742hXPOJVVd44ug6wfE67ucf
         fjeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ztw1HDEAs6OnodVeAD5bM0bnk3tZqDLL6zMVKnMAJfQ=;
        b=FHcFy86AKsobfe8YBYAizqfi1a1pXlOPVG9Q5Z+E/rqDMKc1DKVRh1MVCtFVNkj4fn
         fbU0D2ecAP811RiizIBMjd4IZ0+eMHOSN3eHSeaiO1qZzC1fd02L/c+rMqOE8Ha+PCbc
         VbldBCKzv3jG+4K8uNHNtlVnLTKIQq2SXYxaQFQzuJC6L5Udk5J+5EQbUUwX6kwHaFNa
         gMFVZcR9zbEc0EtnPeoh7utUld7tj5X3pBTOky8a0G7gguqKHE/DWXAM/ohoPPUyY/pk
         tIh+jBTxcRxDEO3zm8LssQpwd+y5eq1G1IKOGj9/CPcs7M3CWrHIVH2wF7xlc0AVzX5s
         hptw==
X-Gm-Message-State: AOAM531Tnk5fN2dyN3wqS4/SeAeWNbMK92NmVbrwRreVyM+GWWD1usco
        2ADB0R2zKgj4hC7gG7IFtw0nBj45FDtRCMDmSA0=
X-Google-Smtp-Source: ABdhPJx0BLHURdPbpMVm7U0ZnGy+Ku77HKqaMI6XoH/uyFZoQpH8oRfreASxmhjk0coTPayWx37WpctWJkxdIlp8P/Q=
X-Received: by 2002:a6b:103:: with SMTP id 3mr6931594iob.98.1615987273008;
 Wed, 17 Mar 2021 06:21:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210316202919.1886616-1-gwendal@chromium.org> <CAHp75VcV6xQQJuVeVL5TS0ott-cmR4YB-2P+Y3WBarpWSz676w@mail.gmail.com>
In-Reply-To: <CAHp75VcV6xQQJuVeVL5TS0ott-cmR4YB-2P+Y3WBarpWSz676w@mail.gmail.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Wed, 17 Mar 2021 15:21:02 +0200
Message-ID: <CA+U=DsrELGfk=8R3fD0OUjUOPD2-gy45oEC4azsfjvz4dcobxw@mail.gmail.com>
Subject: Re: [PATCH v5] iio: cros: unify hw fifo attributes without API changes
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Mar 17, 2021 at 3:16 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Mar 16, 2021 at 11:24 PM Gwendal Grignou <gwendal@chromium.org> wrote:
> >
> > fixes commit 2e2366c2d141 ("iio: cros_ec: unify hw fifo attributes into the core file")
> > fixes commit 165aea80e2e2 ("iio: cros_ec: use devm_iio_triggered_buffer_setup_ext()")
>
> Use the proper Fixes tag(s) in the tag block below.
>
> > 1. Instead of adding has_fw_fifo, deduct it from the configuration:
> > - EC must support FIFO (EC_FEATURE_MOTION_SENSE_FIFO) set.
> > - sensors send data a regular interval (accelerometer, gyro,
> >   magnetomer, barometer, light sensor).
> > - "Legacy accelerometer" is only present on EC without FIFO, so we don't
> > need to set buffer attributes.
> >
> > 2. devm_iio_triggered_buffer_setup_ext() does not need to be called when
> > EC does not support FIFO, as there is no FIFO to manage.
> >
> > 3. Use devm_iio_triggered_buffer_setup_ext() when EC has a FIFO to
> > specify the buffer extended attributes.
>
> Sounds like three patches in one. Please, split and add proper Fixes
> tag(s) to each of them.

The code [at least] can be a single patch.
Albeit, it describes 3 different issues.

>
>
>
> --
> With Best Regards,
> Andy Shevchenko
