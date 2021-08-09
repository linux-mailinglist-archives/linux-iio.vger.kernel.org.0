Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7243B3E4114
	for <lists+linux-iio@lfdr.de>; Mon,  9 Aug 2021 09:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbhHIHuf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Aug 2021 03:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233533AbhHIHue (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Aug 2021 03:50:34 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5362AC0613CF;
        Mon,  9 Aug 2021 00:50:13 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id m9so22353189ljp.7;
        Mon, 09 Aug 2021 00:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=xeQTd8WFfNiYHxuCQgb+lEPVNjpYB2abuY/bC8H0Mm8=;
        b=Y0Q6dOxaL9BLhnxssQNnKXDz4S1loz1rity1kFMZicbvND0S+U9AGuRLod+BgQJLYI
         JZBEai+lp0bQKjm6+p0M1vcQD/SbOSNO3LzwwUMBIfkEfGbBQx2al9yMccKBV+Sya2Qj
         lfCDSytZdnnSTJrliDpMjDQWWX1MGDL+JA4r3qcNSQk+NiDvLoIsvWspm1yxRbIBLqus
         bUUd5dF77k+iP9qIGiPkfoAOPMoWlZPQrH75VGTcKBaLUI6GmmIBV0RVexNQNKr8pBts
         uU9QnMGKK/LgkgEheBFPrEwCfa+yLl+Wyc1iVBXHxj9qMnoktVtjM0+ueoU3j9HuoInp
         ezyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=xeQTd8WFfNiYHxuCQgb+lEPVNjpYB2abuY/bC8H0Mm8=;
        b=U9pkSTTwrMBRVNjqto1BHb8f3tQ2REPmT2O20qczPZByyDTW+yT6XF86C9kYVFzSGb
         Xgb8Pi0nzrcMCvrcqJ3n6z9OkbHeXQ3pBqEXZBh3q5syDrfFxFqs3v0CS1/KYW7k4aLr
         vmpVoJLqIadc9L4ncN2tXEQZlP5OXCWjsRGe799k4gFBJAIGaU1pDkM4X0ju7lXJuVd+
         wP7xf8rRvLsq+2b/K3fh/wqUDtRJZNx/cz7Tx1FtSwceDwPTaDiTKNYd6ib2fh00wT58
         vm+pjgDBU4Ivpf6HuYF1ifYwxg0dzgKOX03NuBVbTLBhQn6i+5vSDd0ctY2MyoeXhJ7U
         ttLA==
X-Gm-Message-State: AOAM5311zXXJMQSKXqtFQ/OgG++45/miFrGhvCBu6xEDPDCklMzJhKRO
        vSPw8SR3AVnddBZ8kkINaO8T5C3a6xOjbDSAFxA=
X-Google-Smtp-Source: ABdhPJycu5aXMJNRQU9wK0uEgoATdntiITAi+qlSFNojJ2knwBQyRMAwFw/BPUh9xIHPRoHRuzhv9eLnPYIVvLiiGFE=
X-Received: by 2002:a05:651c:204e:: with SMTP id t14mr14263386ljo.40.1628495411677;
 Mon, 09 Aug 2021 00:50:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210809074512.34757-1-puranjay12@gmail.com>
In-Reply-To: <20210809074512.34757-1-puranjay12@gmail.com>
From:   Puranjay Mohan <puranjay12@gmail.com>
Date:   Mon, 9 Aug 2021 13:20:00 +0530
Message-ID: <CANk7y0gpTaf97=7PdK5xKxD276Jxxrf6uSsWyYRT=AyBOPtC4w@mail.gmail.com>
Subject: Re: [PATCH v9 0/2] iio: accel: add support for ADXL355
To:     "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        "Berghe, Darius" <Darius.Berghe@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Please Ignore this I will resend this properly.
I made some mistakes while sending the patches.
I am really sorry for the noise.

On Mon, Aug 9, 2021 at 1:15 PM Puranjay Mohan <puranjay12@gmail.com> wrote:
>
> Add the dt-bindings and the driver for ADXL355 3-axis MEMS Accelerometer.
>
> Changes since v8:
> 1. Make scale and offset defines inline and remove them.
> 2. Change dt-binding doc to state interrupt polarity only for DRDY pin.
> 3. Remove triggered buffer support from this patch series.
>
> Changes since v7:
> 1. Update MAINTAINERS to show all driver files.
> 2. Set CONFIGS for buffered support in Kconfig.
>
> Changes since v6:
> 1. Use interrupt-names property in device tree document.
> 2. Add triggered buffer support.
> 3. Use a static table for offset and data registers.
> 4. Fix coding style issues.
> 5. move defines from header to c file.
>
> Changes since v5:
> 1. Used get_unaligned_be24() and  get_unaligned_be16() to parse
> acceleration and temperature data. This solves sparse errors and also
> make the code more understandable.
>
> Changes since v4:
> 1. Fix errors reported by sparse.
>
> Changes since v3:
> 1. Fix errors in yaml DT doc.
> 2. Change SPDX-License-Identifier to GPL-2.0-only OR BSD-2-Clause
>
> Changes since v2:
> 1. Add separate DT binding doc in yaml.
> 2. Use ____cacheline_aligned buffer for regmap_bulk_read/write calls.
> 3. Make code consistent by using same style in switch case.
> 4. Use FIELD_PREP in place of custom macros.
> 5. Make Kconfig description more informative.
>
> Changes since v1:
> 1. Remove the declarations for static regmap structures from adxl355.h.
> This was missed in the v1 and caused errors.
> 2. Make switch case statements consistent by directly returning from
> each case rather than saving the return in a variable.
> 3. Some coding style changes.
>
> Changes since v0:
> 1. Move adxl355_hpf_3db_table to adxl355_data structure. This is done to make
> sure that each device gets its own table.
> 2. Make local regmap definitions private to adxl355_core.c.
> 3. Other minor coding style changes.
>
> Puranjay Mohan (2):
>   iio: accel: Add driver support for ADXL355
>   iio: accel: adxl355: Add triggered buffer support
>
>  MAINTAINERS                      |  10 +
>  drivers/iio/accel/Kconfig        |  33 ++
>  drivers/iio/accel/Makefile       |   3 +
>  drivers/iio/accel/adxl355.h      |  19 +
>  drivers/iio/accel/adxl355_core.c | 676 +++++++++++++++++++++++++++++++
>  drivers/iio/accel/adxl355_i2c.c  |  65 +++
>  drivers/iio/accel/adxl355_spi.c  |  67 +++
>  7 files changed, 873 insertions(+)
>  create mode 100644 drivers/iio/accel/adxl355.h
>  create mode 100644 drivers/iio/accel/adxl355_core.c
>  create mode 100644 drivers/iio/accel/adxl355_i2c.c
>  create mode 100644 drivers/iio/accel/adxl355_spi.c
>
> --
> 2.30.1
>


-- 
Thanks and Regards

Yours Truly,

Puranjay Mohan
