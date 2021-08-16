Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52CC53EE017
	for <lists+linux-iio@lfdr.de>; Tue, 17 Aug 2021 00:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbhHPWuz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Aug 2021 18:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbhHPWuy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Aug 2021 18:50:54 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F5EC061764
        for <linux-iio@vger.kernel.org>; Mon, 16 Aug 2021 15:50:21 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id y6so12955663lje.2
        for <linux-iio@vger.kernel.org>; Mon, 16 Aug 2021 15:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FNF5yTfl26yRV2ZnsuQAzfTJ86jyXsPYWOJul2CIIxA=;
        b=oDjyNYYpKlqJROuUn6VAmXIcYHiu6KQoGMGqHi3LT/irIYzgdbpbgayMX522y/+rd/
         jnHlAxW6jlIvUp6V+6fvpzHR4DETHRN8cH/swJifdTkk6BsMWKFMWWMotDhKQOOKU3PC
         iMUf55Iq5l7WJvdXq+WVb3ngr23evdvduoWLIYk2prD0RbgKiMADcl3Xpb4cSyV9WjLa
         mbAVTODa66G8a4RNboLzF3QI9emyb2cF6Auk+NLtkwzknbBOV+j2d+eJAtfwbqsbVNL/
         6T3B/93fPiq/Mst3eXuYNImGCpN1chnz0zkiPNxsIyQ9HpUuxdm7gVAJ63J9+o8fVWaV
         jHTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FNF5yTfl26yRV2ZnsuQAzfTJ86jyXsPYWOJul2CIIxA=;
        b=GHwBWaYhIGHUkRxkvTML70zO/pVoJh5JsM3nIwjUrGv+cPYhzgaue9WZcCsJz7n0ix
         nmkBugYkGEgKqjnqwxVVNwABpAm8U779QACGVk7Vnnpl7t8esUeebhU40O95sjpFZmcx
         p42vi49XJxD7AHHeB91P2U9Ciwjoz4tJlAirA0JtQ0O7+73tyLTccE1ARo1si1k+/LO3
         9V8ozL9UWBmZNhxRtXPz+sm4773WJ6XUccIKPRcLRujUAacuWnwKnhY34oZ9ZL3HFYZL
         G6m+jgwynIqSVTljSg8oTyUzO1oucsdL5qHvibSnsN/q8wBBibfGl/P2RnxfoRHg9Vr/
         uDzg==
X-Gm-Message-State: AOAM532Lom4OerHSbBeMTJO5oM/2z0QcYmcsiQUw0NwTHxAQot0xN4dj
        Z4gHCmm0XaMdvUGtDOyHzPRhDeDc9OS8r4riFg9LZA==
X-Google-Smtp-Source: ABdhPJwejuMKkXaC6E+32YRGzv21MU1jcY2Mzp8d92kWVWOhvV+9Vcw6sn8yIbSQqLqlZjHqEqrw0wI296H4Er0NMxE=
X-Received: by 2002:a05:651c:1507:: with SMTP id e7mr463144ljf.368.1629154215340;
 Mon, 16 Aug 2021 15:50:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210816082836.67511-1-aardelean@deviqon.com> <20210816082836.67511-2-aardelean@deviqon.com>
In-Reply-To: <20210816082836.67511-2-aardelean@deviqon.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 17 Aug 2021 00:50:04 +0200
Message-ID: <CACRpkdaYLd=R9SjqLF=j94fjbG-urHW6C6rXJ3oGnJM9W78P4g@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] iio: st_sensors: disable regulators after device unregistration
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Denis CIOCCA <denis.ciocca@st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 16, 2021 at 10:30 AM Alexandru Ardelean
<aardelean@deviqon.com> wrote:

> Up until commit ea7e586bdd331 ("iio: st_sensors: move regulator retrieveal
> to core") only the ST pressure driver seems to have had any regulator
> disable. After that commit, the regulator handling was moved into the
> common st_sensors logic.
>
> In all instances of this regulator handling, the regulators were disabled
> before unregistering the IIO device.
> This can cause issues where the device would be powered down and still be
> available to userspace, allowing it to send invalid/garbage data.
>
> This change moves the st_sensors_power_disable() after the common probe
> functions. These common probe functions also handle unregistering the IIO
> device.
>
> Fixes: 774487611c949 ("iio: pressure-core: st: Provide support for the Vdd power supply")
> Fixes: ea7e586bdd331 ("iio: st_sensors: move regulator retrieveal to core")
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Denis CIOCCA <denis.ciocca@st.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>

That's a valid concern I suppose:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

But as it now occurs last before return 0, can't we just solve
this with a
devm_add_action_or_reset(dev, st_sensors_power_off_action, *);
of some kind and let devres handle it?

c.f
drivers/input/touchscreen/cy8ctma140.c

Yours,
Linus Walleij
