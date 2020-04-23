Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D49D1B5336
	for <lists+linux-iio@lfdr.de>; Thu, 23 Apr 2020 05:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgDWDn2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Apr 2020 23:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726002AbgDWDn1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Apr 2020 23:43:27 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58890C03C1AA
        for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2020 20:43:27 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id p10so4888796ioh.7
        for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2020 20:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FVtIjnpSf5LbpdK1udZaGf8l6jxgW8vEApCuaJr7DLA=;
        b=RB5Mu5CGL8wOd/nwjvsvrx4OJUpV0ViQYOOz/JyrWwKukpAv7HP418yqQ15tTSlyfH
         M7JH37dal0UVxRtepLDldHoaCwltw81Kv/Vaa+5lMqKQhfOr+U+Oe665YhX3rnUSr1dn
         kP9UkiJoDXBwzVPz24hM22HOEzD6e+q2rooEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FVtIjnpSf5LbpdK1udZaGf8l6jxgW8vEApCuaJr7DLA=;
        b=DJDrSYo4Ax1oMuDpZnx9i+/dP0JUARs0689EanuDzccbYjBHRVK1INWodORQfTTyb7
         eqymkJNqgwPVMITbGcuJoCorMzhy2EmJiq5+tHnyfns22uuur3l3ShpAIVTqVQpMzm5g
         oZXbfC2tOJOuTDc+x4F3a2Ik2HgI7wqAQHfBggT4SXfOXaD0V9BkfCM2qErNogSIDiBB
         kPuD7rfP1Sy44oB4OaVIZpLCuNC5RmU8Y/bzPnQjHM7HebpFXK+abO7fqpTMRIkB9vB0
         nGkiq12088YF42A9doHeJ5W2L4wZFN50Fxy+DVUHRjyOcBqjOmScSFZkIl+yotvsgeHx
         8lEQ==
X-Gm-Message-State: AGi0PubgemSSmdXbOo6b0So7HxPT6Qiz2Kak+GEmPBvglTHvr2ifMKQu
        CHmlUSp93nQY8E+3+FoGKmD8v0s8ASN4PTSV+JcV5eZu4SwSm/6p
X-Google-Smtp-Source: APiQypJ0DTeUzRERj3zfr6NoWysEzVAvR+zpq57mc+hAFunyn+olEAvyD8cSwXkdZXfznGIoL8JHmoXGDLLYAE7sb20=
X-Received: by 2002:a6b:3e0a:: with SMTP id l10mr1866090ioa.112.1587613406759;
 Wed, 22 Apr 2020 20:43:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200419232847.32206-1-matt.ranostay@konsulko.com>
 <20200422182742.00004e9b@huawei.com> <CAJCx=gmHeyAsjf8ZkWpSE9=uDHtX7=5jES9sx0=P3kZh=TDHng@mail.gmail.com>
In-Reply-To: <CAJCx=gmHeyAsjf8ZkWpSE9=uDHtX7=5jES9sx0=P3kZh=TDHng@mail.gmail.com>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Wed, 22 Apr 2020 20:43:15 -0700
Message-ID: <CAJCx=gnjj6pp9=aEKohdmxrsm+aRgSO9wus3p8oLd01JQGoOUw@mail.gmail.com>
Subject: Re: [PATCH] iio: chemical: atlas-sensor: correct DO-SM channels
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Apr 22, 2020 at 8:42 PM Matt Ranostay
<matt.ranostay@konsulko.com> wrote:
>
> On Wed, Apr 22, 2020 at 10:27 AM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Mon, 20 Apr 2020 02:28:47 +0300
> > Matt Ranostay <matt.ranostay@konsulko.com> wrote:
> >
> > > IIO_CONCENTRATION channel for the DO-SM shouldn't be indexed as
> > > there isn't more than one, and also ATLAS_CONCENTRATION_CHANNEL
> > > macro scan_index define steps on the IIO_TIMESTAMP channel.
> > >
>
> Fixes: 1a881ed8a43b  (iio: chemical: atlas-sensor: add RTD-SM module support)

Oops wrong change for Fixes tag. Sorry about that..

Fixes: a751b8e48018 (iio: chemical: atlas-sensor: add DO-SM module support)

>
> > > Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
> >
> > Fixes tag?
> >
> > J
> > > ---
> > >  drivers/iio/chemical/atlas-sensor.c | 14 +++++++++++++-
> > >  1 file changed, 13 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/iio/chemical/atlas-sensor.c
> > > b/drivers/iio/chemical/atlas-sensor.c index
> > > 82d470561ad3..7b199ce16ecf 100644 ---
> > > a/drivers/iio/chemical/atlas-sensor.c +++
> > > b/drivers/iio/chemical/atlas-sensor.c @@ -194,7 +194,19 @@ static
> > > const struct iio_chan_spec atlas_orp_channels[] = { };
> > >
> > >  static const struct iio_chan_spec atlas_do_channels[] = {
> > > -     ATLAS_CONCENTRATION_CHANNEL(0, ATLAS_REG_DO_DATA),
> > > +     {
> > > +             .type = IIO_CONCENTRATION,
> > > +             .address = ATLAS_REG_DO_DATA,
> > > +             .info_mask_separate =
> > > +                     BIT(IIO_CHAN_INFO_RAW) |
> > > BIT(IIO_CHAN_INFO_SCALE),
> > > +             .scan_index = 0,
> > > +             .scan_type = {
> > > +                     .sign = 'u',
> > > +                     .realbits = 32,
> > > +                     .storagebits = 32,
> > > +                     .endianness = IIO_BE,
> > > +             },
> > > +     },
> > >       IIO_CHAN_SOFT_TIMESTAMP(1),
> > >       {
> > >               .type = IIO_TEMP,
> >
