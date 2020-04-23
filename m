Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 228AC1B5335
	for <lists+linux-iio@lfdr.de>; Thu, 23 Apr 2020 05:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgDWDmO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Apr 2020 23:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726002AbgDWDmO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Apr 2020 23:42:14 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C22C03C1AA
        for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2020 20:42:13 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id u189so4217529ilc.4
        for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2020 20:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=URty8UnZlh/QZ5WfQtE8lORc2T8l+OWaGW375NBKKJ4=;
        b=JHlBDxzp1FkHMWliEhNyArdV4USpydA6tHjvpT5+7eMq+EfkTDnkPVU6UsDy5/hFm3
         zUc0mxi+f4438yrUk7r2daOLvUr2fP73KNI1E0Glqxv/9GJB0+6Kifo2OVke9XwZtFkJ
         ECR2UpAiknZcey1WfKpJV9k/7CwLFRAnnxzVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=URty8UnZlh/QZ5WfQtE8lORc2T8l+OWaGW375NBKKJ4=;
        b=QZlnXF3E3t7TwZcNvSYcuphwcXJLbdWQYbVDasqqEtScfunup/YaCcm3m2fuIO1GIO
         TvU4g0Pye+7M61StIAWY5jutEWJuAqFk4xJjYhLPcN2hasql5zUpQ3RsZfMIF0BpFaAe
         YtcZUGkU9iWU1c7Jy9TMfN30IqZd3MOqc6fl2fNeaCg1A7GCZ5uh3xAzHUlXWiH/lY+5
         jjl1HJGNjkDg7JkCzRodGBfA5tZp099kYTjo2a2R6p365OenVem4DZsvesz88pIdZuzR
         zZtH8tvgLy6RFRikAH8cXENPIsmUCA2eDlwp0eyHuYfIXmsK01Ri6BDg86GoTsdEr2yv
         eEtA==
X-Gm-Message-State: AGi0PubU9OztDL7uIc2Ti/JvQHwpdRWQRDDn1FRb7tVDZH1LhqIKnJEg
        1XaU9zaIDPmNyfSAxlKj7nQYIcwQVogM0gRpa5c2uzHO1gjIWxA+
X-Google-Smtp-Source: APiQypKn/CYLFODj3JUtq89oJCi8TUghE5inLEBY2qWl89o+bRmzhIyPXwas2fjk7CIU5rKNDqz5OFJM60B2r4eFB3A=
X-Received: by 2002:a92:1b91:: with SMTP id f17mr1540185ill.142.1587613332398;
 Wed, 22 Apr 2020 20:42:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200419232847.32206-1-matt.ranostay@konsulko.com> <20200422182742.00004e9b@huawei.com>
In-Reply-To: <20200422182742.00004e9b@huawei.com>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Wed, 22 Apr 2020 20:42:01 -0700
Message-ID: <CAJCx=gmHeyAsjf8ZkWpSE9=uDHtX7=5jES9sx0=P3kZh=TDHng@mail.gmail.com>
Subject: Re: [PATCH] iio: chemical: atlas-sensor: correct DO-SM channels
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Apr 22, 2020 at 10:27 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Mon, 20 Apr 2020 02:28:47 +0300
> Matt Ranostay <matt.ranostay@konsulko.com> wrote:
>
> > IIO_CONCENTRATION channel for the DO-SM shouldn't be indexed as
> > there isn't more than one, and also ATLAS_CONCENTRATION_CHANNEL
> > macro scan_index define steps on the IIO_TIMESTAMP channel.
> >

Fixes: 1a881ed8a43b  (iio: chemical: atlas-sensor: add RTD-SM module support)

> > Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
>
> Fixes tag?
>
> J
> > ---
> >  drivers/iio/chemical/atlas-sensor.c | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/chemical/atlas-sensor.c
> > b/drivers/iio/chemical/atlas-sensor.c index
> > 82d470561ad3..7b199ce16ecf 100644 ---
> > a/drivers/iio/chemical/atlas-sensor.c +++
> > b/drivers/iio/chemical/atlas-sensor.c @@ -194,7 +194,19 @@ static
> > const struct iio_chan_spec atlas_orp_channels[] = { };
> >
> >  static const struct iio_chan_spec atlas_do_channels[] = {
> > -     ATLAS_CONCENTRATION_CHANNEL(0, ATLAS_REG_DO_DATA),
> > +     {
> > +             .type = IIO_CONCENTRATION,
> > +             .address = ATLAS_REG_DO_DATA,
> > +             .info_mask_separate =
> > +                     BIT(IIO_CHAN_INFO_RAW) |
> > BIT(IIO_CHAN_INFO_SCALE),
> > +             .scan_index = 0,
> > +             .scan_type = {
> > +                     .sign = 'u',
> > +                     .realbits = 32,
> > +                     .storagebits = 32,
> > +                     .endianness = IIO_BE,
> > +             },
> > +     },
> >       IIO_CHAN_SOFT_TIMESTAMP(1),
> >       {
> >               .type = IIO_TEMP,
>
