Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE1E83708B4
	for <lists+linux-iio@lfdr.de>; Sat,  1 May 2021 21:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbhEATL4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 May 2021 15:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbhEATL4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 May 2021 15:11:56 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0477AC06174A
        for <linux-iio@vger.kernel.org>; Sat,  1 May 2021 12:11:05 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id n16so605413plf.7
        for <linux-iio@vger.kernel.org>; Sat, 01 May 2021 12:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZPGet8QMOx3fTp9C3o1q26iL27uqnPIe7E0TBoqktAI=;
        b=u3F/v1UcgBG582fb2QOAh/jCUOxU/PSuV7O3PszSgmutfsqxvdQCkakVWLVsn2PzJS
         xbPAeaLAUedKoHs8/kjY6uAi44JzOkU6DHlqWj6sEJB3KQN94r5bMkmPnGz9iZIyc4vy
         Ay32n8ncjYLrHT/a19uUm3xTRae6Ky1J5RZxcdtuzweJW/Zy9Aby9RhphYajp8IMc1GS
         9eYucZXZqfCuO5bZcKmI7RgYlDvMHyuLpPJNMezLlKmqZTJlgWcTzoRMJ68pxDo+9QjF
         HAQ4zWy64uO6vLFmP0gb2T45BktMlEdLrTNsLvNHZpHwbzb2spxOF6+iciac7TbXM224
         RmjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZPGet8QMOx3fTp9C3o1q26iL27uqnPIe7E0TBoqktAI=;
        b=RjYM9KpMgsB7ioav/7PKbleBbsnPwC2PNeklm3Ak9FHV0/YbwjnMfFtfLYs3pv7C6+
         1HaPMhq+9XonZ/N+7xn1ATlg2MX7l83FoqjUc3yQ0Te+Av/pDvDyEv1yTNkC4Cf5tfLF
         d9ERxoD9K1ban4GbZhhoOXLuWXiJegXRdc1Tfkp4bmLggDx5ww6TRbsgARN8tk8sR1HQ
         NUP3oRGMHHeJ2y3rcA2P5U/hf/6XcaDoQfqSrYfBI9UystJ6vfofMpFll3ZXsOuGTJd7
         jsjcXOrOWHDEhtipwKgtsw4R/IkBNZtGrJ62iAP70FLU2uS/F0VXGgzF4REmRLf2jGl8
         Vd/A==
X-Gm-Message-State: AOAM5332gVtip8meLwHwj/pvBG0Tr34xXZsoYVuOJSOcFn1om+QZUqb2
        stzsPxnCdGE+kDCazzWX98hNDbjrn49s8da1Q2s=
X-Google-Smtp-Source: ABdhPJzjffOYk2BAl6jGgu8vlWPW9bK0aEKPQyDjl4ntZwdxvhq9ehKPoTcugtljIdz5UyTIwH+Rp9kpcFIH1dB/+m4=
X-Received: by 2002:a17:90b:1c0f:: with SMTP id oc15mr12372321pjb.228.1619896264433;
 Sat, 01 May 2021 12:11:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210501170121.512209-1-jic23@kernel.org> <20210501170121.512209-5-jic23@kernel.org>
In-Reply-To: <20210501170121.512209-5-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 1 May 2021 22:10:48 +0300
Message-ID: <CAHp75Vc9hOe66LaC7AzbmbZ5+EMCSdgCnxCLY0NQdurmWtyFVQ@mail.gmail.com>
Subject: Re: [PATCH 04/19] iio: accel: kxcjk-1013: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, May 1, 2021 at 8:03 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> To make code more readable, use a structure to express the channel
> layout and ensure the timestamp is 8 byte aligned.
>
> Found during an audit of all calls of this function.
>
> Fixes: 1a4fbf6a9286 ("iio: accel: kxcjk1013 3-axis accelerometer driver")
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/iio/accel/kxcjk-1013.c | 24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index ff724bc17a45..96ab247f17b3 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -133,6 +133,13 @@ enum kx_acpi_type {
>         ACPI_KIOX010A,
>  };
>
> +enum kxcjk1013_axis {
> +       AXIS_X,
> +       AXIS_Y,
> +       AXIS_Z,

> +       AXIS_MAX,

I see that this is from original code, though I think you have a
chance to remove unneeded comma here. Let's make the terminator line
terminate.

> +};
> +
>  struct kxcjk1013_data {
>         struct regulator_bulk_data regulators[2];
>         struct i2c_client *client;
> @@ -140,7 +147,11 @@ struct kxcjk1013_data {
>         struct iio_trigger *motion_trig;
>         struct iio_mount_matrix orientation;
>         struct mutex mutex;
> -       s16 buffer[8];
> +       /* Ensure timestamp naturally aligned */
> +       struct {
> +               s16 chans[AXIS_MAX];
> +               s64 timestamp __aligned(8);
> +       } scan;
>         u8 odr_bits;
>         u8 range;
>         int wake_thres;
> @@ -154,13 +165,6 @@ struct kxcjk1013_data {
>         enum kx_acpi_type acpi_type;
>  };
>
> -enum kxcjk1013_axis {
> -       AXIS_X,
> -       AXIS_Y,
> -       AXIS_Z,
> -       AXIS_MAX,
> -};
> -
>  enum kxcjk1013_mode {
>         STANDBY,
>         OPERATION,
> @@ -1094,12 +1098,12 @@ static irqreturn_t kxcjk1013_trigger_handler(int irq, void *p)
>         ret = i2c_smbus_read_i2c_block_data_or_emulated(data->client,
>                                                         KXCJK1013_REG_XOUT_L,
>                                                         AXIS_MAX * 2,
> -                                                       (u8 *)data->buffer);
> +                                                       (u8 *)data->scan.chans);
>         mutex_unlock(&data->mutex);
>         if (ret < 0)
>                 goto err;
>
> -       iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
> +       iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
>                                            data->timestamp);
>  err:
>         iio_trigger_notify_done(indio_dev->trig);
> --
> 2.31.1
>


-- 
With Best Regards,
Andy Shevchenko
