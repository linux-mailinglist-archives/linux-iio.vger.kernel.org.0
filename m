Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF3D19F3FF
	for <lists+linux-iio@lfdr.de>; Mon,  6 Apr 2020 13:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgDFLBB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Apr 2020 07:01:01 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:50485 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbgDFLBB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Apr 2020 07:01:01 -0400
Received: by mail-pj1-f68.google.com with SMTP id v13so6344311pjb.0
        for <linux-iio@vger.kernel.org>; Mon, 06 Apr 2020 04:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a3e1oG7BVTkkEYtq08KL6YRQHlTlehdvw0EJoQm2H8M=;
        b=X0DWE8ICJG4qoMh1iYv5EcoJlPcrlkFz+B/kOz1zshBZ89G3Gy1PtM7EoTLwNbW5jm
         0Lc85/d1Hz5OweeGzSulyuS0A5VgNbTi/kIwYCO9s9Y4P75pl4PcAEbFdeqiJt68aldi
         6+CFdGwnEBVNRX32HMJUfBpZuW+QrhT4HupKBNGhySldUF/0e8QAawaH6hqRCWHoGjYZ
         DPkITUEHhv1KTIqnTq+JWDqkDglyLt+BvMO6p76eOWfNwe3WtjkwZwacB70ZyStoJB2H
         I4aYWfgRhfGyCvonEdVUOlSPUT3HZyp8PtTJrntsFay+oNbkugnHf17G3SHNbDceWtX2
         aK2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a3e1oG7BVTkkEYtq08KL6YRQHlTlehdvw0EJoQm2H8M=;
        b=rPpOrVEaugyofqh0s72FN/pwQW6RKGCzhV1Mrm4w4fFD1QIAYhn66HBEGKYMEPSfed
         7sqmc7NtdVbLMmecPItE3h9n5/tLGzfFHzniNHqWBcLWAvbAskF4iOU++9EYbd/vrN49
         Dn6g732bM/bb8Qn5sh9hQT2iBaH1DKDCJ9uj0j+/PtQo5eM+g9v9npVtr1CCI9mcepw8
         zE2AgytGCpzdCKLJLbV7Ui87VibJxV2k3u6TyLLx3tJhll18Mv8oAchbifvff+O8lNh3
         rGjgyIS9pcOgV+b60uioAuM7yeDvwUgKYGIF0ttyJrFQS6WgHA9EMbAwiH7LbK4ZWn2n
         dR3w==
X-Gm-Message-State: AGi0PuYvJAt9TqyUPOqVxntM3ibMdk5NHXe7GeJhxzMrfJrgF8s3pQb+
        RTE+epG6jqkYeZ+tDQ69hKbr2IKXr3J2mSBTfLQ=
X-Google-Smtp-Source: APiQypIgLSj/5gIzH0O6woYbL1Jgx5/QsUGJDWJu9Ww+EHvll7VTDaE180llXM8GYMNVJBb7ChArS9u0Lu8UesV/zHE=
X-Received: by 2002:a17:90a:e982:: with SMTP id v2mr26179608pjy.1.1586170860595;
 Mon, 06 Apr 2020 04:01:00 -0700 (PDT)
MIME-Version: 1.0
References: <8593125b207045797adb9406aa2d3d2f43c30153.1586170271.git.lorenzo@kernel.org>
In-Reply-To: <8593125b207045797adb9406aa2d3d2f43c30153.1586170271.git.lorenzo@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 6 Apr 2020 14:00:53 +0300
Message-ID: <CAHp75VcqZ_VDD69wToo6LQqsawkEA_oPFQanSoFOT1gSgOrXZQ@mail.gmail.com>
Subject: Re: [PATCH v2] iio: imu: st_lsm6dsx: drop huge include in sensor-hub driver
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        lorenzo.bianconi@redhat.com,
        Jimmy Assarsson <jimmyassarsson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Apr 6, 2020 at 1:52 PM Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>
> st_sensors.h contains common stm sensor definitions but in

> st_lsm6dsx_shub driver it is used just to introduce the default

Still doesn't fully clear why only this part of the st_lsm6dsx is not
okay with the header.
You need to explain that common/st_sensors is for separate ST sensor
drivers, while LSM6DSx is a driver for certain IMU which *does not*
use ST common infrastructure.

> wai address for LIS3MDL sensor.
> Drop this largely unconnected include and introduce the default wai
> address in st_lsm6dsx_ext_dev_settings register map
>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
> Changes since v1:
> - improve commit message
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> index 280925dd8edb..947ca3a7dcaf 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> @@ -28,7 +28,6 @@
>  #include <linux/iio/sysfs.h>
>  #include <linux/bitfield.h>
>
> -#include <linux/iio/common/st_sensors.h>
>  #include "st_lsm6dsx.h"
>
>  #define ST_LSM6DSX_SLV_ADDR(n, base)           ((base) + (n) * 3)
> @@ -93,7 +92,7 @@ static const struct st_lsm6dsx_ext_dev_settings st_lsm6dsx_ext_dev_table[] = {
>         {
>                 .i2c_addr = { 0x1e },
>                 .wai = {
> -                       .addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
> +                       .addr = 0x0f,
>                         .val = 0x3d,
>                 },
>                 .id = ST_LSM6DSX_ID_MAGN,
> --
> 2.25.1
>


-- 
With Best Regards,
Andy Shevchenko
