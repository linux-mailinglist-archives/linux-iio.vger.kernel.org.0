Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06AA5C250B
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2019 18:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732257AbfI3QYq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Sep 2019 12:24:46 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43287 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732177AbfI3QYq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Sep 2019 12:24:46 -0400
Received: by mail-io1-f65.google.com with SMTP id v2so39790646iob.10
        for <linux-iio@vger.kernel.org>; Mon, 30 Sep 2019 09:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pMMecHlbii45iWOZHo2zW6iaJVDnPkjK3dSHl9V+w9k=;
        b=gxg51sWYMWs5I+Rs64CCmaLYCptrQXOXaDSFiT6envy1JZaR2Ggqn1tMrfH3/x6wZh
         nmHLnHuGstb3DY9wlIP9IHKb8Wim8b7I1KVeQjIlNdzzME0Q6ZyNNgdSTt8OOawfFyT2
         /ZSC/X8fAZFAxIluTHfm1WpCf5zR1GZNw8fvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pMMecHlbii45iWOZHo2zW6iaJVDnPkjK3dSHl9V+w9k=;
        b=cz0/Q1MkyY+13cml1A+ZTBly1G0zV+QBlyyfeEdo3uLsQ1G3bATHzOhEb28+LzXtOH
         pndcuA1Lym3WbT1717+mJn7VdXZRqWbN1/dXKdmewNlzdS1EK804qUl/Y1Ft2xQ8UOai
         PHpIvXK/Fsh1VCgl3XwCn79lbBINVk3tni9nElwbOg1oIxAZlArsNqnzHLe7QBIczjf0
         154EtAjPyk6PZAxMtW1XPuO98XpNDkvq5aZvpMzdU81GWTPmcoSrxGsPwDz4hutXIF39
         Dkic5OBXPWAu7GCrlXb654c3UPAVmZzghBx/taiP2b7wOTH6ZOpbOoygj7CJj8UCJeuz
         e6ag==
X-Gm-Message-State: APjAAAXz7L0IfHyzHeZ3AsmfR0X+dVNsXxa6kfetF3lDtWBtZvHDNz7y
        iTBXm/z5T6hCiRx8kJGLah7tBdqY6GSdubZo2zJ83A==
X-Google-Smtp-Source: APXvYqzoyjRyk10Z6QSw8uzHAdILDacqAXCbflVdJW+xpSV5WxVDagtkOpqqRF8Utl8En6M6C/yQsxGc8bzrYYmf6xY=
X-Received: by 2002:a6b:5907:: with SMTP id n7mr21653958iob.145.1569860685182;
 Mon, 30 Sep 2019 09:24:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190922175021.53449-1-gwendal@chromium.org> <20190922175021.53449-2-gwendal@chromium.org>
 <411716b0-818b-9060-7055-8ff9523c0c45@collabora.com>
In-Reply-To: <411716b0-818b-9060-7055-8ff9523c0c45@collabora.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Mon, 30 Sep 2019 09:24:34 -0700
Message-ID: <CAPUE2utue_uVeZYmrtB4DyPYtNh9vBHz9W5vc=Z2VAEbBZm5Vg@mail.gmail.com>
Subject: Re: [PATCH 01/13] mfd: cros_ec: Add sensor_count and make
 check_features public
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Sounds good to me, I will make the change in rev2.

On Mon, Sep 30, 2019 at 6:15 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Gwendal,
>
> Many thanks for the patches.
>
> On 22/9/19 19:50, Gwendal Grignou wrote:
> > Add a new function to return the number of MEMS sensors available in a
> > ChromeOS Embedded Controller.
> > It uses MOTIONSENSE_CMD_DUMP if available or a specific memory map ACPI
> > registers to find out.
> >
> > Also, make check_features public as it can be useful for other drivers
> > to know whant the Embedded Controller supports.
> >
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> > ---
> >  drivers/mfd/cros_ec_dev.c   | 61 ++++++++++++++++++++++++++++++++++++-
> >  include/linux/mfd/cros_ec.h | 17 +++++++++++
> >  2 files changed, 77 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> > index 6e6dfd6c1871..3be80183ccaa 100644
> > --- a/drivers/mfd/cros_ec_dev.c
> > +++ b/drivers/mfd/cros_ec_dev.c
> > @@ -112,7 +112,7 @@ static const struct mfd_cell cros_ec_vbc_cells[] = {
> >       { .name = "cros-ec-vbc", }
> >  };
> >
> > -static int cros_ec_check_features(struct cros_ec_dev *ec, int feature)
> > +int cros_ec_check_features(struct cros_ec_dev *ec, int feature)
> >  {
> >       struct cros_ec_command *msg;
> >       int ret;
> > @@ -143,12 +143,71 @@ static int cros_ec_check_features(struct cros_ec_dev *ec, int feature)
> >
> >       return ec->features[feature / 32] & EC_FEATURE_MASK_0(feature);
> >  }
> > +EXPORT_SYMBOL_GPL(cros_ec_check_features);
> >
> >  static void cros_ec_class_release(struct device *dev)
> >  {
> >       kfree(to_cros_ec_dev(dev));
> >  }
> >
> > +int cros_ec_get_sensor_count(struct cros_ec_dev *ec)
> > +{
> > +     /*
> > +      * Issue a command to get the number of sensor reported.
> > +      * If not supported, check for legacy mode.
> > +      */
> > +     int ret, sensor_count;
> > +     struct ec_params_motion_sense *params;
> > +     struct ec_response_motion_sense *resp;
> > +     struct cros_ec_command *msg;
> > +     struct cros_ec_device *ec_dev = ec->ec_dev;
> > +     u8 status;
> > +
> > +     msg = kzalloc(sizeof(struct cros_ec_command) +
> > +                     max(sizeof(*params), sizeof(*resp)), GFP_KERNEL);
> > +     if (msg == NULL)
> > +             return -ENOMEM;
> > +
> > +     msg->version = 1;
> > +     msg->command = EC_CMD_MOTION_SENSE_CMD + ec->cmd_offset;
> > +     msg->outsize = sizeof(*params);
> > +     msg->insize = sizeof(*resp);
> > +
> > +     params = (struct ec_params_motion_sense *)msg->data;
> > +     params->cmd = MOTIONSENSE_CMD_DUMP;
> > +
> > +     ret = cros_ec_cmd_xfer(ec->ec_dev, msg);
> > +     if (ret < 0) {
> > +             sensor_count = ret;
> > +     } else if (msg->result != EC_RES_SUCCESS) {
> > +             sensor_count = -EPROTO;
> > +     } else {
> > +             resp = (struct ec_response_motion_sense *)msg->data;
> > +             sensor_count = resp->dump.sensor_count;
> > +     }
> > +     kfree(msg);
> > +
> > +     /*
> > +      * Check legacy mode: Let's find out if sensors are accessible
> > +      * via LPC interface.
> > +      */
> > +     if (sensor_count == -EPROTO &&
> > +         ec->cmd_offset == 0 &&
> > +         ec_dev->cmd_readmem) {
> > +             ret = ec_dev->cmd_readmem(ec_dev, EC_MEMMAP_ACC_STATUS,
> > +                             1, &status);
> > +             if ((ret >= 0) &&
> > +                 (status & EC_MEMMAP_ACC_STATUS_PRESENCE_BIT)) {
> > +                     /*
> > +                      * We have 2 sensors, one in the lid, one in the base.
> > +                      */
> > +                     sensor_count = 2;
> > +             }
> > +     }
> > +     return sensor_count;
> > +}
> > +EXPORT_SYMBOL_GPL(cros_ec_get_sensor_count);
> > +
> >  static void cros_ec_sensors_register(struct cros_ec_dev *ec)
> >  {
> >       /*
> > diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
> > index 61c2875c2a40..578e0bbcafdc 100644
> > --- a/include/linux/mfd/cros_ec.h
> > +++ b/include/linux/mfd/cros_ec.h
> > @@ -32,4 +32,21 @@ struct cros_ec_dev {
> >
> >  #define to_cros_ec_dev(dev)  container_of(dev, struct cros_ec_dev, class_dev)
> >
> > +/**
> > + * cros_ec_check_features - Test for the presence of EC features
> > + *
> > + * Call this function to test whether the ChromeOS EC supports a feature.
> > + *
> > + * @ec_dev: EC device
> > + * @msg: One of ec_feature_code values
> > + * @return: 1 if supported, 0 if not
> > + */
> > +int cros_ec_check_features(struct cros_ec_dev *ec, int feature);
> > +
> > +/*
> > + * Return the number of MEMS sensors supported.
> > + * Return < 0 in case of error.
> > + */
> > +int cros_ec_get_sensor_count(struct cros_ec_dev *ec);
> > +
>
> I am wondering if we should take this opportunity to move these two functions
> from drivers/mfd/cros_ec_dev to drivers/platform/chrome/cros_ec_proto.c and
> include/linux/platform_data/cros_ec_proto.h
>
> I think this part is more suitable for core part that actually resides in
> platform/chrome than the mfd device itself. What do you think? Do you see any
> problem on doing this?
>
> Thanks,
>  Enric
>
> >  #endif /* __LINUX_MFD_CROS_EC_H */
> >
