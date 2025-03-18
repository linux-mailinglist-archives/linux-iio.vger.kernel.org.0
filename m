Return-Path: <linux-iio+bounces-17061-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 047A8A68087
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 00:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87FE08816F0
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 23:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120942144D5;
	Tue, 18 Mar 2025 23:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWzcBPeB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5791720FAAB;
	Tue, 18 Mar 2025 23:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742339343; cv=none; b=I0QfxnUc5aGM5xMyPeVKIdR6fOTSNobZgovpr/B1sJPUblVoBh44HsqWpuOcEK288Louj2WWKXGmGnxWq+JDMdlPB3i/r2Yet530SDfLiMkr8BEq+m/FdDV0M1HB3q3hkFNIqpyTnFDerQ2O7o0//EQHlqeUFHxRsFlaZbe+ZfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742339343; c=relaxed/simple;
	bh=12IElAGS0JOyhd0a5BjSSccOOg+P4AcS4hnnhXwKjd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SQgUStlO4gk0pqgNHT608RZfz1qAmyvl1q7BivBlh2xzD5jaBk3ymWoGKF7Ah4gno7CsYYNLFNtszV5lNr/PvWsp3Ul8Ue9yTIt3xaNuF9QYAMSQYqZ3C1oqc+fe+zJJw7NsW5GnwQkUYsT5U+jMoUh+qapNKTbori68UTyF+v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GWzcBPeB; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6fee3632ef1so3732467b3.1;
        Tue, 18 Mar 2025 16:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742339340; x=1742944140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xIS/spIxOBDiiXIBqVelLgXqoKj2wc+gtRYIv/Osi60=;
        b=GWzcBPeBqAnHQarfMpqep9Ki/HLn2LCklbp/IaGcW1RZbf8GrOxklshq4tFf8Ftoqb
         cQXVju9oeB5kebzwFq0cetXzDL33BA31R6KJqocFy9yTHJsyIrK+jWwR/lS2xi9JhAVS
         SOSrA5EC6Qa8btMF0QXt4frKFi6OsXtsAeIWpspcEjFO9CQS9TDhGz7J0wYm0a7zc1TJ
         jvuMGJn+e9m1eyy8bLK4vdiQzbzU7n2XhdQYJgErzP6FZpLblRgtTa63+xhwMCMSxSTE
         b2F/WH1Tx1ezYF+9fdi8xs96OdLhB9TQnBn+unzC3Bxz4R/cIqHhXpo6bILhkgoAjLll
         6pXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742339340; x=1742944140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xIS/spIxOBDiiXIBqVelLgXqoKj2wc+gtRYIv/Osi60=;
        b=Si2X0MIx37rZUC9qDT34pQeDWcCt1/k0rVfW5HZCxnJiv1q8Z2LLWuzLqeFpVzPs7L
         vlkUfC0hXbR0Y7R6S6V/QgEr59l1VJWKZe4Ko004YdTymh70h+TFfYUqVCQZYPMCk6BQ
         B15uuulzYvhzUoG44qdV4/QTHIYihHkFfB8GuMKb0sW/+69/DTt/XViqELs83XiEtSmA
         H48l0gFj7b+fkjd7EtbDk7iQrpbFzj/PaL2LeAI9sKeeydLyeJ3fk//E/fYySiSbxlhq
         NMOmlU8jLH86+5HCdXXy8ai03EshNtHs9KH5wRi3KB/3S1iroZ82/RjZthsfEqPmTCwD
         hYAg==
X-Forwarded-Encrypted: i=1; AJvYcCXGe9wbeHHh2saHuTbqTdvVLeWcib29+tKlkBYdCMEyXQVeVWVSpRVAorArndX5aRAQmQgNgdiqxeeKsUNV@vger.kernel.org, AJvYcCXnGsc0GQxNwq4CYxRVZ2v69hxzalj+p7N9M08gHbjQFAMpKWEHrMWYZDNLwR4Gkm1m1U89Eddythw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxENMK0V5Jksf7rGfUD835gXBittKZ3j7gN8EpSdLX46EvbAhr7
	OZn9ofJhNLPv5q8x9OdX9HNvdPu1Z7IhY9y0OV+2XSjl8Ese69f/WLj184CfbeW+bOwF2qnNCHq
	EtKecxedJ1bQyCjGKia2gEpyLcYE=
X-Gm-Gg: ASbGncsFyS22l3eBkvo9IDsI9Nv5X8jCoexE4cL8XBwljy7er0J6uiZI9C5JSLYVs43
	DYGsmLQW3BJDBL3L1jC8R8fZaW/sVsDvJOHpYSvJquSFijoZoKnymrPNjxXMPzvpplNIIZXrpdZ
	SIc2GCfRXGCwpJuoI8t5hLEUDdRg==
X-Google-Smtp-Source: AGHT+IEjVR47CADf3uWFBHBHIPGWbA0aE2MzkK2cipOon093MUvn5RpZDd72vHAeVIhh+zfubRbSUg4Zd3yWws7ZqsA=
X-Received: by 2002:a05:690c:d0b:b0:6fd:45f9:5f65 with SMTP id
 00721157ae682-7009c1dc93emr4425867b3.8.1742339340100; Tue, 18 Mar 2025
 16:09:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313165049.48305-1-l.rubusch@gmail.com> <20250313165049.48305-6-l.rubusch@gmail.com>
 <20250316112057.638626bd@jic23-huawei>
In-Reply-To: <20250316112057.638626bd@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Wed, 19 Mar 2025 00:08:24 +0100
X-Gm-Features: AQ5f1JpIftPJ_Bq2CTCQQSDs8DG8jSji5uxhkTn5lmR1h1EFtQ7YPkCqKKxSJ1U
Message-ID: <CAFXKEHZ+4OyA4AFPkAayetoK3pWfzf8ubrbozJjcjTqTAnHqFw@mail.gmail.com>
Subject: Re: [PATCH v4 05/14] iio: accel: adxl345: add single tap feature
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 16, 2025 at 12:22=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
>
> On Thu, 13 Mar 2025 16:50:40 +0000
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> > Add the single tap feature with a threshold in 62.5mg/LSB points and a
> > scaled duration in us. Keep singletap threshold in regmap cache but
> > the scaled value of duration in us as member variable.
> >
> > Both use IIO channels for individual enable of the x/y/z axis. Initiali=
zes
> > threshold and duration with reasonable content. When an interrupt is
> > caught it will be pushed to the according IIO channel.
> >
>
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
>
> Hi Lothar,
>
> A few things in here are from the discussion that was continuing
> on v3 so I may have said more replying to that.
>
> Anyhow, for now I'll hold off on applying from this point on as
> a few more things to respond to inline.
>
> Jonathan
>
> >
> >  #include "adxl345.h"
> > @@ -31,6 +33,33 @@
> >  #define ADXL345_INT1                 0
> >  #define ADXL345_INT2                 1
> >
> > +#define ADXL345_REG_TAP_AXIS_MSK     GENMASK(2, 0)
> > +
> > +enum adxl345_axis {
> > +     ADXL345_Z_EN =3D BIT(0),
> > +     ADXL345_Y_EN =3D BIT(1),
> > +     ADXL345_X_EN =3D BIT(2),
> > +     /* Suppress double tap detection if value > tap threshold */
> > +     ADXL345_TAP_SUPPRESS =3D BIT(3),
> > +};
> As per feedback (after you sent this!) on v3, I'd drop
> the last value out of the enum, or just use defines and a u8 for
> the one place this is used for local variable storage.
>
>
> > @@ -198,6 +387,132 @@ static int adxl345_write_raw(struct iio_dev *indi=
o_dev,
> >       return -EINVAL;
> >  }
> >
> > +static int adxl345_read_event_config(struct iio_dev *indio_dev,
> > +                                  const struct iio_chan_spec *chan,
> > +                                  enum iio_event_type type,
> > +                                  enum iio_event_direction dir)
> > +{
> > +     struct adxl345_state *st =3D iio_priv(indio_dev);
> > +     bool int_en;
> > +     int ret =3D -EFAULT;
> Not used?
>
> > +
> > +     switch (type) {
> > +     case IIO_EV_TYPE_GESTURE:
> > +             switch (dir) {
> > +             case IIO_EV_DIR_SINGLETAP:
> > +                     ret =3D adxl345_is_tap_en(st, chan->channel2,
> > +                                             ADXL345_SINGLE_TAP, &int_=
en);
> > +                     if (ret)
> > +                             return ret;
> > +                     return int_en;
> > +             default:
> > +                     return -EINVAL;
> > +             }
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +}
>
> > +static int adxl345_write_event_value(struct iio_dev *indio_dev,
> > +                                  const struct iio_chan_spec *chan,
> > +                                  enum iio_event_type type,
> > +                                  enum iio_event_direction dir,
> > +                                  enum iio_event_info info,
> > +                                  int val, int val2)
> > +{
> > +     struct adxl345_state *st =3D iio_priv(indio_dev);
> > +     int ret;
> > +
> > +     ret =3D adxl345_set_measure_en(st, false);
> > +     if (ret)
> > +             return ret;
> > +
> So in my brief reply to the v3 discussion I suggested perhaps
> factoring out everything from here...
> > +     switch (type) {
> > +     case IIO_EV_TYPE_GESTURE:
> > +             switch (info) {
> > +             case IIO_EV_INFO_VALUE:
> > +                     ret =3D regmap_write(st->regmap, ADXL345_REG_THRE=
SH_TAP,
> > +                                        min(val, 0xFF));
> > +                     break;
> > +             case IIO_EV_INFO_TIMEOUT:
> > +                     ret =3D adxl345_set_tap_duration(st, val, val2);
> > +                     break;
> > +             default:
> > +                     ret =3D -EINVAL;
> > +                     break;
> > +             }
> > +             break;
> > +     default:
> > +             ret =3D -EINVAL;
> > +             break;
> > +     }
> to here, so as to allow simple direct returns.
>
> I think that will make the code more readable given the need to reenable
> measurements and that you want to leave it off on error.
>

Sorry for replying again on this topic. Pls, find my solution in v5.

After some thinking, I implemented it now using returns directly leaving th=
e
measurement on/off as is. I'm unsure if it actually makes sense, after an e=
rror
here to turn measurement on again? I can imagine a situation where a wrong
input might result in an error. Nothing is changed, and measurement
could/should continue. Now, it will probably stop, in case of wrong
input. But is
wrong input actually an issue here?

As other alternative, I can think of is to shift measurement on/off
into the called
functions directly. I think, this approach was used also in the
ADXL380 and seems
to be common. Let me know what you think.

> > +
> > +     if (ret)
> > +             return ret; /* measurement stays off */
> > +
> > +     return adxl345_set_measure_en(st, true);
> > +}
>

