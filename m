Return-Path: <linux-iio+bounces-20199-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CFEACD783
	for <lists+linux-iio@lfdr.de>; Wed,  4 Jun 2025 07:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AD5C7A86C5
	for <lists+linux-iio@lfdr.de>; Wed,  4 Jun 2025 05:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5522C3251;
	Wed,  4 Jun 2025 05:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1DsKLCiv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0393238145
	for <linux-iio@vger.kernel.org>; Wed,  4 Jun 2025 05:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749015703; cv=none; b=twMyywTQFEKi+n/LSc5broLT/aREUsc8N9254RViITqLpN32FdZk+pHmI0PacOj/zWtcTxDC+s7YIjH1XiWSyowqqN8oOV7EAQyaYq6soWLinaXFWNaPErsHInZEBpOrFmhm1lAz7gArAY+NcDqKasPtci/msozxtrfL50pBn8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749015703; c=relaxed/simple;
	bh=wa8NI9XCwiiquLagLJTd0f5KqlSbPt2a8Tslxyqol8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yx2M6M16Y7EO53DpEb3saptBr1oNKu8ssaD+hur1QmvZAvFC7dAbVyu4ivWAGiL6Ul3xFyWRZ/YYDGtx6vyVmuVRpv6K41NaW3AwptCsTk5A0hxNIsNz3botKfmGb36DNaKIWcNz6p9ZigIODCeM8ylsITv6x2ZCeDpN0PMO3b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1DsKLCiv; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-442eb5d143eso64154915e9.0
        for <linux-iio@vger.kernel.org>; Tue, 03 Jun 2025 22:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749015699; x=1749620499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GeuKz/CGoHUQ9f2sjFofpzB2ID0YZiLZ4U3TJEfKeZY=;
        b=1DsKLCivQYCWJ66fQSX9UPUzp/5oEQdqxi+cmCKds74op13PpumWTHzB1qFPBVPF4v
         gTi9HuWvO9tDPRN7K+w1KhK/iOcwSkAVW0VzsAnsd/ZHMtBjgFWnYDINPAXcQkKwum+O
         5K4TL71leUgL8shELpI5/9M0MmkpGRj7aow1SC42IQHGCK5TVGZSovMFzefpm99uiM0T
         RIONxNsQ6yVYK4hUXoKu/7WBzoYGVRtynAhOUk2ARutZitD9QN54dDce+2RhZzjZC52v
         +/Qyzmre1Fq6EYELCP3vWiJD6uQplE3bXga2nDj4+lqri+9rxKy9mF3EnTnQcU0TAAbQ
         OWDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749015699; x=1749620499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GeuKz/CGoHUQ9f2sjFofpzB2ID0YZiLZ4U3TJEfKeZY=;
        b=Mn+1cZv62U5K3yGmhd5F06xLx2hA9wjm3trPIiBJAljMrdL6GdETWXalmzjrrADmk1
         BbC7SQ64RbINYbt91j/cP+4zJanEii/eDm+Lc11PpxXbaGh7n1LOxV05WdyGr7GZLBJ8
         XKJbckYB77OoNefQQ41+QACZCNtrvddY0XnJI/kg6+PTTI+Bkci9oPXU2TEE6YFlFbfV
         TiTdBP+8fzLaNLQXjYyOOiABIvBJ9sVLNetebugzXJGysVxzkNgpxSfRsu4Z+QaaS5U3
         KsxvKf25JwjUBi7DO8KrjDplZEsT60YyVLM0Lbznp/AhlQilj2wEMHokWefIP5LyS+Yk
         N4sQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBrhYHtcK0I3r3FnsE2gY4PLi4X/1V5OdMKZSkW0MlHA7BLvaSSpMhqIJBx2JHeZvd8oDVhQ5zboM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxVLMT9mn4sDM2F7k93UgDqTKYqdlEe8Z86CSwzVPSuj85NrDr
	xzPak0XAHgw+C/PELlBINi31dCAq+8uSkhiiL8B1jbQczcUw/jjkLUJcMXDF+s6i4/s3ksXJFO4
	3HBjBkok8DjugZ4Gw6VANQtTBMWjd2RBYQho2LMPkYYz8YEMYYLCTbQ==
X-Gm-Gg: ASbGnctywusSX+YnmZ6XJ49F8BgBWDMv4gMwql/n89wFBrBVRKODaDG7UXTqSvUT5Im
	cR2i1L9xAIOZeWVy1c9ZRJiPtJLa4gF33RREQprQq65oOdryg4PxoC9vGMQlto1h/PDdk6Rfjgu
	WHqcCH4NlPxW+preSotQH25T7YkihwBhFAVTGHB8bCmMxHjFVhxY2+09pjarsFO7jRs9+N1/sfg
	Cmu
X-Google-Smtp-Source: AGHT+IFc7HJf2xxlQ66aJPQPfbG+NlPpfQN6Sx17zakP8OTXr4qQVa6P/85X7+ex6xFpskwzx15A8lS+oJmmveJP87Q=
X-Received: by 2002:a05:600c:1c94:b0:450:30e4:bdf6 with SMTP id
 5b1f17b1804b1-451f0b0cfc6mr8998815e9.19.1749015698595; Tue, 03 Jun 2025
 22:41:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523172727.2654957-1-gwendal@google.com> <20250525144233.13df701f@jic23-huawei>
In-Reply-To: <20250525144233.13df701f@jic23-huawei>
From: Gwendal Grignou <gwendal@google.com>
Date: Tue, 3 Jun 2025 22:41:25 -0700
X-Gm-Features: AX0GCFtrn_ceo7qWkVfbiBKQvfr9SxVdfs9XDCViYHyzGG1e2bVDKdh1tO4cnsU
Message-ID: <CAMHSBOUb-HPqmW3CFspipNGQGzbYUV+oqVw-Cbw0Bk4Huwz-QQ@mail.gmail.com>
Subject: Re: [PATCH v4] iio: cros_ec_sensors: add cros_ec_activity driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: Gwendal Grignou <gwendal@chromium.org>, tzungbi@kernel.org, 
	chrome-platform@lists.linux.dev, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jonathan,

Thanks for the thorough review. I just send a v5, much cleaner driver.

Gwendal.

On Sun, May 25, 2025 at 6:42=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Fri, 23 May 2025 10:27:27 -0700
> Gwendal Grignou <gwendal@chromium.org> wrote:
>
> Hi Gwendal,
>
> > ChromeOS EC can report activity information derived from the
> > accelerometer:
> > - Reports on-body/off-body as a proximity event.
>
> How do you do proximity from an accelerometer?
It is a crude proximity detection: The accelerometer is set to ~50Hz
and uses a low pass filter to check for vibration.
It is not vibrating (sitting on a table), then it is in off-body mode.
It is very conservative, erring on the side of on-body: if the table
is in a train, the device may stay in on-body mode. See its
implmentation here
(https://chromium.googlesource.com/chromiumos/platform/ec/+/refs/heads/main=
/common/body_detection.c).
The sensor can be used to leave the device unlocked (see
https://support.google.com/android/answer/9075927#zippy=3D%2Ckeep-your-phon=
e-unlocked-when-its-on-you)
or kick on the CPU fans earlier to keep the device cooler than when it
is on a table.

>
> > - Reports significant motion as an activity event.
>
> This one might be from an accelerometer. In which case is there
> any information on the algorithm?
This one looks at a significant motion a few seconds apart. It can
come directly from the accelerometer, see BMI160 datasheet
(https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/=
bst-bmi160-ds000.pdf)
secion 2.6.2. Or it can be implemented in the firmware of the embedded
controller/sensor hub.

>
> >
> > This new sensor is a virtual sensor, included only when the EC firmware
> > is compiled with the appropriate module.
> >
> > Signed-off-by: Gwendal Grignou <gwendal@google.com>
> > Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
>
>
> Various comments inline.
>
> Biggest question I have is what the significant motion detector
> is based on. Do we know more about that as I'd prefer it associated
> with an actual channel if possible?
These 2 events are indeed currently generated today from the raw
output of a single accelerometer. It does not have to be: we could
further improve the algorithms by fusionning data from the
accelerometer and the gyroscope. As such a virtual sensor is presented
to the kernel by the sensor hub just for the activities.

>
> Also does it only surface as an event?  Is there an underlying
> value to read.
The on-body/off-body algorithm calculates a moving average of the
samples variance and uses an internal threshold to decide the device
state.
The thresholds are model specific (depends on the sensors/device
weight) and a set in the factory.
Same with significant motion; threshold set in the factory based on
experiments decides to trigger an event or not.

>
>
> > diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_activity.c b/dr=
ivers/iio/common/cros_ec_sensors/cros_ec_activity.c
> > new file mode 100644
> > index 000000000000..620203f7aa63
> > --- /dev/null
> > +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_activity.c
> > @@ -0,0 +1,322 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * cros_ec_activity - Driver for activities/gesture recognition.
> > + *
> > + * Copyright 2025 Google, Inc
> > + *
> > + * This driver uses the cros-ec interface to communicate with the Chro=
meOS
> > + * EC about activity data. Accelerometer access is presented through i=
io sysfs.
>
> Maybe update as this isn't returning accelerometer data .
Removed.
>
> > + */
>
> > +
> > +static int ec_sensors_read(struct iio_dev *indio_dev,
>
> Given this only applies to this sensor, maybe needs a more specific name?
>
> > +                        struct iio_chan_spec const *chan,
> > +                        int *val, int *val2, long mask)
> > +{
> > +     struct cros_ec_sensors_state *st =3D iio_priv(indio_dev);
> > +     int ret;
> > +
> > +     mutex_lock(&st->core.cmd_lock);
> Include cleanup.h and use
>
>         guard(mutex)(&st->core.cmd_lock);
> to simpilfy this.
Done. It is indeed much cleaner. I will work on another patch to clean
up the rest of the cros_ec drivers.
>
> > +     if (chan->type =3D=3D IIO_PROXIMITY && mask =3D=3D IIO_CHAN_INFO_=
RAW) {
> > +             st->core.param.cmd =3D MOTIONSENSE_CMD_GET_ACTIVITY;
> > +             st->core.param.get_activity.activity =3D
> > +                     MOTIONSENSE_ACTIVITY_BODY_DETECTION;
> > +             ret =3D cros_ec_motion_send_host_cmd(&st->core, 0);
> > +             if (ret =3D=3D 0) {
> > +                     *val =3D st->core.resp->get_activity.state;
> > +                     ret =3D IIO_VAL_INT;
> With guard magic, can handle error out path and return directly in good p=
ath.
>                 if (ret)
>                         return ret;
>
>                 *val =3D ..
>
>                 return IIO_VAL_INT;
>
> > +             }
> > +     } else {
> > +             ret =3D -EINVAL;
>
> With guard() magic can just return here.
>
> > +     }
> > +     mutex_unlock(&st->core.cmd_lock);
> > +     return ret;
> > +}
> > +
> > +static int cros_ec_read_event_config(struct iio_dev *indio_dev,
> > +                                  const struct iio_chan_spec *chan,
> > +                                  enum iio_event_type type,
> > +                                  enum iio_event_direction dir)
> > +{
> > +     struct cros_ec_sensors_state *st =3D iio_priv(indio_dev);
> > +     int ret;
> > +
> > +     if (chan->type !=3D IIO_ACTIVITY && chan->type !=3D IIO_PROXIMITY=
)
> > +             return -EINVAL;
> > +
> > +     mutex_lock(&st->core.cmd_lock);
>
> Similar to below. guard() will simplify this quite a bit.
>
> > +     st->core.param.cmd =3D MOTIONSENSE_CMD_LIST_ACTIVITIES;
> > +     ret =3D cros_ec_motion_send_host_cmd(&st->core, 0);
> > +     if (ret)
> > +             goto done;
>
> Blank line here.
>
> > +     switch (chan->type) {
> > +     case IIO_PROXIMITY:
> > +             ret =3D !!(st->core.resp->list_activities.enabled &
> > +                      (1 << MOTIONSENSE_ACTIVITY_BODY_DETECTION));
> > +             break;
> > +     case IIO_ACTIVITY:
> > +             if (chan->channel2 =3D=3D IIO_MOD_STILL) {
> > +                     ret =3D !!(st->core.resp->list_activities.enabled=
 &
> > +                              (1 << MOTIONSENSE_ACTIVITY_SIG_MOTION));
> > +             } else {
> > +                     dev_warn(&indio_dev->dev, "Unknown activity: %d\n=
",
> > +                              chan->channel2);
> > +                     ret =3D -EINVAL;
>
> Flip logic and direct returns etc.
>
> > +             }
> > +             break;
> > +     default:
> > +             dev_warn(&indio_dev->dev, "Unknown channel type: %d\n",
> > +                      chan->type);
> > +             ret =3D -EINVAL;
> > +     }
> > +done:
> > +     mutex_unlock(&st->core.cmd_lock);
> > +     return ret;
> > +}
> > +
> > +static int cros_ec_write_event_config(struct iio_dev *indio_dev,
> > +                                   const struct iio_chan_spec *chan,
> > +                                   enum iio_event_type type,
> > +                                   enum iio_event_direction dir, int s=
tate)
> > +{
> > +     struct cros_ec_sensors_state *st =3D iio_priv(indio_dev);
> > +     int ret =3D 0;
> > +
> > +     mutex_lock(&st->core.cmd_lock);
>
> Guard and direct returns. (See below for more on this)
>
> > +     st->core.param.cmd =3D MOTIONSENSE_CMD_SET_ACTIVITY;
> > +     switch (chan->type) {
> > +     case IIO_PROXIMITY:
> > +             st->core.param.set_activity.activity =3D
> > +                     MOTIONSENSE_ACTIVITY_BODY_DETECTION;
> > +             break;
> > +     case IIO_ACTIVITY:
> > +             if (chan->channel2 =3D=3D IIO_MOD_STILL) {
> > +                     st->core.param.set_activity.activity =3D
> > +                             MOTIONSENSE_ACTIVITY_SIG_MOTION;
> > +             } else {
> flip logic so error is out of line and good path inline.  Then with
> guard you an directly return for error path.
>
> > +                     dev_warn(&indio_dev->dev, "Unknown activity: %d\n=
",
> > +                              chan->channel2);
> > +                     ret =3D -EINVAL;
> > +             }
> > +             break;
> > +     default:
> > +             dev_warn(&indio_dev->dev, "Unknown channel type: %d\n",
> > +                      chan->type);
> > +             ret =3D -EINVAL;
>                 return -EINVAL; when using guard()
> > +     }
> > +     if (ret =3D=3D 0) {
>
> Then we only get here if ret =3D=3D 0 so condition can go away.
>
> > +             st->core.param.set_activity.enable =3D state;
> > +             ret =3D cros_ec_motion_send_host_cmd(&st->core, 0);
> > +     }
> > +
> > +     mutex_unlock(&st->core.cmd_lock);
> > +     return ret;
> > +}
> > +
> > +static int cros_ec_activity_push_data(struct iio_dev *indio_dev,
> > +                                   s16 *data,
> > +                                   s64 timestamp)
>
> Can reduce wrap and have a parameters share a line.  Nice to stay under 8=
0
> but this is well below that.
Done
>
> > +{
> > +     struct ec_response_activity_data *activity_data =3D
> > +                     (struct ec_response_activity_data *)data;
> > +     enum motionsensor_activity activity =3D activity_data->activity;
> > +     u8 state =3D activity_data->state;
> > +     const struct cros_ec_sensors_state *st =3D iio_priv(indio_dev);
> > +     const struct iio_chan_spec *chan;
> > +     const struct iio_event_spec *event;
> > +     enum iio_event_direction dir;
> > +     int index;
> > +     u64 ev;
> > +
> > +     switch (activity) {
> > +     case MOTIONSENSE_ACTIVITY_BODY_DETECTION:
> > +             index =3D st->body_detection_channel_index;
> > +             dir =3D state ? IIO_EV_DIR_FALLING : IIO_EV_DIR_RISING;
> > +             break;
> > +     case MOTIONSENSE_ACTIVITY_SIG_MOTION:
> > +             index =3D st->sig_motion_channel_index;
> > +             dir =3D IIO_EV_DIR_FALLING;
>
> Falling stillness is I guess a detection of activity... As below though I=
'd
> like to know if we have any more info on what this is actually measuring?
Since the activity name is "IIO_MOD_STILL", when the sensor detects a
significant motion, we are out of still, so the condition is false,
transitioning from true (1) to false (0), thus falling. Note the event
is a one-off, it has to be retriggered, to prevent an avalanche of
significant motion events.
>
> > +             break;
> > +     default:
> > +             dev_warn(&indio_dev->dev, "Unknown activity: %d\n", activ=
ity);
> > +             return 0;
> > +     }
> > +     chan =3D &st->channels[index];
> > +     event =3D &chan->event_spec[0];
>
> I'd not have so many local variables. Pick some to put inline. Either
> these two or ev.  Just in the interests of shorter code and little
> cost to readability.
Done, removed event.
>
> > +
> > +     ev =3D IIO_UNMOD_EVENT_CODE(chan->type, index, event->type, dir);
> > +     iio_push_event(indio_dev, ev, timestamp);
>
> Blank line here.
> > +     return 0;
> > +}
> > +
> > +static irqreturn_t cros_ec_activity_capture(int irq, void *p)
> > +{
> > +     struct iio_poll_func *pf =3D p;
> > +     struct iio_dev *indio_dev =3D pf->indio_dev;
> > +
> > +     dev_warn(&indio_dev->dev, "%s: Not Expected\n", __func__);
>
> Add a comment on why.
Done.
>
> > +     return IRQ_NONE;
> > +}
>
> > +static int cros_ec_sensors_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev =3D &pdev->dev;
> > +     struct cros_ec_device *ec_device =3D dev_get_drvdata(dev->parent)=
;
> > +     struct iio_dev *indio_dev;
> > +     struct cros_ec_sensors_state *st;
> > +     struct iio_chan_spec *channel;
> > +     unsigned long activities;
> > +     int i, index, ret, nb_activities;
> > +
> > +     if (!ec_device) {
> > +             dev_warn(dev, "No CROS EC device found.\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     indio_dev =3D devm_iio_device_alloc(dev, sizeof(*st));
> > +     if (!indio_dev)
> > +             return -ENOMEM;
> > +
> > +     ret =3D cros_ec_sensors_core_init(pdev, indio_dev, true,
> > +                                     cros_ec_activity_capture);
> > +     if (ret)
> > +             return ret;
> > +
> > +     indio_dev->info =3D &ec_sensors_info;
> > +     st =3D iio_priv(indio_dev);
> > +     st->core.type =3D st->core.resp->info.type;
> > +     st->core.read_ec_sensors_data =3D cros_ec_sensors_read_cmd;
> > +
> > +     /*
> > +      * List all available activities
>
> Single line comment.  also, it's kind of obvious given the name
> of the command so maybe don't bother with the comment at all?
Removed.
>
>
> > +      */
> > +     st->core.param.cmd =3D MOTIONSENSE_CMD_LIST_ACTIVITIES;
> > +     ret =3D cros_ec_motion_send_host_cmd(&st->core, 0);
> > +     if (ret)
> > +             return ret;
>
> I'd put a blank line here to separate the error path out
> from where we carry on to in the good case.
>
> > +     activities =3D st->core.resp->list_activities.enabled |
> > +                  st->core.resp->list_activities.disabled;
> > +     if (!activities)
> > +             return -ENODEV;
> > +
> > +     /* Allocate a channel per activity and one for timestamp */
> > +     nb_activities =3D hweight_long(activities) + 1;
> > +     st->channels =3D devm_kcalloc(dev, nb_activities,
> > +                                 sizeof(*st->channels), GFP_KERNEL);
> > +     if (!st->channels)
> > +             return -ENOMEM;
> > +
> > +     channel =3D &st->channels[0];
> > +     index =3D 0;
> > +     for_each_set_bit(i, &activities, BITS_PER_LONG) {
> > +             /* List all available triggers */
> > +             if (i =3D=3D MOTIONSENSE_ACTIVITY_BODY_DETECTION) {
> > +                     channel->type =3D IIO_PROXIMITY;
> > +                     channel->info_mask_separate =3D BIT(IIO_CHAN_INFO=
_RAW);
> > +                     channel->modified =3D 0;
>
> Not modified is the 'obvious' default so can probably drop that one.
>
> > +                     channel->event_spec =3D cros_ec_body_detect_event=
s;
> > +                     channel->num_event_specs =3D
> > +                             ARRAY_SIZE(cros_ec_body_detect_events);
> > +                     st->body_detection_channel_index =3D index;
> > +             } else {
> > +                     channel->type =3D IIO_ACTIVITY;
>
> This is getting a little creative.  Do we know anything about what the
> underlying detection actually is?  Activity sensor are often some form
> of magnitude sensor on a specific type of data.  I guess if we have no
> idea what this then activity detection makes some sense.
As written earlier, the event is triggered when a threshold is
crossed. So contrary to other activity sensors like walking or
swimming, there is no confidence level, it just happened that we are
not still anymore.

For proximity, since the proximity API is used, the output is either
far or near, there are no distances.
>
> Is it only ever an event?
>
> > +                     channel->modified =3D 1;
> > +                     channel->event_spec =3D cros_ec_activity_single_s=
hot;
> > +                     channel->num_event_specs =3D
> > +                             ARRAY_SIZE(cros_ec_activity_single_shot);
> > +                     if (i =3D=3D MOTIONSENSE_ACTIVITY_SIG_MOTION) {
> > +                             channel->channel2 =3D IIO_MOD_STILL;
> > +                             st->sig_motion_channel_index =3D index;
> > +                     } else {
> > +                             dev_warn(dev, "Unknown activity: %d\n", i=
);
> > +                             continue;
> > +                     }
> > +             }
> > +             channel->ext_info =3D cros_ec_sensors_limited_info;
> > +             channel->scan_index =3D index++;
> > +             channel++;
> > +     }
> > +
> > +     /* Timestamp */
> > +     channel->scan_index =3D index;
> > +     channel->type =3D IIO_TIMESTAMP;
> > +     channel->channel =3D -1;
> > +     channel->scan_type.sign =3D 's';
> > +     channel->scan_type.realbits =3D 64;
> > +     channel->scan_type.storagebits =3D 64;
> > +
> > +     indio_dev->channels =3D st->channels;
> > +     indio_dev->num_channels =3D index + 1;
> > +
> > +     return cros_ec_sensors_core_register(dev, indio_dev,
> > +                                          cros_ec_activity_push_data);
> > +}
> > +
> > +static void cros_ec_sensors_remove(struct platform_device *pdev)
> > +{
> > +     struct iio_dev *indio_dev =3D platform_get_drvdata(pdev);
> > +
> > +     iio_device_unregister(indio_dev);
>
> Why?  The cros_ec_sensors_core_register() uses devm internally
> to clean this up so I'd not expect to see a remove function at all
> for one of these drivers
Removed.
>
> > +}
> > +
> > +static struct platform_driver cros_ec_sensors_platform_driver =3D {
> > +     .driver =3D {
> > +             .name   =3D DRV_NAME,
> > +     },
> > +     .probe          =3D cros_ec_sensors_probe,
> > +     .remove         =3D cros_ec_sensors_remove,
> > +};
> > +module_platform_driver(cros_ec_sensors_platform_driver);
> > +
> > +MODULE_DESCRIPTION("ChromeOS EC activity sensors driver");
> > +MODULE_ALIAS("platform:" DRV_NAME);
> > +MODULE_LICENSE("GPL v2");
> > diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c =
b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > index 64bada1e8678..1bd07ca3abfe 100644
> > --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > @@ -489,6 +489,16 @@ const struct iio_chan_spec_ext_info cros_ec_sensor=
s_ext_info[] =3D {
> >  };
> >  EXPORT_SYMBOL_GPL(cros_ec_sensors_ext_info);
> >
> > +const struct iio_chan_spec_ext_info cros_ec_sensors_limcros_ec_sensors=
_limited_info
ited_info[] =3D {
> > +     {
> > +             .name =3D "id",
> > +             .shared =3D IIO_SHARED_BY_ALL,
> > +             .read =3D cros_ec_sensors_id
> > +     },
> > +     { },
>
> No comma on terminating entries / sentinels like this.  We don't want
> it to be easy to add things after them as that should never happen.
Done for `cros_ec_sensors_ext_info` as well.
>
> > +};
> > +EXPORT_SYMBOL_GPL(cros_ec_sensors_limited_info);
> > +
> >  /**
> >   * cros_ec_sensors_idx_to_reg - convert index into offset in shared me=
mory
> >   * @st:              pointer to state information for device
>
> > diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/l=
inux/platform_data/cros_ec_commands.h
> > index ecf290a0c98f..0f6d53e7cb97 100644
> > --- a/include/linux/platform_data/cros_ec_commands.h
> > +++ b/include/linux/platform_data/cros_ec_commands.h
>
>
> >  struct ec_response_motion_sensor_data {
> >       /* Flags for each sensor. */
> >       uint8_t flags;Each sensor is up to 3-axis.
> > @@ -2454,15 +2465,14 @@ struct ec_response_motion_sensor_data {
> >       uint8_t sensor_num;
> >       /* Each sensor is up to 3-axis. */
> >       union {
> > -             int16_t             data[3];
> > +             int16_t                                  data[3];
>
> I dislike careful alignment like this because of the noise
> it tends to add - this being a classic example.
> I'd just not update the existing field and let one through that isn't
> aligned.
Done.
>
> >               struct __ec_todo_packed {
> > -                     uint16_t    reserved;
> > -                     uint32_t    timestamp;
> > +                     uint16_t                         reserved;
> > +                     uint32_t                         timestamp;
> >               };
> >               struct __ec_todo_unpacked {
> > -                     uint8_t     activity; /* motionsensor_activity */
> > -                     uint8_t     state;
> > -                     int16_t     add_info[2];
> > +                     struct ec_response_activity_data activity_data;
> > +                     int16_t                          add_info[2];
> >               };
> >       };
> >  } __ec_todo_packed;
>
> >
> >  struct ec_motion_sense_activity {
> > @@ -2671,6 +2682,7 @@ struct ec_params_motion_sense {
> >                       uint32_t max_data_vector;
> >               } fifo_read;
> >
> > +             /* Used for MOTIONSENSE_CMD_SET_ACTIVITY */
> >               struct ec_motion_sense_activity set_activity;
> >
> >               /* Used for MOTIONSENSE_CMD_LID_ANGLE */
> > @@ -2716,6 +2728,14 @@ struct ec_params_motion_sense {
> >                        */
> >                       int16_t hys_degree;
> >               } tablet_mode_threshold;
> > +
> > +             /*
> > +              * Used for MOTIONSENSE_CMD_GET_ACTIVITY.
>
> Single line comment works fine here and fits with local style.
>                 /* Used for MOTIONSENSE_CMD_GET_ACTIVITY */
>
> > +              */
> > +             struct __ec_todo_unpacked {
> > +                     uint8_t sensor_num;
> > +                     uint8_t activity;  /* enum motionsensor_activity =
*/
> > +             } get_activity;
> >       };
> >  } __ec_todo_packed;
> >
> > @@ -2833,6 +2853,10 @@ struct ec_response_motion_sense {
> >                       uint16_t hys_degree;
> >               } tablet_mode_threshold;
> >
> > +             /* USED for MOTIONSENSE_CMD_GET_ACTIVITY. */
>
> Maybe no fullstop is more consistent with local style? Only a bit visible
> in this patch and I'm lazy  :)
It is a mix and match in this file. Full stop is supposed to be the
norm, but it was not always been the case. Remove full stop to blend
with other commands.

>
> > +             struct __ec_todo_unpacked {
> > +                     uint8_t     state;
> > +             } get_activity;
> >       };
> >  } __ec_todo_packed;
> >
>

