Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29565196A47
	for <lists+linux-iio@lfdr.de>; Sun, 29 Mar 2020 01:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgC2AeC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Mar 2020 20:34:02 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39589 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbgC2AeB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 Mar 2020 20:34:01 -0400
Received: by mail-io1-f65.google.com with SMTP id c19so13869981ioo.6
        for <linux-iio@vger.kernel.org>; Sat, 28 Mar 2020 17:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PZOXxamCEJ4pJQooOY8Vo9spEOaO/1ETCDCanMSNcIk=;
        b=YZWIpXz7N7ebsVBY4gyw5EFXHKkiS+YuFdw2uOvHgijvEPadY8XY+aWz8gap8wk7Rp
         7rzRxoip3d5JH6174iB0QAB6qeheTN1A2boFICYooUJjV/i54iTeGsXZ/WtY7jW/TndZ
         c3lnf6UaJX0DJaqaLLDOx9vwp6EFCTOxHJ2rM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PZOXxamCEJ4pJQooOY8Vo9spEOaO/1ETCDCanMSNcIk=;
        b=XzVrmI6fIJBHvFmv7Abc6sIOqs738joXdOcIutfZqy5JgC+OmSrN6SgycVLIS2LAGk
         OKgi3jmtZhteMg4aJKDQt55XtOPKzLelZdadtgOw1nHkpsROlETpbgoHWIlZer6LDgki
         NNBSHYun1VMUyCu+LRiqgWTP0oMa2j9zV2fm4PiYkouBHty6rs7c0PzSGesEphYYlxgh
         QFjwZS71/0VwvMN1rLl6MmRaTXCWXtrDK6r4jXN5RHJ1iDmsVETGCdpcuwFNT3rhhlq+
         MPy7skf+9ua3A+7QcmIt/e5kwCMIzfj40gqwNfdKFv+VGbplUkTLu+wf2kyQ6wGHCRkG
         dQVQ==
X-Gm-Message-State: ANhLgQ2bt++17bbAFRgjLc1jOMV9NFfkwkImKoebJ4hiqrpsQU1itWUx
        z0pMi61ftGE6+Hgy9oRduNol1cJ8apDu0eTRs/uR2A==
X-Google-Smtp-Source: ADFU+vtZgYpobw5MVLLk+5ci/NZSPJCUPVLm2Mda0qDub/Gv1hERtB9YqQQsjao4KhMhGyeptUfOXId1MzgtQD7vZeE=
X-Received: by 2002:a05:6638:733:: with SMTP id j19mr5300490jad.131.1585442039546;
 Sat, 28 Mar 2020 17:33:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200327223443.6006-1-gwendal@chromium.org> <20200327223443.6006-13-gwendal@chromium.org>
 <20200328172256.583b483e@archlinux>
In-Reply-To: <20200328172256.583b483e@archlinux>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Sat, 28 Mar 2020 17:33:48 -0700
Message-ID: <CAPUE2usGMaqieLW+L_Axou1GoVVOEnWDd6huAsqY21iKnMDPzQ@mail.gmail.com>
Subject: Re: [PATCH v7 12/12] iio: cros_ec: flush as hwfifo attribute
To:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Mar 28, 2020 at 10:22 AM Jonathan Cameron
<jic23@jic23.retrosnub.co.uk> wrote:
>
> On Fri, 27 Mar 2020 15:34:43 -0700
> Gwendal Grignou <gwendal@chromium.org> wrote:
>
> > Add buffer/hwfifo_flush. It is not part of the ABI, but it follows ST
> > and HID lead: Tells the sensor hub to send to the host all pending
> > sensor events.
> >
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
>
> Unless I'm missing something there aren't any other drivers providing
> an explicit flush attribute.
The flush attribute comes from a  requirement from Android to ask the
sensorhub to flush the samples still in its FIFO queue. (see
https://source.android.com/devices/sensors/hal-interface#flush_sensor)
It has been implemented in the ST Android HAL, which expects a
hw_fifo_flush attribute.:
https://github.com/STMicroelectronics/STMems_Android_Sensor_HAL_IIO/blob/STMems_Android_Sensor_HAL_IIO/src/utils.cpp#L31

But I misread kernel ST code; as you said, the request to flush
appends only when the buffer is enabled/disabled or the sensor
suspended, it is not exposed to user space.

For Bosh sensor : there is a patch that was proposed a while back:
"http://lkml.iu.edu/hypermail/linux/kernel/1504.3/03270.html", but it
never reached mainline.

For HID, the attribute is defined in the HID specification (31C) :
https://www.usb.org/sites/default/files/hutrr59_-_usages_for_wearables_0.pdf
but I could not find a publicly available proposed change request that uses it.

Anyhow, it was a mistake to put this patch in the current patch set. I
need it on chromebook for supporting Android, but it should be
discussed more widely to have it part of the ABI, or define a better
solution.

> The nearest equivalent is the flush
> callback which reads out stuff that is in a fifo to be read, but which
> hasn't yet reached a watermark to trigger normal readback.
>
> Can we do something similar here?
>
> If not this needs ABI documentation in Documentation/ABI/testing/...
> I'm not keen on it in becoming general ABI unless I'm missing a
> strong argument in favour of it.
>
> Jonathan
Thank you for your support,
Gwendal.
>
>
> > ---
> > No changes in v7.
> > New in v6.
> >
> >  .../cros_ec_sensors/cros_ec_sensors_core.c    | 28 +++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> >
> > diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > index c831915ca7e56..aaf124a82e0e4 100644
> > --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > @@ -113,6 +113,33 @@ static int cros_ec_sensor_set_ec_rate(struct cros_ec_sensors_core_state *st,
> >       return ret;
> >  }
> >
> > +static ssize_t cros_ec_sensors_flush(struct device *dev,
> > +                                  struct device_attribute *attr,
> > +                                  const char *buf, size_t len)
> > +{
> > +     struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > +     struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
> > +     int ret = 0;
> > +     bool flush;
> > +
> > +     ret = strtobool(buf, &flush);
> > +     if (ret < 0)
> > +             return ret;
> > +     if (!flush)
> > +             return -EINVAL;
> > +
> > +     mutex_lock(&st->cmd_lock);
> > +     st->param.cmd = MOTIONSENSE_CMD_FIFO_FLUSH;
> > +     ret = cros_ec_motion_send_host_cmd(st, 0);
> > +     if (ret != 0)
> > +             dev_warn(&indio_dev->dev, "Unable to flush sensor\n");
> > +     mutex_unlock(&st->cmd_lock);
> > +     return ret ? ret : len;
> > +}
> > +
> > +static IIO_DEVICE_ATTR(hwfifo_flush, 0644, NULL,
> > +                    cros_ec_sensors_flush, 0);
> > +
> >  static ssize_t cros_ec_sensor_set_report_latency(struct device *dev,
> >                                                struct device_attribute *attr,
> >                                                const char *buf, size_t len)
> > @@ -175,6 +202,7 @@ static ssize_t hwfifo_watermark_max_show(struct device *dev,
> >  static IIO_DEVICE_ATTR_RO(hwfifo_watermark_max, 0);
> >
> >  const struct attribute *cros_ec_sensor_fifo_attributes[] = {
> > +     &iio_dev_attr_hwfifo_flush.dev_attr.attr,
> >       &iio_dev_attr_hwfifo_timeout.dev_attr.attr,
> >       &iio_dev_attr_hwfifo_watermark_max.dev_attr.attr,
> >       NULL,
>
