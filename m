Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7089577757
	for <lists+linux-iio@lfdr.de>; Sun, 17 Jul 2022 18:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiGQQu7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 Jul 2022 12:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiGQQu7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 17 Jul 2022 12:50:59 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C69F13F35
        for <linux-iio@vger.kernel.org>; Sun, 17 Jul 2022 09:50:58 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id q14so7615732iod.3
        for <linux-iio@vger.kernel.org>; Sun, 17 Jul 2022 09:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=avxBOPDF9jSAMvXoJK0nNwdJ0nlaICszMhRag1oLQs0=;
        b=J0aoOTCgbnMNLewUZwdZSEJIVxiNwigjs6f/MXhLSVNI/UN6iP2FkO+w9WtHKuKb2B
         OiAQBPQ/ODPX5h5ndkUL1ppZzOYDUNiGifhnVwsbQJ7XGzSUpkI7VrE4vaUIrqudUoWS
         ctGr/dRPcSZcFpEtcu0fYBYh5t3xJJgP8xNJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=avxBOPDF9jSAMvXoJK0nNwdJ0nlaICszMhRag1oLQs0=;
        b=Mq1EniF2LQaSrW0mcEWwNAnWRiF4dosDedtuOXDyDnK2sz/EqN7ohNFBocNyAkQqBI
         Tx66HZWrL1pbRrp0ZicSBU9O/EUICzNp7EzRrhKo3JKEFJlt2Nt1pdsmfujFgFbCNJlw
         vctdIlQ7VnBMcprCL8XLCMGE7/R4BanCgIx46aiEvcT3ndl80I3vsM7/AzHC++zlrOmi
         V4PUhLlGMnTNns5oRvFeXNZonDv/zHx0bKMHnFAO2TdYWUbZdBRmHkOr0yyp4t2xx4fT
         dKT1WvPBUIBZmzu0T8G167pjwyj3CEQfKhJmIfBr0pMztaH4JM5lO5gvgaccBzWuRKwp
         +LFw==
X-Gm-Message-State: AJIora/IrWmUDI8r9e5CzNWlM21XioIYiKLEhIBGG2Qe7G6Ex+kBfRJr
        NnX/sEdhuicXTDlSGwx6bzeol3Acq5WQu4HHapZTyA==
X-Google-Smtp-Source: AGRyM1uYMhNwQAD9pc3mUr9H9IENzHihp34bUYCkG+QQ9xKyo23pmeANSuDiGw+hvpEVAsAsRqnRq9MKojpB4GnUKYI=
X-Received: by 2002:a05:6638:4511:b0:33f:4ccb:3139 with SMTP id
 bs17-20020a056638451100b0033f4ccb3139mr12421804jab.20.1658076657036; Sun, 17
 Jul 2022 09:50:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220711144716.642617-1-gwendal@chromium.org> <CAD=FV=VEiVgXSC=vx5vB3kEuL2XCQyuaAxNvDHig-PjOfANHag@mail.gmail.com>
 <20220717161148.0a2ef822@jic23-huawei>
In-Reply-To: <20220717161148.0a2ef822@jic23-huawei>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Sun, 17 Jul 2022 18:50:45 +0200
Message-ID: <CAPUE2uu-0tDSdpjL0AGEfQBEJs9K9wpBDcUf7+j5pt7EqxgCPg@mail.gmail.com>
Subject: Re: [PATCH v3] iio: cros: Register FIFO callback after sensor is registered
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jul 17, 2022 at 5:01 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Mon, 11 Jul 2022 11:45:36 -0700
> Doug Anderson <dianders@chromium.org> wrote:
>
> > Hi,
> >
> > On Mon, Jul 11, 2022 at 7:47 AM Gwendal Grignou <gwendal@chromium.org> wrote:
> > >
> > > Instead of registering callback to process sensor events right at
> > > initialization time, wait for the sensor to be register in the iio
> > > subsystem.
> > >
> > > Events can come at probe time (in case the kernel rebooted abruptly
> > > without switching the sensor off for  instance), and be sent to IIO core
> > > before the sensor is fully registered.
> > >
> > > Reported-by: Douglas Anderson <dianders@chromium.org>
> > > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> Applied to the togreg branch of iio.git which will be pushed out as testing
> only until rc1 is out and I can rebase.
>
> I'm assuming this doesn't need to go in quickly as a fix?  If it does
> let me know (and add a fixes tag)
We were lucky current drivers do not allocate channels after calling
cros_ec_sensors_core_init()
For cleanliness, we can add the following fixes tag:

Fixes: aa984f1ba4a4 ("iio: cros_ec: Register to cros_ec_sensorhub when
EC supports FIFO")

Thanks,
Gwendal
> Thanks,
>
> Jonathan
>
> > > ---
> > > Changes since v2:
> > > - Do not compare pointer with NULL,
> > > - Invert logic to reduce indentation.
> > > - Do not set local variable just before use.
> > >
> > > Changes since v1:
> > > - renamed from "iio: cros: Add cros_ec_sensors_core_register"
> > > - Call devm_iio_device_register() inside cros_ec_sensors_core_register.
> > >
> > >  drivers/iio/accel/cros_ec_accel_legacy.c      |  4 +-
> > >  .../cros_ec_sensors/cros_ec_lid_angle.c       |  4 +-
> > >  .../common/cros_ec_sensors/cros_ec_sensors.c  |  6 +-
> > >  .../cros_ec_sensors/cros_ec_sensors_core.c    | 58 ++++++++++++++-----
> > >  drivers/iio/light/cros_ec_light_prox.c        |  6 +-
> > >  drivers/iio/pressure/cros_ec_baro.c           |  6 +-
> > >  .../linux/iio/common/cros_ec_sensors_core.h   |  7 ++-
> > >  7 files changed, 60 insertions(+), 31 deletions(-)
> > >
> > > diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel/cros_ec_accel_legacy.c
> > > index 1c0171f26e99e..0f403342b1fc0 100644
> > > --- a/drivers/iio/accel/cros_ec_accel_legacy.c
> > > +++ b/drivers/iio/accel/cros_ec_accel_legacy.c
> > > @@ -215,7 +215,7 @@ static int cros_ec_accel_legacy_probe(struct platform_device *pdev)
> > >                 return -ENOMEM;
> > >
> > >         ret = cros_ec_sensors_core_init(pdev, indio_dev, true,
> > > -                                       cros_ec_sensors_capture, NULL);
> > > +                                       cros_ec_sensors_capture);
> > >         if (ret)
> > >                 return ret;
> > >
> > > @@ -235,7 +235,7 @@ static int cros_ec_accel_legacy_probe(struct platform_device *pdev)
> > >                 state->sign[CROS_EC_SENSOR_Z] = -1;
> > >         }
> > >
> > > -       return devm_iio_device_register(dev, indio_dev);
> > > +       return cros_ec_sensors_core_register(dev, indio_dev, NULL);
> > >  }
> > >
> > >  static struct platform_driver cros_ec_accel_platform_driver = {
> > > diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
> > > index 9f780fafaed9f..119acb078af3b 100644
> > > --- a/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
> > > +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
> > > @@ -98,7 +98,7 @@ static int cros_ec_lid_angle_probe(struct platform_device *pdev)
> > >         if (!indio_dev)
> > >                 return -ENOMEM;
> > >
> > > -       ret = cros_ec_sensors_core_init(pdev, indio_dev, false, NULL, NULL);
> > > +       ret = cros_ec_sensors_core_init(pdev, indio_dev, false, NULL);
> > >         if (ret)
> > >                 return ret;
> > >
> > > @@ -114,7 +114,7 @@ static int cros_ec_lid_angle_probe(struct platform_device *pdev)
> > >         if (ret)
> > >                 return ret;
> > >
> > > -       return devm_iio_device_register(dev, indio_dev);
> > > +       return cros_ec_sensors_core_register(dev, indio_dev, NULL);
> > >  }
> > >
> > >  static const struct platform_device_id cros_ec_lid_angle_ids[] = {
> > > diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> > > index 61e07a7bb1995..66153b1850f10 100644
> > > --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> > > +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> > > @@ -236,8 +236,7 @@ static int cros_ec_sensors_probe(struct platform_device *pdev)
> > >                 return -ENOMEM;
> > >
> > >         ret = cros_ec_sensors_core_init(pdev, indio_dev, true,
> > > -                                       cros_ec_sensors_capture,
> > > -                                       cros_ec_sensors_push_data);
> > > +                                       cros_ec_sensors_capture);
> > >         if (ret)
> > >                 return ret;
> > >
> > > @@ -298,7 +297,8 @@ static int cros_ec_sensors_probe(struct platform_device *pdev)
> > >         else
> > >                 state->core.read_ec_sensors_data = cros_ec_sensors_read_cmd;
> > >
> > > -       return devm_iio_device_register(dev, indio_dev);
> > > +       return cros_ec_sensors_core_register(dev, indio_dev,
> > > +                       cros_ec_sensors_push_data);
> >
> > Probably not worth spinning for, but now that the indentation was been
> > reduced (compared to v2) the above call doesn't need to be split
> > across 2 lines.
> >
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
