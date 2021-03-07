Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 433CF3303FC
	for <lists+linux-iio@lfdr.de>; Sun,  7 Mar 2021 19:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbhCGSq1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Mar 2021 13:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbhCGSp6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Mar 2021 13:45:58 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654D5C06174A;
        Sun,  7 Mar 2021 10:45:58 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id n132so7654856iod.0;
        Sun, 07 Mar 2021 10:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hki0Hl2tbnajpF3gwCuqdLTb9AKHzRLxw38xL8ZoUXw=;
        b=Sb/khIF9MfxVP6p4cPQczN/OI7N1MNMAuG5XUyqSXrrpri2fNBztyxP76LfdxvLbFY
         VTSFG5DJipyJ7E2KRm5IYmApFqXIHDNZlPHLvsbyUMazms59dUB+x1r6/8q0Lre7bhzp
         bYT2uxiAStzG7yETo2yyxZVDJ1mPAOhI/NGZ1QNsPgBo9nAB6Ahe5+vazJuMZaqC5QBj
         9ltkp8FcVc+Q/qWLiLxUx+qkQqSPlUvVCs1sPGSGpOi4C/iKbdIbfELqUXPTOSib1OGX
         tFIGhlL07pn6XrLcoW9Hh3M/gbYKhxpIljPQBBPHIzph2aCoSyd36+K9D5akPU9XWe8Q
         nqFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hki0Hl2tbnajpF3gwCuqdLTb9AKHzRLxw38xL8ZoUXw=;
        b=blzLPwNoj6gE+CrhrN8PXTOan3UzzVWwvQ6XCQjc54LyPBT6+/CNbtANsaRQJKJGBg
         fz0NZBbPUa01GiQ5UAcgt+foyQlYTJ5ZTE7IIC4vd1vxLE7fLyyHZhqeaMskWH9wI0nD
         13gQVSFZHhE3izSAvc+laJoFgOMJxsKenGFpJwOrJDsHb3G7Ny2Tqo56EBV/pz3PAcih
         +v7ffH8nvEWGQq/WEhcWBNM19C3olR59vEXlYDWc+s9dwwnpDNxVCpbUfyI/Drt5ihN7
         JUK3SMp40mpzNdDE8/SCIPUNA/i5LSiEt3nHgjBTPHLQJcUVkcbSkxFdgofnu7NtnwZE
         6WPw==
X-Gm-Message-State: AOAM532lRYhCP5ssWx3Axw6FrCSvQPrfeDTqLhC6Qt1w/qM5+/cWHXXP
        v+D3JpGWkGLQ8KgQ60FOlqTT8o9hfMRwP0T0OuM=
X-Google-Smtp-Source: ABdhPJwVvVV/1Z3jl/xAzB/0UAqCQ1OUSJzdqdTxTjtQD0CO0ZXsppwaV1aTMv2pihP4s6xd/iy3hHlva27p0JCH0q8=
X-Received: by 2002:a5d:8416:: with SMTP id i22mr15237919ion.32.1615142757584;
 Sun, 07 Mar 2021 10:45:57 -0800 (PST)
MIME-Version: 1.0
References: <20201123144017.18311-1-alexandru.ardelean@analog.com>
 <20210221162905.65be88d0@archlinux> <408e9b87-0528-141a-1fa6-ca8c2a0b1c69@collabora.com>
 <20210307115941.18badb2e@archlinux>
In-Reply-To: <20210307115941.18badb2e@archlinux>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Sun, 7 Mar 2021 20:45:46 +0200
Message-ID: <CA+U=DsoLuj0bVAG92iDxTcg=aLGAnzaSiT-+_n=HkFzedGzS6Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: cros_ec: do an early exit if not physical_device case
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>, groeck@chromium.org,
        Gwendal Grignou <gwendal@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Mar 7, 2021 at 1:59 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Tue, 2 Mar 2021 11:46:06 +0100
> Enric Balletbo i Serra <enric.balletbo@collabora.com> wrote:
>
> > Hi all,
> >
> > On 21/2/21 17:29, Jonathan Cameron wrote:
> > > On Mon, 23 Nov 2020 16:40:16 +0200
> > > Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
> > >
> > >> This whole code-block was put under one big if() condition/block.
> > >> This change does an early return if the 'physical_device' boolean is false,
> > >> thus unindenting the block by one level.
> > >>
> > >> No other functional change has been done.
> > >>
> > >> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > > @Gwendal, others  This series from Alex has been outstanding for a while
> > > but may well still apply.
> > > Ideally looking for an ack.
> > >
> >
> > This looks good to me.
> >
> > Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>
> Hi Enric, Ack or both patches or just this one?
>
> @Alex, series needs a rebase.  I'm not totally sure what's changed.
> If you don't get to it I'll do it at somepoint but unlikely to
> be terribly soon!

It's likely that it's that iio_device_attach_buffer() went away and
the block got replaced by devm_iio_kfifo_buffer_setup().
I'll re-spin it.
I dropped this set from my main work branch because I didn't know if
it was forgotten, and rebasing it with every change on
devm_iio_kfifo_buffer_setup() and
devm_iio_triggered_buffer_setup_ext() became annoying.
But it shouldn't be hard to re-spin.

>
> Jonathan
>
> >
> > Thanks,
> >  Enric
> >
> > > Thanks,
> > >
> > > Jonathan
> > >
> > >> ---
> > >>  .../cros_ec_sensors/cros_ec_sensors_core.c    | 161 +++++++++---------
> > >>  1 file changed, 81 insertions(+), 80 deletions(-)
> > >>
> > >> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > >> index 5c6c4e6fec9b..9470014936f2 100644
> > >> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > >> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > >> @@ -287,89 +287,90 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
> > >>
> > >>    indio_dev->name = pdev->name;
> > >>
> > >> -  if (physical_device) {
> > >> -          state->param.cmd = MOTIONSENSE_CMD_INFO;
> > >> -          state->param.info.sensor_num = sensor_platform->sensor_num;
> > >> -          ret = cros_ec_motion_send_host_cmd(state, 0);
> > >> -          if (ret) {
> > >> -                  dev_warn(dev, "Can not access sensor info\n");
> > >> +  if (!physical_device)
> > >> +          return 0;
> > >> +
> > >> +  state->param.cmd = MOTIONSENSE_CMD_INFO;
> > >> +  state->param.info.sensor_num = sensor_platform->sensor_num;
> > >> +  ret = cros_ec_motion_send_host_cmd(state, 0);
> > >> +  if (ret) {
> > >> +          dev_warn(dev, "Can not access sensor info\n");
> > >> +          return ret;
> > >> +  }
> > >> +  state->type = state->resp->info.type;
> > >> +  state->loc = state->resp->info.location;
> > >> +
> > >> +  /* Set sign vector, only used for backward compatibility. */
> > >> +  memset(state->sign, 1, CROS_EC_SENSOR_MAX_AXIS);
> > >> +
> > >> +  for (i = CROS_EC_SENSOR_X; i < CROS_EC_SENSOR_MAX_AXIS; i++)
> > >> +          state->calib[i].scale = MOTION_SENSE_DEFAULT_SCALE;
> > >> +
> > >> +  /* 0 is a correct value used to stop the device */
> > >> +  if (state->msg->version < 3) {
> > >> +          get_default_min_max_freq(state->resp->info.type,
> > >> +                                   &frequencies[1],
> > >> +                                   &frequencies[2],
> > >> +                                   &state->fifo_max_event_count);
> > >> +  } else {
> > >> +          frequencies[1] = state->resp->info_3.min_frequency;
> > >> +          frequencies[2] = state->resp->info_3.max_frequency;
> > >> +          state->fifo_max_event_count =
> > >> +              state->resp->info_3.fifo_max_event_count;
> > >> +  }
> > >> +  for (i = 0; i < ARRAY_SIZE(frequencies); i++) {
> > >> +          state->frequencies[2 * i] = frequencies[i] / 1000;
> > >> +          state->frequencies[2 * i + 1] =
> > >> +                  (frequencies[i] % 1000) * 1000;
> > >> +  }
> > >> +
> > >> +  if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE_FIFO)) {
> > >> +          /*
> > >> +           * Create a software buffer, feed by the EC FIFO.
> > >> +           * We can not use trigger here, as events are generated
> > >> +           * as soon as sample_frequency is set.
> > >> +           */
> > >> +          struct iio_buffer *buffer;
> > >> +
> > >> +          buffer = devm_iio_kfifo_allocate(dev);
> > >> +          if (!buffer)
> > >> +                  return -ENOMEM;
> > >> +
> > >> +          iio_device_attach_buffer(indio_dev, buffer);
> > >> +          indio_dev->modes = INDIO_BUFFER_SOFTWARE;
> > >> +
> > >> +          ret = cros_ec_sensorhub_register_push_data(
> > >> +                          sensor_hub, sensor_platform->sensor_num,
> > >> +                          indio_dev, push_data);
> > >> +          if (ret)
> > >>                    return ret;
> > >> -          }
> > >> -          state->type = state->resp->info.type;
> > >> -          state->loc = state->resp->info.location;
> > >>
> > >> -          /* Set sign vector, only used for backward compatibility. */
> > >> -          memset(state->sign, 1, CROS_EC_SENSOR_MAX_AXIS);
> > >> +          ret = devm_add_action_or_reset(
> > >> +                          dev, cros_ec_sensors_core_clean, pdev);
> > >> +          if (ret)
> > >> +                  return ret;
> > >>
> > >> -          for (i = CROS_EC_SENSOR_X; i < CROS_EC_SENSOR_MAX_AXIS; i++)
> > >> -                  state->calib[i].scale = MOTION_SENSE_DEFAULT_SCALE;
> > >> -
> > >> -          /* 0 is a correct value used to stop the device */
> > >> -          if (state->msg->version < 3) {
> > >> -                  get_default_min_max_freq(state->resp->info.type,
> > >> -                                           &frequencies[1],
> > >> -                                           &frequencies[2],
> > >> -                                           &state->fifo_max_event_count);
> > >> -          } else {
> > >> -                  frequencies[1] = state->resp->info_3.min_frequency;
> > >> -                  frequencies[2] = state->resp->info_3.max_frequency;
> > >> -                  state->fifo_max_event_count =
> > >> -                      state->resp->info_3.fifo_max_event_count;
> > >> -          }
> > >> -          for (i = 0; i < ARRAY_SIZE(frequencies); i++) {
> > >> -                  state->frequencies[2 * i] = frequencies[i] / 1000;
> > >> -                  state->frequencies[2 * i + 1] =
> > >> -                          (frequencies[i] % 1000) * 1000;
> > >> -          }
> > >> -
> > >> -          if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE_FIFO)) {
> > >> -                  /*
> > >> -                   * Create a software buffer, feed by the EC FIFO.
> > >> -                   * We can not use trigger here, as events are generated
> > >> -                   * as soon as sample_frequency is set.
> > >> -                   */
> > >> -                  struct iio_buffer *buffer;
> > >> -
> > >> -                  buffer = devm_iio_kfifo_allocate(dev);
> > >> -                  if (!buffer)
> > >> -                          return -ENOMEM;
> > >> -
> > >> -                  iio_device_attach_buffer(indio_dev, buffer);
> > >> -                  indio_dev->modes = INDIO_BUFFER_SOFTWARE;
> > >> -
> > >> -                  ret = cros_ec_sensorhub_register_push_data(
> > >> -                                  sensor_hub, sensor_platform->sensor_num,
> > >> -                                  indio_dev, push_data);
> > >> -                  if (ret)
> > >> -                          return ret;
> > >> -
> > >> -                  ret = devm_add_action_or_reset(
> > >> -                                  dev, cros_ec_sensors_core_clean, pdev);
> > >> -                  if (ret)
> > >> -                          return ret;
> > >> -
> > >> -                  /* Timestamp coming from FIFO are in ns since boot. */
> > >> -                  ret = iio_device_set_clock(indio_dev, CLOCK_BOOTTIME);
> > >> -                  if (ret)
> > >> -                          return ret;
> > >> -          } else {
> > >> -                  const struct attribute **fifo_attrs;
> > >> -
> > >> -                  if (has_hw_fifo)
> > >> -                          fifo_attrs = cros_ec_sensor_fifo_attributes;
> > >> -                  else
> > >> -                          fifo_attrs = NULL;
> > >> -
> > >> -                  /*
> > >> -                   * The only way to get samples in buffer is to set a
> > >> -                   * software trigger (systrig, hrtimer).
> > >> -                   */
> > >> -                  ret = devm_iio_triggered_buffer_setup_ext(
> > >> -                                  dev, indio_dev, NULL, trigger_capture,
> > >> -                                  NULL, fifo_attrs);
> > >> -                  if (ret)
> > >> -                          return ret;
> > >> -          }
> > >> +          /* Timestamp coming from FIFO are in ns since boot. */
> > >> +          ret = iio_device_set_clock(indio_dev, CLOCK_BOOTTIME);
> > >> +          if (ret)
> > >> +                  return ret;
> > >> +  } else {
> > >> +          const struct attribute **fifo_attrs;
> > >> +
> > >> +          if (has_hw_fifo)
> > >> +                  fifo_attrs = cros_ec_sensor_fifo_attributes;
> > >> +          else
> > >> +                  fifo_attrs = NULL;
> > >> +
> > >> +          /*
> > >> +           * The only way to get samples in buffer is to set a
> > >> +           * software trigger (systrig, hrtimer).
> > >> +           */
> > >> +          ret = devm_iio_triggered_buffer_setup_ext(
> > >> +                          dev, indio_dev, NULL, trigger_capture,
> > >> +                          NULL, fifo_attrs);
> > >> +          if (ret)
> > >> +                  return ret;
> > >>    }
> > >>
> > >>    return 0;
> > >
>
