Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C48EF3D5425
	for <lists+linux-iio@lfdr.de>; Mon, 26 Jul 2021 09:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbhGZGkQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Jul 2021 02:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbhGZGkP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Jul 2021 02:40:15 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FFEC061757;
        Mon, 26 Jul 2021 00:20:44 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id z7so9757309wrn.11;
        Mon, 26 Jul 2021 00:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8tWhQCl1p8bzV21p6F+aEhldPxkV5yakQenolKk9Fjk=;
        b=KGKxq0qzpRqdLkRZKwiF6sYC6KA0ZWB4eKk5hi8spunEUcdlPvlGI0+MU0Ic3BTbG2
         sWfEVTMG4/+y3W2ActepUxwMgC1BKkUVdkOdGnZSiHJeLKc1M5UhW+T7I+sIf6Mennm9
         Uxj8L0gpuSYiZ04FYf+l1QMlIHPUGlsRE+uCgj2rdXKj4YV+ucTixA1eOqQDkJ+PCYef
         H17mxLPwSjFIKRTyFxUJlJz5avAxusg0OVurhUgV9ggMYsNgFIjpdXRnUL8ry2yfhkNz
         /Bcn5YprnpdIu82OONatZlvqGkPd8qBO1tl0I0ifBuhmRiNpKFUe1zWwnRFokAVINqiM
         qBgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8tWhQCl1p8bzV21p6F+aEhldPxkV5yakQenolKk9Fjk=;
        b=cNwMjRKY7UxHLjH5eH/7GPHa5VO6knkNlAKPq4KJ/TmgmeuAjJKobxZd8vy7rnBAu0
         6ofAQfVfNVRGE5grw5hI2wPpmSkeTrxL5xCncDrmSMANmQBX8uQ0fmXFnDnyoYQY4XY0
         W5LqIHbEvLiyI0ygkIAmqvvCn3VZHNH7UV7peGkngAU2s2ZxBw+Qun45hREap71bCBC2
         fig0tIICBbKbAMpZS9FKsR6dhLtClI9s9GNmrlngRJcJ+oTdrTz+K2AcTu49ST8CoF5A
         WC3xq8B0qiZwmddj8cqXhMeWb2PZpO35DwE8Y2QSr+n+fxrHjncI6e5vF0YNJbx6q74o
         YV9g==
X-Gm-Message-State: AOAM5306fA5XylvIojfjcqq2OijH6abpDLsFEGbTD8GLKfL6/NJmvlu6
        woRRAsIUBKMLOzYHmBNhbwkgBNuixRwVl49RZyY=
X-Google-Smtp-Source: ABdhPJzzHfCObM0RO4SmDyRgvI92f5m46W/D5TkCtAqA/JzUZaTRTC4Kqpj0bIzFejI7oNbm2ipoeCqdZ+zGtOwOePM=
X-Received: by 2002:adf:ec0c:: with SMTP id x12mr18281237wrn.113.1627284043603;
 Mon, 26 Jul 2021 00:20:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210726071404.14529-1-aardelean@deviqon.com> <20210726071404.14529-4-aardelean@deviqon.com>
In-Reply-To: <20210726071404.14529-4-aardelean@deviqon.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 26 Jul 2021 10:20:07 +0300
Message-ID: <CAHp75Vem3Q5vRknvWrZSsX4_+2j7fGtU6RcLzCHEr2AA67eZfA@mail.gmail.com>
Subject: Re: [PATCH 3/4] iio: st_sensors: remove all driver remove functions
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Denis Ciocca <denis.ciocca@st.com>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jul 26, 2021 at 10:14 AM Alexandru Ardelean
<aardelean@deviqon.com> wrote:
>
> At this point all ST driver remove functions do iio_device_unregister().
> This change removes them from them and replaces all iio_device_register()
> with devm_iio_device_register().
>
> This can be done in a single change relatively easy, since all these remove

easily

> functions are define in st_sensors.h.

defined

>  drivers/iio/imu/st_lsm9ds0/st_lsm9ds0.h      |  1 -
>  drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c | 15 +--------------
>  drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c  |  6 ------
>  drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c  |  6 ------

I will check these later on, but the rule of thumb about devm_*() is
that there shouldn't be gaps (non-devm) before any devm call.

-- 
With Best Regards,
Andy Shevchenko
