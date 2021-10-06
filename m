Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 288B44234DB
	for <lists+linux-iio@lfdr.de>; Wed,  6 Oct 2021 02:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233994AbhJFAS0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 5 Oct 2021 20:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbhJFASY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 5 Oct 2021 20:18:24 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68EBC061749
        for <linux-iio@vger.kernel.org>; Tue,  5 Oct 2021 17:16:33 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id ls14-20020a17090b350e00b001a00e2251c8so936839pjb.4
        for <linux-iio@vger.kernel.org>; Tue, 05 Oct 2021 17:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FsmOcyeSF5LDALD7AdWRbXWLdG0zO7+WUiqdNCezuHc=;
        b=jjILV6lHdBkHdfDeE167mW3yw3DgacBfFLFIqrdpFEphqu7gr5eQbTyq/bFiEJrvwm
         lF6b3/99Sh7dF2t6FHkXdOqBT6c1WnDGCi0QOyRRQ38+jehDZkGLVPBNK1YlElQZgeHh
         crpWe5OgLIsypO1pyfBfnOxUQb/A1EmwqHy8BSbjzn3kHDLeQBmkIyNLDM43cnpupUxT
         FqQhIa8/Op3x50d1/JkbcSxGyANvfzP/9LXbG0QEqvi4vThdq42sK+CSFR8DmK+0CRF6
         ILIWrZdc9/ZRd3FTHiFkAODhhk9XxdLMtAr4TUe1RcgWTsmflT3rWt0dl+E4WXpAp78Z
         xm1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FsmOcyeSF5LDALD7AdWRbXWLdG0zO7+WUiqdNCezuHc=;
        b=WpY9R1vUndUN9VsDFHdPajJTV/H7xLiUl+xaenMvYtiyugO5BmCBoq1Gdy6LqJ8/Do
         AA5SJ4mhldDUJfvuKqA4ndVVGfu/Pq4dBTVS6SdkKXUJI5Ek7sPN6YQTR3RT51PTuKNB
         BGCU9nRE2t0L3oJBX71tgjVRgFJnRbanWzWPbdIQs3+H2X4FiqkdE3Xeuh21IkBq64BA
         OYTkK2CPhASqsgW+hmlnCIVRemQKiv3vLR48qpbPswI7/yoXE0M6as0jELcLkmJKuz2V
         Nax0ElZFOEdlQ1EzqSxmaZ+jnsh21le9YX9wBXk/wwgp9Ip+9pmJ9Al24vyBh8PkBzDp
         P9hg==
X-Gm-Message-State: AOAM532+TGJtDuNyMhSgsio0I4fK1ftBtAWA4Dn0SfVjPBBJ7wZytrsK
        XBF11gSmKJcrQbVotOf+NykrT2Ky8g60Bholanyc4w==
X-Google-Smtp-Source: ABdhPJxm2mrIkvX1H5FZqrRIvq/NW592WPZPWtxWAKdaIixsmln+D5I2mF9rQg+zHJZWe9VAKADevheENmdKLBXcV88=
X-Received: by 2002:a17:90a:2902:: with SMTP id g2mr7212693pjd.161.1633479392911;
 Tue, 05 Oct 2021 17:16:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210928161957.24628-1-andriy.tryshnivskyy@opensynergy.com>
 <20210930174043.0845f6ed@jic23-huawei> <CA+=V6c34+VtYbUDG=NuY6YeyML23Tth2+fTjhvXpwMvrtkM5_Q@mail.gmail.com>
 <650ec3b8-c970-604c-9be6-577c46d3e762@opensynergy.com>
In-Reply-To: <650ec3b8-c970-604c-9be6-577c46d3e762@opensynergy.com>
From:   Jyoti Bhayana <jbhayana@google.com>
Date:   Tue, 5 Oct 2021 17:16:21 -0700
Message-ID: <CA+=V6c10xE-1uUzGWusBiGVMV2Fwy93dGGHA9FH0PC4tYggVUQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/1] iio/scmi: Add reading "raw" attribute.
To:     Vasyl Vavrychuk <vasyl.vavrychuk@opensynergy.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Vasyl,

Regarding below question, yes reading raw attribute should be blocked
if buffer is enabled for that sensor.

> 1. Should we block reading raw attribute and IIO buffer enabled, for for
> SCMI sensor it can coexist?


PLease see  https://elixir.bootlin.com/linux/latest/source/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c#L667
as well. It has

case IIO_CHAN_INFO_RAW:
ret = iio_device_claim_direct_mode(indio_dev);
if (ret)
return ret;
mutex_lock(&st->lock);
ret = inv_mpu6050_read_channel_data(indio_dev, chan, val);
mutex_unlock(&st->lock);
iio_device_release_direct_mode(indio_dev);
return ret;

Regarding the question below, the answer is yes.

> 2. Should we wrap reading raw attribute implementation in iio_dev->mlock
> mutex?


Thanks, Jyoti





On Tue, Oct 5, 2021 at 5:52 AM Vasyl Vavrychuk
<vasyl.vavrychuk@opensynergy.com> wrote:
>
> Hi, Jyoti,
>
> > In the code below, why is the logic of enabling and disabling the
> > sensor in this function?  Generally the function to read the sensor
> > value is just used for the code to read the sensor values ? and not
> > enable/disable the sensor
>
> But to read sensor value we have to enable it first. Other way to enable
> sensor we found is, for example:
>
>    echo 1 > /sys/bus/iio/devices/.../scan_elements/in_anglvel_x_en
>
> But, this command is related to IIO buffers use.
>
> Other sensors drivers enable/disable sensor in read raw too, for
> example, drivers/iio/accel/kxcjk-1013.c has:
>
>    case IIO_CHAN_INFO_RAW:
>            mutex_lock(&data->mutex);
>            if (iio_buffer_enabled(indio_dev))
>                    ret = -EBUSY;
>            else {
>                    ret = kxcjk1013_set_power_state(data, true);
>                    ... reading ...
>                    ret = kxcjk1013_set_power_state(data, false);
>            }
>            mutex_unlock(&data->mutex);
>
> But, after looking on this code I have some questions:
>
> 1. Should we block reading raw attribute and IIO buffer enabled, for for
> SCMI sensor it can coexist?
> 2. Should we wrap reading raw attribute implementation in iio_dev->mlock
> mutex?
>
> >>     case IIO_CHAN_INFO_RAW:
> >> +               sensor_config = FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK,
> >> +                                          SCMI_SENS_CFG_SENSOR_ENABLE);
> >> +               err = sensor->sensor_ops->config_set(
> >> +                       sensor->ph, sensor->sensor_info->id, sensor_config);
> >> +               if (err) {
> >> +                       dev_err(&iio_dev->dev,
> >> +                               "Error in enabling sensor %s err %d",
> >> +                               sensor->sensor_info->name, err);
> >> +                       return err;
> >> +               }
> >> +
> >> +               err = sensor->sensor_ops->reading_get_timestamped(
> >> +                       sensor->ph, sensor->sensor_info->id,
> >> +                       sensor->sensor_info->num_axis, readings);
> >> +               if (err) {
> >> +                       dev_err(&iio_dev->dev,
> >> +                               "Error in reading raw attribute for sensor %s err %d",
> >> +                               sensor->sensor_info->name, err);
> >> +                       return err;
> >> +               }
> >> +
> >> +               sensor_config = FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK,
> >> +                                          SCMI_SENS_CFG_SENSOR_DISABLE);
> >> +               err = sensor->sensor_ops->config_set(
> >> +                       sensor->ph, sensor->sensor_info->id, sensor_config);
> >> +               if (err) {
> >> +                       dev_err(&iio_dev->dev,
> >> +                               "Error in enabling sensor %s err %d",
> >> +                               sensor->sensor_info->name, err);
> >> +                       return err;
> >> +               }
> >> +               /* Check if raw value fits 32 bits */
> >> +               if (readings[ch->scan_index].value < INT_MIN ||
> >> +                   readings[ch->scan_index].value > INT_MAX)
> >> +                       return -ERANGE;
> >> +               /* Use 32-bit value, since practically there is no need in 64 bits */
> >> +               *val = (int)readings[ch->scan_index].value;
> >>
> >> +               return IIO_VAL_INT;
