Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C96E731A550
	for <lists+linux-iio@lfdr.de>; Fri, 12 Feb 2021 20:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbhBLTXu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Feb 2021 14:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbhBLTX3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Feb 2021 14:23:29 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0766C061756
        for <linux-iio@vger.kernel.org>; Fri, 12 Feb 2021 11:22:49 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id n14so329173iog.3
        for <linux-iio@vger.kernel.org>; Fri, 12 Feb 2021 11:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LxS5cUpKBcl5T2WAI80JBd2lVKJgCFSoSzgoNxoL1Hs=;
        b=G7yR+HAcsA5Kd+v7dV8kNIedjfbNhvZi0El63ZC1o1gIr2OHZPhC5rVAMrvMuVAkbi
         8Cuf2eoWvpkYc6dLG2bR8zUAv4AtGlLOrKS2MHBqAPgZNhRyC/+8z6ri/YnQrS7zerxz
         6OZ8bT6o6JFhzohpPgam8FYS7BXvi8ExKD2HY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LxS5cUpKBcl5T2WAI80JBd2lVKJgCFSoSzgoNxoL1Hs=;
        b=jG91HOFgpCwagte/YCeUNf67L6rR+5FDMk3TSsPiqb1twB6s1HPOEaHI0kP6UXMhKL
         fa24OwW+XsxwshBXWoTszFpsf8LyQvqNLIfpeuZqOLEWOdSy9RZ+1rdGPRIA3zvP0QmU
         Kw3hVX1dk60E9zVNplN9eZkyUAMaCEY6dh4ewUEyOfyZkLlvHjqX8TxP713j3GI0oUH4
         o3mBqF34+hHvUe+aDcsU4bP8maqTS0OlEAY4FdCILHhEpWbLDDZU3MORq4ieT4u669vz
         3N0qcux7GDl5ogtknUQKgq2O1d+B2qBW+jEcZ7luKhYc6hujXDgZeQ/U+ZK4d7QUkNCz
         IMQQ==
X-Gm-Message-State: AOAM533W33gg/bXU2WJXOtV/RokzPvPsbB+JbOOwmWG1my7DW9CFd6SH
        C1UcjeGTQ7NHqsZi1wgtjuEUeC8O+TcQ2CfksbpktQ==
X-Google-Smtp-Source: ABdhPJytFpkHF+pnnx6a4gFjrnD5D+CJzbAz8JxcOO6nz/qiIysdtGVWbJndsqCxTHJfuzoiiLDi6a3eTnedrVPfFUY=
X-Received: by 2002:a6b:7501:: with SMTP id l1mr3253466ioh.92.1613157769086;
 Fri, 12 Feb 2021 11:22:49 -0800 (PST)
MIME-Version: 1.0
References: <20210210025142.3609708-1-swboyd@chromium.org> <20210210025142.3609708-4-swboyd@chromium.org>
 <CAPUE2utey1os_CmYxHdmObCSPZWFGrLCVfP24wuZj_iQDNqQ5Q@mail.gmail.com> <161297912701.418021.12174983952645253802@swboyd.mtv.corp.google.com>
In-Reply-To: <161297912701.418021.12174983952645253802@swboyd.mtv.corp.google.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Fri, 12 Feb 2021 11:22:37 -0800
Message-ID: <CAPUE2uvGaO_qpfg2S4vmcLto65eTzngbhL-pVcXKuS48r8zghQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] iio: proximity: Add a ChromeOS EC MKBP proximity driver
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Feb 10, 2021 at 9:45 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Gwendal Grignou (2021-02-10 00:29:45)
> > On Tue, Feb 9, 2021 at 6:51 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > > +       if (event_type == EC_MKBP_EVENT_SWITCH) {
> > > +               data = container_of(nb, struct cros_ec_mkbp_proximity_data,
> > > +                                   notifier);
> > > +               indio_dev = data->indio_dev;
> > > +
> > > +               mutex_lock(&data->lock);
> > > +               if (data->enabled) {
> > > +                       timestamp = ktime_to_ns(ec->last_event_time);
> > Note to self, ktime_to_ns is a noop, but make code cleaner: need to
> > change other access to ec->last_event_time.
> >
> > > +                       if (iio_device_get_clock(indio_dev) != CLOCK_BOOTTIME)
> > > +                               timestamp = iio_get_time_ns(indio_dev);
> > > +                       state = cros_ec_mkbp_proximity_parse_state(switches);
> >
> > There can be several switches in the EC (lid open, tablet mode, ...),
> > so you can get a switch event even when the proximity switch did not
> > trigger.
> > You can keep the current state and push an iio event only when there
> > is a change. See cbas_ec_notify().
> >
>
> Ah ok. So we'll have to save a state tracking variable and poll the bit
> once at boot and then at resume time?
Required at boot: There is provision in the EC to report switch events
at init mkbp_report_switch_on_init(), but that's only useful when EC
reboots or transitions from RO to RW while AP is up.
No need to peek at resume time: the EC will send a switch event if the
mask has changed during suspend: when the AP is sleeping, EC just put
the event in a FIFO. But looking at the code, the FIFO can get full,
so if no switch events can be added, we lose them - see
mkbp_fifo_add()).
Then cros_ec_report_events_during_suspend() will gather these events.
> What happens to events that happen across suspend/resume? We drop them?
We should not drop them: if the user gets close while the device is
suspended and she resumes it, we should be able to send that info to
the user space.
EV stores switches values in a single field |mkbp_switch_state|, so 2
events that nullify themselves during suspend will be ignored.
> Or we need to inject the last state
> if it's different into IIO with the time of resume?
The notifier routine will be called. Looking at the code, the ec
last_event_time is not updated, I need to fix cros_ec_resume().
>
> > > +                       dir = state ? IIO_EV_DIR_FALLING : IIO_EV_DIR_RISING;
> > > +
> > > +                       ev = IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, 0,
> > > +                                                 IIO_EV_TYPE_THRESH, dir);
> > > +                       iio_push_event(indio_dev, ev, timestamp);
> > > +               }
> > > +               mutex_unlock(&data->lock);
> > > +       }
> > > +
> > > +       return NOTIFY_OK;
> > > +}
> > > +
> > > +static int cros_ec_mkbp_proximity_read_raw(struct iio_dev *indio_dev,
> > > +                          const struct iio_chan_spec *chan, int *val,
> > > +                          int *val2, long mask)
> > > +{
> > > +       struct cros_ec_mkbp_proximity_data *data = iio_priv(indio_dev);
> > > +       struct cros_ec_device *ec = data->ec;
> > > +
> > > +       if (chan->type != IIO_PROXIMITY)
> > > +               return -EINVAL;
> > > +
> > > +       switch (mask) {
> >
> > A switch is not necessary here.
>
> Ok.
>
> > > +       case IIO_CHAN_INFO_RAW:
