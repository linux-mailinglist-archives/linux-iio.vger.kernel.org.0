Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A42C20F857
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jun 2020 17:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389508AbgF3PcM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 30 Jun 2020 11:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389464AbgF3PcL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 30 Jun 2020 11:32:11 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10CBC061755
        for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2020 08:32:11 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id a6so1365499ilq.13
        for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2020 08:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1iRmGH+QSpYLBEiOWtvHyGiTeID/RhHp9YoH4hC9UDU=;
        b=S3cmwzg9hSmxQeE48kLhKoKgXAoDh04aGqUI2iYFcauCEY2/FsvOS9US2ZCjQplshj
         ZzB83G88aaswCM97XWvewezIiOu8Wx8P3V56FtYHj4G/MI/Gl4YdL3jVvqII2346IyT5
         gZHos495hFWC+nK8mCl1RO0E/tE90JtAgw3Ew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1iRmGH+QSpYLBEiOWtvHyGiTeID/RhHp9YoH4hC9UDU=;
        b=Dw5ewe4wbRnnf6X9qphXHg7YSXIvNcYtNRSujTzq0KQpmnX93BBXuRsFurNF9LLQLP
         LL36l31OrYWjaeRQ9Mu8LijyKgVseuojW5d2ZLS38pBmbHVuqVG37p+xDNBRqu3POIDo
         YcAYdThzM9x3zhSWc9Ljk8EczXmOsG2F4jNcHf3/f2nEdA0OZM5TPklXXJWKimM5Jfaf
         bjzkB2XDtthCP9CrK2kxAD5O6QLRm2Uq7tOw9A08o1FygJuKd7EXzqXKh8DDQ4O1WCPl
         B8U7S67WxCGhrUpwJO/jEj/3F4ceD5wc5zZDhsoP22YXbdHo7pvGq4pdb93GHXEHNp6H
         l6dA==
X-Gm-Message-State: AOAM530+GoohmzBfQVoz2p2DUBmtQv/S0jh/BBJHt7z2d6tk84V75iX2
        UINqAr0/KnMsKWUw32PONFjQMjOxdZeLqYN3dmD45g==
X-Google-Smtp-Source: ABdhPJwwnVzFCPBGsxnAb6kqWB3B8N2q7ZBjOyhMITyjyUXa/YLHoLBBG9kBLgwiOqd7nc0sqZ9ebCgZR2phusQW+JE=
X-Received: by 2002:a92:c7ab:: with SMTP id f11mr3242735ilk.50.1593531130936;
 Tue, 30 Jun 2020 08:32:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200630075933.3056990-1-gwendal@chromium.org> <6ef3d7ea-31f3-09fb-f0c0-61e9999e5761@collabora.com>
In-Reply-To: <6ef3d7ea-31f3-09fb-f0c0-61e9999e5761@collabora.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Tue, 30 Jun 2020 08:31:57 -0700
Message-ID: <CAPUE2utjuPH3pkW3jTD272-BMZXN+rw+x+3ZvJ343zfEmUqc+w@mail.gmail.com>
Subject: Re: [PATCH] iio: cros_ec: Use default frequencies when EC returns
 invalid information
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jun 30, 2020 at 8:12 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Gwendal,
>
> Thank you for the patch.
>
> On 30/6/20 9:59, Gwendal Grignou wrote:
> > Minimal and maximal frequencies supported by a sensor is queried.
> > On some older machines, these frequencies are not returned properly and
> > the EC returns 0 instead.
> > When returned maximal frequency is 0, ignore the information and use
> > default frequencies instead.
> >
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> > ---
> >  .../common/cros_ec_sensors/cros_ec_sensors_core.c | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > index 36e3f20891f05..8437ff659260b 100644
> > --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > @@ -289,7 +289,7 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
> >       struct cros_ec_sensorhub *sensor_hub = dev_get_drvdata(dev->parent);
> >       struct cros_ec_dev *ec = sensor_hub->ec;
> >       struct cros_ec_sensor_platform *sensor_platform = dev_get_platdata(dev);
> > -     u32 ver_mask;
> > +     u32 ver_mask, temp;
> >       int frequencies[ARRAY_SIZE(state->frequencies) / 2] = { 0 };
> >       int ret, i;
> >
> > @@ -345,8 +345,17 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
> >                                                &frequencies[2],
> >                                                &state->fifo_max_event_count);
> >               } else {
> > -                     frequencies[1] = state->resp->info_3.min_frequency;
> > -                     frequencies[2] = state->resp->info_3.max_frequency;
> > +                     if (state->resp->info_3.max_frequency == 0) {
>
> I might miss some use cases but I am wondering if this can be OR'ed with the
> above if, so there is only one call to get_default_min_max_freq
>
> > +                             get_default_min_max_freq(state->resp->info.type,
> > +                                                      &frequencies[1],
> > +                                                      &frequencies[2],
> > +                                                      &temp);
>
> and use &state->fifo_max_event_count instead of temp, so you don't need to
> create a new variable that is not used anymore. Or is in purpose?
It is on purpose: on some machines, min_frequency and max_frequency
are both 0, but fifo_max_event_count is correct and should be used.
>
> > +                     } else {
> > +                             frequencies[1] =
> > +                                     state->resp->info_3.min_frequency;
>
> nit: I think that you can take advantage of the new 100 character line length
> limit, here.
Fixed in the next patch.
>
> > +                             frequencies[2] =
> > +                                     state->resp->info_3.max_frequency;
>
> nit: ditto
>
> > +                     }
> >                       state->fifo_max_event_count =
> >                           state->resp->info_3.fifo_max_event_count;
> >               }
> >
