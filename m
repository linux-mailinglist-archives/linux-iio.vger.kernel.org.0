Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEB05316D22
	for <lists+linux-iio@lfdr.de>; Wed, 10 Feb 2021 18:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbhBJRqP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 Feb 2021 12:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232996AbhBJRqK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 Feb 2021 12:46:10 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20D6C0613D6
        for <linux-iio@vger.kernel.org>; Wed, 10 Feb 2021 09:45:29 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id t2so1570559pjq.2
        for <linux-iio@vger.kernel.org>; Wed, 10 Feb 2021 09:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=s4db3FRFo7X4YqxZjmvCCj3kJmcqGswyfAjEtyKKTcM=;
        b=d/yxt0YF7Spef0pYWLcNzTCagPindemCuIlhwf5UCBCZj26bF+6X17K2dn8M+CqXQ4
         /zHlOXfQJAwlwJlUvhoL+KjJvQ7kpHJ6/mEU4i//0H885VsH35aJY2IK9Ow49wWvVeZF
         Z35qIWRm5HEMJMl2RViUhCmygcN+Pu17CD+Ho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=s4db3FRFo7X4YqxZjmvCCj3kJmcqGswyfAjEtyKKTcM=;
        b=DrZZVvxhtqW/Car9ZWbyIEsQdJsYGIJnpalqoWzYMPg+DJwm6f/9GRR75dZLiZf9wM
         c8+AHUzy8fsSweOm8doCVctayhSutWIuPHpXnRyYJiyNATQo2E8VA/x7Y+b+IUR24TQ3
         EX0AhtvJCBce7OHCkZTB/IJMFAxkSg/seORhb8MXHiJJTT2Ou0pegUZxI7sDfszT2x4R
         7XGS4QkZBNMTP5HZZxRKhCP0JdJ4BSOFJymw0NWFxJu1S7DmjHK9Oy0Ki/KIzgdg8S4M
         xJuBxsN+Oi/CzVzJG5PjoylUw2cggrYoAgQnUfhoLtfe3v4DjlA6gowFR2VGPcsT3hLQ
         Wjag==
X-Gm-Message-State: AOAM531lKpd5UfewZPp2Zay2SezmMXPl8SSzjII/3og109Q6c9D2nJq5
        IJ1k6TgxkBcak8McMUyTgN6N7A==
X-Google-Smtp-Source: ABdhPJwEeMPlzTPD+9Z7iAFpSugf02Wwi01Nji6DCsWB/yHqXoE/eEFXv04Fh0uXGGgv16yIpJjaQQ==
X-Received: by 2002:a17:90a:7525:: with SMTP id q34mr58078pjk.88.1612979129245;
        Wed, 10 Feb 2021 09:45:29 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:5533:1106:2710:3ce])
        by smtp.gmail.com with ESMTPSA id a37sm2980467pgm.79.2021.02.10.09.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 09:45:28 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAPUE2utey1os_CmYxHdmObCSPZWFGrLCVfP24wuZj_iQDNqQ5Q@mail.gmail.com>
References: <20210210025142.3609708-1-swboyd@chromium.org> <20210210025142.3609708-4-swboyd@chromium.org> <CAPUE2utey1os_CmYxHdmObCSPZWFGrLCVfP24wuZj_iQDNqQ5Q@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] iio: proximity: Add a ChromeOS EC MKBP proximity driver
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     Gwendal Grignou <gwendal@chromium.org>
Date:   Wed, 10 Feb 2021 09:45:27 -0800
Message-ID: <161297912701.418021.12174983952645253802@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Gwendal Grignou (2021-02-10 00:29:45)
> On Tue, Feb 9, 2021 at 6:51 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > +       if (event_type =3D=3D EC_MKBP_EVENT_SWITCH) {
> > +               data =3D container_of(nb, struct cros_ec_mkbp_proximity=
_data,
> > +                                   notifier);
> > +               indio_dev =3D data->indio_dev;
> > +
> > +               mutex_lock(&data->lock);
> > +               if (data->enabled) {
> > +                       timestamp =3D ktime_to_ns(ec->last_event_time);
> Note to self, ktime_to_ns is a noop, but make code cleaner: need to
> change other access to ec->last_event_time.
>
> > +                       if (iio_device_get_clock(indio_dev) !=3D CLOCK_=
BOOTTIME)
> > +                               timestamp =3D iio_get_time_ns(indio_dev=
);
> > +                       state =3D cros_ec_mkbp_proximity_parse_state(sw=
itches);
>
> There can be several switches in the EC (lid open, tablet mode, ...),
> so you can get a switch event even when the proximity switch did not
> trigger.
> You can keep the current state and push an iio event only when there
> is a change. See cbas_ec_notify().
>

Ah ok. So we'll have to save a state tracking variable and poll the bit
once at boot and then at resume time? What happens to events that happen
across suspend/resume? We drop them? Or we need to inject the last state
if it's different into IIO with the time of resume?

> > +                       dir =3D state ? IIO_EV_DIR_FALLING : IIO_EV_DIR=
_RISING;
> > +
> > +                       ev =3D IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, 0,
> > +                                                 IIO_EV_TYPE_THRESH, d=
ir);
> > +                       iio_push_event(indio_dev, ev, timestamp);
> > +               }
> > +               mutex_unlock(&data->lock);
> > +       }
> > +
> > +       return NOTIFY_OK;
> > +}
> > +
> > +static int cros_ec_mkbp_proximity_read_raw(struct iio_dev *indio_dev,
> > +                          const struct iio_chan_spec *chan, int *val,
> > +                          int *val2, long mask)
> > +{
> > +       struct cros_ec_mkbp_proximity_data *data =3D iio_priv(indio_dev=
);
> > +       struct cros_ec_device *ec =3D data->ec;
> > +
> > +       if (chan->type !=3D IIO_PROXIMITY)
> > +               return -EINVAL;
> > +
> > +       switch (mask) {
>
> A switch is not necessary here.

Ok.

> > +       case IIO_CHAN_INFO_RAW:
