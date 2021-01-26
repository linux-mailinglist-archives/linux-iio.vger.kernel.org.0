Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 417D3305187
	for <lists+linux-iio@lfdr.de>; Wed, 27 Jan 2021 05:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238247AbhA0E4f (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 Jan 2021 23:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405855AbhAZVAr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 26 Jan 2021 16:00:47 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BD2C0613D6
        for <linux-iio@vger.kernel.org>; Tue, 26 Jan 2021 13:00:02 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id 16so6056350ioz.5
        for <linux-iio@vger.kernel.org>; Tue, 26 Jan 2021 13:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M2I9sdcBhNd2ZDpjOFUA3JTjooXZgJestl6B5WtLqYw=;
        b=gxFNJhfN4Chrhg5kdayB/ftyn/fnw2+Wb29YdrTDNZLITfcjnAYGg/UCD9KQ9iBKVq
         BTLngUgnymBGRjQPJU1AR8aQOyBGqngK8WBqyzvUVBBi2UozLEtk86hlfMu1L/tZvD8F
         LHE3q/aRZAw4CozvujuR16fcm3Ff9Ar9NX+HI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M2I9sdcBhNd2ZDpjOFUA3JTjooXZgJestl6B5WtLqYw=;
        b=Chy4wxvEhyXnwzrcR4q8GCcQximy3jD3txPx/W78MhxPbGFnWGC66F6coPnji3Nl0x
         y25lTJ/jdQDcKTir0c/nf405L2o9LkogIUXCCAZJnjdjOA33Hk07+u28hrzJIeByjMy/
         WTIdwJu0A+uybMM/U97e4Q1WUtUxh/LzCwOaFISmg5Z3tIcL7/jvdxT8aij4D+U6v9eM
         0pz0quVUYbBUi990IpTFrYYb5uy99tncdf8swRfxZXyk8hv5BvTzgzS00yitxjXItgut
         KfL0bP9cPnybFmMckDD2hDXnM9v3w5+KPwTUZNwdSSQi/l597uWsB0SRDQL9md0Vj87O
         pfYQ==
X-Gm-Message-State: AOAM532SlXIpVaRGKoap/Ds7MyncCSUloGaQ7n9vxwlSkMFdkct/lb2g
        4RGdOcnI/3HCbgv2XSomeLO0xLTGaUW3rqxG0kteVA==
X-Google-Smtp-Source: ABdhPJzvH7Kidi4YOoM0fLFVkzyTXOAV6ZfOIiPcZ3USyJUikHCwq2RYFlwUjIIUAbctdiscwBVKEW0PTWMU/GTDmuQ=
X-Received: by 2002:a05:6e02:6ce:: with SMTP id p14mr5849847ils.50.1611694802243;
 Tue, 26 Jan 2021 13:00:02 -0800 (PST)
MIME-Version: 1.0
References: <20210122225443.186184-1-swboyd@chromium.org> <20210122225443.186184-4-swboyd@chromium.org>
 <20210124173820.4528b9c9@archlinux> <CAPUE2uuQsa7=pjw+D=r0QtLGTd1kQa7X6VBVa73=gx47Vf7KDA@mail.gmail.com>
 <161160076017.76967.4467861058817044169@swboyd.mtv.corp.google.com>
 <CAPUE2uu555NT1=u=1Nb8WExT7RvK8mj5kBiDfGymHiAmoj2WCg@mail.gmail.com> <161161826068.76967.15170332425672601158@swboyd.mtv.corp.google.com>
In-Reply-To: <161161826068.76967.15170332425672601158@swboyd.mtv.corp.google.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Tue, 26 Jan 2021 12:59:50 -0800
Message-ID: <CAPUE2uuf-7h2Zjvb7bVqPb+=KSMKfAV-vopey1XwP0U+AGRZAA@mail.gmail.com>
Subject: Re: [PATCH 3/3] iio: proximity: Add a ChromeOS EC MKBP proximity driver
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jan 25, 2021 at 3:44 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Gwendal Grignou (2021-01-25 14:28:46)
> > On Mon, Jan 25, 2021 at 10:52 AM Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > > Quoting Gwendal Grignou (2021-01-24 13:41:44)
> > > > On Sun, Jan 24, 2021 at 9:38 AM Jonathan Cameron <jic23@kernel.org> wrote:
> > > > >
> > > > > On Fri, 22 Jan 2021 14:54:43 -0800
> > > > > Stephen Boyd <swboyd@chromium.org> wrote:
> > > > > > +     if (event_type == EC_MKBP_EVENT_SWITCH) {
> > > > > > +             data = container_of(nb, struct cros_ec_proximity_data, notifier);
> > > > > > +             indio_dev = data->indio_dev;
> > > > > > +
> > > > > > +             mutex_lock(&data->lock);
> > > > > > +             if (data->enabled) {
> > > > > > +                     timestamp = iio_get_time_ns(indio_dev);
> > > > For Android, given the timestamp must be time it happens, not reported
> > > > [https://source.android.com/devices/sensors/sensors-hal2] """The
> > > > timestamp must be accurate and correspond to the time at which the
> > > > event physically happened, not the time it was reported.""", consider
> > > > using ec_dev->last_event_time and apply a delta if the iio clock base
> > > > is different from CLOCK_BOOTTIME.
> > >
> > > Ah alright. Is there a reason why cros_ec_get_time_ns() is using
> > > boottime instead of plain ktime_get(), i.e. CLOCK_MONOTONIC? Otherwise I
> > > suppose some sort of cros_ec API should be exposed to convert the
> > > last_event_time to whatever clock base is desired. Does that exist?
> > CLOCK_BOOTTIME was chosen to be Android compliant, as it includes
> > suspend time and match elapsedRealtime() [see
> > https://developer.android.com/reference/android/os/SystemClock#elapsedRealtime()]
> > Chromebook set iio clock reference for all sensor to CLOCK_BOOTTIME
> > (see https://chromium.googlesource.com/chromiumos/platform2/+/HEAD/mems_setup/configuration.cc#127).
> > In case the iio device clock_id is not CLOCK_BOOTTIME/"bootime", we
> > need to add a delta, like in cros_ec_sensors_push_data()
> > [https://elixir.bootlin.com/linux/latest/source/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c#L210]
>
> The delta may help but what if the clock is adjusted in the time between
> the event is timestamped and this driver reading the timestamp? That
> could lead to some odd behavior where the timestamp is in the future
> because we don't know what sort of adjustment was made, e.g. the
> realtime clock being moved back in time.
>
> I'd rather have a way to request that cros_ec core timestamp the event
> with some clock base that this driver desires,
ec_dev->last_event_time is collected outside of the IIO stack, and can
be used by multiple drivers.

> instead of having to do
> an offset after the fact. For now I'll use ec_dev->last_event_time
> because this is only used on chromeos and that should work until
> userspace is changed, but in the future I think we'll need to have a way
> for this IIO device to be notified when the clock base changes in
> iio_device_set_clock() and then have this driver call into cros_ec to
> request that such a timestamp be made when this event is seen. Or even
> better have a way to request that cros_ec timestamp the event itself on
> the EC side, but I don't know if that's possible.
One way would be use the EC sensor stack that collect such timestamp,
but that would be more firmware changes.

On second thought, to keep it simple and consistent with other IIO
drivers, I suggest to keep using iio_get_time_ns() when the sensor
clock is not CLOCK_BOOTTIME, ec_dev->last_event_time when it is.
>
> > > > > > +static const struct of_device_id cros_ec_proximity_of_match[] = {
> > > > > > +     { .compatible = "google,cros-ec-proximity" },
> > > > > > +     {}
> > > > > > +};
> > > > > > +MODULE_DEVICE_TABLE(of, cros_ec_proximity_of_match);
> > > > > > +#endif
> > > > > > +
> > > > > > +static struct platform_driver cros_ec_proximity_driver = {
> > > > > > +     .driver = {
> > > > > > +             .name = "cros-ec-proximity",
> > > > > > +             .of_match_table = of_match_ptr(cros_ec_proximity_of_match),
> > > > Add a ACPI match table to match.
> > >
> > > I don't have an ACPI system in hand. What should the ACPI table look
> > > like? Can ACPI use the of_match_table logic?
> > AFAIK, ACPI uses .acpi_match_table, see
> > drivers/iio/magnetometer/ak8975.c for a simple example.
>
> Ok. I'm leaning towards punting on this. I don't have an ACPI system to
> test and I don't know what the ACPI match table should have in it. If
> you can tell me what to put in the acpi_match_table then I can add it.
