Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A443E37095C
	for <lists+linux-iio@lfdr.de>; Sun,  2 May 2021 01:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbhEAX7X (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 May 2021 19:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbhEAX7X (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 May 2021 19:59:23 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F81C06174A
        for <linux-iio@vger.kernel.org>; Sat,  1 May 2021 16:58:33 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id a11so1326187ioo.0
        for <linux-iio@vger.kernel.org>; Sat, 01 May 2021 16:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5UvbDl5/DX2Tgh6k2ItbL//52C66Wmx7Ujv/3uKvGAM=;
        b=Y739HG5dXkW4yS9+HNKUsUVFAiW9YuT570fjPe9dXeLt2KA06VKmEHea3Cb8r3Jht9
         L2R6jnxSz3WOeDKy0MLP3UTVQQH9XgqxMayBcnzddwfyckFNURDKZ06c8ZjjwnzKTpFE
         Wywq/aKqR0eqarmvLoGW9g5XOfOHRQ5q1njrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5UvbDl5/DX2Tgh6k2ItbL//52C66Wmx7Ujv/3uKvGAM=;
        b=ZIToK7+2RtUQaJwxh4WQM0KPpjytcz+pRXcU8Mj7zwgJJJoHl7K59Hm3TWPiBHLSrM
         IPZlbVF5s7Y9knu/Z69C014WY0kKilj+1+iRGxtmTcsuy0Ch/+6c+l0Rrw5+g22+q5lf
         u5QkYVCn3XEbpW6NFpWzW3eIsb69wpKH/dWFLQO1CsqXBvipueVLwPGF2xgP7dIAzBx1
         CHM+YvYgpE1wFQvuIbP86DVQjNnOsZdXtHWlgY1ThVp7gG/lRlQdso3s+y9CVWfkU18t
         /DFWUvrSLnBxLo/6z9R7TgWU58tiixCL3V8XNngdYm3BpszXPbjrE4jj18trKa/STRWY
         u1pA==
X-Gm-Message-State: AOAM5338zU8G64ujLJmnnzTI6e6XyQIx9YPz/Czywo4k0iPj4JRzkvRz
        gm3+509yuOK24PjQUwXXpg5Y1M/1H7dD/Uk8pa43UjAbI2DHBw==
X-Google-Smtp-Source: ABdhPJwBcEXBYJ3WyEz0GJkYughHxCeVnMYM5gvzQQokBhHwapfGJtCvkwDS2+raxuekdBmrtXVT4RG14boFxjyijCw=
X-Received: by 2002:a02:878c:: with SMTP id t12mr11334927jai.59.1619913512486;
 Sat, 01 May 2021 16:58:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210501171352.512953-1-jic23@kernel.org> <20210501171352.512953-7-jic23@kernel.org>
In-Reply-To: <20210501171352.512953-7-jic23@kernel.org>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Sat, 1 May 2021 16:58:21 -0700
Message-ID: <CAPUE2uv7dX8kArmA76bLQ0DQmd=F_Obsv54KZGVcbFfC-aRC1g@mail.gmail.com>
Subject: Re: [PATCH 06/11] iio: cros_ec_sensors: Fix alignment of buffer in iio_push_to_buffers_with_timestamp()
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fixes tag is correct up to kernel stable 4.18.
Before, the include file to fix is
drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.h:
commit 974e6f02e27 ("iio: cros_ec_sensors_core: Add common functions
for the ChromeOS EC Sensor Hub.") present since kernel stable 4.10.

Reviewed-by: Gwendal Grignou <gwendal@chromium.org

On Sat, May 1, 2021 at 10:15 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> The samples buffer is passed to iio_push_to_buffers_with_timestamp()
> which requires a buffer aligned to 8 bytes as it is assumed that
> the timestamp will be naturally aligned if present.
>
> Fixes tag is inaccurate but prior to that likely manual backporting needed.
>
> Fixes: 5a0b8cb46624c ("iio: cros_ec: Move cros_ec_sensors_core.h in /include")
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Gwendal Grignou <gwendal@chromium.org>
> ---
>  include/linux/iio/common/cros_ec_sensors_core.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include/linux/iio/common/cros_ec_sensors_core.h
> index 7ce8a8adad58..c582e1a14232 100644
> --- a/include/linux/iio/common/cros_ec_sensors_core.h
> +++ b/include/linux/iio/common/cros_ec_sensors_core.h
> @@ -77,7 +77,7 @@ struct cros_ec_sensors_core_state {
>                 u16 scale;
>         } calib[CROS_EC_SENSOR_MAX_AXIS];
>         s8 sign[CROS_EC_SENSOR_MAX_AXIS];
> -       u8 samples[CROS_EC_SAMPLE_SIZE];
> +       u8 samples[CROS_EC_SAMPLE_SIZE] __aligned(8);
>
>         int (*read_ec_sensors_data)(struct iio_dev *indio_dev,
>                                     unsigned long scan_mask, s16 *data);
> --
> 2.31.1
>
