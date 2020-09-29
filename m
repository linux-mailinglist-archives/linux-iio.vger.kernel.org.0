Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79CC727CE94
	for <lists+linux-iio@lfdr.de>; Tue, 29 Sep 2020 15:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgI2NJU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Sep 2020 09:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728407AbgI2NJU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 29 Sep 2020 09:09:20 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D305CC061755;
        Tue, 29 Sep 2020 06:09:19 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id u24so3858823pgi.1;
        Tue, 29 Sep 2020 06:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tt6v4ga1/Mgn+EM+y48V+7TqXjsy9HI9GgagZAZOHWw=;
        b=DDgvQ+y5shVSCn0I9Gd0f6WGQ6jl//7KTJErMFo/3R5rlxhS92buZgWVNC4Fo4PmTb
         sKdYM7NJfm2jxzTqJM0zZSuNNKqU/KdDOfeaE7nbHmc/h6cxdMH1Y/4P2cGAPgdiYtZf
         43sCdHHkNSPeadh6BtsqlsaimhbW8crUtQhxJZTNsLZADdUHIKTS+ecbpi3HezNTep16
         Z0IlU0lJgjmYY61qZbT/5mI6qYMIkcXvG3qQDUI1BDR69ru75VatblTVjhGCPptaWN2J
         ZmHOe6dDap419lEKmf9xIgCWeq4R6hnJxjn3t5JQ+dkz3RFeNIVtVPmGPhfn0RjPLUv8
         3g2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tt6v4ga1/Mgn+EM+y48V+7TqXjsy9HI9GgagZAZOHWw=;
        b=r7KQ63vZi3psSd6vMZ5rM7f25ZyeB9Uy0sw8b0f+RRdQBC7JFzfpo6EQaVxM8NEQaY
         XqMEiUB31XxL4a5d/BUeBC1dJWebo9dJctntQWfuuJpFgc5r0mVZmegj6Eht7R738yYl
         rtSph8S8+k6E1CO1xiyJ+tI8p2dtaGvJaXPSA+mJixFm+a6n5usgC+70OTvrB40Nnq09
         FG/RO3wClowPNLSskPWxXrlw+HDh9QLQq0oX+Kgl3S4OxxOoD4naqFJ3HRMXUY1JWyRO
         3R1oUP8d72A+aaDxshbvVfSVQ7QT/XvaneOVVR4WZdcDJG+hY4sYxHx1+hYx1ksJQ+1a
         KEhQ==
X-Gm-Message-State: AOAM5333FGpg9p/qQ+jtDppwqPKOpK9oaR48n7hMMvsDhvKlNTNijd7z
        YuyLTK8F/IaqGBjrw+w3l15RyUw/LiqF5JVFcHY=
X-Google-Smtp-Source: ABdhPJwZ+hnhwZsFlvFVPou6fwcLZNuHUShBmnu8YDwqpKs2XLK2SW85n9ZWpUNNNZN60wEeaUWMYfslyv8eSimIVis=
X-Received: by 2002:a62:7b55:0:b029:13e:7367:2b2e with SMTP id
 w82-20020a627b550000b029013e73672b2emr3942657pfc.7.1601384959384; Tue, 29 Sep
 2020 06:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200929125949.69934-1-alexandru.ardelean@analog.com>
In-Reply-To: <20200929125949.69934-1-alexandru.ardelean@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 29 Sep 2020 16:09:00 +0300
Message-ID: <CAHp75VeQVEwtKGZcM6w=wfWuAvAD4xtveNUzT-7eXn5FVdheJQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] iio: remove iio_buffer_set_attrs() and assign
 buffer attrs during alloc
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        groeck@chromium.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Gwendal Grignou <gwendal@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Sep 29, 2020 at 3:55 PM Alexandru Ardelean
<alexandru.ardelean@analog.com> wrote:
>
> This is a v2 & v3 for [1]:
>   https://lore.kernel.org/linux-iio/20200925083743.46469-1-alexandru.ardelean@analog.com/
>
> It also includes a at91-sama5d2_adc cleanup patch in this series:
>   https://lore.kernel.org/linux-iio/20200924102902.136169-1-alexandru.ardelean@analog.com/
> This patch is required, in order to make the removal of
> iio_buffer_set_attrs() a bit cleaner in the at91-sama5d2_adc driver.
>
> Following the discussion from [1], this patchset implements the
> following:

Makes sense to me, FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenjko>

>
> Changelog v2 -> v3:
> * in patch 'iio: buffer: dmaengine: unwrap the use of iio_buffer_set_attrs()'
>   - minor stylistic change;
>
> Changelog v1 -> v2:
> * rename '{devm_}iio_triggered_buffer_setup()' ->
>          '{devm_}iio_triggered_buffer_setup_ext()'
>   - wrap with macros the new ext functions to preserve backwards
>     compatibility
>   - add a new parameter to the ext functions, which are the
>     buffer->attrs
> * split into separate patches the removal [from each driver] of
>   iio_buffer_set_attrs() and the switch to a
>   {devm_}iio_triggered_buffer_setup_ext variant
> * add patch to remove iio_buffer_set_attrs() from DMAEngine IIO buffer
> * remove the iio_buffer_set_attrs() helper in a final/separate patch
> * add 'at91-sama5d2_adc: merge buffer & trigger' patch in this series,
>   so that the removal of iio_buffer_set_attrs() is easier to view
>
> Alexandru Ardelean (9):
>   iio: buffer: dmaengine: unwrap the use of iio_buffer_set_attrs()
>   iio: adc: at91-sama5d2_adc: merge buffer & trigger init into a
>     function
>   iio: triggered-buffer: add {devm_}iio_triggered_buffer_setup_ext
>     variants
>   iio: accel: adxl372: use devm_iio_triggered_buffer_setup_ext()
>   iio: accel: bmc150: use iio_triggered_buffer_setup_ext()
>   iio: adc: at91-sama5d2_adc: use devm_iio_triggered_buffer_setup_ext()
>   iio: cros_ec: use devm_iio_triggered_buffer_setup_ext()
>   iio: hid-sensors: use iio_triggered_buffer_setup_ext()
>   iio: buffer: remove iio_buffer_set_attrs() helper
>
>  drivers/iio/accel/adxl372.c                   | 11 ++-
>  drivers/iio/accel/bmc150-accel-core.c         | 25 +++---
>  drivers/iio/adc/at91-sama5d2_adc.c            | 82 +++++++++----------
>  .../buffer/industrialio-buffer-dmaengine.c    |  3 +-
>  .../buffer/industrialio-triggered-buffer.c    | 31 ++++---
>  .../cros_ec_sensors/cros_ec_sensors_core.c    | 15 ++--
>  .../common/hid-sensors/hid-sensor-trigger.c   | 22 ++---
>  drivers/iio/industrialio-buffer.c             | 12 ---
>  include/linux/iio/buffer.h                    |  3 -
>  include/linux/iio/triggered_buffer.h          | 23 ++++--
>  10 files changed, 113 insertions(+), 114 deletions(-)
>
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
