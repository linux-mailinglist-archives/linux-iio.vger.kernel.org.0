Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEC034F8FC
	for <lists+linux-iio@lfdr.de>; Wed, 31 Mar 2021 08:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233806AbhCaGpj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 31 Mar 2021 02:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233880AbhCaGpS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 31 Mar 2021 02:45:18 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45AAEC06174A
        for <linux-iio@vger.kernel.org>; Tue, 30 Mar 2021 23:45:18 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id r193so19010572ior.9
        for <linux-iio@vger.kernel.org>; Tue, 30 Mar 2021 23:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zAU4lpC/qgUv8RGdb0dyG3G2BMUyD6VWcJk/lVJtLC0=;
        b=KtGU3RJU6W1DnGFjEmlw9/uVwG64vlUSvEVX35OJchD3HyPGXiU5rVfNHXBSkR9NOp
         yfDYtYL2jZDgjMv02JfbTvJaBEAgzF0zyeftEJ9y8F3lF/g5uOxACzaPd+9h5jfkN4R+
         qSAdtQ96tXTAQPM/BaUW75LFrAP6SZ4IltZ0AIR2+Giko4fHK+kGCOrqDe6FerpDgw3y
         P2As8uty7f4h117tGOe4AVCLiHL0EN1h4hWcWveRCokf2ZUuOY/GmJ1+nVevtZCX/kjd
         mst3WWvGuhenAmTMpVbSy1TgW2IDGEMliaxTFKYYC0VuMu2lzVRkvNMmPkAVQ4kXz2PD
         iDmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zAU4lpC/qgUv8RGdb0dyG3G2BMUyD6VWcJk/lVJtLC0=;
        b=DaKkIYSWab1e4MUJM0XD8Kq2R1a8xOrA9vLX7i78vaf6GTRLY3iBUXWe/6+iTfOEGw
         YuDNgXVEfgwCqhiTJfjnUnTH1buErVSigXamk8hLyIPIRBX4VcUkK8WlNRp/5VFB6p86
         GVlc7hIRFybrvfx7uHhkdeiIuOqJo+LynQbH8n8CNWDkGKLolsQ6rZ6JAxZ4qYlUFlTO
         er7ME47/zfB6tZxj+dCZQEbzZjOtCUlRrDwuj/CD21VCo9kvzGI4mVnI7WA3Zv7FE71T
         UiF+S2a3kcjVuxEJP/gApXkiykSmHDaCW/3gJlr/Tu9Ahr6nkRRPZ75v0i9vrzYvWHeI
         eNGw==
X-Gm-Message-State: AOAM532tqWsGl4ZXu7c35KW8XjpKZZgZqaDXnaHgfDafGQWYE/lzx9pf
        Q7Qr1ra/3KRKfBRwrNCFHqtqoJsd5DS/SFYeOn6V4DSmvLs=
X-Google-Smtp-Source: ABdhPJx8URdLtF0vFJH49Yak2romzA4K1+FEwJTJ6CaSoWeFD1Z6TPzq2DDfRqB6t5+CNccO5R1YzqTr338ysrdFXto=
X-Received: by 2002:a6b:7b05:: with SMTP id l5mr1264301iop.32.1617173117728;
 Tue, 30 Mar 2021 23:45:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210314181511.531414-1-jic23@kernel.org> <20210314181511.531414-22-jic23@kernel.org>
In-Reply-To: <20210314181511.531414-22-jic23@kernel.org>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Wed, 31 Mar 2021 09:45:06 +0300
Message-ID: <CA+U=DsqicqBsRitxuSCPrcrpPsomNV0dyVkf_wgs-JLj-BYZww@mail.gmail.com>
Subject: Re: [PATCH v2 21/24] iio:Documentation:ABI Add missing elements as
 used by the adi,ad7150
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Rob Herring <Robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Mar 14, 2021 at 8:18 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Main additions are around thresh_adaptive.  This has been supported
> by the core of IIO for a long time, but no driver that uses it has
> previously graduated from staging, hence we are missing Docs.
>
> Otherwise, just new entries in existing lists.
>

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Link: https://lore.kernel.org/r/20210207154623.433442-23-jic23@kernel.org
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 33 +++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index affd4ce871d7..32d26c118141 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -371,6 +371,7 @@ What:               /sys/bus/iio/devices/iio:deviceX/in_humidityrelative_offset
>  What:          /sys/bus/iio/devices/iio:deviceX/in_magn_offset
>  What:          /sys/bus/iio/devices/iio:deviceX/in_rot_offset
>  What:          /sys/bus/iio/devices/iio:deviceX/in_angl_offset
> +What:          /sys/bus/iio/devices/iio:deviceX/in_capacitanceX_offset
>  KernelVersion: 2.6.35
>  Contact:       linux-iio@vger.kernel.org
>  Description:
> @@ -702,6 +703,8 @@ What:               /sys/.../iio:deviceX/events/in_voltageY_thresh_falling_en
>  What:          /sys/.../iio:deviceX/events/in_voltageY_thresh_either_en
>  What:          /sys/.../iio:deviceX/events/in_tempY_thresh_rising_en
>  What:          /sys/.../iio:deviceX/events/in_tempY_thresh_falling_en
> +What:          /sys/.../iio:deviceX/events/in_capacitanceY_thresh_rising_en
> +What:          /sys/.../iio:deviceX/events/in_capacitanceY_thresh_falling_en
>  KernelVersion: 2.6.37
>  Contact:       linux-iio@vger.kernel.org
>  Description:
> @@ -779,6 +782,32 @@ Description:
>                 a given event type is enabled a future point (and not those for
>                 whatever event was previously enabled).
>
> +What:          /sys/.../events/in_capacitanceY_adaptive_thresh_rising_en
> +What:          /sys/.../events/in_capacitanceY_adaptive_thresh_falling_en
> +KernelVersion: 5.11
> +Contact:       linux-iio@vger.kernel.org
> +Descrption:
> +               Adaptive thresholds are similar to normal fixed thresholds
> +               but the value is expressed as an offset from a value which
> +               provides a low frequency approximation of the channel itself.
> +               Thus these detect if a rapid change occurs in the specified
> +               direction which crosses tracking value + offset.
> +               Tracking value calculation is devices specific.
> +
> +What:          /sys/.../in_capacitanceY_adaptive_thresh_rising_timeout
> +What:          /sys/.../in_capacitanceY_adaptive_thresh_falling_timeout
> +KernelVersion: 5.11
> +Contact:       linux-iio@vger.kernel.org
> +Descrption:
> +               When adaptive thresholds are used, the tracking signal
> +               may adjust too slowly to step changes in the raw signal.
> +               *_timeout (in seconds) specifies a time for which the
> +               difference between the slow tracking signal and the raw
> +               signal is allowed to remain out-of-range before a reset
> +               event occurs in which the tracking signal is made equal
> +               to the raw signal, allowing slow tracking to resume and the
> +               adaptive threshold event detection to function as expected.
> +
>  What:          /sys/.../events/in_accel_thresh_rising_value
>  What:          /sys/.../events/in_accel_thresh_falling_value
>  What:          /sys/.../events/in_accel_x_raw_thresh_rising_value
> @@ -819,6 +848,10 @@ What:              /sys/.../events/in_proximity0_thresh_falling_value
>  What:          /sys/.../events/in_proximity0_thresh_rising_value
>  What:          /sys/.../events/in_illuminance_thresh_rising_value
>  What:          /sys/.../events/in_illuminance_thresh_falling_value
> +What:          /sys/.../events/in_capacitanceY_thresh_rising_value
> +What:          /sys/.../events/in_capacitanceY_thresh_falling_value
> +What:          /sys/.../events/in_capacitanceY_thresh_adaptive_rising_value
> +What:          /sys/.../events/in_capacitanceY_thresh_falling_rising_value
>  KernelVersion: 2.6.37
>  Contact:       linux-iio@vger.kernel.org
>  Description:
> --
> 2.30.2
>
