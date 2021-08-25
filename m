Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD6AD3F707D
	for <lists+linux-iio@lfdr.de>; Wed, 25 Aug 2021 09:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbhHYHgu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Aug 2021 03:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239131AbhHYHgt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Aug 2021 03:36:49 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE988C061757;
        Wed, 25 Aug 2021 00:36:04 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id u11-20020a17090adb4b00b00181668a56d6so4097937pjx.5;
        Wed, 25 Aug 2021 00:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pZl4MA8IpSm1mSICNev7VaV9Xtg28JIhyQQPJFpXvAg=;
        b=TRqL9tOga8It+k+XaGYgWqp5U/Ioa/BZdXQGlwylG02BOGQnDn160f1zVs0aOWBr4B
         B81YTUSGOl1+vftPlmce3/oq6xbCFoqUSqwUOCfWHyaprZSodUeqVoEqeV0eoAvgByG+
         jjqsAE875T9o/TOVClBSqU68LRuQNSrLNSXCjcMqpqwObK8YX8FSg00mTsg60tRs90Sv
         Mfa4jZLeY8BIf7q0jTnKs/tCisX3rJxxwxICg3Laro60l1Jb6yeBYuQ7fAfHk0d0K7FN
         K8zuB7bmvv5wt1VR/SeVi2M54ZQ32FNSCkKE7LW6JFcIs3Uc5u0aojlyV9hbEiNcPe26
         wP9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pZl4MA8IpSm1mSICNev7VaV9Xtg28JIhyQQPJFpXvAg=;
        b=lF/sFULnEBwaoH57DIKBlFZGJRfIYVkwIgvSeYr0CUSQ6MamZzls+iY4aVHX/lmRLh
         JlaO5yqPsnPz60LDa7V4klr7prxVQXaj9RiNiRtf8bLhdWn3ik0UnegYK3p2gFyuv6p5
         RuLcB7Zo1qExLJUhSwuczrZn1SZNyxpWuPhtpuiS8m9YN5NHb7Y/ERmzqWWvvktc4Tlc
         W7W+OyEDjrRyF00eImaoZHjoGVa86sNoI/gIeoJAwne5kq0Y7YN9vS8tOk4vXaK52ezM
         3/V6aycbgFDP/zrbo+NlhyZRPwMJqyiQU1g5CLpMiSfbSl/TM7l0VEAhSx5yxl6qH/Hc
         AL9A==
X-Gm-Message-State: AOAM532O8ITcLD0TdkeM3lR3UHcYarvMw+OkUEXK2aout6PsDOOOKhv+
        2t51PjxV6iBDQbQj9uODPUrz5Kl3Rf7nb5eKBQg=
X-Google-Smtp-Source: ABdhPJw3J7jwZ0kP+TubMZaKIcnU5ZB5KfDlF615wpO1Q2xJaQIBe9JW29eHvWxNUfZUYiUxvzL0I61JWb+xsqKCC2s=
X-Received: by 2002:a17:90a:a382:: with SMTP id x2mr9268049pjp.86.1629876964248;
 Wed, 25 Aug 2021 00:36:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210820165927.4524-1-mihail.chindris@analog.com>
In-Reply-To: <20210820165927.4524-1-mihail.chindris@analog.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Wed, 25 Aug 2021 10:35:53 +0300
Message-ID: <CA+U=DsqfxUVJ6e_09wWBqP2XMgYrsq0ggOmgFWKzrru45oWZYQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] iio: Add output buffer support and DAC example
To:     Mihail Chindris <mihail.chindris@analog.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Aug 20, 2021 at 8:01 PM Mihail Chindris
<mihail.chindris@analog.com> wrote:
>

My only note about this series [as a whole] is that I would have
chosen an existing DAC to which to add kfifo output support.
To make things smooth for this new mechanism.

A new driver usually takes more effort to review/introduce than a
change to an existing one.

> Changelog v3 -> v4:
>   * https://lore.kernel.org/linux-iio/20210219124012.92897-1-alexandru.ardelean@analog.com
>   * Remove DMA related commits
>   * Test and add fixies to the previous version
>     - Add write function to iio_buffer_fileops in industrialiio-core
>     - In iio_kfifo_remove_from change number of samples to 1 instead of
>       r->bytes_per_datum otherwise n square samples are removed.
>     - In iio_buffer_remove_sample replace move buffer->access->write
>       check to first if an replace with remove_from. Checkpatch was
>       complaining about returning -ENOSYS
>   * Add ad3552r example
>
> Alexandru Ardelean (1):
>   iio: triggered-buffer: extend support to configure output buffers
>
> Lars-Peter Clausen (2):
>   iio: Add output buffer support
>   iio: kfifo-buffer: Add output buffer support
>
> Mihail Chindris (3):
>   Documentation:ABI:testing:add doc for AD3552R ABI
>   dt-bindings: iio: dac: Add adi,ad3552r.yaml
>   drivers:iio:dac: Add AD3552R driver support
>
>  .../ABI/testing/sysfs-bus-iio-dac-ad3552r     |   10 +
>  .../bindings/iio/dac/adi,ad3552r.yaml         |  185 +++
>  drivers/iio/accel/adxl372.c                   |    1 +
>  drivers/iio/accel/bmc150-accel-core.c         |    1 +
>  drivers/iio/adc/at91-sama5d2_adc.c            |    4 +-
>  .../buffer/industrialio-triggered-buffer.c    |    8 +-
>  drivers/iio/buffer/kfifo_buf.c                |   50 +
>  .../cros_ec_sensors/cros_ec_sensors_core.c    |    5 +-
>  .../common/hid-sensors/hid-sensor-trigger.c   |    5 +-
>  drivers/iio/dac/Kconfig                       |   10 +
>  drivers/iio/dac/Makefile                      |    1 +
>  drivers/iio/dac/ad3552r.c                     | 1419 +++++++++++++++++
>  drivers/iio/iio_core.h                        |    4 +
>  drivers/iio/industrialio-buffer.c             |  133 +-
>  drivers/iio/industrialio-core.c               |    1 +
>  include/linux/iio/buffer.h                    |    7 +
>  include/linux/iio/buffer_impl.h               |   11 +
>  include/linux/iio/triggered_buffer.h          |   11 +-
>  18 files changed, 1854 insertions(+), 12 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-dac-ad3552r
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
>  create mode 100644 drivers/iio/dac/ad3552r.c
>
>
> base-commit: 94a853eca720ac9e385e59f27e859b4a01123f58
> --
> 2.27.0
>
