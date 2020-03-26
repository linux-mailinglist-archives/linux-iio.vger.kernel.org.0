Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F287193B5A
	for <lists+linux-iio@lfdr.de>; Thu, 26 Mar 2020 09:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgCZI4T (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Mar 2020 04:56:19 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44220 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgCZI4T (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Mar 2020 04:56:19 -0400
Received: by mail-io1-f66.google.com with SMTP id v3so5166151iot.11
        for <linux-iio@vger.kernel.org>; Thu, 26 Mar 2020 01:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B4BkKkSWsXgd9zhr3xGlzgu7rQZxjaKeG55M2mFPNmM=;
        b=Y5WYiPh4K1lNsZW7ekBaN2gk0Gty0qBY1OAqswpyRemzCKfnLTP9AZonz92H/kqTI9
         UBWYktedINkOj9BA/JvUxpMwx/1+DgjSDGE2D49DIsR1Ka684azz4xS1UNYltHw3Q4Ip
         2nSZr+GJC7JtcDZ7L1CSHbhxI2iv5IoRNc1Lg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B4BkKkSWsXgd9zhr3xGlzgu7rQZxjaKeG55M2mFPNmM=;
        b=ChhUnGeu+cQRvflKVNKS4RJQrDROzaJnnpYXR20tklf7uir7uT3yWIiwOlBpq8iI4G
         io3H7r6BAneLciruRJ4BnQNsJ+Sjc0IAlUjDmg8M7KaRDA82gdkd6ojwgPCY/2q0m4UI
         XmLbpUY7HbAAIJBYTHPKyZIruA65FK6zWWaVEITT8QB2+xOxUqxuT68YARP8XbQqSs8s
         d46B0rMzbWnTM9ZBd5kP31ZfNq+jRmpL3IRbmBdCVbZMQ5LHi/Y96nZGKUjIxxh+rb5p
         Lz2+3p8yE4o5QJz/4l8aQVgrkBGiC3hmpDlBgumIaBO2VLNlTMN3Aqvy4oDB/3i8aY8K
         LwBA==
X-Gm-Message-State: ANhLgQ1q4k0a9L9ZNwKW6MMjrDIiO0/78d8YTXpMdb31oOWyZOosU3XL
        gBb0QlTolVJsqgxocY+NvyycMIVXocIQrvvoJrmcmqcalZg=
X-Google-Smtp-Source: ADFU+vu3Aj7r8bt/5fXJjo5M+vxQmLU7QpupN9Z40j0q7Vn1qJy6ni6vhLPryvDgJnekPhQFIHj7uKM1SCTyqOcvGzM=
X-Received: by 2002:a5e:990d:: with SMTP id t13mr6873751ioj.52.1585212978063;
 Thu, 26 Mar 2020 01:56:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200324202736.243314-1-gwendal@chromium.org> <20200324202736.243314-2-gwendal@chromium.org>
 <399a282a-e6a6-a1ed-26c4-1999008f242d@collabora.com>
In-Reply-To: <399a282a-e6a6-a1ed-26c4-1999008f242d@collabora.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Thu, 26 Mar 2020 01:56:06 -0700
Message-ID: <CAPUE2uvZdbeU0zAgCGErDbDqu-VifVuNcLzvuo6mYY1MwYsaPQ@mail.gmail.com>
Subject: Re: [PATCH v6 01/11] platform: chrome: sensorhub: Add FIFO support
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Mar 25, 2020 at 9:28 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Gwendal,
>
> Many thanks for sending this series upstream. Just one comment, other than that
> looks good to me.
>
> On 24/3/20 21:27, Gwendal Grignou wrote:
> > cros_ec_sensorhub registers a listener and query motion sense FIFO,
> > spread to iio sensors registers.
> >
> > To test, we can use libiio:
> > iiod&
> > iio_readdev -u ip:localhost -T 10000 -s 25 -b 16 cros-ec-gyro | od -x
> >
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
>
> [snip]
>
> > +/**
> > + * cros_ec_sensorhub_ring_handler() - The trigger handler function
> > + *
> > + * @sensorhub: Sensor Hub object.
> > + *
> > + * Called by the notifier, process the EC sensor FIFO queue.
> > + */
> > +static void cros_ec_sensorhub_ring_handler(struct cros_ec_sensorhub *sensorhub)
> > +{
> > +     struct cros_ec_fifo_info *fifo_info = &sensorhub->fifo_info;
> > +     struct cros_ec_dev *ec = sensorhub->ec;
> > +     ktime_t fifo_timestamp, current_timestamp;
> > +     int i, j, number_data, ret;
> > +     unsigned long sensor_mask = 0;
> > +     struct ec_response_motion_sensor_data *in;
> > +     struct cros_ec_sensors_ring_sample *out, *last_out;
> > +
> > +     mutex_lock(&sensorhub->cmd_lock);
> > +
> > +     /* Get FIFO information if there are lost vectors. */
> > +     if (fifo_info->info.total_lost) {
> > +             /* Need to retrieve the number of lost vectors per sensor */
> > +             sensorhub->params->cmd = MOTIONSENSE_CMD_FIFO_INFO;
> > +             sensorhub->msg->outsize = 1;
> > +             sensorhub->msg->insize =
> > +                     sizeof(struct ec_response_motion_sense_fifo_info) +
> > +                     sizeof(u16) * CROS_EC_SENSOR_MAX;
> > +
> > +             if (cros_ec_cmd_xfer_status(ec->ec_dev, sensorhub->msg) < 0)
> > +                     goto error;
> > +
> > +             memcpy(fifo_info, &sensorhub->resp->fifo_info,
> > +                    sizeof(*fifo_info));
> > +
>
> Smatch is reporting:
Which version of smatch are you using? I am using
v0.5.0-6279-g2f013029 and the problem is not reported.
>
> cros_ec_sensorhub_ring_handler() error: memcpy() '&sensorhub->resp->fifo_info'
> too small (10 vs 42)
>
> Is it fine and safe to copy always the 42 bytes? I suspect that we should only
> copy the number of lost events, total_lost , not always the maximum (16). Or the
> EC is always sending the full array (16 bytes)?
EC will not fill the 42 bytes if it has less than 16 sensors. It is
safe because we are not looking at the bytes we don't need, but it is
not clean.
Working on a new patch set where I remove the CROS_EC_SENSOR_MAX
constant and dynamically allocate the data I need based on the number
of sensors.
>
> Thanks,
> Enric
>
