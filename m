Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDB403ED0DE
	for <lists+linux-iio@lfdr.de>; Mon, 16 Aug 2021 11:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234721AbhHPJKP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Aug 2021 05:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233053AbhHPJKP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Aug 2021 05:10:15 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B706C061764;
        Mon, 16 Aug 2021 02:09:44 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id hv22-20020a17090ae416b0290178c579e424so26405826pjb.3;
        Mon, 16 Aug 2021 02:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VPGedwvnCei+6xmV2jyY7egHgphSukXbhhMKxVkL/KM=;
        b=sYF9vOyRt5AZCqqykOv3ZbYGe/cETGsqJ2Sc82f8ExNAXrlyyYtQsHLDbC0SlVJw+O
         XpERn2Dy7GsYa1BrUsnF29TV47vchrb+jRMKSEcQf+b/ZdbXtOIAV90K8/VnTYPMscMB
         a9IAapXx7+R05LYHTbi4DXmf3iDNkBFd8Brhqu7II6NiRfWeUb6kGoMGzCa97VoM4rKr
         JYCtiyBVfJzEF4AIOzAVxEpKfG6YaEJUneCjvswA/U/HNJRgfsjD6Ih5f+fOLAoi5T4a
         DCVOK5WbIY7cotZKMnNDjoT26AazmMjX0YSgRINaJ2RneLVYDd8KIYwYMQw0Nq2OjkAI
         9ZOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VPGedwvnCei+6xmV2jyY7egHgphSukXbhhMKxVkL/KM=;
        b=S/0Zi2ufaXlTfzRBeXoESug1+VzonXkJ8WtVtERWsESH3I/x/u3RLsq3KSsB0Umq7T
         8awH1c+LKoiJymowS691G5YfE4P3ArnASAWCB/8t3SMAcqrdEkh7mlPw9IcA9oBQe7Cg
         W2trTZaXZWYBHz5esjkAljiaDVSEASeyOeuPb2It1GESIMhMbU2tCiKeiF9a4s89Lxf6
         g88xFM6OkvCvA2m3hUiV0HJjjuESEjAE2aJcadj2KzgZJ0kPMAVJac+9vh/nrij/MBTw
         15jVktwY2QzER7F+eUn7EUCSR5We7B3SrVHi0GsXcZw+Expb4a5jVQnx2gf4ehY62hUI
         3suQ==
X-Gm-Message-State: AOAM530Iah5SM7grPWS3M3eV1DUKzppKK3bDw0XdeFckpxzfU+IXMRnq
        yET0YuVUF7jliPXThVf7eaB/ofboFweB99mfMFo=
X-Google-Smtp-Source: ABdhPJw+wb22Sx2hYIVb5pjxjPajLnJeqs42mh+QxbOEDRjTujJScmbcVUOHpinYq7T463VfkskGvMQDKHt3rYWXDvw=
X-Received: by 2002:a63:cf0a:: with SMTP id j10mr15211364pgg.4.1629104983812;
 Mon, 16 Aug 2021 02:09:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210816082836.67511-1-aardelean@deviqon.com>
In-Reply-To: <20210816082836.67511-1-aardelean@deviqon.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 16 Aug 2021 12:09:04 +0300
Message-ID: <CAHp75VecnBiMLie2ki7--c9YgiZrknhLb-TSOjSAVKXy+ZpxYQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] iio: st_sensors: convert probe functions to full devm
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Denis Ciocca <denis.ciocca@st.com>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 16, 2021 at 11:30 AM Alexandru Ardelean
<aardelean@deviqon.com> wrote:
>
> Changelog v1 - v2:
> * https://lore.kernel.org/linux-iio/20210726071404.14529-1-aardelean@deviqon.com/
> * added patch 'iio: st_sensors: disable regulators after device unregistration'
>   - splits the regulator disable fix in a separate patch

Entire series makes sense to me, thanks!
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Alexandru Ardelean (5):
>   iio: st_sensors: disable regulators after device unregistration
>   iio: st_sensors: remove st_sensors_deallocate_trigger() function
>   iio: st_sensors: remove st_sensors_power_disable() function
>   iio: st_sensors: remove all driver remove functions
>   iio: st_sensors: remove reference to parent device object on
>     st_sensor_data
>
>  drivers/iio/accel/st_accel_core.c             | 32 +++--------
>  drivers/iio/accel/st_accel_i2c.c              | 23 +-------
>  drivers/iio/accel/st_accel_spi.c              | 23 +-------
>  .../iio/common/st_sensors/st_sensors_core.c   | 34 ++++++------
>  .../iio/common/st_sensors/st_sensors_i2c.c    |  1 -
>  .../iio/common/st_sensors/st_sensors_spi.c    |  1 -
>  .../common/st_sensors/st_sensors_trigger.c    | 53 +++++++------------
>  drivers/iio/gyro/st_gyro_core.c               | 27 ++--------
>  drivers/iio/gyro/st_gyro_i2c.c                | 23 +-------
>  drivers/iio/gyro/st_gyro_spi.c                | 23 +-------
>  drivers/iio/imu/st_lsm9ds0/st_lsm9ds0.h       |  1 -
>  drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c  | 17 +-----
>  drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c   |  6 ---
>  drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c   |  6 ---
>  drivers/iio/magnetometer/st_magn_core.c       | 29 ++--------
>  drivers/iio/magnetometer/st_magn_i2c.c        | 23 +-------
>  drivers/iio/magnetometer/st_magn_spi.c        | 23 +-------
>  drivers/iio/pressure/st_pressure_core.c       | 27 ++--------
>  drivers/iio/pressure/st_pressure_i2c.c        | 23 +-------
>  drivers/iio/pressure/st_pressure_spi.c        | 23 +-------
>  include/linux/iio/common/st_sensors.h         | 13 -----
>  21 files changed, 60 insertions(+), 371 deletions(-)
>
> --
> 2.31.1
>


-- 
With Best Regards,
Andy Shevchenko
