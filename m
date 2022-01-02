Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDDA482A63
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jan 2022 08:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbiABHCh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Jan 2022 02:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiABHCg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jan 2022 02:02:36 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45056C061574
        for <linux-iio@vger.kernel.org>; Sat,  1 Jan 2022 23:02:36 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id x6so15847978lfa.5
        for <linux-iio@vger.kernel.org>; Sat, 01 Jan 2022 23:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tvv0DgV9NgQ98HHlvA9A23WiX/m5Ked1q7rAcv1JoHI=;
        b=FgxbBkHr4ssahA/LRHFCPhZGIzGGh1341x5GTN/imnarLCCW4gGvqu2iXqbXg5m98o
         9k5PH/+9+Fdsg0V6Ttl4BoYb2rYkpXbxTAQYaCiRZrFOXXPakp70wO/1ix5QvBk0D4/V
         qui1GWGTszsMzRAe6VYNzhquU4sW+OLZEdRR2rJfTcun2rXIGWIQAVu+cMgT8pvael1K
         FUeGabpXt8suJQnA8g5VlOhUzFSNAQ1rs6eH1DePr7thrCTh7vWuZjnTAVy3ceNlK31E
         xUj3kvapPgj0YjumCo0S+uCHy0EV0rBmo651gqIwtQ7dVkoILjsQD1NhEUnSo7AlmGpB
         iCcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tvv0DgV9NgQ98HHlvA9A23WiX/m5Ked1q7rAcv1JoHI=;
        b=vXZkwCNJiwnDMDPasr5SHcoYXjfwQ1O2FFc+5/f+6UB7u81BlYX+7a+a9QC3oc1/98
         0ZWJKPSrSH2dGro1dxxMVcCvfBoy2t/NtCEWbK6UAjmsC8Y4gjnGGlF3Ir+dWKuesV5y
         z7za92KTPzTy0Y4RCYXlhPx2ECMZODyhYLariFGPBzGirX5IC759eSYnXXuuh9EczvAz
         MyNzdIDmMt8jD3Z6PTXo6TlGPkgDlPbiRU/O/q5x54zUlMO7qLJ/qIzd/GBrSzba2sML
         mHr9uiFNoQuzPb80LuzH27CtmOH6wbkV70dyl2yXz0nFMHVmK3+kP3IVbTkMDMARQhPb
         5goQ==
X-Gm-Message-State: AOAM5339rNE849STgzlUHmy3wsKbm2roR76rfVCaq96bolkJSer9O9Ph
        4RLdZCS8okM9WcERZctYIFDXI3OsqJC2JC/L7eLI7g==
X-Google-Smtp-Source: ABdhPJxOYkFHnmRn3PYBTBsgCRCoJd7PFWfeRGQ56+8AZELiRbmsztgXlZvIJs8EwHLTIxk38f21bTkC+UzdQ7Xg7Nk=
X-Received: by 2002:a05:6512:750:: with SMTP id c16mr37738865lfs.622.1641106954440;
 Sat, 01 Jan 2022 23:02:34 -0800 (PST)
MIME-Version: 1.0
References: <20211229072916.2567155-1-nikita.yoush@cogentembedded.com>
In-Reply-To: <20211229072916.2567155-1-nikita.yoush@cogentembedded.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 2 Jan 2022 08:02:21 +0100
Message-ID: <CACRpkdYcR7SA1bfzAtMBpXZiXZeZnV8hWGddx26VvvKwiZC4Sw@mail.gmail.com>
Subject: Re: [PATCH] iio: stm: don't always auto-enable I2C and SPI interface drivers
To:     Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Cai Huoqing <caihuoqing@baidu.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Dec 29, 2021 at 8:29 AM Nikita Yushchenko
<nikita.yoush@cogentembedded.com> wrote:

>  config IIO_ST_ACCEL_I2C_3AXIS
> -       tristate
> -       depends on IIO_ST_ACCEL_3AXIS
> -       depends on IIO_ST_SENSORS_I2C
> +       tristate "STMicroelectronics accelerometers 3-Axis I2C Interface"
> +       depends on (I2C && IIO_ST_ACCEL_3AXIS)
> +       default y if (I2C && IIO_ST_ACCEL_3AXIS)
> +       select IIO_ST_SENSORS_I2C

This thing that a Kconfig symbol is made to depend on itself just
boggles my head but it wouldn't surprise me if KConfig is this weird :(

I CCed Arnd who knows KConfig a bit better than anyone I know.

Yours,
Linus Walleij
