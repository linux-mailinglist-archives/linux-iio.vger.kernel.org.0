Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27D692C519
	for <lists+linux-iio@lfdr.de>; Tue, 28 May 2019 13:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfE1LEs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 May 2019 07:04:48 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:36133 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbfE1LEs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 May 2019 07:04:48 -0400
Received: by mail-it1-f196.google.com with SMTP id e184so3248628ite.1
        for <linux-iio@vger.kernel.org>; Tue, 28 May 2019 04:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NKwH+82KHDf3Ln6RM+n/0ytfrCGFMBBR/KTsbE79MoM=;
        b=UKYaNIdhTjv47yG//8KVOKAxOcJ17oE/ftJbrVP/LAy6BNaykyjQpUfG7GHMFaeoAu
         kyuaA0x3DKi9/3O+u1g1/4+ez7v8XhY+yvsfluD7HhgiCaLkQflj+v8T7pakLqqa+vJf
         zdev5AelfM07Rqk4xkyjDFSSGaUH/VhGKs93Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NKwH+82KHDf3Ln6RM+n/0ytfrCGFMBBR/KTsbE79MoM=;
        b=H57I19wZIZPHBYqh5W3EuTOaIkAHAV7/0qxVugRBgvLN8zsSUXwdOPrhemm8vlim2Q
         nMlueZXgQChA8vW5ng9iQL73hhZOdeArnRjlMpm8JrQ+/FBypglrqITC2Yw2NRZ2BgE1
         loWBnbqfRdL/J9qlweyKX18KHww61dXK7owawwmwdQ/ZhRSd0trpwqFLSY5AwNTMEz6r
         aY8MamwD1T5ZwXhvtfaXSAr+XX9c4N580HFANn3CvbXkOqHmOBVSwMARxNo47oMICTKr
         hhHdkQq1ZbGRWCHJFtz95Bnbt9fw/2bQ9pyZI4bcFw1J4YAzGLj6KIarUQ9kYuuBRtgA
         pRhQ==
X-Gm-Message-State: APjAAAW66tExIeP2A38X4cFbYq7v7COredSYjLnCbDW1XPYc2lyUwNH/
        AkuvkCHlNeLRcvJuyLOan2og/DucDUU1Nwh/nzqGNA==
X-Google-Smtp-Source: APXvYqw6AeYe43wL9fhXL4WEdNXmXBANYqQyY1rUQS9NrTqwL6nDioVCwbQkAewUNWEqlQHFXlnkI+fMsJFR7mOLMHw=
X-Received: by 2002:a24:3993:: with SMTP id l141mr2874995ita.35.1559041486931;
 Tue, 28 May 2019 04:04:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1558601329.git.fabien.lahoudere@collabora.com>
 <f1891f9da2e9362a4efebf0ebce487b9584d4f5a.1558601329.git.fabien.lahoudere@collabora.com>
 <20190526184507.45c54053@archlinux> <3af7925c5dad281774b6d12826770cbefb32ea09.camel@collabora.com>
In-Reply-To: <3af7925c5dad281774b6d12826770cbefb32ea09.camel@collabora.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Tue, 28 May 2019 04:04:35 -0700
Message-ID: <CAPUE2usTOPA52AYzyY=Gupj55ynn=Gwmkjt_7MZC-UZ4KoeebQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] iio: common: cros_ec_sensors: add sysfs attribute
 for frequencies
To:     Fabien Lahoudere <fabien.lahoudere@collabora.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, kernel@collabora.com,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, May 27, 2019 at 2:55 AM Fabien Lahoudere
<fabien.lahoudere@collabora.com> wrote:
>
> Le dimanche 26 mai 2019 =C3=A0 18:45 +0100, Jonathan Cameron a =C3=A9crit=
 :
> > On Thu, 23 May 2019 11:07:36 +0200
> > Fabien Lahoudere <fabien.lahoudere@collabora.com> wrote:
> >
> > > In order to provide minimum and maximum frequencies for each
> > > sensors,
> > > we use a standard API (sampling_frequency_available) to provide
> > > them
> > > to userland.
> > > As cros_ec_sensors_core_init do not manage default attrs, we change
> > > the signature to let all kind of sensors to provide "struct
> > > iio_info"
> > > with their callback. This change impact drivers using that
> > > function.
> > >
> > > Then cros_ec_* sensors provides frequencies range in sysfs like
> > > this:
> > > [min step max]
> > >
> > > Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
> > When I was pointing at the _available syntax I was meaning that
> > the ideal is to implement this using the associated callbacks rather
> > than as a custom sysfs attribute.
> >
>
> Sorry, I misunderstood. Let me retry with that callback implemented.
>
> > > ---
> > >  .../common/cros_ec_sensors/cros_ec_sensors.c  |  6 +--
> > >  .../cros_ec_sensors/cros_ec_sensors_core.c    | 38
> > > +++++++++++++++++++
> > >  drivers/iio/light/cros_ec_light_prox.c        |  6 +--
> > >  drivers/iio/pressure/cros_ec_baro.c           |  6 +--
> > >  .../linux/iio/common/cros_ec_sensors_core.h   |  4 +-
> > >  5 files changed, 50 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> > > b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> > > index 17af4e0fd5f8..a0ecee15a6c8 100644
> > > --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> > > +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> > > @@ -172,7 +172,7 @@ static int cros_ec_sensors_write(struct iio_dev
> > > *indio_dev,
> > >     return ret;
> > >  }
> > >
> > > -static const struct iio_info ec_sensors_info =3D {
> > > +static struct iio_info ec_sensors_info =3D {
> > >     .read_raw =3D &cros_ec_sensors_read,
> > >     .write_raw =3D &cros_ec_sensors_write,
> > >  };
> > > @@ -195,11 +195,11 @@ static int cros_ec_sensors_probe(struct
> > > platform_device *pdev)
> > >     if (!indio_dev)
> > >             return -ENOMEM;
> > >
> > > -   ret =3D cros_ec_sensors_core_init(pdev, indio_dev, true);
> > > +   ret =3D cros_ec_sensors_core_init(pdev, indio_dev,
> > > &ec_sensors_info,
> > > +                                   true);
> > >     if (ret)
> > >             return ret;
> > >
> > > -   indio_dev->info =3D &ec_sensors_info;
> > >     state =3D iio_priv(indio_dev);
> > >     for (channel =3D state->channels, i =3D CROS_EC_SENSOR_X;
> > >          i < CROS_EC_SENSOR_MAX_AXIS; i++, channel++) {
> > > diff --git
> > > a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > > b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > > index ac53ea32c1b1..08fb5d3dc7b5 100644
> > > --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > > +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > > @@ -10,6 +10,7 @@
> > >  #include <linux/iio/buffer.h>
> > >  #include <linux/iio/common/cros_ec_sensors_core.h>
> > >  #include <linux/iio/iio.h>
> > > +#include <linux/iio/sysfs.h>
> > >  #include <linux/iio/kfifo_buf.h>
> > >  #include <linux/iio/trigger_consumer.h>
> > >  #include <linux/kernel.h>
> > > @@ -86,8 +87,42 @@ static int
> > > cros_ec_get_host_cmd_version_mask(struct cros_ec_device *ec_dev,
> > >     return ret;
> > >  }
> > >
> > > +/**
> > > + * cros_ec_sensors_read_freq() - sysfs function to get available
> > > frequencies
> > > + * @dev: Device structure for this device.
> > > + * @attr: Description of the attribute.
> > > + * @buf: Incoming string
> > > + *
> > > + * The later modes are only relevant to the ring buffer - and
> > > depend on current
> > > + * mode. Note that data sheet gives rather wide tolerances for
> > > these so integer
> > > + * division will give good enough answer and not all chips have
> > > them specified
> > > + * at all.
> > > + **/
> > > +static ssize_t cros_ec_sensors_read_freq(struct device *dev,
> > > +                                    struct device_attribute *attr,
> > > +                                    char *buf)
> > > +{
> > > +   struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> > > +   struct cros_ec_sensors_core_state *state =3D iio_priv(indio_dev);
> > > +
> > > +   return snprintf(buf, PAGE_SIZE, "[%d 1 %d]\n", state->min_freq,
> > > +                   state->max_freq);
Step to 1 [Hz?] is not right; EC uses the frequency the sensors
supports, rounded up by default.
Given EC is hiding the sensors it controls, it is not straight-forward
to find the supported frequencies between min_freq and max_freq.
However, sensors mostly follow the following rules:
- "fast" sensors: accelerometer, gyroscope, magnetometer,  barometer:
Supported frequencies are: [ min_freq, max_freq >> n, max_freq >> (n -
1), ... max_freq >> 1, max_freq], where (min_freq >> n) > min_freq.
frequency are expressed in mHz resolution.
- "Slow" sensors: light, proximity:
Any frequencies between min_freq and max_freq are supported.

Note that frequency 0 is accepted, it puts the given sensor in suspend mode=
.

Given that information, it would make sense to follow the existing
macro IIO_DEV_ATTR_SAMP_FREQ_AVAIL and report an array of frequencies,
like bmc150_magn_show_samp_freq_avail does.

Gwendal.

> > Whilst it is a bit more fiddly I would much prefer if this was done
> > with
> > the info_mask_shared_by_all_available bit mask in the iio_dev and
> > providing
> > the read_avail callback.
> >
> > The original reason to introduce this form was as part of trying to
> > (far too slowly) kill off as much hand defined ABI as possible.
> > Ultimate aim is to make the IIO interface optional for cases where
> > the channels are mostly being used by other consumer drivers rather
> > than
> > being directly consumed by userspace.  To do that we need all of
> > these elements to be easily accessible from the consumer hooks.
> >
> >
> >
> > > +}
> > > +
> > > +static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(cros_ec_sensors_read_freq);
> > > +
> > > +static struct attribute *cros_ec_sensors_attributes[] =3D {
> > > +   &iio_dev_attr_sampling_frequency_available.dev_attr.attr,
> > > +   NULL,
> > > +};
> > > +
> > > +static const struct attribute_group
> > > cros_ec_sensors_attribute_group =3D {
> > > +   .attrs =3D cros_ec_sensors_attributes,
> > > +};
> > > +
> > >  int cros_ec_sensors_core_init(struct platform_device *pdev,
> > >                           struct iio_dev *indio_dev,
> > > +                         struct iio_info *info,
> > >                           bool physical_device)
> > >  {
> > >     struct device *dev =3D &pdev->dev;
> > > @@ -149,6 +184,9 @@ int cros_ec_sensors_core_init(struct
> > > platform_device *pdev,
> > >             }
> > >     }
> > >
> > > +   info->attrs =3D &cros_ec_sensors_attribute_group;
> > > +   indio_dev->info =3D info;
> > > +
> > >     return 0;
> > >  }
> > >  EXPORT_SYMBOL_GPL(cros_ec_sensors_core_init);
> > > diff --git a/drivers/iio/light/cros_ec_light_prox.c
> > > b/drivers/iio/light/cros_ec_light_prox.c
> > > index 308ee6ff2e22..1772e339cf14 100644
> > > --- a/drivers/iio/light/cros_ec_light_prox.c
> > > +++ b/drivers/iio/light/cros_ec_light_prox.c
> > > @@ -161,7 +161,7 @@ static int cros_ec_light_prox_write(struct
> > > iio_dev *indio_dev,
> > >     return ret;
> > >  }
> > >
> > > -static const struct iio_info cros_ec_light_prox_info =3D {
> > > +static struct iio_info cros_ec_light_prox_info =3D {
> > >     .read_raw =3D &cros_ec_light_prox_read,
> > >     .write_raw =3D &cros_ec_light_prox_write,
> > >  };
> > > @@ -184,11 +184,11 @@ static int cros_ec_light_prox_probe(struct
> > > platform_device *pdev)
> > >     if (!indio_dev)
> > >             return -ENOMEM;
> > >
> > > -   ret =3D cros_ec_sensors_core_init(pdev, indio_dev, true);
> > > +   ret =3D cros_ec_sensors_core_init(pdev, indio_dev,
> > > +                                   &cros_ec_light_prox_info,
> > > true);
> > >     if (ret)
> > >             return ret;
> > >
> > > -   indio_dev->info =3D &cros_ec_light_prox_info;
> > >     state =3D iio_priv(indio_dev);
> > >     state->core.type =3D state->core.resp->info.type;
> > >     state->core.loc =3D state->core.resp->info.location;
> > > diff --git a/drivers/iio/pressure/cros_ec_baro.c
> > > b/drivers/iio/pressure/cros_ec_baro.c
> > > index 034ce98d6e97..cd3be0f16226 100644
> > > --- a/drivers/iio/pressure/cros_ec_baro.c
> > > +++ b/drivers/iio/pressure/cros_ec_baro.c
> > > @@ -107,7 +107,7 @@ static int cros_ec_baro_write(struct iio_dev
> > > *indio_dev,
> > >     return ret;
> > >  }
> > >
> > > -static const struct iio_info cros_ec_baro_info =3D {
> > > +static struct iio_info cros_ec_baro_info =3D {
> > >     .read_raw =3D &cros_ec_baro_read,
> > >     .write_raw =3D &cros_ec_baro_write,
> > >  };
> > > @@ -130,11 +130,11 @@ static int cros_ec_baro_probe(struct
> > > platform_device *pdev)
> > >     if (!indio_dev)
> > >             return -ENOMEM;
> > >
> > > -   ret =3D cros_ec_sensors_core_init(pdev, indio_dev, true);
> > > +   ret =3D cros_ec_sensors_core_init(pdev, indio_dev,
> > > &cros_ec_baro_info,
> > > +                                   true);
> > >     if (ret)
> > >             return ret;
> > >
> > > -   indio_dev->info =3D &cros_ec_baro_info;
> > >     state =3D iio_priv(indio_dev);
> > >     state->core.type =3D state->core.resp->info.type;
> > >     state->core.loc =3D state->core.resp->info.location;
> > > diff --git a/include/linux/iio/common/cros_ec_sensors_core.h
> > > b/include/linux/iio/common/cros_ec_sensors_core.h
> > > index 32fd08bbcf52..f170a72ac08d 100644
> > > --- a/include/linux/iio/common/cros_ec_sensors_core.h
> > > +++ b/include/linux/iio/common/cros_ec_sensors_core.h
> > > @@ -114,12 +114,14 @@ struct platform_device;
> > >   * cros_ec_sensors_core_init() - basic initialization of the core
> > > structure
> > >   * @pdev:          platform device created for the sensors
> > >   * @indio_dev:             iio device structure of the device
> > > + * @info:          iio info structure with read and write callback
> > >   * @physical_device:       true if the device refers to a physical
> > > device
> > >   *
> > >   * Return: 0 on success, -errno on failure.
> > >   */
> > >  int cros_ec_sensors_core_init(struct platform_device *pdev,
> > > -                         struct iio_dev *indio_dev, bool
> > > physical_device);
> > > +                         struct iio_dev *indio_dev, struct
> > > iio_info *info,
> > > +                         bool physical_device);
> > >
> > >  /**
> > >   * cros_ec_sensors_capture() - the trigger handler function
>
