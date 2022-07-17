Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097DD5776DC
	for <lists+linux-iio@lfdr.de>; Sun, 17 Jul 2022 17:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbiGQPB6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 Jul 2022 11:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbiGQPB5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 17 Jul 2022 11:01:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A8E13DF6
        for <linux-iio@vger.kernel.org>; Sun, 17 Jul 2022 08:01:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 738ADB80E23
        for <linux-iio@vger.kernel.org>; Sun, 17 Jul 2022 15:01:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09EAFC341CE;
        Sun, 17 Jul 2022 15:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658070113;
        bh=BWsUw6sgkcuAPz3kMv5Lke1PJu8FabemCiHVNwX6hdY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oRbZo6vhiz38vlOwFGW39vWVsulwwKgt0WDQSVlxXy5SQW2pU5iCaxFWTMB0St0o/
         JqOJR+4zmK0CEXd8uYQUCJO0LUegqg7dDDlXebf+gjWo4RbmExU7V1cBckaJ6NEC1Q
         m2QGd3fz/hoon6pvddx6Dap5wHJ+UcW/cFfhyPyQTDk69ZWWIYL2I5hPYpedGTmVRd
         kJQ8X8HshUGQdiEF4xIoW6ZFjauVvLe3lqIK3DYCzAqE5mr6UI9hJotO3Lix72DFr1
         +v1gHhAPbiKFRdgG76AfUTH4UoYPGJLGMFvabqZDGlc8iSJe/+IlIJaeZkAehtyBnM
         v9VdF/Q5yBzYA==
Date:   Sun, 17 Jul 2022 16:11:48 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v3] iio: cros: Register FIFO callback after sensor is
 registered
Message-ID: <20220717161148.0a2ef822@jic23-huawei>
In-Reply-To: <CAD=FV=VEiVgXSC=vx5vB3kEuL2XCQyuaAxNvDHig-PjOfANHag@mail.gmail.com>
References: <20220711144716.642617-1-gwendal@chromium.org>
        <CAD=FV=VEiVgXSC=vx5vB3kEuL2XCQyuaAxNvDHig-PjOfANHag@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 11 Jul 2022 11:45:36 -0700
Doug Anderson <dianders@chromium.org> wrote:

> Hi,
> 
> On Mon, Jul 11, 2022 at 7:47 AM Gwendal Grignou <gwendal@chromium.org> wrote:
> >
> > Instead of registering callback to process sensor events right at
> > initialization time, wait for the sensor to be register in the iio
> > subsystem.
> >
> > Events can come at probe time (in case the kernel rebooted abruptly
> > without switching the sensor off for  instance), and be sent to IIO core
> > before the sensor is fully registered.
> >
> > Reported-by: Douglas Anderson <dianders@chromium.org>
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Applied to the togreg branch of iio.git which will be pushed out as testing
only until rc1 is out and I can rebase.

I'm assuming this doesn't need to go in quickly as a fix?  If it does
let me know (and add a fixes tag)

Thanks,

Jonathan

> > ---
> > Changes since v2:
> > - Do not compare pointer with NULL,
> > - Invert logic to reduce indentation.
> > - Do not set local variable just before use.
> >
> > Changes since v1:
> > - renamed from "iio: cros: Add cros_ec_sensors_core_register"
> > - Call devm_iio_device_register() inside cros_ec_sensors_core_register.
> >
> >  drivers/iio/accel/cros_ec_accel_legacy.c      |  4 +-
> >  .../cros_ec_sensors/cros_ec_lid_angle.c       |  4 +-
> >  .../common/cros_ec_sensors/cros_ec_sensors.c  |  6 +-
> >  .../cros_ec_sensors/cros_ec_sensors_core.c    | 58 ++++++++++++++-----
> >  drivers/iio/light/cros_ec_light_prox.c        |  6 +-
> >  drivers/iio/pressure/cros_ec_baro.c           |  6 +-
> >  .../linux/iio/common/cros_ec_sensors_core.h   |  7 ++-
> >  7 files changed, 60 insertions(+), 31 deletions(-)
> >
> > diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel/cros_ec_accel_legacy.c
> > index 1c0171f26e99e..0f403342b1fc0 100644
> > --- a/drivers/iio/accel/cros_ec_accel_legacy.c
> > +++ b/drivers/iio/accel/cros_ec_accel_legacy.c
> > @@ -215,7 +215,7 @@ static int cros_ec_accel_legacy_probe(struct platform_device *pdev)
> >                 return -ENOMEM;
> >
> >         ret = cros_ec_sensors_core_init(pdev, indio_dev, true,
> > -                                       cros_ec_sensors_capture, NULL);
> > +                                       cros_ec_sensors_capture);
> >         if (ret)
> >                 return ret;
> >
> > @@ -235,7 +235,7 @@ static int cros_ec_accel_legacy_probe(struct platform_device *pdev)
> >                 state->sign[CROS_EC_SENSOR_Z] = -1;
> >         }
> >
> > -       return devm_iio_device_register(dev, indio_dev);
> > +       return cros_ec_sensors_core_register(dev, indio_dev, NULL);
> >  }
> >
> >  static struct platform_driver cros_ec_accel_platform_driver = {
> > diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
> > index 9f780fafaed9f..119acb078af3b 100644
> > --- a/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
> > +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
> > @@ -98,7 +98,7 @@ static int cros_ec_lid_angle_probe(struct platform_device *pdev)
> >         if (!indio_dev)
> >                 return -ENOMEM;
> >
> > -       ret = cros_ec_sensors_core_init(pdev, indio_dev, false, NULL, NULL);
> > +       ret = cros_ec_sensors_core_init(pdev, indio_dev, false, NULL);
> >         if (ret)
> >                 return ret;
> >
> > @@ -114,7 +114,7 @@ static int cros_ec_lid_angle_probe(struct platform_device *pdev)
> >         if (ret)
> >                 return ret;
> >
> > -       return devm_iio_device_register(dev, indio_dev);
> > +       return cros_ec_sensors_core_register(dev, indio_dev, NULL);
> >  }
> >
> >  static const struct platform_device_id cros_ec_lid_angle_ids[] = {
> > diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> > index 61e07a7bb1995..66153b1850f10 100644
> > --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> > +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> > @@ -236,8 +236,7 @@ static int cros_ec_sensors_probe(struct platform_device *pdev)
> >                 return -ENOMEM;
> >
> >         ret = cros_ec_sensors_core_init(pdev, indio_dev, true,
> > -                                       cros_ec_sensors_capture,
> > -                                       cros_ec_sensors_push_data);
> > +                                       cros_ec_sensors_capture);
> >         if (ret)
> >                 return ret;
> >
> > @@ -298,7 +297,8 @@ static int cros_ec_sensors_probe(struct platform_device *pdev)
> >         else
> >                 state->core.read_ec_sensors_data = cros_ec_sensors_read_cmd;
> >
> > -       return devm_iio_device_register(dev, indio_dev);
> > +       return cros_ec_sensors_core_register(dev, indio_dev,
> > +                       cros_ec_sensors_push_data);  
> 
> Probably not worth spinning for, but now that the indentation was been
> reduced (compared to v2) the above call doesn't need to be split
> across 2 lines.
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

