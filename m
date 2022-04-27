Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 819F6512240
	for <lists+linux-iio@lfdr.de>; Wed, 27 Apr 2022 21:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbiD0TSG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 27 Apr 2022 15:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233051AbiD0TR5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 27 Apr 2022 15:17:57 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A166E552
        for <linux-iio@vger.kernel.org>; Wed, 27 Apr 2022 12:10:50 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id o5so592289ils.11
        for <linux-iio@vger.kernel.org>; Wed, 27 Apr 2022 12:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+3PWt4Rx4ZteMbjxV0SmKDUTzic25+CKRGIaTJQR0N8=;
        b=YmazCg27BiRRqmD3nSMJgXi8IoIQvs0pLjF/tBLV3gG46UabAK2gubBRokmpmjQjQc
         xXLNwH3zDHL+y5sb6QF0UWNjlIwWExuhHUZwN5r8l8MA82OYo42UTzQvN7vNSku2LnPn
         1zxGz0oBDqX/ufeSeggPSn54FnHE63bF+bEJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+3PWt4Rx4ZteMbjxV0SmKDUTzic25+CKRGIaTJQR0N8=;
        b=ps1PhZTnRSacIqRCU1FcRRGx3UGjT2mRPb06IAZ3g9EBKQo0ORdx6I0NtzDsEIJ/JI
         e98rXWFDvZvDA4ELruVFd5f5JrJIbxPVU5FV7XUxiWkIQ2ZdbPSUk7aczA2z7xa74bn/
         WUrNh+mSv3rlPaSYHDW47+LAfIQqME2ctiZ9CKXMme2LuLf9BzKcf62B4dHovcShaSph
         IL3dXEFpws7i6gjnGZ/UvP1Hl/1sUUQgDJFg9EZ6D9wOa1YQXKfPWpTgzkp1ceYPzt2h
         W1uUyVyR7to82CBS2+Fn7RrnYuwNFMbh8CNRu7QSIyahPEAQ92tw1O1l9E2tdTia7x3q
         4aZw==
X-Gm-Message-State: AOAM5302H2ci61MOaZTcc+rMtDe8MVT6qmY+tuj1PEurP2DTdGP4mePA
        pEnoKJu4z17MGLos6mYz+JYS/zOfbf++ixsAaKxkNou/4g0=
X-Google-Smtp-Source: ABdhPJzKCyF0jBjQmjn+36I/2FVyp2iT8GhYYQuhQ06dWjwxCxTTkTnCHCpsmeiQz+nKu4Lv+cFLyObHzkRXoaG3UUM=
X-Received: by 2002:a05:6e02:1ba3:b0:2cd:58d9:726f with SMTP id
 n3-20020a056e021ba300b002cd58d9726fmr11835774ili.61.1651086649469; Wed, 27
 Apr 2022 12:10:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220412210703.3842914-1-gwendal@chromium.org> <20220416151049.43844f70@jic23-huawei>
In-Reply-To: <20220416151049.43844f70@jic23-huawei>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Wed, 27 Apr 2022 12:10:38 -0700
Message-ID: <CAPUE2ut4bv0EZt9EQ1xmN5s=LMMBzViYpZk0o1CyHP7HxqDvOA@mail.gmail.com>
Subject: Re: [PATCH] iio: common: cros_ec_sensors: Add label attribute
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     enric.balletbo@collabora.com, bleung@chromium.org,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Apr 16, 2022 at 7:02 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Tue, 12 Apr 2022 14:07:03 -0700
> Gwendal Grignou <gwendal@chromium.org> wrote:
>
> > When sensor location is known, populate iio sysfs "label" attribute:
> >
> > * "accel-base" : the sensor is in the base of the convertible (2-1)
> >   device.
> > * "accel-display" : the sensor is in the lid/display plane of the
> >   device.
> >
> > It apply to standalone accelerometer and IMU (accelerometer +
> > gyroscope).
> >
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
>
> I'm happy with this change, but I think it would
> be good for the patch description to include 'why' you want to
> add this. I assume that's to make use of the standard ABI rather
> than the custom ABI we introduced for this driver. We'd have
> used label for this in the first place if it had been an option
> at the time, but given we didn't what is the logic for duplicating
> this information?
I removed the duplication in v2, I needed to add a define for the
narrow case where a sensor is in a camera subassembly.
Note the location attribute can apply to other sensors than
accelerometers (gyroscope, light sensor).

Thanks,

Gwendal.
>
> Thanks,
>
> Jonathan
>
> > ---
> >  .../iio/common/cros_ec_sensors/cros_ec_sensors_core.c    | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > index 989b109a82f47..f86b938b36bf8 100644
> > --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > @@ -325,6 +325,8 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
> >       indio_dev->name = pdev->name;
> >
> >       if (physical_device) {
> > +             enum motionsensor_location loc;
> > +
> >               state->param.cmd = MOTIONSENSE_CMD_INFO;
> >               state->param.info.sensor_num = sensor_platform->sensor_num;
> >               ret = cros_ec_motion_send_host_cmd(state, 0);
> > @@ -333,7 +335,12 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
> >                       return ret;
> >               }
> >               state->type = state->resp->info.type;
> > -             state->loc = state->resp->info.location;
> > +             loc = state->resp->info.location;
> > +             if (loc == MOTIONSENSE_LOC_BASE)
> > +                     indio_dev->label = "accel-base";
> > +             else if (loc == MOTIONSENSE_LOC_LID)
> > +                     indio_dev->label = "accel-display";
> > +             state->loc = loc;
> >
> >               /* Set sign vector, only used for backward compatibility. */
> >               memset(state->sign, 1, CROS_EC_SENSOR_MAX_AXIS);
>
