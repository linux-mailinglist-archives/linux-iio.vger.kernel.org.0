Return-Path: <linux-iio+bounces-18588-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31AE3A99B33
	for <lists+linux-iio@lfdr.de>; Thu, 24 Apr 2025 00:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 670A146468F
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 22:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D1E38382;
	Wed, 23 Apr 2025 22:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MwqrlAYL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5791E5B66
	for <linux-iio@vger.kernel.org>; Wed, 23 Apr 2025 22:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745445918; cv=none; b=Ao451PKf/Ea3by71QgLEYjByrV/WERZ+YJHp1AWxQNjbltnVV8+izsQ8VGk8hfXDw9h0/jeiehJ4jX0pbs6HAUWBd94zVvHRlorDJhXrRg3fzCzKPb1ix1Xwnax1lecpKaPzfJBFKQybNB4WuaXvCzoWJ6UbToo6rfiLQU0EMl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745445918; c=relaxed/simple;
	bh=0RgWlD++dai0ShsK29FeHW5kZU0mhofgjOIuyR4gaas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dl5t4qSPPh0C9vyNoQe0d1UH14woe6lMWczBeFcNHCTKtVEuHzGQCeLWdUqbKuhXLz9c5ZxNquD1m84fhiIp/J7ceTCK2eOHj4Pf9NgbNS6hM1Nhd1CyyQNRLrX0Dp9eSEWSi3wZMWtAXpLrGCGb3lBBjrIZYYPKq8IZSs/9iGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MwqrlAYL; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5259331b31eso163577e0c.0
        for <linux-iio@vger.kernel.org>; Wed, 23 Apr 2025 15:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1745445915; x=1746050715; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OPRkZJ58BSq7sWIenQSBLWI6JDYVj/zzAhaRJ7wMxFY=;
        b=MwqrlAYLth/DJ7N174KBGOHa5ukE2x4/wwTwQPH5RtpNzvW7HCuDc7+6tI3q5jAiul
         LhyUhmvMsZZIPWY8rUouhRgIX4BtFLp82a+ZXC3RS0D7GS8uN4pCGKA/pI6+JSSEApW3
         HOAIyBm1GlsuGoaj0kQqs3cwGX26yN382IyDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745445915; x=1746050715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OPRkZJ58BSq7sWIenQSBLWI6JDYVj/zzAhaRJ7wMxFY=;
        b=s/FRz7XPfdBiPh+yh9avSFBN4wQN/JGijSTHoOM4XrNOXyTgRB8FMyA7Xj+pUBu+/n
         kmubHET1pPr6CPe9Npu3mju+W/18s6gopolQPQqcKOg9IWWw68WzH+iFwJdT+ZaWws+M
         dKmQyzADv0MIRMj+saIu+G40aedP55tsVFeGAyBiM7MQlipRKu86pHR1xZXiP5PZ2XqM
         Jl7LwyJuIiaSYB4kp8VPTERZyAPM6GpejEAM3Jv+5LdhWXZmUp9qCAmlaZQyKFtxTjTR
         zT6AicH95iMgz6iD0wX3quOoC3hgFPgQHpkuoKAR+4rqAXccwHCn39/HAZ4yYJIYLnzw
         tsTQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6ARbNmqDrSCaA+kSfs8rXvv2/ALV6jTLI88SLdTM/GOC8MVo+Bdq96qJ1suI9QxQDo3IM7rI6HVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKxS8jZLq3Hoe8IIc8IQHlEq11ULWbh6xHj+3CSjd130HUoHke
	nH5O6tdV+R7G2eNijBkgwryBsMn4memgwRB8/EbAHvGUMF4QkpR7qmhh9tsGEKhlBanBwzlShBs
	8UL/6osZfUqFkfaC9Vtpm90DxsNXsC10HIY9w
X-Gm-Gg: ASbGncuxB94uns2Ky2IheXOv0Cue8+IxUUbDjODadBwcHCeehnG3D9VO7UkYJmYVtAn
	YkOMakvVRVcEJLaRFJT+PDg3y/eU3L0n/Uds0+wzTuBhTaC0BSkOuINd+AJATTKS8BEFM7/BN7J
	xLdDI6zFZDwtZ2VlyhLtDA5MMku8dVnRkpsSv2FwGpz/zEFAw=
X-Google-Smtp-Source: AGHT+IHACjkHF1JhmqKNvkCjrjFp5IlPqI32PqceAcktEz1uSgkBIbcq3PdfCz48LI4RIIb6CZzBwhSupJSUIeB85DI=
X-Received: by 2002:a05:6122:d85:b0:520:61ee:c814 with SMTP id
 71dfb90a1353d-52a78248971mr404779e0c.1.1745445914934; Wed, 23 Apr 2025
 15:05:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPUE2uuY=BaPFro5cQSmQg4JS1Z5J5aBL7XvqqAo-X=LR4be3Q@mail.gmail.com>
 <20250408155619.2169189-1-gwendal@chromium.org> <20250412114256.41602d67@jic23-huawei>
In-Reply-To: <20250412114256.41602d67@jic23-huawei>
From: Gwendal Grignou <gwendal@chromium.org>
Date: Wed, 23 Apr 2025 15:05:03 -0700
X-Gm-Features: ATxdqUH9kIEs8tPt571DX3_0lEEpV2Ju8NJAKkecugPLh4XsF0QtpQ2-sXXLlPQ
Message-ID: <CAPUE2ut-2Cp9pt_MkhnmrM3R4Lb-3d__3RyJzhQ+xYnoyUpgkw@mail.gmail.com>
Subject: Re: [PATCH v3] iio: cros_ec_sensors: Flush when changing the FIFO timeout
To: Jonathan Cameron <jic23@kernel.org>
Cc: tzungbi@kernel.org, linux-iio@vger.kernel.org, 
	chrome-platform@lists.linux.dev, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 12, 2025 at 3:43=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Tue,  8 Apr 2025 08:56:19 -0700
> Gwendal Grignou <gwendal@chromium.org> wrote:
>
> > |hwfifo_timeout| is used by the EC firmware only when new samples are
> > available.
> > When the timeout changes, espcially when the new timeout is shorter tha=
n
> > the current one, send the samples waiting in the FIFO to the host.
> > Inline the call to transmit |hwfifo_timeout| value to the firmware.
> >
> > Now flush when a sensor is suspended (ODR set to 0) as well.
> >
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> Firstly.  Don't send a new version in reply to an old one.
> In general the reasons for this are:
> 1 - it can get very confusing if a thread gets deeply nested.
> 2 - at least some well known kernel folk start at their most recent email=
s
>     and work backwards when looking for what to review.  They will probab=
ly
>     never get to your thread!
>
> There may be other parts of the kernel that prefer this style, but most
> do not and I've never had anyone 'ask' for it (as opposed to not object).
Point taken. Applied all the comments in v4.

Thanks,
Gwendal.
>
> Various minor comments inline.
>
> Thanks,
> Jonathan
>
> > ---
> > Changes in v3:
> > - Fix error detection when setting the sensor frequency
> >
> > Changes in v2:
> > - Fix sysfs attribute in commit message
> > - Indicated the function to send the content of the attribute is now
> >   inline.
> > - Improve error detection when setting the sensor frequency and flusing
> >   the FIFO.
> >  .../cros_ec_sensors/cros_ec_sensors_core.c    | 50 ++++++++++++-------
> >  1 file changed, 33 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c =
b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > index b1abd6e16c4ba..67ffe88df7b23 100644
> > --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > @@ -103,22 +103,6 @@ static void get_default_min_max_freq(enum motionse=
nsor_type type,
> >       }
> >  }
> >
> > -static int cros_ec_sensor_set_ec_rate(struct cros_ec_sensors_core_stat=
e *st,
> > -                                   int rate)
> > -{
> > -     int ret;
> > -
> > -     if (rate > U16_MAX)
> > -             rate =3D U16_MAX;
> > -
> > -     mutex_lock(&st->cmd_lock);
> > -     st->param.cmd =3D MOTIONSENSE_CMD_EC_RATE;
> > -     st->param.ec_rate.data =3D rate;
> > -     ret =3D cros_ec_motion_send_host_cmd(st, 0);
> > -     mutex_unlock(&st->cmd_lock);
> > -     return ret;
> > -}
> > -
> >  static ssize_t cros_ec_sensor_set_report_latency(struct device *dev,
> >                                                struct device_attribute =
*attr,
> >                                                const char *buf, size_t =
len)
> > @@ -134,7 +118,25 @@ static ssize_t cros_ec_sensor_set_report_latency(s=
truct device *dev,
> >
> >       /* EC rate is in ms. */
> >       latency =3D integer * 1000 + fract / 1000;
> > -     ret =3D cros_ec_sensor_set_ec_rate(st, latency);
> > +
> > +     mutex_lock(&st->cmd_lock);
> Maybe use cleanup.h and
>         guard(mutex)(&st->cmd_lock);
> mostly because it simplifies code and...
> > +     st->param.cmd =3D MOTIONSENSE_CMD_EC_RATE;
> > +     st->param.ec_rate.data =3D min(U16_MAX, latency);
> > +     ret =3D cros_ec_motion_send_host_cmd(st, 0);
> > +     mutex_unlock(&st->cmd_lock);
>
> I'm not sure why you unlock briefly here?
We don't have to; the intent was to let another command waiting go
through since flush can be sent at anytime. But all in all it does not
improve multi-tasking, so removed.
>
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     /*
> > +      * Flush samples currently in the FIFO, especially when the new l=
atency
> > +      * is shorter than the old one: new timeout value is only conside=
red when
> > +      * there is a new sample available. It can take a while for a slo=
w
> > +      * sensor.
> > +      */
> > +     mutex_lock(&st->cmd_lock);
> > +     st->param.cmd =3D MOTIONSENSE_CMD_FIFO_FLUSH;
> > +     ret =3D cros_ec_motion_send_host_cmd(st, 0);
> > +     mutex_unlock(&st->cmd_lock);
> >       if (ret < 0)
> >               return ret;
> >
> > @@ -764,6 +766,8 @@ EXPORT_SYMBOL_GPL(cros_ec_sensors_capture);
> >   * @mask:    specifies which values to be requested
> >   *
> >   * Return:   the type of value returned by the device
> > + *
> > + * cmd_lock mutex held.
>
> Maybe true, but has that changed in a fashion that means this should
> be in this fix patch rather than a follow up improving documentation?
Removed for now.
>
> >   */
> >  int cros_ec_sensors_core_read(struct cros_ec_sensors_core_state *st,
> >                         struct iio_chan_spec const *chan,
> > @@ -836,6 +840,8 @@ EXPORT_SYMBOL_GPL(cros_ec_sensors_core_read_avail);
> >   * @mask:    specifies which values to write
> >   *
> >   * Return:   the type of value returned by the device
> > + *
> > + * cmd_lock mutex held.
> As above.
Removed for now.
>
> >   */
> >  int cros_ec_sensors_core_write(struct cros_ec_sensors_core_state *st,
> >                              struct iio_chan_spec const *chan,
> > @@ -853,6 +859,16 @@ int cros_ec_sensors_core_write(struct cros_ec_sens=
ors_core_state *st,
> >               st->param.sensor_odr.roundup =3D 1;
> >
> >               ret =3D cros_ec_motion_send_host_cmd(st, 0);
> I'd rather see
>                 if (ret)
>                         break;
> given local style.
Done.
>
> Ideal would actually be to make this whole function do direct returns on =
error
> as that is easier to follow in cases like this where there is no cleanup.
> However that change doesn't belong in a fix. Something for another day!
>
> > +
> > +             /* Flush the FIFO in case we are stopping a sensor.
> Comment syntax slightly wrong.
>
>                 /*
>                  * Flush the FIFO
>
> > +              * If the FIFO has just been emptied, pending samples wil=
l be
> > +              * stuck until new samples are available. It will not hap=
pen
> > +              * when all the sensors are stopped.
> > +              */
> > +             if (ret =3D=3D 0 && frequency =3D=3D 0) {
>
> With the break above, only need to check frequency here.
>
> > +                     st->param.cmd =3D MOTIONSENSE_CMD_FIFO_FLUSH;
> > +                     ret =3D cros_ec_motion_send_host_cmd(st, 0);
> > +             }
> >               break;
> >       default:
> >               ret =3D -EINVAL;
>

