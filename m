Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB17302F0A
	for <lists+linux-iio@lfdr.de>; Mon, 25 Jan 2021 23:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732301AbhAYW3p (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 Jan 2021 17:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732031AbhAYW3j (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 Jan 2021 17:29:39 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809A0C061756
        for <linux-iio@vger.kernel.org>; Mon, 25 Jan 2021 14:28:59 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id p72so29854877iod.12
        for <linux-iio@vger.kernel.org>; Mon, 25 Jan 2021 14:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3HTXYu55L+PAx0SiIbYzAoCAbt0r7piW94Rvj4CnZEs=;
        b=lhDuB21EK2ZrJGH1AFpt2WhxwsmxqDqj0dgUgbw63DMTeTFGtTRhtcxKjql0Pd1o1m
         D2OyUyFBNwh2V04SjQigJD0BGrrAry+k1yeuQ/rVxmPApCtkYVzgmclTyDLwKDE/bkkD
         W1SalSsWPLqajBDlroCko3EAlIkIJzqwTDrgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3HTXYu55L+PAx0SiIbYzAoCAbt0r7piW94Rvj4CnZEs=;
        b=AsTRZJIyobS0yJmFyuqqjbsCeQprT8tU6+AC1uLWqnQ184PSzoMuwkwi53WSOe3l+Q
         sDlsMZo0iH9S650uwQUcZEtfL2M1pxOGcPIx7uOMuXSE4A6DGmT4H4whC/tcpeotB9xJ
         FSP8X7bd1YRBj4CNfcfjPKSUiuJ/QoTfK7sRKn1AHMaoIYzsWdl02AahgBVd1Q23Xkfq
         ui0PRwrSVVcAP3x4lY3a6xkOF+yauqzV+7CzJHNgzxI/0DM/z3mHx6XCeaySY1CDzp+U
         r58SUoaQX3VztNOQwAlB1K3ATXS1mbl9Q4oV1ZFL5yvbvYEwVQZ9w3Pqyk2unwgBcGhX
         tjyQ==
X-Gm-Message-State: AOAM531p3CqDcg5LiNDZKFymm0/wpTN7mOrbhQ8aR67892v18HyqXHxC
        UeegyeOyuA4QLgM1wCAi3w2EbJOIij8leLmJrN/3TQ==
X-Google-Smtp-Source: ABdhPJxXwB291NNb3prn3mV1kF2sr9XondyMRUQzXqm37hFMZBuz7sJjvziSK50fLymFfaIQYRf1DeHFOihgvNO7SEE=
X-Received: by 2002:a5e:d603:: with SMTP id w3mr2025939iom.65.1611613738699;
 Mon, 25 Jan 2021 14:28:58 -0800 (PST)
MIME-Version: 1.0
References: <20210122225443.186184-1-swboyd@chromium.org> <20210122225443.186184-4-swboyd@chromium.org>
 <20210124173820.4528b9c9@archlinux> <CAPUE2uuQsa7=pjw+D=r0QtLGTd1kQa7X6VBVa73=gx47Vf7KDA@mail.gmail.com>
 <161160076017.76967.4467861058817044169@swboyd.mtv.corp.google.com>
In-Reply-To: <161160076017.76967.4467861058817044169@swboyd.mtv.corp.google.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Mon, 25 Jan 2021 14:28:46 -0800
Message-ID: <CAPUE2uu555NT1=u=1Nb8WExT7RvK8mj5kBiDfGymHiAmoj2WCg@mail.gmail.com>
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

On Mon, Jan 25, 2021 at 10:52 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Gwendal Grignou (2021-01-24 13:41:44)
> > On Sun, Jan 24, 2021 at 9:38 AM Jonathan Cameron <jic23@kernel.org> wrote:
> > >
> > > On Fri, 22 Jan 2021 14:54:43 -0800
> > > Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > > > ---
> > > >  drivers/iio/proximity/Kconfig             |  11 +
> > > >  drivers/iio/proximity/Makefile            |   1 +
> > > >  drivers/iio/proximity/cros_ec_proximity.c | 252 ++++++++++++++++++++++
>
> I suppose I'll change this to cros_ec_mkbp_proximity as well.
>
> > > > diff --git a/drivers/iio/proximity/cros_ec_proximity.c b/drivers/iio/proximity/cros_ec_proximity.c
> > > > new file mode 100644
> > > > index 000000000000..a3aef911e3cc
> > > > --- /dev/null
> > > > +++ b/drivers/iio/proximity/cros_ec_proximity.c
> > > > @@ -0,0 +1,252 @@
> [...]
> > > > +
> > > > +static int cros_ec_proximity_query(struct cros_ec_device *ec_dev, int *state)
> > > > +{
> > > > +     struct ec_params_mkbp_info *params;
> > > > +     struct cros_ec_command *msg;
> > > > +     int ret;
> > > > +
> > > > +     msg = kzalloc(sizeof(*msg) + max(sizeof(u32), sizeof(*params)),
> > > > +                   GFP_KERNEL);
> > >
> > > Given this is known at build time, perhaps better to add it to the
> > > iio_priv() accessed structure and avoid having to handle allocations
> > > separately.
> > As Jonathan said, it can be preallocated in iio private structure. We
> > can also use the stack, given the response size is known beforehand.
> > See cros_ec_cec_set_log_addr() or cros_ec_pwm_get_duty() for example.
>
> I suppose stack is even simpler. I'll try that.
>
> > > > +
> > > > +static int cros_ec_proximity_notify(struct notifier_block *nb,
> > > > +                          unsigned long queued_during_suspend, void *_ec)
> > > > +{
> > > > +     struct cros_ec_proximity_data *data;
> > > > +     struct cros_ec_device *ec = _ec;
> > > > +     u8 event_type = ec->event_data.event_type & EC_MKBP_EVENT_TYPE_MASK;
> > > > +     void *switches = &ec->event_data.data.switches;
> > > > +     struct iio_dev *indio_dev;
> > > > +     s64 timestamp;
> > > > +     int state, dir;
> > > > +     u64 ev;
> > > > +
> > > > +     if (event_type == EC_MKBP_EVENT_SWITCH) {
> > > > +             data = container_of(nb, struct cros_ec_proximity_data, notifier);
> > > > +             indio_dev = data->indio_dev;
> > > > +
> > > > +             mutex_lock(&data->lock);
> > > > +             if (data->enabled) {
> > > > +                     timestamp = iio_get_time_ns(indio_dev);
> > For Android, given the timestamp must be time it happens, not reported
> > [https://source.android.com/devices/sensors/sensors-hal2] """The
> > timestamp must be accurate and correspond to the time at which the
> > event physically happened, not the time it was reported.""", consider
> > using ec_dev->last_event_time and apply a delta if the iio clock base
> > is different from CLOCK_BOOTTIME.
>
> Ah alright. Is there a reason why cros_ec_get_time_ns() is using
> boottime instead of plain ktime_get(), i.e. CLOCK_MONOTONIC? Otherwise I
> suppose some sort of cros_ec API should be exposed to convert the
> last_event_time to whatever clock base is desired. Does that exist?
CLOCK_BOOTTIME was chosen to be Android compliant, as it includes
suspend time and match elapsedRealtime() [see
https://developer.android.com/reference/android/os/SystemClock#elapsedRealtime()]
Chromebook set iio clock reference for all sensor to CLOCK_BOOTTIME
(see https://chromium.googlesource.com/chromiumos/platform2/+/HEAD/mems_setup/configuration.cc#127).
In case the iio device clock_id is not CLOCK_BOOTTIME/"bootime", we
need to add a delta, like in cros_ec_sensors_push_data()
[https://elixir.bootlin.com/linux/latest/source/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c#L210]
>
> > > > +static int cros_ec_proximity_probe(struct platform_device *pdev)
> > > > +{
> > > > +     struct device *dev = &pdev->dev;
> > > > +     struct cros_ec_device *ec = dev_get_drvdata(dev->parent);
> > > > +     struct iio_dev *indio_dev;
> > > > +     struct cros_ec_proximity_data *data;
> > > > +     int ret;
> > > > +
> > > > +     indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> > > > +     if (!indio_dev)
> > > > +             return -ENOMEM;
> > > > +
> > > > +     data = iio_priv(indio_dev);
> > > > +     data->ec = ec;
> > > > +     data->indio_dev = indio_dev;
> > > > +     mutex_init(&data->lock);
> > > > +     platform_set_drvdata(pdev, data);
> > > > +
> > > > +     indio_dev->name = "cros_ec_proximity";
> > Define a constant CROS_EC_[MKBP_]PROXIMITY_DRIVER_NAME and use it here
> > and in struct platform_driver cros_ec_proximity_driver.
>
> I used dev->driver->name instead. Yay for no define!
>
> > > > +     indio_dev->dev.parent = dev;
> > Not needed, done by iio_device_alloc(), called by devm_iio_device_alloc().
>
> Ok.
>
> > > > +static const struct of_device_id cros_ec_proximity_of_match[] = {
> > > > +     { .compatible = "google,cros-ec-proximity" },
> > > > +     {}
> > > > +};
> > > > +MODULE_DEVICE_TABLE(of, cros_ec_proximity_of_match);
> > > > +#endif
> > > > +
> > > > +static struct platform_driver cros_ec_proximity_driver = {
> > > > +     .driver = {
> > > > +             .name = "cros-ec-proximity",
> > > > +             .of_match_table = of_match_ptr(cros_ec_proximity_of_match),
> > Add a ACPI match table to match.
>
> I don't have an ACPI system in hand. What should the ACPI table look
> like? Can ACPI use the of_match_table logic?
AFAIK, ACPI uses .acpi_match_table, see
drivers/iio/magnetometer/ak8975.c for a simple example.


>
> > > > +     },
> > > > +     .probe = cros_ec_proximity_probe,
> > > > +     .remove = cros_ec_proximity_remove,
> > > > +};
